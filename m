Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751640AbcHWWQO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Aug 2016 18:16:14 -0400
Subject: [PATCH 0/2] PCI: Rename *_valid_config() to *_valid_device()
To: Ley Foon Tan <lftan@altera.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, rfi@lists.rocketboards.org,
        linux-pci@vger.kernel.org
Date: Tue, 23 Aug 2016 17:09:37 -0500
Message-ID: <20160823220620.16374.70369.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename *_pcie_valid_config() to *_pcie_valid_device() for readability and
consistency with nwl_pcie_valid_device() and xilinx_pcie_valid_device().

Also consistently use boolean style ("if (!dw_pcie_valid_device()) ..."
instead of "if (dw_pcie_valid_device() == 0) ...")

---

Bjorn Helgaas (2):
      PCI: designware: Rename dw_pcie_valid_config() to dw_pcie_valid_device()
      PCI: altera: Rename altera_pcie_valid_config() to altera_pcie_valid_device()


 drivers/pci/host/pcie-altera.c     |    6 +++---
 drivers/pci/host/pcie-designware.c |    8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)
