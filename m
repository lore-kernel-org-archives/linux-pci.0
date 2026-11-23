Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450845;
	b=NUOZ3B2hlc86sn58MJAnejbIshDqhQDm0Dil6rQT9Hyp+KMFVPJCj/o8Z9johzOWV+fz
	 KhoXAhJ778UoiRVmt588agXhr2WewvEKE997v9uuDx1/FVP4ejKn6Xz6bTvbW6W6xNipU
	 ZJZSnwgZRV7tfy5pzeWtvAtWjlmwbH11ozEZeky9PdbMAvOrT0pGbNbCm3JC/Ho78G3lg
	 zRXQN2vWGz4B5qfk/W+8s/F5QxFdj2lsofqUZ24Gin83lIwDJXhBxZ1jU/hvvbZClqzAd
	 8V2e70WRG2zI5jqbsqLz6kfmCNX9ssxHQi3ana61kKV6TCU69eOFS1Oxbgl7/A91KkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450845;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=jiorvTbex8xNRbSFcyEOA9X1zMLKOWcfRbigdWAcml8=;
	b=OKD4CxG1ZNDNHyF+zKkPjDbwxNQI0t0rGwMe0BNZwKFm9Bee9RTXpvJLP49s3iyOURE5
	 H3I4KpsdciZH6Qw/1kKxsJofu5toneHFAEh+DBwZG3lv4xh/Ylcg12wFD9yChod5kAtKT
	 vQIp/0OLKQ+FOc4SVOGV3QNXutsVXk9B/N2IBlcodG94goLWoOhhryeU39GDaondeZ9e+
	 BhgKXtkLmplJeQXvjQ1Or6S6jXYTKvWoShATVw2xYmmTEcs9AduP5Agq8vcoPkv/8IIdy
	 cL7YllMTO5dQg9U/VLQO/GBiMQGr4F/6oVM4SS8HzUwQL3c+6HlkNREDC5qhvM1+m1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b="Cw/mhI+q";
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134EF606A31A;
	Mon, 23 Nov 2026 16:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 134EF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Cw/mhI+q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795450845; x=1826986845;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jiorvTbex8xNRbSFcyEOA9X1zMLKOWcfRbigdWAcml8=;
  b=Cw/mhI+qydV0Gr6fvUZkeGdNgp535PvKqc5EYMC+thD49Giv+nqQIc7H
   QjSy5TTi0Y42YHtEjd7VmR/nKqICqKe5zDZY/ye3tAFAZlY8Skrb3zKMS
   e4xSOjvQ0MYSmWmpcueTeLfG/9n99iM1Z76MowXl5xD7mkqDs/ykYaMog
   +q7NTKt9IgkWwR0zeLekZY6B8Ep8laDu5BUN7lZ9eZlmvDj/hOIhkTJjc
   +SVrIlWdoELhRMB1/z8Crx0smnYIhc4pDEJhlNrUF1iSeU+wrKBIS1jy9
   izS3cGxD1XB2hkCTH3+/cvCZiNgIMo7zjZ+3S5fds83cCuY+ZuABbtSOt
   w==;
X-CSE-ConnectionGUID: r3z+BnVhQbCxqPU18iWaCw==
X-CSE-MsgGUID: LURIAL1kTsepXAyWHka9Tw==
X-IronPort-AV: E=Sophos;i="6.27,229,1787011200"; 
   d="scan'208";a="34899596"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 16:20:42 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:9902]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.86:2525] with esmtp (Farcaster)
 id e03af4a5-e137-45d7-8311-8c7b2037f87c; Mon, 23 Nov 2026 16:20:42 +0000 (UTC)
X-Farcaster-Flow-ID: e03af4a5-e137-45d7-8311-8c7b2037f87c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Mon, 23 Nov 2026 16:20:42 +0000
Received: from dev-dsk-machaujo-1c-d6b511e2.eu-west-1.amazon.com
 (10.253.100.8) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Mon, 23 Nov 2026
 16:20:40 +0000
From: Joshua Machauer <machaujo@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Dave Jiang <dave.jiang@intel.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [PATCH v2] PCI: Skip the CXL state update for a VF
Date: Mon, 23 Nov 2026 16:20:35 +0000
Message-ID: <20261123162035.79133-1-machaujo@amazon.de>
X-Mailer: git-send-email 2.47.3
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

set_pcie_cxl() runs for every added device. It first refreshes the CXL
state of the upstream bridge, which walks that bridge's extended
capabilities and recurses up to the Root Port, and then searches the
device's own extended capabilities for the Flex Bus Port DVSEC.

For a VF neither step changes anything. A CXL device exposes its Flex
Bus Port DVSEC through Function 0 (CXL r4.0, sec 8.1.8), so the search
in a VF finds nothing and the VF's is_cxl stays false. The bridges
above a VF are the ones above its PF, which were already refreshed when
the PF was added. Because enabling SR-IOV adds the VFs one after
another, each add repeats both walks without effect.

Return early for a VF. Every device keeps the is_cxl value it has
today, and the bridges above the PF are no longer refreshed during a
VF add.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Joshua Machauer <machaujo@amazon.de>
---
v2:
- Shorten the commit log (Dave)
- State that VF adds no longer refresh the bridges above the PF, and
  cite the spec section in the comment (Richard)

v1: https://lore.kernel.org/all/20261119164219.51540-1-machaujo@amazon.de/

 drivers/pci/probe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..e302f9dabddd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1717,6 +1717,15 @@ static void set_pcie_cxl(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return;
 
+	/*
+	 * A CXL device exposes its Flex Bus Port DVSEC through Function 0
+	 * (CXL r4.0, sec 8.1.8 "PCIe DVSEC for Flex Bus Port"), so a VF has
+	 * none. Its upstream bridges are the PF's, which were updated when
+	 * the PF was added.
+	 */
+	if (dev->is_virtfn)
+		return;
+
 	/*
 	 * Update parent's CXL state because alternate protocol training
 	 * may have changed
-- 
2.47.3

