Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:38458 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753078AbeENRck (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 13:32:40 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 46FB51E1376
        for <linux-pci@vger.kernel.org>; Mon, 14 May 2018 19:32:39 +0200 (CEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 0/2] PCI: dwc: Use devm_ioremap_resource instead of devm_ioremap_resource
Date: Mon, 14 May 2018 18:32:33 +0100
Message-Id: <cover.1526319075.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fix aims to replace the use of devm_ioremap() by
devm_ioremap_resource() already discussed on [1]

Gustavo Pimentel (2):
  PCI: dwc: artpec6: Use devm_ioremap_resource instead of devm_ioremap
  PCI: dwc: dra7xx: Use devm_ioremap_resource instead of devm_ioremap

 drivers/pci/dwc/pci-dra7xx.c   | 18 +++++++++---------
 drivers/pci/dwc/pcie-artpec6.c |  6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.7.4
