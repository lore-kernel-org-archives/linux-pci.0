Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80F51DE1F;
	Tue, 13 Oct 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897522; cv=none; b=n78W7OFlFovBjfReFonjYnR+sJ/jKcVBQ3Y1eEcbxgW8Cdzxhf2/eCg9GnXox8q/o6zQC0pD9AHjbkRxzv0QBaOr7O+hlbR+Q/YqKDnLiF++DpKDHCwY+bHeT4GTUDqfZiepVJl2vSs8lYPPEl6jyh1qiGDnUJER/QtvAJ2p5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897522; c=relaxed/simple;
	bh=8JYtipmOiygcDVvIiUY5DS33eVAgzuoSTxN6j6Q93K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTnziySzCSFXDGTVFJ3xgBof5NTpoLJTDk4MMgqrYgtwv03yVAN/6qW8pFEbpn3fNwDQi1eS5tjwtz4krVMTn/W15Pzmj6z3DXx29rJId/KjPgQVcYztZ07T2ObBnJiXRMvMlH3Jljm+6XSJcgAacxF+Ez8hi3CtCyk8ykvIaEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmFEIBlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmFEIBlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B921F000FF;
	Tue, 13 Oct 2026 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897521;
	bh=GhrAiFfq5qsCITVKUtlLsiPtqQ8GQ4ekFMQMwjn+lQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bmFEIBlkdTWDlfOD5fM2Brz92cSZ2id1vup1bZczYJp5wfGcoYIoDJi9jnp0v2NXz
	 fej2CtW/WhXTFPzElscfGL+1CAsgq3gRsAgUTDyiVAS4eTyfIqBygAKl6/PvkJ9PnV
	 tvX8QQsGWRpnfadNKoV7rTIaQmvXyoH4qtxJV6K/RmUxkS7THksAKGIcZNZtq4Xpp/
	 wayRqSnnX7cIeOzT3qgxnonC9t9NA3UCTRMGAPRRehP1TM47PGTmb4d9TI7BKBH6o4
	 dtG7z/qcVX5v9Vsp9ipHSK1FrXMRxFxdGUAHYE88ffL8W3fWGPNoGNn7OeAeM5N7cQ
	 5FmBXejjD6OpA==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 05/53] MIPS: PCI: xtalk-bridge: reassign slots whose devio window maps elsewhere
Date: Tue, 13 Oct 2026 15:16:25 +0200
Message-ID: <c9b11207110efb9df3663aafed9fe900658b104b.1791890466.git.kaloz@kernel.org>
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

The PROM may point the devio window covering a BAR elsewhere. On an
Octane, window 2 maps the IOC3 while the RAD1 BAR sits in it, so RAD1
writes land in the IOC3. Reassign such slots like unconfigured ones.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/pci/pci-xtalk-bridge.c | 58 ++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 16c1ac2c2551..8b56c754245d 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -730,6 +730,63 @@ static struct resource *bridge_map_devio(struct bridge_controller *bc,
 	return res;
 }
 
+/*
+ * Linux reaches a BAR through the devio window at the BAR's own address, but
+ * the PROM may point that window elsewhere: an Octane's window 2 maps the IOC3
+ * at 0x500000 while the RAD1 BAR sits at 0x600000.  Only the offset matters;
+ * the PROM puts a slot's I/O and memory BARs at one address and maps the
+ * window for memory.
+ */
+static bool bridge_devio_reaches(struct bridge_controller *bc,
+				 struct xtalk_bridge_platform_data *bd,
+				 struct resource *res)
+{
+	resource_size_t base = bd->mem.start - BRIDGE_DEVIO0;
+	resource_size_t offset = res->flags & IORESOURCE_IO ? bd->io_offset :
+							      bd->mem_offset;
+	resource_size_t addr = res->start;
+	u32 off;
+	int win;
+
+	while (addr <= res->end) {
+		addr -= base;
+		win = addr < BRIDGE_DEVIO2 ?
+		      (addr - BRIDGE_DEVIO0) / BRIDGE_DEVIO_2MB :
+		      2 + (addr - BRIDGE_DEVIO2) / BRIDGE_DEVIO_1MB;
+		if (win >= bridge_nslots(bc))
+			return false;
+		off = bridge_read(bc, b_device[win].reg) & BRIDGE_DEV_OFF_MASK;
+		if (off != (base + BRIDGE_DEVIO(win) - offset) >>
+			   BRIDGE_DEV_OFF_ADDR_SHFT)
+			return false;
+		addr = base + BRIDGE_DEVIO(win + 1);
+	}
+
+	return true;
+}
+
+/* Release slots with a BAR Linux cannot reach, for bridge_setup_slot(). */
+static void bridge_release_unreached(struct bridge_controller *bc,
+				     struct xtalk_bridge_platform_data *bd,
+				     struct pci_bus *bus)
+{
+	unsigned long unreached = 0;
+	struct pci_dev *pdev;
+	struct resource *res;
+	int i;
+
+	list_for_each_entry(pdev, &bus->devices, bus_list)
+		pci_dev_for_each_resource(pdev, res)
+			if (res->parent && !pdev->subordinate &&
+			    !bridge_devio_reaches(bc, bd, res))
+				__set_bit(PCI_SLOT(pdev->devfn), &unreached);
+
+	list_for_each_entry(pdev, &bus->devices, bus_list)
+		if (test_bit(PCI_SLOT(pdev->devfn), &unreached))
+			pci_dev_for_each_resource(pdev, res, i)
+				pci_release_resource(pdev, i);
+}
+
 /*
  * A slot's BARs are reached only through a devio window, which Device(x)
  * points at either PCI I/O or PCI memory space.  The PROM leaves some slots
@@ -929,6 +986,7 @@ static int bridge_probe(struct platform_device *pdev)
 	pci_bus_claim_resources(host->bus);
 	list_for_each_entry(pcidev, &host->bus->devices, bus_list)
 		__set_bit(PCI_SLOT(pcidev->devfn), &busy);
+	bridge_release_unreached(bc, bd, host->bus);
 	for (slot = 0; slot < bridge_nslots(bc); slot++)
 		bridge_setup_slot(bc, bd, dev, host->bus, slot, &busy);
 	pci_bus_add_devices(host->bus);
-- 
2.47.3

