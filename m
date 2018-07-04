Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46643 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeGDHOS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2018 03:14:18 -0400
Received: by mail-wr0-f196.google.com with SMTP id s11-v6so4182265wra.13
        for <linux-pci@vger.kernel.org>; Wed, 04 Jul 2018 00:14:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625210606.2736-3-alexander.deucher@amd.com>
References: <20180625210606.2736-1-alexander.deucher@amd.com> <20180625210606.2736-3-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Jul 2018 03:14:16 -0400
Message-ID: <CADnq5_NQFYp6z+TaUGHSqmCh4L5LX1jiJMHM1sTux_KvM94fmA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: update amd_pcie.h to include gen4 speeds
To: amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2018 at 5:06 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
> Internal header used by the driver to specify pcie gen
> speeds of the asic and chipset.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Anyone care to review patches 2,3,4?

> ---
>  drivers/gpu/drm/amd/include/amd_pcie.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/amd_pcie.h b/drivers/gpu/drm/amd/include/amd_pcie.h
> index 5eb895fd98bf..9cb9ceb4d74d 100644
> --- a/drivers/gpu/drm/amd/include/amd_pcie.h
> +++ b/drivers/gpu/drm/amd/include/amd_pcie.h
> @@ -27,6 +27,7 @@
>  #define CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1        0x00010000
>  #define CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2        0x00020000
>  #define CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3        0x00040000
> +#define CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4        0x00080000
>  #define CAIL_PCIE_LINK_SPEED_SUPPORT_MASK        0xFFFF0000
>  #define CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT       16
>
> @@ -34,6 +35,7 @@
>  #define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN1   0x00000001
>  #define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN2   0x00000002
>  #define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN3   0x00000004
> +#define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN4   0x00000008
>  #define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_MASK   0x0000FFFF
>  #define CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_SHIFT  0
>
> --
> 2.13.6
>
