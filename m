Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50871 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755468Ab2DYRvq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Apr 2012 13:51:46 -0400
Received: by lahj13 with SMTP id j13so305857lah.19
        for <linux-pci@vger.kernel.org>; Wed, 25 Apr 2012 10:51:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <403610A45A2B5242BD291EDAE8B37D300FD3ABC3@SHSMSX101.ccr.corp.intel.com>
References: <403610A45A2B5242BD291EDAE8B37D300FD24698@SHSMSX102.ccr.corp.intel.com>
 <CAErSpo4Dm45uRsvdzSAfrvGNPPA_7QqvC_Se-JxpJErsasoTKw@mail.gmail.com> <403610A45A2B5242BD291EDAE8B37D300FD3ABC3@SHSMSX101.ccr.corp.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Apr 2012 11:51:23 -0600
Message-ID: <CAErSpo4Qm1DP-i2YWc1ZibiUAnPC-tLG9X0xceAvGFxs8e+mPQ@mail.gmail.com>
Subject: Re: [PATCH v6] Quirk for IVB graphics FLR errata
To: "Hao, Xudong" <xudong.hao@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <matthew@wil.cx>,
	"Zhang, Xiantao" <xiantao.zhang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 23, 2012 at 9:06 PM, Hao, Xudong <xudong.hao@intel.com> wrote:
>
>> -----Original Message-----
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> Sent: Tuesday, April 24, 2012 5:07 AM
>> To: Hao, Xudong
>> Cc: linux-pci@vger.kernel.org; Don Dutile; Matthew Wilcox; Zhang, Xiantao
>> Subject: Re: [PATCH v6] Quirk for IVB graphics FLR errata
>>
>> On Fri, Apr 20, 2012 at 1:08 AM, Hao, Xudong <xudong.hao@intel.com> wrote:
>> > Hi, Bjorn
>> >
>> > Do you have any other comments for this patch?
>>
>> What happened with the idea of adding a .reset hook in struct pci_driver?  It
>> would be better if all the device-related code could live in the device-specific
>> driver, rather than having to put it in a quirk.  Everybody pays the cost of a
>> quirk, even on systems that don't include this device.
>>
>
> The FLR happened on bus but not for device driver, considering one case that we just want to assign device to guest, but host do not have the device driver, how will a quirk be executed?
>
> Thanks,
> -Xudong
>
>> Bjorn
>>
>> >> -----Original Message-----
>> >> From: Hao, Xudong
>> >> Sent: Monday, April 16, 2012 9:40 AM
>> >> To: 'Bjorn Helgaas'
>> >> Cc: 'linux-pci@vger.kernel.org'; 'Don Dutile'; 'Matthew Wilcox'
>> >> Subject: [PATCH v6] Quirk for IVB graphics FLR errata
>> >>
>> >> For IvyBridge Mobile platform, a system hang may occur if a
>> >> FLR(Function Level
>> >> Reset) is asserted to internal graphics.
>> >>
>> >> This quirk patch is workaround for the IVB FLR errata issue.
>> >> We are disabling the FLR reset handshake between the PCH and CPU
>> >> display, then manually powering down the panel power sequencing and
>> >> resetting the PCH display.
>> >>
>> >> Changes from v5:
>> >> - clean up patch with Matthew's comments.
>> >>
>> >> Signed-off-by: Xudong Hao <xudong.hao@intel.com>
>> >> Signed-off-by: Kay, Allen M <allen.m.kay@intel.com>
>> >> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
>> >> ---
>> >>  drivers/pci/quirks.c |   48
>> >> ++++++++++++++++++++++++++++++++++++++++++++++++
>> >>  1 files changed, 48 insertions(+), 0 deletions(-)
>> >>
>> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
>> >> 4bf7102..213cad9
>> >> 100644
>> >> --- a/drivers/pci/quirks.c
>> >> +++ b/drivers/pci/quirks.c
>> >> @@ -29,6 +29,7 @@
>> >>  #include <linux/sched.h>
>> >>  #include <linux/ktime.h>
>> >>  #include <asm/dma.h> /* isa_dma_bridge_buggy */
>> >> +#include <asm/io.h>
>> >>  #include "pci.h"
>> >>
>> >>  /*
>> >> @@ -3085,11 +3086,58 @@ static int
>> >> reset_intel_82599_sfp_virtfn(struct
>> >> pci_dev *dev, int probe)
>> >>       return 0;
>> >>  }
>> >>
>> >> +#include "../gpu/drm/i915/i915_reg.h"
>> >> +#define MSG_CTL      0x45010
>> >> +#define IGD_OPERATION_TIMEOUT 10000     /* set timeout 10 seconds
>> */
>> >> +
>> >> +static int reset_ivb_igd(struct pci_dev *dev, int probe) {
>> >> +     void __iomem *mmio_base;
>> >> +     unsigned long timeout;
>> >> +     u32 val;
>> >> +
>> >> +     if (probe)
>> >> +             return 0;
>> >> +
>> >> +     mmio_base = ioremap_nocache(pci_resource_start(dev, 0),
>> >> +                              pci_resource_len(dev, 0));
>> >> +     if (!mmio_base)
>> >> +             return -ENOMEM;
>> >> +
>> >> +     /* Work Around */
>> >> +     writel(0x00000002, mmio_base + MSG_CTL);
>> >> +     /* Clobbering SOUTH_CHICKEN2 register is fine only if the next
>> >> +      * driver loaded sets the right bits. However, this's a reset
>> >> + and
>> >> +      * the bits have been set by i915 previously, so we clobber
>> >> +      * SOUTH_CHICKEN2 register directly here.
>> >> +      */
>> >> +     writel(0x00000005, mmio_base + SOUTH_CHICKEN2);
>> >> +     val = readl(mmio_base + PCH_PP_CONTROL) & 0xfffffffe;
>> >> +     writel(val, mmio_base + PCH_PP_CONTROL);
>> >> +     timeout = jiffies + msecs_to_jiffies(IGD_OPERATION_TIMEOUT);
>> >> +     while (time_before(jiffies, timeout)) {
>> >> +             val = readl(mmio_base + PCH_PP_STATUS);
>> >> +             if ((val & 0xB0000000) == 0)
>> >> +                     break;
>> >> +             cpu_relax();
>> >> +     }
>> >> +     writel(0x00000002, mmio_base + 0xd0100);
>> >> +
>> >> +     iounmap(pci_resource_start(dev, 0));
>> >> +     return 0;
>> >> +}
>> >> +
>> >>  #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
>> >> +#define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156 #define
>> >> +PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
>> >>
>> >>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] =
>> >> {
>> >>       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>> >>                reset_intel_82599_sfp_virtfn },
>> >> +     { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M_VGA,
>> >> +             reset_ivb_igd },
>> >> +     { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
>> >> +             reset_ivb_igd },
>> >>       { PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>> >>               reset_intel_generic_dev },
>> >>       { 0 }

If we're doing FLR in a pass-through situation, where the host does
the FLR but has no driver for the device, doing this in a quirk makes
sense to me.

I tried to apply this patch, but it's whitespace-damaged.  Can you repost it?

Bjorn
