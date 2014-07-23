Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44211 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbaGWRkU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 13:40:20 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Shawn Guo <shawn.guo@freescale.com>, kernel@pengutronix.de
Subject: [PATCH 0/3] i.MX6 PCIe fixes for 3.17
Date: Wed, 23 Jul 2014 19:40:14 +0200
Message-Id: <1406137217-11294-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Two important fixes for i.MX6 PCIe that should go in to 3.17

Also I'm adding myself as a co-maintainer of the driver as I'm
already keeping an eye on it and Richard seems to be ok with this.

Lucas Stach (3):
  MAINTAINERS: add myself as co-maintainer for i.MX6 PCI driver
  PCI: imx6: prevent driver unbind
  PCI: imx6: fix boot hang when link already enabled

 MAINTAINERS                 |  1 +
 drivers/pci/host/pci-imx6.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

-- 
2.0.1

