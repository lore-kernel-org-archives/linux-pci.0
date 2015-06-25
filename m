Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33550 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbFYBgc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2015 21:36:32 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: akpm@linux-foundation.org
Cc: bp@suse.de, mingo@elte.hu, syrjala@sci.fi,
	ville.syrjala@linux.intel.com, luto@amacapital.net,
	tomi.valkeinen@ti.com, mst@redhat.com, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-pci@vger.kernel.org, airlied@redhat.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH v5 0/3] atyfb: address MTRR corner case
Date: Wed, 24 Jun 2015 18:34:17 -0700
Message-Id: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Andrew,

Forgive me for the TL;DR, I'm afraid I need to be crystal clear on this
patchset as its the most complex in the entire series. The skinny is that this
patchset addresses a complex work around with APIs now merged upstream going in
for v4.2, the driver maintainer hasn't followed up with the driver changes for
over a month and no one else has provided Acks for these device driver
changes [0]. We have a few options:

0) Sit and wait for a driver maintainer to review this
1) Merge this as-is and hope for reports
2) go with the nopat requirement as with the ivtv and ipath driver

I'd prefer to merge this as is, and only if reports come back with
issues should we then consider 2) as we'd then have at least a well
documented work effort required for this transformation. This device
driver is also old, so I don't expect much reports anyway.

----

The TL;DR:

As part of the long haul effort to rid the world of direct MTRR use [1] we've
have had to also work on alternative solutions which can co-exist with PAT
interfaces. Most of the transformation of device drivers to use PAT was fairly
easy (TM): so long as ioremap_wc() was used we could then convert over the
drivers using mtrr_add() over to the arch-agnostic and PAT-aware (ignored when
PAT is enabled) arch_phys_wc_add(). This was typically easy to do, for instance
in cases where a full PCI BAR was used for MMIO registers and another PCI BAR
was used with write-combining effects desirable. In some cases we just needed
new WC apis for some buses. This was the case for most modern devices, but a
few old devices had a combined set of MMIO registers and the write-combined
area mixed. In such situations even when using MTRR one had to figure out
creative solutions to make things work, specially considering MTRRs were
limited and they had size constraints: an MTRR base and size must be
a power of two.

The good news is that on Linux there were only three device drivers in total
that we ended up with radical issue with when converting them over to PAT
interfaces. One was with the ivtv media device driver, another was the
infiniband ipath device driver. The other one was the framebuffer atyfb
device driver that this series addresses. For both ivtv and ipath we've
decided to simply require users of those devices to boot with the nopat
kernel parameter because both devices drivers are ancient and the work
required to fully convert to PAT interfaces is significant (in the ipath case)
or nearly almost impossible (ivtv). For details please refer to the respective
and now upstream commits:

7ea402d x86/mm/pat, drivers/infiniband/ipath: Use arch_phys_wc_add() and require PAT disabled
1bf1735 x86/mm/pat, drivers/media/ivtv: Use arch_phys_wc_add() and require PAT disabled

To demo exactly how much effort would have been required I decided to venture
into atyfb and try to fix that device driver first, considering it had the
worst case situation to address as it used size hackery and MTRR combinations
of different types. In order to accomplish this we needed to map out all
possible combinatorial effects of PAT page entries with write-combining, and
page attributes (PAT, PCD, PWT) with write-combining effects for non-PAT
systems. We did this not only for atyfb's sake but also for any other possible
future driver which might meet these same needs. We needed to take this a bit
more seriously given that our long term goal was also to change the default
behaviour of ioremap_nocache() to use strong UC instead of UC-, we needed
to take this into consideration when converting drivers over. The documentation
table for all these possible combinatorial entries is now upstream:

2f9e897 x86/mm/mtrr, pat: Document Write Combining MTRR type effects on PAT / non-PAT pages

Of importance to this patch set is this table:

----------------------------------------------------------------------
MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
----------------------------------------------------------------------
                                                  Non-PAT |  PAT
     PAT
     |PCD
     ||PWT
     |||
WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   UC
WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
----------------------------------------------------------------------

In the atyfb case it used to use two MTRR calls, a large WC MTRR followed by a
UC MTRR "hole" call for the MMIO registers. This was done this way on atyfb
because of the offset and size of the framebuffer area would only work well
this way, otherwise you'd also have to try a series of small MTRR calls and you
might end up running out of MTRRs. For non-PAT systems we take advantage of the
above map to protect an MMIO region with 011 page attributes (this maps to
strong UC for PAT systems) so that if a large MTRR is issued that encompasses
the MMIO region, the MMIO region remains with an effective UC type, while the
desired wc area would have an effective memory type of WC as its region would
have been mapped with ioremap_wc(). This makes use of the newly introduced
ioremap_uc() as otherwise if we would have used ioremap_nocache() we would
not get the UC effective memeory type. This also let us remove the only UC MTRR
call from the kernel :) after this then we'd only have WC MTRR calls in effect
on non-PAT systems on Linux. The more complex patch then is patch 2 which does
most of the magic.

[0] http://lkml.kernel.org/r/CAB=NE6Xy1UGAqZ8CsVc+JzKqsxREaXBYK+1GjZKN8d2FG8xqJg@mail.gmail.com
[1] http://lkml.kernel.org/r/CAB=NE6UgtdSoBsA=8+ueYRAZHDnWUSmQAoHhAaefqudBrSY7Zw@mail.gmail.com

Luis R. Rodriguez (3):
  video: fbdev: atyfb: clarify ioremap() base and length used
  video: fbdev: atyfb: replace MTRR UC hole with strong UC
  video: fbdev: atyfb: use arch_phys_wc_add() and ioremap_wc()

 drivers/video/fbdev/aty/atyfb.h      |  5 +--
 drivers/video/fbdev/aty/atyfb_base.c | 74 +++++++++++-------------------------
 2 files changed, 24 insertions(+), 55 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

