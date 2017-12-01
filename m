Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42006 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752553AbdLAOB5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Dec 2017 09:01:57 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86 / PCI: Make broadcom_postcore_init() check acpi_disabled
Date: Fri, 01 Dec 2017 15:01:25 +0100
Message-ID: <1593230.4rVA5fLXq5@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

acpi_os_get_root_pointer() may return a valid address even if
acpi_disabled is set, but the host bridge information from the ACPI
tables is not going to be used in that case and the Broadcom host
bridge initialization should not be skipped then, so make
broadcom_postcore_init() check acpi_disabled too to avoid this issue.

Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 6361d72b04d1 (x86/PCI: read Broadcom CNB20LE host bridge info before PCI scan)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/pci/broadcom_bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/arch/x86/pci/broadcom_bus.c
===================================================================
--- linux-pm.orig/arch/x86/pci/broadcom_bus.c
+++ linux-pm/arch/x86/pci/broadcom_bus.c
@@ -97,7 +97,7 @@ static int __init broadcom_postcore_init
 	 * We should get host bridge information from ACPI unless the BIOS
 	 * doesn't support it.
 	 */
-	if (acpi_os_get_root_pointer())
+	if (!acpi_disabled && acpi_os_get_root_pointer())
 		return 0;
 #endif
 
