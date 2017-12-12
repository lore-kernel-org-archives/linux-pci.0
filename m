Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.185]:56598 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbdLLPjf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Dec 2017 10:39:35 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>
CC: 'Niklas Cassel' <niklas.cassel@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>, Niklas Cassel <niklass@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/3] Fix find_first_zero_bit() usage
Date: Tue, 12 Dec 2017 15:39:47 +0000
Message-ID: <963608b179be4d5297082dcf915ac924@AcuMS.aculab.com>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
 <5a6a30994101482c94f16203e3c8ba7d@AcuMS.aculab.com>
 <20171212152416.GA1262@e107981-ln.cambridge.arm.com>
In-Reply-To: <20171212152416.GA1262@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lorenzo Pieralisi
> Sent: 12 December 2017 15:24
> 
> On Tue, Dec 12, 2017 at 02:33:52PM +0000, David Laight wrote:
> > From: Niklas Cassel
> > > find_first_zero_bit()'s parameter 'size' is defined in bits,
> > > not in bytes.
> > >
> > > Calling find_first_zero_bit() with the wrong size unit
> > > will lead to insidious bugs.
> > >
> > > Fix all uses of find_first_zero_bit() called with
> > > sizeof() as size argument in drivers/pci.
> > ...
> >
> > Isn't all this code just using the wrong function.
> > Shouldn't they be using ffz() (or whatever it is called)
> > to find the first zero in a numeric argument rather that
> > find_first_zero_bit() which is intended for large bitmaps.
> >
> > Perhaps the type for 'large bitmaps' should be:
> > struct {
> > 	unsigned long bitmap_bits[0];
> > } bitmap;
> > rather than unsigned long[].
> 
> David,
> 
> I think you are referring to patch 3, which is a fix for the current
> find_first_zero_bit() usage. The point is, I think that
> struct pci_epc_group.function_num_map should actually be converted
> to a bitmap (and therefore using find_first_zero_bit() on it is the
> right API); patch 3 is just a fix for current code.
> 
> Unless you think patch 3 is technically wrong I would go ahead
> with the series as-is for fixes and we will refactor
> struct pci_epc_group.function_num_map usage to a proper bitmap
> for the upcoming merge window.

I may not have looked very closely at these patches, but IIRC some other
similar ones were using explicit foo |= 1 << bit to set the bit.

While technically correct (changes 4 or 8 to 32 or 64) it might be
better described as '8 * sizeof xxxx'.
Then the code is correct regardless of the bitmap size (unless smaller
than a long on (probably) BE systems).

	David
