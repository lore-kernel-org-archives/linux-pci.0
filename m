Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85A44E652;
	Thu,  6 Aug 2026 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015587; cv=none; b=fOx8OyWB2Pzn6KLgW2jh6Cx+RbhLdKWXJWVhWWCk8qB7drudlZfxCDdhjxNv2Zr+NpmYxQGyZg8qm45iTKKTCM/4ZbT180nUn2rkLA77TCHhzHv0JH7gAo0wD77PDDKGbcrroLYkxOIiOhUJOuF19SA4YGLge49KrgURvPAmPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015587; c=relaxed/simple;
	bh=jpyb0zXGp6TIE9MJcV8IbSL5hMgZ6UCje6nRWEOHUFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwM0l1aDEKsJhfWO1P8VA7ljEhFRbLLgL6h+ot3gATdsYu89SY28zU1wZjhcO6fyLBHGoryFOEk1wpXs46rKCqaxovBxXwKqSzk/OzV/j2R8M+CvmRShU12JO3m7Am7ZKjzIKEU025ZUHvZgpZdwSMuuqEY+Su684OZZ3v3aI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCOPlHG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCOPlHG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2418F1F00A3A;
	Thu,  6 Aug 2026 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015585;
	bh=1wa5DouB3whHlnz+gysX/2bxWYa8g3Tko7em60mg5KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CCOPlHG1EZiX/VwQ6zXlZhKst9G0xHai6YuJw7g5QFkT+u1rwIHH4rxb3Ad9B58Yy
	 hpIsQmH+h6iUEZRz5qetMhcGFdZa5WXRVQOyPczbkHFfkvl5Kq9dxzVZPGyz49MENo
	 ElpqBgUte7J7iT1hjedvMjwbYtg9VkQBNkIPhMvXZf1XAoxaPIMkmJaK9M22X6st1F
	 4DJhod1sfqWHBpVAQDR2b035P0mgOxmbTb1fW10cc5+/cJc2wh5Nn/LYvUQiZTJPU5
	 vDywcFeALDoRzt1EYyppVmGGRvagxuggugSgGDfBjmPSY6VWFh0sN/UlB0wRrjoKNm
	 0uGhJ6CsYIsXQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Claude Opus 5 <noreply@anthropic.com>
Subject: [PATCH v2 13/13] PCI: Add KUnit coverage for ACS isolation checks
Date: Thu,  6 Aug 2026 14:24:20 +0300
Message-ID: <20260806-fix-p2p-acs-v2-13-0cec14812965@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
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
Control register and check each combination. The function is exposed
under CONFIG_KUNIT via VISIBLE_IF_KUNIT.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Assisted-by: Claude Opus 5 <noreply@anthropic.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/pci.c          |  4 +-
 drivers/pci/pci.h          |  1 +
 drivers/pci/pci_acs_test.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9e64003f8d2..0b5d6ad21582 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3621,7 +3621,8 @@ int pci_acs_egress_ctrl_set(struct pci_dev *pdev, struct pci_dev *target)
 }
 EXPORT_SYMBOL_IF_KUNIT(pci_acs_egress_ctrl_set);
 
-static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
+VISIBLE_IF_KUNIT
+bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
 	bool request_redirect = acs_flags & PCI_ACS_RR;
 	int pos;
@@ -3660,6 +3661,7 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 
 	return (ctrl & acs_flags) == acs_flags;
 }
+EXPORT_SYMBOL_IF_KUNIT(pci_acs_flags_enabled);
 
 /**
  * pci_acs_enabled - test ACS against required flags for a given device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6f200d40d69e..f519ee774300 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1060,6 +1060,7 @@ enum pci_acs_p2pdma_state {
 };
 
 #if IS_ENABLED(CONFIG_KUNIT)
+bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_egress_port_valid(u16 acs_caps, u8 target_port);
 enum pci_acs_p2pdma_state pci_acs_p2pdma_decision(u16 ctrl, bool has_target,
 						  int egress);
diff --git a/drivers/pci/pci_acs_test.c b/drivers/pci/pci_acs_test.c
index b258fc46fcaa..b01e6ca6c7d9 100644
--- a/drivers/pci/pci_acs_test.c
+++ b/drivers/pci/pci_acs_test.c
@@ -120,6 +120,102 @@ static void pci_acs_egress_port_valid_test(struct kunit *test)
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
+
+struct acs_ctrl_cfg {
+	unsigned int	devfn;
+	u16		ctrl;
+};
+
+static int acs_ctrl_read(struct pci_bus *bus, unsigned int devfn,
+			 int where, int size, u32 *val)
+{
+	struct acs_ctrl_cfg *cfg = bus->sysdata;
+
+	*val = 0;
+	if (devfn == cfg->devfn && size == 2 &&
+	    where == ACS_TEST_CAP + PCI_ACS_CTRL)
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
+	bool	expect;			/* isolation reported? */
+};
+
+static const struct acs_isolation_case acs_isolation_cases[] = {
+	{ "plain_rr", ACS_REQ_FLAGS, ACS_REQ_FLAGS, true },
+	/* Direct Translated P2P bypasses Request Redirect ... */
+	{ "dt", ACS_REQ_FLAGS | PCI_ACS_DT, ACS_REQ_FLAGS, false },
+	/* ... unless Translation Blocking rejects the Translated Request. */
+	{ "dt_tb", ACS_REQ_FLAGS | PCI_ACS_DT | PCI_ACS_TB, ACS_REQ_FLAGS, true },
+	{ "tb_only", ACS_REQ_FLAGS | PCI_ACS_TB, ACS_REQ_FLAGS, true },
+	/* Egress Control can override Request Redirect as well. */
+	{ "ec", ACS_REQ_FLAGS | PCI_ACS_EC, ACS_REQ_FLAGS, false },
+	{ "ec_dt_tb", ACS_REQ_FLAGS | PCI_ACS_EC | PCI_ACS_DT | PCI_ACS_TB,
+	  ACS_REQ_FLAGS, false },
+	/* Without Request Redirect requested, neither bit is consulted. */
+	{ "no_rr_dt", PCI_ACS_SV | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT,
+	  PCI_ACS_SV | PCI_ACS_CR | PCI_ACS_UF, true },
+	/* A control bit the caller asked for is simply missing. */
+	{ "rr_not_enabled", PCI_ACS_SV | PCI_ACS_CR | PCI_ACS_UF, ACS_REQ_FLAGS,
+	  false },
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
+	struct acs_ctrl_cfg cfg = { .devfn = PCI_DEVFN(0, 0), .ctrl = c->ctrl };
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
+	KUNIT_EXPECT_EQ(test, pci_acs_flags_enabled(pdev, c->req), c->expect);
+}
+
 /*
  * pci_acs_egress_ctrl_set(): drive the config-space reads with a fake pci_ops
  * so the Egress Control Vector lookup is exercised without real hardware --
@@ -549,6 +645,7 @@ static void acs_walk_thru_host_bridge_test(struct kunit *test)
 static struct kunit_case pci_acs_test_cases[] = {
 	KUNIT_CASE_PARAM(pci_acs_p2pdma_decision_test, acs_decision_gen_params),
 	KUNIT_CASE_PARAM(pci_acs_egress_port_valid_test, egress_valid_gen_params),
+	KUNIT_CASE_PARAM(pci_acs_flags_enabled_test, acs_isolation_gen_params),
 	KUNIT_CASE(acs_egress_vector_bit_set_test),
 	KUNIT_CASE(acs_egress_vector_bit_clear_test),
 	KUNIT_CASE(acs_egress_high_port_index_test),

-- 
2.55.0

