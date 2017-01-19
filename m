Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 0/3] i.MX7 PCI support
Date: Thu, 19 Jan 2017 08:36:28 -0800
Message-Id: <20170119163631.10668-1-andrew.smirnov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 yurovsky@gmail.com, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello, everyone:

This is a small patchset intended to add PCI-subsystem bits necessary
for enabling PCI support on i.MX7. This patchset is not
self-sufficient and depends on three other patchsets:

  - Changes to anatop regulator driver
  - Chagnes to i.MX device tree code pertaining to anatop regulator
  - Changes to i.MX device tree pertaining to PCIe controller

I submitted first two in [1] and [2], and, unless adwised otherwise,
am planning on submitting the last one once [1], [2] and this patchset
are accepted.

This patch was tested against i210 card on i.MX7 Sabre board
(connected via mini-PCIe to PCIe adapter) with general functionality
and bandwidth tests.

Note that this patchset have known "blemish" where Gen1 cards (at
least) report this message:

 imx6q-pcie 33800000.pcie: Speed change timeout
 imx6q-pcie 33800000.pcie: Failed to bring link up!

due to hardware not clearing PORT_LOGIC_SPEED_CHANGE bit after speed
change is requested, but since this does not seem to affect the
functioning of the link I am hoping this is not a deal breaker.

I posted a question on NXP community web-site [3] hoping to get some
additional info to help resolve the matter and if anyone has any
suggestions I'd love to hear them.

Thanks,
Andrey Smirnov

[1] https://www.spinics.net/lists/arm-kernel/msg553215.html
[2] https://www.spinics.net/lists/kernel/msg2418471.html
[3] https://community.nxp.com/message/867943

Andrey Smirnov (3):
  PCI: imx6: Fix a typo in error message
  PCI: imx6: Allow probe deferal by reset GPIO
  PCI: imx6: Add code to support i.MX7D

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
 drivers/pci/host/pci-imx6.c                        | 197 ++++++++++++++++++---
 include/linux/mfd/syscon/imx7-gpc.h                |  18 ++
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
 include/linux/mfd/syscon/imx7-src.h                |  18 ++
 5 files changed, 214 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/mfd/syscon/imx7-gpc.h
 create mode 100644 include/linux/mfd/syscon/imx7-src.h

-- 
2.9.3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
