Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [PATCH 0/3] Tango PCIe host bridge MSI support + required API
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
Date: Tue, 29 Aug 2017 16:19:26 +0200
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mason <slash.tmp@free.fr>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn, Marc,

This patch-set includes
	[PATCH v11] PCI: tango: Add MSI controller support
with the doorbell address parsed from DT instead of hard-coded
in the driver.

A wrapper to parse dma-ranges was added to drivers/of/address.c

A few drivers were converted to use the new wrapper.

Marc Gonzalez (3):
  of/pci: Add dma-ranges parsing support
  PCI: Use of_pci_dma_range_parser_init API
  PCI: tango: Add MSI controller support

 drivers/of/address.c             |  19 +++-
 drivers/pci/host/pci-ftpci100.c  |  20 +---
 drivers/pci/host/pci-rcar-gen2.c |  20 +---
 drivers/pci/host/pci-xgene.c     |  20 +---
 drivers/pci/host/pcie-iproc.c    |  20 +---
 drivers/pci/host/pcie-rcar.c     |  20 +---
 drivers/pci/host/pcie-tango.c    | 205 ++++++++++++++++++++++++++++++++++++++-
 include/linux/of_address.h       |  10 +-
 8 files changed, 232 insertions(+), 102 deletions(-)

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
