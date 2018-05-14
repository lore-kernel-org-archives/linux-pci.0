Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:37985 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753690AbeENPQk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 11:16:40 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B01E31E1376
        for <linux-pci@vger.kernel.org>; Mon, 14 May 2018 17:16:39 +0200 (CEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 0/2] PCI: dwc: Use devm_ioremap_resource instead of devm_ioremap_resource
Date: Mon, 14 May 2018 16:16:31 +0100
Message-Id: <cover.1526310842.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fix aims to replace the use of devm_ioremap() by
devm_ioremap_resource() already discussed on [1].

[1] -> https://lkml.kernel.org/r/20180120001645.GA21343@lenoch

Gustavo Pimentel (2):
  PCI: dwc: artpec6: Use devm_ioremap_resource instead of
    devm_ioremap_resource
  PCI: dwc: dra7xx: Use devm_ioremap_resource instead of
    devm_ioremap_resource

 drivers/pci/dwc/pci-dra7xx.c   | 18 +++++++++---------
 drivers/pci/dwc/pcie-artpec6.c |  6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.7.4
