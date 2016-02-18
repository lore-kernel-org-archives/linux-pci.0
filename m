Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36204 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424770AbcBRL7w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2016 06:59:52 -0500
Received: by mail-wm0-f66.google.com with SMTP id a4so2499034wme.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Feb 2016 03:59:51 -0800 (PST)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v2 0/2] Add PCIe driver support for imx6sx.
Date: Thu, 18 Feb 2016 12:59:01 +0100
Message-Id: <1455796743-5987-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add PCIe driver support for imx6sx.

v2:
 * leave out regulator handling from driver, will be done later
   in PM subsystem 
 * use BIT() macro for MFD

Christoph Fritz (2):
  MFD: imx6sx: Add PCIe register definitions for iomuxc gpr
  PCI: imx6: add initial imx6sx support

 drivers/pci/host/pci-imx6.c                 | 130 +++++++++++++++++++---------
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |   5 ++
 2 files changed, 96 insertions(+), 39 deletions(-)

-- 
2.1.4

