Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 4 Dec 2017 14:24:44 -0800
From: "tip-bot for Rafael J. Wysocki" <tipbot@zytor.com>
Message-ID: <tip-2ee90363a838cf41ebf1ad24bad274762e467d8d@git.kernel.org>
Cc: rafael.j.wysocki@intel.com, tglx@linutronix.de,
        bhelgaas@google.com, hpa@zytor.com, mingo@kernel.org,
        linux-pci@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org
Reply-To: dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
          linux-pci@vger.kernel.org, bhelgaas@google.com, hpa@zytor.com,
          mingo@kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de
In-Reply-To: <3186627.pxZj1QbYNg@aspire.rjw.lan>
References: <3186627.pxZj1QbYNg@aspire.rjw.lan>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86 / PCI: Make broadcom_postcore_init() check
 acpi_disabled
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit-ID:  2ee90363a838cf41ebf1ad24bad274762e467d8d
Gitweb:     https://git.kernel.org/tip/2ee90363a838cf41ebf1ad24bad274762e467d8d
Author:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate: Fri, 1 Dec 2017 15:08:12 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 4 Dec 2017 23:20:35 +0100

x86 / PCI: Make broadcom_postcore_init() check acpi_disabled

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
 
