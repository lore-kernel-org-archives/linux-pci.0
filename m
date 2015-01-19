Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:10916 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbASDTi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 Jan 2015 22:19:38 -0500
Message-ID: <54BC77B3.6080701@huawei.com>
Date: Mon, 19 Jan 2015 11:19:15 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>, <x86@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Guan Xuetao" <gxt@mprc.pku.edu.cn>, <linux-alpha@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, Liviu Dudau <liviu@dudau.co.uk>,
	"Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: [PATCH 27/28] PCI: Remove platform specific pci_domain_nr()
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com> <1421372666-12288-28-git-send-email-wangyijing@huawei.com> <1561857.t9qV46uRjC@wuerfel>
In-Reply-To: <1561857.t9qV46uRjC@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/1/16 17:44, Arnd Bergmann wrote:
> On Friday 16 January 2015 09:44:25 Yijing Wang wrote:
>>
>> +int pci_domain_nr(struct pci_bus *bus)
>> +{
>> +       struct pci_host_bridge *host = find_pci_host_bridge(bus);
>> +
>> +       return host->domain;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_domain_nr);
>> +
> 
> Since most of the existing functions are exported as EXPORT_SYMBOL
> rather than EXPORT_SYMBOL_GPL, I think the new version should do
> the same.

Good catch. Thanks!

> 
> 	Arnd
> 
> .
> 


-- 
Thanks!
Yijing

