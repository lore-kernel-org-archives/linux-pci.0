Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44502 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751760AbaBMSMh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 13:12:37 -0500
Date: Thu, 13 Feb 2014 18:11:48 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kumar Gala <galak@codeaurora.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
	devicetree@vger.kernel.org, grant.likely@linaro.org,
	robh+dt@kernel.org
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140213181148.GC25107@e106331-lin.cambridge.arm.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <20140213110721.GC13576@mudshark.cambridge.arm.com>
 <BA5E6077-77F8-4BE8-80E5-BAB9FE111387@codeaurora.org>
 <4110788.UI9TADVhpa@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4110788.UI9TADVhpa@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[adding devicetree, Grant, Rob]

Apologies to all those who aren't too bothered about the naming, I'm
going to derail this subthread for a general device tree policy
discussion.

On Thu, Feb 13, 2014 at 04:28:20PM +0000, Arnd Bergmann wrote:
> On Thursday 13 February 2014 10:22:25 Kumar Gala wrote:
> > On Feb 13, 2014, at 5:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> > > Happy to change it, but I'm also struggling for names. Maybe "linux,…"?
> >
> > I was thinking that as well, I’d say go with “linux,”.
> 
> I see nothing linux specific in there. I would only use that namespace
> for things we don't expect to work with another OS.

Let's take a stop back. This is an instance of a wider problem, and to
be honest it's a rather trivial one. As usual, because there's been no
policy there's no consistency, and everyone's got their own favourite.

All we need is a policy for how generic bindings are named/prefixed. As
long as this is consistent and unlikely to cause problems it doesn't
really matter what that specific policy is.

Regardless, we need to support our existing bindings.

So far we have instances of (in v3.14-rc2):

A) No prefix

  $ git grep 'compatible\s*=\s*"[^,]*"' -- Documentation/devicetree | \
    awk '{ print $NF }' | sort -u | wc -l
    96

  $ git grep 'compatible\s*=\s*"[^,]*"' -- arch/*/boot/dts | \
    awk ' { print $NF }' | sort -u | wc -l
    233

  These include some commonly use bindings like "fixed-clock",
  "regulator-fixed", and (everybody's favourite) "simple-bus". The
  "ns16550" binding falls here too.
 
  There are subdivisions within this, like "simple-*" and "*-generic".
  There are three "simple-" prefixed variants, perhaps that's worth it's
  own class?
 
  There are also some dubious ones like "ldo4" that are probably only
  appearing in sub-nodes and probably don't matter that much for this
  discussion.


B) "linux," prefixed

  $ git grep 'compatible\s*=\s*"linux,.*"' -- Documentation/devicetree | \
    awk ' { print $NF }' | sort -u | wc -l
    4

  $ git grep 'compatible\s*=\s*"linux,.*"' -- arch/*/boot/dts | \
    awk ' {print $NF }' | sort -u | wc -l
    1

  These include:
  * "linux,hdmi-audio"
  * "linux,spdif-dir"
  * "linux,spdif-dit"
  * "linux,wdt-gpio"

Is there another class I've missed?

If a binding originates for Linux, a "linux," prefix doesn't seem that
bad to me. It's just a namespace, it doesn't have to mean that it's only
ever going to work for Linux, and two such bindings within Linux
shouldn't be able to collide.

As long as we choose something that reduces the possibility of name
collisions (several people might come up with incompatible "pci"
bindings) then we're fine regardless of the particular prefix or lack
thereof. A "generic," prefix feels like it's too easy to collide with if
another community also creates bindings.

Thoughts?

One final option for generic bindings would be a prefix per-author (e.g.
in this case the compatible string could be "will-deacon,pci"). That
might lead to the fewest namespace issues in future, and helps to
immortalise/demonise the original author of any binding claiming to be
generic. Patch below.

Thanks,
Mark.

---->8----
>From 6ed3e3564199ed6dbd8782a740d4067fb1e6d3b6 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 13 Feb 2014 17:50:33 +0000
Subject: [PATCH] Documentation: devicetree: add vendor prefix for Will Deacon

This patch adds a vendor prefix for Will Deacon, for use in generic
hardware bindings originating from Will Deacon.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3f900cd..b945e74 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -88,6 +88,7 @@ toumaz	Toumaz
 v3	V3 Semiconductor
 via	VIA Technologies, Inc.
 winbond Winbond Electronics corp.
+will-deacon	Will Deacon MEng
 wlf	Wolfson Microelectronics
 wm	Wondermedia Technologies, Inc.
 xlnx	Xilinx
-- 
1.8.1.1
