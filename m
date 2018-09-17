Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vignesh R <vigneshr@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4 0/2] pci-dra7xx: Enable errata i870 workaround for RC mode
Date: Mon, 17 Sep 2018 23:36:33 +0530
Message-ID: <20180917180635.26996-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make workaround for errata i870 applicable in Host mode as
well(previously it was enabled only for EP mode) as per errata
documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf
Driver will continue to work with w/o applying errata in host mode when
using older DT, to maintain backward compatibility.

Tested on DRA72 EVM

Changes since v3:
Rebase onto latest next
Drop DT patches from this series. They will be sent separately once
driver changes in this series is merged.

Changes since v2:
Reorder patch 2 to appear at the last.
Collect all the ACKs

Changes since v1:
Drop IRQ handling rework (will be sent out separately)

v2: https://patchwork.ozlabs.org/cover/935454/
v1: https://lkml.org/lkml/2017/12/1/59


Vignesh R (2):
  dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
    mode
  pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode

 Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
 drivers/pci/controller/dwc/pci-dra7xx.c          | 12 ++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.19.0
