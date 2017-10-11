Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752099AbdJKLrm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Oct 2017 07:47:42 -0400
Date: Wed, 11 Oct 2017 06:47:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: Dynamically adding a PCI subfunction
Message-ID: <20171011114735.GE25517@bhelgaas-glaptop.roam.corp.google.com>
References: <CAKb7UvjFYoZZCQ8p6gMx_7crUjEA0d29gCB8g7rJz4k=NPcDAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKb7UvjFYoZZCQ8p6gMx_7crUjEA0d29gCB8g7rJz4k=NPcDAA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 09, 2017 at 10:41:38AM -0400, Ilia Mirkin wrote:
> Hello,
> 
> As a bit of background, all NVIDIA GPUs since GT215 have an audio
> subfunction for HDMI(/DP) audio to be sent to the sink. This generally
> works.
> 
> However some, especially laptop, devices come up with that function
> disabled. We have a quirk to enable it when coming back from runpm,
> but that doesn't help the init case. Basically we have to write a bit
> to the PCI config space:
> 
> https://github.com/torvalds/linux/blob/v4.12/drivers/gpu/drm/nouveau/nouveau_drm.c#L783
> 
> (MMIO 0x88000 is an alias for the PCI config space)

  /* do magic */
  nvif_mask(&device->object, 0x088488, (1 << 25), (1 << 25));

Wow, that *is* inscrutable magic.  I gave up trying to convince myself
that this turns into pci_write_config_word() eventually.

0x88000 is way too big for an offset into PCI config space (it's only
4096 bytes per device at most), so I don't know what sort of alias it
could be.  It doesn't look like a MMCONFIG address (which the driver
shouldn't be using directly anyway).

> This works for runtime pm resume, since the device was originally
> there and we just have to make sure the underlying device agrees with
> it, but when it's missing on boot, we have to convince linux that it
> exists, bind a driver, etc.
> 
> What's the best way of going about doing that?

If you make an early quirk for the GPU device, we'll run the quirk
while enumerating it.  If it can enable the audio device, and if the
audio device is at a higher device number, the PCI core should try to
enumerate it later.  But there might be wrinkles if setting the bit
turns a single-function device into a multi-function one, because the
core might have already decided it didn't need to scan for more
functions.  DECLARE_PCI_FIXUP_CLASS_EARLY() is the place to start.

Bjorn
