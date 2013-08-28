Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f177.google.com ([209.85.213.177]:60062 "EHLO
	mail-ye0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab3H1T0z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 15:26:55 -0400
Received: by mail-ye0-f177.google.com with SMTP id r13so1658218yen.22
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 12:26:55 -0700 (PDT)
Subject: [PATCH 0/4] PCIe Capability accessor fix and cleanups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yuval Mintz <yuvalmin@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>
Date: Wed, 28 Aug 2013 13:26:52 -0600
Message-ID: <20130828192627.5895.26558.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The first patch fixes a Link Control issue reported by Yuval Mintz.
The rest simplify the code a bit.

---

Bjorn Helgaas (4):
      PCI: Allow PCIe Capability link-related register access for switches
      PCI: Remove PCIe Capability version checks
      PCI: Support PCIe Capability Slot registers only for ports with slots
      PCI: Remove pcie_cap_has_devctl()


 drivers/pci/access.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)
