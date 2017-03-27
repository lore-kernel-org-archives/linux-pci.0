Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] PCI: Support for configurable PCI endpoint 
Date: Mon, 27 Mar 2017 15:14:56 +0530
Message-ID: <20170327094520.3129-1-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, nsekhar@ti.com, kishon@ti.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Please find the pull request for PCI endpoint support below. I've
also included all the history here.

Changes from v4:
*) add #syscon-cells property and used of_parse_phandle_with_args
   to perform a configuration in syscon module (as suggested by
   Rob Herring)
*) Remove unnecessary white space.

Changes from v3:
*) fixed a typo and adapted to https://lkml.org/lkml/2017/3/13/562.

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
[1] -> https://lkml.org/lkml/2017/3/13/562

Let me know if this has to be re-based to some of your branch.

Thanks
Kishon

The following changes since commit 623e87fec8ab7867fb51b3079196bd10718a60ce:

  PCI: dwc: dra7xx: Push request_irq call to the bottom of probe (2017-03-22 20:35:30 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git tags/pci-endpoint-for-4.12

for you to fetch changes up to e98bf80074be4654faae42fe0f5a622a776b6fdd:

  ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP (2017-03-27 15:08:22 +0530)

----------------------------------------------------------------
pci: endpoint: for 4.12

 *) Add PCI endpoint core layer
 *) Modify designware and dra7xx driver to be configured in EP mode
 *) Add a PCI endpoint *test* function driver and corresponding host
    driver

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Kishon Vijay Abraham I (24):
      PCI: endpoint: Add EP core layer to enable EP controller and EP functions
      Documentation: PCI: Guide to use PCI Endpoint Core Layer
      PCI: endpoint: Introduce configfs entry for configuring EP functions
      Documentation: PCI: Guide to use pci endpoint configfs
      PCI: endpoint: Create configfs entry for EPC device and EPF driver
      Documentation: PCI: Add specification for the *pci test* function device
      PCI: endpoint: functions: Add an EP function to test PCI
      Documentation: PCI: Add binding documentation for pci-test endpoint function
      PCI: dwc: designware: Add EP mode support
      dt-bindings: PCI: Add dt bindings for pci designware EP mode
      PCI: dwc: dra7xx: Facilitate wrapper and msi interrupts to be enabled independently
      PCI: dwc: dra7xx: Add EP mode support
      dt-bindings: PCI: dra7xx: Add dt bindings for pci dra7xx EP mode
      dt-bindings: mfd: syscon: Add documentation for #syscon-cells property
      PCI: dwc: dra7xx: Workaround for errata id i870
      dt-bindings: PCI: dra7xx: Add dt bindings to enable unaligned access
      PCI: Add device IDs for DRA74x and DRA72x
      misc: Add host side pci driver for pci test function device
      Documentation: misc-devices: Add Documentation for pci-endpoint-test driver
      tools: PCI: Add a userspace tool to test PCI endpoint
      tools: PCI: Add sample test script to invoke pcitest
      Documentation: PCI: Add userguide for PCI endpoint test function
      MAINTAINERS: add PCI EP maintainer
      ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP

 Documentation/PCI/00-INDEX                                |  10 +++
 Documentation/PCI/endpoint/function/binding/pci-test.txt  |  17 +++++
 Documentation/PCI/endpoint/pci-endpoint-cfs.txt           | 105 ++++++++++++++++++++++++++
 Documentation/PCI/endpoint/pci-endpoint.txt               | 215 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/PCI/endpoint/pci-test-function.txt          |  66 ++++++++++++++++
 Documentation/PCI/endpoint/pci-test-howto.txt             | 179 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/syscon.txt          |   2 +
 Documentation/devicetree/bindings/pci/designware-pcie.txt |  26 +++++--
 Documentation/devicetree/bindings/pci/ti-pci.txt          |  42 +++++++++--
 Documentation/misc-devices/pci-endpoint-test.txt          |  35 +++++++++
 MAINTAINERS                                               |   9 +++
 arch/arm/mach-omap2/clockdomains7xx_data.c                |   2 +-
 drivers/Makefile                                          |   2 +
 drivers/misc/Kconfig                                      |   7 ++
 drivers/misc/Makefile                                     |   1 +
 drivers/misc/pci_endpoint_test.c                          | 534 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/Kconfig                                       |   1 +
 drivers/pci/dwc/Kconfig                                   |  36 ++++++++-
 drivers/pci/dwc/Makefile                                  |   5 +-
 drivers/pci/dwc/pci-dra7xx.c                              | 268 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/pci/dwc/pcie-designware-ep.c                      | 342 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/dwc/pcie-designware.c                         | 125 ++++++++++++++++++++++++++++++
 drivers/pci/dwc/pcie-designware.h                         | 112 +++++++++++++++++++++++++++
 drivers/pci/endpoint/Kconfig                              |  31 ++++++++
 drivers/pci/endpoint/Makefile                             |   7 ++
 drivers/pci/endpoint/functions/Kconfig                    |  12 +++
 drivers/pci/endpoint/functions/Makefile                   |   5 ++
 drivers/pci/endpoint/functions/pci-epf-test.c             | 510 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-cfs.c                         | 509 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c                       | 579 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-epc-mem.c                        | 143 +++++++++++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c                       | 351 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h                           |  10 +++
 include/linux/pci-ep-cfs.h                                |  41 ++++++++++
 include/linux/pci-epc.h                                   | 144 +++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h                                   | 162 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h                                   |   2 +
 include/uapi/linux/Kbuild                                 |   1 +
 include/uapi/linux/pcitest.h                              |  19 +++++
 tools/pci/pcitest.c                                       | 186 +++++++++++++++++++++++++++++++++++++++++++++
 tools/pci/pcitest.sh                                      |  56 ++++++++++++++
 41 files changed, 4869 insertions(+), 40 deletions(-)
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
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
