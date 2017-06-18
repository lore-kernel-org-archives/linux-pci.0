Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdFRAdV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jun 2017 20:33:21 -0400
Date: Sun, 18 Jun 2017 08:33:15 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 06/13] switchtec_ntb: initialize hardware for memory
 windows
Message-ID: <20170618003315.GA5326@kroah.com>
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170615203729.9009-7-logang@deltatee.com>
 <20170617051658.GG6040@kroah.com>
 <5294be8f-5547-0cd8-2e1d-a9bbfe06dc6f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5294be8f-5547-0cd8-2e1d-a9bbfe06dc6f@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 17, 2017 at 10:39:35AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 16/06/17 11:16 PM, Greg Kroah-Hartman wrote:
> >> +#ifndef ioread64
> >> +#ifdef readq
> >> +#define ioread64 readq
> >> +#else
> >> +#define ioread64 _ioread64
> >> +static inline u64 _ioread64(void __iomem *mmio)
> >> +{
> >> +	u64 low, high;
> >> +
> >> +	low = ioread32(mmio);
> >> +	high = ioread32(mmio + sizeof(u32));
> >> +	return low | (high << 32);
> >> +}
> >> +#endif
> >> +#endif
> > 
> > Really?  Don't we have ioread64 in generic code for all arches?  If not,
> > that should be fixed, don't hide this in a random driver please.  Or
> > just restrict your driver to only building on those arches that does
> > provide this api.
> 
> Yes, I know these are _very_ ugly. Unfortunately, the other ntb drivers
> each have the exact same thing. ioread64 is not provided universally at
> this time and I did spend a bit of time digging and things are a bit
> messy so I wasn't at all sure of the correct solution.

That implies that this needs to be fixed, no driver should ever have to
define this themselves.  The fact that they all do it at the same time
is a huge hint that it's wrong.

> For starters, ioread64 is only defined on 64 bit machines. They are
> surrounded by ifdef CONFIG_64BIT and it's not clear to me if the above
> wrapper (around two ioread32s) would be acceptable universally.
> 
> Second, the x86_64 version doesn't even compile. This is because the
> arch doesn't provide any ioread64 implementation anywhere and the macro
> in io.h isn't used because CONFIG_GENERIC_IOMAP is defined.
> 
> The only arch where I _think_ ioread64 would work is powerpc or any that
> define CONFIG_64BIT and not CONFIG_GENERIC_IOMAP.
> 
> If you have any guidance on this I'd be happy to try and make a patch or
> two for it.

I suggest coming up with something simple like what you have here,
adding it to the arch-generic code and posting it to the linux-arch
mailing list and seeing if anyone screams :)

thanks,

greg k-h
