Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:9541 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbcKHD3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2016 22:29:01 -0500
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>,
        <mark.rutland@arm.com>, <olof@lixom.net>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
CC: <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <minyard@acm.org>, <benh@kernel.crashing.org>,
        <liviu.dudau@arm.com>, <zourongrong@gmail.com>,
        <john.garry@huawei.com>, <gabriele.paoloni@huawei.com>,
        <zhichang.yuan02@gmail.com>, <kantyzc@163.com>,
        <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for special ISA
Date: Tue, 8 Nov 2016 11:47:08 +0800
Message-ID: <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch solves two issues:
1) parse and get the right I/O range from DTS node whose parent does not
define the corresponding ranges property;

There are some special ISA/LPC devices that work on a specific I/O range where
it is not correct to specify a ranges property in DTS parent node as cpu
addresses translated from DTS node are only for memory space on some
architectures, such as Arm64. Without the parent 'ranges' property, current
of_translate_address() return an error.
Here we add a fixup function, of_get_isa_indirect_io(). During the OF address
translation, this fixup will be called to check the 'reg' address to be
translating is for those sepcial ISA/LPC devices and get the I/O range
directly from the 'reg' property.

2) eliminate the I/O range conflict risk with PCI/PCIE leagecy I/O device;

The current __of_address_to_resource() always translates the I/O range to PIO.
But this processing is not suitable for our ISA/LPC devices whose I/O range is
not cpu address(Arnd had stressed this in his comments on V2,V3 patch-set).
Here, we bypass the mapping between cpu address and PIO for the special
ISA/LPC devices. But to drive these ISA/LPC devices, a I/O port address below
PCIBIOS_MIN_IO is needed by in*/out*(). Which means there is conflict risk
between I/O range of [0, PCIBIOS_MIN_IO) and PCI/PCIE legacy I/O range of [0,
IO_SPACE_LIMIT).
To avoid the I/O conflict, this patch reserve the I/O range below
PCIBIOS_MIN_IO.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 .../arm/hisilicon/hisilicon-low-pin-count.txt      | 31 ++++++++++++
 arch/arm64/include/asm/io.h                        |  6 +++
 arch/arm64/kernel/extio.c                          | 25 ++++++++++
 drivers/of/address.c                               | 56 +++++++++++++++++++++-
 drivers/pci/pci.c                                  |  6 +--
 include/linux/of_address.h                         | 17 +++++++
 include/linux/pci.h                                |  8 ++++
 7 files changed, 145 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
new file mode 100644
index 0000000..13c8ddd
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
@@ -0,0 +1,31 @@
+Hisilicon Hip06 low-pin-count device
+  Usually LPC controller is part of PCI host bridge, so the legacy ISA ports
+  locate on LPC bus can be accessed direclty. But some SoCs have independent
+  LPC controller, and access the legacy ports by triggering LPC I/O cycles.
+  Hisilicon Hip06 implements this LPC device.
+
+Required properties:
+- compatible: should be "hisilicon,low-pin-count"
+- #address-cells: must be 2 which stick to the ISA/EISA binding doc.
+- #size-cells: must be 1 which stick to the ISA/EISA binding doc.
+- reg: base memory range where the register set of this device is mapped.
+
+Note:
+  The node name before '@' must be "isa" to represent the binding stick to the
+  ISA/EISA binding specification.
+
+Example:
+
+isa@a01b0000 {
+	compatible = "hisilicom,low-pin-count";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	reg = <0x0 0xa01b0000 0x0 0x1000>;
+
+	ipmi0: bt@e4 {
+		compatible = "ipmi-bt";
+		device_type = "ipmi";
+		reg = <0x01 0xe4 0x04>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 136735d..c26b7cc 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -175,6 +175,12 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define outsl outsl
 
 DECLARE_EXTIO(l, u32)
+
+#define indirect_io_enabled indirect_io_enabled
+extern bool indirect_io_enabled(void);
+
+#define addr_is_indirect_io addr_is_indirect_io
+extern int addr_is_indirect_io(u64 taddr);
 #endif
 
 
diff --git a/arch/arm64/kernel/extio.c b/arch/arm64/kernel/extio.c
index 647b3fa..3d45fa8 100644
--- a/arch/arm64/kernel/extio.c
+++ b/arch/arm64/kernel/extio.c
@@ -19,6 +19,31 @@
 
 struct extio_ops *arm64_extio_ops;
 
+/**
+ * indirect_io_enabled - check whether indirectIO is enabled.
+ *	arm64_extio_ops will be set only when indirectIO mechanism had been
+ *	initialized.
+ *
+ * Returns true when indirectIO is enabled.
+ */
+bool indirect_io_enabled(void)
+{
+	return arm64_extio_ops ? true : false;
+}
+
+/**
+ * addr_is_indirect_io - check whether the input taddr is for indirectIO.
+ * @taddr: the io address to be checked.
+ *
+ * Returns 1 when taddr is in the range; otherwise return 0.
+ */
+int addr_is_indirect_io(u64 taddr)
+{
+	if (arm64_extio_ops->start > taddr || arm64_extio_ops->end < taddr)
+		return 0;
+
+	return 1;
+}
 
 BUILD_EXTIO(b, u8)
 
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 02b2903..cc2a05d 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -479,6 +479,50 @@ static int of_empty_ranges_quirk(struct device_node *np)
 	return false;
 }
 
+
+/*
+ * of_isa_indirect_io - get the IO address from some isa reg property value.
+ *	For some isa/lpc devices, no ranges property in ancestor node.
+ *	The device addresses are described directly in their regs property.
+ *	This fixup function will be called to get the IO address of isa/lpc
+ *	devices when the normal of_translation failed.
+ *
+ * @parent:	points to the parent dts node;
+ * @bus:		points to the of_bus which can be used to parse address;
+ * @addr:	the address from reg property;
+ * @na:		the address cell counter of @addr;
+ * @presult:	store the address paresed from @addr;
+ *
+ * return 1 when successfully get the I/O address;
+ * 0 will return for some failures.
+ */
+static int of_get_isa_indirect_io(struct device_node *parent,
+				struct of_bus *bus, __be32 *addr,
+				int na, u64 *presult)
+{
+	unsigned int flags;
+	unsigned int rlen;
+
+	/* whether support indirectIO */
+	if (!indirect_io_enabled())
+		return 0;
+
+	if (!of_bus_isa_match(parent))
+		return 0;
+
+	flags = bus->get_flags(addr);
+	if (!(flags & IORESOURCE_IO))
+		return 0;
+
+	/* there is ranges property, apply the normal translation directly. */
+	if (of_get_property(parent, "ranges", &rlen))
+		return 0;
+
+	*presult = of_read_number(addr + 1, na - 1);
+	/* this fixup is only valid for specific I/O range. */
+	return addr_is_indirect_io(*presult);
+}
+
 static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 			    struct of_bus *pbus, __be32 *addr,
 			    int na, int ns, int pna, const char *rprop)
@@ -595,6 +639,15 @@ static u64 __of_translate_address(struct device_node *dev,
 			result = of_read_number(addr, na);
 			break;
 		}
+		/*
+		 * For indirectIO device which has no ranges property, get
+		 * the address from reg directly.
+		 */
+		if (of_get_isa_indirect_io(dev, bus, addr, na, &result)) {
+			pr_debug("isa indirectIO matched(%s)..addr = 0x%llx\n",
+				of_node_full_name(dev), result);
+			break;
+		}
 
 		/* Get new parent bus and counts */
 		pbus = of_match_bus(parent);
@@ -688,8 +741,9 @@ static int __of_address_to_resource(struct device_node *dev,
 	if (taddr == OF_BAD_ADDR)
 		return -EINVAL;
 	memset(r, 0, sizeof(struct resource));
-	if (flags & IORESOURCE_IO) {
+	if (flags & IORESOURCE_IO && taddr >= PCIBIOS_MIN_IO) {
 		unsigned long port;
+
 		port = pci_address_to_pio(taddr);
 		if (port == (unsigned long)-1)
 			return -EINVAL;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ba34907..1a08511 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3263,7 +3263,7 @@ int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
 
 #ifdef PCI_IOBASE
 	struct io_range *range;
-	resource_size_t allocated_size = 0;
+	resource_size_t allocated_size = PCIBIOS_MIN_IO;
 
 	/* check if the range hasn't been previously recorded */
 	spin_lock(&io_range_lock);
@@ -3312,7 +3312,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
 
 #ifdef PCI_IOBASE
 	struct io_range *range;
-	resource_size_t allocated_size = 0;
+	resource_size_t allocated_size = PCIBIOS_MIN_IO;
 
 	if (pio > IO_SPACE_LIMIT)
 		return address;
@@ -3335,7 +3335,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
 {
 #ifdef PCI_IOBASE
 	struct io_range *res;
-	resource_size_t offset = 0;
+	resource_size_t offset = PCIBIOS_MIN_IO;
 	unsigned long addr = -1;
 
 	spin_lock(&io_range_lock);
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 3786473..deec469 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -24,6 +24,23 @@ struct of_pci_range {
 #define for_each_of_pci_range(parser, range) \
 	for (; of_pci_range_parser_one(parser, range);)
 
+
+#ifndef indirect_io_enabled
+#define indirect_io_enabled indirect_io_enabled
+static inline bool indirect_io_enabled(void)
+{
+	return false;
+}
+#endif
+
+#ifndef addr_is_indirect_io
+#define addr_is_indirect_io addr_is_indirect_io
+static inline int addr_is_indirect_io(u64 taddr)
+{
+	return 0;
+}
+#endif
+
 /* Translate a DMA address from device space to CPU space */
 extern u64 of_translate_dma_address(struct device_node *dev,
 				    const __be32 *in_addr);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e49f70..7f6bbb6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2130,4 +2130,12 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 /* provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
 
+/*
+ * define this macro here to refrain from compilation error for some
+ * platforms. Please keep this macro at the end of this header file.
+ */
+#ifndef PCIBIOS_MIN_IO
+#define PCIBIOS_MIN_IO		0
+#endif
+
 #endif /* LINUX_PCI_H */
-- 
1.9.1

