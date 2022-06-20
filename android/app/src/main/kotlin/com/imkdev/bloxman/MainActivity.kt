package com.imkdev.bloxman

import io.flutter.embedding.android.FlutterActivity
import android.content.ContentValues
import android.content.Intent
import android.database.Cursor
import android.net.Uri
import android.os.Bundle
import android.provider.BlockedNumberContract
import android.telecom.TelecomManager
import android.util.Log
import androidx.annotation.NonNull
import com.imkdev.bloxman.model.ContactModel
import com.google.gson.Gson
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

class MainActivity: FlutterActivity() {
    private fun checkSetAsDefaultDialer() : Boolean {
        if (getSystemService(TelecomManager::class.java).defaultDialerPackage != packageName) {
            Intent(TelecomManager.ACTION_CHANGE_DEFAULT_DIALER)
                .putExtra(TelecomManager.EXTRA_CHANGE_DEFAULT_DIALER_PACKAGE_NAME, packageName)
                .let(::startActivity)
        }
        return getSystemService(TelecomManager::class.java).defaultDialerPackage == packageName
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,
            "com.imk.dev/blox").setMethodCallHandler { call, result ->

            val phone = call.argument<String>("contact")
            when(call.method){
                "addToBlock" -> {
                    if (phone != null){
                        addToBlock(phone, result)
                    }
                }
                "removeFromBlock" -> {
                    if (phone != null) {
                        removeFromBlock(phone, result)
                    }
                }
                "checkSetAsDefaultDialer" -> {
                    result.success(checkSetAsDefaultDialer())
                }
                "retrieveBlockedContacts" -> {
                    retrieveBlockedContacts(result)
                }
            }
        }
    }

    private fun addToBlock(phone: String, result: MethodChannel.Result){
        try {
            val values = ContentValues()
            values.put(BlockedNumberContract.BlockedNumbers.COLUMN_ORIGINAL_NUMBER, phone)
            val uri: Uri? = contentResolver.insert(BlockedNumberContract.BlockedNumbers.CONTENT_URI, values)
            if (uri != null){
                result.success("Successfully added to the block list")
            } else {
                result.success("Try Again!")
            }
        } catch (ex: Exception){
            ex.printStackTrace()
            result.success(ex.localizedMessage)
        }
    }

    private fun removeFromBlock(phone: String, result: MethodChannel.Result){
        val values = ContentValues()
        values.put(BlockedNumberContract.BlockedNumbers.COLUMN_ORIGINAL_NUMBER, phone)
        val uri = contentResolver.insert(BlockedNumberContract.BlockedNumbers.CONTENT_URI, values)
        val i = contentResolver.delete(uri!!, null, null)
        result.success(if (i == 1) "Successfully contact unblocked!" else "Failed to unblock contact, try again!")
    }

    private fun retrieveBlockedContacts(result: MethodChannel.Result){
        val contacts = ArrayList<ContactModel>()

        if (checkSetAsDefaultDialer()){
            val cursor: Cursor? = contentResolver.query(
                BlockedNumberContract.BlockedNumbers.CONTENT_URI, arrayOf(
                    BlockedNumberContract.BlockedNumbers.COLUMN_ID,
                    BlockedNumberContract.BlockedNumbers.COLUMN_ORIGINAL_NUMBER,
                    BlockedNumberContract.BlockedNumbers.COLUMN_E164_NUMBER
                ), null, null, null
            )

            if (cursor != null) {
                while (cursor.moveToNext()) {
                    val id = cursor.getInt(
                        cursor.getColumnIndexOrThrow(BlockedNumberContract.BlockedNumbers.COLUMN_ID))
                    val phone = cursor.getString(
                        cursor.getColumnIndexOrThrow(BlockedNumberContract.BlockedNumbers.COLUMN_ORIGINAL_NUMBER))
                    contacts.add(ContactModel(id, phone))
                }
                cursor.close()
                val json = Gson().toJson(contacts)
                result.success(json)
            }
        }
    }
}
