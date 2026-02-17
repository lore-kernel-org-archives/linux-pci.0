Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06928C006
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363675; cv=none; b=LjkVKbrbRJfAF9hrHLjbhy+/bFhlDOGVKU1g9ftVJODGRoW3X8MlM3NupbX1FO3h9tdXlWNCAT49fW2uqiBdOfLZURsBYwSc68H3AQJRt5rVxYEMe0CSaqr+0+Z3aUEBOae37H3zKuq4nitqndF/XhVFMbb4tZtPqy6KXTQs9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363675; c=relaxed/simple;
	bh=iqhVvvUTepr/0ALGjPuaZLxc0bdqFow1MUHNKVF6XjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/1DEZTyZUiCrnavg7ur8/reucupiIW/BPFTg3QQJuyqggIS5PDgfMWWAoO2OgBjOgpqLKA0+JBBI3H9q6stq4ew/fDW9SyhQpUqXXbpF0AofY3wgGq7avVFPvhL9bvh+HI81zubX3i6VcfxmhTPjM+WtQRbr/RjkqHo4Ye+5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6MvK2id; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6MvK2id"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF9EC4CEF7;
	Tue, 17 Feb 2026 21:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771363674;
	bh=iqhVvvUTepr/0ALGjPuaZLxc0bdqFow1MUHNKVF6XjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6MvK2idLamtxGg8dO8scLvhrvZdl0Ks/Fl+gnDOcaTjlJbvbzLwMMlhbd9hTPo9X
	 wVZldKfM4iIsR+DBftuGNKym/e2VGxfqP7aMlDA8xAsYDRUS92REpArFut2nPKXA5u
	 2QCDkwSfXAJTk5iS7/41XCZj0rqvx7JYrU7g6s3mWUiXiWo5OOULAiy+Ub9aVdLj+O
	 Nd/YWLCt7KeMthJbIsxer/kqMrRbe26jH5o+7TqpQYGcw4gs6ovaqsPE9lrKUlq4Mc
	 T+yXhz93R8/xL6ORNd8zG9bBBzkdHbwVuwmFvPyT4Ub6hdyKoTVgbJw9sEKv9+S7TR
	 gI2cRXLaGaJ6g==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/9] PCI: endpoint: Introduce pci_epc_bar_type BAR_DISABLED
Date: Tue, 17 Feb 2026 22:27:10 +0100
Message-ID: <20260217212707.2450423-15-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217212707.2450423-11-cassel@kernel.org>
References: <20260217212707.2450423-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2984; i=cassel@kernel.org; h=from:subject; bh=iqhVvvUTepr/0ALGjPuaZLxc0bdqFow1MUHNKVF6XjY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKn3NWbdSV94/rqSgvjhd9YjN6w8UU9vaZhvnvR7oUVZ nGqGxL9OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARx68M/6w2RSzfunpXmd3r tYY9TpuVYo/K/lcxbYvibfiYd5R5yVeG/25HtZ3vM2S9+PDa+aujgKe+74bpHlWrH/zszkizr+I S5wIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a pci_epc_bar_type BAR_64BIT_UPPER to more clearly differentiate
BAR_DISABLED from BAR_RESERVED.

This BAR type will only be used for a BAR that the EPC driver should
disable. (Unlike a BAR_RESERVED, which is still enabled.)

Co-developed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c |  5 +++--
 include/linux/pci-epc.h             | 12 ++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 8de321e1c342..5045e22367cf 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -103,9 +103,10 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 		bar++;
 
 	for (i = bar; i < PCI_STD_NUM_BARS; i++) {
-		/* If the BAR is not reserved, return it. */
+		/* If the BAR is not reserved or disabled, return it. */
 		if (epc_features->bar[i].type != BAR_RESERVED &&
-		    epc_features->bar[i].type != BAR_64BIT_UPPER)
+		    epc_features->bar[i].type != BAR_64BIT_UPPER &&
+		    epc_features->bar[i].type != BAR_DISABLED)
 			return i;
 	}
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f7f48f43d370..8687b9c3462b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -191,7 +191,14 @@ struct pci_epc {
  * @BAR_RESIZABLE: The BAR implements the PCI-SIG Resizable BAR Capability.
  *		   NOTE: An EPC driver can currently only set a single supported
  *		   size.
- * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
+ * @BAR_RESERVED: Used for HW-backed BARs (e.g. MSI-X table, DMA regs). The BAR
+ *		  should not be disabled an EPC driver. The BAR should not be
+ *		  reprogrammed by an EPF driver. An EPF driver is allowed to
+ *		  disable the BAR if absolutely necessary. (However, right now
+ *		  there is no EPC operation to disable a BAR that has not been
+ *		  programmed using pci_epc_set_bar().)
+ * @BAR_DISABLED: The BAR should be disabled by an EPC driver. The BAR will be
+ *		  unavailable to an EPF driver.
  * @BAR_64BIT_UPPER: Should only be set on a BAR if the preceding BAR is marked
  *		     as only_64bit.
  */
@@ -200,6 +207,7 @@ enum pci_epc_bar_type {
 	BAR_FIXED,
 	BAR_RESIZABLE,
 	BAR_RESERVED,
+	BAR_DISABLED,
 	BAR_64BIT_UPPER,
 };
 
@@ -238,7 +246,7 @@ struct pci_epc_bar_rsvd_region {
  *
  *		only_64bit should not be set on a BAR of type BAR_RESERVED.
  *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
- *		touch, then both BARx and BARx+1 must be set to type
+ *		reprogram, then both BARx and BARx+1 must be set to type
  *		BAR_RESERVED.)
  * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
  * @rsvd_regions: fixed subregions behind BAR_RESERVED
-- 
2.53.0

