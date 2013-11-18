Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57182 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731Ab3KRFqw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Nov 2013 00:46:52 -0500
Message-ID: <5289A9B8.3010408@ti.com>
Date: Mon, 18 Nov 2013 11:16:32 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>, Jingoo Han <jg1.han@samsung.com>
CC: "'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Pratyush Anand'" <pratyush.anand@st.com>,
	<linux-pci@vger.kernel.org>,
	"'Mohit KUMAR DCG'" <Mohit.KUMAR@st.com>,
	"'Ajay KHANDELWAL'" <ajay.khandelwal@st.com>,
	"'Tim Harvey'" <tharvey@gateworks.com>,
	"'Arnd Bergmann'" <arnd@arndb.de>
Subject: Re: [QUERY] Number of address translation regions in designware
References: <52652BF1.4040507@ti.com> <5285B0E7.5000802@ti.com> <000901cee1c9$d8ec6450$8ac52cf0$%han@samsung.com> <201311151637.53867.marex@denx.de>
In-Reply-To: <201311151637.53867.marex@denx.de>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
On Friday 15 November 2013 09:07 PM, Marek Vasut wrote:
> Hi Kishon, Jingoo,
> 
>> On Friday, November 15, 2013 2:28 PM, Kishon Vijay Abraham I wrote:
>>> On Friday 15 November 2013 06:10 AM, Marek Vasut wrote:
>>>> Hi Kishon,
>>>>
>>>> just curious, what's the current status of the DWC PCIe driver? How's
>>>> the iATU issue going? Can you please update us a little?
>>>
>>> I was able to get it working in DRA7. Few of the dependent stuffs are not
>>> in mainline yet (some clock related patches, rest framework changes, PHY
>>> changes). Will post a RFC soon for pcie only part.
>>
>> OK, I see.
>> If you send the RFC patch, I will review ant test your patch
>> as soon as possible. Thank you for your effort. :-)
> 
> DTTO here, I can test it on MX6 as well. If you can roll out a prototype, I'm 
> sure we can help in some ways too :)

huh.. I didn't change much in designware code that would affect other
platforms. I just added a property base_mask that should be populated from the
dt data. (if it's not populated from the dt data, it will take the default
value of all f's). Here is the patch anyway.

Thanks
Kishon

commit b91b61d594f293d994d87f10eb8a1a3b2e5f8977
Author: Kishon Vijay Abraham I <kishon@ti.com>
Date:   Wed Oct 30 14:51:58 2013 +0530

    pci: host: pcie-designware: Use *base-mask* for configuring the iATU

    In DRA7, the cpu sees 32bit address, but the pcie controller can see only 28bit
    address. So whenever the cpu issues a read/write request, the 4 most
    significant bits are used by L3 to determine the target controller.
    For example, the cpu reserves 0x2000_0000 - 0x2FFF_FFFF for PCIe controller but
    the PCIe controller will see only (0x000_0000 - 0xFFF_FFF). So for programming
    the outbound translation window the *base* should be programmed as 0x000_0000.
    Whenever we try to write to say 0x2000_0000, it will be translated to whatever
    we have programmed in the translation window with base as 0x000_0000.

    Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt
b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index d5d26d4..fc04ab7 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -25,6 +25,7 @@ Optional properties for fsl,imx6q-pcie
 - power-on-gpio: gpio pin number of power-enable signal
 - wake-up-gpio: gpio pin number of incoming wakeup signal
 - disable-gpio: gpio pin number of outgoing rfkill/endpoint disable signal
+- base-mask: address mask for the PCIe controller target port

 Example:

diff --git a/drivers/pci/host/pcie-designware.c
b/drivers/pci/host/pcie-designware.c
index f879116..fef64cf 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -440,6 +440,9 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 		return -EINVAL;
 	}

+	if (of_property_read_u64(np, "base-mask", &pp->base_mask))
+		pp->base_mask = ~(0x0ULL);
+
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
 					MAX_MSI_IRQS, &msi_domain_ops,
@@ -479,12 +482,15 @@ int __init dw_pcie_host_init(struct pcie_port *pp)

 static void dw_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
 {
+	u64 cfg0_base;
+
+	cfg0_base = pp->cfg0_base & pp->base_mask;
 	/* Program viewport 0 : OUTBOUND : CFG0 */
 	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
 			  PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, pp->cfg0_base, PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->cfg0_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->cfg0_base + pp->config.cfg0_size - 1,
+	dw_pcie_writel_rc(pp, cfg0_base, PCIE_ATU_LOWER_BASE);
+	dw_pcie_writel_rc(pp, (cfg0_base >> 32), PCIE_ATU_UPPER_BASE);
+	dw_pcie_writel_rc(pp, cfg0_base + pp->config.cfg0_size - 1,
 			  PCIE_ATU_LIMIT);
 	dw_pcie_writel_rc(pp, busdev, PCIE_ATU_LOWER_TARGET);
 	dw_pcie_writel_rc(pp, 0, PCIE_ATU_UPPER_TARGET);
@@ -494,14 +500,17 @@ static void dw_pcie_prog_viewport_cfg0(struct pcie_port
*pp, u32 busdev)

 static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
 {
+	u64 cfg1_base;
+
+	cfg1_base = pp->cfg1_base & pp->base_mask;
 	/* Program viewport 1 : OUTBOUND : CFG1 */
 	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
 			  PCIE_ATU_VIEWPORT);
 	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, PCIE_ATU_CR1);
 	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
-	dw_pcie_writel_rc(pp, pp->cfg1_base, PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->cfg1_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->cfg1_base + pp->config.cfg1_size - 1,
+	dw_pcie_writel_rc(pp, cfg1_base, PCIE_ATU_LOWER_BASE);
+	dw_pcie_writel_rc(pp, (cfg1_base >> 32), PCIE_ATU_UPPER_BASE);
+	dw_pcie_writel_rc(pp, cfg1_base + pp->config.cfg1_size - 1,
 			  PCIE_ATU_LIMIT);
 	dw_pcie_writel_rc(pp, busdev, PCIE_ATU_LOWER_TARGET);
 	dw_pcie_writel_rc(pp, 0, PCIE_ATU_UPPER_TARGET);
@@ -509,14 +518,17 @@ static void dw_pcie_prog_viewport_cfg1(struct pcie_port
*pp, u32 busdev)

 static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
 {
+	u64 mem_base;
+
+	mem_base = pp->mem_base & pp->base_mask;
 	/* Program viewport 0 : OUTBOUND : MEM */
 	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
 			  PCIE_ATU_VIEWPORT);
 	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_MEM, PCIE_ATU_CR1);
 	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
-	dw_pcie_writel_rc(pp, pp->mem_base, PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->mem_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->mem_base + pp->config.mem_size - 1,
+	dw_pcie_writel_rc(pp, mem_base, PCIE_ATU_LOWER_BASE);
+	dw_pcie_writel_rc(pp, (mem_base >> 32), PCIE_ATU_UPPER_BASE);
+	dw_pcie_writel_rc(pp, mem_base + pp->config.mem_size - 1,
 			  PCIE_ATU_LIMIT);
 	dw_pcie_writel_rc(pp, pp->config.mem_bus_addr, PCIE_ATU_LOWER_TARGET);
 	dw_pcie_writel_rc(pp, upper_32_bits(pp->config.mem_bus_addr),
@@ -525,14 +537,17 @@ static void dw_pcie_prog_viewport_mem_outbound(struct
pcie_port *pp)

 static void dw_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
 {
+	u64 io_base;
+
+	io_base = pp->io_base & pp->base_mask;
 	/* Program viewport 1 : OUTBOUND : IO */
 	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
 			  PCIE_ATU_VIEWPORT);
 	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_IO, PCIE_ATU_CR1);
 	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
-	dw_pcie_writel_rc(pp, pp->io_base, PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->io_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->io_base + pp->config.io_size - 1,
+	dw_pcie_writel_rc(pp, io_base, PCIE_ATU_LOWER_BASE);
+	dw_pcie_writel_rc(pp, (io_base >> 32), PCIE_ATU_UPPER_BASE);
+	dw_pcie_writel_rc(pp, io_base + pp->config.io_size - 1,
 			  PCIE_ATU_LIMIT);
 	dw_pcie_writel_rc(pp, pp->config.io_bus_addr, PCIE_ATU_LOWER_TARGET);
 	dw_pcie_writel_rc(pp, upper_32_bits(pp->config.io_bus_addr),
diff --git a/drivers/pci/host/pcie-designware.h
b/drivers/pci/host/pcie-designware.h
index c15379b..2fe1dc5 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -35,6 +35,7 @@ struct pcie_port {
 	struct device		*dev;
 	u8			root_bus_nr;
 	void __iomem		*dbi_base;
+	u64			base_mask;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
 	u64			cfg1_base;
> 
> Best regards,
> Marek Vasut
> 

