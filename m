Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:45627 "EHLO
        2.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938093AbdLRSXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Dec 2017 13:23:33 -0500
Received: from player158.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id E1CEF17A725
        for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2017 19:16:26 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v2 0/9] PCI: Add support to the Cadence PCIe controller
Date: Mon, 18 Dec 2017 19:16:00 +0100
Message-Id: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

this series of patches adds support to the Cadence PCIe controller.
It was tested on a ARM64 platform emulated by a Palladium running the
pci-next kernel.

The host mode was tested with some PCIe devices connected to the Palladium
through a speed-bridge. Some of those devices were a USB host controller
and a SATA controller. The PCIe host controller was also tested with a
second controller configured in endpoint mode and connected back to back
to the first controller.

The EndPoint Controller (EPC) driver of this series was tested with the
pci-epf-test.c EndPoint Function (EPF) driver and the pcitest userspace
program.

For pci-next, I applied this series on top of Kishon's patch
("PCI: endpoint: Use EPC's device in dma_alloc_coherent/dma_free_coherent")
otherwise dma_alloc_coherent() fails when called by pci_epf_alloc_space().

Best regards,

Cyrille

ChangeLog:

v1 -> v2:
- add new properties in the device-tree bindings: 'cdns,max-outbound-regions'
  and 'cdns,no-bar-match-nbits'.
- add a new patch to regroup all makefile rules in drivers/pci/Makefile, hence
  cleaning drivers/Makefile up.
- change the license text to use the recommanded format:
  // SPDX-License-Identifier: GPL-2.0
- add a new patch updating the API of the EPC library to add support to
  multi-function devices.
- add a 2 new patches to share more common code between host controller drivers
- remove some useless tests
- add more comments in both drivers.
- fix DT bindings examples
- remove useless init of the primary, secondary and sub-ordinate bus numbers in
  the PCI configuration space of the root port.
- remove cdns_pcie_ep_stop() function and rework cdns_pcie_ep_start() function

Cyrille Pitchen (8):
  PCI: Regroup all PCI related entries into drivers/pci/Makefile
  PCI: OF: Add generic function to parse and allocate PCI resources
  PCI: Add generic function to probe PCI host controllers
  PCI: Add vendor ID for Cadence
  PCI: cadence: Add host driver for Cadence PCIe controller
  PCI: endpoint: Add the function number as argument to EPC ops
  dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe endpoint
    controller
  PCI: cadence: Add EndPoint Controller driver for Cadence PCIe
    controller

Scott Telford (1):
  dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe host
    controller

 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |  23 +
 .../bindings/pci/cdns,cdns-pcie-host.txt           |  60 +++
 MAINTAINERS                                        |   7 +
 drivers/Makefile                                   |   5 +-
 drivers/pci/Kconfig                                |   2 +
 drivers/pci/Makefile                               |  12 +-
 drivers/pci/cadence/Kconfig                        |  33 ++
 drivers/pci/cadence/Makefile                       |   4 +
 drivers/pci/cadence/pcie-cadence-ep.c              | 531 +++++++++++++++++++++
 drivers/pci/cadence/pcie-cadence-host.c            | 330 +++++++++++++
 drivers/pci/cadence/pcie-cadence.c                 |  95 ++++
 drivers/pci/cadence/pcie-cadence.h                 | 310 ++++++++++++
 drivers/pci/dwc/pcie-designware-ep.c               |  20 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  41 +-
 drivers/pci/endpoint/pci-epc-core.c                |  62 ++-
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pci-host-common.c                 |  87 +---
 drivers/pci/of.c                                   |  51 ++
 drivers/pci/probe.c                                |  50 ++
 include/linux/pci-epc.h                            |  43 +-
 include/linux/pci.h                                |  12 +
 include/linux/pci_ids.h                            |   2 +
 22 files changed, 1624 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
 create mode 100644 drivers/pci/cadence/Kconfig
 create mode 100644 drivers/pci/cadence/Makefile
 create mode 100644 drivers/pci/cadence/pcie-cadence-ep.c
 create mode 100644 drivers/pci/cadence/pcie-cadence-host.c
 create mode 100644 drivers/pci/cadence/pcie-cadence.c
 create mode 100644 drivers/pci/cadence/pcie-cadence.h

-- 
2.11.0
