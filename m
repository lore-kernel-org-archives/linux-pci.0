Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <563B22F1.901@arm.com>
Date: Thu, 05 Nov 2015 09:35:45 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"majun (F)" <majun258@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 7/7] irqchip: [Example] dummy wired interrupt/MSI
 bridge driver
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com> <1444923568-17413-8-git-send-email-marc.zyngier@arm.com> <5639BB10.1090108@huawei.com> <5639C9F9.2010704@arm.com> <EE11001F9E5DDD47B7634E2F8A612F2E1629D8DD@lhreml503-mbs>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1629D8DD@lhreml503-mbs>
Content-Type: text/plain; charset=gbk
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/11/15 08:25, Gabriele Paoloni wrote:
> Hi Marc
> 
>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
>> On Behalf Of Marc Zyngier
>> Sent: 04 November 2015 09:04
>> To: majun (F); Thomas Gleixner; Jiang Liu; Jason Cooper
>> Cc: linux-arm-kernel@lists.infradead.org; linux-pci@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH RFC 7/7] irqchip: [Example] dummy wired interrupt/MSI
>> bridge driver
>>
>> On 04/11/15 08:00, majun (F) wrote:

[...]

>>> I think,for a interrupt controller, msichip driver initialization maybe is
>> too late
>>> for some devices which connect to this irqchip if we use
>> module_platform_driver.
>>
>> That's a consequence of this design. This is why I insisted on the fact
>> that this is currently avoided by using deferred probe in drivers, and
> 
> Mmm using te deferred probe would mean to rework all the drivers of the
> potential devices connected to mbi-gen...would that be sustainable/acceptable?

I'm tempted to reply "Not my problem". Or rather, not a problem I'm
trying to solve right now (or any time soon).

I'm pretty sure that sprinkling -EPROBE_DEFER on all possible drivers
will result in a resounding NAK, which is is why I suggested that
someone with a vested interest dedicates some quality time helping those
who are trying to solve this issue for good.

>> that it should be solved by having a probe order. Either way, this is
>> not something that we can solve at that level (see the multiple proposal
>> for this on the various lists).
> 
> Could you point me to the relevant discussions for this...?

Google is, as always, your dearest friend. But here you go:

- LWN has some quality coverage of the KS discussions (assuming you're a
subscriber, otherwise you'll have to wait for another week):
http://lwn.net/Articles/662820/

- There is also Tomeu Vizoso's series, which itself builds upon other
previous attempts at solving this: https://lwn.net/Articles/658690/

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
