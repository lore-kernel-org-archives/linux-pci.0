Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C49F51DB0A;
	Tue, 13 Oct 2026 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897516; cv=none; b=H4YFBGDdm0LjtpctRWlHwg4Z9wLnL6g6lRW1SG9hAxzDjghBmky2VVUoJo0nsAKVq5WeeJL5Wm/Nx9cyVEN8NW6S/roWwp7sjmEOd5ZQsa/7JU8m/h2z7DYU2TJc/SFXAQoIREvro9M6n+euGVaOC4+G4BXz2jHn1Naw1gyLIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897516; c=relaxed/simple;
	bh=JLmXJAUpn8RPgoWM5bnLhuyOy/NBQjmb+4qxyd6X9zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0SXZyhSiVq3nnmrmaLebqAcwztcJ4WqXCAFZ6ZhjN1WEd0URoJBAkp0ajwc7HfhBmeqNlNX0XB8C8qmgKVmo9mry3TMQ0f0s0J25kJoYvGwwxk8vlTnD1HR4k34sKUaHQqoMKXMWIaKxmXkP6J7TLWHfL7Jl90lNEB4dmPaA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnbXmhJB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnbXmhJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602141F00898;
	Tue, 13 Oct 2026 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897514;
	bh=4q4Cyrrf+CNq0JdmPGr1zzBjRyzKEoT8NlomPMO8iJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VnbXmhJBvfopBwUwY+Dsvqda2e7kcRz7gZPXbHqPZQJ8GHqCW2Hfvpy/7ldZRZYgj
	 GS+vUnnWSUeC17kt1Q5fTuYr6swuTcLur6IaARK4ldjwZdxL0J6CkqW+jOp3lxcM2h
	 mhvL9BxK1WrIP11fxd0DqqAV+BulKZa+G6SDoQWkZhTKxZPX2HixX+sIH3H9wpke4k
	 zBT0BmyvLGX6biRlZgnFHcB1U+7vUXXo4jHnexoavC/7G3C7O/NtI2BCZAKWkVwnb6
	 apDHbMp6+yIHzREhOF8vFpSr5O4iKzRrZPzMv8KHMqrdDIhm5FKb+2Lu2psPFpWxNT
	 7RmYRqH+ZfNnA==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 02/53] MIPS: PCI: xtalk-bridge: assign slots the PROM leaves unconfigured
Date: Tue, 13 Oct 2026 15:16:22 +0200
Message-ID: <938cb58f1db3a1272aff33a4d70ead1f711017ee.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PROM leaves some slots unassigned, such as an LSI SAS1064 or the bus
behind a PCI-to-PCI bridge, so their drivers cannot bind.  Map their devio
windows, borrowing an empty slot's for I/O when memory takes their own.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/pci/pci-xtalk-bridge.c | 192 +++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 9451b7546068..2fa9ac8d0a1c 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -619,6 +619,192 @@ static int bridge_get_partnum(u64 baddr, char *partnum)
 	return 0;
 }
 
+static unsigned long bridge_dev_space(struct pci_dev *pdev)
+{
+	unsigned long flags = 0;
+	struct resource *res;
+	int i;
+
+	pci_dev_for_each_resource(pdev, res, i)
+		if (i < PCI_ROM_RESOURCE && resource_size(res))
+			flags |= res->flags & (IORESOURCE_IO | IORESOURCE_MEM);
+
+	return flags;
+}
+
+static bool bridge_ppb_window(struct pci_dev *ppb, int idx,
+			      struct resource *win)
+{
+	struct resource *res = &ppb->resource[idx];
+
+	if (!win)
+		return false;
+	res->start = win->start;
+	res->end = win->end;
+	res->flags = win->flags;
+	if (request_resource(win, res))
+		return false;
+	pci_info(ppb, "bridge window %pR: assigned\n", res);
+	return true;
+}
+
+static void bridge_setup_ppb(struct pci_dev *ppb,
+			     struct xtalk_bridge_platform_data *bd,
+			     struct resource *io, struct resource *mem)
+{
+	u32 start, end;
+	u8 io_type;
+
+	pci_read_config_byte(ppb, PCI_IO_BASE, &io_type);
+	if (io && (io_type & PCI_IO_RANGE_TYPE_MASK) != PCI_IO_RANGE_TYPE_32) {
+		pci_warn(ppb, "no 32-bit I/O window\n");
+		io = NULL;
+	}
+	if (!bridge_ppb_window(ppb, PCI_BRIDGE_IO_WINDOW, io))
+		io = NULL;
+	if (!bridge_ppb_window(ppb, PCI_BRIDGE_MEM_WINDOW, mem))
+		mem = NULL;
+	if (!io && !mem)
+		return;
+
+	if (io) {
+		start = io->start - bd->io_offset;
+		end = io->end - bd->io_offset;
+		pci_write_config_dword(ppb, PCI_IO_BASE_UPPER16,
+				       (end & 0xffff0000) | (start >> 16));
+		pci_write_config_word(ppb, PCI_IO_BASE,
+				      (end & 0xf000) | (start >> 8 & 0xf0));
+	} else {
+		pci_write_config_dword(ppb, PCI_IO_BASE_UPPER16, 0);
+		pci_write_config_word(ppb, PCI_IO_BASE, 0x00f0);
+	}
+	if (mem) {
+		start = mem->start - bd->mem_offset;
+		end = mem->end - bd->mem_offset;
+		pci_write_config_dword(ppb, PCI_MEMORY_BASE,
+				       (end & 0xfff00000) | (start >> 16));
+	} else {
+		pci_write_config_dword(ppb, PCI_MEMORY_BASE, 0x0000fff0);
+	}
+	pci_write_config_dword(ppb, PCI_PREF_MEMORY_BASE, 0x0000fff0);
+	pci_write_config_dword(ppb, PCI_PREF_BASE_UPPER32, 0);
+	pci_write_config_dword(ppb, PCI_PREF_LIMIT_UPPER32, 0);
+
+	pci_bus_assign_resources(ppb->subordinate);
+}
+
+/* Map devio window @win, at its own address, in memory or I/O space. */
+static struct resource *bridge_map_devio(struct bridge_controller *bc,
+					 struct xtalk_bridge_platform_data *bd,
+					 struct device *dev, int win, bool mem)
+{
+	struct resource *root = mem ? &bd->mem : &bd->io;
+	resource_size_t offset = mem ? bd->mem_offset : bd->io_offset;
+	struct resource *res;
+	u32 devreg;
+
+	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return NULL;
+	res->name = "Bridge PCI slot";
+	res->start = root->start - BRIDGE_DEVIO0 + BRIDGE_DEVIO(win);
+	res->end = res->start + (win <= 1 ? BRIDGE_DEVIO_2MB :
+					    BRIDGE_DEVIO_1MB) - 1;
+	res->flags = root->flags;
+	if (devm_request_resource(dev, root, res))
+		return NULL;
+
+	devreg = bridge_read(bc, b_device[win].reg);
+	devreg &= ~(BRIDGE_DEV_OFF_MASK | BRIDGE_DEV_DEV_IO_MEM);
+	devreg |= (res->start - offset) >> BRIDGE_DEV_OFF_ADDR_SHFT;
+	if (mem)
+		devreg |= BRIDGE_DEV_DEV_IO_MEM;
+	bridge_write(bc, b_device[win].reg, devreg);
+	bridge_read(bc, b_wid_tflush);
+
+	return res;
+}
+
+/*
+ * A slot's BARs are reached only through a devio window, which Device(x)
+ * points at either PCI I/O or PCI memory space.  The PROM leaves some slots
+ * without resources, the secondary bus of a PCI-to-PCI bridge among them.
+ * Give such a slot its own window, in memory space if anything in the slot
+ * needs memory, and the window of a slot with no device for I/O space if
+ * it needs both: PIO through any devio window reaches every device on the
+ * bus.
+ */
+static void bridge_setup_slot(struct bridge_controller *bc,
+			      struct xtalk_bridge_platform_data *bd,
+			      struct device *dev, struct pci_bus *bus, int slot,
+			      unsigned long *busy)
+{
+	struct resource *res, *win, *io = NULL, *mem = NULL;
+	struct pci_dev *pdev, *child;
+	unsigned long flags = 0;
+	int i;
+
+	list_for_each_entry(pdev, &bus->devices, bus_list) {
+		if (PCI_SLOT(pdev->devfn) != slot)
+			continue;
+		pci_dev_for_each_resource(pdev, res)
+			if (res->parent)
+				return;
+		if (!pdev->subordinate)
+			flags |= bridge_dev_space(pdev);
+		else
+			list_for_each_entry(child, &pdev->subordinate->devices,
+					    bus_list)
+				flags |= bridge_dev_space(child);
+	}
+	if (!flags)
+		return;
+
+	if (flags & IORESOURCE_MEM)
+		mem = bridge_map_devio(bc, bd, dev, slot, true);
+	else
+		io = bridge_map_devio(bc, bd, dev, slot, false);
+	if (!io && !mem)
+		return;
+
+	if ((flags & IORESOURCE_IO) && !io) {
+		i = find_first_zero_bit(busy, bridge_nslots(bc));
+		if (i < bridge_nslots(bc)) {
+			__set_bit(i, busy);
+			io = bridge_map_devio(bc, bd, dev, i, false);
+		}
+		if (!io)
+			dev_warn(dev, "slot %d: no devio window for I/O space\n",
+				 slot);
+	}
+
+	list_for_each_entry(pdev, &bus->devices, bus_list) {
+		if (PCI_SLOT(pdev->devfn) != slot)
+			continue;
+		if (pdev->subordinate) {
+			bridge_setup_ppb(pdev, bd, io, mem);
+			continue;
+		}
+		pci_dev_for_each_resource(pdev, res, i) {
+			win = res->flags & IORESOURCE_MEM ? mem : io;
+			if (i >= PCI_ROM_RESOURCE || !win ||
+			    !(res->flags & win->flags) || !resource_size(res))
+				continue;
+			if (allocate_resource(win, res, resource_size(res),
+					      win->start, win->end,
+					      resource_alignment(res),
+					      NULL, NULL)) {
+				pci_warn(pdev, "BAR %d %pR: no space in slot\n",
+					 i, res);
+				continue;
+			}
+			res->flags &= ~IORESOURCE_UNSET;
+			pci_update_resource(pdev, i);
+			pci_info(pdev, "BAR %d %pR: assigned\n", i, res);
+		}
+	}
+}
+
 static int bridge_probe(struct platform_device *pdev)
 {
 	struct xtalk_bridge_platform_data *bd = dev_get_platdata(&pdev->dev);
@@ -627,6 +813,8 @@ static int bridge_probe(struct platform_device *pdev)
 	struct pci_host_bridge *host;
 	struct irq_domain *domain, *parent;
 	struct fwnode_handle *fn;
+	struct pci_dev *pcidev;
+	unsigned long busy = 0;
 	char partnum[26];
 	int slot;
 	int err;
@@ -734,6 +922,10 @@ static int bridge_probe(struct platform_device *pdev)
 		goto err_free_resource;
 
 	pci_bus_claim_resources(host->bus);
+	list_for_each_entry(pcidev, &host->bus->devices, bus_list)
+		__set_bit(PCI_SLOT(pcidev->devfn), &busy);
+	for (slot = 0; slot < bridge_nslots(bc); slot++)
+		bridge_setup_slot(bc, bd, dev, host->bus, slot, &busy);
 	pci_bus_add_devices(host->bus);
 
 	platform_set_drvdata(pdev, host->bus);
-- 
2.47.3

