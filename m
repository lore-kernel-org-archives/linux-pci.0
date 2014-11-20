Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:14423 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334AbaKTB4b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Nov 2014 20:56:31 -0500
Message-ID: <546D4891.80503@huawei.com>
Date: Thu, 20 Nov 2014 09:49:05 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Liviu Dudau <liviu@dudau.co.uk>,
	"Tony Luck" <tony.luck@intel.com>,
	Russell King <linux@arm.linux.org.uk>,
	<linux-mips@linux-mips.org>, <linux-sh@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
	<x86@kernel.org>, <sparclinux@vger.kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	<linux-alpha@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] PCI: Rip out pci_bus_add_devices() from pci_scan_root_bus()
References: <1416382369-13587-1-git-send-email-wangyijing@huawei.com> <1416382369-13587-6-git-send-email-wangyijing@huawei.com> <1645037.uypArjN50l@wuerfel>
In-Reply-To: <1645037.uypArjN50l@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
>> index 076c35c..97f9730 100644
>> --- a/arch/alpha/kernel/pci.c
>> +++ b/arch/alpha/kernel/pci.c
>> @@ -334,6 +334,8 @@ common_init_pci(void)
>>  
>>  		bus = pci_scan_root_bus(NULL, next_busno, alpha_mv.pci_ops,
>>  					hose, &resources);
>> +		if (bus)
>> +			pci_bus_add_devices(bus);
>>  		hose->bus = bus;
>>  		hose->need_domain_info = need_domain_info;
>>  		next_busno = bus->busn_res.end + 1;
> 
> How about making pci_bus_add_devices() handle a NULL argument to save
> the if() here and elsewhere?

This make sense, will update it, thanks!

>> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
>> index 1bf60b1..f083688 100644
>> --- a/arch/mips/pci/pci.c
>> +++ b/arch/mips/pci/pci.c
>> @@ -113,6 +113,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
>>  		if (!pci_has_flag(PCI_PROBE_ONLY)) {
>>  			pci_bus_size_bridges(bus);
>>  			pci_bus_assign_resources(bus);
>> +			pci_bus_add_devices(bus);
>>  		}
>>  	}
>>  }
> 
> This one looks wrong, I think you still want to call pci_bus_add_devices()
> even with PCI_PROBE_ONLY set.

Yes, this is my mistake, :(

> 
>> diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
>> index 1f80a88..007466e 100644
>> --- a/arch/tile/kernel/pci.c
>> +++ b/arch/tile/kernel/pci.c
>> @@ -308,6 +308,8 @@ int __init pcibios_init(void)
>>  			pci_add_resource(&resources, &iomem_resource);
>>  			bus = pci_scan_root_bus(NULL, 0, controller->ops,
>>  						controller, &resources);
>> +			if (bus)
>> +				pci_bus_add_devices(bus);
>>  			controller->root_bus = bus;
>>  			controller->last_busno = bus->busn_res.end;
>>  		}
> 
> Should the pci_bus_add_devices come after setting the bus numbers here?

I think it's doesn't matter, but move it backward is ok to me.

> 
> 	Arnd
> 
> .
> 


-- 
Thanks!
Yijing

