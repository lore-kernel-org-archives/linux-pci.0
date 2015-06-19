Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35235 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbbFSWKr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 18:10:47 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: arnd@arndb.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xensource.com, linux-fbdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH v7 0/9] pci: add pci_iomap_wc() and pci_ioremap_wc_bar()
Date: Fri, 19 Jun 2015 15:08:23 -0700
Message-Id: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Arnd,

After a long-winded conversation with Bjorn over use of
EXPORT_SYMBOL_GPL() instead of EXPORT_SYMBOL() he's noted he'd
be OK if this goes through you as an alternative. This series
goes unmodified from the last posted v6 series, I am just
reposting and addressing this to you now in hopes you might
be comfortable with my use of EXPORT_SYMBOL_GPL() on new
PAT interfaces. I use EXPORT_SYMBOL_GPL() for new PAT symbols,
this parallels Ingo's stated preference as "we don't want
proprietary modules mucking around with new code PAT interfaces,
we only want modules we can analyze and fix in detail" [1].
Other than this Bjorn seemed comfortable with the series and
even had provided an Ack to the series, the EXPORT_SYMBOL_GPL()
thing was the ony thing he was not comfortable with, and also
that of the devres change going in with no users yet.

Tomi has already Ack'd the framebuffer driver specific changes
and is comfortable with the driver changes to go through the
tree that the depending symbols depend on.

I typically had submitted two series for these patches but since
the patches are all related and now already Acked I've bundled
them together and rebased them on top of today's linux-next tree.
This series is part of a larger effort to help avoid direct use
of MTRR code and instead replace it with more generic PAT
interfaces, I posted a full description of the entire series
recently [2].

Please let me know if there are any issues.

[0] http://lkml.kernel.org/r/CAErSpo7CNH1WpgqJCEU8EtxiFNp_PiQ3cBwnKiWQpUaD-fd4YA@mail.gmail.com
[1] http://article.gmane.org/gmane.linux.kernel.mm/129104
[2] http://lkml.kernel.org/r/CAB=NE6UgtdSoBsA=8+ueYRAZHDnWUSmQAoHhAaefqudBrSY7Zw@mail.gmail.com

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
 lib/devres.c                     | 78 ++++++++++++++++++++++++++++++++++++++++
 lib/pci_iomap.c                  | 61 +++++++++++++++++++++++++++++++
 12 files changed, 206 insertions(+), 140 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
