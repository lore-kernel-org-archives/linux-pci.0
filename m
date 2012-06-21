Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:21530 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab2FUJsG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 05:48:06 -0400
From: Jiang Liu <jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
CC: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v9 10/11] x86, PCI: refine __pci_mmcfg_init() for better code readability
Date: Thu, 21 Jun 2012 17:37:02 +0800
Message-ID: <1340271423-4352-11-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
References: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Refine __pci_mmcfg_init() for better code readability.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/pci/mmconfig-shared.c |   46 ++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 332fabd..ffe72b9 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -544,8 +544,6 @@ static void __init pci_mmcfg_reject_broken(int early)
 	}
 }
 
-static int __initdata known_bridge;
-
 static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
 					struct acpi_mcfg_allocation *cfg)
 {
@@ -617,28 +615,7 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 
 static void __init __pci_mmcfg_init(int early)
 {
-	/* MMCONFIG disabled */
-	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
-		return;
-
-	/* MMCONFIG already enabled */
-	if (!early && !(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
-		return;
-
-	/* for late to exit */
-	if (known_bridge)
-		return;
-
-	if (early) {
-		if (pci_mmcfg_check_hostbridge())
-			known_bridge = 1;
-	}
-
-	if (!known_bridge)
-		acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
-
 	pci_mmcfg_reject_broken(early);
-
 	if (list_empty(&pci_mmcfg_list))
 		return;
 
@@ -660,14 +637,33 @@ static void __init __pci_mmcfg_init(int early)
 	}
 }
 
+static int __initdata known_bridge;
+
 void __init pci_mmcfg_early_init(void)
 {
-	__pci_mmcfg_init(1);
+	if (pci_probe & PCI_PROBE_MMCONF) {
+		if (pci_mmcfg_check_hostbridge())
+			known_bridge = 1;
+		else
+			acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
+		__pci_mmcfg_init(1);
+	}
 }
 
 void __init pci_mmcfg_late_init(void)
 {
-	__pci_mmcfg_init(0);
+	/* MMCONFIG disabled */
+	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
+		return;
+
+	if (known_bridge)
+		return;
+
+	/* MMCONFIG hasn't been enabled yet, try again */
+	if (pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF) {
+		acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
+		__pci_mmcfg_init(0);
+	}
 }
 
 static int __init pci_mmcfg_late_insert_resources(void)
-- 
1.7.1


