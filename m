Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:32995 "EHLO
        wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeEKKnc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 May 2018 06:43:32 -0400
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v16 0/9] Address error and recovery for AER and DPC
Date: Fri, 11 May 2018 06:43:19 -0400
Message-Id: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set brings in error handling support for DPC

The current implementation of AER and error message broadcasting to the
EP driver is tightly coupled and limited to AER service driver.
It is important to factor out broadcasting and other link handling
callbacks. So that not only when AER gets triggered, but also when DPC get
triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.

The goal of the patch-set is:
DPC should handle the error handling and recovery similar to AER, because 
finally both are attempting recovery in some or the other way,
and for that error handling and recovery framework has to be loosely
coupled.

It achieves uniformity and transparency to the error handling agents such
as AER, DPC, with respect to recovery and error handling.

So, this patch-set tries to unify lot of things between error agents and
make them behave in a well defined way. (be it error (FATAL, NON_FATAL)
handling or recovery).

The FATAL error handling is handled with remove/reset_link/re-enumerate
sequence while the NON_FATAL follows the default path.
Documentation/PCI/pci-error-recovery.txt talks more on that.

Changes since v15:
    Bjorn's comments addressed
    > minor comments fixed
    > made FATAL sequence aligned to existing one, as far as clearing status are concerned.
    > pcie_do_fatal_recovery and pcie_do_nonfatal_recovery functions made to modularize
    > pcie_do_fatal_recovery now takes service as an argument
Changes since v14:
    Bjorn's comments addressed
    > simplified the patch set, and moved AER_FATAL handling in the beginning.
    > rebase the code to 4.17-rc1.
Changes since v13:
    Bjorn's comments addressed
    > handke FATAL errors with remove devices followed by re-enumeration.
    > changes in AER and DPC along with required Documentation.
Changes since v12:
    Bjorn's and Keith's Comments addressed.
    > Made DPC and AER error handling identical <aligned err.c>
    > hanldled cases for hotplug enabled system differently.
Changes since v11:
    Bjorn's comments addressed.
    > rename pcie-err.c to err.c
    > removed EXPORT_SYMBOL
    > made generic find_serivce function in port driver.
    > removed mutex patch as no need to have mutex in pcie_do_recovery
    > brough in DPC_FATAL in aer.h
    > so now all the error codes (AER and DPC) are unified in aer.h
Changes since v10:
    Christoph Hellwig's, David Laight's and Randy Dunlap's
    comments addressed.
        > renamed pci_do_recovery to pcie_do_recovery
        > removed inner braces in conditional statements.
        > restrctured the code in pci_wait_for_link
        > EXPORT_SYMBOL_GPL
Changes since v9:
    Sinan's comments addressed.
        > bool active = true; unnecessary variable removed.
Changes since v8:
    Fixed Kbuild errors.
Changes since v7:
    Rebased the code on pci master
        > https://kernel.googlesource.com/pub/scm/linux/kernel/git/helgaas/pci
Changes since v6:
    Sinan's and Stefan's comments implemented.
        > reordered patch 6 and 7
        > cleaned up
Changes since v5:
    Sinan's and Keith's comments incorporated.
        > made separate patch for mutex
        > unified error repotting codes into driver/pci/pci.h
        > got rid of wait link active/inactive and
          made generic function in driver/pci/pci.c
Changes since v4:
    Bjorn's comments incorporated.
        > Renamed only do_recovery.
        > moved the things more locally to drivers/pci/pci.h
Changes since v3:
    Bjorn's comments incorporated.
        > Made separate patch renaming generic pci_err.c
        > Introduce pci_err.h to contain all the error types and recovery
        > removed all the dependencies on pci.h
Changes since v2:
    Based on feedback from Keith:
    "
    When DPC is triggered due to receipt of an uncorrectable error Message,
    the Requester ID from the Message is recorded in the DPC Error
    Source ID register and that Message is discarded and not forwarded Upstream.
    "
    Removed the patch where AER checks if DPC service is active
Changes since v1:
    Kbuild errors fixed:
        > pci_find_dpc_dev made static
        > ras_event.h updated
        > pci_find_aer_service call with CONFIG check
        > pci_find_dpc_service call with CONFIG check

Oza Pawandeep (9):
  PCI: Unify wait for link active into generic PCI
  pci-error-recovery: Add AER_FATAL handling
  PCI/AER: Handle ERRR_FATAL with removal and re-enumeration of devices
  PCI/AER: Rename error recovery to generic PCI naming
  PCI/AER: Factor out error reporting from AER
  PCI/PORTDRV: Implement generic find service
  PCI/PORTDRV: Implement generic find device
  PCI/DPC: Unify and plumb error handling into DPC
  PCI/DPC: Disable ERR_NONFATAL and enable ERR_FATAL for DPC

 Documentation/PCI/pci-error-recovery.txt |  35 ++-
 drivers/pci/hotplug/pciehp_hpc.c         |  20 +-
 drivers/pci/pci.c                        |  29 +++
 drivers/pci/pci.h                        |   4 +
 drivers/pci/pcie/Makefile                |   2 +-
 drivers/pci/pcie/aer/aerdrv.c            |   2 +
 drivers/pci/pcie/aer/aerdrv.h            |  30 ---
 drivers/pci/pcie/aer/aerdrv_core.c       | 317 +-------------------------
 drivers/pci/pcie/dpc.c                   |  58 +++--
 drivers/pci/pcie/err.c                   | 374 +++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h               |   4 +
 drivers/pci/pcie/portdrv_core.c          |  67 ++++++
 include/linux/aer.h                      |   1 +
 include/uapi/linux/pci_regs.h            |   1 +
 14 files changed, 540 insertions(+), 404 deletions(-)
 create mode 100644 drivers/pci/pcie/err.c

-- 
2.7.4
