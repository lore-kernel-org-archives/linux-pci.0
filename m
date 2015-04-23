Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36997 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758242AbbDWV4B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Apr 2015 17:56:01 -0400
Received: by widdi4 with SMTP id di4so608200wid.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2015 14:56:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150423213015.GA7888@google.com>
References: <alpine.DEB.2.00.1504200432000.1232@skynet.skynet.ie>
	<CA+55aFyVMfTBB0oz_yx8+eQOEJnzGtCsYSj9QuhEpdZ9BHdq5A@mail.gmail.com>
	<20150423213015.GA7888@google.com>
Date: Thu, 23 Apr 2015 14:56:00 -0700
Message-ID: <CAPeXnHsrQrkeJ3QQ6ds6yhY0C31DKqnR2uHSm9rcXdGEHBDDAg@mail.gmail.com>
Subject: Re: git pull] drm for v4.1-rc1
From: Matthew Garrett <matthew.garrett@coreos.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg59@coreos.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 23, 2015 at 2:30 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> Your i915 does not have a ROM BAR in hardware.  If the default video
> device has no ROM BAR, pci_fixup_video() sets IORESOURCE_ROM_SHADOW
> even though the resource flags are zero because the BAR itself doesn't
> exist.
>
> If IORESOURCE_ROM_SHADOW is set, pci_map_rom() assumes there's a
> shadow ROM image at 0xC0000.  Is there a shadow image even if the
> device itself doesn't have a ROM BAR?

On UEFI systems, there's no special reason to believe that there's
anything at 0xc0000 - it depends on whether a CSM got loaded or not.
Everything is awful. So...

>   int pcibios_add_device(struct pci_dev *dev)
>   {
>     if (dev-is-default-vga-device) {
>       dev->rom = 0xC0000;
>       dev->romlen = 0x20000;
>     }

I don't know what we want to do here. This is, at some level,
fundamentally wrong - however, it also wouldn't surprise me if this is
also the only copy of the video ROM we have on some UEFI systems,
especially since I believe that Windows 7 still required that there be
a legacy ROM it could use for bootloader modesetting on UEFI
platforms. So simply making this conditional on BIOS may break
existing machines. But if there *is* a ROM there then we should be
able to id it from the usual video ROM signature?
