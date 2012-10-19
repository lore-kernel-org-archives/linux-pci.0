Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57891 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759182Ab2JSO0K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2012 10:26:10 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so266446wey.19
        for <linux-pci@vger.kernel.org>; Fri, 19 Oct 2012 07:26:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1704067.2NCOGYajHN@f17simon>
References: <1704067.2NCOGYajHN@f17simon>
Date: Fri, 19 Oct 2012 16:26:08 +0200
Message-ID: <CAKMK7uHHn0H1usv=7Msdvg6vW4PDRaFvtRG7m=c9ENw+c_PE4g@mail.gmail.com>
Subject: Re: GPU RC6 breaks PCIe to PCI bridge connected to CPU PCIe slot on
 SandyBridge systems
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Cc: linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	bhelgaas@google.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 19, 2012 at 12:26 PM, Simon Farnsworth
<simon.farnsworth@onelan.co.uk> wrote:
> Hello,
>
> I've just been trying to work out why a PCIe to PCI bridge worked with kernel
> 3.3, but not with kernel 3.5 or Linus's git master. I bisected down to bad:
> [aa46419186992e6b8b8010319f0ca7f40a0d13f5] drm/i915: enable plain RC6 on Sandy
> Bridge by default.
>
> I then confirmed that on a failing kernel (3.5 or Linus git
> 8d2b6b3ae280dcf6f6c7a95623670a57cdf562ed from Tuesday 16th, "Merge tag 'sh-
> for-linus' of git://github.com/pmundt/linux-sh"), I can make the failure
> disappear by adding i915.i915_enable_rc6=0 to the kernel command line, and I
> can make it reappear by changing the value of i915_enable_rc6 to -1.
>
> I've attached lspci -vvxxxxx output from a failure case and from a working
> case as lspci.faulty and lspci.working; if you need anything more, just ask
> for it.
>
> My hardware is an Intel DH67CF motherboard, with an i3-2100 CPU; there is a
> Startech branded PCIe to PCI bridge in the PCIe x16 slot (which I believe is
> connected to the CPU PCIe lanes, not the PCH PCIe lanes). I have a Hauppauge
> HVR-1110 in the PCI slot provided by the bridge.
>
> I have two test cases; one is transferring MPEG-2 transport streams from the
> DVB-T tuner on the card (no graphics involved), the other is using the V4L2
> interface to capture buffers via the mmap() mechanism, which are then uploaded
> to the XServer via the Xv extension, and composited using an OpenGL compositor
> that uses texture_from_pixmap.

Ok, this is really freaky stuff. One thing to triage: Is it just
sufficient to put the gpu into rc6 to corrupt the dma transfers, or is
some light X/gpu load required? In either case, rc6 being able to
corrupt random dma transfers (or at least prevent them from reaching
their destination) would be a fitting explanation for the leftover rc6
issues on snb ...

Thanks, Daniel

>
> In both cases, the behaviour I see is that some DMA transfers don't transfer
> data; the DMA apparently completes, and addresses are updated correctly, but
> data bytes don't change. This results in corruption in the MPEG-2 transport
> streams, and in pixel spans not updating in the V4L2 case. Disabling RC6 fully
> fixes this.
>
> This isn't a deal-breaker for my application - I can force off RC6 and live
> with the extra power draw for now. However, I'd prefer to be able to run
> without command line options in the future.
>
> I'm happy to try patches, even if the goal is just to get you some more debug
> information; long term, I'd like to be able to remove the command line option,
> as I run a single software image on multiple boxes, not all of which have the
> PCIe to PCI bridge fitted, and on those that don't use the PCIe to PCI bridge,
> I'd like to run with the power savings of RC6.
> --
> Simon Farnsworth
> Software Engineer
> ONELAN Ltd
> http://www.onelan.com



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
