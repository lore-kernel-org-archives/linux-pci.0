Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF035DCE0
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120971; cv=none; b=Vq5wmy5OhPihrUN7UHz1X9E2aVn1U17pXVpwCUuu0L22rxGYW+/TsWnHAZQTHG8XtWYu5z6ND66/YfT7po4aRp7KaIxmu/4eav0HH3ewlXbAAIZaUmjCrmnXdzjpMlTqGAUec7Po6Q37W+8brwlPz798xhawTcl4fRR1B7lKvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120971; c=relaxed/simple;
	bh=UkmYP2/X7m8xSl/WaH/iJTh2GY9MOf0nADocG1jjx/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTSuw+5HmTrkOUASuBVQ7c4jCMNCfdRfucsIEvuN5N2E4bUDOGXdI9GwPaciMdeZrA05MaKeSWttsbkCbjiqPcz1f2+Xy305MVrzhxiDmrmcj4EtWiEvBBhuo9Bt6u9yuMeimb8gLHAnYJkxPyYZAVQO84ZWE0IjrAq6vuqyIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp1rLNs+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp1rLNs+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C23C116D0;
	Thu, 22 Jan 2026 22:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769120970;
	bh=UkmYP2/X7m8xSl/WaH/iJTh2GY9MOf0nADocG1jjx/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cp1rLNs+NPdz9Cci6mULA5UBjDTWTQL60GrMaqJD8uniKacZVTidUArTTIFe8mRGr
	 Tx0yjVvSOyEFACgq5BSIx0KDGlwhkaVvmZSduduyc1kyGL2U48/roOUj/ZZZH0iU6Q
	 MoPzlqxFEBcfvBS9bhVC3J35Ra8AHnasNJLOTJR5gLtRtltqrwNr5zqE67f/FzMoFl
	 knFsdHxlPmrpdKM2/n8PHWyxQGWPsy6Jhung5Hrpkf/JO1Y/KaJygYwYNzPRYZzjzO
	 p/pu5QrKszPSEducGiDl4lGVipYhxSqTi+VU8vBJpXmAEbB4g/2aMWDdYkpchnZu3v
	 3KI2rPQg+q92A==
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
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/4] PCI: dwc: Improve msg_atu_index error handling
Date: Thu, 22 Jan 2026 23:29:16 +0100
Message-ID: <20260122222914.523238-8-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122222914.523238-6-cassel@kernel.org>
References: <20260122222914.523238-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=cassel@kernel.org; h=from:subject; bh=UkmYP2/X7m8xSl/WaH/iJTh2GY9MOf0nADocG1jjx/A=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKLluz6Vtioa67nMsmJ3bfK+/7asEl9j+9ddbg/ZbvRE 81fvY8/dJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAic18y/E/tL667LK73qpON acuNZLs88ZRP6y9vZL98hXFFbsziRT0Mv5hYdm+8dcDzmfK+INYNT6TUhC99XuAeHZj7OitSxeS VLwsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Only try to dedicate an outbound iATU to MSG TLP if use_atu_msg is set.
If use_atu_msg is not set, it is completely useless to bump the index.

Additionally, if use_atu_msg is set, and there is no available outbound
iatu available, return an error.

Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cca5fc886409..991fe5b9a7b3 100644
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

