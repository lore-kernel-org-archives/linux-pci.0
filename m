Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142FB3E8C5D
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039068; cv=none; b=JkpwC4KxbzkCpBhBnJ/jJdNkpk0twLcyr/hplOp/LyENnVzYd/dqRIv1ffY9k3eHSHywByZ/hnAR72taNj1eAAE+rd/MTNedD4Montm70SnxF8Av0/IDtqxLhwiLNilL9p3qdG35QFACQ9KOV/lK87h7hERaR5MXW/LtOpz3iqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039068; c=relaxed/simple;
	bh=jIZhB2fBVtJtFnGVNOkjs166cBmC7x78JzvJfyKZNTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lks6pMsYP8J64wU/7sakn34RWjzH8t3P3atLFVNM5uNGilHfG6SIrkbvo3CCXdyHpLWAou/7ndlPfkpV3G8uYpYTSQUyp8NA5/IcHwZaZt8cGbkn9cTARO9BdamNjjd7s5ejqg30WQV+Y9MjgKZZiAXyjMpczLRSlDD5AQQa5XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gamphg9/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gamphg9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021AFC116D0;
	Wed, 25 Feb 2026 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772039067;
	bh=jIZhB2fBVtJtFnGVNOkjs166cBmC7x78JzvJfyKZNTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gamphg9/9fMffPjU2swXfPu647SCAVKtXxrug/msServRRB2u703VP++UeRpr+joV
	 +T71VlBpB+oI3SMOHSEILtQRwY8ZVL96diLBWIbM74c+z5X5S2oJrNbVQKERjJJsfn
	 mun3Vb8zVYgq7Pac2xLOVbGt2QmOEoWBZ6rHbIIFiMdQYnEFakG6aPlEjpfOS3z2KE
	 Wwzh4PD1zfoalfKlCJmAT9DN7Z9OA86hv8UQ1KMqiph5yAPPvJV5IqfNglOXiruB9l
	 eOHLPcU4zyOPQjsfmiGU/RyhuJFHZTFoZQdXHpsjdCuoZtGzYzNjgYy7Ps6VujB0b1
	 kMBnYuxpSpexA==
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
Subject: [PATCH v2 7/9] PCI: endpoint: pci-epf-test: Advertise reserved BARs
Date: Wed, 25 Feb 2026 18:03:30 +0100
Message-ID: <20260225170324.4033466-18-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225170324.4033466-11-cassel@kernel.org>
References: <20260225170324.4033466-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=cassel@kernel.org; h=from:subject; bh=jIZhB2fBVtJtFnGVNOkjs166cBmC7x78JzvJfyKZNTc=; b=kA0DAAoWyWQxo5nGTXIByyZiAGmfK2Wi3Bu0VtHYV1vXAUfpzWdxExmGiQdQyNPMLC2cGZy5f Ih1BAAWCgAdFiEETfhEv3OLR5THIdw8yWQxo5nGTXIFAmmfK2UACgkQyWQxo5nGTXLJnQD/cJ+i TONvWa6o49ScIa9YcUCrkdjuv7TLFdDNQd1pWyIBAJXrzPVGmPK/kCg8YGhOwJN7bmTlKynTBzL zh9ctWrwJ
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Advertise reserved BARs as reserved in the Capabilities register,
such that the host side driver will be able to skip reserved BARs.

Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 6030ae1373b1..14e61ebe1f11 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -65,6 +65,12 @@
 #define CAP_INTX			BIT(3)
 #define CAP_SUBRANGE_MAPPING		BIT(4)
 #define CAP_DYNAMIC_INBOUND_MAPPING	BIT(5)
+#define CAP_BAR0_RESERVED		BIT(6)
+#define CAP_BAR1_RESERVED		BIT(7)
+#define CAP_BAR2_RESERVED		BIT(8)
+#define CAP_BAR3_RESERVED		BIT(9)
+#define CAP_BAR4_RESERVED		BIT(10)
+#define CAP_BAR5_RESERVED		BIT(11)
 
 #define PCI_EPF_TEST_BAR_SUBRANGE_NSUB	2
 
@@ -1112,6 +1118,24 @@ static void pci_epf_test_set_capabilities(struct pci_epf *epf)
 	    epf_test->epc_features->subrange_mapping)
 		caps |= CAP_SUBRANGE_MAPPING;
 
+	if (epf_test->epc_features->bar[BAR_0].type == BAR_RESERVED)
+		caps |= CAP_BAR0_RESERVED;
+
+	if (epf_test->epc_features->bar[BAR_1].type == BAR_RESERVED)
+		caps |= CAP_BAR1_RESERVED;
+
+	if (epf_test->epc_features->bar[BAR_2].type == BAR_RESERVED)
+		caps |= CAP_BAR2_RESERVED;
+
+	if (epf_test->epc_features->bar[BAR_3].type == BAR_RESERVED)
+		caps |= CAP_BAR3_RESERVED;
+
+	if (epf_test->epc_features->bar[BAR_4].type == BAR_RESERVED)
+		caps |= CAP_BAR4_RESERVED;
+
+	if (epf_test->epc_features->bar[BAR_5].type == BAR_RESERVED)
+		caps |= CAP_BAR5_RESERVED;
+
 	reg->caps = cpu_to_le32(caps);
 }
 
-- 
2.53.0

