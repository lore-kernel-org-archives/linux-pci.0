Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from claranet-outbound-smtp02.uk.clara.net ([195.8.89.35]:59935 "EHLO
	claranet-outbound-smtp02.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756731Ab2JSOws (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2012 10:52:48 -0400
From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	bhelgaas@google.com
Subject: Re: GPU RC6 breaks PCIe to PCI bridge connected to CPU PCIe slot on SandyBridge systems
Date: Fri, 19 Oct 2012 15:52:32 +0100
Message-ID: <3896332.1fABn9rFR8@f17simon>
In-Reply-To: <CAKMK7uHHn0H1usv=7Msdvg6vW4PDRaFvtRG7m=c9ENw+c_PE4g@mail.gmail.com>
References: <1704067.2NCOGYajHN@f17simon> <CAKMK7uHHn0H1usv=7Msdvg6vW4PDRaFvtRG7m=c9ENw+c_PE4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5364821.besjWlMyCd"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nextPart5364821.besjWlMyCd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 19 October 2012 16:26:08 Daniel Vetter wrote:
> On Fri, Oct 19, 2012 at 12:26 PM, Simon Farnsworth
> <simon.farnsworth@onelan.co.uk> wrote:
> > Hello,
> >
> > I've just been trying to work out why a PCIe to PCI bridge worked with kernel
> > 3.3, but not with kernel 3.5 or Linus's git master. I bisected down to bad:
> > [aa46419186992e6b8b8010319f0ca7f40a0d13f5] drm/i915: enable plain RC6 on Sandy
> > Bridge by default.
> >
> > I then confirmed that on a failing kernel (3.5 or Linus git
> > 8d2b6b3ae280dcf6f6c7a95623670a57cdf562ed from Tuesday 16th, "Merge tag 'sh-
> > for-linus' of git://github.com/pmundt/linux-sh"), I can make the failure
> > disappear by adding i915.i915_enable_rc6=0 to the kernel command line, and I
> > can make it reappear by changing the value of i915_enable_rc6 to -1.
> >
> > I've attached lspci -vvxxxxx output from a failure case and from a working
> > case as lspci.faulty and lspci.working; if you need anything more, just ask
> > for it.
> >
> > My hardware is an Intel DH67CF motherboard, with an i3-2100 CPU; there is a
> > Startech branded PCIe to PCI bridge in the PCIe x16 slot (which I believe is
> > connected to the CPU PCIe lanes, not the PCH PCIe lanes). I have a Hauppauge
> > HVR-1110 in the PCI slot provided by the bridge.
> >
> > I have two test cases; one is transferring MPEG-2 transport streams from the
> > DVB-T tuner on the card (no graphics involved), the other is using the V4L2
> > interface to capture buffers via the mmap() mechanism, which are then uploaded
> > to the XServer via the Xv extension, and composited using an OpenGL compositor
> > that uses texture_from_pixmap.
> 
> Ok, this is really freaky stuff. One thing to triage: Is it just
> sufficient to put the gpu into rc6 to corrupt the dma transfers, or is
> some light X/gpu load required? In either case, rc6 being able to
> corrupt random dma transfers (or at least prevent them from reaching
> their destination) would be a fitting explanation for the leftover rc6
> issues on snb ...
> 
In an attempt to have this happen with the GPU as idle as possible, I did the
following (note that I'm on a gigabit Ethernet segment, so I can burn network
bandwidth while testing):

1. Start X.org with -noreset, and don't start any X clients.
2. Run "xset dpms force off ; xrandr --output DP2 --off" (DP2 is the connected output).
3. On the affected machine, run "gst-launch v4l2src ! gdppay ! tcpclientsink host=f17simon port=65512"
4. On my desktop, run "gst-launch tcpserversrc host=0.0.0.0 port=65512 ! gdpdepay ! xvimagesink"

I see the corruption continue to happen, even though the GPU should be idle
and in RC6 state most of the time (confirmed by reading
/sys/class/drm/card0/power/rc6_residency_ms and seeing it increase between
reads). When I run intel_forcewaked from intel_gpu_tools, the corruption goes
away, and I can confirm by reading /sys/class/drm/card0/power/rc6_residency_ms
that the GPU does not enter RC6. Killing intel_forcewaked makes the corruption
reappear while streaming over the network (X11 idle).
-- 
Simon Farnsworth
Software Engineer
ONELAN Ltd
http://www.onelan.com

--nextPart5364821.besjWlMyCd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAABAgAGBQJQgWkzAAoJEIKsye9/dtRWTAwH/3fAns8K7PhmvTt/4c/dUIIS
EGK/oKP6r8dPeIit+Hv2LNIEe4SLdAdF9XpLSQQMkM99JjA9/NVakPhAAiqtyHbI
3OikjP+tUaXZQ8WcArU56RFgEegb07TDt0huH6xMmIZag07paz/E3nOdwbopWDJB
DAUbhUPJuAfemjGblo/3lfe+SD3HIVnWUNlIl06e30k+NFwUunIBNnQTMgucVTuO
GT5Idvm3lJtCbxGY/Ky5uqipQcfsDdTl8Qe8yQxP0KKKdor481w6LiYAppXGv81g
Xrx3PN/IhJEmlLogz4cWndJ+YeZb7lPzbx8fRL6cjBhHd5q9N+2WhFnoleYa6Pc=
=hqTy
-----END PGP SIGNATURE-----

--nextPart5364821.besjWlMyCd--

