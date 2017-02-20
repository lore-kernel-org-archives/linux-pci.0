Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33571 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753669AbdBTQJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2017 11:09:49 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, yurovsky@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v5 0/4] i.MX7 PCI support
Date: Mon, 20 Feb 2017 08:08:56 -0800
Message-Id: <20170220160900.7014-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[ RESEND becasue I messed up CC list of patches 2,3 of the original
  submission as well as not adding Reviewed-by to patch 1 and droping
  it from patch 4 ]

Hello, everyone:

This is a fifth iteration of the code that adds PCI-subsystem bits
necessary for enabling PCI support on i.MX7.

Rob, Bjorn, power domain and reset bindings remained the same, please
let me know if you still think that PHY aspect of the driver needs to
be moved into a separate abstraction.

Changes since v4 (can be found at [version4]):

	- Dropped typo-fix patch (originally patch #1 of the
          series). Bjorn, I am assuming that patch from v4 survived
          and stayed in your tree, let me know if that is not true.

	- Added patch with workaround to address speed change false
          failures (I kept it as a separate patch to better document
          exchange with NXP/Freescale that lead to that patch)

	- Added patch to avoid speed change on links configured Gen1
          only (Let me know if that is a terrible idea)

	- Addressed section mismatch problem by moving call to
          hook_fault_code to happend before driver registration.

Changes since v3 (can be found at [version3]):
	- Move all of the reset_control_assert's into imx6_pcie_assert_core_reset
	- Documented required reset and power domain DT bindings

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

[version4] https://lkml.org/lkml/2017/2/7/478
[version3] https://lkml.org/lkml/2017/2/6/565
[version2] https://lkml.org/lkml/2017/2/1/510
[version1] https://lkml.org/lkml/2017/1/19/488
[gpc1] https://lkml.org/lkml/2017/2/6/551
[reset1] https://lkml.org/lkml/2017/2/6/554

Andrey Smirnov (4):
  PCI: imx6: Add code to support i.MX7D
  PCI: imx6: Do not wait for speed change on i.MX7
  PCI: imx6: Do not switch speed if Gen2 is disabled
  PCI: imx6: Allow probe deferal by reset GPIO

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  13 +-
 drivers/pci/host/pci-imx6.c                        | 199 +++++++++++++++------
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
 3 files changed, 161 insertions(+), 55 deletions(-)

-- 
2.9.3
