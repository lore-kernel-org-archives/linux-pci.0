Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 0/2] Add PCIe host driver support for Mediatek SoCs
Date: Wed, 10 May 2017 10:06:58 +0800
Message-ID: <1494382020-26790-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Red Hung <red.hung@mediatek.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ryder Lee <ryder.lee@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

This patch series add Mediatek Gen2 PCIe host controller driver and
dt-binding document. It can be found on MT7623 series SoCs.

This driver was validated using Broadcom Tigon3 and Intel(R) 82575/82576
gigabit ethernet card.

Changes since v3:
- correct sub-nodes unit addresses.

Changes since v2:
- modify Kconfig to avoid kbuild test error on some architecture.
- change compatible string.
- revise binding document:
  add missing interrupt-names.
  remove the board dts example and drop 'status' properties.
  remove unnecessary descriptions bout standard PCI bus binding.

Changes since v1:
- add .suppress_bind_attrs.
- remove unnecessary *_valid_device() pattern.
- remove PCI_PROBE_ONLY.
- use the regular readl() instead of readl_relaxed().
- add .map_bus() and change to use pci_generic_config_read/pci_generic_config_write.
- revise dt-binding document and move nonstandard properties to root node.
- change compatible string.
- use interrupt-map property and replace mtk_pcie_map_irq() with of_irq_parse_and_map_pci().
- use the new pci_register_host_bridge() method instead of pci_scan_root_bus().

Ryder Lee (2):
  PCI: mediatek: Add Mediatek PCIe host controller support
  dt-bindings: pcie: Add documentation for Mediatek PCIe

 .../bindings/pci/mediatek,mt7623-pcie.txt          | 149 ++++++
 drivers/pci/host/Kconfig                           |  11 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-mediatek.c                   | 563 +++++++++++++++++++++
 4 files changed, 724 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
 create mode 100644 drivers/pci/host/pcie-mediatek.c

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
