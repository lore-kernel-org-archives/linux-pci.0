Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <bhelgaas@google.com>, <robh+dt@kernel.org>
Subject: [PATCHv2 0/2] PCI: add ls2088a and ls1088a support
Date: Fri, 4 Aug 2017 14:41:32 +0800
Message-ID: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: minghuan.lian@nxp.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 shawnguo@kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Hou Zhiqiang (2):
  PCI: layerscape: Add support for ls2088a
  PCI: layerscape: Add support for ls1088a

 Documentation/devicetree/bindings/pci/layerscape-pci.txt |  2 ++
 drivers/pci/dwc/pci-layerscape.c                         | 10 ++++++++++
 2 files changed, 12 insertions(+)

-- 
2.1.0.27.g96db324


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
