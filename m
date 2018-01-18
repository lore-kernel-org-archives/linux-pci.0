Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:56022 "EHLO
        10.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932561AbeARXKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jan 2018 18:10:44 -0500
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id E6BD799C00
        for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2018 23:53:10 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v4 0/7] PCI: Add support to the Cadence PCIe controller
Date: Thu, 18 Jan 2018 23:52:45 +0100
Message-Id: <cover.1516314953.git.cyrille.pitchen@free-electrons.com>
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

The EndPoint Controller (EPC) driver was removed only because I didn't
have time to take all Kishon's comments into account. However, using a
fixed patch based on patch 7 of the v2 series + another patch fixing
the EPF device name chosen by pci_epf_make(), I was abled to probe
both function 0 and function 1 of the of the 2nd Cadence PCIe controller
configured in endpoint mode (new hardware design since v2 so function 1
is now available).

Currently I'm facing 2 issues, which I didn't have enough time to
investigate and to fix yet:

1 - when the vendor:device IDs are set to 104c:b500 for both functions,
then I remove both devfn (echo 1 > /sys/bus/pci/devices/$BDF/remove)
before scanning the PCI bus again (echo 1 > /sys/bus/pci/rescan),
the PCI enumeration fails reporting that the PCI memory is exhausted.

2 - when I set the vendor:device IDs to 104c:0100 for function 0 and
104c:b500 and remove only function 1 before scanning the PCI bus again,
I now pass the PCI enumeration. I also pass the 'pcitest -b <BAR>' test
but I fail on the MSI test ('pcitest -m <MSI>').

I'm still investigating on those issues.

Best regards,

Cyrille

ChangeLog

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

Cyrille Pitchen (6):
  PCI: Regroup all PCI related entries into drivers/pci/Makefile
  PCI: OF: Add generic function to parse and allocate PCI resources
  PCI: generic: fix missing call of pci_free_resource_list()
  PCI: Add generic function to probe PCI host controllers
  PCI: Add vendor ID for Cadence
  PCI: cadence: Add host driver for Cadence PCIe controller

Scott Telford (1):
  dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe host
    controller

 .../bindings/pci/cdns,cdns-pcie-host.txt           |  60 ++++
 MAINTAINERS                                        |   7 +
 drivers/Makefile                                   |   5 +-
 drivers/pci/Kconfig                                |   2 +
 drivers/pci/Makefile                               |  14 +-
 drivers/pci/cadence/Kconfig                        |  16 +
 drivers/pci/cadence/Makefile                       |   3 +
 drivers/pci/cadence/pcie-cadence-host.c            | 336 +++++++++++++++++++++
 drivers/pci/cadence/pcie-cadence.c                 |  56 ++++
 drivers/pci/cadence/pcie-cadence.h                 | 194 ++++++++++++
 drivers/pci/dwc/Makefile                           |   2 +
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pci-host-common.c                 |  72 +----
 drivers/pci/of.c                                   |  51 ++++
 drivers/pci/probe.c                                |  33 ++
 include/linux/pci.h                                |  10 +
 include/linux/pci_ids.h                            |   2 +
 17 files changed, 790 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
 create mode 100644 drivers/pci/cadence/Kconfig
 create mode 100644 drivers/pci/cadence/Makefile
 create mode 100644 drivers/pci/cadence/pcie-cadence-host.c
 create mode 100644 drivers/pci/cadence/pcie-cadence.c
 create mode 100644 drivers/pci/cadence/pcie-cadence.h

-- 
2.11.0
