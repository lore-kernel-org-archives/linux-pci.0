Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Russell King <linux@arm.linux.org.uk>
Subject: [PATCHv2 0/3] PCI: emulated PCI bridge config space
Date: Wed, 12 Sep 2018 17:48:28 +0200
Message-Id: <20180912154831.2220-1-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

The pci-mvebu driver already contains some logic to emulate a root
port PCI bridge configuration space. It turns out that we have a
similar need for the pci-aardvark driver. Instead of duplicating the
same logic in two drivers, this patch series starts by adding a small
common infrastructure that helps emulate a root port PCI bridge config
space, converts pci-mvebu to use it, and finally extends pci-aardvark
to use it as well.

Thanks to this, Marvell Armada 3720 based systems, which use the
Aarkvark PCI controller, will have better PCI support, by having a
root port PCI bridge exposed.

The emulated PCI bridge common logic is a proposal, I very much
welcome comments and suggestions. Also, if you feel that adding a
common logic for only two drivers is too early, I'm fine with
duplicating a bit of code betwen pci-mvebu and pci-aardvark.

In this version 2, I have (hopefully) taken into account the comments
from Bjorn Helgaas and Russell King. Here are the changes:

 - Rebased to 4.19-rc1

 - The functions implementing the config space read/write emulation
   now have the knowledge of which registers/bits are read-only,
   read-write, reserved and write-1-to-clear, and behave according to
   this information.

 - I have renamed the function to use conf_read() and conf_write()
   suffixes, as suggested by Bjorn.

 - The whole thing is now named pci-bridge-emul instead of
   pci-sw-bridge (and of course all functions, types and macros were
   changed accordingly), as Bjorn wasn't happy about pci-sw-bridge.

 - The header file was moved into drivers/pci (instead of being in
   include/linux).

Thanks a lot in advance for your review and feedback.

Best regards,

Thomas Petazzoni

Thomas Petazzoni (2):
  PCI: Introduce PCI bridge emulated config space common logic
  PCI: mvebu: Convert to PCI emulated bridge config space

Zachary Zhang (1):
  PCI: aardvark: Implement emulated root PCI bridge config space

 drivers/pci/Kconfig                   |   3 +
 drivers/pci/Makefile                  |   1 +
 drivers/pci/controller/Kconfig        |   2 +
 drivers/pci/controller/pci-aardvark.c | 129 ++++++++++-
 drivers/pci/controller/pci-mvebu.c    | 375 +++++++++----------------------
 drivers/pci/pci-bridge-emul.c         | 408 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci-bridge-emul.h         | 124 +++++++++++
 7 files changed, 770 insertions(+), 272 deletions(-)
 create mode 100644 drivers/pci/pci-bridge-emul.c
 create mode 100644 drivers/pci/pci-bridge-emul.h

-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
