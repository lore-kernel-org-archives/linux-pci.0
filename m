Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46766 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbbETDV5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 May 2015 23:21:57 -0400
Message-ID: <555BFDCF.4020303@linux.intel.com>
Date: Wed, 20 May 2015 11:21:51 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [RFC 0/4] Introduce a mechanism to allocate PCI IRQ on demand
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505191535190.4225@nanos>
In-Reply-To: <alpine.DEB.2.11.1505191535190.4225@nanos>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/19 21:35, Thomas Gleixner wrote:
> On Thu, 7 May 2015, Jiang Liu wrote:
> 
>> This patch set introduces a mechanism to allocate PCI IRQ on demand and
>> free it when not used anymore by hooking pci_device_probe() and
>> pci_device_remove().
>>
>> It will be used to track IOAPIC pin usage on x86 so we could support
>> IOAPIC hot-removal.
> 
> Bjorn, any opinion on this?
Hi Bjorn,
	With this patch applied, how about removing this workaround
from arch/x86/pci/irq.c?
-------------------------------------------------------------------
        if (io_apic_assign_pci_irqs && pci_routeirq) {
                struct pci_dev *dev = NULL;
                /*
                 * PCI IRQ routing is set up by pci_enable_device(), but we
                 * also do it here in case there are still broken
drivers that
                 * don't use pci_enable_device().
                 */
                printk(KERN_INFO "PCI: Routing PCI interrupts for all
devices because \"pci=routeirq\" specified\n");
                for_each_pci_dev(dev)
                        pirq_enable_irq(dev);
        }
-------------------------------------------------------
Thanks!
Gerry

> 
> Thanks,
> 
> 	tglx
> 
