Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36057 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbdBFPRc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 10:17:32 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, yurovsky@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] i.MX7 PCI support
Date: Mon,  6 Feb 2017 07:17:13 -0800
Message-Id: <20170206151716.10381-1-andrew.smirnov@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hello, everyone:

This is a third iteration of the code that adds PCI-subsystem bits
necessary for enabling PCI support on i.MX7.

Changes since v2 (can be found at [version2]):

	- Collected Reviewed-by for patch #2 from Lucas
	- Reset logic implementation moved out into a reset controller
          driver (see [reset1])
	- Removed unused leftover code

Changes since v1 (can be found at [version1]):

	- All GPC related code moved into a separate driver (see [gpc1])
	- Removed GPIO probe deferral logging
	- Fixed section mismatch warning
	- Minor reformatting of fsl,imx6q-pcie.txt(as per Rob
          Herring's request)

[version2] https://lkml.org/lkml/2017/2/1/510
[version1] https://lkml.org/lkml/2017/1/19/488
[gpc1] https://lkml.org/lkml/2017/2/6/551
[reset1] https://lkml.org/lkml/2017/2/6/554

Andrey Smirnov (3):
  PCI: imx6: Fix a typo in error message
  PCI: imx6: Allow probe deferal by reset GPIO
  PCI: imx6: Add code to support i.MX7D

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
 drivers/pci/host/pci-imx6.c                        | 131 ++++++++++++++++-----
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
 3 files changed, 111 insertions(+), 30 deletions(-)

-- 
2.9.3
