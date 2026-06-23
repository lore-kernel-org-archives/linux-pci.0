Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C9352010;
	Tue, 23 Jun 2026 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205720; cv=fail; b=U+3rzVmJVLKSBbMzzuf/htAzvjs861YcDzU3whUajnb1dq6lKm0zr+0Y2RYgsnr/iicwrU4le2TEgPPjUBeghqc0l9CHMbI31PQdN8As6NRLnQaK4QWbBRCYCQM/PW/OX/SEzVIXijNz3YtRKEIoohF75JvbbXpGiQ6mudr6SJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205720; c=relaxed/simple;
	bh=ZrCCjfKG4M5ehYTxfxJQwbmHyLoSyzzaNPvUGcloNCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPSFCCaljTyolhLEPjzS0aMQmHiW5mfQc/oftUeduOY7p8Ie1wC01fhVusneolq3AMZX2P58eGzyKcT2DhqEc3mwtwUqGangqwT6DdqBtY1t4wzSZBcJt/Z6xaDcAPSIo2y7A6Kkk83oROUtQNiRiQco7u/04HyPglt0YxaXaAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=gTcpDHID; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V/eO97wz; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="gTcpDHID";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V/eO97wz"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N6cWWo786403;
	Tue, 23 Jun 2026 04:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=XJnSiAoi62NSNDgMxFnyoVeO4Y0n4ZjHpVLhrloK5
	gQ=; b=gTcpDHIDbqOv86J8SVISEww+Sl1r5Lbw1bjyfhjuz5yixxAPkUYprzSoL
	EbNZYEkYNexSHjrMDciuIOUy70tAPS/V1Fl4IHxzpcCYPjtmZyo5v0scToM/lx1t
	p4LiQvEPc5pd2p5yQbZ1vToI146yi9qDYr/Ht/Y2FSzq/AD+tbbF06tMq4VWdFqd
	ZWfOiPT94IEFAAwhrwXLiqAW5jGcy5/5OxKpDLUcljHSYbakNK0AgnthFJPs8xK7
	Km5tPBslThvF0gyKdsp4oH++l+A5vHkbXOFaED0FEPdMu4rE2JB20bA3U5p0E2QH
	STpEPBzYYcUeBqxa0mUE2M8y7fs5Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	by m0380145.ppops.net (PPS) with ESMTPS id 4eyma1rygv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 04:08:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkHQoMtR8pqFS3lPxPStnKTJ6A8XVL7Kzj1CUKfBreY3NPKlx87a5iova/tdEd6VWZv9hhR4PiTHSg1+Q6NdBe0YtezVGVGPk0WPNiTuVqrnKGISqn9wrLUwStryDZelH6MA+6bflOGAZcDvTRY6bBq1wbIpReHM5/tXT7v4dlskdjjBRuKtxqGxqby1pLcWGyGkPhLeb651MExqWoejhd0xhcb9zUU9+8S1xlBwbtDtf5dhVvNYNU/uLzjiYGQ7UoIj/UcCdQ+U95Ix8rPsmwSfFlcKHkJYVvwSR9xjoJIECda5z9VJ87ddXMuo02b1RsHpegB3nfm8GJ0RckjuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJnSiAoi62NSNDgMxFnyoVeO4Y0n4ZjHpVLhrloK5gQ=;
 b=JINKZL9MDfaFR4c7wvB1iBzmWwwiUXcgxwz4UMaMIv++bofmYbdoUUMvKSzk5CmxF44uoeCa4dr5AjOS6I5DOrSZoPm5nTQwdqCy1C2XEnYP1nCEMAJVhpcTL9yBiScWGaw/632FDmUcwJRe8hfcYlJDpnoEWzcF09jCLSEXnF29ksC503kl1vL0eKHEgiPlNcrDPvFAjy4ETikk1MzXXY5LSNcfj73T5httErhRXMyG9Fazbbfw/7jQxfbrJzGDOGfzpQ5tjWZzWvyNDYCRV3mQxLlf83cpdZqr2+xH13jC8Ykrb9IvuPG+XMcDiuY5ZkI4TwAHV/UsnrmFMnrgcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJnSiAoi62NSNDgMxFnyoVeO4Y0n4ZjHpVLhrloK5gQ=;
 b=V/eO97wzj1dnkmfJMXOccjjjGDq9HipW8pemLVEWP7oNFqeb8hi8CqHPg031qS/RakfZqBk1o9hJdX5Qhkfy9fCzEQMw017rDjymBIVEBiN880jfalTjvvU3uYfoPtP00XIuSJdbJnz+lBQx0GL1a551kx9XiT4uZ5FhzriLqEg=
Received: from SJ2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:a03:505::15)
 by SJ2PR10MB7039.namprd10.prod.outlook.com (2603:10b6:a03:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 09:08:07 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::ad) by SJ2PR07CA0013.outlook.office365.com
 (2603:10b6:a03:505::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 09:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 09:08:06 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:08:05 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:08:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 04:08:05 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N97bL62520663;
	Tue, 23 Jun 2026 04:08:00 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
        <lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <rdunlap@infradead.org>, <Frank.Li@nxp.com>, <s-vadapalli@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v6 4/4] Documentation: PCI: Add documentation for DOE endpoint support
Date: Tue, 23 Jun 2026 14:37:37 +0530
Message-ID: <20260623090737.711656-5-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623090737.711656-1-a-garg7@ti.com>
References: <20260623090737.711656-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SJ2PR10MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b305ed-b1fb-4c6f-a1ab-08ded106f027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|23010399003|82310400026|1800799024|921020|13003099007|18002099003|22082099003|3023799007|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	HW3+eogOPam45C+TPcUeTaCWuCd9v6EPq1LoLYA+yCqNDGGF6i9JdIkJ5A+6Dk5LDrvhfVAn+OXlClMcEc5/+++CdpanbZN2/4fE/1k/gHSmgDpFt/pVjXiaZWbaksYsMZmZzYmmXcjUVd5/r+MnbfAMj38T5NsX/8j8XaOIB5X1jShJwEAJlbssB/2yC3K7S+J7H17h76L2iHeRjkiZQ4i8WfCdVIzmwcxSSG0zv6Q73qDuSIWFmIQXdlPVXc/WNzu81mot0jSEbPmfKPRebZqb8I1X3TVnYFJAD3Y29apoWYdhn4QvoReM2vBVdM0Ik2TZg8akAYVtHr+8cA2u128DWcjmR03B+cenfNwEAMu9EqDWAYrjUOUx9OjcLnkAaHYvBhI+tRq+IUroYXsjAaf2XZeTynKfCL+D0sORwUI5NoYslkMN7TwpREKT5FkcYE8pKM6Z07jYT0+GJ/x0poM3AS1lCIKO3OzatQGZ3q7TVkll/HeGbya6vvBH/FuKD/JELrCUJYqnIZR8wzueVVTm5xZRl2J2ZfebvlxopWpMq/xOxc6sTNmTtVpEBI9I5Vgi74ZqvNQjBIbBWdKaRNSZdCvkbkIdU64HDMaKiczT62ageigVrXQkjOpBTmkbE5oI5wF7e1TWoqZa9x1Ner26qwsdMoIT4e9sK3qO0e+YYY7iu524esTe2gO/9FXp2WuiJndejwCocbKfVLq6/JSUnmL4Gr4LUqi07chxZK2V1UQsODGBqZrc8+JUMojM
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(23010399003)(82310400026)(1800799024)(921020)(13003099007)(18002099003)(22082099003)(3023799007)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2Chjqwhzsa1XR99NLHUJ7PHmgr7tQfCUedgtkO0Yw7ALJjzi3dBe8jUphQ92ryN8mw/9gzAWil9Ey6cFrNYhJV5t0zqxoWQmVzUMmpxX/NZ+A5PM4ksm8PGXjXuKokGBkwS/oC2mlx9YxfpvqPZIzQ0U2aNhMXWelFH6dMxgLXnZzhkiQiTZxv5BoY1ZwydSsoUX8q4lDZkWVEc1imcX13bqlDs2ukDtbteGeHM+G6hkuSQd0QiEnGRzmOXPL6FAzgr7z6A310bK6W4L4V5SzdOu9UWFA/afoepvITSlvUDp9Kndks1TD/wiLAK6CRJmQCQ8s2Hms4zNtdx9k1koQhelHkuPuyjJgAr1H/urMBjvQWbVePPMAm+H+Ge3FkKobMA9sGO1AvogbX9RxBWbT0Y6tIRJHPZaI2TyJfNZcCPK8CCwato1jS9Z4o03OvCy
X-Exchange-RoutingPolicyChecked:
	DIMPbx7faPZOGrY1k7jpvQLs4qc4YcENzHi4Gh4dYHyl1l/QRqGSE25YTYn5XiM5gFkSnpR/B4QH+rdNahm0AaqAzJ5H+ATEMJ+A9/Sqhd4iYtOD8qpP7uqqx7dgg8DiqefSJh1gKJ27yTQk2XYZDMxrB7Y+EJW1nqsWf0n1EFPap0jp7xat41uZDUR0OP4LV0ZfL8HWDVoiPJd5YtvxXxotam9rrlK9Ogd9D1742Nu5srYbJ4JRc5WC6thIqyJGwD5oJA3a00rdq1iFEF5sOmNK9xrxwTZAu3FGPcqNj7L3lmsRLGu1iwUathYsSyTZRfk8y3wx53qOQHYa5IgHNg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:08:06.1093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b305ed-b1fb-4c6f-a1ab-08ded106f027
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7039
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfXzXE0p9Ggfl/M
 hV0NedENBFoR6B2RILKc88COsP30vYwz8heqVLUhsnGPSiwz4bT+7S3HT987GFdgEw9vS4IyZTm
 qQ9X0tyykNa9t4IQ9e5AWEZyZHmAZF8=
X-Proofpoint-ORIG-GUID: i59ex7UC4hvQeF0as09du_8b9CgvNT85
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfX1q9eAr0SDZq2
 SP4zVwGce3uJP7nMsAJRhKNDcgdMittV+sKpDZ13zNiMuk7Wjkd2jJF5hxO++zCfNTGENUZWjdQ
 rfKXUBN9jBWEnPjAy6ovhptA6DAsGl7pVpfq2RDH2BpD6toIKeB548d0ypcHm+OfzFgpglRnkse
 seCDVvK2cBZO6L6Rb4UIktltzHnq0XbqmrXUc95Zc3E6ZBuI1tlXHmymDZVKmGtKISsElVr4Q34
 mP2cWNmKQlFzAUOSIXZF1NvvJlosXwgkx+25oN6GPGv8P/6oOeWeNbmF4PLJAg3obav2veI9XtA
 0OlkfF0VclS5wSqNAIG7SsAAOXPMFJIjXEfzQ1nDxIK5NynZ86Ji6j45sKQMaaMqsoyy187Ed8J
 M7noa4okaG3plGluXTRt8zkh2I0PydXDE9+zqhCg3R8rDvAyuCPGSel1SY2c5D9fqAVFIb2N220
 Nv2kyeCIToDYZWwCZqQ==
X-Proofpoint-GUID: i59ex7UC4hvQeF0as09du_8b9CgvNT85
X-Authority-Analysis: v=2.4 cv=WoYb99fv c=1 sm=1 tr=0 ts=6a3a4cfe cx=c_pps
 a=/CYSPFcZsPiriMCSbh9ShQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=JfrnYn6hAAAA:8
 a=4wboLV9FyiRSdVYXUOcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230072

Document the architecture and implementation details for the Data Object
Exchange (DOE) framework for PCIe Endpoint devices.

Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Changes from v5 to v6:
- Addressed the review comments provided by Bjorn Helgaas at v5

Changes from v4 to v5:
- Updated the DOE Abort handling setion.

Changes from v3 to v4:
- Updated the maximum size of the DOE object from 256KB to 1MB,
  as per PCIe spec.
- Updated the DOE setup and cleanup sections.

Changes from v2 to v3:
- Rebased on 7.1-rc1.

Changes since v1:
- Squashed the patches [1] and [2], and moved the documentation file
  to Documentation/PCI/endpoint/pci-endpoint-doe.rst to match the existing
  naming scheme, as suggested by Niklas Cassel
- Updated the documentation as per the design and implementaion changes
  made to previous patches in this series:
  * Updated for static protocol array instead of dynamic registration
  * Documented asynchronous callback model
  * Updated request/response flow with new callback signature
  * Updated memory ownership: DOE core frees request, driver frees response
  * Updated initialization and cleanup sections for new APIs

v5: https://lore.kernel.org/all/20260610100256.1889111-5-a-garg7@ti.com/
v4: https://lore.kernel.org/all/20260522052434.802034-5-a-garg7@ti.com/
v3: https://lore.kernel.org/all/20260427051725.223704-5-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260401073022.215805-5-a-garg7@ti.com/
v1: [1] https://lore.kernel.org/all/20260213123603.420941-2-a-garg7@ti.com/
    [2] https://lore.kernel.org/all/20260213123603.420941-5-a-garg7@ti.com/

 Documentation/PCI/endpoint/index.rst          |   1 +
 .../PCI/endpoint/pci-endpoint-doe.rst         | 352 ++++++++++++++++++
 2 files changed, 353 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-doe.rst

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index dd1f62e731c9..7c03d5abd2ef 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -9,6 +9,7 @@ PCI Endpoint Framework
 
    pci-endpoint
    pci-endpoint-cfs
+   pci-endpoint-doe
    pci-test-function
    pci-test-howto
    pci-ntb-function
diff --git a/Documentation/PCI/endpoint/pci-endpoint-doe.rst b/Documentation/PCI/endpoint/pci-endpoint-doe.rst
new file mode 100644
index 000000000000..49bb1d8236f0
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-endpoint-doe.rst
@@ -0,0 +1,352 @@
+.. SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+.. include:: <isonum.txt>
+
+=============================================
+Data Object Exchange (DOE) for PCIe Endpoint
+=============================================
+
+:Copyright: |copy| 2026 Texas Instruments Incorporated
+:Author: Aksh Garg <a-garg7@ti.com>
+:Co-Author: Siddharth Vadapalli <s-vadapalli@ti.com>
+
+Overview
+========
+
+DOE (Data Object Exchange) is a standard PCIe extended capability feature
+defined in PCI Express Base Specification Revision 7.0, Section 6.30.
+It is an optional mechanism for system firmware/software running on root
+complex (host) to perform :ref:`data object <data-object-term>` exchanges
+with an endpoint function. Each data object is uniquely identified by the
+Vendor ID of the vendor publishing the data object definition and a Data
+Object Type value assigned by that vendor.
+
+Think of DOE as a sophisticated mailbox system built into PCIe. The root
+complex can send structured requests to the endpoint device through DOE
+mailboxes, and the endpoint device responds with appropriate data. These
+mailboxes are implemented as PCIe Extended Capabilities in endpoint devices,
+allowing multiple mailboxes per function, each potentially supporting
+different data object protocols.
+
+The DOE support for root complex devices has already been implemented in
+``drivers/pci/doe.c``.
+
+How DOE Works
+=============
+
+The DOE mailbox operates through a simple request-response model:
+
+1. **Host sends request**: The root complex writes a data object (Vendor ID,
+   Type, and Payload) to the DOE Write Data Mailbox Register (one DWORD at
+   a time) of the endpoint function's DOE Capability and sets the DOE Go bit
+   in the DOE Control Register to indicate that a request is ready for
+   processing.
+2. **Endpoint processes**: The endpoint function reads the request from DOE
+   Write Data Mailbox Register, sets the DOE Busy bit in the DOE Status
+   Register, identifies the protocol of the data object, and executes the
+   appropriate handler.
+3. **Endpoint responds**: The endpoint function writes the response data
+   object to the DOE Read Data Mailbox Register (one DWORD at a time), and
+   sets the Data Object Ready bit in the DOE Status Register to indicate that
+   the response is ready. If an error occurs during request processing (such
+   as unsupported protocol or handler failure), the endpoint sets the DOE
+   Error bit in the DOE Status Register instead of the Data Object Ready bit.
+4. **Host reads response**: The root complex retrieves the response data from
+   the DOE Read Data Mailbox Register once the Data Object Ready bit is set
+   in the DOE Status Register, and then writes any value to this register to
+   indicate a successful read. If the DOE Error bit was set, the root complex
+   discards the response and performs error handling as needed.
+
+Each mailbox operates independently and can handle one transaction at a
+time. The DOE specification supports data objects of size up to 1MB
+(2\ :sup:`18` dwords).
+
+For complete DOE Capability details, refer to `PCI Express Base Specification
+Revision 7.0, Section 6.30 - Data Object Exchange (DOE)`.
+
+Key Terminologies
+=================
+
+.. _data-object-term:
+
+**Data Object**
+  A structured, vendor-defined, or standard-defined message exchanged
+  between root complex and endpoint function via DOE Capability registers
+  in configuration space of the function.
+
+**Mailbox**
+  A DOE Capability on the endpoint device, where each physical function
+  can have multiple mailboxes.
+
+**Protocol**
+  A specific type of DOE communication data object identified by a Vendor ID
+  and Type.
+
+**Handler**
+  A function that processes DOE requests of a specific protocol and generates
+  responses.
+
+Architecture of DOE Implementation for Endpoint
+===============================================
+
+.. code-block:: text
+
+      +------------------+
+      |                  |
+      |   Root Complex   |
+      |                  |
+      +--------^---------+
+               |
+               | Config space access
+               |   over PCIe link
+               |
+    +----------v-----------+
+    |                      |
+    |    PCIe Controller   |
+    |      as Endpoint     |
+    |                      |
+    |  +-----------------+ |
+    |  |   DOE Mailbox   | |
+    |  +------^----------+ |
+    +---------|------------+
+   +----------|-------------------------------------------------------------+
+   |          |                                        +------------------+ |
+   | +--------v---------+           Allocate           | +--------------+ | |
+   | |                  |------------------------------->|   Request    | | |
+   | |   EP Controller  |                            +-->|    Buffer    | | |
+   | |      Driver      |             Free           | | +--------------+ | |
+   | |                  |--------------------------+ | |                  | |
+   | +--------^---------+                          | | |                  | |
+   |          |                                    | | |                  | |
+   |          |                                    | | |                  | |
+   |          | pci_ep_doe_process_request()       | | |                  | |
+   |          |                                    | | |                  | |
+   | +--------v---------+             Free         | | |                  | |
+   | |                  |----------------------------+ |        DDR       | |
+   | |    DOE EP Core   |<----+                    |   |                  | |
+   | |  (pci-ep-doe.c)  |     |     Discovery      |   |                  | |
+   | |                  |-----+  Protocol Handler  |   |                  | |
+   | +--------^---------+                          |   |                  | |
+   |          |                                    |   |                  | |
+   |          | protocol_handler()                 |   |                  | |
+   |          |                                    |   |                  | |
+   | +--------v---------+                          |   |                  | |
+   | |                  |                          |   | +--------------+ | |
+   | | Protocol Handler |                          +---->|   Response   | | |
+   | |      Module      |------------------------------->|    Buffer    | | |
+   | | (CMA/SPDM/Other) |           Allocate           | +--------------+ | |
+   | |                  |                              |                  | |
+   | +------------------+                              |                  | |
+   |                                                   +------------------+ |
+   +------------------------------------------------------------------------+
+
+Initialization and Cleanup
+--------------------------
+
+**Framework Initialization and DOE Setup**
+
+The EPC core automatically initializes and sets up DOE mailboxes through the
+``pci_epc_init_capabilities()`` internal function, which is invoked during
+``pci_epc_init_notify()`` when the controller driver calls this API.
+Controller drivers do not need to explicitly handle DOE initialization,
+rather the EPC core manages this transparently.
+
+DOE initialization only occurs when the EPC driver reports DOE Capability
+through the ``doe_capable`` flag in its ``pci_epc_features``.
+
+This internal function performs the following steps:
+
+1. Calls ``pci_ep_doe_init(epc)`` to initialize the xarray data structure
+   (a resizable array data structure defined in linux) named ``doe_mbs`` that
+   stores metadata of DOE mailboxes for the controller in ``struct pci_epc``.
+2. Calls ``pci_epc_doe_setup(epc)`` to discover all DOE capabilities in the
+   endpoint function's configuration space for each function. For each
+   discovered DOE Capability, calls ``pci_ep_doe_add_mailbox(epc, func_no,
+   cap_offset)`` to register the mailbox.
+
+Each DOE mailbox structure created by ``pci_ep_doe_add_mailbox()`` gets an
+ordered workqueue allocated for processing DOE requests sequentially for that
+mailbox, enabling concurrent request handling across different mailboxes.
+Each mailbox is uniquely identified by the combination of physical function
+number and capability offset for that controller.
+
+**Cleanup**
+
+The EPC core automatically cleans up DOE mailboxes through the
+``pci_epc_deinit_capabilities()`` internal function, which is invoked during
+``pci_epc_deinit_notify()`` when the controller driver calls this API.
+Controller drivers do not need to explicitly handle DOE cleanup, rather
+the EPC core manages this transparently.
+
+DOE cleanup only occurs when the EPC device reported DOE Capability
+through the ``doe_capable`` flag in its ``pci_epc_features``.
+
+This internal function calls ``pci_ep_doe_destroy(epc)``, which destroys all
+registered mailboxes, cancels any pending tasks, flushes and destroys the
+workqueues, and frees all memory allocated to the mailboxes.
+
+Protocol Handler Support
+------------------------
+
+Protocol implementations (such as CMA, SPDM, or vendor-specific protocols)
+are supported through a static array of protocol handlers.
+
+When a new DOE protocol library is introduced, its handler function
+is added to the static ``pci_doe_protocols`` array in
+``drivers/pci/endpoint/pci-ep-doe.c``. The discovery protocol
+(VID = 0x0001 (PCI-SIG Vendor ID), Type = 0x00 (discovery protocol)) is
+included in this static array and handled internally by the DOE EP core.
+
+Request Handling
+----------------
+
+The complete flow of a DOE request from the root complex to the response:
+
+**Step 1: Root Complex → EP Controller Driver**
+
+The root complex writes a DOE request (Vendor ID, Type, and Payload) to the
+DOE Write Data Mailbox Register in the endpoint function's DOE Capability
+and sets the DOE Go bit in the DOE Control Register, indicating that the
+request is ready for processing.
+
+**Step 2: EP Controller Driver → DOE EP Core**
+
+The controller driver reads the request header to determine the data object
+length. Based on this length field, it allocates a request buffer in memory
+(DDR) of the appropriate size. The driver then reads the complete request
+payload from the DOE Write Data Mailbox Register and converts the data from
+little-endian format (the format followed in the PCIe transactions over the
+link) to CPU-native format using ``le32_to_cpu()``. The driver defines a
+completion callback function with signature ``void (*complete)(struct pci_epc
+*epc, u8 func_no, u16 cap_offset, int status, u16 vendor, u8 type, void
+*response_pl, size_t response_pl_sz)`` to be invoked when the request
+processing completes. The driver then calls ``pci_ep_doe_process_request(epc,
+func_no, cap_offset, vendor, type, request, request_sz, complete)`` to
+hand off the request to the DOE EP core. This function returns immediately
+after queuing the work (without blocking), and the driver sets the DOE Busy
+bit in the DOE Status Register.
+
+**Step 3: DOE EP Core Processing**
+
+The DOE EP core creates a task structure and submits it to the mailbox's
+ordered workqueue. This ensures that requests for each mailbox are processed
+sequentially, one at a time, as required by the DOE specification. It looks
+for the protocol handler based on the Vendor ID and Type from the request
+header, and executes the handler function.
+
+**Step 4: Protocol Handler Execution**
+
+The workqueue executes the task by calling the registered protocol handler:
+``handler(request, request_sz, &response, &response_sz)``. The handler
+processes the request, allocates a response buffer in memory (DDR), builds
+the response data, and returns the response pointer and size. For the
+discovery protocol, the DOE EP core handles this directly without invoking
+an external handler.
+
+**Step 5: DOE EP Core → EP Controller Driver**
+
+After the protocol handler completes, the DOE EP core frees the request
+buffer, and invokes the completion callback provided by the controller
+driver asynchronously. The callback receives the struct pci_epc, function
+number, capability offset (to identify the mailbox), status code indicating
+the result of request processing, Vendor ID and Type of the data object,
+the response buffer, and its size.
+
+**Step 6: EP Controller Driver → Root Complex**
+
+The controller driver converts the response from CPU-native format to
+little-endian format using ``cpu_to_le32()``, writes the response to DOE
+Read Data Mailbox Register, and sets the Data Object Ready bit in the DOE
+Status Register. The root complex then reads the response from the DOE Read
+Data Mailbox Register. Finally, the controller driver frees the response
+buffer (which the handler allocated).
+
+Asynchronous Request Processing
+-------------------------------
+
+The DOE-EP framework implements asynchronous request processing because an
+endpoint function can have multiple instances of DOE mailboxes, and requests
+may be interleaved across these mailboxes. Request processing of one mailbox
+should not result in blocking request processing of other mailboxes. Hence,
+requests on each mailbox need to be handled in parallel for optimization.
+
+For the EP controller driver to handle requests on multiple mailboxes in
+parallel, ``pci_ep_doe_process_request()`` must be asynchronous. The function
+returns immediately after submitting the request to the mailbox's workqueue,
+without waiting for the request to complete. A completion callback provided
+by the controller driver is invoked asynchronously when request processing
+finishes. This asynchronous design enables concurrent processing of requests
+across different mailboxes.
+
+Abort Handling
+--------------
+
+The DOE specification allows the root complex to abort ongoing DOE operations
+by setting the DOE Abort bit in the DOE Control Register.
+
+**Trigger**
+
+When the root complex sets the DOE Abort bit, the EP controller driver
+detects this condition (typically in an interrupt handler or register
+polling routine). The action taken depends on the timing of the abort:
+
+- **ABORT before request transfer**: If the DOE Abort bit is set before the
+  root complex transfers the request to the mailbox registers, the controller
+  driver should not call ``pci_ep_doe_abort()`` API.
+
+- **ABORT during request transfer**: If the DOE Abort bit is set while the
+  root complex is still transferring the request to the mailbox registers,
+  the controller driver should discard the request, and should not call
+  ``pci_ep_doe_abort()`` and ``pci_ep_doe_process_request()`` APIs in the
+  respective IRQ handlers.
+
+- **ABORT after request submission**: If the DOE Abort bit is set after
+  the request has been fully received and submitted to the DOE EP core via
+  ``pci_ep_doe_process_request()``, the controller driver must call
+  ``pci_ep_doe_abort(epc, func_no, cap_offset)`` for the affected mailbox
+  to perform abort sequence in the DOE EP core.
+
+**Abort Sequence**
+
+The abort function sets the CANCEL flag on the mailbox to prevent queued
+requests from starting. Instead of waiting for the workqueue to flush,
+it returns immediately.
+
+The CANCEL flag gets cleared after invoking the completion callback,
+allowing the mailbox to accept new requests.
+
+Queued requests that have not started execution will be aborted with an
+error status. The currently executing request will complete normally,
+and the controller will reject the response if it arrives after the abort
+sequence has been triggered.
+
+.. note::
+   Independent of when the DOE Abort bit is triggered, the controller
+   driver must clear the DOE Error, Busy, and Ready bits in the DOE Status
+   Register after completing the abort operation to reset the mailbox to
+   an idle state.
+
+Error Handling
+--------------
+
+Errors can occur during DOE request processing for various reasons, such as
+unsupported protocols, handler failures, or memory allocation failures.
+
+**Error Detection**
+
+When an error occurs during DOE request processing, the DOE EP core
+propagates this error back to the controller driver either through the
+``pci_ep_doe_process_request()`` return value, or the status code passed
+to the completion callback.
+
+**Error Response**
+
+When the controller driver receives an error code, it sets the DOE Error bit
+in the DOE Status Register instead of writing a response to the DOE Read Data
+Mailbox Register, and frees the buffers.
+
+API Reference
+=============
+
+.. kernel-doc:: drivers/pci/endpoint/pci-ep-doe.c
+   :export:
-- 
2.34.1

