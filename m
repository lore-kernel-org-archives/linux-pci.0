Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:59741 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966063AbeCAFlK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Mar 2018 00:41:10 -0500
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
Subject: [PATCH v3 3/6] x86/jailhouse: Enable PCI mmconfig access in inmates
Date: Thu,  1 Mar 2018 06:40:46 +0100
Message-Id: <188edc11aa5fa11d4915097831a2a4a153f6ed83.1519882849.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1519882849.git.jan.kiszka@siemens.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1519882849.git.jan.kiszka@siemens.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Otavio Pontes <otavio.pontes@intel.com>

Use the PCI mmconfig base address exported by jailhouse in boot
parameters in order to access the memory mapped PCI configuration space.

Signed-off-by: Otavio Pontes <otavio.pontes@intel.com>
[Jan: rebased, fixed !CONFIG_PCI_MMCONFIG]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/include/asm/pci_x86.h | 2 ++
 arch/x86/kernel/jailhouse.c    | 7 +++++++
 arch/x86/pci/mmconfig-shared.c | 4 ++--
 3 files changed, 11 insertions(+), 2 deletions(-)

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
index b68fd895235a..7fe2a73da0b3 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -124,6 +124,13 @@ static int __init jailhouse_pci_arch_init(void)
 	if (pcibios_last_bus < 0)
 		pcibios_last_bus = 0xff;
 
+#ifdef CONFIG_PCI_MMCONFIG
+	if (setup_data.pci_mmconfig_base) {
+		pci_mmconfig_add(0, 0, 0xff, setup_data.pci_mmconfig_base);
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
