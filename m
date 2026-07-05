Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD9372662;
	Sun,  5 Jul 2026 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289325; cv=none; b=PamE9abVHfyNhR7E6tsMFCBpSFwXiBaGeT/iLCMBtNFS9LRbvQbnus/T35FnmU1K2FTHTs2aGWp8sng0y5dy2AgzSgQXIC9xgpE81SSM6OSZ367BYjbEutKcNVEr+8lVn105zZd3UbMFBwSh03vstZtMSgtTYU45L3f3nUn1obo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289325; c=relaxed/simple;
	bh=/XhqoVCDn/kX20Fh74YdSq8Sv4YSI9hjRC0Znmzapuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJaDO/SJ3AYlrjaTePV07Gs82z8Q0FDH3urKXESqcPULVuUIBkwT7X4u63MtyIjLh7aN5nTBJNvYSkB9FHcRm8W1odp7NvlcovJnmYEjkT8VvGi8nq+CfXt+iNAYCqdMfQGcxHmxksGKvRjrDFYxvN9zTKUMNgPU4ouDEOr5tzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXl8SeYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXl8SeYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E9D1F00A3F;
	Sun,  5 Jul 2026 22:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289324;
	bh=WbhKpjNECLuUoXRUVb5O0EOmC1i0wDnGAkCjBnM4mTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NXl8SeYlte+Tw4x29+IWI7e/1VY+l/kKfvr78CUNU24V6NknPJ8q6DC7EjnMlN5iw
	 FLM1kxuRzhmLps5UzegJIg+99WWEbfIi2FfPE+kGiRMT8C6k40Cu7H/bPy4d3DfdgQ
	 zbA8/rmUQraPzAnzPlfV2LSFPjq1cBmMF+GoXoMcSYufFW79OIgWn+1sLw8Zv4v/Cf
	 uR8POnSJTwSx4utR9Dsv6ra6ruFIVtYlYtFXciE3QkhTPV5T9Wju2DkyAhCQjegKsq
	 pBn5PMkVmRWud531kXBCpGL+NxJXXe4gt1qsJIxuiu+iTZYnB2f2Z/m5OZ5gJbFFXo
	 lWgsoeWhOQrgA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id F1006F40068;
	Sun,  5 Jul 2026 18:08:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 05 Jul 2026 18:08:42 -0400
X-ME-Sender: <xms:6tVKasvc_2_7RXnwYzHgSZ9vAhxanp896RMfXwBDMen_R2xTJVZvxA>
    <xme:6tVKasBEJ1j2JBWsQ9-w6O4CJo4Q4S6lV_6EHcL8WzwmHhXcFAmNTnRpk94ZCwR-d
    rexzUjPNLJ78m7SgEjuSRpDeSrQbXdIa9KSMTAqloL2A1A92Dk7Zms>
X-ME-Received: <xmr:6tVKaraamjhLXpBkqHJGIaobCoG-Qp3EF3Lv-T0gQuNiZWcNG5qKiSR1uSK9wAMPOxOHWt2hi9R5qxhnUP7YyM77Jklk_riCMiw>
X-ME-Proxy-Cause: dmFkZTFUGr5OPbYAz0wmzdhxu2JEiy8uhGQkMDfqYSUlnSOi8Hfg8ZMTwp6+b9v/qb8FVa
    Se+VxqTsdhgCG+azN+i3dmhitHrtEDj/59v5d+uXLM07ck0xFAknGLdIjNBXFn97L9ys6J
    kvacFR+67rFQ2xLVgqD1gZNrem+E4FCVahrShVpM5/LyIWEZ74ck6uQ/28sCZv8zjQC6y5
    I31k3Bf15rxY47uaSbJwGS6s0RmucOYiQ38FfEKi0+Wkg95GIxdnt0hOu9+PbfVY4hsuS5
    S/MwmCmXXaaHyGI8m93q4NOWqcTbLdEMgo0MDWywX/u/0zACTFgI9DYunJgB/DI+VfJkP3
    aCAhn7c9IbOVvZZ0ZUT9AWPS2o2zLCZAXhABSsZigRPWMF+G2qvd5Wp1Xg3MfrJNXRzOcG
    //JWIvoNRKTC8yUBTi0mLkR2icT6OoaKQ0wiivuvaJ15sSZb9x0ZHM3oBo0HJNOqU+F7b1
    p7A+g/L/9JJ2SYxyhF6R/DWKuUM+dcG9iyOFJTOUBpJCA/0tliq/Sx0CoPuePMF4cBRH91
    UIvw1Hcb50zDUNPbtvMJpdql0ArqaOgiEkaDptyF4RwyjQPn/Awruqt8ws5isb0BYSZ1D+
    ZqJt2/G6fduwjq7DGcgytOpuAm70ByxaKTpZh72h9YQY/nkbJ1q4+sp5E34g
X-ME-Proxy: <xmx:6tVKavUYKIIyegOuTAuuwT58XoljQAJJyb-_Ck5nINMY45NRJoCQlw>
    <xmx:6tVKaiPu2mpzB31lV9GuIneyL7MZcGoCUjXMAowEv6pADuvbcL359g>
    <xmx:6tVKahaNECUeervAjJK_FQjEipGbtsK4HKllhXpYnSUJoj-_nJObnw>
    <xmx:6tVKap_SHJSty0us7WvhEGDMHRKaEtEY5yM_HhmO3gps1_UJYi6OGQ>
    <xmx:6tVKaqRu4HkprawAvFJk3j-MlB_VUMrIlCZF-Pb7LOJfMSxpBDTMUy62>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:42 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: [PATCH 15/15] PCI/TSM: Add relative MMIO offset support?
Date: Sun,  5 Jul 2026 15:08:19 -0700
Message-ID: <20260705220819.2472765-16-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RMM specification, DEN0137-2.0-bet2 section A9.6.2 "Realm validation of
device memory mappings" documents the expectation that the
MMIO_REPORTING_OFFSET chosen for TDISP Interface Reports is always BAR
aligned.

Ideally this change is not needed and all implementations share the same
expectation.

If this semantic is already shipping in production and/or the PCI-SIG
clarifies that an implementation can hold this assumption then Linux will
need to ask the TSM drivers for this hint.

Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 include/linux/pci-tsm.h | 15 ++++++++++++++-
 drivers/pci/tsm/core.c  | 14 ++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 6d5fadd79360..be9f78ca2c1a 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -296,7 +296,20 @@ struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm);
 int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
 void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio);
 
-struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev);
+/**
+ * enum tdisp_offset_scheme - MMIO_REPORTING_OFFSET assumptions
+ * @TDISP_OFFSET_BAR_ALIGN: mask by bar size to recover offset
+ * @TDISP_OFFSET_RELATIVE: first mmio report per bar is bar-offset-0
+ *
+ * A TSM driver may know that the default TDISP_OFFSET_BAR_ALIGN
+ * assumption is being violated.
+ */
+enum tdisp_offset_scheme {
+	TDISP_OFFSET_BAR_ALIGN,
+	TDISP_OFFSET_RELATIVE,
+};
+struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
+					enum tdisp_offset_scheme scheme);
 int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
index 9ac216ad896d..19ad35f2da4a 100644
--- a/drivers/pci/tsm/core.c
+++ b/drivers/pci/tsm/core.c
@@ -643,13 +643,15 @@ struct pci_tsm_devif_report {
 /**
  * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
  * @pdev: device owner of MMIO ranges
+ * @scheme: allow the low level TSM driver to hint the offset calc scheme
  *
  * Return: the encrypted MMIO range descriptor on success, NULL on failure
  *
  * Assumes that this is called within the live lifetime of a PCI device's
  * association with a low level TSM.
  */
-struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev)
+struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
+					enum tdisp_offset_scheme scheme)
 {
 	struct device_evidence *evidence = pdev->tsm->evidence;
 	u64 reporting_bar_base, last_reporting_end;
@@ -712,10 +714,14 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev)
 			last_bar = bar;
 
 			/*
-			 * Determine the obfuscated base of the BAR. BAR
-			 * offsets are never obfuscated.
+			 * Either the first range per bar always maps
+			 * the start of the BAR, or the reporting_offset
+			 * is BAR size aligned.
 			 */
-			reporting_bar_base = tsm_offset & ~mask;
+			if (scheme == TDISP_OFFSET_RELATIVE)
+				reporting_bar_base = tsm_offset;
+			else
+				reporting_bar_base = tsm_offset & ~mask;
 		} else if (tsm_offset < last_reporting_end) {
 			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
 			return NULL;
-- 
2.54.0

