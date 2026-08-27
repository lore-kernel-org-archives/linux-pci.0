Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFC43D50E;
	Thu, 27 Aug 2026 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823583; cv=none; b=q+J8t4DL1IxOp+IbxLJTx7BF8b9RJk8jnxUdP6WthNyvhcjUWuUroBQJtwSTDT73W9LeW5nI5jUDrofZj/ZwTaXqG2Gl9J4YxaIOqU2JrRFlvCDb4cmFjvHKNtlWkZZICMTUua8okOxkRlR3ZY3CyYzKOXToQE/Tb0qzTC02zSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823583; c=relaxed/simple;
	bh=s0Eq4yoMm4TIyvptiyH7uIUTwi7ED+e2e5uUwjUeQDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tjss4MYVe27qN5nsQPx7Q4WceixVpsbpQK/Fr0irFz0Jc89rHnqcVjMOkfyvhL7KxuL/24Uy//ohvoBckvAeRGNgmH6qeOnjOU96sr66ZiZVbckr6Xt2+q0oeWWob8eKztehqGFi/Ml7MsUzTx82tDQA4x8j85CYQUqAXU+pHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 33ca1214a1fb11f19a56ed5b684f684d-20260827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:98bc76fa-3a6e-4c61-9ed2-121a71121b8e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:7e4c55709b8396e1e132c328ba1a06ae,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 33ca1214a1fb11f19a56ed5b684f684d-20260827
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 962789048; Thu, 27 Aug 2026 17:39:30 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: thierry.reding@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	jonathanh@nvidia.com,
	mmaddireddy@nvidia.com,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] PCI: tegra264: Fix Link Capabilities register offset
Date: Thu, 27 Aug 2026 17:39:19 +0800
Message-Id: <20260827093919.2825467-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI Express Link Capabilities and Link Status registers are at offsets
0x0c and 0x12 from the capability header, respectively.  Since the driver
uses 0x5a for Link Status, Link Capabilities starts at 0x54, not 0x56.

Reading a 16-bit value at 0x56 returns the upper half of the Link
Capabilities register.  When a hotplug-capable port has no link during
probe, tegra264_pcie_icc_set() consequently derives the maximum speed and
width from unrelated bits and requests the wrong interconnect bandwidth.

Use the correct Link Capabilities offset.

Fixes: 01c3c27a0ef6 ("PCI: tegra264: Add Tegra264 support")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/pci/controller/pcie-tegra264.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
index 653136db401e0..3a672d18c4d2d 100644
--- a/drivers/pci/controller/pcie-tegra264.c
+++ b/drivers/pci/controller/pcie-tegra264.c
@@ -49,7 +49,7 @@
 #define XAL_RC_BAR_CNTL_STANDARD_64B_BAR_EN	BIT(2)
 
 /* XTL registers */
-#define XTL_RC_PCIE_CFG_LINK_CAPS		0x56
+#define XTL_RC_PCIE_CFG_LINK_CAPS		0x54
 #define XTL_RC_PCIE_CFG_LINK_STATUS		0x5a
 
 #define XTL_RC_MGMT_PERST_CONTROL		0x218
-- 
2.25.1

