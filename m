Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42386 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757655AbaGWRw4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 13:52:56 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	kernel@pengutronix.de
Subject: [PATCH 0/4] PCI: designware: init order/resource alloc fixes
Date: Wed, 23 Jul 2014 19:52:37 +0200
Message-Id: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series fixes a couple of issues with the initialisation
ordering and ressource allocation handling in the designware
driver and moves its behavior much closer to other PCI host
controller drivers like MVEBU and Tegra.
For more detailed explanation see the commit messages.

This effectively enables the i.MX6 pcie driver to be
probed from module initcall level, instead of relying on
being probed early.

Lucas Stach (4):
  PCI: designware: start parsing bus-range
  PCI: designware: get rid of pci_scan_root_bus
  PCI: designware: remove pci_assign_unassigned_resources call
  PCI: imx6: move to module_init

 .../devicetree/bindings/pci/designware-pcie.txt    |  3 +++
 drivers/pci/host/pci-imx6.c                        |  2 +-
 drivers/pci/host/pcie-designware.c                 | 29 ++++++++++++++--------
 drivers/pci/host/pcie-designware.h                 |  1 +
 4 files changed, 24 insertions(+), 11 deletions(-)

-- 
2.0.1

