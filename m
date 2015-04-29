Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:19421 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031140AbbD2BKP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2015 21:10:15 -0400
Message-ID: <55402F27.3080204@huawei.com>
Date: Wed, 29 Apr 2015 09:08:55 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <dja@axtens.net>,
	Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH Part1 v11 5/5] PCI: iproc: Use pci_scan_root_bus() instead
 of pci_create_root_bus()
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com> <1430204499-19571-6-git-send-email-wangyijing@huawei.com> <553FB772.1000202@broadcom.com>
In-Reply-To: <553FB772.1000202@broadcom.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> @@ -210,10 +210,10 @@ int iproc_pcie_setup(struct iproc_pcie *pcie)
>>  
>>  	pcie->sysdata.private_data = pcie;
>>  
>> -	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
>> +	bus = pci_scan_root_bus(pcie->dev, 0, &iproc_pcie_ops,
>>  				  &pcie->sysdata, pcie->resources);
>>  	if (!bus) {
>> -		dev_err(pcie->dev, "unable to create PCI root bus\n");
>> +		dev_err(pcie->dev, "unable to scan PCI root bus\n");
>>  		ret = -ENOMEM;
>>  		goto err_power_off_phy;
>>  	}
> 
> iproc_pcie_check_link is called here by using the 'bus' structure
> returned from pci_create_root_bus. In iproc_pcie_check_link, we
> configure root bus class to PCI_CLASS_BRIDGE_PCI and validate to ensure
> a stable link between RC and EP can be detected.

Oh, I got it. Thanks for your explanation.

> 
>> @@ -227,7 +227,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie)
>>  
>>  	iproc_pcie_enable(pcie);
> 
> Here we enable INTx support for our RC controller.
> 
>>  
>> -	pci_scan_child_bus(bus);
> 
> Here, if pci_scan_child_bus is moved to before iproc_pcie_check_link, I
> don't think it would work (although I have not tested this).
> 
> An alternative is to use a dummy bus structure to feed into
> iproc_pcie_check_link, and call iproc_pcie_check_link and
> iproc_pcie_enable before pci_scan_root_bus. But the reason I put the
> link check code in between pci_create_root_bus and pci_scan_child_bus
> was to avoid using a dummy bus structure, :)

Maybe we could refactor this by add a new pci_host_bridge_ops in the later patch.

> 
>>  	pci_assign_unassigned_bus_resources(bus);
>>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>>  	pci_bus_add_devices(bus);
>>
> 
> Thanks,
> 
> Ray
> 
> .
> 


-- 
Thanks!
Yijing

