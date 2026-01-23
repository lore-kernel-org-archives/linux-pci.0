Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6B23E35F
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192932; cv=none; b=S/LT1J9MrOS4n/gKvUq7jFJ0dpZ4TP8kNHrMsEa4UWtU7GmH6dDKvR4HDEVd4usGA6xmq2IopAYrmyC7hc6wr9AbqLmGWMLguSMBCQm1lUkziTsJScyGjlTDA+Klj5A2QS3WuEBctrWuSJyoejqRcMkzOOo3YKhvJLKdXul8mXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192932; c=relaxed/simple;
	bh=hmfENqf/sd3/VRtj4wnxTAZRV2UiOajflbJWh//T/pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spq/EBPaTfJuZZG3jYAVq8WxSl8aOFGLz0O/hZhPlurYIqI2R/vLQUhXzqxNty5VSc2mO2ZgoR4e23b9VSC7V0JAivY/7Tm+5puRN9QqvVCTiArnxJn1V+ERDno9s/IViAH8Gymcw6tsf0T8jiukNyNg4ZE758j7uVwBLgYq5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icK/tyiI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icK/tyiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51617C4CEF1;
	Fri, 23 Jan 2026 18:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769192932;
	bh=hmfENqf/sd3/VRtj4wnxTAZRV2UiOajflbJWh//T/pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=icK/tyiIdx4NavpQzz0qZ38P2HW+4RAiIgPvW7Wv+D+J4TGBkMz5rpiyWABb8+YXi
	 IJG312gYOM8FDcgdksRcVnS7P4PHu+QfIklldnQJ6KKQ3dJkNcgY5rTZHxPZlsZQpI
	 ujHyUOwkusqexZSHdBBdJDHDitm2MkFkM8edEARemczpKBpWmgGxfIxPsroqQE185Q
	 rWJHVGVVXcOs8QvkyLJptV7kjNKzaZCX5A0rep3/P9DZ2Cs9y0F0VfvZHaFNasjC5H
	 am8vmb4kKrrE/+dNjoYa4X97GgBjDNVxtsTw8mDF8TgllIq/RjdbCd/LfgxcrtQ6S7
	 JQSgJJXy0cUkA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	dlemoal@kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 2/4] PCI: dwc: Improve msg_atu_index error handling
Date: Fri, 23 Jan 2026 19:28:37 +0100
Message-ID: <20260123182835.831710-8-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123182835.831710-6-cassel@kernel.org>
References: <20260123182835.831710-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=cassel@kernel.org; h=from:subject; bh=hmfENqf/sd3/VRtj4wnxTAZRV2UiOajflbJWh//T/pk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKL9175fIPn49yHTmuSZBlVJjr5Rl3rXeX0OtHastyET WGKNY9LRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYSs4LhD89mvzCZCVdz9Ywj W1MsHxn/mbvoowJjrNnE46o2N/1en2D4nxzDNGvn6QrWpSVlYQlP9plo/Nldy/yjamP/7OYVSll sXAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Only try to dedicate an outbound iATU to MSG TLP if use_atu_msg is set.
If use_atu_msg is not set, it is completely useless to bump the index.

Additionally, if use_atu_msg is set, and there is no outbound iATU
available, return an error.

Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ae5f2d8a3857..d7f57d77bdf5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -982,7 +982,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
-	pp->msg_atu_index = ++i;
+	if (pp->use_atu_msg) {
+		if (pci->num_ob_windows > ++i) {
+			pp->msg_atu_index = i;
+		} else {
+			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
+			return -ENOMEM;
+		}
+	}
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
-- 
2.52.0

