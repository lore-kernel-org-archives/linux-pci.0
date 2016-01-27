Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] pci: fix unavailable irq number 255 reported by BIOS
To: Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
References: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
 <20160125205803.GA10272@localhost> <alpine.DEB.2.11.1601260825510.3886@nanos>
 <20160126152221.GB9279@localhost> <alpine.DEB.2.11.1601261628450.3886@nanos>
 <20160127002505.GA3329@localhost>
CC: Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rjw@rjwysocki.net>, <lenb@kernel.org>,
	<izumi.taku@jp.fujitsu.com>, <wency@cn.fujitsu.com>,
	<ddaney.cavm@gmail.com>, <okaya@codeaurora.org>,
	<bhelgaas@google.com>, <jiang.liu@linux.intel.com>,
	<linux-pci@vger.kernel.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <56A85494.8070606@cn.fujitsu.com>
Date: Wed, 27 Jan 2016 13:24:36 +0800
MIME-Version: 1.0
In-Reply-To: <20160127002505.GA3329@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 01/27/2016 08:25 AM, Bjorn Helgaas wrote:
> On Tue, Jan 26, 2016 at 04:48:25PM +0100, Thomas Gleixner wrote:
>> On Tue, 26 Jan 2016, Bjorn Helgaas wrote:


>>
>> Right. So we could certainly do something like this INVALID_IRQ thingy, but
>> that looks a bit weird. What would request_irq() return?
>>
>> If it returns success, then drivers might make the wrong decision. If it
>> returns an error code, then the i801 one works, but we might have to fix
>> others anyway.
>
> I was thinking request_irq() could return -EINVAL if the caller passed
> INVALID_IRQ.  That should tell drivers that this interrupt won't work.
>
> We'd be making request_irq() return -EINVAL in some cases where it
> currently returns success.  But even though it returns success today,
> I don't think the driver is getting interrupts, because the wire isn't
> connected.
>
>> I think it's better to have a software flag in pci_dev to indicate that there
>> is no irq line and fix up the (probably few) affected drivers so they avoid
>> calling request_irq() and take the right action.
>
> We could add an "irq_valid" flag in struct pci_dev and make a new
> rule that drivers should check dev->irq_valid before using dev->irq.
> But realistically, i801 is the only place that will check irq_valid
> because that's the only driver where we know about a problem, so that
> seems like sort of a point solution.
>
> Bjorn
>

How about using IRQ_BITMAP_BITS as that "irq_valid" flag? because it is 
the ceiling of struct irq_desc irq_desc[], and request_irq() will return 
-EINVAL in case of the ceiling.

#ifdef CONFIG_SPARSE_IRQ
# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
#else
# define IRQ_BITMAP_BITS	NR_IRQS
#endif

> .
>

-- 
Yours Sincerely,

Cao jin
