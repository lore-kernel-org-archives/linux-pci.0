Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: mingo@kernel.org
Cc: bp@suse.de, arnd@arndb.de, bhelgaas@google.com,
	luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com,
	benh@kernel.crashing.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH v9 0/8] pci: add pci_iomap_wc() and pci_ioremap_wc_bar()
Date: Wed,  8 Jul 2015 18:54:11 -0700
Message-Id: <1436406859-1280-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Ingo,

Boris is on vacation, he picked up these patches on his bp#tip-mm tree [0]
and they have baked there for a while now. That tree receives 0-day
bot testing, but other than that its not clear what other tests were
run on these patches. Boris modified the commit logs a bit, and made one
optimizaiton to bail early on an PCI ioremap call when it should. These
patches have no modifications from what is on Boris' tree and tip-mm branch.

The 0 day build bot did find issues on Boris' tree but those are related
to ioremap_uc() (already upstream) and its first use on atyfb (not
upstream) -- I will be addressing a fix for that ioremap_uc() issue through
another patch series prior to posting the final set for atyfb which makes
use of ioremap_uc().

No issues have been found with this series. Benh did note some possible issues
with expectations with what is done for write-combining for PowerPC [1] but
the issue is a rather general long standing issue with semantics of ioremap --
in the case for ioremap_wc() on PowerPC benh notes that writel() will never
write-combine as it uses too heavy barriers. Benh notes that although
writel_relaxed() today is identical to writel() this can be changed. There are
other general semantics issues with ioremap() variant calls -- we seem to have
all gotten together to discuss all these issues on a thread where Dan Williams
is proposing to "unify ioremap prototypes and macro aliases" [1], folks
intersted on these issues or semantic concerns can drop in and chime there.

Let me know if these are OK or if there are any questions.

[0] http://lkml.kernel.org/r/20150625204703.GC4898@pd.tnic
[1] http://lkml.kernel.org/r/20150707095012.GQ7021@wotan.suse.de

Luis R. Rodriguez (8):
  PCI: Add pci_ioremap_wc_bar()
  drivers/video/fbdev/i740fb: Use arch_phys_wc_add() and
    pci_ioremap_wc_bar()
  drivers/video/fbdev/kyrofb: Use arch_phys_wc_add() and
    pci_ioremap_wc_bar()
  drivers/video/fbdev/gxt4500: Use pci_ioremap_wc_bar() to map
    framebuffer
  PCI: Add pci_iomap_wc() variants
  drivers/video/fbdev/arkfb.c: Use arch_phys_wc_add() and pci_iomap_wc()
  drivers/video/fbdev/s3fb: Use arch_phys_wc_add() and pci_iomap_wc()
  drivers/video/fbdev/vt8623fb: Use arch_phys_wc_add() and
    pci_iomap_wc()

 drivers/pci/pci.c                | 14 +++++++++
 drivers/video/fbdev/arkfb.c      | 36 +++-------------------
 drivers/video/fbdev/gxt4500.c    |  2 +-
 drivers/video/fbdev/i740fb.c     | 35 ++++-----------------
 drivers/video/fbdev/kyro/fbdev.c | 33 +++++++-------------
 drivers/video/fbdev/s3fb.c       | 35 ++++-----------------
 drivers/video/fbdev/vt8623fb.c   | 31 ++++---------------
 include/asm-generic/pci_iomap.h  | 14 +++++++++
 include/linux/pci.h              |  1 +
 include/video/kyro.h             |  4 +--
 lib/pci_iomap.c                  | 66 ++++++++++++++++++++++++++++++++++++++++
 11 files changed, 131 insertions(+), 140 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

