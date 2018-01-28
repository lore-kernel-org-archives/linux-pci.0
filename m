Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:46032 "EHLO
        1.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbeA1UsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jan 2018 15:48:09 -0500
Received: from player776.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 5ED3BBAE49
        for <linux-pci@vger.kernel.org>; Sun, 28 Jan 2018 21:40:43 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v5 00/11] PCI: Add support to the Cadence PCIe controller
Date: Sun, 28 Jan 2018 21:40:14 +0100
Message-Id: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
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

The EndPoint Controller (EPC) driver was tested with 2 PCI functions, both
handled by the pci-epf-test driver, using the pcitest userspace program.
I used the "-D" optional command line parameter to select the proper PCI
function.

Best regards,

Cyrille

ChangeLog

v4 -> v5:
- rebase on today's (20180128) linux-pci/next
- add again the endpoint driver

- Patch 7:
 move host driver from drivers/pci/cadence into drivers/pci/host and remove
 all references to the endpoint mode, as requested by Lorenzo.
 The host driver will be moved back into drivers/pci/cadence by Patch 11

- Patch 8:
 fix comparison of func_no to BAR5: compare to epc->max_functions

- Patch 9:
 add new patch to fix support of PCI multi-function devices

- Patch 10:
 change the 'cdns,max-outbound-regions' from optional to mandatory as requested
 by Kishon.

- Patch 11:
 take Kishon's comments into account as much as I could.

- Other patches: unchanged


v3 -> v4:
- split patch 3 from v3 into patches 3 and 4.
- remove unused cdns_pcie_reset_outbound_region() from old patch 6
  (new patch 7).
- other patches are unchanged.

v2 -> v3:

- rebase on today's linux-pci/next (20180110) 

patch1:
- rework the commit message of patch 1 and add two new comments on why endpoint
  library users must be linked after the endpoint library itself and why
  the dwc rule uses obj-y instead of obj-$(CONFIG_PCIE_CONFIG_DW).
- update patch 1 to add missing ifdef CONFIG_PCI / endif in
  drivers/pci/dwc/Makefile around the obj-$(CONFIG_ARM64) += pcie-hisi.o rule,
  like for the other obj-$(CONFIG_ARM64) rules in drivers/pci/host/Makefile.

patch2: unchanged

patch3:
- update patch 3 so the bridge hooks/members initialization is left to the
  host bridges probe routines.

patch4: unchanged

patch5:
- collect 'Reviewed-by' tag from Rob Herring for the DT bindings.

patch6:
- remove explanation in the commit message on why obj-$(CONFIG_PCIE_CANDENCE) is
  placed after obj-$(CONFIG_PCI_ENDPOINT) in drivers/pci/Makefile since a
  comment on it has been added into patch1.
- remove menuconfig PCI_CADENCE in drivers/pci/cadence/Kconfig to match
  drivers/pci/dwc/Kconfig.
- adapt patch6 to the changes done in patch3 for the pci_host_probe() function.

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

Cyrille Pitchen (10):
  PCI: Regroup all PCI related entries into drivers/pci/Makefile
  PCI: OF: Add generic function to parse and allocate PCI resources
  PCI: generic: fix missing call of pci_free_resource_list()
  PCI: Add generic function to probe PCI host controllers
  PCI: Add vendor ID for Cadence
  PCI: cadence: Add host driver for Cadence PCIe controller
  PCI: endpoint: Add the function number as argument to EPC ops
  PCI: endpoint: Fix EPF device name to support multi-function devices
  dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe endpoint
    controller
  PCI: cadence: Add EndPoint Controller driver for Cadence PCIe
    controller

Scott Telford (1):
  dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe host
    controller

 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |  22 +
 .../bindings/pci/cdns,cdns-pcie-host.txt           |  60 +++
 MAINTAINERS                                        |   7 +
 drivers/Makefile                                   |   5 +-
 drivers/pci/Kconfig                                |   2 +
 drivers/pci/Makefile                               |  14 +-
 drivers/pci/cadence/Kconfig                        |  27 +
 drivers/pci/cadence/Makefile                       |   4 +
 drivers/pci/cadence/pcie-cadence-ep.c              | 542 +++++++++++++++++++++
 drivers/pci/cadence/pcie-cadence-host.c            | 336 +++++++++++++
 drivers/pci/cadence/pcie-cadence.c                 | 126 +++++
 drivers/pci/cadence/pcie-cadence.h                 | 311 ++++++++++++
 drivers/pci/dwc/Makefile                           |   2 +
 drivers/pci/dwc/pcie-designware-ep.c               |  20 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  41 +-
 drivers/pci/endpoint/pci-ep-cfs.c                  |  46 +-
 drivers/pci/endpoint/pci-epc-core.c                |  62 ++-
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pci-host-common.c                 |  72 +--
 drivers/pci/of.c                                   |  51 ++
 drivers/pci/probe.c                                |  33 ++
 include/linux/pci-epc.h                            |  43 +-
 include/linux/pci.h                                |  10 +
 include/linux/pci_ids.h                            |   2 +
 24 files changed, 1693 insertions(+), 147 deletions(-)
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
