Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 00/22] PCI: Support for configurable PCI endpoint
Date: Fri, 17 Feb 2017 15:20:20 +0530
Message-ID: <1487325042-28227-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This patch series
 *) add PCI endpoint core layer
 *) modify designware/dra7xx driver to be configured in EP mode
 *) add a PCI endpoint *test* function driver and corresponding host
    driver

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

The patch series is created after applying
https://lkml.org/lkml/2017/2/16/270

I've also pushed the tree to
git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git next

Kishon Vijay Abraham I (22):
  PCI: endpoint: Add EP core layer to enable EP controller and EP
    functions
  Documentation: PCI: Guide to use PCI Endpoint Core Layer
  PCI: endpoint: Introduce configfs entry for configuring EP functions
  Documentation: PCI: Guide to use pci endpoint configfs
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
  dt-bindings: PCI: dra7xx: Add dt bindings to enable legacy mode
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

 Documentation/PCI/00-INDEX                         |    8 +
 .../PCI/endpoint/function/binding/pci-test.txt     |   17 +
 Documentation/PCI/endpoint/pci-endpoint-cfs.txt    |   84 +++
 Documentation/PCI/endpoint/pci-endpoint.txt        |  190 +++++++
 Documentation/PCI/endpoint/pci-test-function.txt   |   66 +++
 Documentation/PCI/endpoint/pci-test-howto.txt      |  167 ++++++
 .../devicetree/bindings/pci/designware-pcie.txt    |   26 +-
 Documentation/devicetree/bindings/pci/ti-pci.txt   |   41 +-
 Documentation/misc-devices/pci-endpoint-test.txt   |   35 ++
 MAINTAINERS                                        |    9 +
 arch/arm/mach-omap2/clockdomains7xx_data.c         |    2 +-
 drivers/Makefile                                   |    2 +
 drivers/misc/Kconfig                               |    7 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/pci_endpoint_test.c                   |  534 +++++++++++++++++++
 drivers/pci/Kconfig                                |    1 +
 drivers/pci/dwc/Kconfig                            |   36 +-
 drivers/pci/dwc/Makefile                           |    5 +-
 drivers/pci/dwc/pci-dra7xx.c                       |  271 +++++++++-
 drivers/pci/dwc/pcie-designware-ep.c               |  342 ++++++++++++
 drivers/pci/dwc/pcie-designware.c                  |   51 ++
 drivers/pci/dwc/pcie-designware.h                  |   79 +++
 drivers/pci/endpoint/Kconfig                       |   33 ++
 drivers/pci/endpoint/Makefile                      |    7 +
 drivers/pci/endpoint/functions/Kconfig             |   12 +
 drivers/pci/endpoint/functions/Makefile            |    5 +
 drivers/pci/endpoint/functions/pci-epf-test.c      |  513 ++++++++++++++++++
 drivers/pci/endpoint/pci-ep-cfs.c                  |  427 +++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c                |  548 ++++++++++++++++++++
 drivers/pci/endpoint/pci-epc-mem.c                 |  143 +++++
 drivers/pci/endpoint/pci-epf-core.c                |  347 +++++++++++++
 include/linux/mod_devicetable.h                    |   10 +
 include/linux/pci-epc.h                            |  141 +++++
 include/linux/pci-epf.h                            |  160 ++++++
 include/linux/pci_ids.h                            |    2 +
 include/uapi/linux/Kbuild                          |    1 +
 include/uapi/linux/pcitest.h                       |   19 +
 tools/pci/pcitest.c                                |  186 +++++++
 tools/pci/pcitest.sh                               |   56 ++
 39 files changed, 4544 insertions(+), 40 deletions(-)
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
 create mode 100644 include/linux/pci-epc.h
 create mode 100644 include/linux/pci-epf.h
 create mode 100644 include/uapi/linux/pcitest.h
 create mode 100644 tools/pci/pcitest.c
 create mode 100644 tools/pci/pcitest.sh

-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
