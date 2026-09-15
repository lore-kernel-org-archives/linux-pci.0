Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452B33BFAE2;
	Tue, 15 Sep 2026 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789441265; cv=none; b=oWy2NCDPlGB4og+uzQTK2gQC3T5FEfFyhHJsoySpFaO2Onm4giICo/oLBQyNfsGo9JOwatTim+Jb1mAaMArHDCmtDmbjdvSH9SdfKtfOc4Zl3iSHzCmdQRNWyCvoCVqvLqsf0yAUD1AAxmuT8bQQYwPQptb8gamzHwj+9F78DRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789441265; c=relaxed/simple;
	bh=22isUK75nn2g8V+Xx7QUG5p1IQhA79RN8XVPSAhVT08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WbeMu/XsBFRU35I0iri0YRAWbD+x0u7WZAzNJQQMt2dI4mSB6RXcd9WkTroXlUqoy4CTHKkdov8B9csXN5GmdBl+xjz8+W3zf6grWj+dgIi8GHlmRi4AiEkE1cvX1jfY5ySe7f7AWNcnfn0egx6HEDnHClk5TdYEXDo+xLdZ/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aac1c41ab0b111f19a56ed5b684f684d-20260915
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:9d5113f5-765c-4239-a4bb-2f7a9c31919e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:b7ed3df321596c1d112fe4776ccf676b,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aac1c41ab0b111f19a56ed5b684f684d-20260915
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 671556128; Tue, 15 Sep 2026 11:00:54 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Aksh Garg <a-garg7@ti.com>,
	Tom Joseph <tjoseph@cadence.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] PCI: cadence: Store the core controller in platform drvdata
Date: Tue, 15 Sep 2026 11:00:44 +0800
Message-Id: <20260915030044.4019259-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cdns_plat_pcie_probe() stores a struct cdns_plat_pcie pointer with
platform_set_drvdata(). cdns_plat_pcie_shutdown() and the callbacks in
cdns_pcie_pm_ops retrieve the same pointer with dev_get_drvdata() and
use it as a struct cdns_pcie pointer. This makes them read phy_count
and phy beyond the wrapper.

Store the wrapped struct cdns_pcie pointer instead.

Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 13edc6be21f5..7fef237cdbb7 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -55,7 +55,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	if (!cdns_plat_pcie)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, cdns_plat_pcie);
 	if (is_rc) {
 		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
 			return -ENODEV;
@@ -114,6 +113,8 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 			goto err_init;
 	}
 
+	platform_set_drvdata(pdev, cdns_plat_pcie->pcie);
+
 	return 0;
 
  err_init:

base-commit: 9a9d18547ddc97a73d5d90cff4d5aef90bd8c15d
-- 
2.25.1

