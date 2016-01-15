Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36110 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750911AbcAOS4y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 13:56:54 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <Richard.Zhu@freescale.com>, linux-pci@vger.kernel.org,
	kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH 0/4] i.MX6 sleep while atomic bugfix
Date: Fri, 15 Jan 2016 19:56:46 +0100
Message-Id: <1452884210-11359-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There have been some reports about a possible scheduling while atomic bug
in the i.MX6 PCIe host driver, like the following one
https://bugzilla.kernel.org/show_bug.cgi?id=100031

Although there were some proposed patches, they all had some flaws, which
lead to none of them being included in the mainline kernel. The following
patch series fixes this bug in a proper way, instead of papering over the
problem, making the fix a bit bigger.

Regards
Lucas

Lucas Stach (4):
  PCI: imx6: move PHY reset function to other PHY handling functions
  PCI: imx6: move PHY reset into establish_link
  PCI: imx6: remove broken Gen2 workaround
  PCI: imx6: move link up check into establish link path

 drivers/pci/host/pci-imx6.c | 137 +++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 83 deletions(-)

-- 
2.6.4

