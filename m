Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5B362150
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526669; cv=none; b=CcIDIQsOzif2zydDsZ7Ftc+0G9BydIyOAMJRUqbtptg6thOEV/vUF44atZnHWAGmBtODljvvbaKnxbo2rn+VHTf5T8ndrTZl3YJOdITmjKULQL80cnlZQw1dPuf8vyU9U9+EExQuu4FQjdN2MLkHkscfxVGIuVTJrEF4v5nlJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526669; c=relaxed/simple;
	bh=iA0BeG3GDhg3aKeENiiQXBULyLdoQYuMu4cWuTq2h0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zc+Th/t+dYAYP/j79OR/4df35dfxuyZe6DTyJ0+n6AAYFfLuVeRYu84/xoADYQGJp5eXsIjxem5vGseGi+kL9mbJ+PwpW0t0+LH/ow72A9T9L+vl+ZIQGmrIXzuuMv+UECFDzeUdd4HP9NSmrC66rK9DKegbKPwK9uG5JDpbCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA5/Xz9/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA5/Xz9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5678FC116C6;
	Tue, 27 Jan 2026 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769526668;
	bh=iA0BeG3GDhg3aKeENiiQXBULyLdoQYuMu4cWuTq2h0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WA5/Xz9/cNGWUg/wNHuvjyzLG+WuJfeTJUjXVBOSJQ8iS2wo5osl17p5jC+s5rn4Q
	 V1tK+bhURi4WswdEgBQmiGT1B/e1fh7DevRU21UgcGzG/aj4bP2WEGvLfss0rEJ7aX
	 zi6/f+qD/Zeyd9Ss0AtwEQXLsTHPu+LrNh/dchX0HCAap3JHarHIvY0jluY5hJw0uI
	 UJuoG+khJmS9d2uALTwX5lu2WADd38twqZmSQLR/zq14rROY0mSBZJuzzs/5TT74eO
	 OCn7dlitPR3EIj09DrLGCujCPLIJikCk8puEhi2d0II1c7RIqzxWLvG6YR9W7HrZX7
	 90tDaRf1L1+Sg==
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
	stable+noautosel@kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 3/3] PCI: dwc: Fix missing iATU setup when ECAM is enabled
Date: Tue, 27 Jan 2026 16:10:41 +0100
Message-ID: <20260127151038.1484881-8-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127151038.1484881-5-cassel@kernel.org>
References: <20260127151038.1484881-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4893; i=cassel@kernel.org; h=from:subject; bh=UaOZI6lVGWYbfg3JrxNe3W19aiUVPfxoQJxpHxY5Zms=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIrrha7212sL6+ZN6WKtbzd2OA4+2afg/f6fosz1/kef abYuvJzRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbid5yRYVJRrcDsi2tlE86Y XFwSnb68+2Thxv9bvn8/f3ifTXHZu3eMDJ2p0xUldi7tEG3Palg9p3HnC+fuH9v2rI/v/WTzxXr jFx4A
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
Cc: stable+noautosel@kernel.org # depends on Clean up iATU index usage in dw_pcie_iatu_setup()
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

