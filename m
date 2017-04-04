Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 4 Apr 2017 15:36:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL] PCI: Support for configurable PCI endpoint
Message-ID: <20170404203606.GE27692@bhelgaas-glaptop.roam.corp.google.com>
References: <20170327094520.3129-1-kishon@ti.com>
MIME-Version: 1.0
In-Reply-To: <20170327094520.3129-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, hch@infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 27, 2017 at 03:14:56PM +0530, Kishon Vijay Abraham I wrote:
> Hi Bjorn,
> 
> Please find the pull request for PCI endpoint support below. I've
> also included all the history here.

I tentatively applied this to pci/host-designware with the mostly trival
textual changes below.  If you post the series again, please include them.

I saw some acks to prior revisions, but few of them were included in this
series.   Can you collect them up?  If there are no other substantial
changes, I can insert them into my branch manually.

Bjorn



diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index fd533c79fa19..00c9a90b6f38 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -15,10 +15,10 @@ pcieaer-howto.txt
 endpoint/pci-endpoint.txt
 	- guide to add endpoint controller driver and endpoint function driver.
 endpoint/pci-endpoint-cfs.txt
-	- guide to use configfs to configure the pci endpoint function.
+	- guide to use configfs to configure the PCI endpoint function.
 endpoint/pci-test-function.txt
-	- specification of *pci test* function device.
+	- specification of *PCI test* function device.
 endpoint/pci-test-howto.txt
 	- userguide for PCI endpoint test function.
 endpoint/function/binding/
-	- binding documentation for pci endpoint function
+	- binding documentation for PCI endpoint function
diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.txt b/Documentation/PCI/endpoint/function/binding/pci-test.txt
index c44fc18d78cc..3b68b955fb50 100644
--- a/Documentation/PCI/endpoint/function/binding/pci-test.txt
+++ b/Documentation/PCI/endpoint/function/binding/pci-test.txt
@@ -13,5 +13,5 @@ cache_line_size	 : don't care
 subsys_vendor_id : don't care
 subsys_id	 : don't care
 interrupt_pin	 : Should be 1 - INTA, 2 - INTB, 3 - INTC, 4 -INTD
-msi_interrupts	 : Should be 1 to 32 depending on the number of msi interrupts
+msi_interrupts	 : Should be 1 to 32 depending on the number of MSI interrupts
 		   to test
diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt b/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
index 8b2a8280b131..d740f29960a4 100644
--- a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
+++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
@@ -1,10 +1,10 @@
                    CONFIGURING PCI ENDPOINT USING CONFIGFS
                     Kishon Vijay Abraham I <kishon@ti.com>
 
-The PCI Endpoint Core exposes configfs entry (pci_ep) in order to configure the
-PCI endpoint function and in order to bind the endpoint function
+The PCI Endpoint Core exposes configfs entry (pci_ep) to configure the
+PCI endpoint function and to bind the endpoint function
 with the endpoint controller. (For introducing other mechanisms to
-configure the PCI Endpoint Function refer [1]).
+configure the PCI Endpoint Function refer to [1]).
 
 *) Mounting configfs
 
diff --git a/Documentation/PCI/endpoint/pci-endpoint.txt b/Documentation/PCI/endpoint/pci-endpoint.txt
index 4a3e4388b37b..9b1d66829290 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.txt
+++ b/Documentation/PCI/endpoint/pci-endpoint.txt
@@ -2,27 +2,27 @@
 		    Kishon Vijay Abraham I <kishon@ti.com>
 
 This document is a guide to use the PCI Endpoint Framework in order to create
-endpoint controller driver, endpoint function driver and using configfs
+endpoint controller driver, endpoint function driver, and using configfs
 interface to bind the function driver to the controller driver.
 
 1. Introduction
 
-*Linux* has a comprehensive PCI subsystem to support PCI controllers that
+Linux has a comprehensive PCI subsystem to support PCI controllers that
 operates in Root Complex mode. The subsystem has capability to scan PCI bus,
-assign memory resources and irq resources, load PCI driver (based on
-vendorid, deviceid), support other services like hot-plug, power management,
+assign memory resources and IRQ resources, load PCI driver (based on
+vendor ID, device ID), support other services like hot-plug, power management,
 advanced error reporting and virtual channels.
 
-However PCI controller IPs integrated in certain SoC is capable of operating
+However the PCI controller IP integrated in some SoCs is capable of operating
 either in Root Complex mode or Endpoint mode. PCI Endpoint Framework will
-add endpoint mode support in *Linux*. This will help to run Linux in an
+add endpoint mode support in Linux. This will help to run Linux in an
 EP system which can have a wide variety of use cases from testing or
-validation, co-processor accelerator etc..
+validation, co-processor accelerator, etc.
 
 2. PCI Endpoint Core
 
-The PCI Endpoint Core layer comprises of 3 components: the Endpoint Controller
-library, the Endpoint Function library and the configfs layer to bind the
+The PCI Endpoint Core layer comprises 3 components: the Endpoint Controller
+library, the Endpoint Function library, and the configfs layer to bind the
 endpoint function with the endpoint controller.
 
 2.1 PCI Endpoint Controller(EPC) Library
@@ -42,20 +42,20 @@ by the PCI controller driver.
 	 * write_header: ops to populate configuration space header
 	 * set_bar: ops to configure the BAR
 	 * clear_bar: ops to reset the BAR
-	 * alloc_addr_space: ops to allocate *in* PCI controller address space
+	 * alloc_addr_space: ops to allocate in PCI controller address space
 	 * free_addr_space: ops to free the allocated address space
 	 * raise_irq: ops to raise a legacy or MSI interrupt
 	 * start: ops to start the PCI link
 	 * stop: ops to stop the PCI link
 
    The PCI controller driver can then create a new EPC device by invoking
-   devm_pci_epc_create/pci_epc_create.
+   devm_pci_epc_create()/pci_epc_create().
 
 *) devm_pci_epc_destroy()/pci_epc_destroy()
 
    The PCI controller driver can destroy the EPC device created by either
-   devm_pci_epc_create or pci_epc_create using devm_pci_epc_destroy() or
-   /pci_epc_destroy()
+   devm_pci_epc_create() or pci_epc_create() using devm_pci_epc_destroy() or
+   pci_epc_destroy().
 
 *) pci_epc_linkup()
 
@@ -112,27 +112,27 @@ by the PCI endpoint function driver.
 2.1.3 Other APIs
 
 There are other APIs provided by the EPC library. These are used for binding
-the epf device with epc device. pci-ep-cfs.c can be used as reference for
+the EPF device with EPC device. pci-ep-cfs.c can be used as reference for
 using these APIs.
 
 *) pci_epc_get()
 
-   Get a reference to the pci endpoint controller based on the device name of
+   Get a reference to the PCI endpoint controller based on the device name of
    the controller.
 
 *) pci_epc_put()
 
-   Release the reference to the pci endpoint controller obtained using
+   Release the reference to the PCI endpoint controller obtained using
    pci_epc_get()
 
 *) pci_epc_add_epf()
 
-   Add a pci endpoint function to a pci endpoint controller. A pcie device
-   can have upto 8 functions according to the specification.
+   Add a PCI endpoint function to a PCI endpoint controller. A PCIe device
+   can have up to 8 functions according to the specification.
 
 *) pci_epc_remove_epf()
 
-   Remove the pci endpoint function from pci endpoint controller.
+   Remove the PCI endpoint function from PCI endpoint controller.
 
 *) pci_epc_start()
 
@@ -147,7 +147,7 @@ using these APIs.
 2.2 PCI Endpoint Function(EPF) Library
 
 The EPF library provides APIs to be used by the function driver and the EPC
-library in order to provide endpoint mode functionality.
+library to provide endpoint mode functionality.
 
 2.2.1 APIs for the PCI Endpoint Function Driver
 
diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.txt
index 1324376ec6a3..0c519c9bf94a 100644
--- a/Documentation/PCI/endpoint/pci-test-function.txt
+++ b/Documentation/PCI/endpoint/pci-test-function.txt
@@ -32,8 +32,8 @@ This register will be used by the host driver to indicate the function
 that the endpoint device must perform.
 
 Bitfield Description:
-  Bit 0		: raise legacy irq
-  Bit 1		: raise MSI irq
+  Bit 0		: raise legacy IRQ
+  Bit 1		: raise MSI IRQ
   Bit 2 - 7	: MSI interrupt number
   Bit 8		: read command (read data from RC buffer)
   Bit 9		: write command (write data to RC buffer)
@@ -51,7 +51,7 @@ Bitfield Description:
   Bit 3		: write fail
   Bit 4		: copy success
   Bit 5		: copy fail
-  Bit 6		: irq raised
+  Bit 6		: IRQ raised
   Bit 7		: source address is invalid
   Bit 8		: destination address is invalid
 
diff --git a/Documentation/PCI/endpoint/pci-test-howto.txt b/Documentation/PCI/endpoint/pci-test-howto.txt
index 730b70c73055..75f48c3bb191 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.txt
+++ b/Documentation/PCI/endpoint/pci-test-howto.txt
@@ -49,7 +49,7 @@ configurable fields.
 	  cache_line_size	msi_interrupts	subclass_code	vendorid
 	  deviceid          	progif_code	subsys_id
 
-The pci endpoint function driver populates these entries with default values
+The PCI endpoint function driver populates these entries with default values
 when the device is bound to the driver. The pci-epf-test driver populates
 vendorid with 0xffff and interrupt_pin with 0x0001
 
diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index b69dd7dbd29e..6a07c96227e0 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -14,7 +14,7 @@ HOST MODE
 =========
  - reg : Two register ranges as listed in the reg-names property
  - reg-names : The first entry must be "ti-conf" for the TI specific registers
-	       The second entry must be "rc-dbics" for the designware pcie
+	       The second entry must be "rc-dbics" for the DesignWare PCIe
 	       registers
 	       The third entry must be "config" for the PCIe configuration space
  - interrupts : Two interrupt entries must be specified. The first one is for
@@ -39,7 +39,7 @@ DEVICE MODE
  - interrupts : one interrupt entries must be specified for main interrupt.
  - num-ib-windows : number of inbound address translation windows
  - num-ob-windows : number of outbound address translation windows
- - ti,syscon-unaligned-access: phandle to the syscon dt node. The 1st argument
+ - ti,syscon-unaligned-access: phandle to the syscon DT node. The 1st argument
 			       should contain the register offset within syscon
 			       and the 2nd argument should contain the bit field
 			       for setting the bit to enable unaligned
@@ -48,10 +48,10 @@ DEVICE MODE
 Optional Property:
  - gpios : Should be added if a gpio line is required to drive PERST# line
 
-NOTE: Two dt nodes may be added for each PCI controller; one for host
+NOTE: Two DT nodes may be added for each PCI controller; one for host
 mode and another for device mode. So in order for PCI to
-work in host mode, EP mode dt node should be disabled and in order to PCI to
-work in EP mode, host mode dt node should be disabled. And host mode and EP
+work in host mode, EP mode DT node should be disabled and in order to PCI to
+work in EP mode, host mode DT node should be disabled. Host mode and EP
 mode are mutually exclusive.
 
 Example:
diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
index 438571898d27..4ebc3594b32c 100644
--- a/Documentation/misc-devices/pci-endpoint-test.txt
+++ b/Documentation/misc-devices/pci-endpoint-test.txt
@@ -1,7 +1,7 @@
 Driver for PCI Endpoint Test Function
 
 This driver should be used as a host side driver if the root complex is
-connected to a configurable pci endpoint running *pci_epf_test* function
+connected to a configurable PCI endpoint running *pci_epf_test* function
 driver configured according to [1].
 
 The "pci_endpoint_test" driver can be used to perform the following tests.
@@ -20,10 +20,10 @@ should be used to perform the above tests.
 
 ioctl
 -----
- PCITEST_BAR: Tests the BAR. The number of the BAR that has to be tested
+ PCITEST_BAR: Tests the BAR. The number of the BAR to be tested
 	      should be passed as argument.
  PCITEST_LEGACY_IRQ: Tests legacy IRQ
- PCITEST_MSI: Tests message signalled interrupts. The MSI number that has
+ PCITEST_MSI: Tests message signalled interrupts. The MSI number
 	      to be tested should be passed as argument.
  PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
 		as argument.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3c1b947811e2..15ed84389092 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9581,7 +9581,7 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
-PCI EP SUBSYSTEM
+PCI ENDPOINT SUBSYSTEM
 M:	Kishon Vijay Abraham I <kishon@ti.com>
 L:	linux-pci@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 5f4f8f8ff1c2..09c10f426b64 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -424,7 +424,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
 			       IRQF_SHARED, DRV_MODULE_NAME, test);
 	if (err) {
-		dev_err(dev, "failed to request irq\n");
+		dev_err(dev, "failed to request IRQ %d\n", pdev->irq);
 		goto err_disable_msi;
 	}
 
@@ -433,8 +433,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 				       pci_endpoint_test_irqhandler,
 				       IRQF_SHARED, DRV_MODULE_NAME, test);
 		if (err)
-			dev_err(dev, "failed to request irq for MSI %d\n",
-				i + 1);
+			dev_err(dev, "failed to request IRQ %d for MSI %d\n",
+				pdev->irq + i, i + 1);
 	}
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 345ad67dca3c..b7e15526d676 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -21,8 +21,8 @@ config PCI_DRA7XX
 	help
 	 Enables support for the PCIe controller in the DRA7xx SoC. There
 	 are two instances of PCIe controller in DRA7xx. This controller can
-	 work either as EP or RC. In order to enable host specific features
-	 PCI_DRA7XX_HOST must be selected and in order to enable device
+	 work either as EP or RC. In order to enable host-specific features
+	 PCI_DRA7XX_HOST must be selected and in order to enable device-
 	 specific features PCI_DRA7XX_EP must be selected. This uses
 	 the Designware core.
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 29cbe9a73b30..9ae9e59b2a74 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -43,7 +43,7 @@ static int devm_pci_epc_match(struct device *dev, void *res, void *match_data)
 }
 
 /**
- * pci_epc_put() - release the pci endpoint controller
+ * pci_epc_put() - release the PCI endpoint controller
  * @epc: epc returned by pci_epc_get()
  *
  * release the refcount the caller obtained by invoking pci_epc_get()
@@ -59,7 +59,7 @@ void pci_epc_put(struct pci_epc *epc)
 EXPORT_SYMBOL_GPL(pci_epc_put);
 
 /**
- * pci_epc_get() - get the pci endpoint controller
+ * pci_epc_get() - get the PCI endpoint controller
  * @epc_name: device name of the endpoint controller
  *
  * Invoke to get struct pci_epc * corresponding to the device name of the
@@ -225,11 +225,11 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 interrupts)
 EXPORT_SYMBOL_GPL(pci_epc_set_msi);
 
 /**
- * pci_epc_unmap_addr() - unmap cpu address from pci address
+ * pci_epc_unmap_addr() - unmap CPU address from PCI address
  * @epc: the EPC device on which address is allocated
  * @phys_addr: physical address of the local system
  *
- * Invoke to unmap the cpu address from pci address.
+ * Invoke to unmap the CPU address from PCI address.
  */
 void pci_epc_unmap_addr(struct pci_epc *epc, phys_addr_t phys_addr)
 {
@@ -248,13 +248,13 @@ void pci_epc_unmap_addr(struct pci_epc *epc, phys_addr_t phys_addr)
 EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
 
 /**
- * pci_epc_map_addr() - map cpu address to pci address
+ * pci_epc_map_addr() - map CPU address to PCI address
  * @epc: the EPC device on which address is allocated
  * @phys_addr: physical address of the local system
- * @pci_addr: pci address to which the physical address should be mapped
+ * @pci_addr: PCI address to which the physical address should be mapped
  * @size: the size of the allocation
  *
- * Invoke to map cpu address with pci address.
+ * Invoke to map CPU address with PCI address.
  */
 int pci_epc_map_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 		     u64 pci_addr, size_t size)
@@ -279,7 +279,7 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
 /**
  * pci_epc_clear_bar() - reset the BAR
  * @epc: the EPC device for which the BAR has to be cleared
- * @bar: the bar number that has to be reset
+ * @bar: the BAR number that has to be reset
  *
  * Invoke to reset the BAR of the endpoint device.
  */
@@ -302,7 +302,7 @@ EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
 /**
  * pci_epc_set_bar() - configure BAR in order for host to assign PCI addr space
  * @epc: the EPC device on which BAR has to be configured
- * @bar: the bar number that has to be configured
+ * @bar: the BAR number that has to be configured
  * @size: the size of the addr space
  * @flags: specify memory allocation/io allocation/32bit address/64 bit address
  *
@@ -358,13 +358,13 @@ int pci_epc_write_header(struct pci_epc *epc, struct pci_epf_header *header)
 EXPORT_SYMBOL_GPL(pci_epc_write_header);
 
 /**
- * pci_epc_add_epf() - bind pci endpoint function to an endpoint controller
+ * pci_epc_add_epf() - bind PCI endpoint function to an endpoint controller
  * @epc: the EPC device to which the endpoint function should be added
  * @epf: the endpoint function to be added
  *
  * A PCI endpoint device can have one or more functions. In the case of PCIe,
- * the specification allows upto 8 PCIe endpoint functions. Invoke
- * pci_epc_add_epf() to add a pci endpoint function to an endpoint controller.
+ * the specification allows up to 8 PCIe endpoint functions. Invoke
+ * pci_epc_add_epf() to add a PCI endpoint function to an endpoint controller.
  */
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
@@ -392,11 +392,11 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 EXPORT_SYMBOL_GPL(pci_epc_add_epf);
 
 /**
- * pci_epc_remove_epf() - remove pci endpoint function from endpoint controller
+ * pci_epc_remove_epf() - remove PCI endpoint function from endpoint controller
  * @epc: the EPC device from which the endpoint function should be removed
  * @epf: the endpoint function to be removed
  *
- * Invoke to remove pci endpoint function from the endpoint controller.
+ * Invoke to remove PCI endpoint function from the endpoint controller.
  */
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 9ec1639ef749..92db7dcd911c 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -87,7 +87,7 @@ EXPORT_SYMBOL_GPL(pci_epf_bind);
 /**
  * pci_epf_free_space() - free the allocated PCI EPF register space
  * @addr: the virtual address of the PCI EPF register space
- * @bar: the bar number corresponding to the register space
+ * @bar: the BAR number corresponding to the register space
  *
  * Invoke to free the allocated PCI EPF register space.
  */
@@ -109,7 +109,7 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
 /**
  * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
  * @size: the size of the memory that has to be allocated
- * @bar: the bar number corresponding to the allocated register space
+ * @bar: the BAR number corresponding to the allocated register space
  *
  * Invoke to allocate memory for the PCI EPF register space.
  */
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index d6eb32291462..af5edbf3eea3 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -27,8 +27,8 @@ enum pci_epc_irq_type {
  * @write_header: ops to populate configuration space header
  * @set_bar: ops to configure the BAR
  * @clear_bar: ops to reset the BAR
- * @map_addr: ops to map cpu address to pci address
- * @unmap_addr: ops to unmap cpu address and pci address
+ * @map_addr: ops to map CPU address to PCI address
+ * @unmap_addr: ops to unmap CPU address and PCI address
  * @set_msi: ops to set the requested number of MSI interrupts in the MSI
  *	     capability register
  * @get_msi: ops to get the number of MSI interrupts allocated by the RC from
@@ -58,9 +58,9 @@ struct pci_epc_ops {
 
 /**
  * struct pci_epc_mem - address space of the endpoint controller
- * @phys_base: physical base address of the pci address space
- * @size: the size of the pci address space
- * @bitmap: bitmap to manage the pci address space
+ * @phys_base: physical base address of the PCI address space
+ * @size: the size of the PCI address space
+ * @bitmap: bitmap to manage the PCI address space
  * @pages: number of bits representing the address region
  */
 struct pci_epc_mem {
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 5ff2c5a592c3..0d529cb90143 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -38,7 +38,7 @@ enum pci_barno {
  * struct pci_epf_header - represents standard configuration header
  * @vendorid: identifies device manufacturer
  * @deviceid: identifies a particular device
- * @revid: specifies a device specific revision identifier
+ * @revid: specifies a device-specific revision identifier
  * @progif_code: identifies a specific register-level programming interface
  * @subclass_code: identifies more specifically the function of the device
  * @baseclass_code: broadly classifies the type of function the device performs
@@ -115,11 +115,11 @@ struct pci_epf_bar {
  * @name: the name of the PCI EPF device
  * @header: represents standard configuration header
  * @bar: represents the BAR of EPF device
- * @msi_interrupts: number of msi interrupts required by this function
+ * @msi_interrupts: number of MSI interrupts required by this function
  * @func_no: unique function number within this endpoint device
  * @epc: the EPC device to which this EPF device is bound
  * @driver: the EPF driver to which this EPF device is bound
- * @list: to add pci_epf as a list of pci endpoint functions to pci_epc
+ * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
  */
 struct pci_epf {
 	struct device		dev;
diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 39b5b0ba569e..ad54a58d7dda 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -170,7 +170,7 @@ int main(int argc, char **argv)
 		fprintf(stderr,
 			"usage: %s [options]\n"
 			"Options:\n"
-			"\t-D <dev>		pci endpoint test device {default: /dev/pci-endpoint-test.0}\n"
+			"\t-D <dev>		PCI endpoint test device {default: /dev/pci-endpoint-test.0}\n"
 			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
 			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
 			"\t-r			Read buffer test\n"




--- cl.orig	2017-04-04 15:26:34.555152663 -0500
+++ cl.new	2017-04-04 15:26:47.575278312 -0500
@@ -1,67 +1,67 @@
-commit 485847badf93
+commit 2f81b96ef43e
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:20 2017 +0530
 
     ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
     
-    The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should
-    be set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO
-    in RC mode. However in EP mode, the host system is not able to access the
+    The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should be
+    set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO in RC
+    mode. However in EP mode, the host system is not able to access the
     MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.
     
     Acked-by: Tony Lindgren <tony@atomide.com>
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit ea4a8033fd42
+commit 4d53ed89fe50
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:19 2017 +0530
 
-    MAINTAINERS: add PCI EP maintainer
+    MAINTAINERS: Add PCI Endpoint maintainer
     
-    Add maintainer for the newly introduced PCI EP framework.
+    Add maintainer for the newly introduced PCI Endpoint framework.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 9c3eb6b9db09
+commit a11812c0dacc
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:18 2017 +0530
 
     Documentation: PCI: Add userguide for PCI endpoint test function
     
-    Add documentation to help users use pci-epf-test function driver
-    and pci_endpoint_test host driver for testing PCI.
+    Add documentation to help users use pci-epf-test function driver and
+    pci_endpoint_test host driver for testing PCI.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit ce58c0dca0fc
+commit c7ce6959f0a5
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:17 2017 +0530
 
     tools: PCI: Add sample test script to invoke pcitest
     
-    Add a simple test script that invokes the pcitest userspace tool
-    to perform all the PCI endpoint tests (BAR tests, interrupt tests,
-    read tests, write tests and copy tests).
+    Add a simple test script that invokes the pcitest userspace tool to perform
+    all the PCI endpoint tests (BAR tests, interrupt tests, read tests, write
+    tests and copy tests).
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit fdc27ef5bde2
+commit f9ee26a038d8
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:16 2017 +0530
 
     tools: PCI: Add a userspace tool to test PCI endpoint
     
-    Add a userspace tool to invoke the ioctls exposed by the
-    PCI endpoint test driver to perform various PCI tests.
+    Add a userspace tool to invoke the ioctls exposed by the PCI endpoint test
+    driver to perform various PCI tests.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit d323b479a02e
+commit fea31fd3cf56
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:15 2017 +0530
 
@@ -72,21 +72,21 @@
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit d26ec30392dd
+commit bedcd782937f
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:14 2017 +0530
 
-    misc: Add host side pci driver for pci test function device
+    misc: Add host side PCI driver for PCI test function device
     
-    Add PCI endpoint test driver that can verify base address
-    register, legacy interrupt/MSI interrupt and read/write/copy
-    buffers between host and device. The corresponding pci-epf-test
-    function driver should be used on the EP side.
+    Add PCI endpoint test driver that can verify base address register, legacy
+    interrupt/MSI interrupt and read/write/copy buffers between host and
+    device. The corresponding pci-epf-test function driver should be used on
+    the EP side.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 5b43200ddaa7
+commit 8066f3c52feb
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:13 2017 +0530
 
@@ -98,115 +98,115 @@
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit a5090d8e9668
+commit 25eef24289ee
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:12 2017 +0530
 
-    dt-bindings: PCI: dra7xx: Add dt bindings to enable unaligned access
+    dt-bindings: PCI: dra7xx: Add DT bindings to enable unaligned access
     
-    Update device tree binding documentation of TI's dra7xx PCI
-    controller to include property for enabling unaligned mem access.
+    Update device tree binding documentation of TI's dra7xx PCI controller to
+    include property for enabling unaligned mem access.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 3f080640d53f
+commit ebe506162817
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:11 2017 +0530
 
     PCI: dwc: dra7xx: Workaround for errata id i870
     
-    According to errata i870, access to the PCIe slave port
-    that are not 32-bit aligned will result in incorrect mapping
-    to TLP Address and Byte enable fields.
+    According to errata i870, access to the PCIe slave port that are not 32-bit
+    aligned will result in incorrect mapping to TLP Address and Byte enable
+    fields.
     
     Accessing non 32-bit aligned data causes incorrect data in the target
-    buffer if memcpy is used. Implement the workaround for this
-    errata here.
+    buffer if memcpy is used. Implement the workaround for this errata here.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 24365ea32418
+commit 9ff4601c7765
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:10 2017 +0530
 
     dt-bindings: mfd: syscon: Add documentation for #syscon-cells property
     
-    Add documentation for the optional #syscon-cells property to determine
-    the number of cells that should be given in the phandle while
-    referencing the syscon-node.
+    Add documentation for the optional #syscon-cells property to determine the
+    number of cells that should be given in the phandle while referencing the
+    syscon-node.
     
     Suggested-by: Rob Herring <robh@kernel.org>
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 27cb5fde6551
+commit 1329cf15fe87
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:09 2017 +0530
 
-    dt-bindings: PCI: dra7xx: Add dt bindings for pci dra7xx EP mode
+    dt-bindings: PCI: dra7xx: Add DT bindings for PCI dra7xx EP mode
     
-    Add device tree binding documentation for pci dra7xx EP mode.
+    Add device tree binding documentation for PCI dra7xx EP mode.
     
     Acked-by: Rob Herring <robh@kernel.org>
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit e8be32886fd1
+commit 6259ce5e8f4a
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:08 2017 +0530
 
     PCI: dwc: dra7xx: Add EP mode support
     
-    The PCIe controller integrated in dra7xx SoCs is capable of operating
-    in endpoint mode. Add endpoint mode support to dra7xx driver.
+    The PCIe controller integrated in dra7xx SoCs is capable of operating in
+    endpoint mode. Add endpoint mode support to dra7xx driver.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 3138c72f71f2
+commit 9567c35d6566
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:07 2017 +0530
 
-    PCI: dwc: dra7xx: Facilitate wrapper and msi interrupts to be enabled independently
+    PCI: dwc: dra7xx: Facilitate wrapper and MSI interrupts to be enabled independently
     
-    No functional change. Split dra7xx_pcie_enable_interrupts into
-    dra7xx_pcie_enable_wrapper_interrupts and dra7xx_pcie_enable_msi_interrupts
-    so that wrapper interrupts and msi interrupts can be enabled independently.
-    This is in preparation for adding EP mode support to dra7xx driver since
-    EP mode doesn't have to enable msi_interrupts.
+    No functional change. Split dra7xx_pcie_enable_interrupts() into
+    dra7xx_pcie_enable_wrapper_interrupts() and
+    dra7xx_pcie_enable_msi_interrupts() so that wrapper interrupts and MSI
+    interrupts can be enabled independently.  This is in preparation for adding
+    EP mode support to dra7xx driver since EP mode doesn't have to enable
+    msi_interrupts.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 8ba73ff9284c
+commit c10abab4c7ca
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:06 2017 +0530
 
-    dt-bindings: PCI: Add dt bindings for pci designware EP mode
+    dt-bindings: PCI: Add DT bindings for PCI designware EP mode
     
-    Add device tree binding documentation for pci designware EP mode.
+    Add device tree binding documentation for PCI designware EP mode.
     
-    Acked-by: Rob Herring <robh@kernel.org>
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
+    Acked-by: Rob Herring <robh@kernel.org>
 
-commit b6251498f9bc
+commit 98d63c77d6a0
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:05 2017 +0530
 
     PCI: dwc: designware: Add EP mode support
     
-    Add endpoint mode support to designware driver. This uses the
-    EP Core layer introduced recently to add endpoint mode support.
-    *Any* function driver can now use this designware device
-    in order to achieve the EP functionality.
+    Add endpoint mode support to designware driver. This uses the EP Core layer
+    introduced recently to add endpoint mode support.  *Any* function driver
+    can now use this designware device in order to achieve the EP
+    functionality.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 86d768a59594
+commit 36ecd387d736
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:04 2017 +0530
 
@@ -218,71 +218,70 @@
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 41c1e46c71b9
+commit b8116f7d8cec
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:03 2017 +0530
 
     PCI: endpoint: functions: Add an EP function to test PCI
     
-    Adds a new endpoint function driver (to program the virtual
-    test device) making use of the EP-core library.
+    Adds a new endpoint function driver (to program the virtual test device)
+    making use of the EP-core library.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 05e78b3dee04
+commit 1a5946105d8d
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:02 2017 +0530
 
-    Documentation: PCI: Add specification for the *pci test* function device
+    Documentation: PCI: Add specification for the *PCI test* function device
     
-    Add specification for the *pci test* virtual function device. The endpoint
-    function driver and the host pci driver should be created based on this
+    Add specification for the *PCI test* virtual function device. The endpoint
+    function driver and the host PCI driver should be created based on this
     specification.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 5904951f2a07
+commit f24b3959ecbc
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:01 2017 +0530
 
     PCI: endpoint: Create configfs entry for EPC device and EPF driver
     
-    Invoke API's provided by pci-ep-cfs to create configfs entry for
-    every EPC device and EPF driver to help users in creating EPF device
-    and binding the EPF device to the EPC device.
+    Invoke APIs provided by pci-ep-cfs to create configfs entry for every EPC
+    device and EPF driver to help users in creating EPF device and binding the
+    EPF device to the EPC device.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit c782a62981cd
+commit afbfe69d612b
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:15:00 2017 +0530
 
-    Documentation: PCI: Guide to use pci endpoint configfs
+    Documentation: PCI: Guide to use PCI endpoint configfs
     
-    Add Documentation to help users use pci endpoint to configure
-    pci endpoint function and to bind the endpoint function
-    with endpoint controller.
+    Add Documentation to help users use PCI endpoint to configure PCI endpoint
+    function and to bind the endpoint function with endpoint controller.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 9b703e4292d1
+commit 7049ceb16f8d
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:14:59 2017 +0530
 
     PCI: endpoint: Introduce configfs entry for configuring EP functions
     
     Introduce a new configfs entry to configure the EP function (like
-    configuring the standard configuration header entries) and to
-    bind the EP function with EP controller.
+    configuring the standard configuration header entries) and to bind the EP
+    function with EP controller.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit d03d46a9d9fc
+commit e025fb44364f
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:14:58 2017 +0530
 
@@ -294,18 +293,17 @@
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit ff50e9e4a512
+commit 79e4effb2a36
 Author: Kishon Vijay Abraham I <kishon@ti.com>
 Date:   Mon Mar 27 15:14:57 2017 +0530
 
     PCI: endpoint: Add EP core layer to enable EP controller and EP functions
     
-    Introduce a new EP core layer in order to support endpoint functions
-    in linux kernel. This comprises of EPC library
-    (Endpoint Controller Library) and EPF library (Endpoint
-    Function Library). EPC library implements functions that is specific
-    to an endpoint controller and EPF library implements functions
-    that is specific to an endpoint function.
+    Introduce a new EP core layer in order to support endpoint functions in
+    linux kernel. This comprises the EPC library (Endpoint Controller Library)
+    and EPF library (Endpoint Function Library). EPC library implements
+    functions specific to an endpoint controller and EPF library implements
+    functions specific to an endpoint function.
     
     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
