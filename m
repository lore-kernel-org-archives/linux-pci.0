Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:37949 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeENPK1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 11:10:27 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 41A411E044E
        for <linux-pci@vger.kernel.org>; Mon, 14 May 2018 17:10:26 +0200 (CEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com
Cc: linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 0/3] PCI: dwc: Code clean up
Date: Mon, 14 May 2018 16:09:47 +0100
Message-Id: <cover.1526310453.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Does a code cleanup on DesignWare driver, which involves:
 - Replacement of magic numbers by a self-explained define to ease human
comprehension.
 - Replacement a division by 2 operation for a right shift rotation of 1
bit.
 - Replacement of all initial lowercase character in comments and debug
messages to uppercase to maintain coherence.

Gustavo Pimentel (3):
  PCI: dwc: Replace lower into upper case characters
  PCI: dwc: Small computation improvement
  PCI: dwc: Replace magic number by defines

 drivers/pci/dwc/pcie-designware-ep.c   | 16 +++----
 drivers/pci/dwc/pcie-designware-host.c | 77 +++++++++++++++++++---------------
 drivers/pci/dwc/pcie-designware.c      | 22 +++++-----
 drivers/pci/dwc/pcie-designware.h      |  1 +
 4 files changed, 63 insertions(+), 53 deletions(-)

-- 
2.7.4
