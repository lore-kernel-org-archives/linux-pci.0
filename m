Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26207 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbeAQFSx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jan 2018 00:18:53 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Maik Broemme <mbroemme@libmpq.org>,
        Pawandeep Oza <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 0/6] PCI/DPC updates
Date: Tue, 16 Jan 2018 22:22:00 -0700
Message-Id: <20180117052206.7703-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v1 -> v2:
  Updated change logs with additional information

  Print AER status _only_ if the trigger reason is an uncorrectable
  error.

  Clear the uncorrectable status register after printing so we don't log
  the same errors multiple times.

  Added a patch to fix masking a field being printed.

  Added a patch to enable ERR_COR.

Keith Busch (6):
  PCI/AER: Return approrpiate value when AER is not supported
  PCI/AER: Provide API for getting AER information
  PCI/DPC: Enable DPC in conjuction with AER
  PCI/DPC: Print AER status in DPC event handling
  PCI/DPC: Fix interrupt message number print
  PCI/DPC: Enable ERR_COR

 drivers/pci/pcie/Kconfig           |  2 +-
 drivers/pci/pcie/aer/aerdrv.h      |  1 +
 drivers/pci/pcie/aer/aerdrv_core.c | 10 +++++-----
 drivers/pci/pcie/pcie-dpc.c        | 23 +++++++++++++++++++++--
 drivers/pci/pcie/portdrv_core.c    |  4 ++--
 include/uapi/linux/pci_regs.h      |  3 ++-
 6 files changed, 32 insertions(+), 11 deletions(-)

-- 
2.13.6
