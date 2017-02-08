Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Feb 2017 13:22:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Christoph Hellwig <hch@lst.de>,
        Yinghai Lu <yinghai@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc, sorry for the duplicate]

PCI fixes:

  - check MSI affinity vs. number of vectors to avoid memory corruption
  - drop runtime power management for PCIe hotplug ports for now to avoid
    regressing hotplug via sysfs


The following changes since commit 030305d69fc6963c16003f50d7e8d74b02d0a143:

  PCI/ASPM: Handle PCI-to-PCIe bridges as roots of PCIe hierarchies (2017-01-27 15:00:45 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.10-fixes-3

for you to fetch changes up to d98e0929071e7ef63d35c1838b0ad0805ae366dd:

  Revert "PCI: pciehp: Add runtime PM support for PCIe hotplug ports" (2017-02-03 08:53:51 -0600)

----------------------------------------------------------------
pci-v4.10-fixes-3

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "PCI: pciehp: Add runtime PM support for PCIe hotplug ports"

Christoph Hellwig (1):
      PCI/MSI: Don't apply affinity if there aren't enough vectors left

 drivers/pci/hotplug/pciehp_ctrl.c |  6 ------
 drivers/pci/msi.c                 | 10 ++++++++++
 drivers/pci/pci.c                 | 12 ++++++------
 3 files changed, 16 insertions(+), 12 deletions(-)
