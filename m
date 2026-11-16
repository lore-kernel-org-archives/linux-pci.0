Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847886;
	b=A3DNn5fzOKIbBTQd9gB1ouzGmd3OzYIX/8Ob1tH7z/EAseadPKAkBiyZSyoDe8rYZBni
	 3BzCMBHz2dKZELDWNO4xXnIy2ZLH+4JZ+Ob0BgywIinLocIDcnDDLhLEU80fcORWngsdj
	 0vfijThEHG6FUJ0cxY/AabAEhxbAgugRBx6O5GGkg+MHfjocl7dC5dtbuVDB1LwyQQ8yP
	 bLIT+gGsbKY2oicN4+mxhbVx0eSQqc4enFfT286tbG/BGutRnh0d1LcQnV5NWdj8mYmDJ
	 6vYq40nhYeeVbuS79Vn5Y9pKwMgj6NAmAMHmVm8Vu+KBv+o0rcm3rLTDabq6ChcCyGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847886;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=MZhxN0GOkEkmV9c9ukadB8+hmDVvuIAp2F6wUJfYM44=;
	b=1vAxQcmXekU/03ls31hwzc2qR5Cvw/4AoTDUiGSbHfF7/y/3Xj1WwzgoZiJ3Dt4DlXXm
	 Kp368+LhlCxcOMpI3zoV/hoMbhMgLn3I+aX4KfrL8XnZfJtKjCNDFctie5q6xVbYaLCTy
	 z83tzDMOEfPzwNC3NObqjz6MhFC2E8GK8Dim6vG/Jp4OAc8URi85+uKlFZRUYiE4UaDx3
	 C2X+Kq+H+SoLRXnpXK6RWebszjX8ErpRBvfLveuzlP0NhBUfB5feAU1sySpqaaYgJQG1h
	 5vq+rtjyjt6RJ0WyIDc+BFCI7gwGFaO036rOnXfcnPMIHfeqrvJR3x7PPJBJE5hKhuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=U24KOrjB;
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F29606A322;
	Mon, 16 Nov 2026 16:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86F29606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=U24KOrjB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794847886; x=1826383886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MZhxN0GOkEkmV9c9ukadB8+hmDVvuIAp2F6wUJfYM44=;
  b=U24KOrjBCKVVo94LFA4UAadiKeAXMJEHKgtJGWqYdkYg/4p3Fg1ehbTm
   eh8C7gcRynhKSAed44/pTV8IGUPnh0RWEXzYJ2FXb2/H7tjf6ZJThzcej
   qlqBG5TgVhRtB/+cnuAT6U8loqml6J6TYpP+2rleimeRYAkvwyNltjS9u
   YUb5KUlyNAtZbRKiN8qtOJAFcJiwOtcaq0wD0ZDqbK8/+WcTlal8v3N68
   INmuNAmWzGTvLXjiBz1lM1MHlQ2FKTfuSw2YlOvjOtnVxrZfn91ySZBd3
   VI/9RGTnoumYR8c70+KjZ0aHFxwalyz7RZL/Cakdg7SiayTsGO/aSX53a
   Q==;
X-CSE-ConnectionGUID: EHxSkIwZRBiQ/s7UZge2Iw==
X-CSE-MsgGUID: 0NNMMF6mQzOy9kWMVAhx7A==
X-IronPort-AV: E=Sophos;i="6.27,217,1787011200"; 
   d="scan'208";a="34066588"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 16:51:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:2074]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.250:2525] with esmtp (Farcaster)
 id b5de1a6c-8f7e-429c-afd8-bec190967134; Mon, 16 Nov 2026 16:51:23 +0000 (UTC)
X-Farcaster-Flow-ID: b5de1a6c-8f7e-429c-afd8-bec190967134
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 16:51:23 +0000
Received: from dev-dsk-avivb-1a-8cc559d6.eu-west-1.amazon.com (172.19.102.34)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 16:51:22 +0000
From: Aviv Bakal <avivb@amazon.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, "Lukas
 Wunner" <lukas@wunner.de>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Zeev Zilberman <zeev@amazon.com>
Subject: [PATCH v2 3/3] PCI/PM: Keep hotplug ports out of D3 if they can't signal PME from D3hot
Date: Mon, 16 Nov 2026 18:51:10 +0200
Message-ID: <20261116165110.2773301-4-avivb@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261116165110.2773301-1-avivb@amazon.com>
References: <20261116165110.2773301-1-avivb@amazon.com>
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
index eb7f2f03d9ae..fa37dd3067cf 100644
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
@@ -3253,7 +3261,6 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->pm_cap = pm;
 	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
-	dev->bridge_d3 = pci_bridge_d3_possible(dev);
 	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
@@ -3289,6 +3296,9 @@ void pci_pm_init(struct pci_dev *dev)
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

