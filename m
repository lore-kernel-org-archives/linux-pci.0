Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
 <eddie.huang@mediatek.com>, <ryder.lee@mediatek.com>,
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4 0/2] PCI: mediatek: Fixups for the IRQ handle routine and
 MT7622's class code
Date: Fri, 22 Dec 2017 13:39:36 +0800
Message-ID: <1513921178-16148-1-git-send-email-honghui.zhang@mediatek.com>
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

Two fixups for mediatek's host bridge:
The first patch fixup the IRQ handle routine to avoid IRQ reentry which
may exist for both MT2712 and MT7622.
The second patch fixup class type for MT7622.

Change since v3:
 - Setup the class type and vendor ID at the beginning of startup instead
   of in a quirk.
 - Add mediatek's vendor ID, it could be found in:
   https://pcisig.com/membership/member-companies?combine=&page=4

Change since v2:
 - Move the initialize of the iterate before the loop to fix an
   INTx IRQ issue in the first patch

Change since v1:
 - Add the second patch.
 - Make the first patch's commit message more standard.

Honghui Zhang (2):
  PCI: mediatek: Clear IRQ status after IRQ dispatched to avoid reentry
  PCI: mediatek: Set up class type and vendor ID for MT7622

 drivers/pci/host/pcie-mediatek.c | 23 ++++++++++++++++++-----
 include/linux/pci_ids.h          |  3 +++
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
