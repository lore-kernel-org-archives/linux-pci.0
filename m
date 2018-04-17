Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:40519 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeDQA25 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2018 20:28:57 -0400
Received: by mail-it0-f68.google.com with SMTP id u62-v6so13965053ita.5
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2018 17:28:56 -0700 (PDT)
From: Frederick Lawler <fred@fredlawl.com>
To: bhelgaas@google.com, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, dledford@redhat.com, jgg@mellanox.com
Cc: linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v3 0/2] IB/hfi1: Cleanup PCIe link configuration
Date: Mon, 16 Apr 2018 19:28:23 -0500
Message-Id: <20180417002825.2737-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The IB/hfi1 driver uses custom macros to configure the target link speed. Some 
macros were previously replaced, but not fully. This patch series addresses the
configuration inconsistencies by adding PCI_EXP_LNKCTL2_TLS* macros to PCI,
and then use them in the following IB/hfi1 patch.

V3: 
	* PCI: Add PCI_EXP_LNKCTL2_TLS_* macros
	* Drop patch to use extract_speed() in do_pcie_gen3_transition()
V2:
	* s/LINK/LNK

Frederick Lawler (2):
  PCI: Add PCI_EXP_LNKCTL2_TLS* macros
  IB/hfi1: Replace custom hfi1 macros with PCIe macros

 drivers/infiniband/hw/hfi1/pcie.c | 24 ++++++++----------------
 include/uapi/linux/pci_regs.h     |  5 +++++
 2 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.17.0
