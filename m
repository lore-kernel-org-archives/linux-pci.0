Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72E3CC9FE;
	Fri, 10 Apr 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830910; cv=none; b=evsNIdlPsvRqsZd2cxLcNCScLn1qvVH06HNafPkzN1BYqub+/bU4H6H7iLo94XF2P3vApRk1SFpJxtXB/P0eGAfcbgQvTMST2CFThFJXbc3g63Da5RatRzw9TztebRJ2uLYFyYjFKqONVEMCpSkc9eQTWGh7yD7GV/79FxLGAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830910; c=relaxed/simple;
	bh=mj+0sVSjFeUkkMrad9vpDnizLn5nTozOCDoU1Sq9Y9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NqzKQUVqNY6Os61f9wPhD2dMD3HU7LmGmZMu2WA1xX8JGIhaDimgKz7d67qkW3w9l+Cphd6+jFCF3kzn3KFsWAXBdLGQH7+4igv4QwN3TzH7shoQpwFaprihb0C2NML9q3YaBm0WUkTOzrfdP1HG2k8gIUKMkjcpOOJ3qxSW248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=c+OFWgl+; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="c+OFWgl+"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A6ajbh347876;
	Fri, 10 Apr 2026 07:21:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=+Qakn0FJV2FBpwkXmougwk+
	gggl5jahhhLBXSrL2j1Q=; b=c+OFWgl+LR3bgAeItfhdudp5CQUUTm+3Ob0R6N8
	n3gM92l0gR2yErQYdrp+S4ty9RMEOHfmRloTC2AFnhdRFtcYTSFBmiPfzvGjgRDX
	F7ijCOi0NJCcN15Q/DF5UmKmaxxU0uyP1Q2dWmNT8XtKq8xFtBLPSRpmmaCAn1Zw
	5XnrnttsFG1uOaAMQOJMO9NG721CIRWX2nkl0XInYGAo/OcU6gI9ILBwQA5YayYi
	peSdNBNmnz9zSXd4CJlplKrU7oaEx6S4GCIfoaNPOGqhiLTSknicrAXK6HmBg5mX
	ZeYS9zdsNp/I29PthtnEYMFFeltsPPk0A6FR2wscdfft1nw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dee00jpkj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 07:21:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 10 Apr 2026 07:21:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 10 Apr 2026 07:21:40 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 657243F708D;
	Fri, 10 Apr 2026 07:21:36 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
CC: <will@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <mani@kernel.org>, <robh@kernel.org>, <vidyas@nvidia.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] PCI: host-common: Request bus reassignment when not probe-only
Date: Fri, 10 Apr 2026 19:51:24 +0530
Message-ID: <20260410142124.2673056-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEzNCBTYWx0ZWRfX7j/IeWNhisvw
 qzoHbH2T+OyCoQukUsfQzLK5/IfjHD14qCEeITvLDCnBg4Z3lN5++gtg5guO2CA+YvyLJbiRH9n
 /v3xDKTRDFUtnUvGlGOBG/o43AirYcRvKJ7FYNlDl58budH/QP9CNcDGzfnu1usvdXgb1Ud5dNu
 fKBBb7OEa7L3fm45Qs6mXjncAWZKKxvQ6uceDNCVXNWx8kTQh2DD1f2GCqR3QFjTmXI45W29UVy
 rnTtkb9gMFHldnTol39f/7OtfoAPzOmYrlFCbILazHLmRwiw6XYUJ5I4xoHjEvcwzhEL8CHExfF
 7wQ6PTMGoCyjUhGIm5uclZgJCmIOl3/QpURoteXHH8GlWglNy5l04jPVOKdotECwHeDmOD3t1A8
 A8HZVsfKr3EFDRiv1dTGMhk1U9HB7dT4M2b4G14icE+TvLArohxD9cM1QMmCjmXZya3nQTggaaI
 xFK3qgMD8Q4eFjniHVA==
X-Authority-Analysis: v=2.4 cv=M/d97Sws c=1 sm=1 tr=0 ts=69d90775 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=UhbZHETWtGs1wiOFpMcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: YyaNPm2MXTb1M0cv0B4Im0gwWN2FQ2kB
X-Proofpoint-ORIG-GUID: YyaNPm2MXTb1M0cv0B4Im0gwWN2FQ2kB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01

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
Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
Link: https://lore.kernel.org/netdev/adcXzcz2wWJFw4d7@rkannoth-OptiPlex-7090/
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/pci/controller/pci-host-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5..860783553cca 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -68,6 +68,10 @@ int pci_host_common_init(struct platform_device *pdev,
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
+	/* Do not reassign resources if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->enable_device = ops->enable_device;
-- 
2.43.0

