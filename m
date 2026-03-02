Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62006383C96
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445618; cv=none; b=EiOjgciHfXBUDnxFh0FotJrrqiwNBIZ2yZo/QJoXvsiP01c0c7XScl8i3IrSQnv1lCwQ7egUQ8H0o/SrNJMs5rJhzIXmf6n10wZ/buYpAUY1FdTklba93d8OZplVMR+JIfVcFM3B0UpEIXbUJ7NZyoqLRNY6165pLmzq+Zib59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445618; c=relaxed/simple;
	bh=ndwvYANE9sXbGWftf3MiJgq04l2ysL2lSehL3Z9v224=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxTp72SpVXFr6RoD18r2BJ0un7QAb/9L+2TrGI52E7XCRPys7tEMO/ttpGMlFkSuPkA95WsgyRuHPLqxJaUQzJJY5DlHL4LxxAg+b70+UCPkckCxNZZfzo54CnpDTEcMuOhiESD1Ibuv8hyKwvRA2PbWpPfv84gpDwDDgp1yD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9B6REge; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9B6REge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E114C19423;
	Mon,  2 Mar 2026 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772445618;
	bh=ndwvYANE9sXbGWftf3MiJgq04l2ysL2lSehL3Z9v224=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9B6REgeKt4pkmlAZn47Vl+ee/JdeRLo4Ooh8MUklnlzHPMqg1EUh0PpbfnNVK7Ob
	 wLwhKnzeMV6guO6n7aseYlEWwbTcmeoCVwCvwtwbjJbquQv3R6RDm6K3fCASwgpgM+
	 jO/+jkjXZH+poRM4YaMLu7lKM5plu15OMUNyUYvre9rBXoeH+ihtldC1mpuLCURT4U
	 McAiPAsrhZpV7k0wld1TstdcOhU1ad+kKGJ3Y9hdtJPMS2i+JR/RWBGbXwbDXkZR/8
	 pRsY2grAw2UZNcSm/LqbOzKtgZhqOTPDZuRNtC0Iq372yZxRsQ6s1NKjcvHfO33XTw
	 /PuozuSLetwDw==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 4/9] PCI: endpoint: Introduce pci_epc_bar_type BAR_DISABLED
Date: Mon,  2 Mar 2026 10:59:16 +0100
Message-ID: <20260302095913.48155-15-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302095913.48155-11-cassel@kernel.org>
References: <20260302095913.48155-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3268; i=cassel@kernel.org; h=from:subject; bh=ndwvYANE9sXbGWftf3MiJgq04l2ysL2lSehL3Z9v224=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKXxlfUfWPIv7UsjiMjgSu047Xnooirbxo7vXY+bmtQM cxP8n/VUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgInMOMzwm23lnllzlddd5P5k tTJeukhtqfnqj7+jnQ55zo1O3zRpYRXDf8f3l9+cY3z8Lfz2ni/Jf3bNWRjbeVzm8LWC7D6Z4Cl Lc1gA
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Koichiro Den <den@valinux.co.jp>
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

