Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:13821 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdCIH67 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2017 02:58:59 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <hch@infradead.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v3 00/23] PCI: Support for configurable PCI endpoint
Date: Thu, 9 Mar 2017 13:27:11 +0530
Message-ID: <1489046254-19919-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series
 *) add PCI endpoint core layer
 *) modify designware and dra7xx driver to be configured in EP mode
 *) add a PCI endpoint *test* function driver and corresponding host
    driver

Changes from v2:
*) changed the configfs structure as suggested by Christoph Hellwig. With
   this change the framework creates configfs entry for EP function driver
   and EP controller. Previously these entries have to be created by the
   the user. (Haven't changed the epc core or epf core except for invoking
   configfs APIs to create entries for EP function driver and EP controller.
   That's mostly because the EP function device can still be created by
   directly invoking the epf core API without using configfs).
*) Now the user has to use configfs entry 'start' to start the link.
   This was previously done by the function driver. However in the case of
   multi function EP, the function driver shouldn't start the link.

Changes from v1:
*) The preparation patches for adding EP support is removed and is sent
   separately
*) Added device ID for DRA74x/DRA72x and used it instead of
   using "PCI_ANY_ID"
*) Added userguide for PCI endpoint test function

Major Improvements from RFC:
 *) support multi-function devices (hw supported not virtual)
 *) Access host side buffers
 *) Raise MSI interrupts
 *) Add user space program to use the host side PCI driver
 *) Adapt all other users of designware to use the new design (only
    compile tested. Since I have only dra7xx boards, the new design
    has only been tested in dra7xx. I'd require the help of others
    to test the platforms they have access to).

This series has been developed over 4.11-rc1 + [1]
This series has also been pushed to [2]

[1] -> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1348667.html
[2] -> git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git

Kishon Vijay Abraham I (23):
  PCI: endpoint: Add EP core layer to enable EP controller and EP
    functions
  Documentation: PCI: Guide to use PCI Endpoint Core Layer
  PCI: endpoint: Introduce configfs entry for configuring EP functions
  Documentation: PCI: Guide to use pci endpoint configfs
  PCI: endpoint: Create configfs entry for EPC device and EPF driver
  Documentation: PCI: Add specification for the *pci test* function
    device
  PCI: endpoint: functions: Add an EP function to test PCI
  Documentation: PCI: Add binding documentation for pci-test endpoint
    function
  PCI: dwc: designware: Add EP mode support
  dt-bindings: PCI: Add dt bindings for pci designware EP mode
  PCI: dwc: dra7xx: Facilitate wrapper and msi interrupts to be enabled
    independently
  PCI: dwc: dra7xx: Add EP mode support
  dt-bindings: PCI: dra7xx: Add dt bindings for pci dra7xx EP mode
  PCI: dwc: dra7xx: Workaround for errata id i870
  dt-bindings: PCI: dra7xx: Add dt bindings to enable unaligned access
  PCI: Add device IDs for DRA74x and DRA72x
  misc: Add host side pci driver for pci test function device
  Documentation: misc-devices: Add Documentation for pci-endpoint-test
    driver
  tools: PCI: Add a userspace tool to test PCI endpoint
  tools: PCI: Add sample test script to invoke pcitest
  Documentation: PCI: Add userguide for PCI endpoint test function
  MAINTAINERS: add PCI EP maintainer
  ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to
    SW_WKUP

 Documentation/PCI/00-INDEX                         |   10 +
 .../PCI/endpoint/function/binding/pci-test.txt     |   17 +
 Documentation/PCI/endpoint/pci-endpoint-cfs.txt    |  105 ++++
 Documentation/PCI/endpoint/pci-endpoint.txt        |  215 ++++++++
 Documentation/PCI/endpoint/pci-test-function.txt   |   66 +++
 Documentation/PCI/endpoint/pci-test-howto.txt      |  179 ++++++
 .../devicetree/bindings/pci/designware-pcie.txt    |   26 +-
 Documentation/devicetree/bindings/pci/ti-pci.txt   |   42 +-
 Documentation/misc-devices/pci-endpoint-test.txt   |   35 ++
 MAINTAINERS                                        |    9 +
 arch/arm/mach-omap2/clockdomains7xx_data.c         |    2 +-
 drivers/Makefile                                   |    2 +
 drivers/misc/Kconfig                               |    7 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/pci_endpoint_test.c                   |  534 ++++++++++++++++++
 drivers/pci/Kconfig                                |    1 +
 drivers/pci/dwc/Kconfig                            |   36 +-
 drivers/pci/dwc/Makefile                           |    5 +-
 drivers/pci/dwc/pci-dra7xx.c                       |  274 ++++++++-
 drivers/pci/dwc/pcie-designware-ep.c               |  340 ++++++++++++
 drivers/pci/dwc/pcie-designware.c                  |  136 +++++
 drivers/pci/dwc/pcie-designware.h                  |   82 +++
 drivers/pci/endpoint/Kconfig                       |   31 ++
 drivers/pci/endpoint/Makefile                      |    7 +
 drivers/pci/endpoint/functions/Kconfig             |   12 +
 drivers/pci/endpoint/functions/Makefile            |    5 +
 drivers/pci/endpoint/functions/pci-epf-test.c      |  510 +++++++++++++++++
 drivers/pci/endpoint/pci-ep-cfs.c                  |  509 +++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c                |  579 ++++++++++++++++++++
 drivers/pci/endpoint/pci-epc-mem.c                 |  143 +++++
 drivers/pci/endpoint/pci-epf-core.c                |  351 ++++++++++++
 include/linux/mod_devicetable.h                    |   10 +
 include/linux/pci-ep-cfs.h                         |   41 ++
 include/linux/pci-epc.h                            |  144 +++++
 include/linux/pci-epf.h                            |  162 ++++++
 include/linux/pci_ids.h                            |    2 +
 include/uapi/linux/Kbuild                          |    1 +
 include/uapi/linux/pcitest.h                       |   19 +
 tools/pci/pcitest.c                                |  186 +++++++
 tools/pci/pcitest.sh                               |   56 ++
 40 files changed, 4852 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.txt
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-cfs.txt
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint.txt
 create mode 100644 Documentation/PCI/endpoint/pci-test-function.txt
 create mode 100644 Documentation/PCI/endpoint/pci-test-howto.txt
 create mode 100644 Documentation/misc-devices/pci-endpoint-test.txt
 create mode 100644 drivers/misc/pci_endpoint_test.c
 create mode 100644 drivers/pci/dwc/pcie-designware-ep.c
 create mode 100644 drivers/pci/endpoint/Kconfig
 create mode 100644 drivers/pci/endpoint/Makefile
 create mode 100644 drivers/pci/endpoint/functions/Kconfig
 create mode 100644 drivers/pci/endpoint/functions/Makefile
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-test.c
 create mode 100644 drivers/pci/endpoint/pci-ep-cfs.c
 create mode 100644 drivers/pci/endpoint/pci-epc-core.c
 create mode 100644 drivers/pci/endpoint/pci-epc-mem.c
 create mode 100644 drivers/pci/endpoint/pci-epf-core.c
 create mode 100644 include/linux/pci-ep-cfs.h
 create mode 100644 include/linux/pci-epc.h
 create mode 100644 include/linux/pci-epf.h
 create mode 100644 include/uapi/linux/pcitest.h
 create mode 100644 tools/pci/pcitest.c
 create mode 100644 tools/pci/pcitest.sh

-- 
1.7.9.5
