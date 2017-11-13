Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v1 0/3] PCI: Rename host functions for consistency
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Date: Mon, 13 Nov 2017 16:40:36 -0600
Message-ID: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@xilinx.com>, rfi@lists.rocketboards.org,
 =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 Ley Foon Tan <lftan@altera.com>, linux-arm-kernel@lists.infradead.org,
 Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

All native host bridge driver probe functions are called *_pci_probe() or
*_pcie_probe() *except* X-Gene's.  All "is the link up?" functions are
called *_pcie_link_up() *except* Altera's and Xilinx's.  Rename them to be
consistent.

I plan to include these for v4.15 unless there are objections.

---

Bjorn Helgaas (3):
      PCI: xgene: Rename xgene_pcie_probe_bridge() to xgene_pcie_probe()
      PCI: altera: Rename altera_pcie_link_is_up() to altera_pcie_link_up()
      PCI: xilinx: Rename xilinx_pcie_link_is_up() to xilinx_pcie_link_up()


 drivers/pci/host/pci-xgene.c   |    4 ++--
 drivers/pci/host/pcie-altera.c |    8 ++++----
 drivers/pci/host/pcie-xilinx.c |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
