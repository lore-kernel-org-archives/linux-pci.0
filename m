Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:57261 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbaESRDM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 13:03:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Srikanth Thokala <sthokal@xilinx.com>
Cc: bhelgaas@google.com, will.deacon@arm.com, michals@xilinx.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Generic Configuration Access Mechanism support
Date: Mon, 19 May 2014 19:03:04 +0200
Message-ID: <4223392.yrWc3QAXY9@wuerfel>
In-Reply-To: <1400422125-2209-1-git-send-email-sthokal@xilinx.com>
References: <1400422125-2209-1-git-send-email-sthokal@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday 18 May 2014 19:38:45 Srikanth Thokala wrote:
> +
> +	if (cfg->ops->is_valid_cfg_access) {
> +		if (!cfg->ops->is_valid_cfg_access(bus, devfn)) {
> +			*val = PCI_CFG_INVALID_DEVFN;
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		}
> +	}

Can you explain why this callback is needed? If the space for the
bus is mapped, any access should just work.

> +
> +/* Generic PCI CAM/ECAM Configuration Bus Operations */
> +
> +struct pci_cfg_bus_ops pci_cfg_cam_bus_ops = {
> +	.bus_shift	= PCI_CFG_CAM_BUS_NUM,
> +	.map_bus	= pci_cfg_map_bus_cam,
> +};
> +EXPORT_SYMBOL_GPL(pci_cfg_cam_bus_ops);
> +
> +struct pci_cfg_bus_ops pci_cfg_ecam_bus_ops = {
> +	.bus_shift	= PCI_CFG_ECAM_BUS_NUM,
> +	.map_bus	= pci_cfg_map_bus_ecam,
> +};
> +EXPORT_SYMBOL_GPL(pci_cfg_ecam_bus_ops);
> +
> +struct pci_ops pci_cfg_ops = {
> +	.read	= pci_cfg_read,
> +	.write	= pci_cfg_write,
> +};
> +EXPORT_SYMBOL_GPL(pci_cfg_ops);


If we can find a way to remove the is_valid_cfg_access() check, we're
probably better off removing the cfg_bus_ops as well, and exporting
two sets of pci_ops. There will be a little more duplication here, but
also less complexity in this module, and more importantly in the drivers
using it.

	Arnd
