Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40180 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbbJPIs0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Oct 2015 04:48:26 -0400
Message-ID: <5620B9D6.1010708@arm.com>
Date: Fri, 16 Oct 2015 09:48:22 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>
CC: Ma Jun <majun258@huawei.com>, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/7] Adding core support for wire-MSI bridges
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com> <56205917.7090001@linux.intel.com>
In-Reply-To: <56205917.7090001@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gerry,

On 16/10/15 02:55, Jiang Liu wrote:
> On 2015/10/15 23:39, Marc Zyngier wrote:
>> There seems to be a new class of interrupt controller out there whose
>> sole purpose (apart from making everybody's life a nightmare) is to
>> turn wired interrupts into MSIs.
>>
>> Instead of considering that the MSIs allocated to a device are for the
>> direct use of that device, we can turn this set of MSIs into a irq
>> domain, and use that domain to build a standard irqchip on top of
>> that.
> Hi Marc,
> 	There's a working to enable Intel VMD storage device, which
> has the similar requirement. Basically a PCIe hierarchy is hidden
> behind a parent PCIe device, so we need to use the PCIe irqs on parent
> to de-multiple PCIe IRQs from hidden PCIe devices. Seems a chance for
> consolidation here.

Do you know if there is a 1-1 mapping between the interrupts seen by the
parent device and those seen by the hidden devices? Or is it a case of
having to demultiplex the MSIs? Looks like the former, but I'd like to
be sure.

I just had a quick look at the code there:
https://lkml.org/lkml/2015/8/27/674

Is there anything more recent?

> 	cc Keith Busch <keith.busch@intel.com> who is the author of
> VMD device driver.

Sure, will do when I repost this (probably in a few weeks), and assuming
this fits the bill for Thomas and the MBIGEN folks.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
