Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752340AbdLKV5B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Dec 2017 16:57:01 -0500
Subject: Patch "x86/PCI: Make broadcom_postcore_init() check acpi_disabled" has been added to the 4.14-stable tree
To: rafael.j.wysocki@intel.com, bhelgaas@google.com,
        dave.hansen@linux.intel.com, gregkh@linuxfoundation.org,
        linux-pci@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Dec 2017 22:54:17 +0100
Message-ID: <151302925723099@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    x86/PCI: Make broadcom_postcore_init() check acpi_disabled

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     x86-pci-make-broadcom_postcore_init-check-acpi_disabled.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From ddec3bdee05b06f1dda20ded003c3e10e4184cab Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Fri, 1 Dec 2017 15:08:12 +0100
Subject: x86/PCI: Make broadcom_postcore_init() check acpi_disabled

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit ddec3bdee05b06f1dda20ded003c3e10e4184cab upstream.

acpi_os_get_root_pointer() may return a valid address even if acpi_disabled
is set, but the host bridge information from the ACPI tables is not going
to be used in that case and the Broadcom host bridge initialization should
not be skipped then, So make broadcom_postcore_init() check acpi_disabled
too to avoid this issue.

Fixes: 6361d72b04d1 (x86/PCI: read Broadcom CNB20LE host bridge info before PCI scan)
Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>
Link: https://lkml.kernel.org/r/3186627.pxZj1QbYNg@aspire.rjw.lan
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/pci/broadcom_bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/pci/broadcom_bus.c
+++ b/arch/x86/pci/broadcom_bus.c
@@ -97,7 +97,7 @@ static int __init broadcom_postcore_init
 	 * We should get host bridge information from ACPI unless the BIOS
 	 * doesn't support it.
 	 */
-	if (acpi_os_get_root_pointer())
+	if (!acpi_disabled && acpi_os_get_root_pointer())
 		return 0;
 #endif
 


Patches currently in stable-queue which might be from rafael.j.wysocki@intel.com are

queue-4.14/x86-pci-make-broadcom_postcore_init-check-acpi_disabled.patch
