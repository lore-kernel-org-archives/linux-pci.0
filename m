Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bgl-iport-4.cisco.com ([72.163.197.28]:23112 "EHLO
        bgl-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935367AbcJQRB3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 13:01:29 -0400
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
Date: Mon, 17 Oct 2016 09:51:06 -0700
Message-Id: <20161017165108.29718-3-davsingl@cisco.com>
Sender: linux-pci-owner@vger.kernel.org
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

This change is needed to support 1RU, FP40, Kingpin, FP80, and FP160.

Cc: xe-kernel@external.cisco.com
Signed-off-by: Steve Shih <sshih@cisco.com>
Signed-off-by: David Singleton <davsingl@cisco.com>
---
 arch/x86/Kconfig                  |  9 +++++++++
 arch/x86/platform/Makefile        |  1 +
 drivers/pci/pcie/aer/aerdrv.c     | 13 +++++++++++++
 drivers/pci/pcie/aer/aerdrv.h     |  5 +++++
 drivers/pci/quirks.c              |  7 +++++++
 include/asm-generic/vmlinux.lds.h |  3 +++
 include/linux/pci.h               |  5 +++++
 7 files changed, 43 insertions(+)

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
index 3e42bcd..4155e8c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -306,6 +306,9 @@
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
2.9.3

