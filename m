Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:36364 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbdL0BdJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Dec 2017 20:33:09 -0500
Message-ID: <5A42F847.5060305@rock-chips.com>
Date: Wed, 27 Dec 2017 09:32:55 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Rob Herring <robh@kernel.org>
CC: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        rjw@rjwysocki.net, dianders@chromium.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        andriy.shevchenko@linux.intel.com
Subject: Re: [RFC PATCH v12 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com> <20171226023646.17722-5-jeffy.chen@rock-chips.com> <20171226235607.4rgp4ebrrktt6d56@rob-hp-laptop>
In-Reply-To: <20171226235607.4rgp4ebrrktt6d56@rob-hp-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

Thanks for your reply.

On 12/27/2017 07:56 AM, Rob Herring wrote:
>> >
>> >  drivers/of/of_pci_irq.c  | 49 +++++++++++++++++++++++++++++++
> Please move this to drivers/pci/of.c (or perhaps create pci/of_irq.c).
>
>> >  drivers/pci/Makefile     |  1 +
>> >  drivers/pci/pci-driver.c | 10 +++++++
>> >  drivers/pci/pci-of.c     | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
> We already have drivers/pci/of.c. It's not clear what the difference is
> from the filenames. Either merge with of.c or perhaps of-pm.c.

this new file does something similar to the pci-acpi.c and pci-mid.c..

and i am agree the naming is not clear, maybe we can rename both of 
those files to something like pci-pm-***.c?

Hi Rafael, do you think this would make sense?

>> >  include/linux/of_pci.h   |  9 ++++++
>> >  5 files changed, 144 insertions(+)
>> >  create mode 100644 drivers/pci/pci-of.c
>> >
>> >diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
>> >index d39565d5477b..abec3a44853b 100644
>> >--- a/drivers/of/of_pci_irq.c
>> >+++ b/drivers/of/of_pci_irq.c
>> >@@ -1,8 +1,57 @@
>> >  #include <linux/kernel.h>
>> >  #include <linux/of_pci.h>
>> >  #include <linux/of_irq.h>
>> >+#include <linux/pm_wakeirq.h>
>> >  #include <linux/export.h>
>> >
>> >+int of_pci_setup_wake_irq(struct pci_dev *pdev)
>> >+{
>> >+	struct pci_dev *ppdev;
>> >+	struct device_node *dn;
>> >+	int ret, irq;
>> >+
>> >+	/* Get the pci_dev of our parent. Hopefully it's a port. */
>> >+	ppdev = pdev->bus->self;
>> >+	/* Nope, it's a host bridge. */
>> >+	if (!ppdev)
>> >+		return 0;
>> >+
>> >+	dn = pci_device_to_OF_node(ppdev);
>> >+	if (!dn)
>> >+		return 0;
>> >+
>> >+	irq = of_irq_get_byname(dn, "wakeup");
>> >+	if (irq == -EPROBE_DEFER) {
>> >+		return irq;
>> >+	} else if (irq < 0) {
>> >+		/* Ignore other errors, since a missing wakeup is non-fatal. */
>> >+		dev_info(&pdev->dev, "cannot get wakeup interrupt: %d\n", irq);
>> >+		return 0;
>> >+	}
>> >+
>> >+	device_init_wakeup(&pdev->dev, true);
>> >+
>> >+	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, irq);
>> >+	if (ret < 0) {
>> >+		dev_err(&pdev->dev, "failed to set wake IRQ: %d\n", ret);
>> >+		device_init_wakeup(&pdev->dev, false);
>> >+		return ret;
>> >+	}
>> >+
>> >+	/* Start out disabled to avoid irq storm */
>> >+	dev_pm_disable_wake_irq(&pdev->dev);
>> >+
>> >+	return 0;
>> >+}
>> >+EXPORT_SYMBOL_GPL(of_pci_setup_wake_irq);
>> >+
>> >+void of_pci_teardown_wake_irq(struct pci_dev *pdev)
>> >+{
>> >+	dev_pm_clear_wake_irq(&pdev->dev);
>> >+	device_init_wakeup(&pdev->dev, false);
>> >+}
>> >+EXPORT_SYMBOL_GPL(of_pci_teardown_wake_irq);
>> >+
>> >  /**
>> >   * of_irq_parse_pci - Resolve the interrupt for a PCI device
>> >   * @pdev:       the device whose interrupt is to be resolved
>> >diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> >index c7819b973df7..d0182c82162a 100644
>> >--- a/drivers/pci/Makefile
>> >+++ b/drivers/pci/Makefile
>> >@@ -29,6 +29,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
>> >  # ACPI _DSM provided firmware instance and string name
>> >  #
>> >  obj-$(CONFIG_ACPI)    += pci-acpi.o
>> >+obj-$(CONFIG_OF)      += pci-of.o
>> >
>> >  # SMBIOS provided firmware instance and labels
>> >  obj-$(CONFIG_PCI_LABEL) += pci-label.o
>> >diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> >index d79dbc377b9c..b4475ff35d97 100644
>> >--- a/drivers/pci/pci-driver.c
>> >+++ b/drivers/pci/pci-driver.c
>> >@@ -17,6 +17,7 @@
>> >  #include <linux/slab.h>
>> >  #include <linux/sched.h>
>> >  #include <linux/cpu.h>
>> >+#include <linux/of_pci.h>
>> >  #include <linux/pm_runtime.h>
>> >  #include <linux/suspend.h>
>> >  #include <linux/kexec.h>
>> >@@ -421,10 +422,17 @@ static int pci_device_probe(struct device *dev)
>> >  	if (error < 0)
>> >  		return error;
>> >
>> >+	error = of_pci_setup_wake_irq(pci_dev);
>> >+	if (error < 0) {
>> >+		pcibios_free_irq(pci_dev);
>> >+		return error;
>> >+	}
>> >+
>> >  	pci_dev_get(pci_dev);
>> >  	if (pci_device_can_probe(pci_dev)) {
>> >  		error = __pci_device_probe(drv, pci_dev);
>> >  		if (error) {
>> >+			of_pci_teardown_wake_irq(pci_dev);
>> >  			pcibios_free_irq(pci_dev);
>> >  			pci_dev_put(pci_dev);
>> >  		}
>> >@@ -438,6 +446,8 @@ static int pci_device_remove(struct device *dev)
>> >  	struct pci_dev *pci_dev = to_pci_dev(dev);
>> >  	struct pci_driver *drv = pci_dev->driver;
>> >
>> >+	of_pci_teardown_wake_irq(pci_dev);
>> >+
>> >  	if (drv) {
>> >  		if (drv->remove) {
>> >  			pm_runtime_get_sync(dev);
>> >diff --git a/drivers/pci/pci-of.c b/drivers/pci/pci-of.c
>> >new file mode 100644
>> >index 000000000000..ad413b2de508
>> >--- /dev/null
>> >+++ b/drivers/pci/pci-of.c
>> >@@ -0,0 +1,75 @@
>> >+/*
>> >+ * File:	pci-of.c
>> >+ * Purpose:	Provide PCI PM/wakeup support in OF systems
>> >+ *
>> >+ * Copyright (C) 2017 Google, Inc.
>> >+ *	Brian Norris<briannorris@chromium.org>
>> >+ *
>> >+ * Copyright (C) 2017 Rockchip Electronics Co., Ltd.
>> >+ *	Jeffy Chen<jeffy.chen@rock-chips.com>
>> >+ *
>> >+ * This program is free software; you can redistribute it and/or modify it
>> >+ * under the terms and conditions of the GNU General Public License,
>> >+ * version 2, as published by the Free Software Foundation.
>> >+ */
>> >+
>> >+#include <linux/acpi.h>
>> >+#include <linux/init.h>
>> >+#include <linux/module.h>
>> >+#include <linux/pci.h>
>> >+#include <linux/pm_wakeirq.h>
>> >+#include "pci.h"
>> >+
>> >+static bool of_pci_power_manageable(struct pci_dev *dev)
>> >+{
>> >+	return false;
>> >+}
>> >+
>> >+static int of_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>> >+{
>> >+	return -ENOSYS;
>> >+}
>> >+
>> >+static pci_power_t of_pci_get_power_state(struct pci_dev *dev)
>> >+{
>> >+	return PCI_UNKNOWN;
>> >+}
>> >+
>> >+static pci_power_t of_pci_choose_state(struct pci_dev *pdev)
>> >+{
>> >+	return PCI_POWER_ERROR;
>> >+}
>> >+
>> >+static int of_pci_wakeup(struct pci_dev *dev, bool enable)
>> >+{
>> >+	if (enable)
>> >+		dev_pm_enable_wake_irq(&dev->dev);
>> >+	else
>> >+		dev_pm_disable_wake_irq(&dev->dev);
>> >+	return 0;
>> >+}
>> >+
>> >+static bool of_pci_need_resume(struct pci_dev *dev)
>> >+{
>> >+	return false;
>> >+}
>> >+
>> >+static const struct pci_platform_pm_ops of_pci_platform_pm = {
>> >+	.is_manageable = of_pci_power_manageable,
>> >+	.set_state = of_pci_set_power_state,
>> >+	.get_state = of_pci_get_power_state,
>> >+	.choose_state = of_pci_choose_state,
>> >+	.set_wakeup = of_pci_wakeup,
>> >+	.need_resume = of_pci_need_resume,
>> >+};
>> >+
>> >+static int __init of_pci_init(void)
>> >+{
>> >+	if (!acpi_disabled)
>> >+		return 0;
>> >+
>> >+	pci_set_platform_pm(&of_pci_platform_pm);
> I guess no DT based system will override this?

i think the !acpi_disabled means acpi been disabled or CONFIG_ACPI is 
undefined.

and pci-acpi.c would only work when we have CONFIG_ACPI.

but i have no idea about pci-mid.c or would it possible to have more 
platform pm ops in the future...maybe we should add some dependency in 
the Kconfig?

>
