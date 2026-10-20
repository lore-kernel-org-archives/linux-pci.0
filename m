Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499637;
	b=4fZwBp5OKSbFme7FES/Qvw9zIF/9GmRahlp7EvSvI3b71kyRdo5GXYxVx/l3K5EmLrPJ
	 NWPyHLX40CtCBDsi4WRUnlKOVMYc6QYJJ45R95Y7ICjomKcFdTZuaIkFHZAudHyYEHI7c
	 5QTFXlEdonSvr2L8eUB4VN0o2OdLDh0IAwPJZPQPNggM0m/4OpohaNHvgEkuSPjtw8T7L
	 P6nb52U8D7Huza6cVOe0PLrrSWl9jHYzwks5GnMbu9HH0RR5CxJ/6ycYlqmVAX63OL72B
	 H9JbnKihofr75B86dM5OIf5VfLk4lJKlNnNKAixvsaoaPAL1usJwLzIvrPF4HpTRPyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499637;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=FkTCIt2CM7eIS/YjiPAUEy1hHmvY8Dw9AWuqwbSza1I=;
	b=qwtjiKMZJGPTdAqsUbOqIo/Z3WBRCGjsVvgpwFun7LZbzjtqQkxjPY0zZet4JLjPDYLo
	 J78D4qPC7rfM/MCeSlbQRDbp1VF/RqigWS5UDiqYNTXx8+hVG84Q5rq3KNjJkdsbxznOT
	 NB2tdZ2VyUzt+NaUqPxELYWyic8Hjr2NL1o42mdFFEbcIwgAMIkQ8b+hYFHbkTJQ7VShD
	 cX1qF65qDBifYBJcZQNuiY1+2Q31uoLUYRcHDeA7GMCADkcl5AH5n9pq4qILI+NQzhdLc
	 no8WG2VWuWnkfcSHFtxLjgqfUTlypVsrEIysZFCW+jmyXMJBSTvzoEHdQGT2gd6Vl+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh4P9iyX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D6606A319;
	Tue, 20 Oct 2026 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh4P9iyX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0766A1F000C9;
	Tue, 20 Oct 2026 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792499636;
	bh=FkTCIt2CM7eIS/YjiPAUEy1hHmvY8Dw9AWuqwbSza1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qh4P9iyXXS2S4YmKsXValXHK2S+vFVF9p7QR4oxvfpWwnsclZaJ0QHqzEuyLO08U4
	 NYaw+fNB0/aHd2Y9NbDw5vx9kGDleBTwT5Q5AGjqsyH7sNWcgh88IVIQZGwf8rUFq1
	 qPKQf7LVGLJ2ythVBScJeK5HQYk4076EYKDUILKgi8nzbwk7nnp+LuG+S6GCEToHWU
	 MGs0VQcQ+GEB2GLQ4cQhnhtytZrzKu9m/nHtD9SISMQyIR4K/oPnUS/JA8x5WtxXls
	 gp35rtbbqSm4StrfFItu2Le1IYzQCj2v2pFEA5GA4+wxr93n78/0n5kLrwxEUNyMOC
	 AvtzkTG8uGhQA==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yue Wang <yue.wang@Amlogic.com>,
	Hans Zhang <18255117159@163.com>
Cc: Keith Busch <kbusch@kernel.org>,
	mx2pg@pm.me,
	Niklas Cassel <cassel@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Frank Li <Frank.Li@nxp.com>,
	Mahesh Vaidya <mahesh.vaidya@altera.com>,
	Ricardo Pardini <ricardo@pardini.net>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Jon Mason <jdmason@kudzu.us>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 2/3] PCI: Configure Root Port MPS after scanning its hierarchy
Date: Tue, 20 Oct 2026 14:28:56 +0200
Message-ID: <20261020122854.1500883-7-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020122854.1500883-5-cassel@kernel.org>
References: <20261020122854.1500883-5-cassel@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7763; i=cassel@kernel.org; h=from:subject; bh=ji6ry1d2xuy1erRTsPpOdrUaJqUyu2PtOcHOflXlwjI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKux7V3bAkSdtz8tPCJ3MNtd3a5Wqjt2Xsm40Dhst1VJ WFauX+2dZSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiMx0Z/icsTfdk9/HV29D6 7XD/y11rSybd2Zas87hqzpFLMzZ2ruBl+KeQNO0364W+kKzIvFKbFScdjv1W02bcdEUw58j5pwH Pc3gA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

With the default MPS strategy (PCIE_BUS_DEFAULT), pci_configure_mps()
only matches each device's Maximum Payload Size (MPS) to its upstream
bridge.  Root Ports have no upstream bridge, so their MPS stays at
whatever firmware or the hardware default (128 bytes) left there, and the
hierarchy below them inherits that value even if the Root Port and all
devices below it support more.

Once the hierarchy below a Root Port has been scanned, and before drivers
are bound, set the Root Port and every device below it to the largest MPS
they all support, even if that is more than firmware programmed.  Do this
from pcie_bus_configure_settings(), which the host bridge, ACPI and
hotplug paths call after scanning, and from pci_rescan_bus() and
pci_rescan_bus_bridge_resize(), which don't.

If the hierarchy contains a hotplug bridge other than the Root Port,
typically a Switch Downstream Port, limit it to 128 bytes instead, like
pcie_find_smpss() does for PCIE_BUS_SAFE: a device hot-added below such a
port later can't lower the MPS of a hierarchy in use, but every device
supports 128 bytes.  This costs throughput where firmware programmed a
larger MPS for such a hierarchy, in exchange for hot-added devices always
working.

An empty slot directly below a Root Port is left alone; it is evaluated
when a device is hot-added or rescanned there, which also allows raising
the Root Port again after a device that supported less has been replaced.
Hierarchies in which a device other than a Switch port may already have
a driver bound are never changed.  If the MPS of a device can't be set,
restore the previous MPS of the whole hierarchy rather than leaving it
with mismatched settings.

Since PCIE_BUS_DEFAULT can now raise MPS above what firmware programmed,
apply the Intel 5000/5100 read completion coalescing quirk to it as well.

The other strategies are unchanged: PCIE_BUS_TUNE_OFF doesn't touch MPS,
and PCIE_BUS_SAFE, PCIE_BUS_PERFORMANCE and PCIE_BUS_PEER2PEER already
configure the hierarchy in pcie_bus_configure_settings().

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Co-developed-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/probe.c  | 116 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c |   3 +-
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ccc3e9202c2c..ce3cd235a6a6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3102,6 +3102,115 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+struct pcie_mps_update {
+	int mps;
+	bool restore;
+	int err;
+};
+
+static int pcie_update_mps(struct pci_dev *dev, void *data)
+{
+	struct pcie_mps_update *update = data;
+	int ret;
+
+	/* MPS is of type 'RsvdP' for VFs */
+	if (!pci_is_pcie(dev) || dev->is_virtfn ||
+	    pcie_get_mps(dev) == update->mps)
+		return 0;
+
+	ret = pcie_set_mps(dev, update->mps);
+	if (!ret)
+		return 0;
+
+	pci_err(dev, "can't set Max Payload Size to %d\n", update->mps);
+	update->err = ret;
+
+	/* When restoring, keep going to restore as many devices as possible */
+	return update->restore ? 0 : ret;
+}
+
+/*
+ * Set the MPS of @rp and of every device below it to @mps, top-down.  Unless
+ * @restore is set, stop at the first device that can't be set and return its
+ * error, so the caller can restore the previous MPS.
+ */
+static int pcie_set_hierarchy_mps(struct pci_dev *rp, int mps, bool restore)
+{
+	struct pcie_mps_update update = { .mps = mps, .restore = restore };
+
+	if (!pcie_update_mps(rp, &update))
+		pci_walk_bus(rp->subordinate, pcie_update_mps, &update);
+
+	return update.err;
+}
+
+/*
+ * With PCIE_BUS_DEFAULT, pci_configure_mps() only matches each device to its
+ * upstream bridge, so a hierarchy inherits whatever MPS firmware, or the
+ * hardware default of 128 bytes, left in its Root Port.  Once the hierarchy
+ * below a Root Port has been enumerated, set it to the largest MPS that all
+ * of its devices support.
+ *
+ * A device hot-added below a hotplug bridge other than the Root Port can't
+ * lower the MPS once the hierarchy is in use, so limit such hierarchies to
+ * 128 bytes, which every device supports, like pcie_find_smpss() does for
+ * PCIE_BUS_SAFE.  A hotplug slot directly below the Root Port doesn't need
+ * this: it is evaluated when a device is hot-added there, and an empty slot
+ * is left alone until then.  Hierarchies are also left alone once any of
+ * their devices, other than Switch ports, may have a driver bound.
+ */
+static void pcie_bus_configure_default_mps(struct pci_bus *bus)
+{
+	struct pci_dev *rp = bus->self;
+	u8 smpss = rp->pcie_mpss;
+	int mps, old_mps;
+
+	if (pci_pcie_type(rp) != PCI_EXP_TYPE_ROOT_PORT ||
+	    list_empty(&bus->devices) || pci_bus_in_use(bus))
+		return;
+
+	pci_walk_bus(bus, pcie_find_smpss, &smpss);
+	mps = 128 << smpss;
+	old_mps = pcie_get_mps(rp);
+
+	/* Don't leave the hierarchy with mismatched MPS settings on failure */
+	if (pcie_set_hierarchy_mps(rp, mps, false)) {
+		pci_warn(rp, "can't set Max Payload Size of hierarchy to %d, restoring %d\n",
+			 mps, old_mps);
+		pcie_set_hierarchy_mps(rp, old_mps, true);
+		return;
+	}
+
+	if (mps != old_mps)
+		pci_info(rp, "Max Payload Size of hierarchy set to %d (was %d)\n",
+			 mps, old_mps);
+}
+
+/*
+ * A rescan doesn't go through pcie_bus_configure_settings(), so configure
+ * the Root Port hierarchies it may have populated here: every hierarchy
+ * below a rescanned root bus, or the one @bus belongs to.
+ */
+static void pcie_rescan_configure_default_mps(struct pci_bus *bus)
+{
+	struct pci_bus *child;
+	struct pci_dev *rp;
+
+	if (pcie_bus_config != PCIE_BUS_DEFAULT)
+		return;
+
+	if (pci_is_root_bus(bus)) {
+		list_for_each_entry(child, &bus->children, node)
+			if (child->self && pci_is_pcie(child->self))
+				pcie_bus_configure_default_mps(child);
+		return;
+	}
+
+	rp = pcie_find_root_port(bus->self);
+	if (rp && rp->subordinate)
+		pcie_bus_configure_default_mps(rp->subordinate);
+}
+
 /*
  * pcie_bus_configure_settings() requires that pci_walk_bus work in a top-down,
  * parents then children fashion.  If this changes, then this code will not
@@ -3117,6 +3226,11 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
 	if (!pci_is_pcie(bus->self))
 		return;
 
+	if (pcie_bus_config == PCIE_BUS_DEFAULT) {
+		pcie_bus_configure_default_mps(bus);
+		return;
+	}
+
 	/*
 	 * FIXME - Peer to peer DMA is possible, though the endpoint would need
 	 * to be aware of the MPS of the destination.  To work around this,
@@ -3555,6 +3669,7 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 	max = pci_scan_child_bus(bus);
 
 	pci_assign_unassigned_bridge_resources(bridge);
+	pcie_rescan_configure_default_mps(bus);
 
 	pci_bus_add_devices(bus);
 
@@ -3576,6 +3691,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 
 	max = pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+	pcie_rescan_configure_default_mps(bus);
 	pci_bus_add_devices(bus);
 
 	return max;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f1e6566542a4..31cbe7e91bb1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3477,8 +3477,7 @@ static void quirk_intel_mc_errata(struct pci_dev *dev)
 	int err;
 	u16 rcc;
 
-	if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
-	    pcie_bus_config == PCIE_BUS_DEFAULT)
+	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
 		return;
 
 	/*
-- 
2.56.0

