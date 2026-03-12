Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB93C3448
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320587; cv=none; b=cs5dd77g7RL3d9/v5nG/1ArwOom0MVCTU/t2NXuUFZGkzWERCBACsFOXnhoNw9bbb29YTFYrgGzsk3jZ8+rw3VAgEH18KNmYDaxvzeDoX4rM/XemB7RukPTux5WwVeQtcmRHxwwtQ2s2ZLjL0VvAdD8UmSlfYUvncdJDWcCWoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320587; c=relaxed/simple;
	bh=meuG9n5L6aNvyn3cXdHCwJgthimX8fFYDlxQC/V/6V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2mAgfQpH2SYo0v4b9pqvsBWCkbt7tEn9io3fnILTtSMbQoYK5a+IIvUk93TRlF+TM8I6EuoEUxOI27DkAjxQt5ADHRA/PHg9eT2SwzLXMK+0ir0bixBf5YRVUhe6G6aDOlM/CwAvT4AWRlZ6T9Db3Ev8YDq4ziELm3GqF/mGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7TCiPdd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7TCiPdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D258DC4CEF7;
	Thu, 12 Mar 2026 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320587;
	bh=meuG9n5L6aNvyn3cXdHCwJgthimX8fFYDlxQC/V/6V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7TCiPddh3q0tL91hrPv2kdRgha+pJTdhAtwVq5NF+ZxtrWfxXonXz4qe68UrdEhP
	 2ule0pNbNUo6OxVtVYLOESOmJnnafqCwv7rrxuh3JLWDU09CBYLJ5sWBpVo6mM/usM
	 qJCccptSGBEx6KI+sPeYfT1LYfHjvJJ5XpDSS/iI1kHkKWcT+eDAn0wEoZZo0GMS14
	 sCm6+eXjCrkxodu+HD/VtQGu85cy7bII0LcFMoTPeHonRaybbpxk6r/1NI6VRCBZ9f
	 +Z4vQPyKyPKcUQ00LwK+gqYBq86U1oGN54Knmbl4LYRgiPfhLa7TtaeYzlqm7tUJ2z
	 9bu1sobIgVUqQ==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 03/10] PCI: endpoint: Describe reserved subregions within BARs
Date: Thu, 12 Mar 2026 14:02:31 +0100
Message-ID: <20260312130229.2282001-15-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312130229.2282001-12-cassel@kernel.org>
References: <20260312130229.2282001-12-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2617; i=cassel@kernel.org; h=from:subject; bh=+zvuU7aB/yE2RP2fbrY+cvg5J4A+c7gxjmXzbHtxLlM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI37cwOy7573oEp8csNmQsyexW/64VkLzykMff6ySVT9 tm8To0o6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE7MMYfrO86/afaMnI0CIg oC1u+GTbGqO3K37mH7ML9F50dZOu0y2G/0EvVqdqy6ZPTExJ7O7cWBsWMzuqmy0s5JP1wvuT++Y 4cwAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

Some endpoint controllers expose platform-owned, fixed register windows
within a BAR that EPF drivers must not reprogram (e.g. a BAR marked
BAR_RESERVED). Even in that case, EPF drivers may need to reference a
well-defined subset of that BAR, e.g. to reuse an integrated DMA
controller MMIO window as a doorbell target.

Introduce struct pci_epc_bar_rsvd_region and extend struct
pci_epc_bar_desc so EPC drivers can advertise such fixed subregions in a
controller-agnostic way.

No functional change for existing users.

Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 include/linux/pci-epc.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 5c59f5606869..ebcdf70aa9b9 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -200,6 +200,30 @@ enum pci_epc_bar_type {
 	BAR_RESERVED,
 };
 
+/**
+ * enum pci_epc_bar_rsvd_region_type - type of a fixed subregion behind a BAR
+ * @PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO: Integrated DMA controller MMIO window
+ *
+ * BARs marked BAR_RESERVED are owned by the SoC/EPC hardware and must not be
+ * reprogrammed by EPF drivers. Some of them still expose fixed subregions that
+ * EPFs may want to reference (e.g. embedded doorbell fallback).
+ */
+enum pci_epc_bar_rsvd_region_type {
+	PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO = 0,
+};
+
+/**
+ * struct pci_epc_bar_rsvd_region - fixed subregion behind a BAR
+ * @type: reserved region type
+ * @offset: offset within the BAR aperture
+ * @size: size of the reserved region
+ */
+struct pci_epc_bar_rsvd_region {
+	enum pci_epc_bar_rsvd_region_type	type;
+	resource_size_t				offset;
+	resource_size_t				size;
+};
+
 /**
  * struct pci_epc_bar_desc - hardware description for a BAR
  * @type: the type of the BAR
@@ -207,11 +231,15 @@ enum pci_epc_bar_type {
  * @only_64bit: if true, an EPF driver is not allowed to choose if this BAR
  *		should be configured as 32-bit or 64-bit, the EPF driver must
  *		configure this BAR as 64-bit.
+ * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
+ * @rsvd_regions: fixed subregions behind BAR_RESERVED
  */
 struct pci_epc_bar_desc {
 	enum pci_epc_bar_type type;
 	u64 fixed_size;
 	bool only_64bit;
+	u8 nr_rsvd_regions;
+	const struct pci_epc_bar_rsvd_region *rsvd_regions;
 };
 
 /**
-- 
2.53.0

