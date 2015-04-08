Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:7783 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbbDHBTU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2015 21:19:20 -0400
Message-ID: <552481F8.1090308@huawei.com>
Date: Wed, 8 Apr 2015 09:18:48 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>, <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>, <dja@axtens.net>,
	<x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Guan Xuetao" <gxt@mprc.pku.edu.cn>, <linux-alpha@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, Liviu Dudau <liviu@dudau.co.uk>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v9 06/30] PCI: Separate pci_host_bridge creation out of
 pci_create_root_bus()
References: <1428053164-28277-1-git-send-email-wangyijing@huawei.com> <1428053164-28277-8-git-send-email-wangyijing@huawei.com> <20150407213839.GJ10892@google.com>
In-Reply-To: <20150407213839.GJ10892@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> +	/*
>> +	 * If support CONFIG_PCI_DOMAINS_GENERIC, use
>> +	 * pci_host_assign_domain_nr() to update domain
>> +	 * number.
>> +	 */
>> +	host->domain = domain;
>> +	pci_host_assign_domain_nr(host);
> 
> I think it's a bit confusing that there's another "host->domain ="
> assignment buried inside pci_host_assign_domain_nr(), so the first
> assignment is overwritten when CONFIG_PCI_DOMAINS_GENERIC is set.
> 
> Can you do something like this instead:
> 
>   int pci_host_assign_domain_nr(struct pci_host_bridge *host, int domain)
>   {
>   #ifdef CONFIG_PCI_DOMAINS_GENERIC
>     host->domain = pci_assign_domain_nr(host->dev.parent);
>   #else
>     host->domain = domain;
>   #endif
>   }
> 
> Then the alternatives (CONFIG_PCI_DOMAINS_GENERIC=y and
> CONFIG_PCI_DOMAINS_GENERIC being unset) are close together and right at the
> #ifdef CONFIG_PCI_DOMAINS_GENERIC, so no extra comments are needed.

OK, I would use #ifdef to update pci_host_assign_domain_nr(), and I would drop the
last patch [PATCH v9 30/30] PCI: Clean up CONFIG_PCI_DOMAINS_GENERIC.

Thanks!
Yijing.

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing

