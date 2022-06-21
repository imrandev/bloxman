package com.imkdev.bloxman.service

import android.content.ContentValues
import android.content.Context
import android.database.Cursor
import android.net.Uri
import android.provider.BlockedNumberContract
import android.util.Log
import com.google.gson.Gson
import com.imkdev.bloxman.model.ContactModel
import com.imkdev.bloxman.utils.Message
import java.lang.Exception

class ContactBlockService : BlockService<ContactModel> {

    companion object {
        private const val TAG = "ContactBlockService"
    }

    override fun insert(context: Context, phone: String?): Uri? {
        return try {
            val values = ContentValues()
            values.put(BlockedNumberContract.BlockedNumbers.COLUMN_ORIGINAL_NUMBER, phone)
            context.contentResolver.insert(
                BlockedNumberContract.BlockedNumbers.CONTENT_URI,
                values
            )
        } catch (ex: Exception) {
            Log.e(TAG, "insert: ${ex.localizedMessage}")
            null
        }
    }

    override fun insert(context: Context, phone: String?, callback: (message: String) -> Unit) {
        if (insert(context, phone) != null){
            callback(Message.successfullyBlocked)
        } else {
            callback(Message.tryAgainBlock)
        }
    }

    override fun delete(context: Context, phone: String?): Boolean {
        val values = ContentValues()
        values.put(BlockedNumberContract.BlockedNumbers.COLUMN_ORIGINAL_NUMBER, phone)
        val uri = context.contentResolver.insert(BlockedNumberContract.BlockedNumbers.CONTENT_URI, values)
        val i = context.contentResolver.delete(uri!!, null, null)
        return i == 1
    }

    override fun delete(context: Context, phone: String?, callback: (message: String) -> Unit) {
        callback(if (delete(context, phone))
            Message.successfullyUnblock else Message.tryAgainUnblock)
    }

    override fun findAll(context: Context): List<ContactModel> {
        val contacts = ArrayList<ContactModel>()
        val cursor: Cursor? = context.contentResolver.query(
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
        }
        return contacts
    }

    override fun findAll(context: Context, callback: (json: String) -> Unit) {
        val contacts = findAll(context)
        if (contacts.isNotEmpty()){
            val json = Gson().toJson(contacts)
            callback(json)
        } else {
            Log.e(TAG, "findAll: Block list empty")
        }
    }
}