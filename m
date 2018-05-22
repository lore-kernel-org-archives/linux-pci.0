Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 4/4] sparc/PCI: Use dev_printk() when possible
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Meelis Roos <mroos@linux.ee>
Date: Mon, 21 May 2018 19:30:55 -0500
Message-ID: <152694905565.59585.9207331445682490605.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Use the pci_info() and pci_err() wrappers for dev_printk() when possible.

Log PCI device vendor and device IDs and BAR information in the same format
used by other architectures.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sparc/kernel/leon_pci.c   |    4 --
 arch/sparc/kernel/pci.c        |   94 +++++++++++++++++++---------------------
 arch/sparc/kernel/pci_common.c |   12 +++--
 arch/sparc/kernel/pci_msi.c    |   10 ++--
 arch/sparc/kernel/pcic.c       |   29 ++++++------
 5 files changed, 70 insertions(+), 79 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index c2a5033b07c3..fe468ca2eedd 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -82,9 +82,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	}
 
 	if (cmd != oldcmd) {
-		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
-		       pci_name(dev), cmd);
-                /* Enable the appropriate bits in the PCI command register.  */
+		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 8a04983cf8a1..6f0408a3ebc9 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -214,8 +214,8 @@ static void pci_parse_of_addrs(struct platform_device *op,
 	if (!addrs)
 		return;
 	if (ofpci_verbose)
-		printk("    parse addresses (%d bytes) @ %p\n",
-		       proplen, addrs);
+		pci_info(dev, "    parse addresses (%d bytes) @ %p\n",
+			 proplen, addrs);
 	op_res = &op->resource[0];
 	for (; proplen >= 20; proplen -= 20, addrs += 5, op_res++) {
 		struct resource *res;
@@ -227,8 +227,8 @@ static void pci_parse_of_addrs(struct platform_device *op,
 			continue;
 		i = addrs[0] & 0xff;
 		if (ofpci_verbose)
-			printk("  start: %llx, end: %llx, i: %x\n",
-			       op_res->start, op_res->end, i);
+			pci_info(dev, "  start: %llx, end: %llx, i: %x\n",
+				 op_res->start, op_res->end, i);
 
 		if (PCI_BASE_ADDRESS_0 <= i && i <= PCI_BASE_ADDRESS_5) {
 			res = &dev->resource[(i - PCI_BASE_ADDRESS_0) >> 2];
@@ -236,13 +236,15 @@ static void pci_parse_of_addrs(struct platform_device *op,
 			res = &dev->resource[PCI_ROM_RESOURCE];
 			flags |= IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
 		} else {
-			printk(KERN_ERR "PCI: bad cfg reg num 0x%x\n", i);
+			pci_err(dev, "bad cfg reg num 0x%x\n", i);
 			continue;
 		}
 		res->start = op_res->start;
 		res->end = op_res->end;
 		res->flags = flags;
 		res->name = pci_name(dev);
+
+		pci_info(dev, "reg 0x%x: %pR\n", i, res);
 	}
 }
 
@@ -289,8 +291,8 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 		type = "";
 
 	if (ofpci_verbose)
-		printk("    create device, devfn: %x, type: %s\n",
-		       devfn, type);
+		pci_info(bus,"    create device, devfn: %x, type: %s\n",
+			 devfn, type);
 
 	dev->sysdata = node;
 	dev->dev.parent = bus->bridge;
@@ -323,10 +325,6 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(bus),
 		dev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
-	if (ofpci_verbose)
-		printk("    class: 0x%x device name: %s\n",
-		       dev->class, pci_name(dev));
-
 	/* I have seen IDE devices which will not respond to
 	 * the bmdma simplex check reads if bus mastering is
 	 * disabled.
@@ -353,10 +351,13 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 			dev->irq = PCI_IRQ_NONE;
 	}
 
+	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
+		 dev->vendor, dev->device, dev->hdr_type, dev->class);
+
 	pci_parse_of_addrs(sd->op, node, dev);
 
 	if (ofpci_verbose)
-		printk("    adding to system ...\n");
+		pci_info(dev, "    adding to system ...\n");
 
 	pci_device_add(dev, bus);
 
@@ -430,19 +431,19 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	u64 size;
 
 	if (ofpci_verbose)
-		printk("of_scan_pci_bridge(%s)\n", node->full_name);
+		pci_info(dev, "of_scan_pci_bridge(%s)\n", node->full_name);
 
 	/* parse bus-range property */
 	busrange = of_get_property(node, "bus-range", &len);
 	if (busrange == NULL || len != 8) {
-		printk(KERN_DEBUG "Can't get bus-range for PCI-PCI bridge %s\n",
+		pci_info(dev, "Can't get bus-range for PCI-PCI bridge %s\n",
 		       node->full_name);
 		return;
 	}
 
 	if (ofpci_verbose)
-		printk("    Bridge bus range [%u --> %u]\n",
-		       busrange[0], busrange[1]);
+		pci_info(dev, "    Bridge bus range [%u --> %u]\n",
+			 busrange[0], busrange[1]);
 
 	ranges = of_get_property(node, "ranges", &len);
 	simba = 0;
@@ -454,8 +455,8 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 
 	bus = pci_add_new_bus(dev->bus, dev, busrange[0]);
 	if (!bus) {
-		printk(KERN_ERR "Failed to create pci bus for %s\n",
-		       node->full_name);
+		pci_err(dev, "Failed to create pci bus for %s\n",
+			node->full_name);
 		return;
 	}
 
@@ -464,8 +465,8 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	bus->bridge_ctl = 0;
 
 	if (ofpci_verbose)
-		printk("    Bridge ranges[%p] simba[%d]\n",
-		       ranges, simba);
+		pci_info(dev, "    Bridge ranges[%p] simba[%d]\n",
+			 ranges, simba);
 
 	/* parse ranges property, or cook one up by hand for Simba */
 	/* PCI #address-cells == 3 and #size-cells == 2 always */
@@ -487,10 +488,10 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 		u64 start;
 
 		if (ofpci_verbose)
-			printk("    RAW Range[%08x:%08x:%08x:%08x:%08x:%08x:"
-			       "%08x:%08x]\n",
-			       ranges[0], ranges[1], ranges[2], ranges[3],
-			       ranges[4], ranges[5], ranges[6], ranges[7]);
+			pci_info(dev, "    RAW Range[%08x:%08x:%08x:%08x:%08x:%08x:"
+				 "%08x:%08x]\n",
+				 ranges[0], ranges[1], ranges[2], ranges[3],
+				 ranges[4], ranges[5], ranges[6], ranges[7]);
 
 		flags = pci_parse_of_flags(ranges[0]);
 		size = GET_64BIT(ranges, 6);
@@ -510,14 +511,14 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 		if (flags & IORESOURCE_IO) {
 			res = bus->resource[0];
 			if (res->flags) {
-				printk(KERN_ERR "PCI: ignoring extra I/O range"
-				       " for bridge %s\n", node->full_name);
+				pci_err(dev, "ignoring extra I/O range"
+					" for bridge %s\n", node->full_name);
 				continue;
 			}
 		} else {
 			if (i >= PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES) {
-				printk(KERN_ERR "PCI: too many memory ranges"
-				       " for bridge %s\n", node->full_name);
+				pci_err(dev, "too many memory ranges"
+					" for bridge %s\n", node->full_name);
 				continue;
 			}
 			res = bus->resource[i];
@@ -529,8 +530,8 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 		region.end = region.start + size - 1;
 
 		if (ofpci_verbose)
-			printk("      Using flags[%08x] start[%016llx] size[%016llx]\n",
-			       flags, start, size);
+			pci_info(dev, "      Using flags[%08x] start[%016llx] size[%016llx]\n",
+				 flags, start, size);
 
 		pcibios_bus_to_resource(dev->bus, res, &region);
 	}
@@ -538,7 +539,7 @@ static void of_scan_pci_bridge(struct pci_pbm_info *pbm,
 	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
 		bus->number);
 	if (ofpci_verbose)
-		printk("    bus name: %s\n", bus->name);
+		pci_info(dev, "    bus name: %s\n", bus->name);
 
 	pci_of_scan_bus(pbm, node, bus);
 }
@@ -553,14 +554,14 @@ static void pci_of_scan_bus(struct pci_pbm_info *pbm,
 	struct pci_dev *dev;
 
 	if (ofpci_verbose)
-		printk("PCI: scan_bus[%s] bus no %d\n",
-		       node->full_name, bus->number);
+		pci_info(bus, "scan_bus[%s] bus no %d\n",
+			 node->full_name, bus->number);
 
 	child = NULL;
 	prev_devfn = -1;
 	while ((child = of_get_next_child(node, child)) != NULL) {
 		if (ofpci_verbose)
-			printk("  * %s\n", child->full_name);
+			pci_info(bus, "  * %s\n", child->full_name);
 		reg = of_get_property(child, "reg", &reglen);
 		if (reg == NULL || reglen < 20)
 			continue;
@@ -581,8 +582,7 @@ static void pci_of_scan_bus(struct pci_pbm_info *pbm,
 		if (!dev)
 			continue;
 		if (ofpci_verbose)
-			printk("PCI: dev header type: %x\n",
-			       dev->hdr_type);
+			pci_info(dev, "dev header type: %x\n", dev->hdr_type);
 
 		if (pci_is_bridge(dev))
 			of_scan_pci_bridge(pbm, child, dev);
@@ -678,12 +678,8 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 				continue;
 
 			if (ofpci_verbose)
-				printk("PCI: Claiming %s: "
-				       "Resource %d: %016llx..%016llx [%x]\n",
-				       pci_name(dev), i,
-				       (unsigned long long)r->start,
-				       (unsigned long long)r->end,
-				       (unsigned int)r->flags);
+				pci_info(dev, "Claiming Resource %d: %pR\n",
+					 i, r);
 
 			pci_claim_resource(dev, i);
 		}
@@ -755,9 +751,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	}
 
 	if (cmd != oldcmd) {
-		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
-		       pci_name(dev), cmd);
-                /* Enable the appropriate bits in the PCI command register.  */
+		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
@@ -1117,8 +1111,8 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 	sp = prop->names;
 
 	if (ofpci_verbose)
-		printk("PCI: Making slots for [%s] mask[0x%02x]\n",
-		       node->full_name, mask);
+		pci_info(bus, "Making slots for [%s] mask[0x%02x]\n",
+			 node->full_name, mask);
 
 	i = 0;
 	while (mask) {
@@ -1131,12 +1125,12 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 		}
 
 		if (ofpci_verbose)
-			printk("PCI: Making slot [%s]\n", sp);
+			pci_info(bus, "Making slot [%s]\n", sp);
 
 		pci_slot = pci_create_slot(bus, i, sp, NULL);
 		if (IS_ERR(pci_slot))
-			printk(KERN_ERR "PCI: pci_create_slot returned %ld\n",
-			       PTR_ERR(pci_slot));
+			pci_err(bus, "pci_create_slot returned %ld\n",
+				PTR_ERR(pci_slot));
 
 		sp += strlen(sp) + 1;
 		mask &= ~this_bit;
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 9bb6a192ef3f..ca5fa4cc6dda 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -489,8 +489,8 @@ void pci_scan_for_target_abort(struct pci_pbm_info *pbm,
 				   PCI_STATUS_REC_TARGET_ABORT));
 		if (error_bits) {
 			pci_write_config_word(pdev, PCI_STATUS, error_bits);
-			printk("%s: Device %s saw Target Abort [%016x]\n",
-			       pbm->name, pci_name(pdev), status);
+			pci_info(pdev, "%s: Device saw Target Abort [%016x]\n",
+				 pbm->name, status);
 		}
 	}
 
@@ -512,8 +512,8 @@ void pci_scan_for_master_abort(struct pci_pbm_info *pbm,
 			(status & (PCI_STATUS_REC_MASTER_ABORT));
 		if (error_bits) {
 			pci_write_config_word(pdev, PCI_STATUS, error_bits);
-			printk("%s: Device %s received Master Abort [%016x]\n",
-			       pbm->name, pci_name(pdev), status);
+			pci_info(pdev, "%s: Device received Master Abort "
+				 "[%016x]\n", pbm->name, status);
 		}
 	}
 
@@ -536,8 +536,8 @@ void pci_scan_for_parity_error(struct pci_pbm_info *pbm,
 				   PCI_STATUS_DETECTED_PARITY));
 		if (error_bits) {
 			pci_write_config_word(pdev, PCI_STATUS, error_bits);
-			printk("%s: Device %s saw Parity Error [%016x]\n",
-			       pbm->name, pci_name(pdev), status);
+			pci_info(dev, "%s: Device saw Parity Error [%016x]\n",
+				 pbm->name, status);
 		}
 	}
 
diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index 1994d7638406..0820ad0dba13 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -191,8 +191,8 @@ static void sparc64_teardown_msi_irq(unsigned int irq,
 			break;
 	}
 	if (i >= pbm->msi_num) {
-		printk(KERN_ERR "%s: teardown: No MSI for irq %u\n",
-		       pbm->name, irq);
+		pci_err(pdev, "%s: teardown: No MSI for irq %u\n", pbm->name,
+			irq);
 		return;
 	}
 
@@ -201,9 +201,9 @@ static void sparc64_teardown_msi_irq(unsigned int irq,
 
 	err = ops->msi_teardown(pbm, msi_num);
 	if (err) {
-		printk(KERN_ERR "%s: teardown: ops->teardown() on MSI %u, "
-		       "irq %u, gives error %d\n",
-		       pbm->name, msi_num, irq, err);
+		pci_err(pdev "%s: teardown: ops->teardown() on MSI %u, "
+			"irq %u, gives error %d\n", pbm->name, msi_num, irq,
+			err);
 		return;
 	}
 
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 5b9244f328aa..fe268f891aed 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -518,10 +518,10 @@ static void pcic_map_pci_device(struct linux_pcic *pcic,
 				 * board in a PCI slot. We must remap it
 				 * under 64K but it is not done yet. XXX
 				 */
-				printk("PCIC: Skipping I/O space at 0x%lx, "
-				    "this will Oops if a driver attaches "
-				    "device '%s' at %02x:%02x)\n", address,
-				    namebuf, dev->bus->number, dev->devfn);
+				pci_info(dev, "PCIC: Skipping I/O space at "
+					 "0x%lx, this will Oops if a driver "
+					 "attaches device '%s'\n", address,
+					 namebuf);
 			}
 		}
 	}
@@ -551,8 +551,8 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 		p++;
 	}
 	if (i >= pcic->pcic_imdim) {
-		printk("PCIC: device %s devfn %02x:%02x not found in %d\n",
-		    namebuf, dev->bus->number, dev->devfn, pcic->pcic_imdim);
+		pci_info(dev, "PCIC: device %s not found in %d\n", namebuf,
+			 pcic->pcic_imdim);
 		dev->irq = 0;
 		return;
 	}
@@ -565,7 +565,7 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 		ivec = readw(pcic->pcic_regs+PCI_INT_SELECT_HI);
 		real_irq = ivec >> ((i-4) << 2) & 0xF;
 	} else {					/* Corrupted map */
-		printk("PCIC: BAD PIN %d\n", i); for (;;) {}
+		pci_info(dev, "PCIC: BAD PIN %d\n", i); for (;;) {}
 	}
 /* P3 */ /* printk("PCIC: device %s pin %d ivec 0x%x irq %x\n", namebuf, i, ivec, dev->irq); */
 
@@ -574,10 +574,10 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 	 */
 	if (real_irq == 0 || p->force) {
 		if (p->irq == 0 || p->irq >= 15) {	/* Corrupted map */
-			printk("PCIC: BAD IRQ %d\n", p->irq); for (;;) {}
+			pci_info(dev, "PCIC: BAD IRQ %d\n", p->irq); for (;;) {}
 		}
-		printk("PCIC: setting irq %d at pin %d for device %02x:%02x\n",
-		    p->irq, p->pin, dev->bus->number, dev->devfn);
+		pci_info(dev, "PCIC: setting irq %d at pin %d\n", p->irq,
+			 p->pin);
 		real_irq = p->irq;
 
 		i = p->pin;
@@ -610,7 +610,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	struct pcidev_cookie *pcp;
 
 	if (!pcic0_up) {
-		printk("pcibios_fixup_bus: no PCIC\n");
+		pci_info(bus, "pcibios_fixup_bus: no PCIC\n");
 		return;
 	}
 	pcic = &pcic0;
@@ -619,7 +619,8 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	 * Next crud is an equivalent of pbm = pcic_bus_to_pbm(bus);
 	 */
 	if (bus->number != 0) {
-		printk("pcibios_fixup_bus: nonzero bus 0x%x\n", bus->number);
+		pci_info(bus, "pcibios_fixup_bus: nonzero bus 0x%x\n",
+			 bus->number);
 		return;
 	}
 
@@ -664,9 +665,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	}
 
 	if (cmd != oldcmd) {
-		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
-		       pci_name(dev), cmd);
-                /* Enable the appropriate bits in the PCI command register.  */
+		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	return 0;
