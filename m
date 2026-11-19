Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106549;
	b=E/wQvVoVw4booZ3wMxzsqPB/Fhx5EOlmY6HqzOtrA8AipQMZ+e5scN+Rhw/dTfqequD8
	 nJi8tSUwJLPOJAnZDNBFTStyi4FgAKGb11rSyuaAPa84x9s86Q6G+JxMATJpQAYXfJyJD
	 nR6h8z+7iHoI2WuiaqUMX9C57G9dMFQCgTumF2MPBk31Tc13L0YHTXi9mWDA6h3BnYbdB
	 dEPgtLqksYWZyi700OhvPuVflbyuKsnB/qtVVjDy/MkfLwwLtjZ/+ug9cK88Lw1NYs8SI
	 YtnjQVgAwtpZTnPIaQ67ZAV+A4/asUf+mY7nfut4KZkYroZun2Di3/+Sw9rMgt/s1vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106549;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=HCeX9MaW+mCUHwmfmiIjg0vBk3qTXncD9kxTNyLIhzw=;
	b=on8xeIk3K63L387XwzdAK7k446FyGb3X1pPn2Dp+MGtERK+j7npsUpTTH8uTClfNrS98
	 8PuiT1q9ryqv3Xp8ZuyzHkVDgbh50KP4iD9tYXAF5+ZGK8ySoz9J+cw7SpTk0sGSghyin
	 Ywq/KgCUaXHH/6B7Bp/+Y9PVLzqYlmt61OH65rCNnU5L6pYS81hvOnqRUtbaKcGsHOcPe
	 A9MxbEWOOolvTBlThQGLktyUj4t6bhRxCPI6Ss88PHuZ+G7n+NJFwc0l/ykibXxHKKomp
	 MsoMaBCoAn5dyEEQzmXopfFkRVAsKMFu9nPeIfi+Ty6GiBaUgmbZ3/dSGxNGfzycC1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Z63iBD+4;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7A606A320;
	Thu, 19 Nov 2026 16:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16F7A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Z63iBD+4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795106549; x=1826642549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HCeX9MaW+mCUHwmfmiIjg0vBk3qTXncD9kxTNyLIhzw=;
  b=Z63iBD+4Kg4XoWXCQQu+MCLDuO4PFpraBe9IoGgr5iXmg6Yd/CCScmXP
   lNoM27v3VX8EimXp4RT5pYBedUD1tNFfklbf9rgdYA684WaCSYZuSlWT+
   ViCe2XbjEL+RTqbdSXa1A1Gdsf63pZTkU5Gdg2EQHasdG4ssGNgwQYZgu
   moWbGoKa7L0EcBY8YD9hPWHDLbLiqnE2vxhGkRFmBISFFANAZWB+y9mf1
   ON0CU2GhD83EbwMJrFOf7l7Q6X5J/r5A0v0RAhkPOT0KtG6MR425fcIix
   hVZDpOBFpju8Zmx3Xhs+h7752hBAz/c57naL+wYLU7DHWWvG8mdH8IoRQ
   w==;
X-CSE-ConnectionGUID: 8dd13qEMTqykiNTMvDMbkQ==
X-CSE-MsgGUID: 6xA1OTETQYOl4hvfQGZUsQ==
X-IronPort-AV: E=Sophos;i="6.27,221,1787011200"; 
   d="scan'208";a="34557199"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 16:42:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:16999]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.61:2525] with esmtp (Farcaster)
 id 9dc21a8d-4b5c-4cc1-a707-914de7983430; Thu, 19 Nov 2026 16:42:26 +0000 (UTC)
X-Farcaster-Flow-ID: 9dc21a8d-4b5c-4cc1-a707-914de7983430
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 19 Nov 2026 16:42:26 +0000
Received: from dev-dsk-machaujo-1c-d6b511e2.eu-west-1.amazon.com
 (10.253.100.8) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Thu, 19 Nov 2026
 16:42:24 +0000
From: Joshua Machauer <machaujo@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [PATCH] PCI: Skip the CXL state update for a VF
Date: Thu, 19 Nov 2026 16:42:19 +0000
Message-ID: <20261119164219.51540-1-machaujo@amazon.de>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

set_pcie_cxl() runs for every device that is added. It first updates
the CXL state of the upstream bridge, which walks that bridge's
extended capabilities and recurses up to the root port. It then walks
the device's own extended capabilities for the Flex Bus Port DVSEC.

For a VF neither walk can change anything. A CXL device exposes its
Flex Bus Port DVSEC through Function 0 (CXL 4.0, section 8.1.8), so
the search in a VF finds nothing and the VF's is_cxl stays false.
pci_upstream_bridge() resolves a VF through its PF, so the bridge is
the one that was already updated when the PF was added.

Enabling SR-IOV adds the VFs one after another, and each add repeats
both walks against the same bridges.

On an NVIDIA Vera system, enabling 256 VFs on a PF whose upstream
bridge has 18 extended capabilities takes 296 ms instead of 402 ms.
Enabling 32 VFs on a Rubin GPU takes 218 ms instead of 235 ms. The
times are for the write to sriov_numvfs, with the PF bound to
pci-pf-stub and VF driver autoprobe disabled, so no VF driver probes.

Return early for a VF. Every device keeps the is_cxl value it gets
today.

Signed-off-by: Joshua Machauer <machaujo@amazon.de>
---
 drivers/pci/probe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..34acebd1c706 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1717,6 +1717,14 @@ static void set_pcie_cxl(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return;
 
+	/*
+	 * A CXL device exposes its Flex Bus Port DVSEC through Function 0,
+	 * so a VF has none. Its upstream bridge is the PF's, which was
+	 * updated when the PF was added.
+	 */
+	if (dev->is_virtfn)
+		return;
+
 	/*
 	 * Update parent's CXL state because alternate protocol training
 	 * may have changed
-- 
2.47.3

