Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49808 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaGaSQQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jul 2014 14:16:16 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <Shawn.Guo@freescale.com>, kernel@pengutronix.de
Subject: [PATCH 0/2] i.MX6 PCIe fixes for 3.17
Date: Thu, 31 Jul 2014 20:16:03 +0200
Message-Id: <1406830565-23450-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

One important fix for i.MX6 PCIe that should go in to 3.17

Also I'm adding myself as a co-maintainer of the driver replacing
Shawn Guo as I'm already keeping an eye on it and both Richard,
Shawn and Jingoo seem to be ok with this.

Series is based on top of tag pci-v3.16-fixes-1 to avoid a conflict
in MAINTAINERS.

Lucas Stach (2):
  MAINTAINERS: add myself as co-maintainer for i.MX6 PCI driver
  PCI: imx6: fix boot hang when link already enabled

 MAINTAINERS                 |  2 +-
 drivers/pci/host/pci-imx6.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.0.1

