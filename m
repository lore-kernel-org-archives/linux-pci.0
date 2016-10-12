Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933300AbcJLNVa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:21:30 -0400
Subject: [PATCH v2 0/2] PCI: mvebu: Cleanups
To: Jason Cooper <jason@lakedaemon.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 07:55:50 -0500
Message-ID: <20161012125403.24580.74990.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Add local "dev" pointers to reduce repetition of things like
    "&pdev->dev".

  - Tidy up usage of of_node pointer

Nothing here should change the behavior of the driver.

Changes from v1:
  Added of_node cleanup
  Dropped "PCI: mvebu: Swap order of mvebu_writel() reg/val arguments"

---

Bjorn Helgaas (2):
      PCI: mvebu: Add local struct device pointers
      PCI: mvebu: Use existing of_node pointer


 drivers/pci/host/pci-mvebu.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)
