Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:19829 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043AbbCCImQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2015 03:42:16 -0500
Message-ID: <54F573D2.6010807@huawei.com>
Date: Tue, 3 Mar 2015 16:41:54 +0800
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
Subject: Re: [PATCH v4 12/30] PCI: Introduce pci_host_bridge_ops to support
 host specific operations
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com> <1424938344-4017-13-git-send-email-wangyijing@huawei.com> <20150303030301.GI11978@google.com>
In-Reply-To: <20150303030301.GI11978@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/3 11:03, Bjorn Helgaas wrote:
> On Thu, Feb 26, 2015 at 04:12:06PM +0800, Yijing Wang wrote:
>> Now we have weak functions like pcibios_root_bridge_prepare()
>> to setup pci host bridge, We could introduce pci_host_bridge_ops
>> which contain host bridge specific ops to setup pci_host_bridge.
>> Then host bridge driver could add pci_host_bridge_ops hooks
>> intead of weak function to setup pci_host_bridge.
>> This patch add following pci_host_bridge_ops hooks:
>>
>> pci_host_bridge_ops {
>> 	/* set root bus speed, some platform need this like powerpc */
>> 	void (*phb_set_root_bus_speed)(struct pci_host_bridge *host);
>> 	/* setup pci_host_bridge before pci_host_bridge be added to driver core */
>> 	int (*phb_prepare)(struct pci_host_bridge *host);
>> 	/* platform specific of scan hook to scan pci device */
>> 	void (*phb_of_scan_bus)(struct pci_host_bridge *);
>> }
>> We could easily extend it to support different host bridge
>> specific operations.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ...
> 
>> @@ -2050,10 +2052,13 @@ static struct pci_bus *__pci_scan_root_bus(
>>  		pci_bus_insert_busn_res(b, b->number, 255);
>>  	}
>>  
>> -	max = pci_scan_child_bus(b);
>> -
>> -	if (!found)
>> -		pci_bus_update_busn_res_end(b, max);
>> +	if (host->ops && host->ops->phb_of_scan_bus) {
>> +		host->ops->phb_of_scan_bus(host);
> 
> The important thing here is not the use of OF (Open Firmware/Device Tree),
> is it?  Why would we want "_of_" in the function name?  I assume the intent
> is that this host bridge op performs the same function as
> pci_scan_child_bus(), so I think the op should be called "scan_bus".

Yes, because now only OF code need the private scan_child_bus, so I named it
phb_of_scan_bus(). I agree that rename it to scan_bus.

> 
>> +	} else {
>> +		max = pci_scan_child_bus(b);
>> +		if (!found)
>> +			pci_bus_update_busn_res_end(b, max);
>> +	}
>>  
>>  	return b;
>>  }
> 
> .
> 


-- 
Thanks!
Yijing

