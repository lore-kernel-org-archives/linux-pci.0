Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35346 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935089AbeB1QUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 11:20:25 -0500
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Linux PCI" <linux-pci@vger.kernel.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.329460370@decadent.org.uk>
Subject: [PATCH 3.16 059/254] x86/PCI: Make broadcom_postcore_init() check
 acpi_disabled
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/pci/broadcom_bus.c | 2 +-
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
 
