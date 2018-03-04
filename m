Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:60013 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbeCDScB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Mar 2018 13:32:01 -0500
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 3/7] x86/jailhouse: Enable PCI mmconfig access in inmates
Date: Sun,  4 Mar 2018 19:31:35 +0100
Message-Id: <d780e72d7a0992c891f6787aa517f8f090cb54d9.1520188299.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520188299.git.jan.kiszka@siemens.com>
References: <cover.1520188299.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1520188299.git.jan.kiszka@siemens.com>
References: <cover.1520188299.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Otavio Pontes <otavio.pontes@intel.com>

Use the PCI mmconfig base address exported by jailhouse in boot
parameters in order to access the memory mapped PCI configuration space.

Signed-off-by: Otavio Pontes <otavio.pontes@intel.com>
[Jan: rebased, fixed !CONFIG_PCI_MMCONFIG, used pcibios_last_bus]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/include/asm/pci_x86.h | 2 ++
 arch/x86/kernel/jailhouse.c    | 8 ++++++++
 arch/x86/pci/mmconfig-shared.c | 4 ++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index eb66fa9cd0fc..959d618dbb17 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -151,6 +151,8 @@ extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 			       phys_addr_t addr);
 extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
+extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
+							int end, u64 addr);
 
 extern struct list_head pci_mmcfg_list;
 
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index b68fd895235a..fa183a131edc 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -124,6 +124,14 @@ static int __init jailhouse_pci_arch_init(void)
 	if (pcibios_last_bus < 0)
 		pcibios_last_bus = 0xff;
 
+#ifdef CONFIG_PCI_MMCONFIG
+	if (setup_data.pci_mmconfig_base) {
+		pci_mmconfig_add(0, 0, pcibios_last_bus,
+				 setup_data.pci_mmconfig_base);
+		pci_mmcfg_arch_init();
+	}
+#endif
+
 	return 0;
 }
 
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 96684d0adcf9..0e590272366b 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -94,8 +94,8 @@ static struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
 	return new;
 }
 
-static struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
-							int end, u64 addr)
+struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
+						 int end, u64 addr)
 {
 	struct pci_mmcfg_region *new;
 
-- 
2.13.6
