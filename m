Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v6 0/3] PCI: Precision Time Measurement support
To: Jonathan Yong <jonathan.yong@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 14:05:26 -0500
Message-ID: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a slightly different proposal for the PTM support Jonathan
proposed here:

  http://lkml.kernel.org/r/1462956446-27361-2-git-send-email-jonathan.yong@intel.com

I split this into three pieces mostly for ease in reviewing.  They
could all be squashed:

  - Enable PTM in root ports and switches automatically at boot
  - Enable PTM in endpoints when requested by driver
  - Add clock granularity information

I have some open questions about how PTM works on Root Complex
Integrated Endpoints and whether we should enable it automatically
even without a driver request.  And I probably left out some details
of the clock granularity computation, so treat this as more of an RFC
than anything.

Bjorn

---

Bjorn Helgaas (2):
      PCI: Add pci_enable_ptm() for drivers to enable PTM on endpoints
      PCI: Add PTM clock granularity information

Jonathan Yong (1):
      PCI: Add Precision Time Measurement (PTM) support


 drivers/pci/pci.h             |    6 ++
 drivers/pci/pcie/Kconfig      |   12 ++++
 drivers/pci/pcie/Makefile     |    1 
 drivers/pci/pcie/ptm.c        |  140 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |    3 +
 include/linux/pci.h           |   13 ++++
 include/uapi/linux/pci_regs.h |   12 +++-
 7 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/ptm.c
