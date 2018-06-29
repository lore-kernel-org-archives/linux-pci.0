Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36007 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbeF2O7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jun 2018 10:59:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so9144283wrm.3
        for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2018 07:59:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625210606.2736-1-alexander.deucher@amd.com>
References: <20180625210606.2736-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Jun 2018 10:59:13 -0400
Message-ID: <CADnq5_NDb0jKaKWq0H8p7eR-qGDn=nYTx8FtemTVAynrFN5xBA@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm: use core pcie functionality for pcie gen/width
To: amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ping on the drm and amdgpu patches.

Alex

On Mon, Jun 25, 2018 at 5:06 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
> This series exports some pcie helper functions for use by drivers and
> fixes up the amdgpu and radeon drivers to use this core functionality
> rather than the duplicated functionality in the drm.  Finally we remove
> the drm helpers since the duplicate the pcie functionality of the core.
> This also adds proper pcie gen4 detection for amdgpu.
>
> Alex Deucher (5):
>   pci: export pcie_get_speed_cap and pcie_get_width_cap
>   drm/amdgpu: update amd_pcie.h to include gen4 speeds
>   drm/amdgpu: use pcie functions for link width and speed
>   drm/radeon: use pcie functions for link width
>   drm: drop drm_pcie_get_speed_cap_mask and drm_pcie_get_max_link_width
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 83 +++++++++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    |  7 ++-
>  drivers/gpu/drm/amd/amdgpu/ci_dpm.c        |  3 +-
>  drivers/gpu/drm/amd/amdgpu/si_dpm.c        |  3 +-
>  drivers/gpu/drm/amd/include/amd_pcie.h     |  2 +
>  drivers/gpu/drm/drm_pci.c                  | 58 ---------------------
>  drivers/gpu/drm/radeon/ci_dpm.c            | 20 +++++--
>  drivers/gpu/drm/radeon/cik.c               | 22 ++++----
>  drivers/gpu/drm/radeon/r600_dpm.c          |  4 +-
>  drivers/gpu/drm/radeon/radeon.h            |  4 ++
>  drivers/gpu/drm/radeon/si.c                | 22 ++++----
>  drivers/gpu/drm/radeon/si_dpm.c            | 20 +++++--
>  drivers/pci/pci.c                          |  2 +
>  include/drm/drm_pci.h                      |  7 ---
>  include/linux/pci.h                        |  3 ++
>  15 files changed, 132 insertions(+), 128 deletions(-)
>
> --
> 2.13.6
>
