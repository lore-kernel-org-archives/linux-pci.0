Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37840411F83;
	Fri, 21 Aug 2026 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341304; cv=none; b=moFw8DDz378nKfbjm5L1t6TcQ93JI+ITy3z28xDvhsgz4KAZg8v1shmeE6Q2R4dNNyNsGV2kzff6qIaSuXBRcKxSaGL+0X8pUaFX+bI8bsxyjkL3NpHqfe+P4HqNoRwhEJ5ggMkX/w/h0Nf62+p9tQ/GAWE4sRCjTSdItHKWIeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341304; c=relaxed/simple;
	bh=Ql0yq9A6AytjNXn8EfqZUDREWrh0Fym4XKbJeQqmyes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pz1SUBGtQ0imPOVVkJxhIIBIkaDRzrO28YG4PFxBKH4o4JVH+/cooPwsEZwkiYPJUKYG0fMB5IFWYb9LO5WfGFhQ/Cc5BwktlAp9NkF4NrozVDIij4CmZVM6jZ9wSuUyOdtr9KJnif3uaodrfMYaW9ufJh2jZolInK87dtfvSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCD2boGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCD2boGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0E51F00A3A;
	Fri, 21 Aug 2026 19:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341301;
	bh=N/KnqliWkAIRkYwzZ1JJJhbItXDsSu5zjRM3n66rLDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CCD2boGVnBfMVkUhZ52PiHv4WDb4u5j8KvxQeaxnU4Kg9EZ1OzIjyO08RXQu8Mpsi
	 TGP9hPnIClruQcZFEW/fR+JmyEZlx/i+NSeTWW6bjtAnIq9Ct/X4SLgf6LLwsnXAzE
	 +ZevaYJZR+7Vc1dwkfl6zawSozrpNBLg0IVMCba87PAndpJWJZR2VynPSBs0jXmNUd
	 V+t7nq4P9s2ijklOY5CUnEQR3eXyN3ehNduVr6y7pKgLtlf0gH2tr7d9lcOBe4ti3I
	 wM81az//uB/3s1xgmP275QM79DSIpZlwO0Iv9hiqAnu4d8MPOUVBKgumdUAnloajhR
	 rkvIP9pjqta+w==
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
Subject: [PATCH v4 08/18] PCI: Account for Direct Translated P2P in ACS isolation checks
Date: Fri, 21 Aug 2026 22:38:39 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-8-94426b96de73@nvidia.com>
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

PCIe r7.0, sec 6.12.3:

  peer-to-peer Memory Requests whose Address Type (AT) field indicates a
  Translated address must be routed to the peer Port/Function without
  redirection, regardless of ACS P2P Request Redirect and ACS P2P Egress
  Control settings.

Request Redirect therefore does not isolate devices below a Port with
ACS Direct Translated P2P enabled.

Sec 6.12.1.1 makes such a Request an ACS Violation once Translation
Blocking is enabled, and that error "must take precedence over ... ACS
P2P control mechanisms". Report isolation only in that case. Without
Translation Blocking, devices below such a Port now share an IOMMU
group.

This only holds for a caller that needs Request Redirect to isolate
peers. pci_enable_pasid() asks for Request Redirect for a different
reason: a Request carrying a PASID is routed by address alone (sec
2.2.10.4), so it has to be redirected Upstream to reach the translation
agent. Direct Translated P2P says nothing about that, because a
Translated Request already carries an address the agent produced for
that PASID (sec 10.1.3).

Give pci_acs_enabled() and pci_acs_path_enabled() a scope so each caller
states which Requests its answer has to cover, and apply the rule above
only for PCI_ACS_SCOPE_ALL.

pci_acs_flags_enabled() and the Intel SPT PCH quirk both need the rule,
so it lives in pci_acs_rr_ineffective().

Tested-by: Tushar Dave <tdave@nvidia.com>
Fixes: ad805758c0eb ("PCI: add ACS validation utility")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/iommu.c |  8 +++++---
 drivers/pci/ats.c     | 11 +++++++++-
 drivers/pci/pci.c     | 26 +++++++++++++++--------
 drivers/pci/pci.h     | 30 +++++++++++++++++++++++++--
 drivers/pci/quirks.c  | 57 ++++++++++++++++++++++++++++++++++-----------------
 include/linux/pci.h   | 30 +++++++++++++++++++++++----
 6 files changed, 124 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e8f13dcebbde..6ab32d714ce5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1502,13 +1502,14 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
 	struct pci_dev *tmp = NULL;
 	struct iommu_group *group;
 
-	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
+	if (!pdev->multifunction ||
+	    pci_acs_enabled(pdev, REQ_ACS_FLAGS, PCI_ACS_SCOPE_ALL))
 		return NULL;
 
 	for_each_pci_dev(tmp) {
 		if (tmp == pdev || tmp->bus != pdev->bus ||
 		    PCI_SLOT(tmp->devfn) != PCI_SLOT(pdev->devfn) ||
-		    pci_acs_enabled(tmp, REQ_ACS_FLAGS))
+		    pci_acs_enabled(tmp, REQ_ACS_FLAGS, PCI_ACS_SCOPE_ALL))
 			continue;
 
 		group = get_pci_alias_group(tmp, devfns);
@@ -1652,7 +1653,8 @@ struct iommu_group *pci_device_group(struct device *dev)
 		if (!bus->self)
 			continue;
 
-		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
+		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS,
+					 PCI_ACS_SCOPE_ALL))
 			break;
 
 		pdev = bus->self;
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 96efa00d9743..35c3949f39e0 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -463,7 +463,16 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pasid)
 		return -EINVAL;
 
-	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
+	/*
+	 * A Request carrying a PASID is routed by address alone (PCIe r7.0,
+	 * sec 2.2.10.4), so it has to be redirected Upstream to reach the
+	 * translation agent. Only Untranslated Requests are at stake here:
+	 * a Translated Request already carries an address the agent produced
+	 * for this PASID (sec 10.1.3), so ACS Direct Translated P2P routing it
+	 * to a peer is not a way around the agent.
+	 */
+	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF,
+				  PCI_ACS_SCOPE_UNTRANSLATED))
 		return -EINVAL;
 
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..492bb26a99de 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3545,7 +3545,8 @@ void pci_configure_ari(struct pci_dev *dev)
 	}
 }
 
-static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
+static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags,
+				  enum pci_acs_scope scope)
 {
 	int pos;
 	u16 ctrl;
@@ -3554,6 +3555,11 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	if (!pos)
 		return false;
 
+	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+
+	if (pci_acs_rr_ineffective(ctrl, acs_flags, scope))
+		return false;
+
 	/*
 	 * Except for egress control, capabilities are either required
 	 * or only required if controllable.  Features missing from the
@@ -3561,7 +3567,6 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 */
 	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
-	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
 	return (ctrl & acs_flags) == acs_flags;
 }
 
@@ -3569,6 +3574,7 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
  * pci_acs_enabled - test ACS against required flags for a given device
  * @pdev: device to test
  * @acs_flags: required PCI ACS flags
+ * @scope: which peer-to-peer Requests the answer has to cover
  *
  * Return true if the device supports the provided flags.  Automatically
  * filters out flags that are not implemented on multifunction devices.
@@ -3581,11 +3587,12 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
  * it much easier for callers of this function to ignore the actual type
  * or topology of the device when testing ACS support.
  */
-bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
+bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags,
+		     enum pci_acs_scope scope)
 {
 	int ret;
 
-	ret = pci_dev_specific_acs_enabled(pdev, acs_flags);
+	ret = pci_dev_specific_acs_enabled(pdev, acs_flags, scope);
 	if (ret >= 0)
 		return ret > 0;
 
@@ -3620,7 +3627,7 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 */
 	case PCI_EXP_TYPE_DOWNSTREAM:
 	case PCI_EXP_TYPE_ROOT_PORT:
-		return pci_acs_flags_enabled(pdev, acs_flags);
+		return pci_acs_flags_enabled(pdev, acs_flags, scope);
 	/*
 	 * PCIe 3.0, 6.12.1.2 specifies ACS capabilities that should be
 	 * implemented by the remaining PCIe types to indicate peer-to-peer
@@ -3635,7 +3642,7 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 		if (!pdev->multifunction)
 			break;
 
-		return pci_acs_flags_enabled(pdev, acs_flags);
+		return pci_acs_flags_enabled(pdev, acs_flags, scope);
 	}
 
 	/*
@@ -3650,19 +3657,20 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
  * @start: starting downstream device
  * @end: ending upstream device or NULL to search to the root bus
  * @acs_flags: required flags
+ * @scope: which peer-to-peer Requests the answer has to cover
  *
  * Walk up a device tree from start to end testing PCI ACS support.  If
  * any step along the way does not support the required flags, return false.
  */
-bool pci_acs_path_enabled(struct pci_dev *start,
-			  struct pci_dev *end, u16 acs_flags)
+bool pci_acs_path_enabled(struct pci_dev *start, struct pci_dev *end,
+			  u16 acs_flags, enum pci_acs_scope scope)
 {
 	struct pci_dev *pdev, *parent = start;
 
 	do {
 		pdev = parent;
 
-		if (!pci_acs_enabled(pdev, acs_flags))
+		if (!pci_acs_enabled(pdev, acs_flags, scope))
 			return false;
 
 		if (pci_is_root_bus(pdev->bus))
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..6230adb39166 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1045,15 +1045,41 @@ resource_size_t pci_min_window_alignment(struct pci_bus *bus,
 
 void pci_acs_init(struct pci_dev *dev);
 void pci_enable_acs(struct pci_dev *dev);
+
+/*
+ * PCIe r7.0, sec 6.12.3: ACS P2P Request Redirect does not by itself keep a
+ * peer-to-peer Request off the direct path to its target.
+ *
+ * Direct Translated P2P routes a Request carrying a Translated address to the
+ * peer regardless of Request Redirect, so Request Redirect does not isolate
+ * unless Translation Blocking rejects the Request first (sec 6.12.1.1).  It
+ * says nothing about an Untranslated Request, so a caller asking only about
+ * those is unaffected.
+ *
+ * @ctrl is the ACS Control register, @acs_flags the controls the caller asked
+ * for, and @scope the Requests its answer has to cover.
+ */
+static inline bool pci_acs_rr_ineffective(u32 ctrl, u16 acs_flags,
+					  enum pci_acs_scope scope)
+{
+	if (!(acs_flags & PCI_ACS_RR))
+		return false;
+
+	return scope == PCI_ACS_SCOPE_ALL &&
+	       (ctrl & PCI_ACS_DT) && !(ctrl & PCI_ACS_TB);
+}
+
 #ifdef CONFIG_PCI_QUIRKS
-int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
+int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags,
+				 enum pci_acs_scope scope);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
 void pci_disable_broken_acs_cap(struct pci_dev *pdev);
 int pcie_failed_link_retrain(struct pci_dev *dev);
 #else
 static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
-					       u16 acs_flags)
+					       u16 acs_flags,
+					       enum pci_acs_scope scope)
 {
 	return -ENOTTY;
 }
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..8b50cd0e5114 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4707,7 +4707,8 @@ static int pci_acs_ctrl_enabled(u16 acs_ctrl_req, u16 acs_ctrl_ena)
  * 1022:780f [AMD] FCH PCI Bridge
  * 1022:7809 [AMD] FCH USB OHCI Controller
  */
-static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags,
+				enum pci_acs_scope scope)
 {
 #ifdef CONFIG_ACPI
 	struct acpi_table_header *header = NULL;
@@ -4752,7 +4753,8 @@ static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
 	}
 }
 
-static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags,
+				enum pci_acs_scope scope)
 {
 	if (!pci_quirk_cavium_acs_match(dev))
 		return -ENOTTY;
@@ -4769,7 +4771,8 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 }
 
-static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags,
+			       enum pci_acs_scope scope)
 {
 	/*
 	 * X-Gene Root Ports matching this quirk do not allow peer-to-peer
@@ -4785,7 +4788,8 @@ static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
  * But the implementation could block peer-to-peer transactions between them
  * and provide ACS-like functionality.
  */
-static int pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags,
+					    enum pci_acs_scope scope)
 {
 	if (!pci_is_pcie(dev) ||
 	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
@@ -4856,7 +4860,8 @@ static bool pci_quirk_intel_pch_acs_match(struct pci_dev *dev)
 	return false;
 }
 
-static int pci_quirk_intel_pch_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_intel_pch_acs(struct pci_dev *dev, u16 acs_flags,
+				   enum pci_acs_scope scope)
 {
 	if (!pci_quirk_intel_pch_acs_match(dev))
 		return -ENOTTY;
@@ -4878,7 +4883,8 @@ static int pci_quirk_intel_pch_acs(struct pci_dev *dev, u16 acs_flags)
  * Port to pass traffic to another Root Port.  All PCIe transactions are
  * terminated inside the Root Port.
  */
-static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags,
+				 enum pci_acs_scope scope)
 {
 	return pci_acs_ctrl_enabled(acs_flags,
 		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
@@ -4890,13 +4896,15 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
  * and validate bus numbers in requests, but does not provide an ACS
  * capability.
  */
-static int pci_quirk_nxp_rp_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_nxp_rp_acs(struct pci_dev *dev, u16 acs_flags,
+				enum pci_acs_scope scope)
 {
 	return pci_acs_ctrl_enabled(acs_flags,
 		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 }
 
-static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags,
+			    enum pci_acs_scope scope)
 {
 	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
 		return -ENOTTY;
@@ -4976,7 +4984,8 @@ static bool pci_quirk_intel_spt_pch_acs_match(struct pci_dev *dev)
 
 #define INTEL_SPT_ACS_CTRL (PCI_ACS_CAP + 4)
 
-static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags,
+				       enum pci_acs_scope scope)
 {
 	int pos;
 	u32 cap, ctrl;
@@ -4990,14 +4999,18 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
 
 	/* see pci_acs_flags_enabled() */
 	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
-	acs_flags &= (cap | PCI_ACS_EC);
-
 	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
 
+	if (pci_acs_rr_ineffective(ctrl, acs_flags, scope))
+		return 0;
+
+	acs_flags &= (cap | PCI_ACS_EC);
+
 	return pci_acs_ctrl_enabled(acs_flags, ctrl);
 }
 
-static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags,
+				     enum pci_acs_scope scope)
 {
 	/*
 	 * SV, TB, and UF are not relevant to multifunction endpoints.
@@ -5013,7 +5026,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
 		PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
 }
 
-static int pci_quirk_rciep_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_rciep_acs(struct pci_dev *dev, u16 acs_flags,
+			       enum pci_acs_scope scope)
 {
 	/*
 	 * Intel RCiEP's are required to allow p2p only on translated
@@ -5027,7 +5041,8 @@ static int pci_quirk_rciep_acs(struct pci_dev *dev, u16 acs_flags)
 		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 }
 
-static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags,
+			      enum pci_acs_scope scope)
 {
 	/*
 	 * iProc PAXB Root Ports don't advertise an ACS capability, but
@@ -5039,7 +5054,8 @@ static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
 		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 }
 
-static int pci_quirk_loongson_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_loongson_acs(struct pci_dev *dev, u16 acs_flags,
+				  enum pci_acs_scope scope)
 {
 	/*
 	 * Loongson PCIe Root Ports don't advertise an ACS capability, but
@@ -5060,7 +5076,8 @@ static int pci_quirk_loongson_acs(struct pci_dev *dev, u16 acs_flags)
  * RP1000/RP2000 10G NICs(sp).
  * FF5xxx 40G/25G/10G NICs(aml).
  */
-static int  pci_quirk_wangxun_nic_acs(struct pci_dev *dev, u16 acs_flags)
+static int  pci_quirk_wangxun_nic_acs(struct pci_dev *dev, u16 acs_flags,
+				      enum pci_acs_scope scope)
 {
 	switch (dev->device) {
 	case 0x0100 ... 0x010F: /* EM */
@@ -5077,7 +5094,8 @@ static int  pci_quirk_wangxun_nic_acs(struct pci_dev *dev, u16 acs_flags)
 static const struct pci_dev_acs_enabled {
 	u16 vendor;
 	u16 device;
-	int (*acs_enabled)(struct pci_dev *dev, u16 acs_flags);
+	int (*acs_enabled)(struct pci_dev *dev, u16 acs_flags,
+			   enum pci_acs_scope scope);
 } pci_dev_acs_enabled[] = {
 	{ PCI_VENDOR_ID_ATI, 0x4385, pci_quirk_amd_sb_acs },
 	{ PCI_VENDOR_ID_ATI, 0x439c, pci_quirk_amd_sb_acs },
@@ -5256,7 +5274,8 @@ static const struct pci_dev_acs_enabled {
  *   0:		Device does not provide all the desired controls
  *   >0:	Device provides all the controls in @acs_flags
  */
-int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags)
+int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags,
+				 enum pci_acs_scope scope)
 {
 	const struct pci_dev_acs_enabled *i;
 	int ret;
@@ -5272,7 +5291,7 @@ int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags)
 		     i->vendor == (u16)PCI_ANY_ID) &&
 		    (i->device == dev->device ||
 		     i->device == (u16)PCI_ANY_ID)) {
-			ret = i->acs_enabled(dev, acs_flags);
+			ret = i->acs_enabled(dev, acs_flags, scope);
 			if (ret >= 0)
 				return ret;
 		}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..867c0f0970bd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -277,6 +277,26 @@ enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_EXTCFG	= (__force pci_bus_flags_t) 8,
 };
 
+/**
+ * enum pci_acs_scope - which peer-to-peer Requests an ACS check must cover
+ * @PCI_ACS_SCOPE_ALL: every peer-to-peer Request, including one carrying a
+ *	Translated address.  ACS Direct Translated P2P routes those to the peer
+ *	regardless of P2P Request Redirect (PCIe r7.0, sec 6.12.3), so it
+ *	defeats isolation unless ACS Translation Blocking rejects them first
+ *	(sec 6.12.1.1).
+ * @PCI_ACS_SCOPE_UNTRANSLATED: only Requests carrying an Untranslated address.
+ *	ACS Direct Translated P2P does not apply to those, so it says nothing
+ *	about whether they reach the Root Complex.
+ *
+ * A caller proving that peers cannot reach each other wants
+ * %PCI_ACS_SCOPE_ALL.  A caller that only needs Untranslated Requests routed
+ * Upstream, such as pci_enable_pasid(), wants %PCI_ACS_SCOPE_UNTRANSLATED.
+ */
+enum pci_acs_scope {
+	PCI_ACS_SCOPE_ALL,
+	PCI_ACS_SCOPE_UNTRANSLATED,
+};
+
 /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
 enum pcie_link_width {
 	PCIE_LNK_WIDTH_RESRV	= 0x00,
@@ -2213,7 +2233,8 @@ static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
 
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
-static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
+static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags,
+				   enum pci_acs_scope scope)
 { return false; }
 static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 				      struct device_node *node,
@@ -2710,9 +2731,10 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 }
 
 void pci_request_acs(void);
-bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
-bool pci_acs_path_enabled(struct pci_dev *start,
-			  struct pci_dev *end, u16 acs_flags);
+bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags,
+		     enum pci_acs_scope scope);
+bool pci_acs_path_enabled(struct pci_dev *start, struct pci_dev *end,
+			  u16 acs_flags, enum pci_acs_scope scope);
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask);
 
 #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */

-- 
2.55.0

