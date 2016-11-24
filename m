Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Singleton <davsingl@cisco.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Steve Shih <sshih@cisco.com>, xe-kernel@external.cisco.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH] pcie: aer: aerdrv: PCIe AER workaround and handling for ASR1K platforms.
Date: Wed, 23 Nov 2016 20:19:03 -0800
Message-Id: <20161124041904.17393-1-davsingl@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Steve Shih <sshih@cisco.com>

ASR1K FPGAs and ASICs are configured to raise SERR/PERR through PCIe AER.
When an error is raised, it is detected at the root complex, but it is not
detected by the AER driver. If the root complex bridge control register is
configured to forward secondary bus errors to the primary bus (which is not
the case by default), then the aerdrv.c:aer_irq() is invoked, but the id read
from the PCI_ERR_ROOT_COR_SRC register is 0. When aer_isr_one_error()
processes the work posted by aer_irq(), it subsequently complains that
"aer_isr_one_err->can't find device of ID0000".

Modifications need to be made such that PCIe AER are propagated through the
root complex detected by the AER driver and delivered to the ASR1K PCI error
handler.

In additions, MCH5100 and 3500/5500 JF send broadcast EOI to subordinate
devices. However, the Cisco FPGAs and ASICs don't handle the vendor (Intel)
specific messages properly and rases Uncorrectable and Unsupported Request
errors. Thus, need to disable EOI Broadcast.


Cc: xe-kernel@external.cisco.com
Signed-off-by: Steve Shih <sshih@cisco.com>
Signed-off-by: David Singleton <davsingl@cisco.com>
---
 arch/x86/Kconfig                    |   9 ++
 arch/x86/platform/Makefile          |   1 +
 arch/x86/platform/asr1k/Makefile    |   1 +
 arch/x86/platform/asr1k/asr1k_aer.c | 165 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer/aerdrv.c       |  13 +++
 drivers/pci/pcie/aer/aerdrv.h       |   5 ++
 drivers/pci/quirks.c                |   7 ++
 include/asm-generic/vmlinux.lds.h   |   3 +
 include/linux/pci.h                 |   5 ++
 9 files changed, 209 insertions(+)
 create mode 100644 arch/x86/platform/asr1k/Makefile
 create mode 100644 arch/x86/platform/asr1k/asr1k_aer.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bada636..11bdcb2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -449,6 +449,15 @@ config X86_EXTENDED_PLATFORM
 endif
 # This is an alphabetically sorted list of 64 bit extended platforms
 # Please maintain the alphabetic order if and when there are additions
+
+config X86_ASR1K
+	bool "Cisco ASR1K"
+	depends on X86_64
+	depends on X86_EXTENDED_PLATFORM
+	---help---
+	  This option is needed in order to support Cisco ASR1K platforms.
+	  If you don't have one of these, you should say N here.
+
 config X86_NUMACHIP
 	bool "Numascale NumaChip"
 	depends on X86_64
diff --git a/arch/x86/platform/Makefile b/arch/x86/platform/Makefile
index 3c3c19e..cbae8c2 100644
--- a/arch/x86/platform/Makefile
+++ b/arch/x86/platform/Makefile
@@ -1,5 +1,6 @@
 # Platform specific code goes here
 obj-y	+= atom/
+obj-$(X86_ASR1K)	+= asr1k/
 obj-y	+= ce4100/
 obj-y	+= efi/
 obj-y	+= geode/
diff --git a/arch/x86/platform/asr1k/Makefile b/arch/x86/platform/asr1k/Makefile
new file mode 100644
index 0000000..0219e40
--- /dev/null
+++ b/arch/x86/platform/asr1k/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PCIEAER)	+= asr1k_aer.o
diff --git a/arch/x86/platform/asr1k/asr1k_aer.c b/arch/x86/platform/asr1k/asr1k_aer.c
new file mode 100644
index 0000000..6962672
--- /dev/null
+++ b/arch/x86/platform/asr1k/asr1k_aer.c
@@ -0,0 +1,165 @@
+/*
+ * Cisco ASR1K platform PCIe AER support
+ *
+ * Copyright (c) 2015 by cisco Systems, Inc.
+ */
+
+#include <linux/pci.h>
+#include <../../../drivers/pci/pcie/aer/aerdrv.h>
+
+/* MCH 5100 */
+#define PCI_DEVICE_ID_5100_PORT_0   	0x7270
+#define PCI_DEVICE_ID_5100_PORT_2_3	0x65F7
+#define PCI_DEVICE_ID_5100_PORT_6	0x65E6
+#define PEXCTRL3			0x4D
+#define PEXCTRL3_MSI_RAS_ERREN		0x01
+#define PEXCTRL				0x48
+#define PEXCTRL_DIS_APIC_EOI		0x02
+
+/* Jasper Forest - 3500/5500 Series */
+#define PCI_DEVICE_ID_3500_PORT_1	0x3721
+#define PCI_DEVICE_ID_3500_PORT_2	0x3722
+#define PCI_DEVICE_ID_3500_PORT_3	0x3723
+#define PCI_DEVICE_ID_3500_PORT_4	0x3724
+#define MISCCTRLSTS_REG			0x188
+#define MISCCTRLSTS_DISABLE_EOI_MASK	0x04000000
+
+static int aer_err_src_mch5100(struct pci_dev *pdev, unsigned int *id)
+{
+	/*
+	 * MCH 5100 doesn't populate src register, explained
+	 * in an errata, so hard coding the source id
+	 */
+	*id = ((pdev->devfn << 16) | pdev->devfn);
+
+	return 0;
+}
+
+static int aer_err_src_jf(struct pci_dev *pdev, unsigned int *id)
+{
+	/*
+	 * Xeon 3500/5500 series (Jasper Forest) doesn't populate
+	 * the source register either, so we must hard code.
+	 */
+	unsigned int devfn = (pdev->subordinate->number << 8) |
+				PCI_DEVFN(0,0);
+	*id = (devfn << 16) | devfn;
+
+	return 0;
+}
+
+int aer_err_src(struct pci_dev *dev, unsigned int *id)
+{
+	if ((dev->vendor == PCI_VENDOR_ID_INTEL) &&
+	    ((dev->device == PCI_DEVICE_ID_5100_PORT_0) ||
+	     (dev->device == PCI_DEVICE_ID_5100_PORT_2_3) ||
+	     (dev->device == PCI_DEVICE_ID_5100_PORT_6)))
+		return aer_err_src_mch5100(dev, id);
+
+	if ((dev->vendor == PCI_VENDOR_ID_INTEL) &&
+	    ((dev->device == PCI_DEVICE_ID_3500_PORT_1) ||
+	     (dev->device == PCI_DEVICE_ID_3500_PORT_2) ||
+	     (dev->device == PCI_DEVICE_ID_3500_PORT_3) ||
+	     (dev->device == PCI_DEVICE_ID_3500_PORT_4)))
+		return aer_err_src_jf(dev, id);
+
+	return 0;
+}
+
+static bool aer_callbacks_set;
+
+static struct pci_aer_callbacks aer_callbacks = {
+	.error_source = aer_err_src,
+};
+
+static void aer_enable_rootport_mch5100(struct pci_dev *pdev)
+{
+	u32 reg32;
+	u8 reg8;
+
+	if (!aer_callbacks_set) {
+		pci_aer_set_callbacks(&aer_callbacks);
+		aer_callbacks_set = true;
+	}
+
+	/*
+	 * MCH5100 sends broadcast EOI to subordinate
+	 * devices. It is a vendor (Intel) specific message
+	 * that should be ignored by non-Intel devices, but
+	 * our devices (Hytop etc) do not ignore it and
+	 * raise Uncorrectable and Unsupported Request
+	 * errors.
+	 *
+	 * The EOI is for the Intel IO APIC, which is not
+	 * present and therefore not required.
+	 *
+	 * Disable EOI Broadcast to avoid Uncorrectable and
+	 * Unsupported request errors from devices which do
+	 * not support the EOI and do not adhere to the PCIe
+	 * spec.
+	 */
+	pci_read_config_dword(pdev, PEXCTRL, &reg32);
+	reg32 |= PEXCTRL_DIS_APIC_EOI;
+	pci_write_config_dword(pdev, PEXCTRL, reg32);
+
+	/* Enable MSI */
+	pci_read_config_byte(pdev, PEXCTRL3, &reg8);
+	reg8 |= PEXCTRL3_MSI_RAS_ERREN;
+	pci_write_config_byte(pdev, PEXCTRL3, reg8);
+}
+
+static void aer_enable_rootport_jf(struct pci_dev *pdev)
+{
+	u32 reg32;
+	u16 reg16;
+
+	if (!aer_callbacks_set) {
+		pci_aer_set_callbacks(&aer_callbacks);
+		aer_callbacks_set = true;
+	}
+
+	/*
+	 * 3500/5500 series CPUs (JF) send broadcast EOI to
+	 * subordinate devices. It is a vendor (Intel) specific
+	 * message that should be ignored by non-Intel devices,
+	 * but our devices (Yoda etc) do not ignore it and
+	 * raise Uncorrectable and Unsupported Request
+	 * errors.
+	 *
+	 * The EOI is for the Intel IO APIC, which is not
+	 * present and therefore not required.
+	 *
+	 * Disable EOI Broadcast to avoid Uncorrectable and
+	 * Unsupported request errors from devices which do
+	 * not support the EOI and do not adhere to the PCIe
+	 * spec.
+	 */
+	pci_read_config_dword(pdev, MISCCTRLSTS_REG, &reg32);
+	reg32 |= MISCCTRLSTS_DISABLE_EOI_MASK;
+	pci_write_config_dword(pdev, MISCCTRLSTS_REG, reg32);
+
+	/*
+	 * We must also forward #SERR and #PERR from the secondary
+	 * to primary bus.  This will result in the AER driver
+	 * receiving an interrupt that can then be delivered to
+	 * the device specific driver.
+	 */
+	pci_read_config_word(pdev, PCI_BRIDGE_CONTROL, &reg16);
+	reg16 |= PCI_BRIDGE_CTL_PARITY | PCI_BRIDGE_CTL_SERR;
+	pci_write_config_word(pdev, PCI_BRIDGE_CONTROL, reg16);
+}
+
+DECLARE_PCI_FIXUP_AER_ENABLE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_5100_PORT_0,
+				aer_enable_rootport_mch5100);
+DECLARE_PCI_FIXUP_AER_ENABLE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_5100_PORT_2_3,
+				aer_enable_rootport_mch5100);
+DECLARE_PCI_FIXUP_AER_ENABLE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_5100_PORT_6,
+				aer_enable_rootport_mch5100);
+DECLARE_PCI_FIXUP_AER_ENABLE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_3500_PORT_1,
+				aer_enable_rootport_jf);
+DECLARE_PCI_FIXUP_AER_ENABLE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_3500_PORT_2,
+				aer_enable_rootport_jf);
+DECLARE_PCI_FIXUP_AER_ENABLE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_3500_PORT_3,
+				aer_enable_rootport_jf);
+DECLARE_PCI_FIXUP_AER_ENABLE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_3500_PORT_4,
+				aer_enable_rootport_jf);
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 139150b..836e0cb 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -62,6 +62,8 @@ static struct pcie_port_service_driver aerdriver = {
 	.reset_link	= aer_root_reset,
 };
 
+static struct pci_aer_callbacks callbacks;
+
 static int pcie_aer_disable;
 
 void pci_no_aer(void)
@@ -74,6 +76,11 @@ bool pci_aer_available(void)
 	return !pcie_aer_disable && pci_msi_enabled();
 }
 
+void pci_aer_set_callbacks(struct pci_aer_callbacks *cb)
+{
+	memcpy(&callbacks, cb, sizeof(*cb));
+}
+
 static int set_device_error_reporting(struct pci_dev *dev, void *data)
 {
 	bool enable = *((bool *)data);
@@ -149,6 +156,8 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, reg32);
+
+	pci_fixup_device(pci_fixup_aer_enable, pdev);
 }
 
 /**
@@ -212,6 +221,10 @@ irqreturn_t aer_irq(int irq, void *context)
 
 	/* Read error source and clear error status */
 	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_ERR_SRC, &id);
+
+	if (callbacks.error_source)
+		callbacks.error_source(pdev->port, &id);
+
 	pci_write_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, status);
 
 	/* Store error source for later DPC handler */
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index d51e4a5..79ac642 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -80,6 +80,10 @@ struct aer_broadcast_data {
 	enum pci_ers_result result;
 };
 
+struct pci_aer_callbacks {
+	int (*error_source)(struct pci_dev *dev, unsigned int *id);
+};
+
 static inline pci_ers_result_t merge_result(enum pci_ers_result orig,
 		enum pci_ers_result new)
 {
@@ -110,6 +114,7 @@ void aer_isr(struct work_struct *work);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info);
 irqreturn_t aer_irq(int irq, void *context);
+void pci_aer_set_callbacks(struct pci_aer_callbacks *cb);
 
 #ifdef CONFIG_ACPI_APEI
 int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c232729..63b33ff 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3397,6 +3397,8 @@ extern struct pci_fixup __start_pci_fixups_suspend[];
 extern struct pci_fixup __end_pci_fixups_suspend[];
 extern struct pci_fixup __start_pci_fixups_suspend_late[];
 extern struct pci_fixup __end_pci_fixups_suspend_late[];
+extern struct pci_fixup __start_pci_fixups_aer_enable[];
+extern struct pci_fixup __end_pci_fixups_aer_enable[];
 
 static bool pci_apply_fixup_final_quirks;
 
@@ -3447,6 +3449,11 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 		end = __end_pci_fixups_suspend_late;
 		break;
 
+	case pci_fixup_aer_enable:
+		start = __start_pci_fixups_aer_enable;
+		end = __end_pci_fixups_aer_enable;
+		break;
+
 	default:
 		/* stupid compiler warning, you would think with an enum... */
 		return;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3074796..c646106 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -311,6 +311,9 @@
 		VMLINUX_SYMBOL(__start_pci_fixups_suspend_late) = .;	\
 		*(.pci_fixup_suspend_late)				\
 		VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) = .;	\
+		VMLINUX_SYMBOL(__start_pci_fixups_aer_enable) = .;      \
+		*(.pci_fixup_aer_enable)                                \
+		VMLINUX_SYMBOL(__end_pci_fixups_aer_enable) = .;	\
 	}								\
 									\
 	/* Built-in firmware blobs */					\
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e49f70..9a9119c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1689,6 +1689,7 @@ enum pci_fixup_pass {
 	pci_fixup_suspend,	/* pci_device_suspend() */
 	pci_fixup_resume_early, /* pci_device_resume_early() */
 	pci_fixup_suspend_late,	/* pci_device_suspend_late() */
+	pci_fixup_aer_enable,   /* pci_device_aer_enable() */
 };
 
 /* Anonymous variables would be nice... */
@@ -1763,6 +1764,10 @@ enum pci_fixup_pass {
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend_late,		\
 		suspend_late##hook, vendor, device,	\
 		PCI_ANY_ID, 0, hook)
+#define DECLARE_PCI_FIXUP_AER_ENABLE(vendor, device, hook)		\
+	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_aer_enable,		\
+		aer_enable##vendor##device##hook, vendor, device,	\
+		PCI_ANY_ID, 0, hook)
 
 #ifdef CONFIG_PCI_QUIRKS
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
-- 
2.10.1
