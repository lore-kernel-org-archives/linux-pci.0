Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:29455 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136AbbCLNRT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2015 09:17:19 -0400
Message-ID: <550191D0.3050707@huawei.com>
Date: Thu, 12 Mar 2015 21:17:04 +0800
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
	<sparclinux@vger.kernel.org>
Subject: Re: [PATCH v6 20/30] sparc/PCI: Use pci_scan_host_bridge() for simplicity
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com> <1425868467-9667-21-git-send-email-wangyijing@huawei.com> <20150312033050.GG10949@google.com>
In-Reply-To: <20150312033050.GG10949@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> @@ -667,22 +680,21 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
>>  	pbm->busn.end	= pbm->pci_last_busno;
>>  	pbm->busn.flags	= IORESOURCE_BUS;
>>  	pci_add_resource(&resources, &pbm->busn);
>> -	bus = pci_create_root_bus(parent,
>> +	host = pci_scan_host_bridge(parent,
>>  			PCI_DOMBUS(pbm->index, pbm->pci_first_busno),
>> -			pbm->pci_ops, pbm, &resources);
>> -	if (!bus) {
>> -		printk(KERN_ERR "Failed to create bus for %s\n",
>> +			pbm->pci_ops, pbm, &resources, &phb_ops);
>> +	if (!host) {
>> +		printk(KERN_ERR "Failed to create host bridge for %s\n",
>>  		       node->full_name);
>>  		pci_free_resource_list(&resources);
>>  		return NULL;
>>  	}
>>  
> 
> I would keep "bus" and set it here:
> 
> 	bus = host->bus;
> 
> That would remove some lines from your patch that really didn't change,
> which makes it easier to see what actually *is* changing, namely, you're
> removing the pci_of_scan_bus() call because it is now done inside
> pci_scan_host_bridge().
> 

Yes, keep it will make the code more clean, thanks!

>> -	pci_of_scan_bus(pbm, node, bus);
>> -	pci_bus_register_of_sysfs(bus);
>> +	pci_bus_register_of_sysfs(host->bus);
>>  
>> -	pci_claim_bus_resources(bus);
>> -	pci_bus_add_devices(bus);
>> -	return bus;
>> +	pci_claim_bus_resources(host->bus);
>> +	pci_bus_add_devices(host->bus);
>> +	return host->bus;
>>  }
>>  
>>  void pcibios_fixup_bus(struct pci_bus *pbus)
>> -- 
>> 1.7.1
>>
> 
> .
> 


-- 
Thanks!
Yijing

