Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9543DA4B;
	Tue, 11 Aug 2026 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440738; cv=none; b=MU5Pf0Cl4VPFOxL8VnuX5cW/31SEtB27N/lVz5v6bWK3ajf270PnF1T856vL6xCinpdN4lqI3Z0HpUFFzmaDai+Ya4bZlncbx2iOSFygixeOd3y5XpbWBINd4PHNAY+tN9Bsgt/twdgTn2Hl4r64u5PGloJNEUmQFWgam8bxnA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440738; c=relaxed/simple;
	bh=xHX0745GTSixc57wJHnKKtkxs/DmMLtP43QRNGhBymw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCqE1lyqpeGpavjIfQnKaHZt1sZR7nLhg0BwvOn8sRr5/Wl1337z9COAey1AhlE2ZXJ7KpS+39E0+M6qWkVUABmDLf/HeQcWSxe+L7eN74D6pH9N6FMBc5GYKsUvHAZvXOS7kR9kZDSqJilRos+ZOzoJaU/a6zekEA0PD9P+1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqC3t24+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqC3t24+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1B11F000E9;
	Tue, 11 Aug 2026 09:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440737;
	bh=2+bUtGYXfogM9+SmfMCRcPaKXM9gF1dgNXfMyMgg5D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GqC3t24+5c+5CyD2T6PGMgExE1yf9+At05jIQh6yOVnSm+DjMjpXpp69EB0eUDOU0
	 zrLieoqnnLNWzi3d480D/gQBPQpvdLtwTBY7rIjG469qkPKdcLQhwaIp/0akHXe+1R
	 g6zBUjrLFmR9Jrkpb0A5Kz5Q26CGdY8pPxoXgfpQv20nzamedHXyYgQ/qs4g1iOBQf
	 pozcVY3CauZ70ovjiH9C/GjHVoNOtxk/0nfrfdSkAKNpn4aZICLCIKvBKCPWjpDfja
	 bIJi8L7EEVspdMceOXsEEBEKWGL0aDXATk7NIo8CgnZbCb4iNWkznVCfpqIXg6iIW5
	 USlR1Qwrlkjbw==
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
Subject: [PATCH v3 17/17] PCI: Add KUnit coverage for ACS isolation checks
Date: Tue, 11 Aug 2026 12:30:59 +0300
Message-ID: <20260811-fix-p2p-acs-v3-17-efc488ee7c03@nvidia.com>
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

Direct Translated P2P and Egress Control both let a peer request reach
the peer without Request Redirect, and whether Request Redirect still
isolates depends further on Translation Blocking and on the flags the
caller requests. Firmware owns these bits, so the combinations are not
reachable on a given machine.

Drive pci_acs_flags_enabled() with a fake pci_ops supplying the ACS
Control register and check each combination, in both scopes: an
Untranslated-only caller such as pci_enable_pasid() is unaffected by
Direct Translated P2P but still loses Request Redirect to Egress
Control. Cover the two ways the check gives up as well: a device with no
ACS capability, and a control register that cannot be read.

The function is exposed under CONFIG_KUNIT via VISIBLE_IF_KUNIT.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/pci.c          |   6 +-
 drivers/pci/pci.h          |   2 +
 drivers/pci/pci_acs_test.c | 181 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d900fdb6f37d..7ee1fca60a12 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3631,8 +3631,9 @@ int pci_acs_egress_ctrl_is_set(struct pci_dev *pdev, struct pci_dev *target)
 }
 EXPORT_SYMBOL_IF_KUNIT(pci_acs_egress_ctrl_is_set);
 
-static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags,
-				  enum pci_acs_scope scope)
+VISIBLE_IF_KUNIT
+bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags,
+			   enum pci_acs_scope scope)
 {
 	int pos;
 	u16 ctrl;
@@ -3656,6 +3657,7 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags,
 
 	return (ctrl & acs_flags) == acs_flags;
 }
+EXPORT_SYMBOL_IF_KUNIT(pci_acs_flags_enabled);
 
 /**
  * pci_acs_enabled - test ACS against required flags for a given device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c55e6ea7c9de..f8f9a15e411a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1093,6 +1093,8 @@ enum pci_acs_p2pdma_state {
 };
 
 #if IS_ENABLED(CONFIG_KUNIT)
+bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags,
+			   enum pci_acs_scope scope);
 bool pci_acs_egress_port_valid(u16 acs_caps, u8 target_port);
 enum pci_acs_p2pdma_state pci_acs_p2pdma_decision(u16 ctrl, bool has_target,
 						  int egress);
diff --git a/drivers/pci/pci_acs_test.c b/drivers/pci/pci_acs_test.c
index 130605b91b47..11f145c89001 100644
--- a/drivers/pci/pci_acs_test.c
+++ b/drivers/pci/pci_acs_test.c
@@ -120,6 +120,184 @@ static void pci_acs_egress_port_valid_test(struct kunit *test)
 			c->expect);
 }
 
+/*
+ * pci_acs_flags_enabled(): Direct Translated P2P and Egress Control both let a
+ * peer request reach the peer without Request Redirect, so neither may report
+ * isolation.  Translation Blocking rejects a Translated Request before it is
+ * routed, which restores the Request Redirect guarantee.  A fake pci_ops
+ * supplies the ACS Control register.
+ */
+
+/* Flags an IOMMU asks for; see REQ_ACS_FLAGS in drivers/iommu/iommu.c. */
+#define ACS_REQ_FLAGS	(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
+#define ACS_ALL_CAPS	(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | \
+			 PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)
+#define ACS_TEST_CAP	0x100
+/* Flags pci_enable_pasid() asks for; see drivers/pci/ats.c. */
+#define ACS_PASID_FLAGS	(PCI_ACS_RR | PCI_ACS_UF)
+
+struct acs_ctrl_cfg {
+	unsigned int	devfn;
+	u16		cap;		/* offset the ACS capability answers at */
+	u16		ctrl;
+	bool		fail_read;
+};
+
+static int acs_ctrl_read(struct pci_bus *bus, unsigned int devfn,
+			 int where, int size, u32 *val)
+{
+	struct acs_ctrl_cfg *cfg = bus->sysdata;
+
+	*val = 0;
+	if (cfg->fail_read)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (devfn == cfg->devfn && size == 2 &&
+	    where == cfg->cap + PCI_ACS_CTRL)
+		*val = cfg->ctrl;
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int acs_ctrl_write(struct pci_bus *bus, unsigned int devfn,
+			  int where, int size, u32 val)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops acs_ctrl_ops = {
+	.read	= acs_ctrl_read,
+	.write	= acs_ctrl_write,
+};
+
+struct acs_isolation_case {
+	const char *desc;
+	u16	ctrl;			/* ACS Control register */
+	u16	req;			/* flags the caller asks for */
+	enum pci_acs_scope scope;	/* Requests the answer must cover */
+	bool	expect;			/* isolation reported? */
+};
+
+static const struct acs_isolation_case acs_isolation_cases[] = {
+	{ "plain_rr", ACS_REQ_FLAGS, ACS_REQ_FLAGS, PCI_ACS_SCOPE_ALL, true },
+	/* Direct Translated P2P bypasses Request Redirect ... */
+	{ "dt", ACS_REQ_FLAGS | PCI_ACS_DT, ACS_REQ_FLAGS,
+	  PCI_ACS_SCOPE_ALL, false },
+	/* ... unless Translation Blocking rejects the Translated Request. */
+	{ "dt_tb", ACS_REQ_FLAGS | PCI_ACS_DT | PCI_ACS_TB, ACS_REQ_FLAGS,
+	  PCI_ACS_SCOPE_ALL, true },
+	{ "tb_only", ACS_REQ_FLAGS | PCI_ACS_TB, ACS_REQ_FLAGS,
+	  PCI_ACS_SCOPE_ALL, true },
+	/* Egress Control can override Request Redirect as well. */
+	{ "ec", ACS_REQ_FLAGS | PCI_ACS_EC, ACS_REQ_FLAGS,
+	  PCI_ACS_SCOPE_ALL, false },
+	{ "ec_dt_tb", ACS_REQ_FLAGS | PCI_ACS_EC | PCI_ACS_DT | PCI_ACS_TB,
+	  ACS_REQ_FLAGS, PCI_ACS_SCOPE_ALL, false },
+	/* Without Request Redirect requested, neither bit is consulted. */
+	{ "no_rr_dt", PCI_ACS_SV | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT,
+	  PCI_ACS_SV | PCI_ACS_CR | PCI_ACS_UF, PCI_ACS_SCOPE_ALL, true },
+	/* A control bit the caller asked for is simply missing. */
+	{ "rr_not_enabled", PCI_ACS_SV | PCI_ACS_CR | PCI_ACS_UF, ACS_REQ_FLAGS,
+	  PCI_ACS_SCOPE_ALL, false },
+
+	/*
+	 * An Untranslated-only caller such as pci_enable_pasid() is not
+	 * affected by Direct Translated P2P, but is still affected by Egress
+	 * Control, which acts on Untranslated peer Requests too.
+	 */
+	{ "untrans/plain_rr", ACS_PASID_FLAGS, ACS_PASID_FLAGS,
+	  PCI_ACS_SCOPE_UNTRANSLATED, true },
+	{ "untrans/dt", ACS_PASID_FLAGS | PCI_ACS_DT, ACS_PASID_FLAGS,
+	  PCI_ACS_SCOPE_UNTRANSLATED, true },
+	{ "untrans/dt_tb", ACS_PASID_FLAGS | PCI_ACS_DT | PCI_ACS_TB,
+	  ACS_PASID_FLAGS, PCI_ACS_SCOPE_UNTRANSLATED, true },
+	{ "untrans/ec", ACS_PASID_FLAGS | PCI_ACS_EC, ACS_PASID_FLAGS,
+	  PCI_ACS_SCOPE_UNTRANSLATED, false },
+	{ "untrans/rr_not_enabled", PCI_ACS_UF, ACS_PASID_FLAGS,
+	  PCI_ACS_SCOPE_UNTRANSLATED, false },
+};
+
+static void acs_isolation_desc(const struct acs_isolation_case *c, char *desc)
+{
+	strscpy(desc, c->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(acs_isolation, acs_isolation_cases, acs_isolation_desc);
+
+static void pci_acs_flags_enabled_test(struct kunit *test)
+{
+	const struct acs_isolation_case *c = test->param_value;
+	struct acs_ctrl_cfg cfg = { .devfn = PCI_DEVFN(0, 0),
+				    .cap = ACS_TEST_CAP, .ctrl = c->ctrl };
+	struct pci_bus *bus = kunit_kzalloc(test, sizeof(*bus), GFP_KERNEL);
+	struct pci_dev *pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, bus);
+	KUNIT_ASSERT_NOT_NULL(test, pdev);
+
+	bus->ops = &acs_ctrl_ops;
+	bus->sysdata = &cfg;
+
+	pdev->bus = bus;
+	pdev->devfn = cfg.devfn;
+	pdev->acs_cap = ACS_TEST_CAP;
+	pdev->acs_capabilities = ACS_ALL_CAPS;
+
+	KUNIT_EXPECT_EQ(test, pci_acs_flags_enabled(pdev, c->req, c->scope),
+			c->expect);
+}
+
+static bool acs_isolated(struct kunit *test, struct acs_ctrl_cfg *cfg,
+			 u16 acs_cap, u16 acs_flags)
+{
+	struct pci_bus *bus = kunit_kzalloc(test, sizeof(*bus), GFP_KERNEL);
+	struct pci_dev *pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, bus);
+	KUNIT_ASSERT_NOT_NULL(test, pdev);
+
+	bus->ops = &acs_ctrl_ops;
+	bus->sysdata = cfg;
+
+	pdev->bus = bus;
+	pdev->devfn = cfg->devfn;
+	pdev->acs_cap = acs_cap;
+	pdev->acs_capabilities = ACS_ALL_CAPS;
+
+	return pci_acs_flags_enabled(pdev, acs_flags, PCI_ACS_SCOPE_ALL);
+}
+
+/*
+ * Without an ACS capability there is no control register to consult.  The
+ * fake answers at offset 0 here, so dropping the acs_cap guard would read an
+ * isolating control word rather than nothing.
+ */
+static void pci_acs_flags_no_cap_test(struct kunit *test)
+{
+	struct acs_ctrl_cfg cfg = { .devfn = PCI_DEVFN(0, 0), .cap = 0,
+				    .ctrl = ACS_REQ_FLAGS };
+
+	KUNIT_EXPECT_FALSE(test, acs_isolated(test, &cfg, 0, ACS_REQ_FLAGS));
+}
+
+/*
+ * An unreadable ACS Control register reads back as all ones, which satisfies
+ * any requested control.  Ask without Request Redirect, so that neither
+ * pci_acs_rr_ineffective() nor the control word itself can deny isolation and
+ * the read failure is the only thing left that can.
+ */
+static void pci_acs_flags_read_fails_test(struct kunit *test)
+{
+	u16 no_rr = ACS_REQ_FLAGS & ~PCI_ACS_RR;
+	struct acs_ctrl_cfg cfg = { .devfn = PCI_DEVFN(0, 0),
+				    .cap = ACS_TEST_CAP,
+				    .ctrl = ACS_REQ_FLAGS };
+
+	KUNIT_EXPECT_TRUE(test, acs_isolated(test, &cfg, ACS_TEST_CAP, no_rr));
+
+	cfg.fail_read = true;
+	KUNIT_EXPECT_FALSE(test, acs_isolated(test, &cfg, ACS_TEST_CAP, no_rr));
+}
+
 /*
  * pci_acs_egress_ctrl_is_set(): drive the config-space reads with a fake pci_ops
  * so the Egress Control Vector lookup is exercised without real hardware --
@@ -591,6 +769,9 @@ static void acs_walk_thru_host_bridge_test(struct kunit *test)
 static struct kunit_case pci_acs_test_cases[] = {
 	KUNIT_CASE_PARAM(pci_acs_p2pdma_decision_test, acs_decision_gen_params),
 	KUNIT_CASE_PARAM(pci_acs_egress_port_valid_test, egress_valid_gen_params),
+	KUNIT_CASE_PARAM(pci_acs_flags_enabled_test, acs_isolation_gen_params),
+	KUNIT_CASE(pci_acs_flags_no_cap_test),
+	KUNIT_CASE(pci_acs_flags_read_fails_test),
 	KUNIT_CASE(acs_egress_vector_bit_set_test),
 	KUNIT_CASE(acs_egress_vector_bit_clear_test),
 	KUNIT_CASE(acs_egress_high_port_index_test),

-- 
2.55.0

