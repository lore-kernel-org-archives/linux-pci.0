Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54830 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030793AbbKEM0n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2015 07:26:43 -0500
Date: Thu, 5 Nov 2015 13:25:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Marc Zyngier <marc.zyngier@arm.com>
cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Ma Jun <majun258@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/7] Adding core support for wire-MSI bridges
In-Reply-To: <563B49F0.7040000@arm.com>
Message-ID: <alpine.DEB.2.11.1511051324380.4032@nanos>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com> <56205917.7090001@linux.intel.com> <5620B9D6.1010708@arm.com> <alpine.DEB.2.11.1511041348060.4032@nanos> <563B49F0.7040000@arm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 5 Nov 2015, Marc Zyngier wrote:
> On 04/11/15 13:34, Thomas Gleixner wrote:
> > Marc,
> > 
> > On Fri, 16 Oct 2015, Marc Zyngier wrote:
> >> On 16/10/15 02:55, Jiang Liu wrote:
> >>> 	There's a working to enable Intel VMD storage device, which
> >>> has the similar requirement. Basically a PCIe hierarchy is hidden
> >>> behind a parent PCIe device, so we need to use the PCIe irqs on parent
> >>> to de-multiple PCIe IRQs from hidden PCIe devices. Seems a chance for
> >>> consolidation here.
> >>
> >> Do you know if there is a 1-1 mapping between the interrupts seen by the
> >> parent device and those seen by the hidden devices? Or is it a case of
> >> having to demultiplex the MSIs? Looks like the former, but I'd like to
> >> be sure.
> > 
> > Yes, it's a demultiplexer. No 1:1 mapping.
> 
> Right. This doesn't exactly fit the scheme I have so far (there is a 1:1
> mapping between the wired interrupt and the MSI), but once we are able
> to expose an MSI domain, it could be possible to construct the MSI
> demultiplexer on top. That's a lot of layers! ;-)

Well for the demux case it doesn't make a lot of sense. It's not easy
to describe in a hierarchy. Having that parentless MSI domain for that
VMD case is simple enough.

Thanks,

	tglx
