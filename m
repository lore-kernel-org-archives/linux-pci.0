Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:44691 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbbCKOMt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 10:12:49 -0400
Received: by lbvn10 with SMTP id n10so9095607lbv.11
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2015 07:12:48 -0700 (PDT)
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
To: bhelgaas@google.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	al.stone@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH v4 6/9] x86, pci: mmconfig_{32,64}.c code refactoring - remove code duplication.
Date: Wed, 11 Mar 2015 15:12:46 +0100
Message-Id: <1426083169-8698-7-git-send-email-tomasz.nowicki@linaro.org>
In-Reply-To: <1426083169-8698-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1426083169-8698-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mmconfig_64.c version is going to be default implementation for arch
agnostic low-level direct PCI config space accessors for ECAM dirver.
However, now it initialize raw_pci_ext_ops pointer which is x86 specific
code only. Moreover, mmconfig_32.c is doing the same thing at the same time.

Move it to mmconfig_shared.c so it becomes common for both and
mmconfig_64.c turns out to be purely arch agnostic.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 arch/x86/pci/mmconfig-shared.c | 10 ++++++++--
 arch/x86/pci/mmconfig_32.c     | 10 ++--------
 arch/x86/pci/mmconfig_64.c     | 11 ++---------
 include/linux/ecam.h           |  5 +++++
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 5064302..6dfe614 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -29,6 +29,11 @@
 static bool pci_mmcfg_running_state;
 static bool pci_mmcfg_arch_init_failed;
 
+const struct pci_raw_ops pci_mmcfg = {
+	.read =		pci_mmcfg_read,
+	.write =	pci_mmcfg_write,
+};
+
 static u32
 pci_mmconfig_amd_read(int len, void __iomem *addr)
 {
@@ -532,9 +537,10 @@ static void __init __pci_mmcfg_init(int early)
 		}
 	}
 
-	if (pci_mmcfg_arch_init())
+	if (pci_mmcfg_arch_init()) {
+		raw_pci_ext_ops = &pci_mmcfg;
 		pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
-	else {
+	} else {
 		free_all_mmcfg();
 		pci_mmcfg_arch_init_failed = true;
 	}
diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
index 5cf6291..7a050cb 100644
--- a/arch/x86/pci/mmconfig_32.c
+++ b/arch/x86/pci/mmconfig_32.c
@@ -50,7 +50,7 @@ static void pci_exp_set_dev_base(unsigned int base, int bus, int devfn)
 	}
 }
 
-static int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+int pci_mmcfg_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
@@ -79,7 +79,7 @@ err:		*value = -1;
 	return 0;
 }
 
-static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
@@ -106,15 +106,9 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 	return 0;
 }
 
-const struct pci_raw_ops pci_mmcfg = {
-	.read =		pci_mmcfg_read,
-	.write =	pci_mmcfg_write,
-};
-
 int __init pci_mmcfg_arch_init(void)
 {
 	printk(KERN_INFO "PCI: Using MMCONFIG for extended config space\n");
-	raw_pci_ext_ops = &pci_mmcfg;
 	return 1;
 }
 
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index b62ff18..fd857ea 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -25,7 +25,7 @@ static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus, unsigned i
 	return NULL;
 }
 
-static int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+int pci_mmcfg_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	char __iomem *addr;
@@ -49,7 +49,7 @@ err:		*value = -1;
 	return 0;
 }
 
-static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
 	char __iomem *addr;
@@ -71,11 +71,6 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 	return 0;
 }
 
-const struct pci_raw_ops pci_mmcfg = {
-	.read =		pci_mmcfg_read,
-	.write =	pci_mmcfg_write,
-};
-
 static void __iomem *mcfg_ioremap(struct pci_mmcfg_region *cfg)
 {
 	void __iomem *addr;
@@ -101,8 +96,6 @@ int __init pci_mmcfg_arch_init(void)
 			return 0;
 		}
 
-	raw_pci_ext_ops = &pci_mmcfg;
-
 	return 1;
 }
 
diff --git a/include/linux/ecam.h b/include/linux/ecam.h
index 2387df5..fba5d6b 100644
--- a/include/linux/ecam.h
+++ b/include/linux/ecam.h
@@ -47,5 +47,10 @@ extern struct list_head pci_mmcfg_list;
 
 #define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
 
+int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+		   unsigned int devfn, int reg, int len, u32 *value);
+int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+		    unsigned int devfn, int reg, int len, u32 value);
+
 #endif  /* __KERNEL__ */
 #endif  /* __ECAM_H */
-- 
1.9.1

