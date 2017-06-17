Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:37089 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751882AbdFQQjr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Jun 2017 12:39:47 -0400
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170615203729.9009-7-logang@deltatee.com> <20170617051658.GG6040@kroah.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5294be8f-5547-0cd8-2e1d-a9bbfe06dc6f@deltatee.com>
Date: Sat, 17 Jun 2017 10:39:35 -0600
MIME-Version: 1.0
In-Reply-To: <20170617051658.GG6040@kroah.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC PATCH 06/13] switchtec_ntb: initialize hardware for memory
 windows
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16/06/17 11:16 PM, Greg Kroah-Hartman wrote:
>> +#ifndef ioread64
>> +#ifdef readq
>> +#define ioread64 readq
>> +#else
>> +#define ioread64 _ioread64
>> +static inline u64 _ioread64(void __iomem *mmio)
>> +{
>> +	u64 low, high;
>> +
>> +	low = ioread32(mmio);
>> +	high = ioread32(mmio + sizeof(u32));
>> +	return low | (high << 32);
>> +}
>> +#endif
>> +#endif
> 
> Really?  Don't we have ioread64 in generic code for all arches?  If not,
> that should be fixed, don't hide this in a random driver please.  Or
> just restrict your driver to only building on those arches that does
> provide this api.

Yes, I know these are _very_ ugly. Unfortunately, the other ntb drivers
each have the exact same thing. ioread64 is not provided universally at
this time and I did spend a bit of time digging and things are a bit
messy so I wasn't at all sure of the correct solution.

For starters, ioread64 is only defined on 64 bit machines. They are
surrounded by ifdef CONFIG_64BIT and it's not clear to me if the above
wrapper (around two ioread32s) would be acceptable universally.

Second, the x86_64 version doesn't even compile. This is because the
arch doesn't provide any ioread64 implementation anywhere and the macro
in io.h isn't used because CONFIG_GENERIC_IOMAP is defined.

The only arch where I _think_ ioread64 would work is powerpc or any that
define CONFIG_64BIT and not CONFIG_GENERIC_IOMAP.

If you have any guidance on this I'd be happy to try and make a patch or
two for it.

Thanks,

Logan
