Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36754 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbbGXF3y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2015 01:29:54 -0400
Received: by ykay190 with SMTP id y190so11688591yka.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2015 22:29:54 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 0/4] PCI: Mark the msi cascade handler IRQF_NO_THREAD
Date: Fri, 24 Jul 2015 13:29:32 +0800
Message-Id: <1437715776-2243-1-git-send-email-haokexin@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I got a kernel warning on imx6 board when forcing threading of all the
interrupt handler. This patch series tries to fix this issue for all
the msi handler which leverage on dw_handle_msi_irq(). Only boot test
on imx6 board, all others just passed build test.

Kevin Hao (4):
  PCI: imx6: Mark the msi cascade handler IRQF_NO_THREAD
  PCI: dra7xx: Mark the msi cascade handler IRQF_NO_THREAD
  PCI: exynos: Mark the msi cascade handler IRQF_NO_THREAD
  PCI: spear: Mark the msi cascade handler IRQF_NO_THREAD

 drivers/pci/host/pci-dra7xx.c     | 3 ++-
 drivers/pci/host/pci-exynos.c     | 3 ++-
 drivers/pci/host/pci-imx6.c       | 3 ++-
 drivers/pci/host/pcie-spear13xx.c | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

Thanks,
Kevin
-- 
2.1.0

