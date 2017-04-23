Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/2] Add PCIe host driver support for some Mediatek SoCs
Date: Sun, 23 Apr 2017 16:19:01 +0800
Message-ID: <1492935543-18190-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

This patch series add PCIe host controller driver and dt-binding
documentation for Mediatek mt7623 SoCs families.

This driver was validated using Broadcom Tigon3 ethernet card.

Ryder Lee (2):
  PCI: mediatek: Add Mediatek PCIe host controller support
  dt-bindings: pcie: Add documentation for Mediatek PCIe

 .../bindings/pci/mediatek,mt7623-pcie.txt          | 153 ++++++
 drivers/pci/host/Kconfig                           |  11 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-mediatek.c                   | 611 +++++++++++++++++++++
 4 files changed, 776 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
 create mode 100644 drivers/pci/host/pcie-mediatek.c

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
