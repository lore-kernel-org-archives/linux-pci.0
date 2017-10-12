Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <roy.zang@nxp.com>,
 <mingkai.hu@nxp.com>, <minghuan.lian@nxp.com>
Subject: [PATCHv2 0/2] PCI: layerscape: add fixes for layerscape-pcie errata
Date: Thu, 12 Oct 2017 17:44:46 +0800
Message-ID: <20171012094448.31217-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The [1/2] is to fix layerscape PCIe MSI/MSI-X capability errata.
The [2/2] is to change the default AXI system error response behavior
for PCI Express outbound non-posted requests.

Hou Zhiqiang (1):
  PCI: Disable MSI for Freescale PCIe RC mode

Minghuan Lian (1):
  pci/layerscape: change the default error response behavior

 drivers/pci/dwc/pci-layerscape.c | 11 +++++++++++
 drivers/pci/quirks.c             |  8 ++++++++
 2 files changed, 19 insertions(+)

-- 
2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
