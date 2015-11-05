Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.fireflyinternet.com ([87.106.93.118]:56785 "EHLO
	fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031373AbbKENhl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2015 08:37:41 -0500
Date: Thu, 5 Nov 2015 13:37:33 +0000
From: Chris Wilson <chris@chris-wilson.co.uk>
To: ville.syrjala@linux.intel.com
Cc: intel-gfx@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/29] pci: Decouple quirks.c from i915_reg.h
Message-ID: <20151105133733.GG669@nuc-i3427.alporthouse.com>
References: <1446672017-24497-1-git-send-email-ville.syrjala@linux.intel.com>
 <1446672017-24497-2-git-send-email-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1446672017-24497-2-git-send-email-ville.syrjala@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 04, 2015 at 11:19:49PM +0200, ville.syrjala@linux.intel.com wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> i915 register defines are going to become type safe, so going forward
> the register defines can't be used as straight numbers. Since quirks.c
> needs just a few extra register defines from i915_reg.h, decouple the
> two by defining the required registers locally in quirks.c. This was
> already done for a few other igpu related registers.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/pci/quirks.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b03373f..78a70fb 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3404,7 +3404,9 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> -#include "../gpu/drm/i915/i915_reg.h"
> +#define SOUTH_CHICKEN2		0xc2004
> +#define PCH_PP_STATUS		0xc7200
> +#define PCH_PP_CONTROL		0xc7204
>  #define MSG_CTL			0x45010
>  #define NSDE_PWR_STATE		0xd0100
>  #define IGD_OPERATION_TIMEOUT	10000     /* set timeout 10 seconds */

Considering this is in a mixed set of quirks, perhaps now would be a
good time to give them an I915_^W IGD_ prefix as well?

But as far as the simple replacement goes,
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
