Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB23BB100;
	Wed, 30 Sep 2026 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779856; cv=none; b=cjDnYysllBR8GMsTdvE63E3RJeBo6YP0ylLGprKNofthafAeenBlHXSXj/JZ2nUELSRSpl8Gc4qSYDD52SRCZEOENZHcd1mhDoGkJBdD1LyWEKMqkcETXZjx9GiVAANDgnjBtUm3zNk8exOjMASxq6pquU/dJVn2pZ+DywbFm8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779856; c=relaxed/simple;
	bh=HFUU72rF2I+ZOsd+sEY/LlyKiP4iGFfKJvkVITxGLEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi9BajQ/cxPQ5hOvg6dG0lWjwCx9ZYOQ8+6+fJ0ZK6O0DMTVlkCWecRc2hw4JhQgqea6XRFw7Av6KxstBYTEkzKGclMoSRMQkEhb609ywCF5nqtJEKwFkUUSNSdXPqJXmVppEDrz4bJdzSCjVex7NKO6kr3oOq91v44EgbZ1Acg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoMGnAJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoMGnAJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E421F00893;
	Wed, 30 Sep 2026 14:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779851;
	bh=P/YXD0eThUuuTt4F9igzSS8LTHnkxXyp0Ys+DH4Vt5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eoMGnAJAT7k9Q/W+puZ7sbOAekBcynoxY8SGLfp+BhlNyPGzwX6s0JQaPFILE5sr7
	 r/by7vIrFqNA1p+cFtZopIrD+1u5xzY9MXXd51xU2kIib6sYko/t5jbcSnUy59L7j3
	 A2Z5jsM6jaYc5znlSktL3bmHlMTsFtXiU1ySfb6FtwG9Le7engpqaLXWM5LTYbx3Ku
	 ffI7rgzoYOYuSUGi6WXs6FRps1IKmewiM2YyLiw3K19WvS5u77vmHXcdN9WNuCxZ6g
	 7ly1YMud9kd6t7XMCipT9RwL9cUSjcmE/8rVnnbjI26G1GzOGeRE44dxrz9mNh6jN2
	 N6SxT7h/XGX2g==
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
	dlemoal@kernel.org,
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
Subject: [RFC PATCH 3/4] PCI: Configure Root Port MPS after scanning its hierarchy
Date: Wed, 30 Sep 2026 16:50:20 +0200
Message-ID: <20260930145017.1356088-9-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930145017.1356088-6-cassel@kernel.org>
References: <20260930145017.1356088-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6471; i=cassel@kernel.org; h=from:subject; bh=HFUU72rF2I+ZOsd+sEY/LlyKiP4iGFfKJvkVITxGLEE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLL2Kq7Klj2e7y+kwi75nvMij9gfJY6sXqtEyx6TR5H2/ QuO3LjVUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIkoFDL8D2Eqr3qUHNf9zz65 jfnz0Yx181VVjuzMctd/z5S54p9uIiND36wPTy8snVM5285ucqtwr1v84TWla9N1upfOZVpzcnM XCwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

With the default MPS strategy (PCIE_BUS_DEFAULT), pci_configure_mps()
only matches each device's Maximum Payload Size (MPS) to its upstream
bridge.  Root Ports have no upstream bridge, so their MPS stays at
whatever firmware or the hardware default (128 bytes) left there, and the
hierarchy below them inherits that value even if the Root Port and all
devices below it support more.

Once the hierarchy below a Root Port has been scanned, and before drivers
are bound, raise the Root Port and every device below it to the largest
MPS they all support.  Do this from pcie_bus_configure_settings(), which
the host bridge, ACPI and hotplug paths call after scanning, and from
pci_rescan_bus() and pci_rescan_bus_bridge_resize(), which don't.

Leave a hierarchy alone if it contains a hotplug bridge other than the
Root Port, typically a Switch Downstream Port: a device hot-added below it
later can't lower the MPS of a hierarchy in use, so keep the MPS the
hierarchy already had.  pcie_find_smpss() already returns the minimum MPS
for such hierarchies, which never raises anything.  Don't raise an empty
slot directly below a Root Port either; it is evaluated when a device is
hot-added or rescanned there, which also allows raising the Root Port
again after a device that supported less has been replaced.  Hierarchies
with devices that may already have a driver bound are never changed.

Since PCIE_BUS_DEFAULT can now raise MPS above what firmware programmed,
apply the Intel 5000/5100 read completion coalescing quirk to it as well.

The other strategies are unchanged: PCIE_BUS_TUNE_OFF doesn't touch MPS,
and PCIE_BUS_SAFE, PCIE_BUS_PERFORMANCE and PCIE_BUS_PEER2PEER already
configure the hierarchy in pcie_bus_configure_settings().

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Co-developed-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
Assisted-by: LLM
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/probe.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c |  3 +-
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d8e58e5ef730..5f37b480b51d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3083,6 +3083,82 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+static int pcie_raise_mps(struct pci_dev *dev, void *data)
+{
+	int mps = *(int *)data;
+
+	/* MPS is of type 'RsvdP' for VFs */
+	if (!pci_is_pcie(dev) || dev->is_virtfn)
+		return 0;
+
+	if (pcie_get_mps(dev) < mps && pcie_set_mps(dev, mps))
+		pci_err(dev, "can't set Max Payload Size to %d\n", mps);
+
+	return 0;
+}
+
+/*
+ * With PCIE_BUS_DEFAULT, pci_configure_mps() only matches each device to its
+ * upstream bridge, so a hierarchy inherits whatever MPS firmware, or the
+ * hardware default of 128 bytes, left in its Root Port.  Once the hierarchy
+ * below a Root Port has been enumerated, raise it to the largest MPS that all
+ * of its devices support.
+ *
+ * Leave hierarchies with a hotplug bridge other than the Root Port alone: a
+ * device hot-added below it can't lower the MPS once the hierarchy is in use.
+ * pcie_find_smpss() returns the minimum MPS for such hierarchies, which never
+ * raises anything.  A hotplug slot directly below the Root Port is fine: it
+ * is evaluated when a device is hot-added there, and an empty slot is not
+ * raised, so a Switch hot-added into it doesn't inherit a raised MPS.  Also
+ * leave hierarchies alone once any of their devices may have a driver bound.
+ */
+static void pcie_bus_raise_default_mps(struct pci_bus *bus)
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
+	if (mps <= old_mps)
+		return;
+
+	pcie_raise_mps(rp, &mps);
+	pci_walk_bus(bus, pcie_raise_mps, &mps);
+	pci_info(rp, "Max Payload Size of hierarchy set to %d (was %d)\n",
+		 mps, old_mps);
+}
+
+/*
+ * A rescan doesn't go through pcie_bus_configure_settings(), so give the Root
+ * Port hierarchies it may have populated the same chance to be raised: every
+ * hierarchy below a rescanned root bus, or the one @bus belongs to.
+ */
+static void pcie_rescan_raise_default_mps(struct pci_bus *bus)
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
+				pcie_bus_raise_default_mps(child);
+		return;
+	}
+
+	rp = pcie_find_root_port(bus->self);
+	if (rp && rp->subordinate)
+		pcie_bus_raise_default_mps(rp->subordinate);
+}
+
 /*
  * pcie_bus_configure_settings() requires that pci_walk_bus work in a top-down,
  * parents then children fashion.  If this changes, then this code will not
@@ -3098,6 +3174,11 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
 	if (!pci_is_pcie(bus->self))
 		return;
 
+	if (pcie_bus_config == PCIE_BUS_DEFAULT) {
+		pcie_bus_raise_default_mps(bus);
+		return;
+	}
+
 	/*
 	 * FIXME - Peer to peer DMA is possible, though the endpoint would need
 	 * to be aware of the MPS of the destination.  To work around this,
@@ -3536,6 +3617,7 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 	max = pci_scan_child_bus(bus);
 
 	pci_assign_unassigned_bridge_resources(bridge);
+	pcie_rescan_raise_default_mps(bus);
 
 	pci_bus_add_devices(bus);
 
@@ -3557,6 +3639,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 
 	max = pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+	pcie_rescan_raise_default_mps(bus);
 	pci_bus_add_devices(bus);
 
 	return max;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..da171f4babe4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3452,8 +3452,7 @@ static void quirk_intel_mc_errata(struct pci_dev *dev)
 	int err;
 	u16 rcc;
 
-	if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
-	    pcie_bus_config == PCIE_BUS_DEFAULT)
+	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
 		return;
 
 	/*
-- 
2.55.0

