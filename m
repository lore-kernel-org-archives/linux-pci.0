Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A5E39448A
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445612; cv=none; b=q9/hrkMH2BnZb+J4yoQPmta8lfqZrnhup/ygb+anVrf05LLqTr6wnPySx0lZ2sIwJr/S2FgMEjm2G4h5MWS2mitKbET+Dxp7LxWK4JAHic63OmlkBiDvfH921QSl+SImqjRoIuP3yJrku4wvMx+tgzNzEaMeO6O7TqnWdnoukac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445612; c=relaxed/simple;
	bh=rWZpzgfI5B23VAvnHjXamlB5XE/OJ7p8W3rsAINOb+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6Vih0XcIJ0uJ1Hwvx480j4qBuQF+PBAFOeIZUekhxzdfBBUlPymX4RqgYNpWvb55CaE6KRWoghrIuwCu2HReMxlPl6NBdA57G+duj0yUmvLpHcHRtRbSAtDY3KZAKPJPbkCyGYWjqBS4/ND69ow04kXFUnYiSa9toaiR4bBSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By48yOUH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By48yOUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37519C2BCAF;
	Mon,  2 Mar 2026 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772445611;
	bh=rWZpzgfI5B23VAvnHjXamlB5XE/OJ7p8W3rsAINOb+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=By48yOUHMQokjqE3wKlnt/qbi62EiljfEH0DnccPUhMLMYTLi6VeYrw91uw0cAnyo
	 nWNtjdEbApKzXKkxwGdRKhG47I+vmipV8jc/kt7RvTGDSGHTwz2L545W7W4AzFqIOK
	 ZBAUZ8v4YZUaxefzSS7hFhwuVIu20LHBrFqVBDzASeezqybJvUzSkvkBZ4hTdzRoK7
	 OV/zo5/w60KD2YhkG48tCpD6BrCtPCymyx2vBpMz6q/5PBRqEnjwvIVHEutGikLQfq
	 0guw1qaeXlP4z0wgcPp6sK1Ho5lIUiNe+Ip9FFcFgqVj9ziTiNI5c+A60JeZOFwSAB
	 9gXBXT2FX/pCQ==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 2/9] PCI: endpoint: Describe reserved subregions within BARs
Date: Mon,  2 Mar 2026 10:59:14 +0100
Message-ID: <20260302095913.48155-13-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302095913.48155-11-cassel@kernel.org>
References: <20260302095913.48155-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2586; i=cassel@kernel.org; h=from:subject; bh=RYE4FGiPiyuBvJrsDrJdxMoXjUHbpT65C0Nr2gt7yLA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKXxper6nXFrru8SOrL11p5C4PauKMB0zssZ/B8qVL0U Na5lfi9o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPpL2JkmGPD8OjQ1fx273/T Pr46dP/M9Wmec+QOhM+R3H2L4btFBQMjw4fusjnFx3cY/zXcrL74yt3nau80UnweJzUY2P2WUJu 1hhcA
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
index c22f8a6cf9a3..f7f48f43d370 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -203,6 +203,30 @@ enum pci_epc_bar_type {
 	BAR_64BIT_UPPER,
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
@@ -216,11 +240,15 @@ enum pci_epc_bar_type {
  *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
  *		touch, then both BARx and BARx+1 must be set to type
  *		BAR_RESERVED.)
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

