Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 2 Feb 2017 10:18:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lists@ssl-mail.com, "Jayachandran C." <jnair@caviumnetworks.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Takashi Iwai <tiwai@suse.com>
Subject: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170202161812.GB21267@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - configure ASPM on the link from a PCI-to-PCIe bridge (avoids a NULL
    pointer dereference on topologies including these bridges)

The following changes since commit 4d191b1b63c209e37bf27938ef365244d3c41084:

  PCI/MSI: pci-xgene-msi: Fix CPU hotplug registration handling (2017-01-17 08:41:51 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.10-fixes-2

for you to fetch changes up to 030305d69fc6963c16003f50d7e8d74b02d0a143:

  PCI/ASPM: Handle PCI-to-PCIe bridges as roots of PCIe hierarchies (2017-01-27 15:00:45 -0600)

----------------------------------------------------------------
pci-v4.10-fixes-2

----------------------------------------------------------------
Bjorn Helgaas (1):
      PCI/ASPM: Handle PCI-to-PCIe bridges as roots of PCIe hierarchies

 drivers/pci/pcie/aspm.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
