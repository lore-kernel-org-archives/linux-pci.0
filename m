Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D439449C
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445638; cv=none; b=NXN/S6JgcZG25fb/UC9RC4gAF7o5B2Ww6+X7ICjMoLT4SDWy/lDO1fxk/4jqSaRn+yfbkzBns/1CmfuqI7Vve33wS5ejPeihvFsqNApdsr7e1tzMEqPWzpQ5UlMJGb+88zRUZmnyJssxUobxBkw1D3esCRfdE/f16+pRYtSj/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445638; c=relaxed/simple;
	bh=KYeYSNaOiSRsuc5EvvU+T4wUhSzMG+L8k9xSmOuJGzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVyji352vEz3988XFfr/ahofKSIKCYtZOPtuWeRL+Ald0XeZaxFtuuSUymgwfGgRsYMWn02CNdHUVmeLLBFxduxaYzlRSUL1e1x475vzLDy/jKc7pYAnxz+tOhplg5VeKXeASKcKpP3EACHrUCYmc6P+J1LebcN0ukePdhAPG3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCy34/L0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCy34/L0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A066CC19425;
	Mon,  2 Mar 2026 10:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772445637;
	bh=KYeYSNaOiSRsuc5EvvU+T4wUhSzMG+L8k9xSmOuJGzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCy34/L0twFxXkUlcyqN7IciidLfbW9LkZnjcIsB/JFH/09+Bde3BCPoZddQ0IqgV
	 p48lmzhJciO/JHTdrRAgKfylnk1lCeZ03ykhsQA61A/XzDe1mo+DJTh8osHHEbnjbd
	 ke4+ANQcX/TPpEAWp9NGkrUUHM8yfZ3mJvidyXJPFlRd4ES5HfNGRsXqWU/Yx4xECA
	 g1qNlR8Wk+Mj0Yz7stIuPi4sTPQQfHRA1p/9XcRaWmX5qyuV1dRQ1dTxYYf1yRqqYW
	 p3cThK7CHRDBYQJR+wWCHFx5HUqdNNIkmz4yOfN0iifjx4pGRq1PJeFufnKFulm1Rj
	 oXlms7G2FCtOA==
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
Subject: [PATCH v3 7/9] PCI: endpoint: pci-epf-test: Advertise reserved BARs
Date: Mon,  2 Mar 2026 10:59:19 +0100
Message-ID: <20260302095913.48155-18-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302095913.48155-11-cassel@kernel.org>
References: <20260302095913.48155-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=cassel@kernel.org; h=from:subject; bh=KYeYSNaOiSRsuc5EvvU+T4wUhSzMG+L8k9xSmOuJGzM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKXxlcfFH+22Nx9of/s1IVzp8zb8y1reZJPye7yApa6E zmLdpxS7ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEbk1iZJj4NcQuYTej84ui TydmzjON7ToheFWc447W2V0p802SMy8x/He4KSr7Y0dKBgfXH/lbE0wFJ8yNXuGiKHT//bxbxYW XG3gB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Advertise reserved BARs as reserved in the Capabilities register,
such that the host side driver will be able to skip reserved BARs.

Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Koichiro Den <den@valinux.co.jp>
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

