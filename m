Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0E32D0E3;
	Wed,  1 Apr 2026 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013577; cv=none; b=HdqaVVm7qcA6Ih2saDXdXC5IzJ8nb+AKH2e8rYTJ6fQqrbA+5eW1oCNmlIxNsU/RFXWXnwZyLd0lebAbCj+FsZLjqYu1pjJGQaElLBfGqKNR2DcxpuTN5tgFSjZ0Y4ajp/10Q+saU3FXnkkuw9M/2vr2FgS9tr8pP7tPhYK1VVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013577; c=relaxed/simple;
	bh=RmtmV6p6Qd+mGsPuu/nT7q0ZFlpVWt7dc6HLjnmQmsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eHDySEf+VocM9hvu6e7lvHTlAt3doJq8Dxl6moZr8vpiwS1TbwuDXfXViGf9TYAoXWGmcs4xulp/uwF3m6h75KoyRKoTCXzMb5sVUf9ElZsdaD8yRpQ8t+dtgCgGTBc6Iqz5tDrPh151IWHg08xV8l1A49GDWACkcwctLNsgsqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TE27jW/I; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TE27jW/I"
X-UUID: 94f56a122d7911f19a16598d5ca7f8ec-20260401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fJgKS+xYGiuhM4C+jM+iQKuLmgPvl+plPrkSGwo6cRo=;
	b=TE27jW/I0mntBGLlvtKAZeX3Ckx1mUHM+lg3X91qfTDpC0FAJjxeWoPCHJfXVm1o7C+uP8XpGESNc1zeGjACth6CHzNpsSS4mKLSsbmGnqbZaD4EmRjWwZG4wXXR6ZLPMMQNL6MMhoaxDeMy94Esx9tZ6I09JcIRTKqYdHq7hxo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:550ac3da-97e9-4342-84cb-8b997c2ef74d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:7c2a75a7-e101-400a-acb5-0dbb5a913469,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 94f56a122d7911f19a16598d5ca7f8ec-20260401
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <jian.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1851126888; Wed, 01 Apr 2026 11:19:23 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 1 Apr 2026 11:19:22 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 1 Apr 2026 11:19:21 +0800
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
Subject: [PATCH v1] PCI: mediatek-gen3: Align PERST# sequence with PCIe CEM specification
Date: Wed, 1 Apr 2026 11:16:42 +0800
Message-ID: <20260401031917.9108-1-jian.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Fix the control sequence of PERST# during system bootup/shutdown to
meet the requirement from PCIe CEM specification. There are two major
changes in this patch:

1. Some of MediaTek's chip will stop generating REFCLK if the
PCIE_PHY_RSTB signal of PCIe controller is asserted. We have to
adjust the startup sequence as follows to ensure that PERST# will be
de-asserted after the REFCLK is stable:
Assert PHY reset and PERST# -> delay 10ms -> De-assert PHY reset ->
delay 100ms -> De-assert PERST#

2. Add 'shutdown' callback to control the timing of PERST# and power
during the system shutdown phase, ensuring that PERST# is active
before the power on connector is removed.

Signed-off-by: Jian Yang <jian.yang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 39 +++++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index a94fdbaf47fe..66d177918565 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -62,6 +62,7 @@
 #define PCIE_PHY_RSTB			BIT(1)
 #define PCIE_BRG_RSTB			BIT(2)
 #define PCIE_PE_RSTB			BIT(3)
+#define PCIE_BRG_RST_RDY_MS		10
 
 #define PCIE_LTSSM_STATUS_REG		0x150
 #define PCIE_LTSSM_STATE_MASK		GENMASK(28, 24)
@@ -133,6 +134,7 @@
 #define MAX_NUM_PHY_RESETS		3
 
 #define PCIE_MTK_RESET_TIME_US		10
+#define PCIE_MTK_PDN_PERST_TIME_MS	5
 
 /* Time in ms needed to complete PCIe reset on EN7581 SoC */
 #define PCIE_EN7581_RESET_TIME_MS	100
@@ -430,6 +432,21 @@ static int mtk_pcie_devices_power_up(struct mtk_gen3_pcie *pcie)
 		return err;
 	}
 
+	/*
+	 * Some of MediaTek's chips won't output REFCLK when PCIE_PHY_RSTB is
+	 * asserted, we have to de-assert MAC & PHY & BRG reset signals first
+	 * to allow the REFCLK to be stable. While PCIE_BRG_RSTB is asserted,
+	 * there is a short period during which the PCIe internal register
+	 * cannot be accessed, so we need to wait 10ms here.
+	 */
+	msleep(PCIE_BRG_RST_RDY_MS);
+
+	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
+		/* De-assert MAC, PHY and BRG reset signals */
+		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
+		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+	}
+
 	/*
 	 * Described in PCIe CEM specification revision 6.0.
 	 *
@@ -439,9 +456,8 @@ static int mtk_pcie_devices_power_up(struct mtk_gen3_pcie *pcie)
 	msleep(PCIE_T_PVPERL_MS);
 
 	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
-		/* De-assert reset signals */
-		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
-			 PCIE_PE_RSTB);
+		/* De-assert PERST# signal */
+		val &= ~PCIE_PE_RSTB;
 		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
 	}
 
@@ -459,6 +475,14 @@ static void mtk_pcie_devices_power_down(struct mtk_gen3_pcie *pcie)
 		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
 	}
 
+	/*
+	 * Described in PCIe CEM specification revision 6.0.
+	 *
+	 * The PERST# gose active before the power on the connector is removed.
+	 * Wait a while to ensure the voltage transition of PERST# is completed.
+	 */
+	msleep(PCIE_MTK_PDN_PERST_TIME_MS);
+
 	pci_pwrctrl_power_off_devices(pcie->dev);
 }
 
@@ -1266,6 +1290,14 @@ static void mtk_pcie_remove(struct platform_device *pdev)
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
@@ -1404,6 +1436,7 @@ MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
 static struct platform_driver mtk_pcie_driver = {
 	.probe = mtk_pcie_probe,
 	.remove = mtk_pcie_remove,
+	.shutdown = mtk_pcie_shutdown,
 	.driver = {
 		.name = "mtk-pcie-gen3",
 		.of_match_table = mtk_pcie_of_match,
-- 
2.45.2

