Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9023C76A0;
	Sun,  2 Aug 2026 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683452; cv=none; b=fcWcm0D6+42ISVpv1eRVvX+cOY2YeB15bvkkTXuX2Di9y8pgdjM8z3oWsd1Sp+ush6rgB5EqXb0vQyuCc+RO15NlZEgQ8yNuVHaj+1WWbaEeMUvLD/cI6UdZBNlS09Abn/hmCe3iKJKSvRbPnMNPo+zYnPovAZAlbavw/0gKpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683452; c=relaxed/simple;
	bh=WuPDjXSMvpqQrlGISIan50jAF8bSTcR4An1U+Nm1hrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJxfmojSGJVOuzcNNym+Svnc9kSOBOt6Mnim8MS1qS/3RB4c//hEJmMi6elpotq0BU1Nw9tso2Y88zkux6dG/XtvC/S5bWweHWTBGP4mFSCyNgllk9KVz0V4ATZyY5DNDLHDEYHJkN4K/GHKMahZG/n8utt5wB/2B8QGnxqOgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDSD1D5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDSD1D5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F3E1F00A3A;
	Sun,  2 Aug 2026 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785683447;
	bh=xZY7w4rjuz251ejEkgvCw42iIbdDJRqXB6YpNxyjP4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iDSD1D5nr/zIDCvaTi9Npth8EPJaijhvqtcIe/13O69EnpiQnHlOZNHyJLkWQGaxF
	 6QxYsaKqqkU5/OQuP/dBS/9QqeStpiGonXN7yvWyYca/oP4L2Qqa1J+KPJIi5/dZa6
	 4LHpmGWMgci/Ed5KniogmP1PRwIr9MdqtbeDyQXatnTCvTFJSx7WLFmOB+YSQ75+zR
	 ARH1xJGjfVn7/iIs2YEAosfSQ92ke6ih7AiYb69JPyvfADpIUhpgZox030bekwz6Ip
	 XU+EB8VfYuvsEIa6yLFOhmSktlMSC1NVrDC+MeIuqw6zUbBheBFEjXmpibNYV9OQdh
	 3el5b40pOsj+Q==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	"Claude Opus 4.8" <noreply@anthropic.com>
Subject: [PATCH 11/13] PCI/P2PDMA: Add KUnit tests for ACS routing decisions
Date: Sun,  2 Aug 2026 18:09:49 +0300
Message-ID: <20260802-fix-p2p-acs-v1-11-a7c5eb64fff6@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
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

Add a KUnit suite exercising the ACS peer-to-peer routing logic:

  - pci_acs_p2pdma_decision(): the full PCIe table 6-11 truth table,
    including the Egress Control Vector branches (bit set/clear, with and
    without Request Redirect and Completion Redirect) that require a
    switch implementing the Egress Control Vector and so cannot be
    reached on commonly available hardware.

  - pci_acs_egress_port_valid(): the vector-size boundary, including the
    "size 0 encodes 256 bits" case.

  - pci_acs_egress_ctrl_set(): driven through a fake pci_ops returning
    canned config space, covering target Port Number extraction from
    LNKCAP, the vector DWORD offset (target_port / 32), the bit position
    (target_port % 32), the -ERANGE bound, and the unsupported-port
    guards -- all without real hardware.

Run with:

cat > /tmp/pci-acs.kunitconfig <<'EOF'
CONFIG_KUNIT=y
CONFIG_PCI=y
CONFIG_ZONE_DEVICE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_PCI_P2PDMA=y
CONFIG_PCI_ACS_KUNIT_TEST=y
EOF

./tools/testing/kunit/kunit.py run --arch=x86_64 \
    --kunitconfig=/tmp/pci-acs.kunitconfig --jobs=$(nproc) pci_acs

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Assisted-by: Claude Opus 4.8 <noreply@anthropic.com>
---
 drivers/pci/Kconfig        |  15 ++
 drivers/pci/Makefile       |   1 +
 drivers/pci/pci_acs_test.c | 373 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 389 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c7408509ba2..30ad7f407c6f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -226,6 +226,21 @@ config PCI_P2PDMA
 
 	  If unsure, say N.
 
+config PCI_ACS_KUNIT_TEST
+	tristate "KUnit tests for PCI ACS P2P routing" if !KUNIT_ALL_TESTS
+	depends on PCI_P2PDMA && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit tests for the PCI ACS peer-to-peer routing decision
+	  logic (PCIe ACS Egress Control, table 6-11), including the code
+	  paths that require an ACS Egress Control Vector and so cannot be
+	  exercised on typical peer-to-peer hardware.
+
+	  For more information on KUnit and unit tests in general, refer to
+	  the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config PCI_LABEL
 	def_bool y if (DMI || ACPI)
 	select NLS
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..6305d128d3df 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_PCI_STUB)		+= pci-stub.o
 obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
 obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
+obj-$(CONFIG_PCI_ACS_KUNIT_TEST) += pci_acs_test.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
diff --git a/drivers/pci/pci_acs_test.c b/drivers/pci/pci_acs_test.c
new file mode 100644
index 000000000000..7227136c8cff
--- /dev/null
+++ b/drivers/pci/pci_acs_test.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for PCI ACS peer-to-peer routing decision logic.
+ *
+ * These exercise the pure helpers factored out of the ACS Egress Control
+ * handling (PCIe r7.0, sec 6.12.3, table 6-11).  They cover the code paths
+ * that require an ACS Egress Control Vector, which cannot be reached on the
+ * peer-to-peer hardware commonly available for testing.
+ */
+#include <kunit/test.h>
+
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+
+#include "pci.h"
+
+/* pci_acs_p2pdma_decision(): the table 6-11 truth table. */
+
+struct acs_decision_case {
+	const char *desc;
+	u16 ctrl;
+	bool has_target;
+	int egress;
+	enum pci_acs_p2pdma_state expect;
+};
+
+/* Shorthands to keep the table below readable. */
+#define ACS_DIRECT	PCI_ACS_P2PDMA_DIRECT
+#define ACS_REDIR	PCI_ACS_P2PDMA_REDIRECT
+#define ACS_NO_P2P	PCI_ACS_P2PDMA_NOT_SUPPORTED
+
+static const struct acs_decision_case acs_decision_cases[] = {
+	/* No target known: Egress Control is ignored, RR/CR decide. */
+	{ "no_target/none", 0, false, 0, ACS_DIRECT },
+	{ "no_target/rr", PCI_ACS_RR, false, 0, ACS_REDIR },
+	{ "no_target/cr", PCI_ACS_CR, false, 0, ACS_REDIR },
+	{ "no_target/ec_only", PCI_ACS_EC, false, 0, ACS_DIRECT },
+
+	/* Target known but EC clear: RR/CR decide, egress not consulted. */
+	{ "ec_clear/none", 0, true, 0, ACS_DIRECT },
+	{ "ec_clear/rr", PCI_ACS_RR, true, 0, ACS_REDIR },
+	{ "ec_clear/cr", PCI_ACS_CR, true, 0, ACS_REDIR },
+	{ "ec_clear/rr_cr", PCI_ACS_RR | PCI_ACS_CR, true, 0, ACS_REDIR },
+
+	/* EC set but vector unreadable: never a usable P2P route. */
+	{ "ec/eopnotsupp", PCI_ACS_EC | PCI_ACS_RR, true, -EOPNOTSUPP, ACS_NO_P2P },
+	{ "ec/erange", PCI_ACS_EC | PCI_ACS_CR, true, -ERANGE, ACS_NO_P2P },
+
+	/* EC set, vector bit set: redirect iff RR, else ACS Violation. */
+	{ "ec/vec_set/none", PCI_ACS_EC, true, 1, ACS_NO_P2P },
+	{ "ec/vec_set/cr", PCI_ACS_EC | PCI_ACS_CR, true, 1, ACS_NO_P2P },
+	{ "ec/vec_set/rr", PCI_ACS_EC | PCI_ACS_RR, true, 1, ACS_REDIR },
+	{ "ec/vec_set/rr_cr", PCI_ACS_EC | PCI_ACS_RR | PCI_ACS_CR, true, 1,
+	  ACS_REDIR },
+
+	/* EC set, vector bit clear: direct unless CR redirects. */
+	{ "ec/vec_clear/none", PCI_ACS_EC, true, 0, ACS_DIRECT },
+	{ "ec/vec_clear/rr", PCI_ACS_EC | PCI_ACS_RR, true, 0, ACS_DIRECT },
+	{ "ec/vec_clear/cr", PCI_ACS_EC | PCI_ACS_CR, true, 0, ACS_REDIR },
+	{ "ec/vec_clear/rr_cr", PCI_ACS_EC | PCI_ACS_RR | PCI_ACS_CR, true, 0,
+	  ACS_REDIR },
+};
+
+#undef ACS_DIRECT
+#undef ACS_REDIR
+#undef ACS_NO_P2P
+
+static void acs_decision_desc(const struct acs_decision_case *c, char *desc)
+{
+	strscpy(desc, c->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(acs_decision, acs_decision_cases, acs_decision_desc);
+
+static void pci_acs_p2pdma_decision_test(struct kunit *test)
+{
+	const struct acs_decision_case *c = test->param_value;
+
+	KUNIT_EXPECT_EQ(test,
+			pci_acs_p2pdma_decision(c->ctrl, c->has_target, c->egress),
+			c->expect);
+}
+
+/* pci_acs_egress_port_valid(): the Egress Control Vector Size rule. */
+
+struct egress_valid_case {
+	const char *desc;
+	u16 acs_caps;
+	u8 target_port;
+	bool expect;
+};
+
+static const struct egress_valid_case egress_valid_cases[] = {
+	/* A Vector Size of 0 encodes 256 bits, so every port is addressable. */
+	{ "size0/port0",	0x0000,	  0, true },
+	{ "size0/port255",	0x0000,	255, true },
+	/* Vector Size N (bits 15:8): ports [0, N) are addressable. */
+	{ "size1/port0",	0x0100,	  0, true },
+	{ "size1/port1",	0x0100,	  1, false },
+	{ "size8/port7",	0x0800,	  7, true },
+	{ "size8/port8",	0x0800,	  8, false },
+	{ "size255/port254",	0xff00,	254, true },
+	{ "size255/port255",	0xff00,	255, false },
+};
+
+static void egress_valid_desc(const struct egress_valid_case *c, char *desc)
+{
+	strscpy(desc, c->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(egress_valid, egress_valid_cases, egress_valid_desc);
+
+static void pci_acs_egress_port_valid_test(struct kunit *test)
+{
+	const struct egress_valid_case *c = test->param_value;
+
+	KUNIT_EXPECT_EQ(test,
+			pci_acs_egress_port_valid(c->acs_caps, c->target_port),
+			c->expect);
+}
+
+/*
+ * pci_acs_egress_ctrl_set(): drive the config-space reads with a fake pci_ops
+ * so the Egress Control Vector lookup is exercised without real hardware --
+ * the target Port Number from LNKCAP, the vector DWORD at target_port/32, and
+ * the bit at target_port%32.
+ */
+
+/* PCIe Capabilities register value: device/port @type, capability version 2. */
+#define ACS_TEST_PCIE_FLAGS(type)	(((type) << 4) | 0x2)
+#define ACS_DOWNSTREAM			ACS_TEST_PCIE_FLAGS(PCI_EXP_TYPE_DOWNSTREAM)
+#define ACS_ENDPOINT			ACS_TEST_PCIE_FLAGS(PCI_EXP_TYPE_ENDPOINT)
+#define ACS_ROOT_PORT			ACS_TEST_PCIE_FLAGS(PCI_EXP_TYPE_ROOT_PORT)
+#define ACS_PCIE_BRIDGE			ACS_TEST_PCIE_FLAGS(PCI_EXP_TYPE_PCIE_BRIDGE)
+
+struct acs_fake_cfg {
+	unsigned int	pdev_devfn;
+	unsigned int	target_devfn;
+	u16		pdev_acs_cap;
+	u8		target_pcie_cap;
+	u8		target_port;
+	u32		egress_vector[8];	/* full 256-bit vector */
+};
+
+static int acs_fake_cfg_read(struct pci_bus *bus, unsigned int devfn,
+			     int where, int size, u32 *val)
+{
+	struct acs_fake_cfg *cfg = bus->sysdata;
+
+	*val = 0;
+	if (size != 4)
+		return PCIBIOS_SUCCESSFUL;
+
+	if (devfn == cfg->target_devfn &&
+	    where == cfg->target_pcie_cap + PCI_EXP_LNKCAP) {
+		*val = FIELD_PREP(PCI_EXP_LNKCAP_PN, cfg->target_port);
+	} else if (devfn == cfg->pdev_devfn) {
+		int base = cfg->pdev_acs_cap + PCI_ACS_EGRESS_CTL_V;
+
+		if (where >= base &&
+		    where < base + (int)sizeof(cfg->egress_vector))
+			*val = cfg->egress_vector[(where - base) / 4];
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int acs_fake_cfg_write(struct pci_bus *bus, unsigned int devfn,
+			      int where, int size, u32 val)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops acs_fake_ops = {
+	.read	= acs_fake_cfg_read,
+	.write	= acs_fake_cfg_write,
+};
+
+static struct acs_fake_cfg acs_base_cfg(void)
+{
+	return (struct acs_fake_cfg){
+		.pdev_devfn	 = PCI_DEVFN(0, 0),
+		.target_devfn	 = PCI_DEVFN(1, 0),
+		.pdev_acs_cap	 = 0x100,
+		.target_pcie_cap = 0x40,
+	};
+}
+
+static int acs_egress_ctrl_set(struct kunit *test, struct acs_fake_cfg *cfg,
+			       u16 pdev_acs_caps, u16 pdev_flags, u16 target_flags)
+{
+	struct pci_bus *bus = kunit_kzalloc(test, sizeof(*bus), GFP_KERNEL);
+	struct pci_dev *pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+	struct pci_dev *target = kunit_kzalloc(test, sizeof(*target), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, bus);
+	KUNIT_ASSERT_NOT_NULL(test, pdev);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+
+	bus->ops = &acs_fake_ops;
+	bus->sysdata = cfg;
+
+	pdev->bus = bus;
+	pdev->devfn = cfg->pdev_devfn;
+	pdev->acs_cap = cfg->pdev_acs_cap;
+	pdev->acs_capabilities = pdev_acs_caps;
+	pdev->pcie_cap = 0x40;
+	pdev->pcie_flags_reg = pdev_flags;
+
+	target->bus = bus;
+	target->devfn = cfg->target_devfn;
+	target->pcie_cap = cfg->target_pcie_cap;
+	target->pcie_flags_reg = target_flags;
+
+	return pci_acs_egress_ctrl_set(pdev, target);
+}
+
+static void acs_egress_vector_bit_set_test(struct kunit *test)
+{
+	struct acs_fake_cfg cfg = acs_base_cfg();
+
+	cfg.target_port = 5;
+	cfg.egress_vector[0] = BIT(5);
+
+	KUNIT_EXPECT_EQ(test,
+			acs_egress_ctrl_set(test, &cfg, PCI_ACS_EC | (32 << 8),
+					    ACS_DOWNSTREAM, ACS_DOWNSTREAM),
+			1);
+}
+
+static void acs_egress_vector_bit_clear_test(struct kunit *test)
+{
+	struct acs_fake_cfg cfg = acs_base_cfg();
+
+	cfg.target_port = 5;	/* vector left all-zero */
+
+	KUNIT_EXPECT_EQ(test,
+			acs_egress_ctrl_set(test, &cfg, PCI_ACS_EC | (32 << 8),
+					    ACS_DOWNSTREAM, ACS_DOWNSTREAM),
+			0);
+}
+
+static void acs_egress_high_port_index_test(struct kunit *test)
+{
+	struct acs_fake_cfg cfg = acs_base_cfg();
+
+	/* Port 40 lives in vector DWORD 1, bit 8: exercises target_port/32. */
+	cfg.target_port = 40;
+	cfg.egress_vector[1] = BIT(40 % 32);
+
+	KUNIT_EXPECT_EQ(test,
+			acs_egress_ctrl_set(test, &cfg, PCI_ACS_EC | (64 << 8),
+					    ACS_DOWNSTREAM, ACS_DOWNSTREAM),
+			1);
+}
+
+static void acs_egress_port_out_of_range_test(struct kunit *test)
+{
+	struct acs_fake_cfg cfg = acs_base_cfg();
+
+	/* Vector Size 8, port 40 is beyond it. */
+	cfg.target_port = 40;
+
+	KUNIT_EXPECT_EQ(test,
+			acs_egress_ctrl_set(test, &cfg, PCI_ACS_EC | (8 << 8),
+					    ACS_DOWNSTREAM, ACS_DOWNSTREAM),
+			-ERANGE);
+}
+
+static void acs_egress_no_ec_cap_test(struct kunit *test)
+{
+	struct acs_fake_cfg cfg = acs_base_cfg();
+
+	cfg.target_port = 5;
+
+	/* acs_capabilities without PCI_ACS_EC: unsupported. */
+	KUNIT_EXPECT_EQ(test,
+			acs_egress_ctrl_set(test, &cfg, 32 << 8,
+					    ACS_DOWNSTREAM, ACS_DOWNSTREAM),
+			-EOPNOTSUPP);
+}
+
+static void acs_egress_pdev_not_downstream_test(struct kunit *test)
+{
+	struct acs_fake_cfg cfg = acs_base_cfg();
+
+	cfg.target_port = 5;
+
+	KUNIT_EXPECT_EQ(test,
+			acs_egress_ctrl_set(test, &cfg, PCI_ACS_EC | (32 << 8),
+					    ACS_ENDPOINT, ACS_DOWNSTREAM),
+			-EOPNOTSUPP);
+}
+
+static void acs_egress_target_not_downstream_test(struct kunit *test)
+{
+	struct acs_fake_cfg cfg = acs_base_cfg();
+
+	cfg.target_port = 5;
+
+	KUNIT_EXPECT_EQ(test,
+			acs_egress_ctrl_set(test, &cfg, PCI_ACS_EC | (32 << 8),
+					    ACS_DOWNSTREAM, ACS_ENDPOINT),
+			-EOPNOTSUPP);
+}
+
+/*
+ * The vector is indexed by Port Number only for Root Ports and Switch
+ * Downstream Ports, so a PCI/PCI-X to PCIe Bridge must not be indexed by its
+ * Link Capabilities Port Number.
+ */
+static void acs_egress_pdev_pcie_bridge_test(struct kunit *test)
+{
+	struct acs_fake_cfg cfg = acs_base_cfg();
+
+	cfg.target_port = 5;
+
+	KUNIT_EXPECT_EQ(test,
+			acs_egress_ctrl_set(test, &cfg, PCI_ACS_EC | (32 << 8),
+					    ACS_PCIE_BRIDGE, ACS_DOWNSTREAM),
+			-EOPNOTSUPP);
+}
+
+static void acs_egress_target_pcie_bridge_test(struct kunit *test)
+{
+	struct acs_fake_cfg cfg = acs_base_cfg();
+
+	cfg.target_port = 5;
+
+	KUNIT_EXPECT_EQ(test,
+			acs_egress_ctrl_set(test, &cfg, PCI_ACS_EC | (32 << 8),
+					    ACS_DOWNSTREAM, ACS_PCIE_BRIDGE),
+			-EOPNOTSUPP);
+}
+
+/* A Root Port is a valid ingress and egress port for the vector. */
+static void acs_egress_root_port_test(struct kunit *test)
+{
+	struct acs_fake_cfg cfg = acs_base_cfg();
+
+	cfg.target_port = 5;
+	cfg.egress_vector[0] = BIT(5);
+
+	KUNIT_EXPECT_EQ(test,
+			acs_egress_ctrl_set(test, &cfg, PCI_ACS_EC | (32 << 8),
+					    ACS_ROOT_PORT, ACS_ROOT_PORT),
+			1);
+}
+
+static struct kunit_case pci_acs_test_cases[] = {
+	KUNIT_CASE_PARAM(pci_acs_p2pdma_decision_test, acs_decision_gen_params),
+	KUNIT_CASE_PARAM(pci_acs_egress_port_valid_test, egress_valid_gen_params),
+	KUNIT_CASE(acs_egress_vector_bit_set_test),
+	KUNIT_CASE(acs_egress_vector_bit_clear_test),
+	KUNIT_CASE(acs_egress_high_port_index_test),
+	KUNIT_CASE(acs_egress_port_out_of_range_test),
+	KUNIT_CASE(acs_egress_no_ec_cap_test),
+	KUNIT_CASE(acs_egress_pdev_not_downstream_test),
+	KUNIT_CASE(acs_egress_target_not_downstream_test),
+	KUNIT_CASE(acs_egress_pdev_pcie_bridge_test),
+	KUNIT_CASE(acs_egress_target_pcie_bridge_test),
+	KUNIT_CASE(acs_egress_root_port_test),
+	{}
+};
+
+static struct kunit_suite pci_acs_test_suite = {
+	.name = "pci_acs",
+	.test_cases = pci_acs_test_cases,
+};
+kunit_test_suite(pci_acs_test_suite);
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for PCI ACS peer-to-peer routing decisions");

-- 
2.55.0

