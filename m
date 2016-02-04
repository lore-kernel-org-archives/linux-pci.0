Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V4 04/23] x86, pci: mmconfig_{32,64}.c code refactoring - remove code duplication.
Date: Thu,  4 Feb 2016 18:28:42 +0100
Message-Id: <1454606941-9523-5-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mmconfig_64.c version is going to be default implementation for low-level
operation on mmconfig regions. However, now it initializes raw_pci_ext_ops pointer which is specific for
x86 only. Moreover, mmconfig_32.c is doing the same thing at the same time.
So lets move it to mmconfig_shared.c so it becomes common for both and
mmconfig_64.c turns out to be purely arch agnostic.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/x86/include/asm/pci_x86.h |  5 +++++
 arch/x86/pci/mmconfig-shared.c | 10 ++++++++--
 arch/x86/pci/mmconfig_32.c     | 10 ++--------
 arch/x86/pci/mmconfig_64.c     | 11 ++---------
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 0281d2d..26e7dd4 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -129,6 +129,11 @@ extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
 extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 			       phys_addr_t addr);
 
+int pci_mmcfg_read(unsigned int seg, unsigned int bus, unsigned int devfn,
+		   int reg, int len, u32 *value);
+int pci_mmcfg_write(unsigned int seg, unsigned int bus, unsigned int devfn,
+		    int reg, int len, u32 value);
+
 /*
  * On AMD Fam10h CPUs, all PCI MMIO configuration space accesses must use
  * %eax.  No other source or target registers may be used.  The following
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index ce2c2e4..980f304 100644
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
 static const char *__init pci_mmcfg_e7520(void)
 {
 	u32 win;
@@ -512,9 +517,10 @@ static void __init __pci_mmcfg_init(int early)
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
index 246f135..2ded56f 100644
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
@@ -89,7 +89,7 @@ err:		*value = -1;
 	return 0;
 }
 
-static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
@@ -126,15 +126,9 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
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
index b14fcd3..d0c48eb 100644
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
@@ -59,7 +59,7 @@ err:		*value = -1;
 	return 0;
 }
 
-static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
 	char __iomem *addr;
@@ -91,11 +91,6 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
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
@@ -121,8 +116,6 @@ int __init pci_mmcfg_arch_init(void)
 			return 0;
 		}
 
-	raw_pci_ext_ops = &pci_mmcfg;
-
 	return 1;
 }
 
-- 
1.9.1

