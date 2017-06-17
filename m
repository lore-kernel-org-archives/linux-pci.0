Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdFQFRD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jun 2017 01:17:03 -0400
Date: Sat, 17 Jun 2017 07:16:58 +0200
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
Message-ID: <20170617051658.GG6040@kroah.com>
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170615203729.9009-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615203729.9009-7-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 15, 2017 at 02:37:22PM -0600, Logan Gunthorpe wrote:
> This commit adds the code to initialize the memory windows in the
> hardware. This includes setting up the requester ID table, and
> figuring out which bar corresponds to which memory window. (Seeing
> the switch can be configured with any number of bars.)
> 
> Also, seeing the device doesn't have hardware for scratchpads or
> determining the link status, we create a shared memory window that has
> these features. A magic number with a version copmonent will be used
> to determine if the otherside's driver is actually up.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> ---
>  drivers/ntb/hw/mscc/switchtec_ntb.c | 296 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 296 insertions(+)
> 
> diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
> index 1f094216aa1c..756307d1a8a3 100644
> --- a/drivers/ntb/hw/mscc/switchtec_ntb.c
> +++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
> @@ -15,37 +15,332 @@
>  
>  #include <linux/switchtec.h>
>  #include <linux/module.h>
> +#include <linux/delay.h>
>  
>  MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
>  MODULE_VERSION("0.1");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Microsemi Corporation");
>  
> +#ifndef ioread64
> +#ifdef readq
> +#define ioread64 readq
> +#else
> +#define ioread64 _ioread64
> +static inline u64 _ioread64(void __iomem *mmio)
> +{
> +	u64 low, high;
> +
> +	low = ioread32(mmio);
> +	high = ioread32(mmio + sizeof(u32));
> +	return low | (high << 32);
> +}
> +#endif
> +#endif

Really?  Don't we have ioread64 in generic code for all arches?  If not,
that should be fixed, don't hide this in a random driver please.  Or
just restrict your driver to only building on those arches that does
provide this api.

thanks,

greg k-h
