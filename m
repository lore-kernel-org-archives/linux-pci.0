Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v7 0/4] i.MX7 PCI support
Date: Tue, 21 Mar 2017 06:41:59 -0700
Message-Id: <20170321134203.26325-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Dong Aisheng <dongas86@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, yurovsky@gmail.com,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello, everyone:

This is a seventh iteration of the code that adds PCI-subsystem bits
necessary for enabling PCI support on i.MX7.

NOTE: To test this patchset with real i.MX7 hardware, additional
patches, that are being upstreamed via different trees, are needed. Full
working tree is availible at:

	https://github.com/ndreys/linux/tree/imx7d/pcie-support-v7

Changes since v6 (can be found at [version6]):

	- Rebased against latest changes in 'next' of PCI subsystem
          git tree

Chagnes since v5 (can be found at [version5]):

	- Collected ACKs from Lee and Rob

Changes since v4 (can be found at [version4]):

	- Dropped typo-fix patch (originally patch #1 of the
          series).

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

[version6] https://lkml.org/lkml/2017/3/14/584
[version5] https://lkml.org/lkml/2017/2/20/376
[version4] https://lkml.org/lkml/2017/2/7/478
[version3] https://lkml.org/lkml/2017/2/6/565
[version2] https://lkml.org/lkml/2017/2/1/510
[version1] https://lkml.org/lkml/2017/1/19/488
[gpc1] https://lkml.org/lkml/2017/2/6/551
[reset1] https://lkml.org/lkml/2017/2/6/554

Andrey Smirnov (4):
  PCI: imx6: Add code to support i.MX7D
  PCI: imx6: Allow probe deferal by reset GPIO
  PCI: imx6: Do not wait for speed change on i.MX7
  PCI: imx6: Do not switch speed if Gen2 is disabled

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  13 +-
 drivers/pci/dwc/pci-imx6.c                         | 198 +++++++++++++++------
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
 3 files changed, 160 insertions(+), 55 deletions(-)

-- 
2.9.3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
