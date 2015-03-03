Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:29908 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbbCCDdz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2015 22:33:55 -0500
Message-ID: <54F52B8B.1010309@huawei.com>
Date: Tue, 3 Mar 2015 11:33:31 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>, <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>, <x86@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Guan Xuetao" <gxt@mprc.pku.edu.cn>, <linux-alpha@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, Liviu Dudau <liviu@dudau.co.uk>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
	<xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v4 03/30] xen/PCI: Don't use deprecated function pci_scan_bus_parented()
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com> <1424938344-4017-4-git-send-email-wangyijing@huawei.com> <20150303020249.GC11978@google.com>
In-Reply-To: <20150303020249.GC11978@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> --- a/drivers/pci/xen-pcifront.c
>> +++ b/drivers/pci/xen-pcifront.c
>> @@ -446,6 +446,7 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
>>  				 unsigned int domain, unsigned int bus)
>>  {
>>  	struct pci_bus *b;
>> +	LIST_HEAD(resources);
>>  	struct pcifront_sd *sd = NULL;
>>  	struct pci_bus_entry *bus_entry = NULL;
>>  	int err = 0;
>> @@ -470,17 +471,20 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
>>  		err = -ENOMEM;
>>  		goto err_out;
>>  	}
>> +	pci_add_resource(&resources, &ioport_resource);
>> +	pci_add_resource(&resources, &iomem_resource);
> 
> This doesn't add &busn_resource like pci_scan_bus_parented() does.
> That might be OK, but I think we'll now emit "No busn resource found for
> root bus, will use [bus %02x-ff]" when we didn't before.  I don't know how
> xen-pcifront works; it would be nice if it could supply the correct
> bus resource (and ioport and iomem).

Because the pci_scan_bus_parented() add the default busn_resource for it,
I would add the default busn_resource in pcifront_scan_root() too to fix the
"No busn resource found ..." debug info.

> 
>>  	pcifront_init_sd(sd, domain, bus, pdev);
>>  
>>  	pci_lock_rescan_remove();
>>  
>> -	b = pci_scan_bus_parented(&pdev->xdev->dev, bus,
>> -				  &pcifront_bus_ops, sd);
>> +	b = pci_scan_root_bus(&pdev->xdev->dev, bus,
>> +				  &pcifront_bus_ops, sd, &resources);
>>  	if (!b) {
>>  		dev_err(&pdev->xdev->dev,
>>  			"Error creating PCI Frontend Bus!\n");
>>  		err = -ENOMEM;
>>  		pci_unlock_rescan_remove();
>> +		pci_free_resource_list(&resources);
>>  		goto err_out;
>>  	}
>>  
>> @@ -488,7 +492,7 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
>>  
>>  	list_add(&bus_entry->list, &pdev->root_buses);
>>  
>> -	/* pci_scan_bus_parented skips devices which do not have a have
>> +	/* pci_scan_root_bus skips devices which do not have a have
> 
> Please fix the comment typo at the same time ("have a have").

Ok.

> 
>>  	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
>>  	err = pcifront_scan_bus(pdev, domain, bus, b);
>>  
>> -- 
>> 1.7.1
>>
> 
> .
> 


-- 
Thanks!
Yijing

