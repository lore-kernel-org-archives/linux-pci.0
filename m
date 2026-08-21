Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0C41D13C;
	Fri, 21 Aug 2026 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341341; cv=none; b=YeX1rHo6EkstAUnJ4Xd+vO7cpDmYRkNzbO3mzRY7HFx2Msro1Umuc8DJPrwOeYve08PNvRCYMhE/jXmR5BRnJzzQbq6VFaEG2lFLoG2DS2cm/kyWqT9eYKCvuqRQZP9khDK4R5spysoGo7BmqDpeC6EuuCpQCjWAzQhqLKTXgq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341341; c=relaxed/simple;
	bh=+aa8iI88ttSXngKOVmBXU/cr1LVP6U0jEwzs06w6KH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppM9kD4nfcWNnVGLAQN6ylGWGiguXeUMTmWrb1Vi5HCQnPFCvBzFjPGIiTKogheOrEo+t2qedBUfBSMvEoK3nK8830o2MwyxYEJLMzZywX19JUfNamZk+dT5IDIX6G3uwRnW3CHJrkD6oBwTzbKgXGxyqn7ZMNZn1MgCF1y0iJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyfgz3hH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyfgz3hH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE7E1F000E9;
	Fri, 21 Aug 2026 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341339;
	bh=tRIWuy5g/YiwQTKwLgmPuZ8NIDwGbtmjVn/uDGYC3BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tyfgz3hHo3HA7nY3kF/IgwsOGDV9e8n+AbcE7C7xpx31wu+Nc8agBob4yco6j6jSD
	 zcHsU9d3I5sFf+6rFM5KbvuwHtzZuq4C0WBaidVddoLSpXv6o1QImv93hPyW8pbVoa
	 9lazzcgDs0ymKBKAEAWbYO0/FStXznJ+CrfwUBuaqTgucUDc0oB1mwMQjmJipsnIHh
	 yF9tEa1F1lF3odaXEzcU6RfYtE+gyuvzrx6QbyNlKj9szUjWlDebZbWpPLf8lNZXEn
	 T3rGsUHQwvv7LGNeQf+05rdCoe4YiUCoWUHVRlMFft+bLGEaoDkZmTlDrIM6ECMOjw
	 CLxvwN1bSff3Q==
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
Subject: [PATCH v4 15/18] PCI/P2PDMA: Add KUnit tests for ACS routing decisions
Date: Fri, 21 Aug 2026 22:38:46 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-15-94426b96de73@nvidia.com>
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

The ACS routing decision combines TLP type, redirect controls, target
availability, and the Egress Control Vector. Hardware cannot reliably
provide every combination needed to cover this matrix.

Add KUnit cases for Request and Completion routing, including
reverse-direction controls that must be ignored and every Egress Control
outcome. Cover vector-size boundaries and config-space access with fake
pci_ops so the result does not depend on available PCIe hardware.

Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/Kconfig        |  15 ++
 drivers/pci/Makefile       |   1 +
 drivers/pci/pci_acs_test.c | 444 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 460 insertions(+)

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
index 000000000000..aec7d7636f70
--- /dev/null
+++ b/drivers/pci/pci_acs_test.c
@@ -0,0 +1,444 @@
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
+	enum pci_acs_p2pdma_tlp tlp;
+	bool has_target;
+	int egress;
+	enum pci_acs_p2pdma_state expect;
+};
+
+/* Shorthands to keep the table below readable. */
+#define ACS_DIRECT	PCI_ACS_P2PDMA_DIRECT
+#define ACS_REDIR	PCI_ACS_P2PDMA_REDIRECT
+#define ACS_NO_P2P	PCI_ACS_P2PDMA_NOT_SUPPORTED
+#define ACS_REQ		PCI_ACS_P2PDMA_TLP_REQUEST
+#define ACS_CPL		PCI_ACS_P2PDMA_TLP_COMPLETION
+
+static const struct acs_decision_case acs_decision_cases[] = {
+	/* Completion routing depends only on Completion Redirect. */
+	{ "cpl/none", 0, ACS_CPL, false, 0, ACS_DIRECT },
+	{ "cpl/rr", PCI_ACS_RR, ACS_CPL, false, 0, ACS_DIRECT },
+	{ "cpl/cr", PCI_ACS_CR, ACS_CPL, false, 0, ACS_REDIR },
+	{ "cpl/rr_cr", PCI_ACS_RR | PCI_ACS_CR, ACS_CPL, false, 0,
+	  ACS_REDIR },
+	{ "cpl/ec_target", PCI_ACS_EC | PCI_ACS_RR, ACS_CPL, true, 1,
+	  ACS_DIRECT },
+	{ "cpl/ec_error", PCI_ACS_EC | PCI_ACS_CR, ACS_CPL, true, -ERANGE,
+	  ACS_REDIR },
+
+	/* No Request target known: Egress Control is ignored and RR decides. */
+	{ "req/no_target/none", 0, ACS_REQ, false, 0, ACS_DIRECT },
+	{ "req/no_target/rr", PCI_ACS_RR, ACS_REQ, false, 0, ACS_REDIR },
+	{ "req/no_target/cr", PCI_ACS_CR, ACS_REQ, false, 0, ACS_DIRECT },
+	{ "req/no_target/rr_cr", PCI_ACS_RR | PCI_ACS_CR, ACS_REQ, false, 0,
+	  ACS_REDIR },
+	{ "req/no_target/ec_only", PCI_ACS_EC, ACS_REQ, false, 0,
+	  ACS_DIRECT },
+
+	/* Request target known but EC clear: RR decides, egress is ignored. */
+	{ "req/ec_clear/none", 0, ACS_REQ, true, 0, ACS_DIRECT },
+	{ "req/ec_clear/rr", PCI_ACS_RR, ACS_REQ, true, 0, ACS_REDIR },
+	{ "req/ec_clear/cr", PCI_ACS_CR, ACS_REQ, true, 0, ACS_DIRECT },
+	{ "req/ec_clear/rr_cr", PCI_ACS_RR | PCI_ACS_CR, ACS_REQ, true, 0,
+	  ACS_REDIR },
+
+	/* EC set but vector unreadable: never a usable P2P route. */
+	{ "req/ec/eopnotsupp", PCI_ACS_EC | PCI_ACS_RR, ACS_REQ, true,
+	  -EOPNOTSUPP, ACS_NO_P2P },
+	{ "req/ec/erange", PCI_ACS_EC | PCI_ACS_CR, ACS_REQ, true, -ERANGE,
+	  ACS_NO_P2P },
+
+	/* EC set, vector bit set: redirect iff RR, else ACS Violation. */
+	{ "req/ec/vec_set/none", PCI_ACS_EC, ACS_REQ, true, 1, ACS_NO_P2P },
+	{ "req/ec/vec_set/cr", PCI_ACS_EC | PCI_ACS_CR, ACS_REQ, true, 1,
+	  ACS_NO_P2P },
+	{ "req/ec/vec_set/rr", PCI_ACS_EC | PCI_ACS_RR, ACS_REQ, true, 1,
+	  ACS_REDIR },
+	{ "req/ec/vec_set/rr_cr", PCI_ACS_EC | PCI_ACS_RR | PCI_ACS_CR,
+	  ACS_REQ, true, 1, ACS_REDIR },
+
+	/* EC set, vector bit clear: the Request routes directly. */
+	{ "req/ec/vec_clear/none", PCI_ACS_EC, ACS_REQ, true, 0,
+	  ACS_DIRECT },
+	{ "req/ec/vec_clear/rr", PCI_ACS_EC | PCI_ACS_RR, ACS_REQ, true, 0,
+	  ACS_DIRECT },
+	{ "req/ec/vec_clear/cr", PCI_ACS_EC | PCI_ACS_CR, ACS_REQ, true, 0,
+	  ACS_DIRECT },
+	{ "req/ec/vec_clear/rr_cr", PCI_ACS_EC | PCI_ACS_RR | PCI_ACS_CR,
+	  ACS_REQ, true, 0, ACS_DIRECT },
+};
+
+#undef ACS_DIRECT
+#undef ACS_REDIR
+#undef ACS_NO_P2P
+#undef ACS_REQ
+#undef ACS_CPL
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
+			pci_acs_p2pdma_decision(c->ctrl, c->tlp,
+						c->has_target, c->egress),
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
+ * pci_acs_egress_ctrl_is_set(): drive the config-space reads with a fake pci_ops
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
+	return pci_acs_egress_ctrl_is_set(pdev, target);
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
+/*
+ * Each vector bit is a Port Number within one Switch or Root Complex (PCIe
+ * r7.0, sec 7.7.12.4), so a target that does not share the ingress port's bus
+ * has no bit here even when the bit at its Port Number is set.
+ */
+static void acs_egress_target_other_bus_test(struct kunit *test)
+{
+	struct acs_fake_cfg cfg = acs_base_cfg();
+	struct pci_bus *bus = kunit_kzalloc(test, sizeof(*bus), GFP_KERNEL);
+	struct pci_bus *other = kunit_kzalloc(test, sizeof(*other), GFP_KERNEL);
+	struct pci_dev *pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+	struct pci_dev *target = kunit_kzalloc(test, sizeof(*target), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, bus);
+	KUNIT_ASSERT_NOT_NULL(test, other);
+	KUNIT_ASSERT_NOT_NULL(test, pdev);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+
+	cfg.target_port = 5;
+	cfg.egress_vector[0] = BIT(5);
+
+	bus->ops = &acs_fake_ops;
+	bus->sysdata = &cfg;
+	other->ops = &acs_fake_ops;
+	other->sysdata = &cfg;
+
+	pdev->bus = bus;
+	pdev->devfn = cfg.pdev_devfn;
+	pdev->acs_cap = cfg.pdev_acs_cap;
+	pdev->acs_capabilities = PCI_ACS_EC | (32 << 8);
+	pdev->pcie_cap = 0x40;
+	pdev->pcie_flags_reg = ACS_DOWNSTREAM;
+
+	target->bus = other;
+	target->devfn = cfg.target_devfn;
+	target->pcie_cap = cfg.target_pcie_cap;
+	target->pcie_flags_reg = ACS_DOWNSTREAM;
+
+	KUNIT_EXPECT_EQ(test, pci_acs_egress_ctrl_is_set(pdev, target),
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
+	KUNIT_CASE(acs_egress_target_other_bus_test),
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

