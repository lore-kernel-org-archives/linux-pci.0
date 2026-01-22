Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B93D2FED
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120979; cv=none; b=o8Jc94Ydaq1WywABn3263rO6UQMUm6m9PP/pUfElJpoOBXl9o3aKt3n8VLMUyLopHK1aYVTkfvZdft+vVrWyJXadRdrqDwuKOF3xLPqT197LTk7DsQacn2XTMqhySzAnUqqjooRJUrAMDLl94ypFWkihS1UGiOpbcN6S0EozGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120979; c=relaxed/simple;
	bh=vjBjxQvOTA05x6Po/7on/8jiRbri0kXmtJhAS0u0DOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHJTOvelQcbiM1s9LIpnP2m+Ydt/WrnN/LvRjCcGx2anSJONKBMji2pUiAVs2AiJ5rlZppOcXxMCltBdWPW/3X2hEUrN9EmvFUmtg593OQ3g4iC0x1GoWV2ePSmS0UZoRuofEgaDlistqCf4LqheTUJjovs1wEG03tFv2x2Zq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiM67Yx5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiM67Yx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE66C116D0;
	Thu, 22 Jan 2026 22:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769120977;
	bh=vjBjxQvOTA05x6Po/7on/8jiRbri0kXmtJhAS0u0DOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LiM67Yx556UxFdxGV59hu9cL6birHUqgr1jlb6H5A48c6l+cAizCx6NhogVBv65Sm
	 QD2IDED96dk3urOk42fBhN/y21v4o4KKFQ4aqMaM650UgmNCZOunP/PcXSKFZ7v+WF
	 H72/GYJ6iloB3jOGZo1zriOiq2Cx96uaIpNV1WH2KYGMeiz1+EhGlKaFH7CVAMY7CE
	 mhcR6fdxLwoEfhCpa9W/4i4qFzXYflGLOysJ7FF84bE+4sL2iYptblFhT9tFuVouJe
	 IDyqA7c8rz3q8uCKKyCcKRj3AJLy94SGpw20VN9xi1ZaBPYuRY51a0+AIIzwgpYz/0
	 Ga1PHQxrA32vw==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Frank Li <Frank.Li@nxp.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	tim609@andestech.com,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 4/4] PCI: dwc: Fix missing iATU setup when ECAM is enabled
Date: Thu, 22 Jan 2026 23:29:18 +0100
Message-ID: <20260122222914.523238-10-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122222914.523238-6-cassel@kernel.org>
References: <20260122222914.523238-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4896; i=cassel@kernel.org; h=from:subject; bh=q2TywhwzGXSoLBBZsoOLdqecOGkzJCqL9fzoSo++qd4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKLluwO+hl6d9/edWuyr+jdjnMNEboZWRuq17M60urE0 95rMcz+HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIOSZGhhkrYjZK3En6o/3w 4S3r2F1me45u6dtx7a1MaOOMkIMZRYmMDKdL9nLzrFT55Wn1c7pmhehCR+mHZtW/mNKbPM3/nUs WYAAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
before configuring ECAM iATU entries. This left IO and MEM outbound
windows unprogrammed, resulting in broken IO transactions. Additionally,
dw_pcie_config_ecam_iatu() was only called during host initialization,
so ECAM-related iATU entries were not restored after suspend/resume,
leading to failures in configuration space access

To resolve these issues, the ECAM iATU configuration is moved into
dw_pcie_iatu_setup(), and dw_pcie_iatu_setup() is invoked when ECAM is
enabled.

Furthermore, error checks are added in dw_pcie_prog_outbound_atu() and
dw_pcie_prog_inbound_atu() so that an error is returned if trying to
programming an iATU that is outside the number of iATUs provided by
the controller.

Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Co-developed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.c  |  6 ++++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 76be24af7cfd..ef66a031f0bb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -441,7 +441,7 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 	/*
 	 * Root bus under the host bridge doesn't require any iATU configuration
 	 * as DBI region will be used to access root bus config space.
-	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
+	 * Immediate bus under Root Bus needs type 0 iATU configuration and
 	 * remaining buses need type 1 iATU configuration.
 	 */
 	atu.index = 0;
@@ -641,14 +641,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_free_msi;
 
-	if (pp->ecam_enabled) {
-		ret = dw_pcie_config_ecam_iatu(pp);
-		if (ret) {
-			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
-			goto err_free_msi;
-		}
-	}
-
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -915,8 +907,21 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	 * NOTE: For outbound address translation, outbound iATU at index 0 is
 	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
 	 * index 1.
+	 *
+	 * If using ECAM, outbound iATU at index 0 and index 1 is reserved for
+	 * CFG IOs.
 	 */
-	ob_iatu_index_to_use = 1;
+	if (pp->ecam_enabled) {
+		ob_iatu_index_to_use = 2;
+		ret = dw_pcie_config_ecam_iatu(pp);
+		if (ret) {
+			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
+			return ret;
+		}
+	} else {
+		ob_iatu_index_to_use = 1;
+	}
+
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
 		resource_size_t res_size;
 
@@ -1157,9 +1162,10 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	/*
 	 * If the platform provides its own child bus config accesses, it means
 	 * the platform uses its own address translation component rather than
-	 * ATU, so we should not program the ATU here.
+	 * ATU, so we should not program the ATU here. If ECAM is enabled,
+	 * config space access goes through ATU, so set up ATU here.
 	 */
-	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
+	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
 		ret = dw_pcie_iatu_setup(pp);
 		if (ret)
 			return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 2fa9f6ee149e..225897c87c49 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -531,6 +531,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	u32 retries, val;
 	u64 limit_addr;
 
+	if (!(atu->index < pci->num_ob_windows))
+		return -ENOSPC;
+
 	limit_addr = parent_bus_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
@@ -604,6 +607,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 	u64 limit_addr = pci_addr + size - 1;
 	u32 retries, val;
 
+	if (!(index < pci->num_ib_windows))
+		return -ENOSPC;
+
 	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
 	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
-- 
2.52.0

