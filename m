Return-Path: <SRS0=RzOh=FQ=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=RzOh=FQ=arm.com=marc.zyngier@kernel.org>
Subject: Re: free_irq(IRQ#0) on PCIe device with MSI enabled issue...
To: Bjorn Helgaas <helgaas@kernel.org>,
 =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <AM5PR03MB296338FECDD421CF2F438EB7D6CD0@AM5PR03MB2963.eurprd03.prod.outlook.com>
 <20180222151938.GC52685@bhelgaas-glaptop.roam.corp.google.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <95d5a99e-4511-52da-8bd5-0a601ac390d2@arm.com>
Date: Thu, 22 Feb 2018 18:02:40 +0000
MIME-Version: 1.0
In-Reply-To: <20180222151938.GC52685@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 22/02/18 15:19, Bjorn Helgaas wrote:
> [+cc Marc, Thomas]
> 
> Hi Stéphane,
> 
> Thanks for your email!
> 
> On Thu, Feb 22, 2018 at 08:23:52AM +0000, Stéphane Grosjean wrote:
>> I've been writing some drivers for Linux-can in the past years and
>> want to add support of MSI in one of them (see
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/peak_canfd).
>>
>> This device driver works with legacy shared INTx over a CAN PCIe
>> device. I'd like to switch to a full MSI usage of this device, which
>> proposes up to 4 vectors (this device is proposed with 1, 2 or 4 CAN
>> FD ports).
>>
>> I'm running x86_64 Kernel 4.13.0-32 from Ubuntu 17.10. Everything
>> looks ok as I successfully get the 4 consecutive IRQ levels. My
>> problem is this one: as soon as the driver free_irq() the FISRT IRQ
>> level, then it does not receive any interrupt from the device
>> anymore, for all other 3 IRQs... On the contrary, when the driver
>> free_irq() one of the 3 other IRQ (instead of the 1st one), then
>> there is no problem and all other interrupts (including the first
>> IRQ vector) are working as they should.
> 
> Can you share the actual driver code you're running?  The peak_canfd.c
> in v4.16-rc1 doesn't have the MSI code in it, so I can't see exactly
> what you're doing.
> 
> The fact that it does work on ARM suggests there's some difference in
> the arch code.  I don't know enough about this area to figure it out
> from scratch, but maybe working through the actual code would help.
> 
> It would be ideal if you could reproduce the problem on v4.16-rc1, in
> case it's something fixed since v4.13.
> 
>> I contact you because this "issue" seems to be arch dependent:
>> running the same driver and the same board on another arch (ARM),
>> then everything works like a charm: the driver can free_irq() any
>> IRQ in any order without disturbing the other ones. But running on
>> x86, free_irq() on the FIRST MSI seems to (also) free all the other
>> ones...
>>
>> Note that the driver set up MSI as described in the last version of
>> Documentation/PCI/MSI-HOWTO.txt.

Could it be that the driver is ending up with Multi-MSI instead of
MSI-X?  If using Multi-MSI, I think that would be the expected
behaviour, as the various MSIs are not controllable independently (there
is a single interrupt mask for all MSIs). On the other hand, MSI-X gives
you a bunch of completely independent interrupts.

An lspci -vv dump on both platforms would go a long way in helping to
understand the setup.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
