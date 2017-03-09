Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34285 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754747AbdCIPNM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2017 10:13:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id u132so11415009wmg.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2017 07:13:06 -0800 (PST)
Date: Thu, 9 Mar 2017 16:03:47 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Lukas Wunner <lukas@wunner.de>
Cc: dri-devel@lists.freedesktop.org,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Darren Hart <dvhart@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Andy Shevchenko <andy@infradead.org>,
        Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH 0/5] Thunderbolt GPU fixes
Message-ID: <20170309150347.a4k4w2sclox2365t@phenom.ffwll.local>
References: <cover.1487938188.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1487938188.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 24, 2017 at 08:19:45PM +0100, Lukas Wunner wrote:
> Fix Thunderbolt-related issues in apple-gmux and vga_switcheroo:
> 
> Patch [1/5] ("Recognize Thunderbolt devices") has already been subjected
> to a fair amount of scrutiny over at linux-pci@, I've submitted it 5 times
> total since May 2016.  With luck it may be in ack-able shape now.
> 
> Patch [2/5] amends apple-gmux to handle combined DP/Thunderbolt ports
> properly on newer MacBook Pros.
> 
> Patches [3/5] to [5/5] avoid registering external Thunderbolt GPUs with
> vga_switcheroo:  Dave Airlie designed vga_switcheroo to register GPUs
> unconditionally.  So if a desktop box has multiple GPUs, vga_switcheroo
> will see more than one discrete GPU but that's not a problem because on
> desktop boxes no handler is registered and thus vga_switcheroo_enable()
> is never called.  Hybrid graphics laptops on the other hand do register
> a handler, but are assumed to never register more than one discrete GPU.
> However once a Thunderbolt eGPU is attached to a hybrid graphics laptop,
> that assumption is no longer true and things go south when vga_switcheroo
> runtime suspends the external discrete GPU and then calls the handler to
> cut power to the internal discrete GPU.  The driver for the internal GPU
> will sit there puzzled and typically cause a lockup.
> 
> This series is just a first step towards proper handling of eGPUs, another
> will be support for surprise removal:  DRM drivers need to cease MMIO and
> PCI config space access once a device is gone to avoid delaying device
> teardown or accessing a newly attached replacement device.  Also, MMIO
> reads to removed devices return "all ones", which results in an infinite
> loop e.g. in nouveau's nvkm_nsec().
> 
> The question is how to recognize device removal.  One common method is to
> read the vendor register with pci_device_is_present(), but this reports
> a false positive if the device is present but in D3cold.  A better method
> is to let the PCIe hotplug driver recognize and cache device removal.
> Keith Busch has developed patches which do exactly that, they're now at
> v6 and fully reviewed by Christoph Hellwig but alas were not included in
> the 4.11 PCI pull for some reason:
> http://www.spinics.net/lists/linux-pci/msg58123.html
> 
> I've pushed the present series to GitHub in case anyone prefers reviewing
> it in a GUI:
> https://github.com/l1k/linux/commits/thunderbolt_gpu_v1

For merging, should I smash this all into drm-misc? The only thing outside
is the apple-gmux driver ...
-Daniel


> 
> Thanks,
> 
> Lukas
> 
> 
> Lukas Wunner (5):
>   PCI: Recognize Thunderbolt devices
>   apple-gmux: Don't switch external DP port on 2011+ MacBook Pros
>   drm/nouveau: Don't register Thunderbolt eGPU with vga_switcheroo
>   drm/radeon: Don't register Thunderbolt eGPU with vga_switcheroo
>   drm/amdgpu: Don't register Thunderbolt eGPU with vga_switcheroo
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  3 ++-
>  drivers/gpu/drm/nouveau/nouveau_vga.c      | 10 +++++++++-
>  drivers/gpu/drm/radeon/radeon_device.c     |  7 +++++--
>  drivers/gpu/drm/radeon/radeon_kms.c        |  3 ++-
>  drivers/pci/pci.h                          |  2 ++
>  drivers/pci/probe.c                        | 21 ++++++++++++++++++++
>  drivers/platform/x86/apple-gmux.c          | 31 +++++++++++++++++++++++++++++-
>  include/linux/pci.h                        | 23 ++++++++++++++++++++++
>  9 files changed, 99 insertions(+), 8 deletions(-)
> 
> -- 
> 2.11.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
