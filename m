Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 4 Nov 2015 14:34:34 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Marc Zyngier <marc.zyngier@arm.com>
cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Ma Jun <majun258@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/7] Adding core support for wire-MSI bridges
In-Reply-To: <5620B9D6.1010708@arm.com>
Message-ID: <alpine.DEB.2.11.1511041348060.4032@nanos>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com> <56205917.7090001@linux.intel.com> <5620B9D6.1010708@arm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Marc,

On Fri, 16 Oct 2015, Marc Zyngier wrote:
> On 16/10/15 02:55, Jiang Liu wrote:
> > 	There's a working to enable Intel VMD storage device, which
> > has the similar requirement. Basically a PCIe hierarchy is hidden
> > behind a parent PCIe device, so we need to use the PCIe irqs on parent
> > to de-multiple PCIe IRQs from hidden PCIe devices. Seems a chance for
> > consolidation here.
> 
> Do you know if there is a 1-1 mapping between the interrupts seen by the
> parent device and those seen by the hidden devices? Or is it a case of
> having to demultiplex the MSIs? Looks like the former, but I'd like to
> be sure.

Yes, it's a demultiplexer. No 1:1 mapping.

> Sure, will do when I repost this (probably in a few weeks), and assuming
> this fits the bill for Thomas and the MBIGEN folks.

It doesn't look that bad and the resulting mbigen stuff is way less
horrible than it was before. So I agree this is a possible solution to
the problem.

Thanks,

	tglx

