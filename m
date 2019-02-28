Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6612C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 20:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C32220850
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 20:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbfB1Uwj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:52:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:16411 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388186AbfB1UwV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Feb 2019 15:52:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 12:52:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,424,1544515200"; 
   d="scan'208";a="130192192"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2019 12:52:19 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
        robert.moore@intel.com, erik.schmauss@intel.com, ruscur@russell.cc
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        keith.busch@intel.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1 2/3] ACPI: Add Error Disconnect Recover (EDR) ACPI notifier support
Date:   Thu, 28 Feb 2019 12:49:48 -0800
Message-Id: <5229ccc3bbb1792ba625b7c54f5ad6f101826454.1551382061.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551382061.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1551382061.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per ACPI spec r6.3, sec 6.3.5, Error Disconnect Recover
notification can be used to notify OSPM of asynchronous removal
of devices for error containment purposes. OSPM can use this
notification to invalidate software states of disconnected child
devices in the bus and also optionally can attempt recover the child
devices.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/acpica/utdecode.c | 3 ++-
 drivers/acpi/bus.c             | 5 ++++-
 include/acpi/actypes.h         | 3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index dad02b821e19..40d36c6661f1 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -431,7 +431,8 @@ static const char *acpi_gbl_generic_notify[ACPI_GENERIC_NOTIFY_MAX + 1] = {
 								/* Reserved in ACPI 6.0 */
 	/* 0D */ "System Resource Affinity Update",
 								/* 0E */ "Heterogeneous Memory Attributes Update"
-								/* ACPI 6.2 */
+	/* 0F */ "Error Disconnect Recover",
+	/* ACPI 6.3 */
 };
 
 static const char *acpi_gbl_device_notify[5] = {
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 147f6c7ea59c..aacf82162604 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -397,7 +397,10 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	case ACPI_NOTIFY_POWER_FAULT:
 		acpi_handle_err(handle, "Device has suffered a power fault\n");
 		break;
-
+	case ACPI_NOTIFY_ERROR_DISCONNECT:
+		acpi_handle_debug(handle,
+				  "ACPI_NOTIFY_ERROR_DISCONNECT event\n");
+		break;
 	default:
 		acpi_handle_debug(handle, "Unknown event type 0x%x\n", type);
 		break;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 2590627dbfcc..40ad91b06f02 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -617,8 +617,9 @@ typedef u64 acpi_integer;
 #define ACPI_NOTIFY_SHUTDOWN_REQUEST    (u8) 0x0C
 #define ACPI_NOTIFY_AFFINITY_UPDATE     (u8) 0x0D
 #define ACPI_NOTIFY_MEMORY_UPDATE       (u8) 0x0E
+#define ACPI_NOTIFY_ERROR_DISCONNECT    (u8) 0x0F
 
-#define ACPI_GENERIC_NOTIFY_MAX         0x0E
+#define ACPI_GENERIC_NOTIFY_MAX         0x0F
 #define ACPI_SPECIFIC_NOTIFY_MAX        0x84
 
 /*
-- 
2.20.1

