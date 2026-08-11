Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35342E01F;
	Tue, 11 Aug 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440735; cv=none; b=OKtTepEjqyQ+KWza9YDwszkqVvYgSLrdjaO7F4iITYjG5Wt1BsP0qfwwXfPwrZiTiXk1FBtcaE5z60tkDGw0UMcs4gjzbewcenb0026gNRROKbfmH5DNYq0hFO0dULGfeqZ5n0GFcBg2CQKxCxDK16NAOQewvdsnzs5YNahacyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440735; c=relaxed/simple;
	bh=1Zupz39mijiB2eKoFgrRCIUPxUSyOm+t3/Myl03mv6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeV6sdbHyTkU+G81h3EAeDvgTKOn2+HoBdJj/zEuRVukNTbNpj6tcXCIErtd2rl5QJgnS0i/LRtFh7rUv3VaT/RGAL9GRXEyDSNXmtti1CcsCcLYwYNoxLQqgrqB0rYrFRq2RWAFbd/Mp8J2gQhKojNyk+lmLDCBhVgN4WkowRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iulMCgJM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iulMCgJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF991F00A3A;
	Tue, 11 Aug 2026 09:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440734;
	bh=QS+4DdLbcZFSX5l8hs7wBp22auL1V3b3oXdmJboJGfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iulMCgJMqyYJqazy7CDsWpae/lI2hpBla1XmJxBZiOK+l/ojBmn2QJDoOpJd+/Aq/
	 bIGYYfrkgtgHTmFKmeoMKk65U8njgkaLQJ43g9DsgZJI4TZbixbiuQPZUIjKlfH3lD
	 lP+TEXsOsqKSksUAz5iYADg00843LML6054GLIENOXNw3m1Itt/mwsbCCAjon7Hu4q
	 aqTWf5Gqr6E/pXmDb5obck6m8MjMd3JNTgJusA2y1CpNDp2320O76ntBxL1gwZQ8/2
	 hPYAACB2pVJEcUgvDx+8JjBsxgXjRG2Xb1Nblwz3FpZOpqHsx0WUywgDQ6XrCG6FJ+
	 F/GXaGY/aw0Aw==
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
	iommu@lists.linux.dev
Subject: [PATCH v3 16/17] PCI/P2PDMA: Add KUnit coverage for the ACS P2P routing walk
Date: Tue, 11 Aug 2026 12:30:58 +0300
Message-ID: <20260811-fix-p2p-acs-v3-16-efc488ee7c03@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
References: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
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

Extend the ACS KUnit suite with end-to-end coverage of
calc_map_type_and_dist(), the provider-to-client hierarchy walk.

A fabricated PCIe fabric (host bridge, Root Port, Switch Upstream Port,
two Switch Downstream Ports and the provider/client endpoints) with a
fake pci_ops backing the ACS Control, Egress Control Vector and LNKCAP
reads lets the walk run without real hardware.  The tests assert:

  - BUS_ADDR when no port on the path enables ACS;
  - THRU_HOST_BRIDGE when a Downstream Port's Egress Control Vector
    routes the peer with Request Redirect clear (an ACS Violation) at the
    path divergence, leaving only the host-bridge route;
  - BUS_ADDR when Egress Control is enabled but the peer's vector bit is
    clear;
  - THRU_HOST_BRIDGE when Request Redirect redirects the request and the
    host bridge is whitelisted.

calc_map_type_and_dist() is exposed under CONFIG_KUNIT via
VISIBLE_IF_KUNIT.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c       |   3 +-
 drivers/pci/pci.h          |   4 +
 drivers/pci/pci_acs_test.c | 204 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 2c38ed56a57b..34929bc6efb6 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -774,7 +774,7 @@ static unsigned long map_types_idx(struct pci_dev *client)
  * ports per above. If the device is not in the whitelist, return
  * PCI_P2PDMA_MAP_NOT_SUPPORTED.
  */
-static enum pci_p2pdma_map_type
+VISIBLE_IF_KUNIT enum pci_p2pdma_map_type
 calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool verbose)
 {
@@ -911,6 +911,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	rcu_read_unlock();
 	return map_type;
 }
+EXPORT_SYMBOL_IF_KUNIT(calc_map_type_and_dist);
 
 /**
  * pci_p2pdma_distance_many - Determine the cumulative distance between
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 06a18aa663bc..c55e6ea7c9de 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -6,6 +6,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
 #include <trace/events/pci.h>
 
 struct pcie_tlp_log;
@@ -1095,6 +1096,9 @@ enum pci_acs_p2pdma_state {
 bool pci_acs_egress_port_valid(u16 acs_caps, u8 target_port);
 enum pci_acs_p2pdma_state pci_acs_p2pdma_decision(u16 ctrl, bool has_target,
 						  int egress);
+enum pci_p2pdma_map_type calc_map_type_and_dist(struct pci_dev *provider,
+						struct pci_dev *client,
+						int *dist, bool verbose);
 #endif
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags,
diff --git a/drivers/pci/pci_acs_test.c b/drivers/pci/pci_acs_test.c
index 08d4654b95a9..130605b91b47 100644
--- a/drivers/pci/pci_acs_test.c
+++ b/drivers/pci/pci_acs_test.c
@@ -10,6 +10,7 @@
 #include <kunit/test.h>
 
 #include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
 #include <linux/pci_regs.h>
 
 #include "pci.h"
@@ -388,6 +389,205 @@ static void acs_egress_root_port_test(struct kunit *test)
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
+ *         Switch Downstream Port 0 -- provider
+ *         Switch Downstream Port 1 -- client
+ *
+ * A fake pci_ops answers the ACS Control, Egress Control Vector and LNKCAP
+ * reads for the two downstream ports, so the ACS Egress Control evaluated at
+ * the path divergence (Downstream Port 0 targeting Downstream Port 1) decides
+ * the mapping without any real hardware.
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
+	struct acs_dn_cfg	dn0_cfg;
+	struct acs_dn_cfg	dn1_cfg;
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
+	struct pci_bus *bus0, *bus1, *bus2, *bus3, *bus4;
+	struct pci_dev *rootport, *swup;
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
+	f->provider = acs_add_dev(test, bus3, PCI_DEVFN(0, 0),
+				  PCI_EXP_TYPE_ENDPOINT);
+
+	bus4 = acs_add_bus(test, bus2, f->dn1, 4, f);
+	f->client = acs_add_dev(test, bus4, PCI_DEVFN(0, 0),
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
+	 * Downstream Port 0 has Egress Control enabled with the vector bit for
+	 * the client's Downstream Port 1 set and Request Redirect clear: an ACS
+	 * Violation, so the direct path is unusable and the request has to take
+	 * the host-bridge route.
+	 */
+	f.dn0->acs_cap = 0x100;
+	f.dn0->acs_capabilities = PCI_ACS_EC | (64 << 8);
+	f.dn0_cfg.acs_ctrl = PCI_ACS_EC;
+	f.dn1_cfg.port = 5;
+	f.dn0_cfg.egress[0] = BIT(5);
+
+	KUNIT_EXPECT_EQ(test, acs_walk_map(&f),
+			PCI_P2PDMA_MAP_THRU_HOST_BRIDGE);
+}
+
+static void acs_walk_ec_vector_clear_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	/* Egress Control enabled but the vector bit for the peer is clear. */
+	f.dn0->acs_cap = 0x100;
+	f.dn0->acs_capabilities = PCI_ACS_EC | (64 << 8);
+	f.dn0_cfg.acs_ctrl = PCI_ACS_EC;
+	f.dn1_cfg.port = 5;		/* egress vector left all-zero */
+
+	KUNIT_EXPECT_EQ(test, acs_walk_map(&f), PCI_P2PDMA_MAP_BUS_ADDR);
+}
+
+static void acs_walk_thru_host_bridge_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	/* Request Redirect set: traffic is redirected up to the host bridge. */
+	f.dn0->acs_cap = 0x100;
+	f.dn0->acs_capabilities = PCI_ACS_RR;
+	f.dn0_cfg.acs_ctrl = PCI_ACS_RR;
+
+	/* The Google root port is whitelisted, so the host-bridge path is OK. */
+	KUNIT_EXPECT_EQ(test, acs_walk_map(&f),
+			PCI_P2PDMA_MAP_THRU_HOST_BRIDGE);
+}
+
 static struct kunit_case pci_acs_test_cases[] = {
 	KUNIT_CASE_PARAM(pci_acs_p2pdma_decision_test, acs_decision_gen_params),
 	KUNIT_CASE_PARAM(pci_acs_egress_port_valid_test, egress_valid_gen_params),
@@ -402,6 +602,10 @@ static struct kunit_case pci_acs_test_cases[] = {
 	KUNIT_CASE(acs_egress_target_pcie_bridge_test),
 	KUNIT_CASE(acs_egress_target_other_bus_test),
 	KUNIT_CASE(acs_egress_root_port_test),
+	KUNIT_CASE(acs_walk_bus_addr_test),
+	KUNIT_CASE(acs_walk_ec_violation_test),
+	KUNIT_CASE(acs_walk_ec_vector_clear_test),
+	KUNIT_CASE(acs_walk_thru_host_bridge_test),
 	{}
 };
 

-- 
2.55.0

