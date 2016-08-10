Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jisheng Zhang <jszhang@marvell.com>
To: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>, <bhelgaas@google.com>,
 <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 0/2] PCI: designware: let dw_pcie_link_up() beware of LTSSM
 training bit
Date: Wed, 10 Aug 2016 13:31:17 +0800
Message-ID: <1470807079-366-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jisheng Zhang <jszhang@marvell.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

patch1 is a trivial clean up: move the parameters for wait for link
into the core pcie-designware.c

Since link may be UP but still in link training, if so, we can't think
the link is up and operating correctly. So patch2 teaches
dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.

Since v1:
  - add Joao's Ack
  - rebased on v4.8-rc1

Jisheng Zhang (2):
  PCI: designware: mv parameters for wait for link into
    pcie-designware.c
  PCI: designware: let dw_pcie_link_up() beware of LTSSM training bit

 drivers/pci/host/pcie-designware.c | 11 +++++++++--
 drivers/pci/host/pcie-designware.h |  5 -----
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.8.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
