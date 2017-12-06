Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:45697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbdLFLh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Dec 2017 06:37:57 -0500
Date: Wed, 6 Dec 2017 03:35:44 -0800
From: "tip-bot for Rafael J. Wysocki" <tipbot@zytor.com>
Message-ID: <tip-ddec3bdee05b06f1dda20ded003c3e10e4184cab@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
        mingo@kernel.org, hpa@zytor.com, bhelgaas@google.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, bhelgaas@google.com, hpa@zytor.com,
          mingo@kernel.org, rafael.j.wysocki@intel.com,
          linux-pci@vger.kernel.org, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <3186627.pxZj1QbYNg@aspire.rjw.lan>
References: <3186627.pxZj1QbYNg@aspire.rjw.lan>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/PCI: Make broadcom_postcore_init() check
 acpi_disabled
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit-ID:  ddec3bdee05b06f1dda20ded003c3e10e4184cab
Gitweb:     https://git.kernel.org/tip/ddec3bdee05b06f1dda20ded003c3e10e4184cab
Author:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate: Fri, 1 Dec 2017 15:08:12 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 6 Dec 2017 12:27:47 +0100

x86/PCI: Make broadcom_postcore_init() check acpi_disabled

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
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/3186627.pxZj1QbYNg@aspire.rjw.lan
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/pci/broadcom_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/broadcom_bus.c b/arch/x86/pci/broadcom_bus.c
index bb461cf..526536c 100644
--- a/arch/x86/pci/broadcom_bus.c
+++ b/arch/x86/pci/broadcom_bus.c
@@ -97,7 +97,7 @@ static int __init broadcom_postcore_init(void)
 	 * We should get host bridge information from ACPI unless the BIOS
 	 * doesn't support it.
 	 */
-	if (acpi_os_get_root_pointer())
+	if (!acpi_disabled && acpi_os_get_root_pointer())
 		return 0;
 #endif
 
