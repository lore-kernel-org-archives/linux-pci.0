Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 1/3] of/pci: dma-ranges to account highest possible
 host bridge dma_mask
To: Oza Oza <oza.oza@broadcom.com>, Rob Herring <robh@kernel.org>
References: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
 <CAL_JsqLtTiH7DhqKf_x7xy1KZYQyiOreK=M90HFr=8BDW9542w@mail.gmail.com>
 <CAMSpPPdnQdWeyTsnESRFx52gtxQLxwfPQwQgDFSN=katfW7suA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <de6bfedf-62aa-98e4-dae5-7862ab3ba754@arm.com>
Date: Tue, 28 Mar 2017 15:29:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAMSpPPdnQdWeyTsnESRFx52gtxQLxwfPQwQgDFSN=katfW7suA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 28/03/17 06:27, Oza Oza wrote:
> On Mon, Mar 27, 2017 at 8:16 PM, Rob Herring <robh@kernel.org> wrote:
>> On Sat, Mar 25, 2017 at 12:31 AM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
>>> it is possible that PCI device supports 64-bit DMA addressing,
>>> and thus it's driver sets device's dma_mask to DMA_BIT_MASK(64),
>>> however PCI host bridge may have limitations on the inbound
>>> transaction addressing. As an example, consider NVME SSD device
>>> connected to iproc-PCIe controller.
>>>
>>> Currently, the IOMMU DMA ops only considers PCI device dma_mask
>>> when allocating an IOVA. This is particularly problematic on
>>> ARM/ARM64 SOCs where the IOMMU (i.e. SMMU) translates IOVA to
>>> PA for in-bound transactions only after PCI Host has forwarded
>>> these transactions on SOC IO bus. This means on such ARM/ARM64
>>> SOCs the IOVA of in-bound transactions has to honor the addressing
>>> restrictions of the PCI Host.
>>>
>>> current pcie frmework and of framework integration assumes dma-ranges
>>> in a way where memory-mapped devices define their dma-ranges.
>>> dma-ranges: (child-bus-address, parent-bus-address, length).
>>>
>>> but iproc based SOCs and even Rcar based SOCs has PCI world dma-ranges.
>>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>>
>> If you implement a common function, then I expect to see other users
>> converted to use it. There's also PCI hosts in arch/powerpc that parse
>> dma-ranges.
> 
> the common function should be similar to what
> of_pci_get_host_bridge_resources is doing right now.
> it parses ranges property right now.
> 
> the new function would look look following.
> 
> of_pci_get_dma_ranges(struct device_node *dev, struct list_head *resources)
> where resources would return the dma-ranges.
> 
> but right now if you see the patch, of_dma_configure calls the new
> function, which actually returns the largest possible size.
> so this new function has to be generic in a way where other PCI hosts
> can use it. but certainly iproc(Broadcom SOC) , rcar based SOCs can
> use it for sure.
> 
> although having powerpc using it;  is a separate exercise, since I do
> not have any access to other PCI hosts such as powerpc. but we can
> workout with them on thsi forum if required.
> 
> so overall, of_pci_get_dma_ranges has to serve following 2 purposes.
> 
> 1) it has to return largest possible size to of_dma_configure to
> generate largest possible dma_mask.
> 
> 2) it also has to return resources (dma-ranges) parsed, to the users.
> 
> so to address above needs
> 
> of_pci_get_dma_ranges(struct device_node *dev, struct list_head
> *resources, u64 *size)
> 
> dev -> device node.
> resources -> dma-ranges in allocated list.
> size -> highest possible size to generate possible dma_mask for
> of_dma_configure.
> 
> let em know how this sounds.

Note that the point of passing PCI host bridges into of_dma_configure()
in the first place was to avoid having some separate PCI-specific path
for DMA configuration. I worry that introducing bus-specific dma-ranges
parsing largely defeats that, since we end up with the worst of both
worlds; effectively-duplicated code, and/or a load of extra complexity
to then attempt to reconverge the divergent paths (there really
shouldn't be any need to allocate a list of anything). Given that
of_translate_dma_address() is already bus-agnostic, it hardly seems
justifiable for its caller not to be so as well, especially when it
mostly just comes down to getting the right #address-cells value.

The patch below is actually enough to make typical cases work, but is
vile, so I'm not seriously considering it (hence I've not bothered
making IOMMU configuration handle all circumstances). What it has served
to do, though, is give me a clear idea of how to properly sort out the
not-quite-right device/parent assumptions between of_dma_configure() and
of_dma_get_range() rather than bodging around them any further - stay tuned.

Robin.

----->8-----
From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] of/pci: Use child node for DMA configuration

of_dma_configure() expects to be passed an OF node representing the
device being configured - for PCI devices we currently pass the node of
the appropriate host controller, which sort of works for inherited
properties which may appear at any level, like "dma-coherent", but falls
apart for properties which actually care about specific device-parent
relationships, like "dma-ranges".

Solve this by attempting to find a suitable child node if the PCI
hierarchy is actually represented in DT, and if not then faking one up
as a last resort, to make all of DMA configuration work as expected.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/of_iommu.c |  3 ++-
 drivers/pci/of.c         | 24 ++++++++++++++++++++++++
 drivers/pci/probe.c      | 14 +++++++++++++-
 include/linux/pci.h      |  3 +++
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 2683e9fc0dcf..35c97b945c15 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -146,7 +146,8 @@ const struct iommu_ops *of_iommu_configure(struct
device *dev,
 	int idx = 0;

 	if (dev_is_pci(dev))
-		return of_pci_iommu_configure(to_pci_dev(dev), master_np);
+		return of_pci_iommu_configure(to_pci_dev(dev),
+					      of_get_next_parent(master_np));

 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index e112da11630e..96eece1c423d 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -88,3 +88,27 @@ struct irq_domain
*pci_host_bridge_of_msi_domain(struct pci_bus *bus)
 	return NULL;
 #endif
 }
+
+struct device_node *pci_dev_get_dma_of_node(struct pci_dev *dev)
+{
+	struct device_node *np;
+	struct pci_bus *bus = dev->bus;
+
+	/* Is the device itself actually described in the DT? */
+	np = of_node_get(dev->dev.of_node);
+	if (np)
+		return np;
+
+	/* Or is some intermediate bridge? That would do... */
+	for (bus = dev->bus; bus->parent; bus = bus->parent) {
+		np = of_node_get(bus->bridge->of_node);
+		if (np)
+			return np;
+	}
+
+	/* Failing that, any child of the same host bridge? */
+	if (bus->bridge->parent)
+		np = of_get_next_child(bus->bridge->parent->of_node, NULL);
+
+	return np;
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dfc9a2794141..4f7ade64aa3e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1906,7 +1906,19 @@ static void pci_dma_configure(struct pci_dev *dev)

 	if (IS_ENABLED(CONFIG_OF) &&
 		bridge->parent && bridge->parent->of_node) {
-			of_dma_configure(&dev->dev, bridge->parent->of_node);
+		struct device_node *np, tmp = {0};
+
+		np = pci_dev_get_dma_of_node(dev);
+		if (!np) {
+			np = &tmp;
+			of_node_set_flag(np, OF_DETACHED);
+			of_node_init(np);
+			tmp.parent = bridge->parent->of_node;
+		}
+
+		of_dma_configure(&dev->dev, np);
+		if (np != &tmp)
+			of_node_put(np);
 	} else if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a04e6c..94ecd1817f58 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2086,6 +2086,7 @@ void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus);
+struct device_node *pci_dev_get_dma_of_node(struct pci_dev *dev);

 /* Arch may override this (weak) */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
@@ -2110,6 +2111,8 @@ static inline struct device_node *
 pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
 static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
+static inline struct device_node *
+pci_dev_get_dma_of_node(struct pci_dev *dev) { return NULL; }
 #endif  /* CONFIG_OF */

 #ifdef CONFIG_ACPI


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
