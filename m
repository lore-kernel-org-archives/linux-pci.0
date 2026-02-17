Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6B2F6193
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363669; cv=none; b=CNju4cRy639uexXp2Jh4ywU005fihGQ7h52xDQ5SiYBGeGKOpBskhEWoH8rqhgizGzjfbG7AGWtA1cPey86ovHsCgliBaaeWzrvMx5v5YE8OVuuiwwI3+spnHiUcp5zOJOX/4YSeX6F+7MZCu3HwkVgqzUVqklMG7OU+Lf8NVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363669; c=relaxed/simple;
	bh=VPbMv/PkjtZ3UWX+jkT8rcxLFj4fqCA1qbDMLkV3TVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXR0/DQEf3x+GJE/VRIUb8gGOfoRgN9YQ+4RWYNId9nJWu6w2c9aaw1wjzKnOYMsv2Wc+HzrdrOdHYwqAkGoriGbeSn40mfLHxkBwujgmujoCe3yvrkOdw82zLR80foCrgkgKds7/zHyO1OTdG9G2R2fhg51VJclAYlNnBdntB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OugIoRFY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OugIoRFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42949C2BC86;
	Tue, 17 Feb 2026 21:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771363668;
	bh=VPbMv/PkjtZ3UWX+jkT8rcxLFj4fqCA1qbDMLkV3TVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OugIoRFYyKAn+8riHPrETvweCcY0vRTmbP9N3hRrjCmmFVlPpjvnioC/fzMvlRTPJ
	 AIKveo5m0W3PoPsb5p2TvPYhe64M8mjpRSkPMK6p8qcvJ9ZDvF9DMoz9FXGYdGZzY2
	 QrolHjSxTAY6DDCXCkXZpIgTVlnN7p4jjDPEZLoo91J5sdDV405nIwb9/VtlhS2nsC
	 2XNHPXnbKbpgqMVbxR6xqrjdzjcuTUqxJEzTg3VQZQ7qw4lwaaw87b6hDc8jU5cPE2
	 YkshRZfNzMroW91N0MYownVS4b+j3JJYPa1fx5g0qo8dgMsiv7IywaDkFX5p8ryHKF
	 OECdOqYa7SUPA==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/9] PCI: endpoint: Describe reserved subregions within BARs
Date: Tue, 17 Feb 2026 22:27:08 +0100
Message-ID: <20260217212707.2450423-13-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217212707.2450423-11-cassel@kernel.org>
References: <20260217212707.2450423-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441; i=cassel@kernel.org; h=from:subject; bh=5LxGGG8BxSoGZMMP2Trj4tSfd3JRKgXWdNZoem6Teas=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKn3NWta6mz1rnv75ZoP+36vYY5d45syvB44j7x1aHLZ 5tupFSt6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEvjxh+MNj9adiR1JBMXfd xAeZzNwmtQ8YPN84vav5WicUkp8c4M7wVzyhZQd34lXLmUUmT7e9/9R8StSh9MJTRZ9TLbwXY5Y 95AYA
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

Signed-off-by: Koichiro Den <den@valinux.co.jp>
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

