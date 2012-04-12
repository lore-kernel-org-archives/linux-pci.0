Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:11659 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964877Ab2DLC04 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 22:26:56 -0400
From: "Hao, Xudong" <xudong.hao@intel.com>
To: Matthew Wilcox <matthew@wil.cx>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V4] Quirk for IVB graphics FLR errata
Date: Thu, 12 Apr 2012 02:26:34 +0000
Message-ID: <403610A45A2B5242BD291EDAE8B37D300FD0EBA2@SHSMSX102.ccr.corp.intel.com>
References: <403610A45A2B5242BD291EDAE8B37D300FD0DA33@SHSMSX102.ccr.corp.intel.com>
 <20120411122233.GB6557@parisc-linux.org>
In-Reply-To: <20120411122233.GB6557@parisc-linux.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Matthew Wilcox [mailto:matthew@wil.cx]
> Sent: Wednesday, April 11, 2012 8:23 PM
> To: Hao, Xudong
> Cc: Bjorn Helgaas; linux-pci@vger.kernel.org
> Subject: Re: [PATCH V4] Quirk for IVB graphics FLR errata
> 
> On Wed, Apr 11, 2012 at 06:03:43AM +0000, Hao, Xudong wrote:
> > +#ifdef CONFIG_X86
> > +
> > +#include "../gpu/drm/i915/i915_reg.h"
> > +#define MSG_CTL	0x45010
> 
> There's a strange mixture of constants from i915_reg.h, defined constants
> here and bare constants below.  I don't mind which get used, but the mixture
> is bizarre.
> 
> > +static const int op_timeout = 10;	/* set timeout 10 seconds */
> > +static int reset_ivb_igd(struct pci_dev *dev, int probe) {
> > +	u8 *mmio_base;
> > +	u32 val;
> > +	cycles_t cyc_op_timeout = tsc_khz*op_timeout*1000;
> 
> Style: use spaces around the multiply operator:
> 	cycles_t cyc_op_timeout = tsc_khz * op_timeout * 1000;
> 

I'll modify it to follow code style.

> > +	if (probe)
> > +		return 0;
> > +
> > +	mmio_base = ioremap_nocache(pci_resource_start(dev, 0),
> > +				 pci_resource_len(dev, 0));
> 
> mmio_base should have type void __iomem *.
> 
Yes, it should use void __iomem *, I'll change it.

> > +	if (!mmio_base)
> > +		return -ENOMEM;
> > +
> > +	/* Work Around */
> > +	*((u32 *)(mmio_base + MSG_CTL)) = 0x00000002;
> 
> Why are you not using writel() here? (and readl() in other places)
> 

I'll use writel() and readl() in next version patch, thanks for your code review and comments.

> > +	/* Clobbering SOUTH_CHICKEN2 register is fine only if the next
> > +	 * driver loaded sets the right bits. However, this's a reset and
> > +	 * the bits have been set by i915 previously, so we clobber
> > +	 * SOUTH_CHICKEN2 register directly here.
> > +	 */
> > +	*((u32 *)(mmio_base + SOUTH_CHICKEN2)) = 0x00000005;
> > +	val = *((u32 *)(mmio_base + PCH_PP_CONTROL)) & 0xfffffffe;
> > +	*((u32 *)(mmio_base + PCH_PP_CONTROL)) = val;
> > +	do {
> > +		cycles_t start_time = get_cycles();
> > +		while (1) {
> > +			val = *((u32 *)(mmio_base + PCH_PP_STATUS));
> > +			if (((val & 0x80000000) == 0)
> > +				&& ((val & 0x30000000) == 0))
> > +				break;
> > +			if (cyc_op_timeout < (get_cycles() - start_time))
> > +				break;
> > +			cpu_relax();
> > +		}
> > +	} while (0);
> > +	*((u32 *)(mmio_base + 0xd0100)) = 0x00000002;
> > +
> > +	iounmap(pci_resource_start(dev, 0));
> > +	return 0;
> > +}
> > +#else
> > +static int reset_ivb_igd(struct pci_dev *dev, int probe) { }
> > +#endif	/* CONFIG_X86 */
> > +
> >  #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
> > +#define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
> > +#define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
> >
> >  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
> >  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
> >  		 reset_intel_82599_sfp_virtfn },
> > +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M_VGA,
> > +		reset_ivb_igd },
> > +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
> > +		reset_ivb_igd },
> >  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> >  		reset_intel_generic_dev },
> >  	{ 0 }
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> Matthew Wilcox				Intel Open Source Technology Centre
> "Bill, look, we understand that you're interested in selling us this operating
> system, but compare it to ours.  We can't possibly take such a retrograde
> step."
