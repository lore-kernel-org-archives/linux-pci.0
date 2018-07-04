Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35302 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932920AbeGDIip (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2018 04:38:45 -0400
Received: by mail-wr0-f194.google.com with SMTP id h40-v6so4443703wrh.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Jul 2018 01:38:44 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 0/5] drm: use core pcie functionality for pcie gen/width
To: Alex Deucher <alexdeucher@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20180625210606.2736-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d285dc8f-d0a5-2397-cf85-3c55eb445cf9@gmail.com>
Date: Wed, 4 Jul 2018 10:38:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180625210606.2736-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Whole series is Acked-by: Christian König <christian.koenig@amd.com>.

BTW: With patch #2 you created quite some noise in the news:

https://www.tomshardware.com/news/amd-vega-20-pcie-4.0,37389.html

Cheers,
Christian.

Am 25.06.2018 um 23:06 schrieb Alex Deucher:
> This series exports some pcie helper functions for use by drivers and
> fixes up the amdgpu and radeon drivers to use this core functionality
> rather than the duplicated functionality in the drm.  Finally we remove
> the drm helpers since the duplicate the pcie functionality of the core.
> This also adds proper pcie gen4 detection for amdgpu.
>
> Alex Deucher (5):
>    pci: export pcie_get_speed_cap and pcie_get_width_cap
>    drm/amdgpu: update amd_pcie.h to include gen4 speeds
>    drm/amdgpu: use pcie functions for link width and speed
>    drm/radeon: use pcie functions for link width
>    drm: drop drm_pcie_get_speed_cap_mask and drm_pcie_get_max_link_width
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 83 +++++++++++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    |  7 ++-
>   drivers/gpu/drm/amd/amdgpu/ci_dpm.c        |  3 +-
>   drivers/gpu/drm/amd/amdgpu/si_dpm.c        |  3 +-
>   drivers/gpu/drm/amd/include/amd_pcie.h     |  2 +
>   drivers/gpu/drm/drm_pci.c                  | 58 ---------------------
>   drivers/gpu/drm/radeon/ci_dpm.c            | 20 +++++--
>   drivers/gpu/drm/radeon/cik.c               | 22 ++++----
>   drivers/gpu/drm/radeon/r600_dpm.c          |  4 +-
>   drivers/gpu/drm/radeon/radeon.h            |  4 ++
>   drivers/gpu/drm/radeon/si.c                | 22 ++++----
>   drivers/gpu/drm/radeon/si_dpm.c            | 20 +++++--
>   drivers/pci/pci.c                          |  2 +
>   include/drm/drm_pci.h                      |  7 ---
>   include/linux/pci.h                        |  3 ++
>   15 files changed, 132 insertions(+), 128 deletions(-)
>
