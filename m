Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41635 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752341AbaBMQ0b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 11:26:31 -0500
Date: Thu, 13 Feb 2014 16:25:52 +0000
From: Will Deacon <will.deacon@arm.com>
To: Kumar Gala <galak@codeaurora.org>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140213162552.GL13576@mudshark.cambridge.arm.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <1392236171-10512-4-git-send-email-will.deacon@arm.com>
 <D2AE4AE6-E8FA-4DD8-B92B-E37205A2548C@codeaurora.org>
 <20140213110721.GC13576@mudshark.cambridge.arm.com>
 <BA5E6077-77F8-4BE8-80E5-BAB9FE111387@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <BA5E6077-77F8-4BE8-80E5-BAB9FE111387@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 13, 2014 at 04:22:25PM +0000, Kumar Gala wrote:
> On Feb 13, 2014, at 5:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> >>> +
> >>> +- compatible     : Must be "arm,pci-cam-generic" or "arm,pci-ecam-generic"
> >>> +                   depending on the layout of configuration space (CAM vs
> >>> +                   ECAM respectively)
> >> 
> >> What’s arm specific here?  I don’t have a great suggestion, but seems odd
> >> for this to be vendor prefixed with "arm".
> > 
> > Happy to change it, but I'm also struggling for names. Maybe "linux,…"?
> 
> I was thinking that as well, I’d say go with “linux,”.

Great, I'll make that change.

> >>> +- ranges         : As described in IEEE Std 1275-1994, but must provide
> >>> +                   at least a definition of one or both of IO and Memory
> >>> +                   Space.
> >>> +
> >>> +- #address-cells : Must be 3
> >>> +
> >>> +- #size-cells    : Must be 2
> >>> +
> >>> +- reg            : The Configuration Space base address, as accessed by the
> >>> +                   parent bus.
> >> 
> >> Isn’t the size fixed here for cam or ecam?
> > 
> > Yes, which is why reg just specifies the base address.
> 
> Huh?  The reg property clearly has the size in it (as shown in the example
> below).  I guess I was just asking for the description here to say what
> the size was for the 2 compatibles since its fixed and known.

Actually, the example just has a 64-bit CPU physical address with no size.
Do I have to add a size to the binding? It's not at all useful for the driver.

> >> Examples are always nice :)
> > 
> > Not in this case! kvmtool generates the following:
> > 
> > 	pci {
> > 		#address-cells = <0x3>;
> > 		#size-cells = <0x2>;
> > 		#interrupt-cells = <0x1>;
> > 		compatible = "arm,pci-cam-generic";
> > 		reg = <0x0 0x40000000>;
> > 		ranges = <0x1000000 0x0 0x0 0x0 0x0 0x0 0x10000 0x2000000 0x0 0x41000000 0x0 0x41000000 0x0 0x3f000000>;
> > 		interrupt-map = <0x0 0x0 0x0 0x1 0x1 0x0 0x4 0x1 0x800 0x0 0x0 0x1 0x1 0x0 0x5 0x1 0x1000 0x0 0x0 0x1 0x1 0x0 0x6 0x1 0x1800 0x0 0x0 0x1 0x1 0x0 0x7 0x1>;
> > 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> > 	};
> > 
> > I can add it if you like, but it looks like a random bunch of numbers to me.
> 
> You could clean it up a bit to be human readable even if its kvmtool that’s creating it.
> 
> 	pci {
> 		compatible = "arm,pci-cam-generic”;
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		#interrupt-cells = <1>
> 		reg = <0x0 0x40000000>;
> 		ranges = <
> 			0x1000000 0x0 0x00000000 0x0 0x00000000 0x0 0x00010000
> 			0x2000000 0x0 0x41000000 0x0 0x41000000 0x0 0x3f000000
> 			>;
> 		interrupt-map = <
> 			...
> 				>;
> 
> 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;

Sure, if you think it helps.

Will
