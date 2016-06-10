Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org,
	jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	dhdang@apm.com,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	cov@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V9 10/11] ARM64/PCI: Implement ACPI low-level calls to access PCI_Config region from AML
Date: Fri, 10 Jun 2016 21:55:18 +0200
Message-Id: <1465588519-11334-11-git-send-email-tn@semihalf.com>
In-Reply-To: <1465588519-11334-1-git-send-email-tn@semihalf.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

ACPI spec6.1 - chapter: 5.5.2.4 defines OperationRegion (Declare Operation
Region). Following the spec: " [...] An Operation Region is a specific
region of operation within an address space that is declared as a subset
of the entire address space using a starting address (offset) and a length.
Control methods must have exclusive access to any address accessed via
fields declared in Operation Regions. [...]".

OperationRegion allows to declare various of operation region address space
identifiers including PCI_Config. PCI_Config is meant to access PCI
configuration space from the ASL. So every time ASL opcode operates
on PCI_Config space region, ASL interpreter dispatches accesses to OS
low-level calls - raw_pci_write() and raw_pci_read() for Linux - so-called
ACPI RAW accessors.

In order to support PCI_Config operation region, implement mentioned
raw_pci_write() and raw_pci_read() calls so they find associated bus
and call read/write ops.

Waiting for clarification in the ACPI specifications in relation
to PCI_Config space handling before PCI bus enumeration is completed,
current code does not support PCI_Config region accesses before PCI bus
enumeration whilst providing full AML PCI_Config access availability
when the PCI bus enumeration is completed by the kernel so that
RAW accessors can look-up PCI operations through the struct pci_bus
associated with a PCI bus.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/arm64/kernel/pci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index b3b8a2c..328f857 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -71,13 +71,21 @@ int pcibios_alloc_irq(struct pci_dev *dev)
 int raw_pci_read(unsigned int domain, unsigned int bus,
 		  unsigned int devfn, int reg, int len, u32 *val)
 {
-	return -ENXIO;
+	struct pci_bus *b = pci_find_bus(domain, bus);
+
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->read(b, devfn, reg, len, val);
 }
 
 int raw_pci_write(unsigned int domain, unsigned int bus,
 		unsigned int devfn, int reg, int len, u32 val)
 {
-	return -ENXIO;
+	struct pci_bus *b = pci_find_bus(domain, bus);
+
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->write(b, devfn, reg, len, val);
 }
 
 #ifdef CONFIG_NUMA
-- 
1.9.1
