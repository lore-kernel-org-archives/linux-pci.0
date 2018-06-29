Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org
Subject: [PATCH 0/3] PCI: emulated PCI bridge common logic
Date: Fri, 29 Jun 2018 11:22:28 +0200
Message-Id: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Russell King <linux@arm.linux.org.uk>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 Zachary Zhang <zhangzg@marvell.com>, Wilson Ding <dingwei@marvell.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

The pci-mvebu driver already contains some logic to emulate a root
port PCI bridge. It turns out that we have a similar need for the
pci-aardvark driver. Instead of duplicating the same logic in two
drivers, this patch series starts by adding a small common
infrastructure that helps emulate a root port PCI bridge, converts
pci-mvebu to use it, and finally extends pci-aardvark to use it as
well.

Thanks to this, Marvell Armada 3720 based systems, which use the
Aarkvark PCI controller, will have better PCI support, by having a
root port PCI bridge exposed.

The emulated PCI bridge common logic is a proposal, I very much
welcome comments and suggestions. Also, if you feel that adding a
common logic for only two drivers is too early, I'm fine with
duplicating a bit of code betwen pci-mvebu and pci-aardvark.

Best regards,

Thomas

Thomas Petazzoni (2):
  PCI: Introduce PCI software bridge common logic
  PCI: mvebu: Convert to PCI software bridge

Zachary Zhang (1):
  PCI: aardvark: Implement emulated root PCI bridge

 drivers/pci/Kconfig                   |   3 +
 drivers/pci/Makefile                  |   1 +
 drivers/pci/controller/Kconfig        |   2 +
 drivers/pci/controller/pci-aardvark.c | 119 ++++++++++-
 drivers/pci/controller/pci-mvebu.c    | 370 ++++++++++------------------------
 drivers/pci/pci-sw-bridge.c           | 149 ++++++++++++++
 include/linux/pci-sw-bridge.h         | 125 ++++++++++++
 7 files changed, 497 insertions(+), 272 deletions(-)
 create mode 100644 drivers/pci/pci-sw-bridge.c
 create mode 100644 include/linux/pci-sw-bridge.h

-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
