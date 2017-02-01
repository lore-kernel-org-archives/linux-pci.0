Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, yurovsky@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] i.MX7 PCI support
Date: Wed,  1 Feb 2017 08:55:56 -0800
Message-Id: <20170201165559.22436-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, everyone:

This is a second iteration of the code that adds PCI-subsystem bits
necessary for enabling PCI support on i.MX7.

Changes since v1 (can be found at [version1]):

	- All GPC related code moved into a separate driver (subject
          of a different patch)
	- Removed GPIO probe deferral logging
	- Fixed section mismatch warning
	- Minor reformatting of fsl,imx6q-pcie.txt(as per Rob
          Herring's request)

[version1] https://lkml.org/lkml/2017/1/19/488

Thanks,
Andrey Smirnov

Andrey Smirnov (3):
  PCI: imx6: Fix a typo in error message
  PCI: imx6: Allow probe deferal by reset GPIO
  PCI: imx6: Add code to support i.MX7D

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
 drivers/pci/host/pci-imx6.c                        | 145 ++++++++++++++++-----
 include/linux/mfd/syscon/imx7-gpc.h                |  18 +++
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
 include/linux/mfd/syscon/imx7-src.h                |  18 +++
 5 files changed, 161 insertions(+), 30 deletions(-)
 create mode 100644 include/linux/mfd/syscon/imx7-gpc.h
 create mode 100644 include/linux/mfd/syscon/imx7-src.h

-- 
2.9.3
