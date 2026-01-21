Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604CB346FB6;
	Wed, 21 Jan 2026 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011192; cv=none; b=CwpaoTS3aDmMKEL40U9c/ZEzN/UFNmU8TIsyh/cbkqxUZcwhGa0jh6ncl0YqUu29mTO43qdzUP2PpbMzdQCkdKLSuQ+mgSZaZfDi4Mdm4D34FEbvTJnksi3AnLXuj9VvSFVR0sJyoNXAGRixts48kabfz5P5wnJSVBhwX+oT90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011192; c=relaxed/simple;
	bh=usHGDMZ/vMHEEvAJccvvzwzAwA3cjWYxiyGVJDun3PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVKT2nhips1eHXc5bR22MavIAmTiu+cjWB4moY9Rwt5QXL259NKC1ZflJO+mp1gUZPAiKIHT4mpZA6SHsiirud48TKv4DwEp3tLdXO/kJlddOeNpCH+TABhpWdFyVgPJuBqNVAynaVOgwQWBIq0qTCFmIgWg7Bl68EQ3ID/C5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxzfuRVX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxzfuRVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA1AC4CEF1;
	Wed, 21 Jan 2026 15:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769011191;
	bh=usHGDMZ/vMHEEvAJccvvzwzAwA3cjWYxiyGVJDun3PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxzfuRVXPzBkz5BlFZYO535bJ4pzbIyAC1G5khV3STAFQ/ZtOKyEONKKZy2CbWlIa
	 A9QkdM9N36+FGqBfXXNL51HsvXKdcHmQhviY/kFYHc7dRFFd0G04Oazm/ol62mmOt0
	 H4Hk5bAjY0W5rC6F+/P18AfGlbEdA3TzzC2EHJsHWHrktHUy1dGX4OCek2SQqUo5Ys
	 WnKzd7O8V67sQyRUhWrUzsVqWPWgPvH8Rwf9SvqO/sNoMo3pPbxhBH4v9znqiH+BW/
	 n6MA5SVUYTQ+/e+j+79wfwuq00YCiLDKR8FNfZzXb5nEcZrkXnsDI0Q/l3/WAE3pap
	 QGCwv3A7yhcmQ==
Date: Wed, 21 Jan 2026 21:29:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Pragnesh Patel <pragneshp@marvell.com>
Cc: gcherian@marvell.com, Suneel Garapati <sgarapati@marvell.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: octeon: Add link down handler support for PCIe MAC
 controller
Message-ID: <wj2x7viy7o2yoj6r3dfgjurtigifmoingm7yhypvmdn2nltkvo@kf3e4hbzphy7>
References: <20260121051439.1882086-1-pragneshp@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121051439.1882086-1-pragneshp@marvell.com>

On Tue, Jan 20, 2026 at 09:14:29PM -0800, Pragnesh Patel wrote:
> From: Suneel Garapati <sgarapati@marvell.com>
> 
> This driver adds support for link-down interrupt in PCIe MAC (PEM)
> controller in Root complex mode to support hot-plug removal of
> endpoint devices.
> 

What is this device actually? Is this really a Root Complex device? Root complex
(host bridge) is the one that exposes the Root bus and not gets plugged into the
bus. This looks very strange.

> An interrupt handler is registered for RST_INT msix vector
> which is triggered with link going down. This handler
> performs cleanup of root bridge and its children and
> re-initializes root bridge to kernel for next link-up event.
> 

I have a series [1] (needs respin) that allows the controller drivers to reset
the Root Ports in the event of link down. You might want to take a look at that.
I'll try to respin asap.

- Mani

[1] https://lore.kernel.org/linux-pci/20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com/

> Signed-off-by: Suneel Garapati <sgarapati@marvell.com>
> Signed-off-by: Pragnesh Patel <pragneshp@marvell.com>
> ---
>  MAINTAINERS                             |   6 +
>  drivers/pci/controller/Kconfig          |   9 +
>  drivers/pci/controller/Makefile         |   1 +
>  drivers/pci/controller/pci-octeon-pem.c | 278 ++++++++++++++++++++++++
>  4 files changed, 294 insertions(+)
>  create mode 100644 drivers/pci/controller/pci-octeon-pem.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1b020588597..9af8f676c027 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15363,6 +15363,12 @@ R:	Vamsi Attunuru <vattunuru@marvell.com>
>  S:	Supported
>  F:	drivers/pci/hotplug/octep_hp.c
>  
> +MARVELL OCTEON PEM CONTROLLER DRIVER
> +R:	George Cherian <gcherian@marvell.com>
> +R:	Pragnesh Patel <pragneshp@marvell.com>
> +S:	Supported
> +F:	drivers/pci/controller/pci-octeon-pem.c
> +
>  MATROX FRAMEBUFFER DRIVER
>  L:	linux-fbdev@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index c254d2b8bf17..5251dc8b1188 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -231,6 +231,15 @@ config PCI_HYPERV_INTERFACE
>  	  drivers to have a common interface with the Hyper-V PCI frontend
>  	  driver.
>  
> +config PCI_OCTEON_PEM
> +	bool "Marvell Octeon PEM (PCIe MAC) controller"
> +	depends on ARM64 || COMPILE_TEST
> +	depends on PCI_MSI
> +	depends on HOTPLUG_PCI_PCIE
> +	help
> +	  Say Y here if you want PEM controller support for Marvell ARM64 Octeon SoCs
> +	  in root complex mode.
> +
>  config PCI_TEGRA
>  	bool "NVIDIA Tegra PCIe controller"
>  	depends on ARCH_TEGRA || COMPILE_TEST
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 229929a945c2..dd1dab50dd07 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_PCI_V3_SEMI) += pci-v3-semi.o
>  obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
>  obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
> +obj-$(CONFIG_PCI_OCTEON_PEM) += pci-octeon-pem.o
>  obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
>  obj-$(CONFIG_PCIE_IPROC_MSI) += pcie-iproc-msi.o
>  obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
> diff --git a/drivers/pci/controller/pci-octeon-pem.c b/drivers/pci/controller/pci-octeon-pem.c
> new file mode 100644
> index 000000000000..2d67e2b16e9e
> --- /dev/null
> +++ b/drivers/pci/controller/pci-octeon-pem.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Octeon PEM driver
> + *
> + * Copyright (C) 2021 Marvell.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/sysfs.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#include "../hotplug/pciehp.h"
> +#include "../pci.h"
> +
> +#define DRV_NAME	"octeon-pem"
> +#define DRV_VERSION	"1.0"
> +
> +#define PCI_DEVID_OCTEON_PEM	0xA06C
> +
> +#define ID_SHIFT		36
> +#define DOMAIN_OFFSET		0x3
> +#define ON_OFFSET		0xE0
> +#define RST_SOFT_PERST_OFFSET	0x298
> +#define RST_INT_OFFSET		0x300
> +#define RST_INT_ENA_W1C_OFFSET	0x310
> +#define RST_INT_ENA_W1S_OFFSET	0x318
> +#define RST_INT_LINKDOWN	BIT(1)
> +
> +struct pem_ctlr {
> +	int			index;
> +	char			irq_name[32];
> +	void __iomem		*base;
> +	struct pci_dev		*pdev;
> +	struct work_struct	recover_rc_work;
> +};
> +
> +static struct pcie_device *to_pciehp_dev(struct pci_dev *dev)
> +{
> +	struct device *device;
> +
> +	device = pcie_port_find_device(dev, PCIE_PORT_SERVICE_HP);
> +	if (!device)
> +		return NULL;
> +	return to_pcie_device(device);
> +}
> +
> +static void pem_recover_rc_link(struct work_struct *ws)
> +{
> +	struct pem_ctlr *pem = container_of(ws, struct pem_ctlr,
> +					    recover_rc_work);
> +	struct pci_dev *pem_dev = pem->pdev;
> +	struct pci_dev *root_port;
> +	struct pci_bus *bus;
> +	struct pcie_device *pcie;
> +	struct controller *ctrl;
> +	int rc_domain, timeout = 100;
> +	u64 pem_reg;
> +
> +	rc_domain = pem->index + DOMAIN_OFFSET;
> +
> +	root_port = pci_get_domain_bus_and_slot(rc_domain, 0, 0);
> +	if (!root_port) {
> +		dev_err(&pem_dev->dev, "failed to get root port\n");
> +		return;
> +	}
> +
> +	dev_dbg(&pem_dev->dev, "PEM%d rcvr work\n", pem->index);
> +
> +	/* Check if HP interrupt thread is in progress
> +	 * and wait for it to complete
> +	 */
> +	pcie = to_pciehp_dev(root_port);
> +	if (!pcie)
> +		return;
> +	ctrl = get_service_data(pcie);
> +	wait_event(ctrl->requester,
> +		   !atomic_read(&ctrl->pending_events) &&
> +		   !ctrl->ist_running);
> +	dev_dbg(&pem_dev->dev, "PEM%d HP ist done\n", pem->index);
> +
> +	/* Disable hot-plug interrupt
> +	 * Removal and rescan below would setup again.
> +	 */
> +	pcie_disable_interrupt(ctrl);
> +	dev_dbg(&pem_dev->dev, "PEM%d Disable interrupt\n", pem->index);
> +
> +	pci_lock_rescan_remove();
> +
> +	pci_walk_bus(root_port->subordinate, pci_dev_set_disconnected, NULL);
> +
> +	/* Clean-up device and RC bridge */
> +	pci_stop_and_remove_bus_device(root_port);
> +
> +	pci_unlock_rescan_remove();
> +
> +	usleep_range(100, 200);
> +
> +	writeq(0x0, pem->base + RST_SOFT_PERST_OFFSET);
> +
> +	while (timeout--) {
> +		/* Check for PEM_OOR to be set */
> +		pem_reg = readq(pem->base + ON_OFFSET);
> +		if (pem_reg & BIT(1))
> +			break;
> +		usleep_range(1000, 2000);
> +	}
> +	if (!timeout) {
> +		dev_warn(&pem_dev->dev,
> +			 "PEM failed to get out of reset\n");
> +		return;
> +	}
> +
> +	pci_lock_rescan_remove();
> +
> +	/*
> +	 * Hardware resets and initializes config space of RC bridge
> +	 * on every link down event with auto-mode in use.
> +	 * Re-scan will setup RC bridge cleanly in kernel
> +	 * after removal and to be ready for next link-up event.
> +	 */
> +	bus = NULL;
> +	while ((bus = pci_find_next_bus(bus)) != NULL)
> +		if (bus->domain_nr == rc_domain)
> +			pci_rescan_bus(bus);
> +	pci_unlock_rescan_remove();
> +	pci_dev_put(root_port);
> +
> +	/* Ack interrupt */
> +	writeq(RST_INT_LINKDOWN, pem->base + RST_INT_OFFSET);
> +	/* Enable RST_INT[LINKDOWN] interrupt */
> +	writeq(RST_INT_LINKDOWN, pem->base + RST_INT_ENA_W1S_OFFSET);
> +}
> +
> +static irqreturn_t pem_irq_handler(int irq, void *dev_id)
> +{
> +	struct pem_ctlr *pem = (struct pem_ctlr *)dev_id;
> +
> +	/* Disable RST_INT[LINKDOWN] interrupt */
> +	writeq(RST_INT_LINKDOWN, pem->base + RST_INT_ENA_W1C_OFFSET);
> +	schedule_work(&pem->recover_rc_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pem_register_interrupts(struct pci_dev *pdev)
> +{
> +	struct pem_ctlr *pem = pci_get_drvdata(pdev);
> +	int nvec, err;
> +
> +	nvec = pci_msix_vec_count(pdev);
> +	/* Some earlier silicon versions do not support RST vector
> +	 * so check on table size before registering otherwise
> +	 * return with info message.
> +	 */
> +	if (nvec != 10) {
> +		dev_info(&pdev->dev,
> +			 "No RST MSI-X vector support on silicon\n");
> +		return 0;
> +	}
> +	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed %d\n",
> +			nvec);
> +		return -ENOSPC;
> +	}
> +
> +	snprintf(pem->irq_name, 32, "PEM%d RST_INT", pem->index);
> +
> +	/* register interrupt for RST_INT */
> +	return devm_request_irq(&pdev->dev, pci_irq_vector(pdev, 9),
> +				pem_irq_handler, 0,
> +				pem->irq_name, pem);
> +}
> +
> +static int pem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pem_ctlr *pem;
> +	struct pci_dev *root_port;
> +	int err, rc_domain;
> +
> +	pem = devm_kzalloc(dev, sizeof(struct pem_ctlr), GFP_KERNEL);
> +	if (!pem)
> +		return -ENOMEM;
> +
> +	pem->pdev = pdev;
> +	pci_set_drvdata(pdev, pem);
> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(dev, "Failed to enable PCI device\n");
> +		goto enable_failed;
> +	}
> +
> +	err = pci_request_regions(pdev, DRV_NAME);
> +	if (err) {
> +		dev_err(dev, "PCI request regions failed 0x%x\n", err);
> +		goto region_failed;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	/* CSR Space mapping */
> +	pem->base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
> +	if (!pem->base) {
> +		dev_err(&pdev->dev, "Unable to map BAR0\n");
> +		err = -ENODEV;
> +		goto bar0_map_failed;
> +	}
> +	pem->index = ((u64)pci_resource_start(pdev, 0) >> ID_SHIFT) & 0xf;
> +
> +	rc_domain = pem->index + DOMAIN_OFFSET;
> +
> +	root_port = pci_get_domain_bus_and_slot(rc_domain, 0, 0);
> +	if (!root_port) {
> +		dev_err(&pdev->dev, "failed to get root port\n");
> +		goto bar0_map_failed;
> +	}
> +	if (!root_port->is_hotplug_bridge) {
> +		dev_info(&pdev->dev, "Hot-plug disabled skip registration\n");
> +		goto bar0_map_failed;
> +	}
> +
> +	err = pem_register_interrupts(pdev);
> +	if (err < 0) {
> +		dev_err(dev, "Register interrupt failed\n");
> +		goto irq_failed;
> +	}
> +
> +	INIT_WORK(&pem->recover_rc_work, pem_recover_rc_link);
> +
> +	/* Enable RST_INT[LINKDOWN] interrupt */
> +	writeq(RST_INT_LINKDOWN, pem->base + RST_INT_ENA_W1S_OFFSET);
> +
> +	dev_info(&pdev->dev, "PEM%d probed\n", pem->index);
> +	return 0;
> +
> +irq_failed:
> +bar0_map_failed:
> +	pci_release_regions(pdev);
> +region_failed:
> +enable_failed:
> +	pci_set_drvdata(pdev, NULL);
> +	return err;
> +}
> +
> +static void pem_remove(struct pci_dev *pdev)
> +{
> +	pci_release_regions(pdev);
> +}
> +
> +/* Supported devices */
> +static const struct pci_device_id pem_id_table[] = {
> +	{PCI_VDEVICE(CAVIUM, PCI_DEVID_OCTEON_PEM)},
> +	{0} /* end of table */
> +};
> +
> +static struct pci_driver pem_driver = {
> +	.name = DRV_NAME,
> +	.id_table = pem_id_table,
> +	.probe = pem_probe,
> +	.remove = pem_remove,
> +};
> +
> +module_pci_driver(pem_driver);
> +
> +MODULE_AUTHOR("Marvell Inc.");
> +MODULE_DESCRIPTION("Marvell Octeon PEM Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> +MODULE_DEVICE_TABLE(pci, pem_id_table);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்
