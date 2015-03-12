Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4900 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681AbbCLN3g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2015 09:29:36 -0400
Message-ID: <550194AD.6080204@huawei.com>
Date: Thu, 12 Mar 2015 21:29:17 +0800
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
Subject: Re: [PATCH v6 28/30] PCI: Export find_pci_host_bridge() and rename
 to pci_find_host_bridge()
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com> <1425868467-9667-29-git-send-email-wangyijing@huawei.com> <20150312034305.GJ10949@google.com>
In-Reply-To: <20150312034305.GJ10949@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index a1dc9f2..45252dd 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -328,4 +328,6 @@ struct pci_host_bridge *pci_create_host_bridge(
>>  		void *sysdata, struct pci_host_bridge_ops *ops);
>>  
>>  void pci_free_host_bridge(struct pci_host_bridge *host);
>> +struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
> 
> This is only used in drivers/pci/host-bridge.c and in drivers/pci/pci.c for
> pci_domain_nr().  Can you drop this patch and put the generic
> pci_domain_nr() implementation (next patch) in host-bridge.c instead of in
> pci.c?

Of course, thanks.

> 
>> +
>>  #endif /* DRIVERS_PCI_H */
>> -- 
>> 1.7.1
>>
> 
> .
> 


-- 
Thanks!
Yijing

