Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: bhelgaas@google.com
Cc: tomi.valkeinen@ti.com, airlied@linux.ie,
	linux-fbdev@vger.kernel.org, luto@amacapital.net,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH v6 0/4] pci: add and use pci_iomap_wc()
Date: Wed, 20 May 2015 16:08:09 -0700
Message-Id: <1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Bjorn, this v6 respins the introduction of pci_iomap_wc() and
its users onto Bjorn's pci tree [0] on the next branch. It goes
with your own Acked-by on the PCI part as well as the framebuffer
subsystem maintainer's own Acked-bys for the framebuffer driver
specific changes.

The driver changes are being submitted through the PCI tree
to make the caller have users as soon as its merged otherwise
we'd have to wait 2 release before full integration.

Bjorn, if you rather pull instead of apply these patches one
by one I've put these changes up on a branch on a tree based
on yours to pull from.

The following changes since commit 9b08ae0dde00c20a75cf15636a08e0901c6fe482:

  Merge branch 'pci/msi' into next (2015-05-08 15:05:10 -0500)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-pci.git pci_iomap_wc-v6-20150520

for you to fetch changes up to 480d550fa62bdad1c8f25b16d27d2035f36a283b:

  video: fbdev: vt8623fb: use arch_phys_wc_add() and pci_iomap_wc() (2015-05-20 15:12:04 -0700)

[0] https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/

Luis R. Rodriguez (4):
  pci: add pci_iomap_wc() variants
  video: fbdev: arkfb: use arch_phys_wc_add() and pci_iomap_wc()
  video: fbdev: s3fb: use arch_phys_wc_add() and pci_iomap_wc()
  video: fbdev: vt8623fb: use arch_phys_wc_add() and pci_iomap_wc()

 drivers/video/fbdev/arkfb.c     | 36 ++++--------------------
 drivers/video/fbdev/s3fb.c      | 35 ++++-------------------
 drivers/video/fbdev/vt8623fb.c  | 31 ++++-----------------
 include/asm-generic/pci_iomap.h | 14 ++++++++++
 lib/pci_iomap.c                 | 61 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+), 85 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty
