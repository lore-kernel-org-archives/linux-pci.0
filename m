Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57798 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbaBMQ3C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 11:29:02 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
Date: Thu, 13 Feb 2014 17:28:20 +0100
Message-ID: <4110788.UI9TADVhpa@wuerfel>
In-Reply-To: <BA5E6077-77F8-4BE8-80E5-BAB9FE111387@codeaurora.org>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <20140213110721.GC13576@mudshark.cambridge.arm.com> <BA5E6077-77F8-4BE8-80E5-BAB9FE111387@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 13 February 2014 10:22:25 Kumar Gala wrote:
> On Feb 13, 2014, at 5:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Happy to change it, but I'm also struggling for names. Maybe "linux,…"?
>
> I was thinking that as well, I’d say go with “linux,”.

I see nothing linux specific in there. I would only use that namespace
for things we don't expect to work with another OS.

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
> Huh?  The reg property clearly has the size in it (as shown in the example below).
> I guess I was just asking for the description here to say what the size was for
> the 2 compatibles since its fixed and known.

It's still an open question whether the config space in the reg property should
cover all 256 buses or just the ones in the bus-range. In the latter case,
it would be variable (but predictable) size.

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

Make it 

 		ranges = <0x1000000 0x0 0x00000000 0x0 0x00000000 0x0 0x00010000>,
 			 <0x2000000 0x0 0x41000000 0x0 0x41000000 0x0 0x3f000000>;

and it will be perfect ;-)

	Arnd


