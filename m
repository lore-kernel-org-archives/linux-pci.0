Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794763126;
	b=O/WFpZBUdN5PyOYcTTouS0+dBY3SBeAcbI6gf7oWlb6vwjhzr2d9UPGGCAFoK8bMYFmo
	 r6AaWSkamBXAVrjcXtxN0zrJOmU6dIMhmvG3Pea1q0F0Fajit+GDgGIr0pjqxtLE3dB7G
	 LcmaqCbMMTtxPNfVc8fp4NfhR3RPPkBitSZJ6GFIRHFjhwlkuK/en4O/fgXPmU37NXBK3
	 WNEsVzvb8w8YwJ6YQJFiVKnOIfcfKIqxidNNbJlpBsfluL5vTBHQyxeDoERhT09gHE7Op
	 +hyNi3yhKLIZMtJupSyXTxdHqWjvX7exwIHODbz8hcM3/kHEvl8ejh9iVsf19TQCErQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794763126;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=2uoxnOxXtTyDxInRVJmAbE2Rgc4pJQApEsm4Nsf3Nrs=;
	b=bdePRm8muodVe+o4wGyxNPDBU2S+M9zcCU5DfvJSD4jcmsjTP66G3RI7rMDzdL19f4DG
	 kgxQsUw6AnIvqBXUG6PDsDkx59giGlKpRy/tY3xUQAMvnYtbg2N0Mhf4if+Cvp/iWBrjx
	 9Jaw22CN3JBkO0tWJ+i8EiONcgV2DzkNPmERsaTvuQ/U+9sxYCwtb0+/5ISP2AxtFzcTh
	 2WfGTKphzfg1d7I+2ggLhFT5WsDmxErac/UThg17r4xwJf6F2MgfJFDKVcHQYWZdcSxIW
	 N1JhRAL5mdhXJg5g9ExM36q43nHJCY9bkHgJfcKjc2YjJrFKMk0zSfBour0X4EsHxLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Fr5O9JLo;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A0606A895;
	Sun, 15 Nov 2026 17:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 178A0606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Fr5O9JLo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794763126; x=1826299126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2uoxnOxXtTyDxInRVJmAbE2Rgc4pJQApEsm4Nsf3Nrs=;
  b=Fr5O9JLoU7SJwi26p8aOP2iPvLqbS/iyb8wAv4K9RrhrxY2mssHAITiw
   UMWj7kca+E4Wn7b4YO2YbMM1wibLMODoom9Hkk3+qpoLpydjSXQU85OSp
   uk+kFEQniAWqlJ7iBzVRwbbS477uzNNOUpBTARrfW6cKKg56zKxHM7bVP
   Zbf4MCBfOmW57zdh3AMxrIy3AixKiYM33qN9x4PCvIIVyC/u3fwRgu2yp
   tOEYbJvxzbptiA0X0FidLDGhMm9YSYKXI6uDuo57SVfOG6BqalJ75TXkv
   lA+korJvGqoSexdxyQLHdKcOM94S/aaDOAVm31MJn8BT8nh8mcbtBQwBz
   w==;
X-CSE-ConnectionGUID: Aw50QroNTZe5RIeTsSOEaQ==
X-CSE-MsgGUID: Z12sUJwZQ5mEifLdaA8kWg==
X-IronPort-AV: E=Sophos;i="6.27,215,1787011200"; 
   d="scan'208";a="34033631"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 17:18:43 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:20718]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.61:2525] with esmtp (Farcaster)
 id f8c09929-feb9-424e-92d5-7f55c9db1653; Sun, 15 Nov 2026 17:18:43 +0000 (UTC)
X-Farcaster-Flow-ID: f8c09929-feb9-424e-92d5-7f55c9db1653
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sun, 15 Nov 2026 17:18:43 +0000
Received: from dev-dsk-avivb-1a-8cc559d6.eu-west-1.amazon.com (172.19.102.34)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sun, 15 Nov 2026 17:18:41 +0000
From: Aviv Bakal <avivb@amazon.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Zeev Zilberman
	<zeev@amazon.com>
Subject: [PATCH 3/3] PCI/PM: Keep hotplug ports out of D3 if they can't signal PME from D3hot
Date: Sun, 15 Nov 2026 19:18:31 +0200
Message-ID: <20261115171831.1498006-4-avivb@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261115171831.1498006-1-avivb@amazon.com>
References: <20261115171831.1498006-1-avivb@amazon.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On runtime suspend pciehp masks the hotplug interrupt and relies on
PME to resume the port on a slot event. pci_bridge_d3_possible() does
not check whether the port can signal PME from D3hot, so a port that
cannot is not resumed by slot events.

Return false from pci_bridge_d3_possible() for such native hotplug
ports. pci_pm_init() computes bridge_d3 before it reads PME_Support,
so move that assignment after dev->pme_support is set.

Co-developed-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Aviv Bakal <avivb@amazon.com>
---
 drivers/pci/pci.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1a23be4b6a07..0b2e20e781e6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3081,6 +3081,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (platform_pci_bridge_d3(bridge))
 			return true;
 
+		/*
+		 * pciehp masks the hotplug interrupt on runtime suspend and
+		 * relies on PME to resume the port on a slot event. A port
+		 * that cannot signal PME from D3hot is not resumed.
+		 */
+		if (bridge->is_pciehp && !pci_pme_capable(bridge, PCI_D3hot))
+			return false;
+
 		/*
 		 * Hotplug ports handled natively by the OS on x86 platforms
 		 * were not validated by vendors for runtime D3 at least until
@@ -3247,7 +3255,6 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->pm_cap = pm;
 	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
-	dev->bridge_d3 = pci_bridge_d3_possible(dev);
 	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
@@ -3283,6 +3290,9 @@ void pci_pm_init(struct pci_dev *dev)
 		pci_pme_active(dev, false);
 	}
 
+	/* pci_bridge_d3_possible() looks at pme_support */
+	dev->bridge_d3 = pci_bridge_d3_possible(dev);
+
 poweron:
 	pci_update_current_state(dev, PCI_UNKNOWN);
 	if (dev->current_state == PCI_D0) {
-- 
2.50.1

