Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 16 Feb 2017 08:51:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170216145104.GA24065@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fix:

  - add back pcie_pme_remove() so we free the IRQ when removing PCIe port
    devices; previously the leaked IRQ caused an MSI BUG_ON.


The following changes since commit d98e0929071e7ef63d35c1838b0ad0805ae366dd:

  Revert "PCI: pciehp: Add runtime PM support for PCIe hotplug ports" (2017-02-03 08:53:51 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.10-fixes-4

for you to fetch changes up to afe3e4d11bdf50a4c3965eb6465ba6bebbcf5dcf:

  PCI/PME: Restore pcie_pme_driver.remove (2017-02-15 09:39:32 -0600)

----------------------------------------------------------------
pci-v4.10-fixes-4

----------------------------------------------------------------
Yinghai Lu (1):
      PCI/PME: Restore pcie_pme_driver.remove

 drivers/pci/pcie/pme.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)
