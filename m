Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:60098 "EHLO bear.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755240AbcIMRMJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 13:12:09 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>, <hch@infradead.org>,
        <Joao.Pinto@synopsys.com>, <mingkai.hu@nxp.com>,
        <m-karicheri2@ti.com>, Pratyush Anand <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, <kishon@ti.com>,
        <nsekhar@ti.com>
Subject: [RFC PATCH] pci: support for configurable PCI endpoint
Date: Tue, 13 Sep 2016 22:40:42 +0530
Message-ID: <1473786653-12759-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series
	*) adds PCI endpoint core layer
	*) modifies designware/dra7xx driver to be configured in EP mode
	*) adds a PCI endpoint *test* function driver

Known Limitation:
	*) Does not support multi-function devices

TODO:
	*) access buffers in RC
	*) MSI interrupts
	*) Enable user space control for the RC side PCI driver
	*) Adapt all other users of designware to use the new design

HOW TO:

ON THE EP SIDE:
***************

/* EP function is configured using configfs */
# mount -t configfs none /sys/kernel/config

/* PCI EP core layer creates "pci_ep" entry in configfs */
# cd /sys/kernel/config/pci_ep/

/*
 * This is the 1st step in creating an endpoint function. This
 * creates the endpoint function device *instance*. The string
 * before the .<num> suffix will identify the driver this
 * EP function will bind to.
 * Just pci_epf_test is also valid. The .<num> suffix is used
 * if there are multiple PCI controllers and all of them wants
 * to use the same function.
 */
# mkdir pci_epf_test.0

/*
 * When the above command is given, the function device will
 * also be bound to a function driver. To find the list of
 * function drivers available in the system, use the following
 * command. To create a new driver, the following can be referred
 * drivers/pci/endpoint/functions/pci-epf-test.c
 */
# ls /sys/bus/pci-epf/drivers
pci_epf_test

/* Now configure the endpoint function */
# cd pci_epf_test.0

/* These are the fields that can be configured */
# ls
baseclass_code    function          revid             vendorid
cache_line_size   interrupt_pin     subclass_code
deviceid          peripheral        subsys_id
epc               progif_code       subsys_vendor_id

/* The function driver will populate these fields with default values */
# cat vendorid 
0xffff

# cat interrupt_pin 
0x0001

/* The user can configure any of these fields */
# echo 0x104c > vendorid

/*
 * Next is binding this function driver to the controller driver. In
 * order to find the possible controller drivers that this function
 * driver can be bound to, the following sysfs entry can be used
 */
# ls /sys/class/pci_epc/
51000000.pci

/* Now bind the function driver to the controller driver */
# echo "51000000.pcie" > epc
[  494.743487] dra7-pcie 51000000.pcie: no free inbound window
[  494.749367] pci_epf_test pci_epf_test.0: failed to set BAR4
[  494.755238] dra7-pcie 51000000.pcie: no free inbound window
[  494.761451] pci_epf_test pci_epf_test.0: failed to set BAR5

/*
 * the above error messages are due to non availability of free
 * inbound windows. So the function drivers in dra7xx can use
 * only 4 (BAR0..BAR3) BARs
 */

/****** PCI endpoint is configured ******/

ON THE HOST SIDE:
*****************
# modprobe pci_endpoint_test
[    8.197560] ****** Testing pci-endpoint-test Device ******
[    9.056990] Reset: OKAY
[    9.059753] BAR1 OKAY
[    9.062419] BAR2 OKAY
[    9.069506] BAR3 OKAY
[    9.071880] BAR4 NOT OKAY
[    9.074618] BAR5 NOT OKAY
[    9.379257] Legacy IRQ: OKAY
[    9.382281] ****** End Test ******

/*
 * Rightnow these tests gets executed as soon as the pci_endpoint_test
 * module gets inserted. These will be modified so that user/user script
 * can control this. Once the functionality for EP to access RC buffer
 * is added, more tests can be added including throughput measurement tests.
 */ 


Kishon Vijay Abraham I (11):
  pci: endpoint: add EP core layer to enable EP controller and EP
    functions
  pci: endpoint: introduce configfs entry for configuring EP functions
  Documentation: PCI: guide to use PCI Endpoint Core Layer
  pci: endpoint: functions: add an EP function to test PCI
  pci: rename *host* directory to *controller*
  pci: controller: split designware into *core* and *host*
  pci: controller: designware: Add EP mode support
  pci: controller: dra7xx: Add EP mode support
  misc: add a new host side PCI endpoint test driver
  ARM: dts: DRA7: Modify pcie1 dt node for EP mode
  HACK: pci: controller: dra7xx: disable smart idle

 Documentation/PCI/00-INDEX                         |    5 +
 Documentation/PCI/pci-endpoint.txt                 |  199 ++++++++++
 Documentation/PCI/pci-test.txt                     |   79 ++++
 .../devicetree/bindings/pci/designware-pcie.txt    |   26 +-
 Documentation/devicetree/bindings/pci/ti-pci.txt   |   30 +-
 MAINTAINERS                                        |   50 +--
 arch/arm/boot/dts/dra7.dtsi                        |   43 +--
 drivers/Makefile                                   |    4 +
 drivers/misc/Kconfig                               |    7 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/pci_endpoint_test.c                   |  291 +++++++++++++++
 drivers/pci/Kconfig                                |    3 +-
 drivers/pci/Makefile                               |    3 -
 drivers/pci/{host => controller}/Kconfig           |  109 +++++-
 drivers/pci/{host => controller}/Makefile          |    2 +
 drivers/pci/{host => controller}/pci-aardvark.c    |    0
 drivers/pci/{host => controller}/pci-dra7xx.c      |  340 +++++++++++++----
 drivers/pci/{host => controller}/pci-exynos.c      |    0
 drivers/pci/{host => controller}/pci-host-common.c |    0
 .../pci/{host => controller}/pci-host-generic.c    |    0
 drivers/pci/{host => controller}/pci-hyperv.c      |    0
 drivers/pci/{host => controller}/pci-imx6.c        |    0
 drivers/pci/{host => controller}/pci-keystone-dw.c |    0
 drivers/pci/{host => controller}/pci-keystone.c    |    0
 drivers/pci/{host => controller}/pci-keystone.h    |    0
 drivers/pci/{host => controller}/pci-layerscape.c  |    0
 drivers/pci/{host => controller}/pci-mvebu.c       |    0
 drivers/pci/{host => controller}/pci-rcar-gen2.c   |    0
 drivers/pci/{host => controller}/pci-tegra.c       |    0
 .../pci/{host => controller}/pci-thunder-ecam.c    |    0
 drivers/pci/{host => controller}/pci-thunder-pem.c |    0
 drivers/pci/{host => controller}/pci-versatile.c   |    0
 drivers/pci/{host => controller}/pci-xgene-msi.c   |    0
 drivers/pci/{host => controller}/pci-xgene.c       |    0
 drivers/pci/{host => controller}/pcie-altera-msi.c |    0
 drivers/pci/{host => controller}/pcie-altera.c     |    0
 drivers/pci/{host => controller}/pcie-armada8k.c   |    0
 drivers/pci/{host => controller}/pcie-artpec6.c    |    0
 drivers/pci/controller/pcie-designware-ep.c        |  228 ++++++++++++
 .../pcie-designware-host.c}                        |  294 +++------------
 .../{host => controller}/pcie-designware-plat.c    |    0
 drivers/pci/controller/pcie-designware.c           |  233 ++++++++++++
 drivers/pci/controller/pcie-designware.h           |  238 ++++++++++++
 drivers/pci/{host => controller}/pcie-hisi.c       |    0
 drivers/pci/{host => controller}/pcie-iproc-bcma.c |    0
 drivers/pci/{host => controller}/pcie-iproc-msi.c  |    0
 .../pci/{host => controller}/pcie-iproc-platform.c |    0
 drivers/pci/{host => controller}/pcie-iproc.c      |    0
 drivers/pci/{host => controller}/pcie-iproc.h      |    0
 drivers/pci/{host => controller}/pcie-qcom.c       |    0
 drivers/pci/{host => controller}/pcie-rcar.c       |    0
 drivers/pci/{host => controller}/pcie-spear13xx.c  |    0
 drivers/pci/{host => controller}/pcie-xilinx-nwl.c |    0
 drivers/pci/{host => controller}/pcie-xilinx.c     |    0
 drivers/pci/endpoint/Kconfig                       |   25 ++
 drivers/pci/endpoint/Makefile                      |    6 +
 drivers/pci/endpoint/functions/Kconfig             |   12 +
 drivers/pci/endpoint/functions/Makefile            |    5 +
 drivers/pci/endpoint/functions/pci-epf-test.c      |  272 ++++++++++++++
 drivers/pci/endpoint/pci-ep-cfs.c                  |  275 ++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c                |  389 ++++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c                |  338 +++++++++++++++++
 drivers/pci/host/pcie-designware.h                 |   89 -----
 include/linux/mod_devicetable.h                    |   10 +
 include/linux/pci-epc.h                            |  100 +++++
 include/linux/pci-epf.h                            |  159 ++++++++
 66 files changed, 3373 insertions(+), 492 deletions(-)
 create mode 100644 Documentation/PCI/pci-endpoint.txt
 create mode 100644 Documentation/PCI/pci-test.txt
 create mode 100644 drivers/misc/pci_endpoint_test.c
 rename drivers/pci/{host => controller}/Kconfig (79%)
 rename drivers/pci/{host => controller}/Makefile (93%)
 rename drivers/pci/{host => controller}/pci-aardvark.c (100%)
 rename drivers/pci/{host => controller}/pci-dra7xx.c (62%)
 rename drivers/pci/{host => controller}/pci-exynos.c (100%)
 rename drivers/pci/{host => controller}/pci-host-common.c (100%)
 rename drivers/pci/{host => controller}/pci-host-generic.c (100%)
 rename drivers/pci/{host => controller}/pci-hyperv.c (100%)
 rename drivers/pci/{host => controller}/pci-imx6.c (100%)
 rename drivers/pci/{host => controller}/pci-keystone-dw.c (100%)
 rename drivers/pci/{host => controller}/pci-keystone.c (100%)
 rename drivers/pci/{host => controller}/pci-keystone.h (100%)
 rename drivers/pci/{host => controller}/pci-layerscape.c (100%)
 rename drivers/pci/{host => controller}/pci-mvebu.c (100%)
 rename drivers/pci/{host => controller}/pci-rcar-gen2.c (100%)
 rename drivers/pci/{host => controller}/pci-tegra.c (100%)
 rename drivers/pci/{host => controller}/pci-thunder-ecam.c (100%)
 rename drivers/pci/{host => controller}/pci-thunder-pem.c (100%)
 rename drivers/pci/{host => controller}/pci-versatile.c (100%)
 rename drivers/pci/{host => controller}/pci-xgene-msi.c (100%)
 rename drivers/pci/{host => controller}/pci-xgene.c (100%)
 rename drivers/pci/{host => controller}/pcie-altera-msi.c (100%)
 rename drivers/pci/{host => controller}/pcie-altera.c (100%)
 rename drivers/pci/{host => controller}/pcie-armada8k.c (100%)
 rename drivers/pci/{host => controller}/pcie-artpec6.c (100%)
 create mode 100644 drivers/pci/controller/pcie-designware-ep.c
 rename drivers/pci/{host/pcie-designware.c => controller/pcie-designware-host.c} (64%)
 rename drivers/pci/{host => controller}/pcie-designware-plat.c (100%)
 create mode 100644 drivers/pci/controller/pcie-designware.c
 create mode 100644 drivers/pci/controller/pcie-designware.h
 rename drivers/pci/{host => controller}/pcie-hisi.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-bcma.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-msi.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-platform.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc.h (100%)
 rename drivers/pci/{host => controller}/pcie-qcom.c (100%)
 rename drivers/pci/{host => controller}/pcie-rcar.c (100%)
 rename drivers/pci/{host => controller}/pcie-spear13xx.c (100%)
 rename drivers/pci/{host => controller}/pcie-xilinx-nwl.c (100%)
 rename drivers/pci/{host => controller}/pcie-xilinx.c (100%)
 create mode 100644 drivers/pci/endpoint/Kconfig
 create mode 100644 drivers/pci/endpoint/Makefile
 create mode 100644 drivers/pci/endpoint/functions/Kconfig
 create mode 100644 drivers/pci/endpoint/functions/Makefile
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-test.c
 create mode 100644 drivers/pci/endpoint/pci-ep-cfs.c
 create mode 100644 drivers/pci/endpoint/pci-epc-core.c
 create mode 100644 drivers/pci/endpoint/pci-epf-core.c
 delete mode 100644 drivers/pci/host/pcie-designware.h
 create mode 100644 include/linux/pci-epc.h
 create mode 100644 include/linux/pci-epf.h

-- 
1.7.9.5

