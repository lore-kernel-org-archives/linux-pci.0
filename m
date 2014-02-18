Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56824 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbaBRSrk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 13:47:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host controller
Date: Tue, 18 Feb 2014 19:47:15 +0100
Message-ID: <10244486.cKXs90tdz5@wuerfel>
In-Reply-To: <20140218184420.GD2010@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com> <20140218182142.GF29304@obsidianresearch.com> <20140218184420.GD2010@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 18 February 2014 18:44:20 Will Deacon wrote:
> On Tue, Feb 18, 2014 at 06:21:42PM +0000, Jason Gunthorpe wrote:
> > On Tue, Feb 18, 2014 at 12:20:43PM +0000, Will Deacon wrote:
> > > +
> > > +    // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
> > > +    ranges = <0x1000000 0x0 0x00000000  0x0 0x00000000  0x0 0x00010000>,
> >                                            ^^^^^^^^^^^^^^
> > 
> > This probably shouldn't be 0 in the example, nor in your kvm tool
> > output. For example purposes any value will do.
> 
> Hmm, so kvmtool actually provides a PC ioport at 0x0, which is handy since
> there's an 8250 down there. That means we have:
> 
> 0x0    - 0x6200  : Weird PC stuff
> 0x6200 - 0x10000 : PCI IO space
> 
> Should I just change everything to be offset by 0x6200?

Do you have a list of the stuff in there?

If that is actually port I/O, leaving it in there may be best,
but I agree the example should be changed.

	Arnd
