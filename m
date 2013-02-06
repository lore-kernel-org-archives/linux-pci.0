Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:63420 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab3BFO1B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 09:27:01 -0500
Received: by mail-vc0-f181.google.com with SMTP id d16so876620vcd.26
        for <linux-pci@vger.kernel.org>; Wed, 06 Feb 2013 06:27:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <002b01ce0429$59d7acc0$0d870640$%han@samsung.com>
References: <002b01ce0429$59d7acc0$0d870640$%han@samsung.com>
Date: Wed, 6 Feb 2013 09:27:00 -0500
Message-ID: <CADnq5_NsB=xZA-vMr8OkHF6W0GZgWEyZzBMD5AGMOr_jKj_jCw@mail.gmail.com>
Subject: Re: [PATCH] drm/pci: use PCI_EXP_LNKCAP_SLS_2_5GB/5_0GB instead of
 hardcoded values
From: Alex Deucher <alexdeucher@gmail.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 6, 2013 at 12:18 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> Use PCI_EXP_LNKCAP_SLS_2_5GB and PCI_EXP_LNKCAP_SLS_5_0GB instead
> of hardcoded values for readability. These bit definitions were
> added by commit 130f1b8 ("PCI: Add PCIe Link Capability link speed
> and width names")
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/drm_pci.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
> index 754bc96..11c8add 100644
> --- a/drivers/gpu/drm/drm_pci.c
> +++ b/drivers/gpu/drm/drm_pci.c
> @@ -504,9 +504,9 @@ int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
>                 if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
>                         *mask |= DRM_PCIE_SPEED_80;
>         } else {
> -               if (lnkcap & 1)
> +               if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
>                         *mask |= DRM_PCIE_SPEED_25;
> -               if (lnkcap & 2)
> +               if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
>                         *mask |= DRM_PCIE_SPEED_50;
>         }
>
> --
> 1.7.2.5
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
