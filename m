Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD9392825;
	Mon, 13 Apr 2026 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776064458; cv=none; b=t59Wi7tRCpjsDoqY2Vp+ULclXrXDbHmkVRzgaXdw/ADUAWWvhIfgoUiSvyfsP/2NEkqitcaNHbyrE5xrucX3ftrIpBZIEp2SD3BT6Y20VwjIrYbQEUr/J2d0vGVF5uQBbApEJut1kDLW5QtaGTP1M+Gn2qfhSkqW++bNv39jIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776064458; c=relaxed/simple;
	bh=Cnmn2buu/BBhg4jRMHO4PlOEaMBYpDcJsakE3dc8acw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JgX+81Z0TOrUIha/XqR5GqE3U2Sb1+gnsg38JuoXHJ6lZyYAtqvL9zNVEA3KaDoGQAM389Lu99hvAokYKwxYCgrFSh7+Q1lyE2c8veD7GTEQ/+vjcY6foURgjdq3D4gRjhGvFZFGpjrTYt1v3LCYgg8MANvp3dLKL15EADHE1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UJBWpx5R; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UJBWpx5R"
X-UUID: 5d09009e370811f1ae70033691e9ac7d-20260413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+9DOIPBCDXn1gL4EYuRhhyUJKMqKeMJcK0WHANYjnaQ=;
	b=UJBWpx5Rvxo5tloIEnswGWZ9Xa7i4JKEvGpSj6WlRyLYZMw0vu6XduZXGv44MbHQgyV0LVm3mHqQyEFWzi13CVBxkyu70Vb6KTF9j0lMhJaSsQNT09+SEe2Bfp2tNgNqAr3BM5jhzJSk6jPZfdWOfpBo4MI5MKKH0Fgn+yKPoWo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9d5decaf-a3eb-420f-a3e9-974a4289e68c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:6ad5cb24-cb5c-4236-a89a-9a7fb20c9bc4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5d09009e370811f1ae70033691e9ac7d-20260413
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jian.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 625899409; Mon, 13 Apr 2026 15:14:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 13 Apr 2026 15:14:07 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 13 Apr 2026 15:14:06 +0800
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
Subject: [PATCH 0/2] PCI: mediatek-gen3: Fix the control timing of PERST#
Date: Mon, 13 Apr 2026 15:13:54 +0800
Message-ID: <20260413071401.1151-1-jian.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Dear maintainers,

The purpose of this patch series is to fix the PERST# control timing
in the MediaTek PCIe Gen3 controller driver so that it complies with
the PCIe CEM specification.

In the current MediaTek PCIe Gen3 controller driver, there are two
issues with PERST# timing:
1. During the power-up phase (i.e., before PCIe link-up), on some
MediaTek SoCs PERST# is de-asserted before the REFCLK becomes stable;
2. During system shutdown, PERST# is not asserted before power is
removed.

Patch 1 fixes the reset signal sequencing during the power-up phase.

Patch 2 adds a shutdown callback to control PERST# during system
shutdown.

Best regards,
Jian Yang

Jian Yang (2):
  PCI: mediatek-gen3: Fix PERST# control sequence at system startup
    phase
  PCI: mediatek-gen3: Add shutdown callback to cotnrol PERST# signal

 drivers/pci/controller/pcie-mediatek-gen3.c | 30 ++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

-- 
2.45.2

