Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <robh@kerenl.org>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
 <ryder.lee@mediatek.com>
Subject: [PATCH v2 0/5] PCI: MediaTek: Add support for new generation host
 controller
Date: Thu, 27 Jul 2017 10:58:34 +0800
Message-ID: <cover.1501122135.git.honghui.zhang@mediatek.com>
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
from the lagacy controller.
This patchset abstract the common probing flow, and add support for the
new generation controller.

Changes since v1:
 - Fix build warnings in arm arch.
 - Using SoC specific compatible instead of generic compatible.
 - Add devicetree binding example for mt7622.
 - Unified the register define names with PCIE_ prefix.
 - Cleanup some un-necessary condition determine when starup port.
 - minor code cleanups.

Ryder Lee (5):
  PCI: mediatek: Add a structure to abstract the controller generations
  PCI: mediatek: switch to use platform_get_resource_byname()
  dt-bindings: PCI: rename and cleanup MediaTek binding text
  PCI: mediatek: Add new generation controller support
  dt-bindings: PCI: add support for new generation controller

 .../bindings/pci/mediatek,mt7623-pcie.txt          | 130 -----
 .../devicetree/bindings/pci/mediatek-pcie.txt      | 283 ++++++++++
 drivers/pci/host/Kconfig                           |   5 +-
 drivers/pci/host/pcie-mediatek.c                   | 588 +++++++++++++++++++--
 4 files changed, 829 insertions(+), 177 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt

-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
