Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:37180 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbbCLLnH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2015 07:43:07 -0400
Message-ID: <55017BA1.7020700@huawei.com>
Date: Thu, 12 Mar 2015 19:42:25 +0800
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
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 03/30] PCI: Export busn_resource to drivers/pci
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com> <1425868467-9667-4-git-send-email-wangyijing@huawei.com> <20150311222835.GA1082@google.com>
In-Reply-To: <20150311222835.GA1082@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> -static struct resource busn_resource = {
>> +struct resource busn_resource = {
>>  	.name	= "PCI busn",
>>  	.start	= 0,
>>  	.end	= 255,
>>  	.flags	= IORESOURCE_BUS,
>>  };
>> +EXPORT_SYMBOL(busn_resource);
> 
> I don't think this is a good idea.  We support multiple PCI domains, and
> each domain has its own 0-255 bus number range.  This busn_resource is
> only for domain 0 and probably should be handled in arch code instead of
> the PCI core.
> 
> Right now, I think it's possible to call pci_scan_bus_parented() or
> pci_scan_bus() several times for buses in different domains, and they would
> all share the same busn_resource, which would cause corruption.
> 
> So it's already broken, but I don't want to make it harder to fix by
> exporting this stuff.

Hi Bjorn, busn_resource may would not be shared by multi domains,

We insert bus number resource like:

pci_add_resource(&resources, &busn_resource);	
	pci_bus_insert_busn_res(root_bus, start, bus_max);	//start is the root bus number provided by arch pci host driver, bus max here == 255
		get_pci_domain_busn_res(domain)	//for root bus	//try to get a domain specific pci_domain_busn_res, if not exist, create it.
			request_resource_conflict(domain_specific_busn_res, res)   //request busn res(start, bus_max) from the pci_domain_busn_res.

So every domain has its own pci_domain_busn_res , different domain would not share the same bus number resource.

Do I understand correct ?

Thanks!
Yijing.

> 
>>  
>>  /* Ugh.  Need to stop exporting this to modules. */
>>  LIST_HEAD(pci_root_buses);
>> -- 
>> 1.7.1
>>
> 
> .
> 


-- 
Thanks!
Yijing

