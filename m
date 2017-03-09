Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <hch@infradead.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v3 21/23] Documentation: PCI: Add userguide for PCI endpoint test function
Date: Thu, 9 Mar 2017 13:27:32 +0530
Message-ID: <1489046254-19919-22-git-send-email-kishon@ti.com>
In-Reply-To: <1489046254-19919-1-git-send-email-kishon@ti.com>
References: <1489046254-19919-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add documentation to help users use pci-epf-test function driver
and pci_endpoint_test host driver for testing PCI.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/PCI/00-INDEX                    |    2 +
 Documentation/PCI/endpoint/pci-test-howto.txt |  179 +++++++++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-test-howto.txt

diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index 53717b7..fd533c7 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -18,5 +18,7 @@ endpoint/pci-endpoint-cfs.txt
 	- guide to use configfs to configure the pci endpoint function.
 endpoint/pci-test-function.txt
 	- specification of *pci test* function device.
+endpoint/pci-test-howto.txt
+	- userguide for PCI endpoint test function.
 endpoint/function/binding/
 	- binding documentation for pci endpoint function
diff --git a/Documentation/PCI/endpoint/pci-test-howto.txt b/Documentation/PCI/endpoint/pci-test-howto.txt
new file mode 100644
index 0000000..730b70c
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-test-howto.txt
@@ -0,0 +1,179 @@
+			    PCI TEST USERGUIDE
+		    Kishon Vijay Abraham I <kishon@ti.com>
+
+This document is a guide to help users use pci-epf-test function driver
+and pci_endpoint_test host driver for testing PCI. The list of steps to
+be followed in the host side and EP side is given below.
+
+1. Endpoint Device
+
+1.1 Endpoint Controller Devices
+
+To find the list of endpoint controller devices in the system:
+
+	# ls /sys/class/pci_epc/
+	  51000000.pcie_ep
+
+If PCI_ENDPOINT_CONFIGFS is enabled
+	# ls /sys/kernel/config/pci_ep/controllers
+	  51000000.pcie_ep
+
+1.2 Endpoint Function Drivers
+
+To find the list of endpoint function drivers in the system:
+
+	# ls /sys/bus/pci-epf/drivers
+	  pci_epf_test
+
+If PCI_ENDPOINT_CONFIGFS is enabled
+	# ls /sys/kernel/config/pci_ep/functions
+	  pci_epf_test
+
+1.3 Creating pci-epf-test Device
+
+PCI endpoint function device can be created using the configfs. To create
+pci-epf-test device, the following commands can be used
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/pci_ep/
+	# mkdir functions/pci_epf_test/func1
+
+The "mkdir func1" above creates the pci-epf-test function device that will
+be probed by pci_epf_test driver.
+
+The PCI endpoint framework populates the directory with the following
+configurable fields.
+
+	# ls functions/pci_epf_test/func1
+	  baseclass_code	interrupt_pin	revid		subsys_vendor_id
+	  cache_line_size	msi_interrupts	subclass_code	vendorid
+	  deviceid          	progif_code	subsys_id
+
+The pci endpoint function driver populates these entries with default values
+when the device is bound to the driver. The pci-epf-test driver populates
+vendorid with 0xffff and interrupt_pin with 0x0001
+
+	# cat functions/pci_epf_test/func1/vendorid
+	  0xffff
+	# cat functions/pci_epf_test/func1/interrupt_pin
+	  0x0001
+
+1.4 Configuring pci-epf-test Device
+
+The user can configure the pci-epf-test device using configfs entry. In order
+to change the vendorid and the number of MSI interrupts used by the function
+device, the following commands can be used.
+
+	# echo 0x104c > functions/pci_epf_test/func1/vendorid
+	# echo 0xb500 > functions/pci_epf_test/func1/deviceid
+	# echo 16 > functions/pci_epf_test/func1/msi_interrupts
+
+1.5 Binding pci-epf-test Device to EP Controller
+
+In order for the endpoint function device to be useful, it has to be bound to
+a PCI endpoint controller driver. Use the configfs to bind the function
+device to one of the controller driver present in the system.
+
+	# ln -s functions/pci_epf_test/func1 controllers/51000000.pcie_ep/
+
+Once the above step is completed, the PCI endpoint is ready to establish a link
+with the host.
+
+1.6 Start the Link
+
+In order for the endpoint device to establish a link with the host, the _start_
+field should be populated with '1'.
+
+	# echo 1 > controllers/51000000.pcie_ep/start
+
+2. RootComplex Device
+
+2.1 lspci Output
+
+Note that the devices listed here correspond to the value populated in 1.4 above
+
+	00:00.0 PCI bridge: Texas Instruments Device 8888 (rev 01)
+	01:00.0 Unassigned class [ff00]: Texas Instruments Device b500
+
+2.2 Using Endpoint Test function Device
+
+pcitest.sh added in tools/pci/ can be used to run all the default PCI endpoint
+tests. Before pcitest.sh can be used pcitest.c should be compiled using the
+following commands.
+
+	cd <kernel-dir>
+	make headers_install ARCH=arm
+	arm-linux-gnueabihf-gcc -Iusr/include tools/pci/pcitest.c -o pcitest
+	cp pcitest  <rootfs>/usr/sbin/
+	cp tools/pci/pcitest.sh <rootfs>
+
+2.2.1 pcitest.sh Output
+	# ./pcitest.sh
+	BAR tests
+
+	BAR0:           OKAY
+	BAR1:           OKAY
+	BAR2:           OKAY
+	BAR3:           OKAY
+	BAR4:           NOT OKAY
+	BAR5:           NOT OKAY
+
+	Interrupt tests
+
+	LEGACY IRQ:     NOT OKAY
+	MSI1:           OKAY
+	MSI2:           OKAY
+	MSI3:           OKAY
+	MSI4:           OKAY
+	MSI5:           OKAY
+	MSI6:           OKAY
+	MSI7:           OKAY
+	MSI8:           OKAY
+	MSI9:           OKAY
+	MSI10:          OKAY
+	MSI11:          OKAY
+	MSI12:          OKAY
+	MSI13:          OKAY
+	MSI14:          OKAY
+	MSI15:          OKAY
+	MSI16:          OKAY
+	MSI17:          NOT OKAY
+	MSI18:          NOT OKAY
+	MSI19:          NOT OKAY
+	MSI20:          NOT OKAY
+	MSI21:          NOT OKAY
+	MSI22:          NOT OKAY
+	MSI23:          NOT OKAY
+	MSI24:          NOT OKAY
+	MSI25:          NOT OKAY
+	MSI26:          NOT OKAY
+	MSI27:          NOT OKAY
+	MSI28:          NOT OKAY
+	MSI29:          NOT OKAY
+	MSI30:          NOT OKAY
+	MSI31:          NOT OKAY
+	MSI32:          NOT OKAY
+
+	Read Tests
+
+	READ (      1 bytes):           OKAY
+	READ (   1024 bytes):           OKAY
+	READ (   1025 bytes):           OKAY
+	READ (1024000 bytes):           OKAY
+	READ (1024001 bytes):           OKAY
+
+	Write Tests
+
+	WRITE (      1 bytes):          OKAY
+	WRITE (   1024 bytes):          OKAY
+	WRITE (   1025 bytes):          OKAY
+	WRITE (1024000 bytes):          OKAY
+	WRITE (1024001 bytes):          OKAY
+
+	Copy Tests
+
+	COPY (      1 bytes):           OKAY
+	COPY (   1024 bytes):           OKAY
+	COPY (   1025 bytes):           OKAY
+	COPY (1024000 bytes):           OKAY
+	COPY (1024001 bytes):           OKAY
-- 
1.7.9.5
