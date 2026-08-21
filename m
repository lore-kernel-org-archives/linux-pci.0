Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D940F8FC;
	Fri, 21 Aug 2026 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341349; cv=none; b=OdDhgcGHwtIOOjaLPZnZiLP/P7EKmaaLTZvEaEeb/gbsUljreISQNDdUvGXHpqXAiQEpOBX7B4hiUyCfqkrd7vIiC8KarwTPagju6DhKZh3PonLY9p0P2Z3oLCxlfxIhBhI1/J2T0KoxTceBg8DDXLly+O2KZzXtQHQSrifToFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341349; c=relaxed/simple;
	bh=dbY9tECRR/fAgtGttei7/xNCi6AEqHoF1K0X812ZmbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCj8ZZdlUjBbXTPCFsoY2hIr2Sbx4kPDE2uvz8ARD2so6ZiveOFTyivgr5XwrHki3w/VkeFVvj6Iw1fg6NFuubNoB1nHyolNQhpX46paIurSLJq3epcQ5k22HLYpDJVgOYMCOLTCJB6TliHJajWKCLeBmCAziN3tj/wuAyVuQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaTzDMI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaTzDMI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78ABC1F000E9;
	Fri, 21 Aug 2026 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341347;
	bh=Uf9VTVySSnn2wuBKKDYb1/e54iqEGIrAPjWZWAc3m30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LaTzDMI89VmN9LdaCcQd0QwynaV/K/7+LoVC+dew3fb6ElygjnhFjsK9AKd6wF7Qw
	 nZJCJ+c5i65lXXhg6Er6bNb39bTREWBl+CIDB83BKs3ssOTXnxHpjy+RJRbeBFUwa9
	 jkgCNp1uYsyCPE+6kR1dSCkf1KEloYLkCK8++JvSk9uSSjlB+5ga/1ADFi13TBAgtd
	 VfIglcQaabf1DTraNQ1KdiuzUbRxP/lD1R1zPi9vIkQZCpdpmPPyuxb1QcyKn1bQEl
	 +1aGnUDIcvOMM3R6BijK/K6fXya/pK4WgnJq1etEsIwE1IdPZWr0NRE4x1R1FY/OJS
	 4QCzyED5hOyBw==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>
Subject: [PATCH v4 16/18] PCI/P2PDMA: Add KUnit coverage for the ACS P2P routing walk
Date: Fri, 21 Aug 2026 22:38:47 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-16-94426b96de73@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

calc_map_type_and_dist() must apply Request controls to the client-side
divergence port and Completion controls to the provider-side port. Pure
helper tests cannot verify that topology assignment.

Build a nested fake PCIe switch fabric and exercise the full walk. Cover
direct routing, Request and Completion redirects, Egress Control outcomes,
and the asymmetric provider-RR/client-CR configuration. Also verify that
redirect bits below the divergence do not affect the direct path and an ACS
Violation without a redirect is rejected.

Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c       |   3 +-
 drivers/pci/pci.h          |   4 +
 drivers/pci/pci_acs_test.c | 295 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 301 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 632f2d8c51e0..e54901d21d8a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -784,7 +784,7 @@ static unsigned long map_types_idx(struct pci_dev *client)
  * ports per above. If the device is not in the whitelist, return
  * PCI_P2PDMA_MAP_NOT_SUPPORTED.
  */
-static enum pci_p2pdma_map_type
+VISIBLE_IF_KUNIT enum pci_p2pdma_map_type
 calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool verbose)
 {
@@ -916,6 +916,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	rcu_read_unlock();
 	return map_type;
 }
+EXPORT_SYMBOL_IF_KUNIT(calc_map_type_and_dist);
 
 /**
  * pci_p2pdma_distance_many - Determine the cumulative distance between
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4593fb43f96c..4d0f4478158f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -6,6 +6,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
 #include <trace/events/pci.h>
 
 struct pcie_tlp_log;
@@ -1101,6 +1102,9 @@ bool pci_acs_egress_port_valid(u16 acs_caps, u8 target_port);
 enum pci_acs_p2pdma_state
 pci_acs_p2pdma_decision(u16 ctrl, enum pci_acs_p2pdma_tlp tlp,
 			bool has_target, int egress);
+enum pci_p2pdma_map_type calc_map_type_and_dist(struct pci_dev *provider,
+						struct pci_dev *client,
+						int *dist, bool verbose);
 #endif
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags,
diff --git a/drivers/pci/pci_acs_test.c b/drivers/pci/pci_acs_test.c
index aec7d7636f70..dd1054bb4f09 100644
--- a/drivers/pci/pci_acs_test.c
+++ b/drivers/pci/pci_acs_test.c
@@ -10,6 +10,7 @@
 #include <kunit/test.h>
 
 #include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
 #include <linux/pci_regs.h>
 
 #include "pci.h"
@@ -416,6 +417,292 @@ static void acs_egress_root_port_test(struct kunit *test)
 			1);
 }
 
+/*
+ * calc_map_type_and_dist(): drive the full provider->client hierarchy walk
+ * over a fabricated PCIe fabric matching the canonical "two devices behind one
+ * switch" tree:
+ *
+ *   host bridge / root bus
+ *     Root Port
+ *       Switch Upstream Port
+ *         Switch Downstream Port 0
+ *           Nested Switch -- provider
+ *         Switch Downstream Port 1
+ *           Nested Switch -- client
+ *
+ * A fake pci_ops answers the ACS Control, Egress Control Vector and LNKCAP
+ * reads for the downstream ports, so the ACS Egress Control evaluated at the
+ * path divergence (Downstream Port 1 targeting Downstream Port 0) decides the
+ * mapping without any real hardware.
+ */
+
+struct acs_dn_cfg {
+	u16	acs_ctrl;		/* ACS Control register value */
+	u8	port;			/* this port's LNKCAP Port Number */
+	u32	egress[8];		/* Egress Control Vector (256 bits) */
+};
+
+struct acs_fabric {
+	struct pci_dev		*provider;
+	struct pci_dev		*client;
+	struct pci_dev		*dn0;	/* Downstream Port 0 (provider side) */
+	struct pci_dev		*dn1;	/* Downstream Port 1 (client side) */
+	struct pci_dev		*provider_leaf;
+	struct pci_dev		*client_leaf;
+	struct acs_dn_cfg	dn0_cfg;
+	struct acs_dn_cfg	dn1_cfg;
+	struct acs_dn_cfg	provider_leaf_cfg;
+	struct acs_dn_cfg	client_leaf_cfg;
+};
+
+static void acs_dn_read(struct pci_dev *dn, struct acs_dn_cfg *c,
+			int where, int size, u32 *val)
+{
+	int vec = dn->acs_cap + PCI_ACS_EGRESS_CTL_V;
+
+	if (size == 4 && where == dn->pcie_cap + PCI_EXP_LNKCAP)
+		*val = FIELD_PREP(PCI_EXP_LNKCAP_PN, c->port);
+	else if (dn->acs_cap && size == 2 && where == dn->acs_cap + PCI_ACS_CTRL)
+		*val = c->acs_ctrl;
+	else if (dn->acs_cap && size == 4 &&
+		 where >= vec && where < vec + (int)sizeof(c->egress))
+		*val = c->egress[(where - vec) / 4];
+}
+
+static int acs_fabric_read(struct pci_bus *bus, unsigned int devfn,
+			   int where, int size, u32 *val)
+{
+	struct acs_fabric *f = bus->sysdata;
+
+	*val = 0;
+	if (bus == f->dn0->bus && devfn == f->dn0->devfn)
+		acs_dn_read(f->dn0, &f->dn0_cfg, where, size, val);
+	else if (bus == f->dn1->bus && devfn == f->dn1->devfn)
+		acs_dn_read(f->dn1, &f->dn1_cfg, where, size, val);
+	else if (bus == f->provider_leaf->bus &&
+		 devfn == f->provider_leaf->devfn)
+		acs_dn_read(f->provider_leaf, &f->provider_leaf_cfg, where,
+			    size, val);
+	else if (bus == f->client_leaf->bus &&
+		 devfn == f->client_leaf->devfn)
+		acs_dn_read(f->client_leaf, &f->client_leaf_cfg, where, size,
+			    val);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int acs_fabric_write(struct pci_bus *bus, unsigned int devfn,
+			    int where, int size, u32 val)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops acs_fabric_ops = {
+	.read	= acs_fabric_read,
+	.write	= acs_fabric_write,
+};
+
+static struct pci_bus *acs_add_bus(struct kunit *test, struct pci_bus *parent,
+				   struct pci_dev *self, u8 nr, void *sysdata)
+{
+	struct pci_bus *bus = kunit_kzalloc(test, sizeof(*bus), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, bus);
+	bus->parent = parent;
+	bus->self = self;
+	bus->number = nr;
+	bus->ops = &acs_fabric_ops;
+	bus->sysdata = sysdata;
+	INIT_LIST_HEAD(&bus->devices);
+	return bus;
+}
+
+static struct pci_dev *acs_add_dev(struct kunit *test, struct pci_bus *bus,
+				   unsigned int devfn, int pcie_type)
+{
+	struct pci_dev *dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, dev);
+	dev->bus = bus;
+	dev->devfn = devfn;
+	dev->pcie_cap = 0x40;
+	dev->pcie_flags_reg = ACS_TEST_PCIE_FLAGS(pcie_type);
+	list_add_tail(&dev->bus_list, &bus->devices);
+	return dev;
+}
+
+static void acs_build_fabric(struct kunit *test, struct acs_fabric *f)
+{
+	struct pci_bus *bus0, *bus1, *bus2, *bus3, *bus4, *bus5, *bus6;
+	struct pci_bus *bus7, *bus8;
+	struct pci_dev *rootport, *swup, *provider_swup, *client_swup;
+	struct pci_host_bridge *host;
+
+	host = kunit_kzalloc(test, sizeof(*host), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, host);
+
+	bus0 = acs_add_bus(test, NULL, NULL, 0, f);		/* root bus */
+	/* The Root Port doubles as the whitelisted host-bridge device. */
+	rootport = acs_add_dev(test, bus0, PCI_DEVFN(0, 0),
+			       PCI_EXP_TYPE_ROOT_PORT);
+	rootport->vendor = PCI_VENDOR_ID_GOOGLE;
+	rootport->device = 0x1234;
+	host->bus = bus0;
+	bus0->bridge = &host->dev;
+
+	bus1 = acs_add_bus(test, bus0, rootport, 1, f);
+	swup = acs_add_dev(test, bus1, PCI_DEVFN(0, 0), PCI_EXP_TYPE_UPSTREAM);
+
+	bus2 = acs_add_bus(test, bus1, swup, 2, f);
+	f->dn0 = acs_add_dev(test, bus2, PCI_DEVFN(0, 0), PCI_EXP_TYPE_DOWNSTREAM);
+	f->dn1 = acs_add_dev(test, bus2, PCI_DEVFN(1, 0), PCI_EXP_TYPE_DOWNSTREAM);
+
+	bus3 = acs_add_bus(test, bus2, f->dn0, 3, f);
+	provider_swup = acs_add_dev(test, bus3, PCI_DEVFN(0, 0),
+				    PCI_EXP_TYPE_UPSTREAM);
+	bus5 = acs_add_bus(test, bus3, provider_swup, 5, f);
+	f->provider_leaf = acs_add_dev(test, bus5, PCI_DEVFN(0, 0),
+				       PCI_EXP_TYPE_DOWNSTREAM);
+	bus7 = acs_add_bus(test, bus5, f->provider_leaf, 7, f);
+	f->provider = acs_add_dev(test, bus7, PCI_DEVFN(0, 0),
+				  PCI_EXP_TYPE_ENDPOINT);
+
+	bus4 = acs_add_bus(test, bus2, f->dn1, 4, f);
+	client_swup = acs_add_dev(test, bus4, PCI_DEVFN(0, 0),
+				  PCI_EXP_TYPE_UPSTREAM);
+	bus6 = acs_add_bus(test, bus4, client_swup, 6, f);
+	f->client_leaf = acs_add_dev(test, bus6, PCI_DEVFN(0, 0),
+				     PCI_EXP_TYPE_DOWNSTREAM);
+	bus8 = acs_add_bus(test, bus6, f->client_leaf, 8, f);
+	f->client = acs_add_dev(test, bus8, PCI_DEVFN(0, 0),
+				PCI_EXP_TYPE_ENDPOINT);
+}
+
+static enum pci_p2pdma_map_type acs_walk_map(struct acs_fabric *f)
+{
+	int dist;
+
+	return calc_map_type_and_dist(f->provider, f->client, &dist, false);
+}
+
+static void acs_walk_bus_addr_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	/* No ACS on the path: peer-to-peer is allowed directly. */
+	KUNIT_EXPECT_EQ(test, acs_walk_map(&f), PCI_P2PDMA_MAP_BUS_ADDR);
+}
+
+static void acs_walk_ec_violation_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	/*
+	 * Client Downstream Port 1 has Egress Control enabled with the vector bit
+	 * for provider Downstream Port 0 set and Request Redirect clear: an ACS
+	 * Violation. The direct path is unusable, and no redirect establishes an
+	 * upstream route.
+	 */
+	f.dn1->acs_cap = 0x100;
+	f.dn1->acs_capabilities = PCI_ACS_EC | (64 << 8);
+	f.dn1_cfg.acs_ctrl = PCI_ACS_EC;
+	f.dn0_cfg.port = 5;
+	f.dn1_cfg.egress[0] = BIT(5);
+
+	KUNIT_EXPECT_EQ(test, acs_walk_map(&f),
+			PCI_P2PDMA_MAP_NOT_SUPPORTED);
+}
+
+static void acs_walk_ec_vector_clear_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	/* Egress Control enabled but the provider vector bit is clear. */
+	f.dn1->acs_cap = 0x100;
+	f.dn1->acs_capabilities = PCI_ACS_EC | (64 << 8);
+	f.dn1_cfg.acs_ctrl = PCI_ACS_EC;
+	f.dn0_cfg.port = 5;		/* egress vector left all-zero */
+
+	KUNIT_EXPECT_EQ(test, acs_walk_map(&f), PCI_P2PDMA_MAP_BUS_ADDR);
+}
+
+static void acs_walk_request_redirect_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	/* Client Request Redirect sends traffic through the host bridge. */
+	f.dn1->acs_cap = 0x100;
+	f.dn1->acs_capabilities = PCI_ACS_RR;
+	f.dn1_cfg.acs_ctrl = PCI_ACS_RR;
+
+	/* The Google root port is whitelisted, so the host-bridge path is OK. */
+	KUNIT_EXPECT_EQ(test, acs_walk_map(&f),
+			PCI_P2PDMA_MAP_THRU_HOST_BRIDGE);
+}
+
+static void acs_walk_completion_redirect_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	/* Provider Completion Redirect sends traffic through the host bridge. */
+	f.dn0->acs_cap = 0x100;
+	f.dn0->acs_capabilities = PCI_ACS_CR;
+	f.dn0_cfg.acs_ctrl = PCI_ACS_CR;
+
+	/* The Google root port is whitelisted, so the host-bridge path is OK. */
+	KUNIT_EXPECT_EQ(test, acs_walk_map(&f),
+			PCI_P2PDMA_MAP_THRU_HOST_BRIDGE);
+}
+
+static void acs_walk_asymmetric_direct_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	/* Provider RR/EC and client CR act on the reverse transaction paths. */
+	f.dn0->acs_cap = 0x100;
+	f.dn0->acs_capabilities = PCI_ACS_RR | PCI_ACS_EC | (64 << 8);
+	f.dn0_cfg.acs_ctrl = PCI_ACS_RR | PCI_ACS_EC;
+	f.dn1_cfg.port = 6;
+	f.dn0_cfg.egress[0] = BIT(6);
+	f.dn1->acs_cap = 0x100;
+	f.dn1->acs_capabilities = PCI_ACS_CR | PCI_ACS_EC | (64 << 8);
+	f.dn1_cfg.acs_ctrl = PCI_ACS_CR | PCI_ACS_EC;
+	f.dn0_cfg.port = 5;		/* client vector left all-zero */
+
+	KUNIT_EXPECT_EQ(test, acs_walk_map(&f), PCI_P2PDMA_MAP_BUS_ADDR);
+}
+
+static void acs_walk_nested_completion_redirect_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	/* The completion already routes upstream at this nested port. */
+	f.provider_leaf->acs_cap = 0x100;
+	f.provider_leaf->acs_capabilities = PCI_ACS_CR;
+	f.provider_leaf_cfg.acs_ctrl = PCI_ACS_CR;
+
+	KUNIT_EXPECT_EQ(test, acs_walk_map(&f), PCI_P2PDMA_MAP_BUS_ADDR);
+}
+
+static void acs_walk_nested_request_redirect_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	/* The request already routes upstream at this nested port. */
+	f.client_leaf->acs_cap = 0x100;
+	f.client_leaf->acs_capabilities = PCI_ACS_RR;
+	f.client_leaf_cfg.acs_ctrl = PCI_ACS_RR;
+
+	KUNIT_EXPECT_EQ(test, acs_walk_map(&f), PCI_P2PDMA_MAP_BUS_ADDR);
+}
+
 static struct kunit_case pci_acs_test_cases[] = {
 	KUNIT_CASE_PARAM(pci_acs_p2pdma_decision_test, acs_decision_gen_params),
 	KUNIT_CASE_PARAM(pci_acs_egress_port_valid_test, egress_valid_gen_params),
@@ -430,6 +717,14 @@ static struct kunit_case pci_acs_test_cases[] = {
 	KUNIT_CASE(acs_egress_target_pcie_bridge_test),
 	KUNIT_CASE(acs_egress_target_other_bus_test),
 	KUNIT_CASE(acs_egress_root_port_test),
+	KUNIT_CASE(acs_walk_bus_addr_test),
+	KUNIT_CASE(acs_walk_ec_violation_test),
+	KUNIT_CASE(acs_walk_ec_vector_clear_test),
+	KUNIT_CASE(acs_walk_request_redirect_test),
+	KUNIT_CASE(acs_walk_completion_redirect_test),
+	KUNIT_CASE(acs_walk_asymmetric_direct_test),
+	KUNIT_CASE(acs_walk_nested_completion_redirect_test),
+	KUNIT_CASE(acs_walk_nested_request_redirect_test),
 	{}
 };
 

-- 
2.55.0

