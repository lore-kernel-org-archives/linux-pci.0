Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA9552F8B
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320613; cv=none; b=LDSNs99MWUjuG692FE7vtaFSXyXd2Zw8xv0lv8aPeKjTPY/9f0uOCJZxMDO78Hm6ZJo1aZmFBfY+CEdqAty8CcHYGTai5vpPgJCzGeW/3x5vw+M0bZHglS0KcwqBpUYaQJFFzu5nPiL0cvkAA0UPgZv1Y033aS9YvBpaT1Kt5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320613; c=relaxed/simple;
	bh=KYeYSNaOiSRsuc5EvvU+T4wUhSzMG+L8k9xSmOuJGzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7Q0g0vOAvpFlzGAdeOn7+QA9x1998S4RDfEMU5r1IOMBxL5mJYGKqfubcIkpOO/LUuF2lVkNxam/NC8dJoBE1UIJ7r+YxfjKZA8KSJ3MwmVnZLO31grpVB09IxUPNAYAmaSW1Kg1CYU5DG1BJLrSb6tSzBnQEXukU2afnrL+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeEhIn1p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeEhIn1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFA1C2BC87;
	Thu, 12 Mar 2026 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320613;
	bh=KYeYSNaOiSRsuc5EvvU+T4wUhSzMG+L8k9xSmOuJGzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CeEhIn1pVe7VxkWS/vPJXeVWmf9T78HMAzyLwEbl091zR1chF1/jT9luW47W1726f
	 3qtkvvmCdxRqq27DqczZZF/a108liJc25UdDqdIhzWvKkgfuqN4XL0HZtuPztoHT31
	 bs6BbLw/hG6+DEs7c9WuXSg3N5A8O/VIf+R1qb6YKVy141mj7AP69aVoNdCO3XnPSq
	 JygF9GfJjT64BgviUIxQ7stRD67qJlGYeQcgPBLOa1ecwZesyZT299ZVXplwEKpTIi
	 tS5DnVgCD3Lf+nIJ2b1yT1eDzKw20+nYGfl37icZnQhgjK7qtGYldr2IuJOcSUlSRG
	 HF5FcsZsNrmaQ==
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
Subject: [PATCH v4 08/10] PCI: endpoint: pci-epf-test: Advertise reserved BARs
Date: Thu, 12 Mar 2026 14:02:36 +0100
Message-ID: <20260312130229.2282001-20-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312130229.2282001-12-cassel@kernel.org>
References: <20260312130229.2282001-12-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=cassel@kernel.org; h=from:subject; bh=KYeYSNaOiSRsuc5EvvU+T4wUhSzMG+L8k9xSmOuJGzM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI37cw/KP5ssbn7Qv/ZqQvnTpm351vW8iSfkt3lBSx1J 3IW7Til2lHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJ9L5gZDjb5mEmfElg83c/ i33zWD7/vG/9n+3jcZE152+9EFHcvtOD4a/Itiy/Kxa5z1z8D0RP3L9/ccDzBZp1R3ao8ORF3Pn sWc4PAA==
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

