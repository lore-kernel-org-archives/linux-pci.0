Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 4 Aug 2015 11:13:26 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [GIT PULL] PCI fixes for v4.2
Message-ID: <20150804161326.GA17327@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

This is a trivial fix for a change that broke user program compilation
(QEMU in this case).

Bjorn


The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.2-fixes-1

for you to fetch changes up to c9ddbac9c89110f77cb0fa07e634aaf1194899aa:

  PCI: Restore PCI_MSIX_FLAGS_BIRMASK definition (2015-07-14 18:27:46 -0500)

----------------------------------------------------------------
PCI update for v4.2:

  Miscellaneous
    - Restore PCI_MSIX_FLAGS_BIRMASK definition (Michael S. Tsirkin)

----------------------------------------------------------------
Michael S. Tsirkin (1):
      PCI: Restore PCI_MSIX_FLAGS_BIRMASK definition

 include/uapi/linux/pci_regs.h | 1 +
 1 file changed, 1 insertion(+)
