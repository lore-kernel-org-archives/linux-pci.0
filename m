Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:36369 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbaFBSUQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jun 2014 14:20:16 -0400
Date: Mon, 2 Jun 2014 20:16:50 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>
Subject: Re: [Patch] x86, ia64, efifb: Move boot_vga fixup from pci to
 vgaarb
Message-ID: <20140602201650.35f0e936@neptune.home>
In-Reply-To: <20140527234255.GJ11907@google.com>
References: <20140514224339.7f8be3a9@neptune.home>
	<20140527234255.GJ11907@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 27 May 2014 Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, May 14, 2014 at 10:43:39PM +0200, Bruno Prémont wrote:
> > With commit b4aa0163056b6c70029b6e8619ce07c274351f42 Matthew Garret
> 
> I think there's an emerging convention to use reference commits as
> <12-char-SHA1> ("subject"), i.e.,
> 
>     b4aa0163056b ("efifb: Implement vga_default_device() (v2)")
> 
> for this case.  Also, s/Garret/Garrett/.

Adjusted

> > introduced a efifb vga_default_device() so that EFI systems that do not
> > load shadow VBIOS or setup VGA get proper value for boot_vga PCI sysfs
> > attribute on the corresponding PCI device.
> > 
> > Xorg is refusing to autodetect devices when boot_vga=0 which is the case
> > on some EFI system (e.g. MacBookAir2,1). Xorg detects the GPU and finds
> > the dri device but then bails out with "no devices detected".
> > 
> > With introduction of sysfb/simplefb/simpledrm efifb is getting obsolete
> > while having native drivers for the GPU also makes selecting
> > sysfb/efifb optional.
> > 
> > Remove the efifb implementation of vga_default_device() and initialize
> > vgaarb's vga_default_device() with the PCI GPU that matches boot
> > screen_info in pci_fixup_video() [x86 and ia64 pci_fixup_video merged
> > into common function in vgaarb.c].
> 
> I think it would be good to split this into two patches:
> 
>   1) Merge the x86 and ia64 pci_fixup_video() implementations.  This should
>   have no functional change at all.
> 
>   2) Whatever else you need to actually fix the bug.  This will be much
>   smaller, and the actual bug fix will be easier to see.
> 
> It would also be nice to have a URL for a bugzilla or mailing list report
> of the problem, where there might be dmesg and/or Xorg logs.
> 
> This sounds like it might be applicable for the stable kernels.  If so, you
> probably should order these so the small bug-fix comes first (even though
> this may mean applying the same bugfix for x86 and ia64), and the merge
> second.  That way the fix can be applied to the stable kernels without the
> merge.

Split up patches come in reply to this mail

> > Other architectures with PCI GPU might need a similar fixup.
> > 
> > Note: If CONFIG_VGA_ARB is unset vga_default_device() is only available
> >       as a stub that returns NULL, making this adjustment insufficient.
> >       In addition, with the merge of x86/ia64 fixup code, this would
> >       also result in disabled fixup.
> >       Unsetting CONFIG_VGA_ARB requires CONFIG_EXPERT=y though.
> 
> I'm not quite sure what this means, or if this is hint that something is
> still wrong even with this patch.  Do you mean that if CONFIG_VGA_ARB is
> unset, something still doesn't work?
> 
> Maybe this will become obvious to me when you split up the patch.

This means that if someone unsets CONFIG_VGA_ARB (he need to set CONFIG_EXPERT
to do so) the fixup will not happen at all.

Without fixup the systems that need to set the IORESOURCE_ROM_SHADOW
flag will not have it, and boot_vga pci device attribute will be 0
more often as well.

Moving the unified function somewhere else than vgaarb.c would fix the new
IORESOURCE_ROM_SHADOW fixup dependency on VGA_ARB, though not prevent the
issue I try to fix as vga_default_device() always returns NULL without VGA_ARB.

One possible location would be drivers/pci/quirks.c.

Bruno

> > Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> > ---
> > This is ported to changes in pci/fixup.c that landed in 3.15-rcs.
> > 
> > Is this fine to go in, if so who will take it?
> > 
> > I got no feedback on my last respin (on top of 3.14 a couple of weeks ago,
> > which added moving the ia64 pci boot_vga fixup).
> > I've been running this revision for a week or so on 3.15-rc kernels here
> > (mostly EFI-enabled system, the mentioned MBA as wells as non-Apple systems
> > where the patch was not required).
