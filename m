Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36082 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcBNUxW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 14 Feb 2016 15:53:22 -0500
Received: by mail-wm0-f68.google.com with SMTP id a4so7428507wme.3
        for <linux-pci@vger.kernel.org>; Sun, 14 Feb 2016 12:53:21 -0800 (PST)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-pci@vger.kernel.org
Subject: [PATCH 0/2] ARM: imx6sx - add initial PCIe support
Date: Sun, 14 Feb 2016 21:52:42 +0100
Message-Id: <1455483164-13755-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add PCIe driver support for imx6sx.

Christoph Fritz (2):
  ARM: imx6sx: Add PCIe register definitions for iomuxc gpr
  PCI: imx6: add initial imx6sx support

 drivers/pci/host/pci-imx6.c                 | 172 +++++++++++++++++++++-------
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  15 +++
 2 files changed, 144 insertions(+), 43 deletions(-)

-- 
2.1.4

