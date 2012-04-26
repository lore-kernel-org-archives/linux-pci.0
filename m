Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55016 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab2DZXPV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 19:15:21 -0400
Received: by lbbgf7 with SMTP id gf7so106430lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 16:15:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <403610A45A2B5242BD291EDAE8B37D300FD8BEA9@SHSMSX102.ccr.corp.intel.com>
References: <403610A45A2B5242BD291EDAE8B37D300FD24698@SHSMSX102.ccr.corp.intel.com>
 <CAErSpo4Dm45uRsvdzSAfrvGNPPA_7QqvC_Se-JxpJErsasoTKw@mail.gmail.com>
 <403610A45A2B5242BD291EDAE8B37D300FD3ABC3@SHSMSX101.ccr.corp.intel.com>
 <CAErSpo4Qm1DP-i2YWc1ZibiUAnPC-tLG9X0xceAvGFxs8e+mPQ@mail.gmail.com> <403610A45A2B5242BD291EDAE8B37D300FD8BEA9@SHSMSX102.ccr.corp.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 26 Apr 2012 17:14:57 -0600
Message-ID: <CAErSpo4tUnA6oFr1uXyfVPHQh7F-LMN913pu=MfaEsRi5isLLQ@mail.gmail.com>
Subject: Re: [PATCH v6] Quirk for IVB graphics FLR errata
To: "Hao, Xudong" <xudong.hao@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <matthew@wil.cx>,
	"Zhang, Xiantao" <xiantao.zhang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 25, 2012 at 9:19 PM, Hao, Xudong <xudong.hao@intel.com> wrote:
> For IvyBridge Mobile platform, a system hang may occur if a FLR(Function Level Reset) is asserted to internal graphics.
>
> This quirk patch is workaround for the IVB FLR errata issue.
> We are disabling the FLR reset handshake between the PCH and CPU display, then
> manually powering down the panel power sequencing and resetting the PCH display.
>
> Signed-off-by: Xudong Hao <xudong.hao@intel.com>
> Signed-off-by: Kay, Allen M <allen.m.kay@intel.com>
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> ---
>  drivers/pci/quirks.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 48 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4bf7102..213cad9 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched.h>
>  #include <linux/ktime.h>
>  #include <asm/dma.h>   /* isa_dma_bridge_buggy */
> +#include <asm/io.h>
>  #include "pci.h"
>
>  /*
> @@ -3085,11 +3086,58 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
>        return 0;
>  }
>
> +#include "../gpu/drm/i915/i915_reg.h"
> +#define MSG_CTL        0x45010
> +#define IGD_OPERATION_TIMEOUT 10000     /* set timeout 10 seconds */
> +
> +static int reset_ivb_igd(struct pci_dev *dev, int probe)
> +{
> +       void __iomem *mmio_base;
> +       unsigned long timeout;
> +       u32 val;
> +
> +       if (probe)
> +               return 0;
> +
> +       mmio_base = ioremap_nocache(pci_resource_start(dev, 0),
> +                               pci_resource_len(dev, 0));
> +       if (!mmio_base)
> +               return -ENOMEM;
> +
> +       /* Work Around */
> +       writel(0x00000002, mmio_base + MSG_CTL);
> +       /* Clobbering SOUTH_CHICKEN2 register is fine only if the next
> +        * driver loaded sets the right bits. However, this's a reset and
> +        * the bits have been set by i915 previously, so we clobber
> +        * SOUTH_CHICKEN2 register directly here.
> +        */
> +       writel(0x00000005, mmio_base + SOUTH_CHICKEN2);
> +       val = readl(mmio_base + PCH_PP_CONTROL) & 0xfffffffe;
> +       writel(val, mmio_base + PCH_PP_CONTROL);
> +       timeout = jiffies + msecs_to_jiffies(IGD_OPERATION_TIMEOUT);
> +       while (time_before(jiffies, timeout)) {
> +               val = readl(mmio_base + PCH_PP_STATUS);
> +               if ((val & 0xB0000000) == 0)
> +                       break;
> +               cpu_relax();
> +       }
> +       writel(0x00000002, mmio_base + 0xd0100);
> +
> +       iounmap(pci_resource_start(dev, 0));
> +       return 0;
> +}
> +
>  #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
> +#define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
> +#define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
>
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>                 reset_intel_82599_sfp_virtfn },
> +       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M_VGA,
> +               reset_ivb_igd },
> +       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
> +               reset_ivb_igd },
>        { PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>                reset_intel_generic_dev },
>        { 0 }
> --
> 1.6.0.rc1
>
>
>> If we're doing FLR in a pass-through situation, where the host does
>> the FLR but has no driver for the device, doing this in a quirk makes
>> sense to me.
>>
>> I tried to apply this patch, but it's whitespace-damaged.  Can you repost it?
>>
>
>
> Thanks Bjorn, I repost it and can you try again?

Did you change anything, or did you just repost it the same way you
did before?  The patch I see is still corrupted.  Here's what I see:


--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <linux/ktime.h>
 #include <asm/dma.h>   /* isa_dma_bridge_buggy */
+#include <asm/io.h>
 #include "pci.h"
=20
...

The "=20" is bogus.
