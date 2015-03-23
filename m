Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:11027 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbbCWBJM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 22 Mar 2015 21:09:12 -0400
Message-ID: <550F6799.1000301@huawei.com>
Date: Mon, 23 Mar 2015 09:08:41 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
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
Subject: Re: [PATCH v6 09/30] PCI: Separate pci_host_bridge creation out of
 pci_create_root_bus()
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com> <1425868467-9667-10-git-send-email-wangyijing@huawei.com> <550DFD13.9080505@amd.com>
In-Reply-To: <550DFD13.9080505@amd.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> +struct pci_host_bridge *pci_create_host_bridge(
>> +        struct device *parent, u32 db, struct list_head *resources)
>> +{
>> +    int error;
>> +    int bus = PCI_BUSNUM(db);
>> +    int domain = PCI_DOMAIN(db);
>> +    struct pci_host_bridge *host;
>> +    struct resource_entry *window, *n;
>> +
>> +    host = kzalloc(sizeof(*host), GFP_KERNEL);
>> +    if (!host)
>> +        return NULL;
>> +
>> +    host->busnum = bus;
>> +    host->domain = domain;
>> +    /* If support CONFIG_PCI_DOMAINS_GENERIC, use
>> +     * pci_host_assign_domain_nr() to assign domain
>> +     * number instead PCI_DOMAIN(db).
>> +     */
>> +    pci_host_assign_domain_nr(host);
> 
> At this point, host->dev.parent has not been assigned. However, when calling pci_host_assign_domain_nr(host), it calls pci_assign_domain_nr(host->dev.parent), which uses parent->of_node directly w/o checking if parent is NULL. This ended up causing NULL pointer exception when I do the test.
> 
> I think we need to moveo host->dev.parent = parent before calling pci_host_assign_domain_nr(host).

Good catch! Hi Suravee, thanks for your test, I would assign host->dev.parent before pci_host_assign_domain_nr().

Thanks!
Yijing.

> 
> .
> 


-- 
Thanks!
Yijing

