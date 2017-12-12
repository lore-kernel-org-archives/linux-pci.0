Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45616 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752041AbdLLPYX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Dec 2017 10:24:23 -0500
Date: Tue, 12 Dec 2017 15:24:16 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Niklas Cassel' <niklas.cassel@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>, Niklas Cassel <niklass@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Fix find_first_zero_bit() usage
Message-ID: <20171212152416.GA1262@e107981-ln.cambridge.arm.com>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
 <5a6a30994101482c94f16203e3c8ba7d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5a6a30994101482c94f16203e3c8ba7d@AcuMS.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 12, 2017 at 02:33:52PM +0000, David Laight wrote:
> From: Niklas Cassel
> > find_first_zero_bit()'s parameter 'size' is defined in bits,
> > not in bytes.
> > 
> > Calling find_first_zero_bit() with the wrong size unit
> > will lead to insidious bugs.
> > 
> > Fix all uses of find_first_zero_bit() called with
> > sizeof() as size argument in drivers/pci.
> ...
> 
> Isn't all this code just using the wrong function.
> Shouldn't they be using ffz() (or whatever it is called)
> to find the first zero in a numeric argument rather that
> find_first_zero_bit() which is intended for large bitmaps.
> 
> Perhaps the type for 'large bitmaps' should be:
> struct {
> 	unsigned long bitmap_bits[0];
> } bitmap;
> rather than unsigned long[].

David,

I think you are referring to patch 3, which is a fix for the current
find_first_zero_bit() usage. The point is, I think that
struct pci_epc_group.function_num_map should actually be converted
to a bitmap (and therefore using find_first_zero_bit() on it is the
right API); patch 3 is just a fix for current code.

Unless you think patch 3 is technically wrong I would go ahead
with the series as-is for fixes and we will refactor
struct pci_epc_group.function_num_map usage to a proper bitmap
for the upcoming merge window.

Lorenzo
