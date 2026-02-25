Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBFE3DA7E4
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039048; cv=none; b=luKsCFml5pOtdnDZVsFk4RPwkHCPDsZQnTdsV+Rp4ht8c9uIdIKqpmQOiMbSLRs+K1yl714daiYdRxwpWbEMjg5NrBz+4N5arYN/Laqt23YKOkHZLwcsbYOuKYjmzh+yPAFtiVBV2yJoorocGeOPhC05Os0w75SGnNx5w4yJxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039048; c=relaxed/simple;
	bh=dI9dpoOe8KiafoQWZwc+gJ/j5TIrXYj7fc8HnsEJKhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oymq59JZ0V1tkRCkfjM0E+QcrU+68qFGDj9BGUr8sr97T/grs1LZgn5Ify/7knST2bsBLYS40JVH9/0qEKp/SDfrVb5R8gUdsjHGyVbpNE3IwydhzqVl3DRIQEEeaQDwzxcoGcOYtWyy/zBU5d3SfsSVkBgyUtdksaAAZgUb9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leUhAS06; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leUhAS06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEFAC4AF09;
	Wed, 25 Feb 2026 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772039048;
	bh=dI9dpoOe8KiafoQWZwc+gJ/j5TIrXYj7fc8HnsEJKhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=leUhAS06qKt25h0tVcu/l4s6+Q3slvD4D6WhZC9qXqjhqv3mGCzvCZTj6V203YqST
	 pZjQrvtABMCUV3ZZ8zK3ljcpB9TEMiLPNz/F1Z6Y8UK4OsPHiDkyT4yUreC/5DsdHf
	 R1JhuQPHwcduUv4L21A2VDU9SNO4wJKzTBVfJfoMQgWTPY47rbKeXxGvYh6M3j0Ikp
	 H6LnV6Is6LIVzlPbWSQCFNPKAiPWGhCsbezYQV0C8xgNrWaWAaFFX9WQuDVTqWevx9
	 Py5/RfAuD1ra6NjUeEIdDF88qwr8/+6r/Zny7rfPDXYnrXT7U82g1Rx04WEivuOB9a
	 nr21MafeC0qQw==
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
Subject: [PATCH v2 4/9] PCI: endpoint: Introduce pci_epc_bar_type BAR_DISABLED
Date: Wed, 25 Feb 2026 18:03:27 +0100
Message-ID: <20260225170324.4033466-15-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225170324.4033466-11-cassel@kernel.org>
References: <20260225170324.4033466-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3181; i=cassel@kernel.org; h=from:subject; bh=dI9dpoOe8KiafoQWZwc+gJ/j5TIrXYj7fc8HnsEJKhI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLnayevNDh8+55EYs1aXyvmV2r1xmIreIMrdwbGHoxY+ k/PKPRDRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACby9TDDHx7GqTuZWl0nJPKv MZl39lu3Hff33K0FwkLB/yb5RnEbnGBkeGQ2/c+/ZYIWvBtXfa9nVrW58NPWff2/HQrpEutX9u9 1YgYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a pci_epc_bar_type BAR_DISABLED to more clearly differentiate from
BAR_RESERVED.

This BAR type will only be used to describe a BAR that the EPC driver
should disable, and will thus never be available to an EPF drive.
(Unlike BAR_RESERVED, which will never be disabled by default by an EPC
driver.)

Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Co-developed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c |  5 +++--
 include/linux/pci-epc.h             | 12 ++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 1ad2f62963c8..32cf9a9bc365 100644
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
index f7f48f43d370..63a24ebf144c 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -191,7 +191,14 @@ struct pci_epc {
  * @BAR_RESIZABLE: The BAR implements the PCI-SIG Resizable BAR Capability.
  *		   NOTE: An EPC driver can currently only set a single supported
  *		   size.
- * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
+ * @BAR_RESERVED: Used for HW-backed BARs (e.g. MSI-X table, DMA regs). The BAR
+ *		  should not be disabled by an EPC driver. The BAR should not be
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

