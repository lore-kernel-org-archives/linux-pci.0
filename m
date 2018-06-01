Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V3] PCI: move early dump functionality from x86 arch into the
 common code
Date: Fri,  1 Jun 2018 15:00:15 -0400
Message-Id: <1527879620-22720-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Petr Tesarik <ptesarik@suse.cz>, Ram Pai <linuxram@us.ibm.com>,
 Sinan Kaya <okaya@codeaurora.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Christoffer Dall <cdall@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, David Rientjes <rientjes@google.com>,
 Thymo van Beers <thymovanbeers@gmail.com>, Borislav Petkov <bp@suse.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-arm-msm@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Juergen Gross <jgross@suse.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Move early dump functionality into common code so that it is available for
all archtiectures. No need to carry arch specific reads around as the read
hooks are already initialized by the time pci_setup_device() is getting
called during scan.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/x86/include/asm/pci-direct.h               |  5 ---
 arch/x86/kernel/setup.c                         |  5 ---
 arch/x86/pci/common.c                           |  4 ---
 arch/x86/pci/early.c                            | 44 -------------------------
 drivers/pci/pci.c                               |  5 +++
 drivers/pci/pci.h                               |  1 +
 drivers/pci/probe.c                             | 19 +++++++++++
 8 files changed, 26 insertions(+), 59 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e490902..e64f1d8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2995,7 +2995,7 @@
 			See also Documentation/blockdev/paride.txt.
 
 	pci=option[,option...]	[PCI] various PCI subsystem options:
-		earlydump	[X86] dump PCI config space before the kernel
+		earlydump	dump PCI config space before the kernel
 				changes anything
 		off		[X86] don't probe for the PCI bus
 		bios		[X86-32] force use of PCI BIOS, don't access
diff --git a/arch/x86/include/asm/pci-direct.h b/arch/x86/include/asm/pci-direct.h
index e1084f7..e5e2129 100644
--- a/arch/x86/include/asm/pci-direct.h
+++ b/arch/x86/include/asm/pci-direct.h
@@ -14,9 +14,4 @@ extern void write_pci_config(u8 bus, u8 slot, u8 func, u8 offset, u32 val);
 extern void write_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset, u8 val);
 extern void write_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset, u16 val);
 
-extern int early_pci_allowed(void);
-
-extern unsigned int pci_early_dump_regs;
-extern void early_dump_pci_device(u8 bus, u8 slot, u8 func);
-extern void early_dump_pci_devices(void);
 #endif /* _ASM_X86_PCI_DIRECT_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 2f86d88..480f250 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -991,11 +991,6 @@ void __init setup_arch(char **cmdline_p)
 		setup_clear_cpu_cap(X86_FEATURE_APIC);
 	}
 
-#ifdef CONFIG_PCI
-	if (pci_early_dump_regs)
-		early_dump_pci_devices();
-#endif
-
 	e820__reserve_setup_data();
 	e820__finish_early_params();
 
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 563049c..d4ec117 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -22,7 +22,6 @@
 unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
 				PCI_PROBE_MMCONF;
 
-unsigned int pci_early_dump_regs;
 static int pci_bf_sort;
 int pci_routeirq;
 int noioapicquirk;
@@ -599,9 +598,6 @@ char *__init pcibios_setup(char *str)
 		pci_probe |= PCI_BIG_ROOT_WINDOW;
 		return NULL;
 #endif
-	} else if (!strcmp(str, "earlydump")) {
-		pci_early_dump_regs = 1;
-		return NULL;
 	} else if (!strcmp(str, "routeirq")) {
 		pci_routeirq = 1;
 		return NULL;
diff --git a/arch/x86/pci/early.c b/arch/x86/pci/early.c
index e5f753c..f5fc953 100644
--- a/arch/x86/pci/early.c
+++ b/arch/x86/pci/early.c
@@ -57,47 +57,3 @@ int early_pci_allowed(void)
 			PCI_PROBE_CONF1;
 }
 
-void early_dump_pci_device(u8 bus, u8 slot, u8 func)
-{
-	u32 value[256 / 4];
-	int i;
-
-	pr_info("pci 0000:%02x:%02x.%d config space:\n", bus, slot, func);
-
-	for (i = 0; i < 256; i += 4)
-		value[i / 4] = read_pci_config(bus, slot, func, i);
-
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value, 256, false);
-}
-
-void early_dump_pci_devices(void)
-{
-	unsigned bus, slot, func;
-
-	if (!early_pci_allowed())
-		return;
-
-	for (bus = 0; bus < 256; bus++) {
-		for (slot = 0; slot < 32; slot++) {
-			for (func = 0; func < 8; func++) {
-				u32 class;
-				u8 type;
-
-				class = read_pci_config(bus, slot, func,
-							PCI_CLASS_REVISION);
-				if (class == 0xffffffff)
-					continue;
-
-				early_dump_pci_device(bus, slot, func);
-
-				if (func == 0) {
-					type = read_pci_config_byte(bus, slot,
-								    func,
-							       PCI_HEADER_TYPE);
-					if (!(type & 0x80))
-						break;
-				}
-			}
-		}
-	}
-}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 97acba7..04052dc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -115,6 +115,9 @@ static bool pcie_ari_disabled;
 /* If set, the PCIe ATS capability will not be used. */
 static bool pcie_ats_disabled;
 
+/* If set, the PCI config space of each device is printed during boot. */
+bool pci_early_dump;
+
 bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
@@ -5805,6 +5808,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "earlydump")) {
+				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
 				pci_realloc_get_opt(str + 8);
 			} else if (!strncmp(str, "realloc", 7)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a0..c33265e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -7,6 +7,7 @@
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
 extern const unsigned char pcie_link_speed[];
+extern bool pci_early_dump;
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 56771f3..3678f0a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1545,6 +1545,23 @@ static int pci_intx_mask_broken(struct pci_dev *dev)
 	return 0;
 }
 
+static void early_dump_pci_device(struct pci_dev *pdev)
+{
+	u32 value[256 / 4];
+	int i;
+
+	if (!pci_early_dump)
+		return;
+
+	pci_info(pdev, "config space:\n");
+
+	for (i = 0; i < 256; i += 4)
+		pci_read_config_dword(pdev, i, &value[i / 4]);
+
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value,
+		       256, false);
+}
+
 /**
  * pci_setup_device - Fill in class and map information of a device
  * @dev: the device structure to fill
@@ -1594,6 +1611,8 @@ int pci_setup_device(struct pci_dev *dev)
 	pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
 		   dev->vendor, dev->device, dev->hdr_type, dev->class);
 
+	early_dump_pci_device(dev);
+
 	/* Need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
