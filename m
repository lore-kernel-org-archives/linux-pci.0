Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D413164AA
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 01:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502420; cv=none; b=JOBNFnK3PozcfA4o1zcHmissqa2bM1GHx+TaWWtgbHHyA3VHrTQMQM5645/an//Lue21eganO8SRWSYiJc0mxISzSKP4bJNaGbfvWJF+HIsPu9Rb7IkC14Zo5EjVV3kC4/KB3R/YUXRAb5PieUGepRn6k6RnLl2iJkknJyPFR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502420; c=relaxed/simple;
	bh=3IC8ljJJCajOS64tee02XBTHEwA4qXXnJRcjly4kkyI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YrqDa06okUi3yvaV4FmT1tzoJ1n+hPXUcOauNJ6toDvjjbjrT4YEidI3QgTbRkqyXdZKNeWvZwIgq4PKdp8iZKjowhi6hkeGHlJdWqjluYEGPUPZaxZHAVXERzt9AMjVAjTwXAuHNuohIGjWMdoLqfLJEHrl/Ld8Ll/wiN2rQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AyhzdipD; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AyhzdipD"
X-UUID: da81bb5a16a211f1bcd7499a721e883d-20260303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/0sEz2jINBRcc5irANs4F/1esK/f5shwDnPb1VrGRpU=;
	b=AyhzdipDzLnPrFUb27ADVujk9CLn+LGCxDWOjVBSB0JNKecd0I8oaqQlNbymcgJOoPswadaqmuVJytolhCW5H2yGLoLPv6baWXnuwFCmYjYU7Q+BweqFZTcf2/JQEQZFtljN1zjU6S0sbzq347s7ddFZlIo6WrNZSl4pNRtmViQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:c5922b4b-19c2-4fc4-8f5e-c222c1cd75aa,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:89c9d04,CLOUDID:1f2d2ff1-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|1
	6|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: da81bb5a16a211f1bcd7499a721e883d-20260303
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 693904821; Tue, 03 Mar 2026 09:46:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Mar 2026 09:46:51 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 3 Mar 2026 09:46:50 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>
CC: Jianjun Wang <jianjun.wang@mediatek.com>, Manivannan Sadhasivam
	<mani@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>, Ryder Lee
	<ryder.lee@mediatek.com>
Subject: [PATCH] PCI: mediatek: fix W=1 snpringf warnings
Date: Mon, 2 Mar 2026 17:46:48 -0800
Message-ID: <b835e360b42c5e0994f9301a34dbdf140a8d3ef5.1772493898.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N

Fix the following errors in W=1 builds.

  $ make W=1 drivers/pci/controller/pcie-mediatek.o
    CALL    scripts/checksyscalls.sh
    DESCEND objtool
    INSTALL libsubcmd_headers
    CC      drivers/pci/controller/pcie-mediatek.o
  drivers/pci/controller/pcie-mediatek.c: In function ‘mtk_pcie_parse_port’:
  drivers/pci/controller/pcie-mediatek.c:963:43: error: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 6 [-Werror=format-truncation=]
    963 |         snprintf(name, sizeof(name), "port%d", slot);
	|                                           ^~
  drivers/pci/controller/pcie-mediatek.c:963:38: note: directive argument in the range [0, 2147483647]
    963 |         snprintf(name, sizeof(name), "port%d", slot);
	|                                      ^~~~~~~~
  drivers/pci/controller/pcie-mediatek.c:963:9: note: ‘snprintf’ output between 6 and 15 bytes into a destination of size 10
    963 |         snprintf(name, sizeof(name), "port%d", slot);
	|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 5defa5cc4..75722524f 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -953,7 +953,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 	struct mtk_pcie_port *port;
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	char name[10];
+	char name[20];
 	int err;
 
 	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-- 
2.45.2

