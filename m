Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:41204 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab2FSNUY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2012 09:20:24 -0400
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
Subject: [PATCH v8 10/12] x86/PCI: refine __pci_mmcfg_init() for better code readability
Date: Tue, 19 Jun 2012 21:15:30 +0800
Message-ID: <1340111732-6276-11-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340111732-6276-1-git-send-email-jiang.liu@huawei.com>
References: <1340111732-6276-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Refine __pci_mmcfg_init() for better code readability.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/pci/mmconfig-shared.c |   51 ++++++++++++++++++---------------------
 1 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 870ed3f..f8c967c 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -545,8 +545,6 @@ static void __init pci_mmcfg_reject_broken(int early)
 	}
 }
 
-static int __initdata known_bridge;
-
 static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
 					struct acpi_mcfg_allocation *cfg)
 {
@@ -618,28 +616,7 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 
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
 
@@ -659,19 +636,39 @@ static void __init __pci_mmcfg_init(int early)
 		free_all_mmcfg();
 		pci_mmcfg_arch_init_failed = true;
 	}
-
-	if (!early && !known_bridge)
-		acpi_pci_cache_mcfg();
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
+	/* MMCONFIG disabled */
+	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
+		return;
+
+	/* MMCONFIG already enabled */
+	if (!(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
+		return;
+
+	if (known_bridge)
+		return;
+
+	acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
 	__pci_mmcfg_init(0);
+
+	if (!(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
+		acpi_pci_cache_mcfg();
 }
 
 static int __init pci_mmcfg_late_insert_resources(void)
-- 
1.7.1


