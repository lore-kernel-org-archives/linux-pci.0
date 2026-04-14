Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11547248881;
	Tue, 14 Apr 2026 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154669; cv=none; b=YHth7ky1miwYWQThHICww1xQMSvWSMxEKyHJ9JV9oZ2UlDF0JGUWuEzAE7UVWfVaKYUt7B8+mAjPVB2o0Hc/ffffu72gAdrpce2YUB38Ojk3mC28BcYAsCZKcP8Nz0z3wH8F4wVU9dbUNSu0TP/C5gpnDD4zXrE7ZKB5mq63HLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154669; c=relaxed/simple;
	bh=jotw/qlnbEICEuGbOPe8n0ek2CAFz4Obecfjdb4BVhM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gnkiiuscGULZwXTiducZoRkI/neeJB5ioyQPMNmlbIAAsI3QmhKTLjER/CyfF2fzyBRJz/RPyeTdqD3/nUZnp2tQDEeJURIo3/L4v/uitM1LQ/imL0E+yblYCOXf8K/bV+qqj647Qe4xDQQOkUGTwADmwWtjBsdBuLDywSwLT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Yr0gzlN+; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Yr0gzlN+"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLAAZB2633898;
	Tue, 14 Apr 2026 01:17:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=gNNg448gdtUS+tAAC0N3jqL
	6fwbj0HrHTEoB0pDAWaA=; b=Yr0gzlN+ZT8gSiQ1l7GEIW7rzEyCtc0z8JN4Ic7
	R1QV0TSmTF+bzDCEelXTASNO6gnO7I2gjgM2+9GKAc++u2J/kVItLBGlEP60QNSP
	ZVHPa0vwZzkt7Ef6RYqEgd2PlXITCoaqLtTMDa0uavLqQ/5er8KyHn3FBSO5gdGm
	XziM6fL0tr193i/ZkjFC0Lx/1xmo/YPVnk+uiBGRnyPoYGdUeNd6O2bNaA+arZ96
	A2RM5rgxBlw7rPQYRcZuLEbZh70oeupppZZ+/XcLfVX7eUjBjdBw+Pxdgag4vwYX
	EnzaKF8nB+IchPyelWY+8118W69LD9xMV/fhTFmdbp8Nj1A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dh85b973n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 01:17:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 14 Apr 2026 01:17:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 14 Apr 2026 01:17:37 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 78E8C3F7043;
	Tue, 14 Apr 2026 01:17:33 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
CC: <will@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <mani@kernel.org>, <robh@kernel.org>, <vidyas@nvidia.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2] PCI: host-common: Request bus reassignment when not probe-only
Date: Tue, 14 Apr 2026 13:47:30 +0530
Message-ID: <20260414081730.3864372-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA3NiBTYWx0ZWRfX1bhEJ+fcl08Y
 1j7VyRaCWjL+jGuUFTyDO2i/VRXoA6wDPByq8YD9WCLrdXe/AtoWod6iDZ1ysbdW3Mq4PUXX3hF
 pjYwWI5Uc1z2epF0JHTxHJwU98G1H6ol7ZScNvDqWVo9xrRbEAUnk+3LGMPaV2ueVTHeir7J6jy
 xrofM0/UlLUUDIqbUgsRB2NdHbMo2KymjZdkZ3KxOALpq+m/iWmwghtdkBrqHYsLPZJmocOWRjj
 L9FMkURg90j6rUd86HcH75UEbkv1j1I4Tt7uRHjsXfmIBrKw12QKmPN740UV4iWAtHsn8iO0KE/
 YGPB+4ZrX3g1KRnXn90RN5tLq8wLLxJtsXdVjwZHico9WuZ/y9ewusIh0znvxx3v45KLGyHzLzq
 BDHLgu+1dNwuz8o2UI2kwagvlPhA5eS0kypxIG3ZV+rtrTlYKtYE+av3lYxjApSL5MJLSpRvdyY
 TLsLRYfD+qDN4C472wA==
X-Authority-Analysis: v=2.4 cv=F8NnsKhN c=1 sm=1 tr=0 ts=69ddf821 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=Ikd4Dj_1AAAA:8
 a=r5FkvgvYKeOTjkmYp6cA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: RYAIEn4WFZppLB0I8P04sw0j07gu5wz_
X-Proofpoint-ORIG-GUID: RYAIEn4WFZppLB0I8P04sw0j07gu5wz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01

pci_host_common_init() is used by several generic ECAM host drivers.
After PCI core changes around pci_flags and preserve_config, these hosts
no longer opted into full bus number reassignment the way they did
before.

When PCI_PROBE_ONLY is not set, add PCI_REASSIGN_ALL_BUS so
pci_scan_bridge_extend() takes the reassignment path: bus numbers can be
assigned from firmware EA data (e.g. pci_ea_fixed_busnrs()). Skip the
flag in probe-only mode so existing assignments are not overridden.

CC: Bjorn Helgaas <helgaas@kernel.org>
CC: Vidya Sagar <vidyas@nvidia.com>
CC: Manivannan Sadhasivam <mani@kernel.org>
Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
Link: https://lore.kernel.org/netdev/adcXzcz2wWJFw4d7@rkannoth-OptiPlex-7090/
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v1 -> v2 : https://lore.kernel.org/linux-pci/20260410142124.2673056-1-rkannoth@marvell.com/
---
 drivers/pci/controller/pci-host-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5..99952fb7189b 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -68,6 +68,10 @@ int pci_host_common_init(struct platform_device *pdev,
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
+	/* Do not reassign bus numbers if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->enable_device = ops->enable_device;
-- 
2.43.0

