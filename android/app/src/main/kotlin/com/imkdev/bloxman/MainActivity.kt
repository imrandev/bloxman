package com.imkdev.bloxman

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.telecom.TelecomManager
import android.util.Log
import androidx.annotation.NonNull
import com.imkdev.bloxman.model.ContactModel
import com.imkdev.bloxman.service.BlockService
import com.imkdev.bloxman.service.ContactBlockService
import com.imkdev.bloxman.utils.Argument
import com.imkdev.bloxman.utils.Constant
import com.imkdev.bloxman.utils.Message
import com.imkdev.bloxman.utils.Method
import com.imkdev.bloxman.utils.Permission.REQUEST_CODE_DEFAULT_DIALER
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    companion object {
        private const val TAG = "MainActivity"
    }

    lateinit var blockService: BlockService<ContactModel>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        blockService = ContactBlockService()

        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.O){
            requestPermission()
        } else {
            checkSetAsDefaultDialer()
        }
    }

    private fun checkSetAsDefaultDialer() : Boolean {

        if (getSystemService(TelecomManager::class.java).defaultDialerPackage != packageName) {
            Intent(TelecomManager.ACTION_CHANGE_DEFAULT_DIALER)
                .putExtra(TelecomManager.EXTRA_CHANGE_DEFAULT_DIALER_PACKAGE_NAME, packageName)
                .let(::startActivity)
        }
        return getSystemService(TelecomManager::class.java).defaultDialerPackage == packageName
    }

    private fun requestPermission(){
        startActivityForResult(Intent(TelecomManager.ACTION_CHANGE_DEFAULT_DIALER).apply {
            putExtra(
                TelecomManager.EXTRA_CHANGE_DEFAULT_DIALER_PACKAGE_NAME,
                packageName
            )
        }, REQUEST_CODE_DEFAULT_DIALER)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE_DEFAULT_DIALER) {
            Log.d(TAG, "Request Code: $requestCode")
            when (resultCode) {
                RESULT_OK -> Log.d(TAG, "User granted default dialer permission")
                RESULT_CANCELED -> Log.d(TAG, "User denied default dialer permission")
                else -> Log.d(TAG, "Result code: $resultCode")
            }
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,
            Constant.methodChannel).setMethodCallHandler { call, result ->
            val phone = call.argument<String>(Argument.contactKey)
            when(call.method){
                Method.addContactIntoBlockList -> {
                    if (checkSetAsDefaultDialer()){
                        blockService.insert(context, phone) {
                            result.success(it)
                        }
                    } else {
                        result.success(Message.defaultPermissionDenied)
                    }
                }
                Method.deleteContactFromBlockList -> {
                    blockService.delete(context, phone) {
                        result.success(it)
                    }
                }
                Method.checkDefaultPermission -> {
                    if (!checkSetAsDefaultDialer()) {
                        result.success(Message.defaultPermissionDenied)
                    }
                }
                Method.fetchBlockList -> {
                    blockService.findAll(context) {
                        result.success(it)
                    }
                }
            }
        }
    }
}
