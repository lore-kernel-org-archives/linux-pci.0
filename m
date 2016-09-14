Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57340 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756759AbcINFNh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 01:13:37 -0400
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
Subject: [RFC PATCH 03/11] Documentation: PCI: guide to use PCI Endpoint Core Layer
Date: Wed, 14 Sep 2016 10:41:59 +0530
Message-ID: <1473829927-20466-4-git-send-email-kishon@ti.com>
In-Reply-To: <1473829927-20466-1-git-send-email-kishon@ti.com>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add Documentation to let users enable endpoint mode in the PCI
controller and add new PCI endpoint function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/PCI/00-INDEX         |    2 +
 Documentation/PCI/pci-endpoint.txt |  199 ++++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 Documentation/PCI/pci-endpoint.txt

diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index 147231f..e422b8151 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -12,3 +12,5 @@ pci.txt
 	- info on the PCI subsystem for device driver authors
 pcieaer-howto.txt
 	- the PCI Express Advanced Error Reporting Driver Guide HOWTO
+pci-endpoint.txt
+	- guide to add endpoint controller driver and endpoint function driver.
diff --git a/Documentation/PCI/pci-endpoint.txt b/Documentation/PCI/pci-endpoint.txt
new file mode 100644
index 0000000..a453aaa
--- /dev/null
+++ b/Documentation/PCI/pci-endpoint.txt
@@ -0,0 +1,199 @@
+			    PCI ENDPOINT FRAMEWORK
+		    Kishon Vijay Abraham I <kishon@ti.com>
+
+This document is a guide to use the PCI Endpoint Framework in order to create
+endpoint controller driver, endpoint function driver and using configfs
+interface to bind the function driver to the controller driver.
+
+1. Introduction
+
+*Linux* has a comprehensive PCI subsystem to support PCI controllers that
+operates in Root Complex mode. The subsystem has capability to scan PCI bus,
+assign memory resources and irq resources, load PCI driver (based on
+vendorid, deviceid), support other services like hot-plug, power management,
+advanced error reporting and virtual channels.
+
+However PCI controller IPs integrated in certain SoC is capable of operating
+either in Root Complex mode or Endpoint mode. PCI Endpoint Framework will
+add endpoint mode support in *Linux*. This will help to run Linux in an
+EP system which can have a wide variety of use cases from testing or
+validation, co-processor accelerator etc..
+
+2. PCI Endpoint Core
+
+The PCI Endpoint Core layer comprises of 3 components: the Endpoint Controller
+library, the Endpoint Function library and the configfs layer to bind the
+endpoint function with the endpoint controller.
+
+2.1 PCI Endpoint Controller(EPC) Library
+
+The EPC library provides APIs to be used by the controller that can operate
+in endpoint mode. It also provides APIs to be used by function driver/library
+in order to implement a particular endpoint function.
+
+2.1.1 APIs for the PCI controller Driver
+
+This section lists the APIs that the PCI Endpoint core provides to be used
+by the PCI controller driver.
+
+*) devm_pci_epc_create()/pci_epc_create()
+
+   The PCI controller driver should implement the following ops:
+	 * write_header: ops to populate configuration space header
+	 * set_bar: ops to configure the BAR
+	 * clear_bar: ops to reset the BAR
+	 * alloc_addr_space: ops to allocate *in* PCI controller address space
+	 * free_addr_space: ops to free the allocated address space
+	 * raise_irq: ops to raise a legacy or MSI interrupt
+	 * start: ops to start the PCI link
+	 * stop: ops to stop the PCI link
+
+   The PCI controller driver can then create a new EPC device by invoking
+   devm_pci_epc_create/pci_epc_create.
+
+*) devm_pci_epc_destroy()/pci_epc_destroy()
+
+   The PCI controller driver can destroy the EPC device created by either
+   devm_pci_epc_create or pci_epc_create using devm_pci_epc_destroy() or
+   /pci_epc_destroy()
+
+2.1.2 APIs for the PCI Endpoint Function Driver
+
+This section lists the APIs that the PCI Endpoint core provides to be used
+by the PCI endpoint function driver.
+
+*) pci_epc_write_header()
+
+   The PCI endpoint function driver should use pci_epc_write_header() to
+   write the standard configuration header to the endpoint controller.
+
+*) pci_epc_set_bar()
+
+   The PCI endpoint function driver should use pci_epc_set_bar() to configure
+   the Base Address Register in order for the host to assign PCI addr space.
+   Register space of the function driver is usually configured
+   using this API.
+
+*) pci_epc_clear_bar()
+
+   The PCI endpoint function driver should use pci_epc_clear_bar() to reset
+   the BAR.
+
+*) pci_epc_raise_irq()
+
+   The PCI endpoint function driver should use pci_epc_raise_irq() to raise
+   Legacy Interrupt or MSI Interrupt.
+
+*) pci_epc_start()
+
+   The PCI endpoint function driver should invoke pci_epc_start() once it
+   has configured the endpoint function and wants to start the PCI link.
+
+*) pci_epc_stop()
+
+   The PCI endpoint function driver should invoke pci_epc_stop() to stop
+   the PCI LINK.
+
+2.1.3 APIs for the PCI Endpoint Function Library
+
+This section lists the APIs that the PCI Endpoint core provides to be used
+by the PCI endpoint function library.
+
+*) pci_epc_bind_epf()
+
+   The PCI endpoint function library uses pci_epc_bind_epf() to bind the
+   function driver with a controller driver. The binding will be based on
+   the endpoint controller function name (as seen in /sys/class/pci_epc/).
+
+*) pci_epc_unbind_epf()
+
+   The PCI endpoint function library uses pci_epc_unbind_epf() to unbind
+   the function driver from the controller driver. After unbind the controller
+   driver can be bound to any other function driver.
+
+2.2 PCI Endpoint Function(EPF) Library
+
+The EPF library provides APIs to be used by the function driver and the EPC
+library in order to provide endpoint mode functionality.
+
+2.2.1 APIs for the PCI Endpoint Function Driver
+
+This section lists the APIs that the PCI Endpoint core provides to be used
+by the PCI endpoint function driver.
+
+*) pci_epf_register_driver()
+
+   The PCI Endpoint Function driver should implement the following ops:
+	 * bind: ops to perform when a EPC device has been bound to EPF device
+	 * unbind: ops to perform when a binding has been lost between a EPC
+	   device and EPF device
+	 * linkup: ops to perform when the EPC device has established a
+	   connection with a host system
+
+  The PCI Function driver can then register the PCI EPF driver by using
+  pci_epf_register_driver().
+
+*) pci_epf_unregister_driver()
+
+  The PCI Function driver can unregister the PCI EPF driver by using
+  pci_epf_unregister_driver().
+
+*) pci_epf_alloc_space()
+
+  The PCI Function driver can allocate space for a particular BAR using
+  pci_epf_alloc_space().
+
+*) pci_epf_free_space()
+
+  The PCI Function driver can free the allocated space
+  (using pci_epf_alloc_space) by invoking pci_epf_free_space().
+
+2.2.2 APIs for the PCI Endpoint Controller Library
+
+This section lists the APIs that the PCI Endpoint core provides to be used
+by the PCI endpoint controller library.
+
+*) pci_epf_bind()
+
+   The PCI endpoint controller library invokes pci_epf_bind() when the EPF
+   device has been bound to a EPC device.
+
+*) pci_epf_unbind()
+
+   The PCI endpoint controller library invokes pci_epf_unbind() when the
+   binding between EPC device and EPF device is lost.
+
+*) pci_epf_linkup()
+
+   The PCI endpoint controller library invokes pci_epf_linkup() when the
+   EPC device has established the connection to the host.
+
+2.3 CONFIGFS
+
+The PCI Endpoint Core exposes configfs entry (pci_ep) in order to configure the
+PCI Endpoint Function and in order to bind the endpoint function
+with the endpoint controller. Every folder in pci_ep/ represent a PCI
+endpoint function.
+
+The following entries can be used to configure the standard configuration
+header of the endpoint function.
+	vendorid
+	deviceid
+	revid
+	progif_code
+	subclass_code
+	baseclass_code
+	cache_line_size
+	subsys_vendor_id
+	subsys_id
+	interrupt_pin
+
+The following entries has special meaning:
+	function: this readonly entry shows the name using which the function
+		  driver will be bound to this function
+	epc	: the name of the EPC device this function should be bound to.
+		  The name of the EPC device should be from /sys/class/pci_epc.
+
+3. Known Limitations
+
+The Endpoint Core doesn't support adding multi-function devices.
-- 
1.7.9.5

