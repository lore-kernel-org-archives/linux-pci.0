Return-Path: <SRS0=ft8V=EY=fredlawl.com=fred@kernel.org>
Return-Path: <SRS0=ft8V=EY=fredlawl.com=fred@kernel.org>
From: Frederick Lawler <fred@fredlawl.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@kernel.org,
	Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH 0/1] PCI: Replace pci_find_ext_capability() calls with pci_dev aer_cap
Date: Sun, 28 Jan 2018 20:02:17 -0600
Message-Id: <1517191338-22415-1-git-send-email-fred@fredlawl.com>
List-ID: <linux-pci.vger.kernel.org>

Hello,

I replaced certain pci_find_ext_capability(..., PCI_EXT_CAP_ID_ERR) calls
with pci_dev's aer_cap.

Since I do not have a computer with a PCIe device with the Advanced Error
Reporting capability, these changes have not been tested with
CONFIG_PCIEAER=y set on a machine that has a capable device.

Frederick Lawler (1):
  PCI: Replace pci_find_ext_capability() calls with pci_dev aer_cap

 drivers/pci/pcie/aer/aer_inject.c |  4 +-
 drivers/pci/pcie/aer/ecrc.c       |  4 +-
 drivers/pci/pcie/portdrv_core.c   | 15 ++++++--
 drivers/pci/probe.c               | 80 +++++++++++++++++++++------------------
 4 files changed, 58 insertions(+), 45 deletions(-)

-- 
2.7.4
