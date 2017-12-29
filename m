Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49866 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbdL2HYc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 02:24:32 -0500
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v2 0/4] Address error and recovery for AER and DPC
Date: Fri, 29 Dec 2017 12:54:15 +0530
Message-Id: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set brings in support for DPC and AER to co-exist and not to
race for recovery.

The current implementation of AER and error message broadcasting to the
EP driver is tightly coupled and limited to AER service driver.
It is important to factor out broadcasting and other link handling
callbacks. So that not only when AER gets triggered, but also when DPC get
triggered, or both get triggered simultaneously (for e.g. ERR_FATAL),
callbacks are handled appropriately.
having modularized the code, the race between AER and DPC is handled
gracefully.
for e.g. when DPC is active and kicked in, AER should not attempt to do
recovery, because DPC takes care of it.

DPC should enumerate the devices after recovering the link, which is
achieved by implementing error_resume callback.

Changes since v1:
	Kbuild errors fixed:
		> pci_find_dpc_dev made static
		> ras_event.h updated
		> pci_find_aer_service call with CONFIG check
		> pci_find_dpc_service call with CONFIG check

Oza Pawandeep (4):
  PCI/AER: factor out error reporting from AER
  PCI/DPC/AER: Address Concurrency between AER and DPC
  PCI/ERR: Do not do recovery if DPC service is active
  PCI/DPC: Enumerate the devices after DPC trigger event

 drivers/acpi/apei/ghes.c               |   2 +-
 drivers/pci/pcie/Makefile              |   2 +-
 drivers/pci/pcie/aer/aerdrv.h          |  30 ---
 drivers/pci/pcie/aer/aerdrv_core.c     | 306 +------------------------
 drivers/pci/pcie/aer/aerdrv_errprint.c |  27 ++-
 drivers/pci/pcie/pcie-dpc.c            | 127 ++++++++++-
 drivers/pci/pcie/pcie-err.c            | 399 +++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h             |   2 +
 include/linux/aer.h                    |   4 -
 include/linux/pci.h                    |  23 ++
 include/ras/ras_event.h                |   6 +-
 11 files changed, 579 insertions(+), 349 deletions(-)
 create mode 100644 drivers/pci/pcie/pcie-err.c

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
