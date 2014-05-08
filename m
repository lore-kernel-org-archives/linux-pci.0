Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:22825
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753156AbaEHQoh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 May 2014 12:44:37 -0400
From: <suravee.suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
	Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>,
	Borislav Petkov <bp@suse.de>,
	"Robert Richter" <rric@kernel.org>,
	Daniel J Blueman <daniel@numascale.com>,
	Andreas Herrmann <herrmann.der.user@googlemail.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH V4 1/4] x86/PCI: Fix PCI root numa_node info on AMD family15h
Date: Thu, 8 May 2014 11:44:18 -0500
Message-ID: <1399567461-15928-2-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1399567461-15928-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1399567461-15928-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch fixes the numa_node information in sysfs for PCI root
on AMD family15h platforms (currently showing -1) by adding
the hostbridge in the list of probed devices to be used for initializing
pci_root_info structue.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
Tested-by: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Robert Richter <rric@kernel.org>
Cc: Daniel J Blueman <daniel@numascale.com>
Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
---
 arch/x86/pci/amd_bus.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index e88f4c5..330dbfe 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -24,10 +24,11 @@ struct pci_hostbridge_probe {
 };
 
 static struct pci_hostbridge_probe pci_probes[] __initdata = {
-	{ 0, 0x18, PCI_VENDOR_ID_AMD, 0x1100 },
-	{ 0, 0x18, PCI_VENDOR_ID_AMD, 0x1200 },
-	{ 0xff, 0, PCI_VENDOR_ID_AMD, 0x1200 },
-	{ 0, 0x18, PCI_VENDOR_ID_AMD, 0x1300 },
+	{ 0, 0x18, PCI_VENDOR_ID_AMD, 0x1100 }, /* K8 */
+	{ 0, 0x18, PCI_VENDOR_ID_AMD, 0x1200 }, /* Fam10h */
+	{ 0xff, 0, PCI_VENDOR_ID_AMD, 0x1200 }, /* Fam10h */
+	{ 0, 0x18, PCI_VENDOR_ID_AMD, 0x1300 }, /* Fam11h */
+	{ 0, 0x18, PCI_VENDOR_ID_AMD, 0x1600 }, /* Fam15h */
 };
 
 #define RANGE_NUM 16
@@ -113,6 +114,13 @@ static int __init early_fill_mp_bus_info(void)
 		info = alloc_pci_root_info(min_bus, max_bus, node, link);
 	}
 
+	/*
+	 * The following code is only supported until Fam11h.
+	 * Newer processors will depend on ACPI MCFG table instead.
+	 */
+	if (boot_cpu_data.x86 > 0x11)
+		return 0;
+
 	/* get the default node and link for left over res */
 	reg = read_pci_config(bus, slot, 0, 0x60);
 	def_node = (reg >> 8) & 0x07;
-- 
1.9.0

