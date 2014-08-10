Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37005 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbaHJAg1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Aug 2014 20:36:27 -0400
Received: by mail-ig0-f180.google.com with SMTP id l13so2683127iga.7
        for <linux-pci@vger.kernel.org>; Sat, 09 Aug 2014 17:36:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMxnaaXxAZAJAdr5AYYRZC_xKFCuyrfY=qpJu8x+P-S+osm5vw@mail.gmail.com>
References: <20140514224339.7f8be3a9@neptune.home> <20140527234255.GJ11907@google.com>
 <20140602201650.35f0e936@neptune.home> <20140602201926.4d476818@neptune.home>
 <20140625005501.7ff7e982@neptune.home> <20140705171503.GC6247@google.com> <CAMxnaaXxAZAJAdr5AYYRZC_xKFCuyrfY=qpJu8x+P-S+osm5vw@mail.gmail.com>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Sun, 10 Aug 2014 02:36:06 +0200
Message-ID: <CAMxnaaXGQe4vg9cY5e2KZBnG4F-z49OriwxEGUE-DCE6MKUryQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	Matthew Garrett <matthew.garrett@nebula.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 10, 2014 at 2:21 AM, Andreas Noever
<andreas.noever@gmail.com> wrote:
> On Sat, Jul 5, 2014 at 7:15 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Wed, Jun 25, 2014 at 12:55:01AM +0200, Bruno Prémont wrote:
>>> With commit b4aa0163056b ("efifb: Implement vga_default_device() (v2)")
>>> Matthew Garrett introduced a efifb vga_default_device() so that EFI
>>> systems that do not load shadow VBIOS or setup VGA get proper value for
>>> boot_vga PCI sysfs attribute on the corresponding PCI device.
>>>
>>> Xorg is refusing to detect devices when boot_vga=0 which is the case on
>>> some EFI system (e.g. MacBookAir2,1). Xorg detects the GPU and finds
>>> the dri device but then bails out with "no devices detected".
>>>
>>> Note: When vga_default_device() is set boot_vga PCI sysfs attribute
>>> reflects its state. When unset this attribute is 1 whenever
>>> IORESOURCE_ROM_SHADOW flag is set.
>>>
>>> With introduction of sysfb/simplefb/simpledrm efifb is getting obsolete
>>> while having native drivers for the GPU also makes selecting
>>> sysfb/efifb optional.
>>>
>>> Remove the efifb implementation of vga_default_device() and initialize
>>> vgaarb's vga_default_device() with the PCI GPU that matches boot
>>> screen_info in pci_fixup_video().
>>>
>>> Tested-by: Anibal Francisco Martinez Cortina <linuxkid.zeuz@gmail.com>
>>> Cc: Matthew Garrett <matthew.garrett@nebula.com>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
>>
>> I applied both with Matthew's ack to pci/misc for v3.17, thanks!
>
> I just tried to run the latest kernel.  It failed to boot and git
> bisect points to this commit (MacBookPro10,1 with Nvidia&Intel
> graphics).
>
> The (now removed) code in efifb_setup did always set default_vga, even
> if it had already been set earlier. The new code in pci_fixup_video
> runs only if vga_default_device() is NULL. Removing the check fixes
> the regression.
>
>
> The following calls to vga_set_default_device are made during boot:
>
> vga_arbiter_add_pci_device -> vga_set_default_device(intel)
> pci_fixup_video -> vga_set_default_device(intel) (there are two calls
> in pci_fixup_video, this one is the one near "Boot video device")
> pci_fixup_video -> vga_set_default_device(nvidia) (from the "Does
> firmware framebuffer belong to us?" loop, only if I remove the check)
>
> vga_arbiter_add_pci_device chooses intel simply because it is the
> first device. Next pci_fixup_video(intel) sees that it is the default
> device, sets the IORESOURCE_ROM_SHADOW flag and calls
> vga_set_default_device again. And finally (if the check is removed)
> pci_fixup_video(nvidia) sees that it owns the framebuffer and sets
> itself as the default device which allows the system to boot again.
>
> Does setting the ROM_SHADOW flag on (possibly) the wrong device have
> any effect?
Yes it does. Removing the line changes a long standing
i915 0000:00:02.0: Invalid ROM contents
into a
i915 0000:00:02.0: BAR 6: can't assign [??? 0x00000000 flags
0x20000000] (bogus alignment).

The first is logged at KERN_ERR and the second one only at KERN_INFO.
We are making progress.
