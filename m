Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:48574 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbCKBMC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 21:12:02 -0400
Message-ID: <54FF9655.7080604@huawei.com>
Date: Wed, 11 Mar 2015 09:11:49 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>
CC: Arnd Bergmann <arnd@arndb.de>, Hauke Mehrtens <hauke@hauke-m.de>,
	"Paul Bolle" <pebolle@tiscali.nl>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"Dmitry Torokhov" <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<devicetree@vger.kernel.org>, "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH v5 3/4] pci: iproc: Add Broadcom iProc PCIe support
References: <1425947886-23705-1-git-send-email-rjui@broadcom.com> <1425947886-23705-4-git-send-email-rjui@broadcom.com> <20150310214010.GB32204@google.com>
In-Reply-To: <20150310214010.GB32204@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

...
>> +	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
>> +				  &pcie->sysdata, pcie->resources);
>> +	if (!bus) {
>> +		dev_err(pcie->dev, "unable to create PCI root bus\n");
>> +		ret = -ENOMEM;
>> +		goto err_power_off_phy;
>> +	}
>> +	pcie->root_bus = bus;
>> +
>> +	ret = iproc_pcie_check_link(pcie, bus);
>> +	if (ret) {
>> +		dev_err(pcie->dev, "no PCIe EP device detected\n");
>> +		goto err_rm_root_bus;
>> +	}
>> +
>> +	iproc_pcie_enable(pcie);
>> +
>> +	pci_scan_child_bus(bus);
>> +	pci_assign_unassigned_bus_resources(bus);
>> +	pci_bus_add_devices(bus);
>> +
>> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> 
> I think the IRQ fixup should be before pci_bus_add_devices().  CC'd Yijing,
> who's been fixing similar issues.
> 
> pci_bus_add_devices() is the point where drivers can claim these devices,
> and we don't want to change things after a driver claims the device.

Yes, we should call pci_bus_add_devices() at last, after all resources(mem/io/irq) are
configured properly. Otherwise, this code could not be run normally in non system boot up path.

Thanks!
Yijing.


> 
>> +
>> +	return 0;
>> +
>> +err_rm_root_bus:
>> +	pci_stop_root_bus(bus);
>> +	pci_remove_root_bus(bus);
>> +
>> +err_power_off_phy:
>> +	if (pcie->phy)
>> +		phy_power_off(pcie->phy);
>> +err_exit_phy:
>> +	if (pcie->phy)
>> +		phy_exit(pcie->phy);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(iproc_pcie_setup);
>> +
>> +int iproc_pcie_remove(struct iproc_pcie *pcie)
>> +{
>> +	pci_stop_root_bus(pcie->root_bus);
>> +	pci_remove_root_bus(pcie->root_bus);
>> +
>> +	if (pcie->phy) {
>> +		phy_power_off(pcie->phy);
>> +		phy_exit(pcie->phy);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(iproc_pcie_remove);
> 
> These exports wouldn't be needed if this were all squashed into one file.
> 
>> +
>> +MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
>> +MODULE_DESCRIPTION("Broadcom iPROC PCIe common driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
>> new file mode 100644
>> index 0000000..569bc04
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-iproc.h
>> @@ -0,0 +1,42 @@
>> +/*
>> + * Copyright (C) 2014-2015 Broadcom Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef _PCIE_IPROC_H
>> +#define _PCIE_IPROC_H
>> +
>> +#define IPROC_PCIE_MAX_NUM_IRQS 6
>> +
>> +/**
>> + * iProc PCIe device
>> + * @dev: pointer to device data structure
>> + * @base: PCIe host controller I/O register base
>> + * @resources: linked list of all PCI resources
>> + * @sysdata: Per PCI controller data
>> + * @root_bus: pointer to root bus
>> + * @phy: optional PHY device that controls the Serdes
>> + * @irqs: interrupt IDs
>> + */
>> +struct iproc_pcie {
>> +	struct device *dev;
>> +	void __iomem *base;
>> +	struct list_head *resources;
>> +	struct pci_sys_data sysdata;
>> +	struct pci_bus *root_bus;
>> +	struct phy *phy;
>> +	int irqs[IPROC_PCIE_MAX_NUM_IRQS];
>> +};
>> +
>> +extern int iproc_pcie_setup(struct iproc_pcie *pcie);
>> +extern int iproc_pcie_remove(struct iproc_pcie *pcie);
> 
> Hopefully you can squash this all into one file, but if you can't, my
> preference is to omit "extern" on function declarations.
> 
>> +
>> +#endif /* _PCIE_IPROC_H */
>> -- 
>> 1.7.9.5
>>
> 
> .
> 


-- 
Thanks!
Yijing

