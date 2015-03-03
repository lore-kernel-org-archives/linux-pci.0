Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:38483 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbbCCDqZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2015 22:46:25 -0500
Message-ID: <54F52E82.80003@huawei.com>
Date: Tue, 3 Mar 2015 11:46:10 +0800
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
Subject: Re: [PATCH v4 09/30] PCI: Separate pci_host_bridge creation out of
 pci_create_root_bus()
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com> <1424938344-4017-10-git-send-email-wangyijing@huawei.com> <20150303023750.GE11978@google.com>
In-Reply-To: <20150303023750.GE11978@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> +
>> +	resource_list_for_each_entry_safe(window, n, resources)
>> +		list_move_tail(&window->node, &host->windows);
>> +
>> +	return host;
>> +}
>> +EXPORT_SYMBOL(pci_create_host_bridge);
> 
> Why does this need to be exported?  I don't want code outside drivers/pci
> using something like this.

OK, I will unexport it, if some drivers really want to export it, we could do
it when needed.

> 
>> +void pci_free_host_bridge(struct pci_host_bridge *host)
>>  struct pci_host_bridge {
>>  	u16	domain;
>> +	u16 busnum;
>>  	struct device dev;
>>  	struct pci_bus *bus;		/* root bus */
>>  	struct list_head windows;	/* resource_entry */
>> @@ -415,7 +416,8 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>>  		     void *release_data);
>>  
>>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
>> -
>> +struct pci_host_bridge *pci_create_host_bridge(
>> +		struct device *parent, u32 dombus, struct list_head *resources);
> 
> Can these function declarations go in drivers/pci/pci.h instead?  I'd
> rather not expose them to the rest of the kernel unless we have to.

I would move it in drivers/pci/pci.h, thanks.

> 
>>  /*
>>   * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
>>   * to P2P or CardBus bridge windows) go in a table.  Additional ones (for
>> @@ -774,6 +776,7 @@ struct pci_bus *pci_scan_bus_legacy(u32 dombus, struct pci_ops *ops, void *sysda
>>  struct pci_bus *pci_create_root_bus(struct device *parent, u32 dombus,
>>  				    struct pci_ops *ops, void *sysdata,
>>  				    struct list_head *resources);
>> +void pci_free_host_bridge(struct pci_host_bridge *host);
>>  int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
>>  int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
>>  void pci_bus_release_busn_res(struct pci_bus *b);
>> -- 
>> 1.7.1
>>
> 
> .
> 


-- 
Thanks!
Yijing

