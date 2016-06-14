Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52193 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbcFNS3w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jun 2016 14:29:52 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	David Cohen <david.a.cohen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] x86/platform/intel-mid: Add Power Management Unit driver
Date: Tue, 14 Jun 2016 21:29:45 +0300
Message-Id: <1465928985-12113-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add Power Management Unit driver to handle power states of South Complex
devices on Intel Tangier. In the future it might be expanded to cover North
Complex devices as well.

With this driver the power state of the host controllers such as SPI, I2C,
UART, eMMC, and DMA would be managed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
In v2:
- rename *pmu* to *pwr*
- fix indentation to be consistent for definitions
- add comments to explain what driver does
- refactor quirks in intel_mid_pci.c

 arch/x86/include/asm/intel-mid.h     |   8 +
 arch/x86/pci/intel_mid_pci.c         |  40 +++-
 arch/x86/platform/intel-mid/Makefile |   2 +-
 arch/x86/platform/intel-mid/pwr.c    | 416 +++++++++++++++++++++++++++++++++++
 drivers/pci/Makefile                 |   3 +
 drivers/pci/pci-mid.c                |  77 +++++++
 6 files changed, 540 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/platform/intel-mid/pwr.c
 create mode 100644 drivers/pci/pci-mid.c

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index 3cca952..032e041 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -12,9 +12,17 @@
 #define _ASM_X86_INTEL_MID_H
 
 #include <linux/sfi.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 
 extern int intel_mid_pci_init(void);
+extern int intel_mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state);
+
+#define INTEL_MID_PWR_LSS_OFFSET	4
+#define INTEL_MID_PWR_LSS_TYPE		(1 << 7)
+
+extern int intel_mid_pwr_get_lss_id(struct pci_dev *pdev);
+
 extern int get_gpio_by_name(const char *name);
 extern void intel_scu_device_register(struct platform_device *pdev);
 extern int __init sfi_parse_mrtc(struct sfi_table_header *table);
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index ae97f24..a971043 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -316,14 +316,44 @@ static void pci_d3delay_fixup(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_d3delay_fixup);
 
-static void mrst_power_off_unused_dev(struct pci_dev *dev)
+static void mid_power_off_dev(struct pci_dev *dev)
 {
+	u16 pmcsr;
+
+	/*
+	 * Update current state first, otherwise PCI core enforces PCI_D0 in
+	 * pci_set_power_state() for devices which status was PCI_UNKNOWN.
+	 */
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	dev->current_state = (pci_power_t __force)(pmcsr & PCI_PM_CTRL_STATE_MASK);
+
 	pci_set_power_state(dev, PCI_D3hot);
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0801, mrst_power_off_unused_dev);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0809, mrst_power_off_unused_dev);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x080C, mrst_power_off_unused_dev);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0815, mrst_power_off_unused_dev);
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0801, mid_power_off_dev);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0809, mid_power_off_dev);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x080C, mid_power_off_dev);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0815, mid_power_off_dev);
+
+static void mrfld_power_off_dev(struct pci_dev *dev)
+{
+	int id;
+
+	if (!pci_soc_mode)
+		return;
+
+	id = intel_mid_pwr_get_lss_id(dev);
+	if (id < 0)
+		return;
+
+	/*
+	 * This sets only PMCSR bits. The actual power off will happen in
+	 * arch/x86/platform/intel-mid/pwr.c.
+	 */
+	mid_power_off_dev(dev);
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, mrfld_power_off_dev);
 
 /*
  * Langwell devices reside at fixed offsets, don't try to move them.
diff --git a/arch/x86/platform/intel-mid/Makefile b/arch/x86/platform/intel-mid/Makefile
index 0ce1b19..aebb5b9 100644
--- a/arch/x86/platform/intel-mid/Makefile
+++ b/arch/x86/platform/intel-mid/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_X86_INTEL_MID) += intel-mid.o intel_mid_vrtc.o mfld.o mrfl.o
+obj-$(CONFIG_X86_INTEL_MID) += intel-mid.o intel_mid_vrtc.o mfld.o mrfl.o pwr.o
 
 # SFI specific code
 ifdef CONFIG_X86_INTEL_MID
diff --git a/arch/x86/platform/intel-mid/pwr.c b/arch/x86/platform/intel-mid/pwr.c
new file mode 100644
index 0000000..4e87865
--- /dev/null
+++ b/arch/x86/platform/intel-mid/pwr.c
@@ -0,0 +1,416 @@
+/*
+ * Intel MID Power Management Unit device driver
+ *
+ * Copyright (C) 2016, Intel Corporation
+ *
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * Intel MID Power Management Unit device driver handles the South Complex PCI
+ * devices such as GPDMA, SPI, I2C, PWM, and so on. By default PCI core
+ * modifies bits in PMCSR register in the PCI configuration space. This is not
+ * enough on some SoCs like Intel Tangier. In such case PCI core sets a new
+ * power state of the device in question through a PM hook registered in struct
+ * pci_platform_pm_ops (see drivers/pci/pci-mid.c).
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+
+#include <asm/intel-mid.h>
+
+/* Registers */
+#define PM_STS			0x00
+#define PM_CMD			0x04
+#define PM_ICS			0x08
+#define PM_WKC(x)		(0x10 + (x) * 4)
+#define PM_WKS(x)		(0x18 + (x) * 4)
+#define PM_SSC(x)		(0x20 + (x) * 4)
+#define PM_SSS(x)		(0x30 + (x) * 4)
+
+/* Bits in PM_STS */
+#define PM_STS_BUSY		(1 << 8)
+
+/* Bits in PM_CMD */
+#define PM_CMD_CMD(x)		((x) << 0)
+#define PM_CMD_IOC		(1 << 8)
+#define PM_CMD_D3cold		(1 << 21)
+
+/* List of commands */
+#define CMD_SET_CFG		0x01
+
+/* Bits in PM_ICS */
+#define PM_ICS_INT_STATUS(x)	((x) & 0xff)
+#define PM_ICS_IE		(1 << 8)
+#define PM_ICS_IP		(1 << 9)
+#define PM_ICS_SW_INT_STS	(1 << 10)
+
+/* List of interrupts */
+#define INT_INVALID		0
+#define INT_CMD_COMPLETE	1
+#define INT_CMD_ERR		2
+#define INT_WAKE_EVENT		3
+#define INT_LSS_POWER_ERR	4
+#define INT_S0iX_MSG_ERR	5
+#define INT_NO_C6		6
+#define INT_TRIGGER_ERR		7
+#define INT_INACTIVITY		8
+
+/* South Complex devices */
+#define LSS_MAX_SHARED_DEVS	4
+#define LSS_MAX_DEVS		64
+
+#define LSS_WS_BITS		1	/* wake state width */
+#define LSS_PWS_BITS		2	/* power state width */
+
+/* Supported device IDs */
+#define PCI_DEVICE_ID_TANGIER	0x11a1
+
+struct mid_pwr_dev {
+	struct pci_dev *pdev;
+	pci_power_t state;
+};
+
+struct mid_pwr {
+	struct device *dev;
+	void __iomem *regs;
+	int irq;
+	bool available;
+
+	struct mutex lock;
+	struct mid_pwr_dev lss[LSS_MAX_DEVS][LSS_MAX_SHARED_DEVS];
+};
+
+static struct mid_pwr *midpwr;
+
+static u32 mid_pwr_get_state(struct mid_pwr *pwr, int reg)
+{
+	return readl(pwr->regs + PM_SSS(reg));
+}
+
+static void mid_pwr_set_state(struct mid_pwr *pwr, int reg, u32 value)
+{
+	writel(value, pwr->regs + PM_SSC(reg));
+}
+
+static void mid_pwr_set_wake(struct mid_pwr *pwr, int reg, u32 value)
+{
+	writel(value, pwr->regs + PM_WKC(reg));
+}
+
+static void mid_pwr_interrupt_disable(struct mid_pwr *pwr)
+{
+	writel(~PM_ICS_IE, pwr->regs + PM_ICS);
+}
+
+static bool mid_pwr_is_busy(struct mid_pwr *pwr)
+{
+	return !!(readl(pwr->regs + PM_STS) & PM_STS_BUSY);
+}
+
+/* Wait 500ms that the latest PMU command finished */
+static int mid_pwr_wait(struct mid_pwr *pwr)
+{
+	unsigned int count = 500000;
+	bool busy;
+
+	do {
+		busy = mid_pwr_is_busy(pwr);
+		if (!busy)
+			return 0;
+		udelay(1);
+	} while (--count);
+
+	return -EBUSY;
+}
+
+static int mid_pwr_wait_for_cmd(struct mid_pwr *pwr, u8 cmd)
+{
+	writel(PM_CMD_CMD(cmd), pwr->regs + PM_CMD);
+	return mid_pwr_wait(pwr);
+}
+
+static int __update_power_state(struct mid_pwr *pwr, int reg, int bit, int new)
+{
+	int curstate;
+	u32 power;
+	int ret;
+
+	/* Check if the device is already in desired state */
+	power = mid_pwr_get_state(pwr, reg);
+	curstate = (power >> bit) & 3;
+	if (curstate == new)
+		return 0;
+
+	/* Update the power state */
+	mid_pwr_set_state(pwr, reg, (power & ~(3 << bit)) | (new << bit));
+
+	/* Send command to SCU */
+	ret = mid_pwr_wait_for_cmd(pwr, CMD_SET_CFG);
+	if (ret)
+		return ret;
+
+	/* Check if the device is already in desired state */
+	power = mid_pwr_get_state(pwr, reg);
+	curstate = (power >> bit) & 3;
+	if (curstate != new)
+		return -EAGAIN;
+
+	return 0;
+}
+
+static pci_power_t __find_weakest_power_state(struct mid_pwr_dev *lss,
+					      struct pci_dev *pdev,
+					      pci_power_t state)
+{
+	pci_power_t weakest = PCI_D3hot;
+	unsigned int j;
+
+	/* Find device in cache or first free cell */
+	for (j = 0; j < LSS_MAX_SHARED_DEVS; j++) {
+		if (lss[j].pdev == pdev || !lss[j].pdev)
+			break;
+	}
+
+	/* Store the desired state in cache */
+	if (j < LSS_MAX_SHARED_DEVS) {
+		lss[j].pdev = pdev;
+		lss[j].state = state;
+	} else {
+		dev_WARN(&pdev->dev, "No room for device in PMU LSS cache\n");
+		weakest = state;
+	}
+
+	/* Find the power state we may use */
+	for (j = 0; j < LSS_MAX_SHARED_DEVS; j++) {
+		if (lss[j].state < weakest)
+			weakest = lss[j].state;
+	}
+
+	return weakest;
+}
+
+static int __set_power_state(struct mid_pwr *pwr, struct pci_dev *pdev,
+			     pci_power_t state, int id, int reg, int bit)
+{
+	const char *name;
+	int ret;
+
+	state = __find_weakest_power_state(pwr->lss[id], pdev, state);
+	name = pci_power_name(state);
+
+	ret = __update_power_state(pwr, reg, bit, (__force int)state);
+	if (ret) {
+		dev_warn(&pdev->dev, "Can't set power state %s: %d\n", name, ret);
+		return ret;
+	}
+
+	dev_vdbg(&pdev->dev, "Set power state %s\n", name);
+	return 0;
+}
+
+static int mid_pwr_set_power_state(struct mid_pwr *pwr, struct pci_dev *pdev,
+				   pci_power_t state)
+{
+	int id, reg, bit;
+	int ret;
+
+	id = intel_mid_pwr_get_lss_id(pdev);
+	if (id < 0)
+		return id;
+
+	reg = (id * LSS_PWS_BITS) / 32;
+	bit = (id * LSS_PWS_BITS) % 32;
+
+	/* We support states between PCI_D0 and PCI_D3hot */
+	if (state < PCI_D0)
+		state = PCI_D0;
+	if (state > PCI_D3hot)
+		state = PCI_D3hot;
+
+	mutex_lock(&pwr->lock);
+	ret = __set_power_state(pwr, pdev, state, id, reg, bit);
+	mutex_unlock(&pwr->lock);
+	return ret;
+}
+
+int intel_mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state)
+{
+	struct mid_pwr *pwr = midpwr;
+	int ret = 0;
+
+	might_sleep();
+
+	if (pwr && pwr->available)
+		ret = mid_pwr_set_power_state(pwr, pdev, state);
+	dev_vdbg(&pdev->dev, "set_power_state() returns %d\n", ret);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_mid_pci_set_power_state);
+
+int intel_mid_pwr_get_lss_id(struct pci_dev *pdev)
+{
+	int vndr;
+	u8 id;
+
+	/*
+	 * Mapping to PMU index is kept in the Logical SubSystem ID byte of
+	 * Vendor capability.
+	 */
+	vndr = pci_find_capability(pdev, PCI_CAP_ID_VNDR);
+	if (!vndr)
+		return -EINVAL;
+
+	/* Read the Logical SubSystem ID byte */
+	pci_read_config_byte(pdev, vndr + INTEL_MID_PWR_LSS_OFFSET, &id);
+	if (!(id & INTEL_MID_PWR_LSS_TYPE))
+		return -ENODEV;
+
+	id &= ~INTEL_MID_PWR_LSS_TYPE;
+	if (id >= LSS_MAX_DEVS)
+		return -ERANGE;
+
+	return id;
+}
+
+static irqreturn_t mid_pwr_irq_handler(int irq, void *dev_id)
+{
+	struct mid_pwr *pwr = dev_id;
+	u32 ics;
+
+	ics = readl(pwr->regs + PM_ICS);
+	if (!(ics & PM_ICS_IP))
+		return IRQ_NONE;
+
+	writel(ics | PM_ICS_IP, pwr->regs + PM_ICS);
+
+	dev_warn(pwr->dev, "Unexpected IRQ: %#x\n", PM_ICS_INT_STATUS(ics));
+	return IRQ_HANDLED;
+}
+
+struct mid_pwr_device_info {
+	int (*set_initial_state)(struct mid_pwr *pwr);
+};
+
+static int mid_pwr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct mid_pwr_device_info *info = (void *)id->driver_data;
+	struct device *dev = &pdev->dev;
+	struct mid_pwr *pwr;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "error: could not enable device\n");
+		return ret;
+	}
+
+	ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
+	if (ret) {
+		dev_err(&pdev->dev, "I/O memory remapping failed\n");
+		return ret;
+	}
+
+	pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
+	if (!pwr)
+		return -ENOMEM;
+
+	pwr->dev = dev;
+	pwr->regs = pcim_iomap_table(pdev)[0];
+	pwr->irq = pdev->irq;
+
+	mutex_init(&pwr->lock);
+
+	/* Disable interrupts */
+	mid_pwr_interrupt_disable(pwr);
+
+	if (info && info->set_initial_state) {
+		ret = info->set_initial_state(pwr);
+		if (ret)
+			dev_warn(dev, "Can't set initial state: %d\n", ret);
+	}
+
+	ret = devm_request_irq(dev, pdev->irq, mid_pwr_irq_handler,
+			       IRQF_NO_SUSPEND, pci_name(pdev), pwr);
+	if (ret)
+		return ret;
+
+	pwr->available = true;
+	midpwr = pwr;
+
+	pci_set_drvdata(pdev, pwr);
+	return 0;
+}
+
+static int tng_set_initial_state(struct mid_pwr *pwr)
+{
+	unsigned int i, j;
+	int ret;
+
+	/*
+	 * Enable wake events.
+	 *
+	 * PMU supports up to 32 sources for wake up the system. Ungate them
+	 * all here.
+	 */
+	mid_pwr_set_wake(pwr, 0, 0xffffffff);
+	mid_pwr_set_wake(pwr, 1, 0xffffffff);
+
+	/*
+	 * Power off South Complex devices.
+	 *
+	 * There is a map (see a note below) of 64 devices with 2 bits per each
+	 * on 32-bit HW registers. The following calls set all devices to one
+	 * known initial state, i.e. PCI_D3hot. This is done in conjunction
+	 * with PMCSR setting in arch/x86/pci/intel_mid_pci.c.
+	 *
+	 * NOTE: The actual device mapping is provided by a platform at run
+	 * time using vendor capability of PCI configuration space.
+	 */
+	mid_pwr_set_state(pwr, 0, 0xffffffff);
+	mid_pwr_set_state(pwr, 1, 0xffffffff);
+	mid_pwr_set_state(pwr, 2, 0xffffffff);
+	mid_pwr_set_state(pwr, 3, 0xffffffff);
+
+	/* Send command to SCU */
+	ret = mid_pwr_wait_for_cmd(pwr, CMD_SET_CFG);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < LSS_MAX_DEVS; i++) {
+		for (j = 0; j < LSS_MAX_SHARED_DEVS; j++)
+			pwr->lss[i][j].state = PCI_D3hot;
+	}
+
+	return 0;
+}
+
+static const struct mid_pwr_device_info tng_info = {
+	.set_initial_state = tng_set_initial_state,
+};
+
+static const struct pci_device_id mid_pwr_pci_ids[] = {
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_TANGIER), (kernel_ulong_t)&tng_info },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, mid_pwr_pci_ids);
+
+static struct pci_driver mid_pwr_pci_driver = {
+	.name		= "intel_mid_pwr",
+	.probe		= mid_pwr_probe,
+	.id_table	= mid_pwr_pci_ids,
+};
+
+builtin_pci_driver(mid_pwr_pci_driver);
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 1fa6925..8db5079 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -51,6 +51,9 @@ obj-$(CONFIG_ACPI)    += pci-acpi.o
 # SMBIOS provided firmware instance and labels
 obj-$(CONFIG_PCI_LABEL) += pci-label.o
 
+# Intel MID platform PM support
+obj-$(CONFIG_X86_INTEL_MID) += pci-mid.o
+
 obj-$(CONFIG_PCI_SYSCALL) += syscall.o
 
 obj-$(CONFIG_PCI_STUB) += pci-stub.o
diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
new file mode 100644
index 0000000..c878aa7
--- /dev/null
+++ b/drivers/pci/pci-mid.c
@@ -0,0 +1,77 @@
+/*
+ * Intel MID platform PM support
+ *
+ * Copyright (C) 2016, Intel Corporation
+ *
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+#include <asm/intel-mid.h>
+
+#include "pci.h"
+
+static bool mid_pci_power_manageable(struct pci_dev *dev)
+{
+	return true;
+}
+
+static int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state)
+{
+	return intel_mid_pci_set_power_state(pdev, state);
+}
+
+static pci_power_t mid_pci_choose_state(struct pci_dev *pdev)
+{
+	return PCI_D3hot;
+}
+
+static int mid_pci_sleep_wake(struct pci_dev *dev, bool enable)
+{
+	return 0;
+}
+
+static int mid_pci_run_wake(struct pci_dev *dev, bool enable)
+{
+	return 0;
+}
+
+static bool mid_pci_need_resume(struct pci_dev *dev)
+{
+	return false;
+}
+
+static struct pci_platform_pm_ops mid_pci_platform_pm = {
+	.is_manageable	= mid_pci_power_manageable,
+	.set_state	= mid_pci_set_power_state,
+	.choose_state	= mid_pci_choose_state,
+	.sleep_wake	= mid_pci_sleep_wake,
+	.run_wake	= mid_pci_run_wake,
+	.need_resume	= mid_pci_need_resume,
+};
+
+#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
+
+static const struct x86_cpu_id lpss_cpu_ids[] = {
+	ICPU(INTEL_FAM6_ATOM_MERRIFIELD1),
+	{}
+};
+
+static int __init mid_pci_init(void)
+{
+	const struct x86_cpu_id *id;
+
+	id = x86_match_cpu(lpss_cpu_ids);
+	if (id)
+		pci_set_platform_pm(&mid_pci_platform_pm);
+	return 0;
+}
+arch_initcall(mid_pci_init);
-- 
2.8.1

