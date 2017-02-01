Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34598 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdBAQal (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2017 11:30:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170201162020.24314.27094.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170201162020.24314.27094.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Andreas Boll <andreas.boll.dev@gmail.com>
Date: Wed, 1 Feb 2017 17:30:39 +0100
Message-ID: <CACiKqBcZkX0V2EJPy+sPfDg0LWHSzBbkEVfL4h24iCKBFqqSpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm amdgpu/radeon: clean up d3_delay usage
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For the series:
Reviewed-by: Andreas Boll <andreas.boll.dev@gmail.com>

2017-02-01 17:22 GMT+01:00 Bjorn Helgaas <bhelgaas@google.com>:
> amdgpu doesn't need to touch pdev->d3_delay at all.
>
> radeon has a d3_delay quirk for MacBook Pro, but it only affects
> radeon_switcheroo_set_state().  I think it should affect wakeups done by
> the PCI core as well.
>
> Changes from v1 to v2:
>   - Fix accidental removal of "{ 0, 0, 0, 0, 0 }" quirk list termination
>     (thanks, Andreas Boll!)
>   - Add ack from Alex Deucher
> ---
>
> Bjorn Helgaas (2):
>       drm/amdgpu: remove unnecessary save/restore of pdev->d3_delay
>       drm/radeon: make MacBook Pro d3_delay quirk more generic
>
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    4 ----
>  drivers/gpu/drm/radeon/radeon_device.c     |   11 -----------
>  drivers/pci/quirks.c                       |   13 +++++++++++++
>  3 files changed, 13 insertions(+), 15 deletions(-)
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
