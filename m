Return-Path: <SRS0=FKzq=E3=fredlawl.com=fred@kernel.org>
Return-Path: <SRS0=FKzq=E3=fredlawl.com=fred@kernel.org>
From: Frederick Lawler <fred@fredlawl.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@kernel.org,
	Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 0/1] PCI: Replace pci_find_ext_capability() calls with pci_dev aer_cap
Date: Wed, 31 Jan 2018 20:53:44 -0600
Message-Id: <1517453625-13110-1-git-send-email-fred@fredlawl.com>
List-ID: <linux-pci.vger.kernel.org>

Hello,

I replaced certain pci_find_ext_capability(..., PCI_EXT_CAP_ID_ERR) calls
with pci_dev's aer_cap.

Since I do not have a computer with a PCIe device with the Advanced Error
Reporting capability, these changes have not been tested with
CONFIG_PCIEAER=y set on a machine that has a capable device.

V2:
* Reset program_hpp_type2() in probe.c back to its original state

Frederick Lawler (1):
  PCI: Replace pci_find_ext_capability() calls with pci_dev aer_cap

 drivers/pci/pcie/aer/aer_inject.c |  4 ++--
 drivers/pci/pcie/aer/ecrc.c       |  4 ++--
 drivers/pci/pcie/portdrv_core.c   | 15 +++++++++++----
 3 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.7.4
