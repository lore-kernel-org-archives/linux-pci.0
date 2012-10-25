Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:55830 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756494Ab2JYSda (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2012 14:33:30 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so5593034wib.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Oct 2012 11:33:29 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Oct 2012 12:33:09 -0600
Message-ID: <CAErSpo5AeAstcSoJccw75pPUvC8t=36OggcmAOE-56nhW96b8A@mail.gmail.com>
Subject: DRM agp_init error path oops
To: David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I think there's a latent bug in a DRM error path, at least when used
by i915.  In the scenario below, if dev->driver->bus->agp_init()
fails, we call drm_lastclose().  At least in i915_driver_lastclose(),
this dereferences dev->dev_private (at "1" below).

But dev->dev_private isn't initialized until "2", in i915_driver_load().

    i915_pci_probe
        drm_get_pci_dev
            drm_fill_in_dev
                drm_pci_agp_init                (dev->driver->bus->agp_init)
                drm_lastclose                   # error path when agp_init fails
                    i915_driver_lastclose       (dev->driver->lastclose)
                        intel_fb_restore_mode
1)
drm_fb_helper_restore_fbdev_mode(&dev->dev_private->fbdev->helper)
            i915_driver_load                    (dev->driver->load)
2)              dev->dev_private = (void *)dev_priv

We tripped over this because a different bug caused drm_pci_agp_init()
to fail when it shouldn't have.  Details about that bug are here:
https://bugzilla.kernel.org/show_bug.cgi?id=46481#c16

That bug has been fixed, but this dev_private initialization ordering
problem is still there, waiting to bite us again on the next machine
where drm_pci_agp_init() fails for some reason.

Bjorn
