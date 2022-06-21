package com.imkdev.bloxman.utils

object Method {
    const val addContactIntoBlockList = "blockService_insert"
    const val deleteContactFromBlockList = "blockService_delete"
    const val fetchBlockList = "blockService_findAll"
    const val checkDefaultPermission = "checkSetAsDefaultDialer"
}

object Constant {
    const val methodChannel = "com.imk.dev/blox"
}

object Argument {
    const val contactKey = "contact"
}

object Message {
    const val defaultPermissionDenied = "Need permission to add contact into block list"
    const val successfullyBlocked = "Successfully blocked!"
    const val successfullyUnblock = "Successfully unblocked!"
    const val tryAgainBlock = "Unable to block, try again!"
    const val tryAgainUnblock = "Failed to unblock, try again!"
}

object Permission {
    const val REQUEST_CODE_DEFAULT_DIALER = 1001
}