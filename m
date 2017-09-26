Return-Path: <SRS0=sCe6=A3=free.fr=marc.w.gonzalez@kernel.org>
Return-Path: <SRS0=sCe6=A3=free.fr=marc.w.gonzalez@kernel.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [RESEND PATCH v11 0/3] Tango PCIe host bridge MSI support + required
 API
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Marc Zyngier
 <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Mason <slash.tmp@free.fr>
Message-ID: <93a30f88-17e1-af14-0c50-54f829c1158b@free.fr>
Date: Tue, 26 Sep 2017 12:21:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

Someone pointed out that the patches in this series had been mangled by
the server. Thus I'm resending them.

I have added the tags given by Rob and Linus W.

The MSI patch has remained mostly unchanged since v9 (posted three months ago)
except for a cosmetic cleanup in v10 (no functional changes, Acked by Marc Z
with one remark about the doorbell address) and addressing the doorbell remark
in v11 (Discover msi_doorbell in probe by parsing dma-ranges).

Is this code in good enough shape to reach upstream?


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
