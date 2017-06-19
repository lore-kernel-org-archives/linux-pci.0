Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] change powerup logic for MediaTek PCIe controller
Date: Mon, 19 Jun 2017 17:59:57 +0800
Message-ID: <1497866400-41844-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

This patch series does some modifications to powerup logic to avoid unbalanced
PM warnings, and turns off host power if no link is detected.

I also make some properties(eg, PHY/reset/..) optional to gain more flexibility
just in case future SoCs don't have it.

Could you also fold this patch series into pci/host-mediatek for v4.13?
Thanks!

Ryder Lee (3):
  PCI: mediatek: modify controller powerup logic
  PCI: mediatek: turn off subsys power if no link up detected
  PCI: mediatek: make some properties optioanl

 drivers/pci/host/pcie-mediatek.c | 110 +++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 52 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
