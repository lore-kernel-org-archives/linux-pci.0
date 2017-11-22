Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12153 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbdKVHw3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Nov 2017 02:52:29 -0500
Message-ID: <1511337146.4512.6.camel@linux.intel.com>
Subject: Re: [PATCH 09/30] drm/i915: deprecate pci_get_bus_and_slot()
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        timur@codeaurora.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date: Wed, 22 Nov 2017 09:52:26 +0200
In-Reply-To: <1511328675-21981-10-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
         <1511328675-21981-10-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dropping the extra mailing lists and Dave, this is a rather trivial thing.

On Wed, 2017-11-22 at 00:30 -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

<SNIP>

> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -419,7 +419,9 @@ static int i915_getparam(struct drm_device *dev, void *data,
>  
>  static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
>  {
> -	dev_priv->bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> +	uint16_t devfn = PCI_DEVFN(0, 0)

The would have to be "unsigned int" according to the function
signature.

> +
> +	dev_priv->bridge_dev = pci_get_domain_bus_and_slot(0, 0, devfn);

But the most straightforward change is to simply convert to:

	dev_priv->bridge_dev = pci_get_domain_bus_and_slot(0, 0,
							   PCI_DEVFN(0, 0));

Can you please resend like that.

Looks like this is a part of abigger series, so others may prefer
latter form too, to avoid the variable.

Regards, Joonas
-- 
Joonas Lahtinen
Open Source Technology Center
Intel Corporation
