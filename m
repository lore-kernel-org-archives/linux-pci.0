Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:18263 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab2DLCMs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 22:12:48 -0400
From: "Hao, Xudong" <xudong.hao@intel.com>
To: Don Dutile <ddutile@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V4] Quirk for IVB graphics FLR errata
Date: Thu, 12 Apr 2012 02:12:44 +0000
Message-ID: <403610A45A2B5242BD291EDAE8B37D300FD0EB9C@SHSMSX102.ccr.corp.intel.com>
References: <403610A45A2B5242BD291EDAE8B37D300FD0DA33@SHSMSX102.ccr.corp.intel.com>
 <4F8594FD.8020109@redhat.com>
In-Reply-To: <4F8594FD.8020109@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Don Dutile [mailto:ddutile@redhat.com]
> Sent: Wednesday, April 11, 2012 10:28 PM
> To: Hao, Xudong
> Cc: Bjorn Helgaas; linux-pci@vger.kernel.org
> Subject: Re: [PATCH V4] Quirk for IVB graphics FLR errata
> 
> On 04/11/2012 02:03 AM, Hao, Xudong wrote:
> > (Re-rend.)
> >
> > For IvyBridge Mobile platform, a system hang may occur if a FLR(Function
> Level Reset) is asserted to internal graphics.
> >
> > This quirk patch is workaround for the IVB FLR errata issue.
> > We are disabling the FLR reset handshake between the PCH and CPU display,
> then manually powering down the panel power sequencing and resetting the
> PCH display.
> >
> > Changes from v3:
> > - add X86 configuration to avoid compile problem in other architecture.
> >
> > Signed-off-by: Xudong Hao<xudong.hao@intel.com>
> > Signed-off-by: Kay, Allen M<allen.m.kay@intel.com>
> > Reviewed-by: Xiantao Zhang<xiantao.zhang@intel.com>
> > ---
> >   drivers/pci/quirks.c |   59
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 files changed, 59 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > 6476547..63e8b70 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3069,11 +3069,70 @@ static int reset_intel_82599_sfp_virtfn(struct
> pci_dev *dev, int probe)
> >   	return 0;
> >   }
> >
> > +#ifdef CONFIG_X86
> > +
> > +#include "../gpu/drm/i915/i915_reg.h"
> > +#define MSG_CTL	0x45010
> > +
> > +static const int op_timeout = 10;	/* set timeout 10 seconds */
> > +static int reset_ivb_igd(struct pci_dev *dev, int probe) {
> > +	u8 *mmio_base;
> > +	u32 val;
> > +	cycles_t cyc_op_timeout = tsc_khz*op_timeout*1000;
> > +
> Don't we know how to do a 10sec timeout w/o tying it to tsc_khz?
> --> other arch compile problem source???
> 

Of course we have other timeout, this quirk function is only used by IvyBridge mobile which is x86 arch, so I choose tsc_khz.
I have add "#ifdef CONFIG_X86" for avoid other arch compile problem.

> > +	if (probe)
> > +		return 0;
> > +
> > +	mmio_base = ioremap_nocache(pci_resource_start(dev, 0),
> > +				 pci_resource_len(dev, 0));
> > +	if (!mmio_base)
> > +		return -ENOMEM;
> > +
> > +	/* Work Around */
> > +	*((u32 *)(mmio_base + MSG_CTL)) = 0x00000002;
> > +	/* Clobbering SOUTH_CHICKEN2 register is fine only if the next
> > +	 * driver loaded sets the right bits. However, this's a reset and
> > +	 * the bits have been set by i915 previously, so we clobber
> > +	 * SOUTH_CHICKEN2 register directly here.
> > +	 */
> > +	*((u32 *)(mmio_base + SOUTH_CHICKEN2)) = 0x00000005;
> > +	val = *((u32 *)(mmio_base + PCH_PP_CONTROL))&  0xfffffffe;
> > +	*((u32 *)(mmio_base + PCH_PP_CONTROL)) = val;
> above should use readl() & writel()

Thanks, I will use readl() and writel() in next version patch.

> .... and once this & above fixed, then it'll work on other arches???
> 

Other arches do not call this function at all, so it will not impact other arches.

> > +	do {
> > +		cycles_t start_time = get_cycles();
> > +		while (1) {
> > +			val = *((u32 *)(mmio_base + PCH_PP_STATUS));
> > +			if (((val&  0x80000000) == 0)
> > +				&&  ((val&  0x30000000) == 0))
> > +				break;
> > +			if (cyc_op_timeout<  (get_cycles() - start_time))
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
> >   #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
> > +#define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
> > +#define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
> >
> >   static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
> >   	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
> >   		 reset_intel_82599_sfp_virtfn },
> > +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M_VGA,
> > +		reset_ivb_igd },
> > +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
> > +		reset_ivb_igd },
> >   	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> >   		reset_intel_generic_dev },
> >   	{ 0 }
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html

