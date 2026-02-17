Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC6271450
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363694; cv=none; b=D93AKvu/9uhlVFaeGYsUL+y81CAhluatKVOykWPmCrpkPaXpuu9DkuB52Kc8UQUIv0bGtffXTKra7/KyE7QeFn0XsmYlWy5+IGqwYYcOGvZmEaKMAmNRWNQe8jznFCUuwUGU6A18tz5gF2XaZyNZtnELaTbufaE1AjM908xlqK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363694; c=relaxed/simple;
	bh=moOr43+8cgHi9wm8VK/VhU0rAqHCm9nUnhjiJ2bEXPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfyUU17RHjWnOWZVzO0T+l8hvJNBdn9rwexAHihv7weMrmcHrDrSeJvxXK5mKS/MU2k3CrQPuJIISWh/8/q477htLJPZtXuvkJBgMPKDXWyCfHH0znjQf8+hCoMUqVqZ6p2C2j8FKFytQzlHqtAuqOwsPWkKHmxTd/titeNE19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyZxnW1N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyZxnW1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEB6C4CEF7;
	Tue, 17 Feb 2026 21:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771363693;
	bh=moOr43+8cgHi9wm8VK/VhU0rAqHCm9nUnhjiJ2bEXPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EyZxnW1Navz3e4neb0omd0ETRXGAPGXCFRYo0Q8WRDqhigy19rTFVlq5fY5S2s1cP
	 o6VMuJtSddSO5e1AbV7dWMUhoC48ZFEkbCABmqYUm/P3a1DfE7cQS6rCenhz7gCR9z
	 Byp6rEip0JuBG9sMckr2UqgNb29qXEJOMq3Z1kcaqZyYbW7LHkwkPXTsLSZV0HjUQ3
	 yaA8YE3D5Zs6lyN2S4DEDPhcTLun28A9fdY/DF1sy3TQAT4FdNFF9eyzRNDEzShp41
	 sxADCC5CRzXD4fPnpCCNIb4se3y16mT2JqRqLAtUOhiCMSgenUURVtJIgtEYYxFgTT
	 vnLQhiNlBUXrQ==
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
Subject: [PATCH 7/9] PCI: endpoint: pci-epf-test: Advertise reserved BARs
Date: Tue, 17 Feb 2026 22:27:13 +0100
Message-ID: <20260217212707.2450423-18-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217212707.2450423-11-cassel@kernel.org>
References: <20260217212707.2450423-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=cassel@kernel.org; h=from:subject; bh=moOr43+8cgHi9wm8VK/VhU0rAqHCm9nUnhjiJ2bEXPU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKn3DVoDuK66WDs3jgt5etcO5WO2kSpoqy4SRJsD5Jf1 8y573S6o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABMpOMzI8OHsnuKw7y2it1U0 5r2K1nDbFVpt55Qr8StslsGLTwdmbWVk2CP/xWebaZpWsUffn/8tsW3p9ZM/L2CdqBLLuGfN3bw 8PgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Advertise reserved BARs as reserved in the Capabilities register,
such that the host side driver will be able to skip reserved BARs.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 0cb7af0919dc..4c7e42fe5d8e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -64,6 +64,12 @@
 #define CAP_MSIX			BIT(2)
 #define CAP_INTX			BIT(3)
 #define CAP_SUBRANGE_MAPPING		BIT(4)
+#define CAP_BAR0_RESERVED		BIT(5)
+#define CAP_BAR1_RESERVED		BIT(6)
+#define CAP_BAR2_RESERVED		BIT(7)
+#define CAP_BAR3_RESERVED		BIT(8)
+#define CAP_BAR4_RESERVED		BIT(9)
+#define CAP_BAR5_RESERVED		BIT(10)
 
 #define PCI_EPF_TEST_BAR_SUBRANGE_NSUB	2
 
@@ -1106,6 +1112,24 @@ static void pci_epf_test_set_capabilities(struct pci_epf *epf)
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

