Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44085 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbaFEOq1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jun 2014 10:46:27 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>, kernel@pengutronix.de
Subject: [PATCH 0/4] proper multi MSI handling for designware host
Date: Thu,  5 Jun 2014 16:46:08 +0200
Message-Id: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series implements multiple MSI setup and teardown in terms
of the msichip infrastructure for the designware host controller.
It removes quite a bit of homegrown multi MSI handling from the
driver, which I suspect wasn't really tested before.

The series is currently based on pci/next.

Functionality was tested with an FPGA connected to an i.MX6 SoC.
I have verified that the FPGA is able to trigger the second MSI
and the irq is properly routed into the driver.

Lucas Stach (4):
  PCI: allow MSI chip providers to implement their own multiple MSI
    setup
  PCI: designware: remove bogus multiple MSI setup
  PCI: designware: remove open-coded bitmap operations
  PCI: designware: implement multiple MSI irq setup

 drivers/pci/host/pcie-designware.c | 141 +++++++++++++++----------------------
 drivers/pci/msi.c                  |   3 +
 include/linux/msi.h                |   2 +
 3 files changed, 63 insertions(+), 83 deletions(-)

-- 
2.0.0.rc2

