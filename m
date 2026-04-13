Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7453932C5;
	Mon, 13 Apr 2026 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776064460; cv=none; b=UGCdTEKFtDR7Pjp76JPPZM2smGdOJL+N2oD2Rd/KbY/JyyIED/Wndt+DHNXam4tLHH9aSwXehYO9nwClFLBb+gKX3rrE/qsb0R/pqGra3Co5BdjYK4DjVxVqjxRB0HawvqdCPLzkZhKSj0BbsMIcTwOGAltXomTFUrOBkHLNIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776064460; c=relaxed/simple;
	bh=vuwRlkZYLIxxUCOLpgylQQIFaKEpVpnkXfetnfrcOnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYGJBlM7fySnd/SJ12g3EJ6SWqoS2RVNY+xYSLfltrh+nRvLTX45gX2b/RyPz5z/7TxK3Co9bQdZlbmZwz+QFKj7LF8MZfjU/Wnspsl75gyh6CdyHBDYlFlfJdRGHboGhGvMEzggoRwMUK4c96lmko2cjz2XLw7W26dt74woz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bINiSEyW; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bINiSEyW"
X-UUID: 5f3eb93a370811f1ae70033691e9ac7d-20260413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xfFRo0UHQusuMDmGKevH0yFYeubiKUgkDDCMUWqjD1Y=;
	b=bINiSEyWMudMogYpEeJHY9RajiFIFstwyJMpLFkiDDBafhPJ8jpXAjnTr6MMicU/oXl3yAnkLmtRmmV8DCwLVyqIiJzCSL9ZnQ/ny7wu5yycwMaybldajO0j8sGWeUb68vlT+GNiCZ1PnzEFOhuwT9HJnPVzCksf1P8r3khA7+o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c10eb28e-2a09-4397-a958-80539d315422,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:8cd5cb24-cb5c-4236-a89a-9a7fb20c9bc4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5f3eb93a370811f1ae70033691e9ac7d-20260413
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jian.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 337511746; Mon, 13 Apr 2026 15:14:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 13 Apr 2026 15:14:10 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 13 Apr 2026 15:14:10 +0800
From: Jian Yang <jian.yang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ryder Lee
	<ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<jian.yang@mediatek.com>, <chuanjia.liu@mediatek.com>,
	<yonglong.wu@mediatek.com>
Subject: [PATCH 2/2] PCI: mediatek-gen3: Add a shutdown callback to cotnrol PERST# signal
Date: Mon, 13 Apr 2026 15:13:56 +0800
Message-ID: <20260413071401.1151-3-jian.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260413071401.1151-1-jian.yang@mediatek.com>
References: <20260413071401.1151-1-jian.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a shutdown callback to control the timing of PERST# and power
during system shutdown, ensuring that the PERST#, as required by the
PCIe CEM specification, is active before the power on connector is
removed.

Signed-off-by: Jian Yang <jian.yang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 58ba1aa35a22..4915979968b9 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1285,6 +1285,14 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	mtk_pcie_irq_teardown(pcie);
 }
 
+static void mtk_pcie_shutdown(struct platform_device *pdev)
+{
+	struct mtk_gen3_pcie *pcie = platform_get_drvdata(pdev);
+
+	mtk_pcie_devices_power_down(pcie);
+	mtk_pcie_power_down(pcie);
+}
+
 static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
 {
 	int i;
@@ -1423,6 +1431,7 @@ MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
 static struct platform_driver mtk_pcie_driver = {
 	.probe = mtk_pcie_probe,
 	.remove = mtk_pcie_remove,
+	.shutdown = mtk_pcie_shutdown,
 	.driver = {
 		.name = "mtk-pcie-gen3",
 		.of_match_table = mtk_pcie_of_match,
-- 
2.45.2

