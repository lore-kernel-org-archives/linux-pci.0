Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: Initial imx7d pm support
Date: Tue, 29 May 2018 22:39:15 +0300
Message-Id: <cover.1527621510.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Abel Vesa <abel.vesa@nxp.com>,
 Anson Huang <Anson.Huang@nxp.com>, Jingoo Han <jingoohan1@gmail.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This series adds initial pm support on imx7d so that after
suspend/resume lspci works again. This mostly copies the resume sequence
from the imx tree.

More can be done later to reduce power in suspend as well as adding
support for other socs.

This is motivated mostly by a desire to bring imx PM code closer to
upstream. It is possible that I am missing some things about how PM
should be done for pci host drivers, it would be great if you could
point me the right way.

It also relies on this bugfix for PGC offsets:
    https://lkml.org/lkml/2018/5/29/138
Without that patch resume hangs on first PCI read from PCI-PM core. It
is not strictly related to PCI but pci-imx6 is the only user of gpcv2
power domains.

Patch 1 in this series is also technically an unrelated bugfix, however
pci-imx6 is the only user.

Leonard Crestez (2):
  reset: imx7: Fix always writing bits as 0
  PCI: imx: Initial imx7d pm support

 drivers/pci/dwc/pci-imx6.c | 94 ++++++++++++++++++++++++++++++++++++--
 drivers/reset/reset-imx7.c |  2 +-
 2 files changed, 90 insertions(+), 6 deletions(-)

-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
