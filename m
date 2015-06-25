Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33631 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbbFYBYg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2015 21:24:36 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: bp@suse.de
Cc: mingo@kernel.org, arnd@arndb.de, bhelgaas@google.com,
	luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com,
	benh@kernel.crashing.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH v8 0/9] pci: add pci_iomap_wc() and pci_ioremap_wc_bar()
Date: Wed, 24 Jun 2015 18:22:13 -0700
Message-Id: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Boris,

This patchset is part of the long haul of series that addresses removal of
direct use of MTRR and transforms drivers over to use PAT interfaces when
available [0]. Other than this series there is only one more pending series for
that effort, the other one being the atyfb device driver specific changes which
no one has replied to for over one month and I'll soon repost and hope that
Andrew might pick up. The patches in this series were originally split in two
series but I've combined them now given all Acks have been collected and they
are all related. Tomi has provided his Acked-by for all device driver changes.
Bjorn had originally reviewed this series and was comfortable with all the code
except for the use of EXPORT_SYMBOL_GPL() despite new clarifications of how we
can use this for new symbols and our preference for it on new PAT interfaces
[1], despite this Bjorn has clarified he's comfortable with this going in
through another maintainer and in particular Arnd [2]. The v7 series was posted
addressing Arnd, Arnd provided his Acked-by for all PCI and devres changes but
noted he's on parental leave and not taking any patches for arm-soc or
asm-generic until he's back at work in around 3 months from now [2] so he
suggested to see if I could find another maintainer to have these go through.

This v8 goes unmodified, except for the devres commit, since those routines
are not yet used by any device driver for now I've just skipped exporting
the symbols but did note that if they will be it must be exported with
EXPORT_SYMBOL_GPL(). Once we have a driver need them upstream we can export
these.

Although I had test compiled this before just to be safe I went ahead and
successfully test-compiled this set with allmodconfig, specially since I've now
removed the exports for the devres routines.  Please let me know if these might
be able to go through you or if there are any questions. I will note the recent
discussion with Benjamin over the v7 series concluded that the ideas we both
were alluding to, on automating instead the WC effects for devices seems a bit
too idealistic for PCI / PCIE for now, but perhaps we should at least consider
this in the future for userspace mmap() calls [4].

[0] http://lkml.kernel.org/r/CAB=NE6UgtdSoBsA=8+ueYRAZHDnWUSmQAoHhAaefqudBrSY7Zw@mail.gmail.com
[1] http://lkml.kernel.org/r/CAErSpo4sHA-f83X1nW2QdLT9GdubFXCQ7UEJmSfFc5GBjj8FSA@mail.gmail.com
[2] http://lkml.kernel.org/r/CAErSpo7CNH1WpgqJCEU8EtxiFNp_PiQ3cBwnKiWQpUaD-fd4YA@mail.gmail.com
[3] http://lkml.kernel.org/r/1435193521.3790.26.camel@kernel.crashing.org

Luis R. Rodriguez (9):
  pci: add pci_ioremap_wc_bar()
  video: fbdev: i740fb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
  video: fbdev: kyrofb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
  video: fbdev: gxt4500: use pci_ioremap_wc_bar() for framebuffer
  PCI: Add pci_iomap_wc() variants
  lib: devres: add pcim_iomap_wc() variants
  video: fbdev: arkfb: use arch_phys_wc_add() and pci_iomap_wc()
  video: fbdev: s3fb: use arch_phys_wc_add() and pci_iomap_wc()
  video: fbdev: vt8623fb: use arch_phys_wc_add() and pci_iomap_wc()

 drivers/pci/pci.c                | 14 ++++++++
 drivers/video/fbdev/arkfb.c      | 36 +++----------------
 drivers/video/fbdev/gxt4500.c    |  2 +-
 drivers/video/fbdev/i740fb.c     | 35 ++++--------------
 drivers/video/fbdev/kyro/fbdev.c | 33 ++++++-----------
 drivers/video/fbdev/s3fb.c       | 35 ++++--------------
 drivers/video/fbdev/vt8623fb.c   | 31 ++++------------
 include/asm-generic/pci_iomap.h  | 14 ++++++++
 include/linux/pci.h              |  3 ++
 include/video/kyro.h             |  4 +--
 lib/devres.c                     | 76 ++++++++++++++++++++++++++++++++++++++++
 lib/pci_iomap.c                  | 61 ++++++++++++++++++++++++++++++++
 12 files changed, 204 insertions(+), 140 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

