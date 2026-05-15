Received: from outbound.baidu.com (mx21.baidu.com [220.181.3.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3897526ED3E
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807069; cv=none; b=t8OWkY1ZTbcPs0l3ldzNNOXkZ4cCc/zg1LUW/yPUEhbeORysBiOunXIF0iWi6y7AnwQ+6ZoeXasU5CTzSMWJ/jO6g4OdZhRjt7660GN1npHR8bgEIeU4VclzTy0XwHuRM15VJmdCbVHbHdp/WP4ENmc+m00O/QzZSVTOcJxH798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807069; c=relaxed/simple;
	bh=Pp2XdUbL6cDiOBigDPPY+4jPM4epWg6B3Z+coj9SyeQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MGAjmXdgNuOTX0l4YehURULSi+a+0JieKDjbf27Kmf2y0a3bR6oBaJmzojumOOw9TIcdF7cwjom/9JKH5FNr5SInD3zL7E6/RAVcCK0nfCQZvXyLOeujgLu2LPSah2B1YdjiBA69XO6ABzqo8dfX1gnAr67extYDnD88Qx5IwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=ooUBJKVI; arc=none smtp.client-ip=220.181.3.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="ooUBJKVI"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
	<jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] PCI: mediatek: Fix operator precedence in PCIE_FTS_NUM_L0 macro
Date: Thu, 14 May 2026 20:55:52 -0400
Message-ID: <20260515005552.2343-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc11.internal.baidu.com (172.31.51.11) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1778806563;
	bh=uNqStT8E7cOnItJb8DaxzYvszxZpCiV3YjJwPZLjb1g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=ooUBJKVI2+swknCdj2TDWMe1BIWC7Qnu8l114SYQ6Gq/3B8sO+4E3jVsJfBHN2zQk
	 IaX/KfEFkxi9JritkMiARAq2lxsKqjGDrsKhEKumwkfrUFITXZCE5zJ2con5ONQbjP
	 MXKVhE9Wi3DG+ZT/MXoSudZ4j3YLr+2skKyHQTOeVGfjcRQzdPuT4kKBq7d+oNHYUp
	 Hpj/+EkDhb2KBqVbkKLLnSVaFxIm4KFdKGIjT7Zt0orUjA/0KzLTEjal4tzOBNq9xH
	 /tje3G0z/YAqgwLMdstofbFHz9B5Edl2LT1LwRrUUuO9bU1/gCIcf5OFeDLer7vNQP
	 9SKky8N8INiow==

From: Li RongQing <lirongqing@baidu.com>

The original PCIE_FTS_NUM_L0(x) macro was buggy due to improper operator
precedence, where ((x) & 0xff << 8) was evaluated as ((x) & 0xff00).

Instead of just fixing the parentheses, use the standard FIELD_PREP()
macro. This makes the code more robust by automatically handling masks
and shifts, while also adding compile-time type and range checking to
ensure the value fits within PCIE_FTS_NUM_MASK.

Fixes: 637cfacae96f ("PCI: mediatek: Add MediaTek PCIe host controller support")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/pci/controller/pcie-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 7572252..00f0e29 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -61,7 +61,7 @@
 /* MediaTek specific configuration registers */
 #define PCIE_FTS_NUM		0x70c
 #define PCIE_FTS_NUM_MASK	GENMASK(15, 8)
-#define PCIE_FTS_NUM_L0(x)	((x) & 0xff << 8)
+#define PCIE_FTS_NUM_L0(x)	FIELD_PREP(PCIE_FTS_NUM_MASK, x)
 
 #define PCIE_FC_CREDIT		0x73c
 #define PCIE_FC_CREDIT_MASK	(GENMASK(31, 31) | GENMASK(28, 16))
-- 
2.9.4

