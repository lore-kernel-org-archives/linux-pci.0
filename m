Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0704A2749DC
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192941; cv=none; b=Gc+FvhKeeWbeqStsgQG194epgw943TsYAZ7Vi23fs4wAyLHNeHZjy3ZfTeGVPeCC+qHl0JF1Z153shuhJfdlpi5dHO2tFl3th/Bf6ZdBoOCBv0aoHVQhEYMLr6uIcDbAJoU4Y2a3e1HiG1R5XDiiMgfI8rUjnMPItce7bT5WPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192941; c=relaxed/simple;
	bh=IKm87XmnnaEtDSFbMKhMwRrR38oSjzjka/Yn+UjmN90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngFfxcteU8wAXFGEdS4k3uVa99o8BKTnl1A+5sJEPNrVgvjxs4NOiaOX0Xr5i8QqZjEsz0CCpkJ+NiIO9r3WC9FvihDCkdW0HSqLcIGbXyU/XiHxJpsgpj1RXHijufvQS2UnfXSu6Itap6rJl4QCfLNk/XDW4WERSzQ6YxfNND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6ErS7+N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6ErS7+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792ACC4CEF1;
	Fri, 23 Jan 2026 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769192940;
	bh=IKm87XmnnaEtDSFbMKhMwRrR38oSjzjka/Yn+UjmN90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6ErS7+Nf+GsDnGiKSBXrTid6c+hAjERUY5qAu0pV+lr1mdGvOO5TkWQMcav2FWGx
	 +i7fBwcbVNCpWr/k6L7mHnokbXSXDFC4jxCFbJO4HaB2e5mQloFKJ2HmICuscoplE9
	 VmZa17ytQgtEuhl/3fSrNxVIf2pWgBr6PeqG5639EI701th1aT53iDgCbnKeJr++sC
	 ARRGhW1hP7AjRnXOgjhfpxrbHKYQC9qRRzzcmXGeC9VNKReqfe7Jqh/0fjuEYYng14
	 bRksI1uZQnG+5/J9RAliWnGIxoP9pNkUfnSHz5A0hrTFy6ABpv8JhjSffXtl4hZzzB
	 fcLmiluYG5yxQ==
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
	dlemoal@kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 4/4] PCI: dwc: Fix missing iATU setup when ECAM is enabled
Date: Fri, 23 Jan 2026 19:28:39 +0100
Message-ID: <20260123182835.831710-10-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123182835.831710-6-cassel@kernel.org>
References: <20260123182835.831710-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4797; i=cassel@kernel.org; h=from:subject; bh=GWt7Hy5TQpeo5aVLChQ6dxObySAWS8DurjRgy25l0r0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKL9159t+Dto/vqOja17TOYJmZnhGomO2hLlYbOvTGTe ffC+3qGHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZgI1zeG/5G/zuyT8clftG2n aE9LVMLiE7K7enZZy97WeKrJwfvEYCPD/7ze3+kpVn5Cjws+Bhk2Lkxx+n531uq9LiIn9/pffP3 3Ny8A
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
dw_pcie_prog_inbound_atu() such that an error is returned if trying to
program an iATU that is outside the number of iATUs provided by the
controller.

Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Co-developed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c  |  6 ++++
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 87e6a32dbb9a..bc2e08ec515e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
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
-	ob_iatu_index = 1;
+	if (pp->ecam_enabled) {
+		ob_iatu_index = 2;
+		ret = dw_pcie_config_ecam_iatu(pp);
+		if (ret) {
+			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
+			return ret;
+		}
+	} else {
+		ob_iatu_index = 1;
+	}
+
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
 		resource_size_t res_size;
 
@@ -985,8 +990,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 			 * be shared between I/O space and CFG IOs, by
 			 * temporarily reconfiguring the iATU to CFG space, in
 			 * order to do a CFG IO, and then immediately restoring
-			 * it to I/O space.
+			 * it to I/O space. This is only implemented when using
+			 * dw_pcie_other_conf_map_bus(), which is not the case
+			 * when using ECAM.
 			 */
+			if (pp->ecam_enabled) {
+				dev_err(pci->dev, "Cannot add outbound window for I/O\n");
+				return -ENOMEM;
+			}
 			pp->cfg0_io_shared = true;
 		}
 	}
@@ -1157,7 +1168,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	 * the platform uses its own address translation component rather than
 	 * ATU, so we should not program the ATU here.
 	 */
-	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
+	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
 		ret = dw_pcie_iatu_setup(pp);
 		if (ret)
 			return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 18331d9e85be..5741c09dde7f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -532,6 +532,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	u32 retries, val;
 	u64 limit_addr;
 
+	if (atu->index >= pci->num_ob_windows)
+		return -ENOSPC;
+
 	limit_addr = parent_bus_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
@@ -605,6 +608,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 	u64 limit_addr = pci_addr + size - 1;
 	u32 retries, val;
 
+	if (index >= pci->num_ib_windows)
+		return -ENOSPC;
+
 	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
 	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
-- 
2.52.0

