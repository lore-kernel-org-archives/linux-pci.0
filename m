Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Sep 2017 14:08:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [GIT PULL] PCI fixes for v4.14
Message-ID: <20170929190853.GA31210@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix CONFIG_PCI=n build error (introduced in v4.14-rc1) (Geert
    Uytterhoeven)

  - fix a race in sysfs driver_override store/show (Nicolai Stange)


The following changes since commit 749aaf3372b8b56b8743c3e27700d64c8bd06921:

  PCI: endpoint: Use correct "end of test" interrupt (2017-09-20 13:56:06 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.14-fixes-3

for you to fetch changes up to 9561475db680f7144d2223a409dd3d7e322aca03:

  PCI: Fix race condition with driver_override (2017-09-25 18:34:54 -0500)

----------------------------------------------------------------
pci-v4.14-fixes-3

----------------------------------------------------------------
Geert Uytterhoeven (1):
      PCI: Add dummy pci_acs_enabled() for CONFIG_PCI=n build

Nicolai Stange (1):
      PCI: Fix race condition with driver_override

 drivers/pci/pci-sysfs.c | 11 +++++++++--
 include/linux/pci.h     |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)
