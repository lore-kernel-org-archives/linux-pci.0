Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:26549 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbbCCIuG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2015 03:50:06 -0500
Message-ID: <54F575AA.6050409@huawei.com>
Date: Tue, 3 Mar 2015 16:49:46 +0800
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
Subject: Re: [PATCH v4 20/30] PCI/sparc: Use pci_scan_root_bridge() for simplicity
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com> <1424938344-4017-21-git-send-email-wangyijing@huawei.com> <20150303031059.GJ11978@google.com>
In-Reply-To: <20150303031059.GJ11978@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> -	pci_of_scan_bus(pbm, node, bus);
>> -	pci_bus_add_devices(bus);
>> -	pci_bus_register_of_sysfs(bus);
>> +	pci_bus_add_devices(host->bus);
>> +	pci_bus_register_of_sysfs(host->bus);
>>  
>> -	pci_claim_bus_resources(bus);
>> +	pci_claim_bus_resources(host->bus);
> 
> Isn't this a case where pci_claim_bus_resources() should be done before
> pci_bus_add_devices()?  You didn't introduce this problem, but since you're
> fixing similar issues, seems like we should fix this one, too.  In a patch
> of its own, of course.

OK, will fix in a another patch.

> 
>>  
>> -	return bus;
>> +	return host->bus;
>>  }
>>  
>>  void pcibios_fixup_bus(struct pci_bus *pbus)
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
> .
> 


-- 
Thanks!
Yijing

