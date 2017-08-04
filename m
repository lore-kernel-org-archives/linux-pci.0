Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <robh@kerenl.org>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
 <ryder.lee@mediatek.com>
Subject: [PATCH v3 0/6] PCI: MediaTek: Add support for new generation host
 controller
Date: Fri, 4 Aug 2017 20:06:36 +0800
Message-ID: <cover.1501846816.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, hongkun.cao@mediatek.com, sean.wang@mediatek.com,
 xinping.qian@mediatek.com, honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 yong.wu@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

MediaTek's PCIe host controller has two generation HWs, the new
generation HW has two root ports, it shares most probing flow with the
legacy controller. But the read/write config space logical is different
from the legacy controller. The per-port register must be touched for
read/write config space, And the per-port register base are in separate
address space.

This patchset abstract the common probing flow, and add support for the
new generation controller.

Changes since v2:
 - Split the Gen2 training change to a separate patch.
 - Simplify the config_read/write logical and get rid of mtk_pcie_find_port.
 - Using bus->sysdata to simplify the code.
 - Rebase to commit 65b83b13204a ("PCI: mediatek: Explicitly request exclusive
   reset control")[1].
 - Fix some misspells.
 - Add review tags in commit message.

Changes since v1:
 - Fix build warnings in arm arch.
 - Using SoC specific compatible instead of generic compatible.
 - Add devicetree binding example for mt7622.
 - Unified the register define names with PCIE_ prefix.
 - Cleanup some un-necessary condition determine when starup port.
 - minor code cleanups.

[1] https://patchwork.kernel.org/patch/9852591/

Honghui Zhang (1):
  PCI: mediatek: Add a structure to abstract the controller generations

Ryder Lee (5):
  PCI: mediatek: Using readl_poll_timeout to wait Gen2 training
  PCI: mediatek: switch to use platform_get_resource_byname()
  dt-bindings: PCI: rename and cleanup MediaTek binding text
  PCI: mediatek: Add new generation controller support
  dt-bindings: PCI: add support for new generation controller

 .../bindings/pci/mediatek,mt7623-pcie.txt          | 130 -----
 .../devicetree/bindings/pci/mediatek-pcie.txt      | 284 ++++++++++
 drivers/pci/host/Kconfig                           |   5 +-
 drivers/pci/host/pcie-mediatek.c                   | 571 +++++++++++++++++++--
 4 files changed, 812 insertions(+), 178 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt

-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
