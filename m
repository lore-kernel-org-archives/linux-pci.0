Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793730866;
	b=rPuxkBwt3lBxwbhBVtXUfEWKG25zjktYBNWenkA+YS/Ax7hdOU6wD5tNPaY9ShzlqTY3
	 FOCpN5FnSv71nQgpgQHvzirBg60Z/UfKrRjyCoUenKspiogWzt8DlVE3emHAdIrc4VbXO
	 dPC29cUCTqnkArvUcDxYHNb5q5j/RSBWkOaTHEETsUj06JcaN6sfz+K0CNNzapjJ+YVFg
	 3PTv3xeidIfbZ0YTmoUlSaEmjRTwMChzVv943LOLKQdUzc0sDo9oXBnGQ1A8PXjLHbPt6
	 x35IBbw2WuBos96PeZIU9kUgq3XhCSRCVG+TEOVumGOb2E7i8vzdH03QZiRJT3Ykujw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730866;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UFCviMgq9tPPoxgfAI50RyU39nu6TM9MVkVZB7UabTo=;
	b=GmdXHh/TXQPqiBQyABeujW1P7y1b6+hAFDI1Fm3WbiXLC8VnVMW1OoCIuLqEC6gEZEct
	 i+x43dxx+0Y6+qSJrh4yuEpZm9yHB6MQ1+qMAL1+Tj55kLy7eZqdS3SOsGjrYnlNnB/cZ
	 Q+gCY5lt5VKcrHzet3x0QRs4Wxp7b4GkiLT/KvSJNg8F2cETaxiZ3u+b+6Zq5xQhZcnoX
	 +pdL/roWgiboey7jWuSmBtDT85y532AgSYGGfmdJ50lnldrYZy5iOpMLGAphFWvY0LfUn
	 zLBrQ/rZt7z0E6Dn2+Q8Wfty5ADdNvwAnvPC+/Xmc9SclLP/s3lmCsov7gWoWQpy1RQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=knBjiGPT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.51
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3A606A32D;
	Tue,  3 Nov 2026 18:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F3A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=knBjiGPT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq3jsfS4r8wqRAGVeysaQpWnx/7qtep1T07P8o6j9w4QNCAe7KmavvgulUD5x7AoCWqTGXA4uvrDyeejTEZ3RgIO7ChDtKmhjtQyuzNV09cTk6t5zmdw8XHxZmZ6W6rh/0nmZQoQdsmeOe44q8fMQY+yjaQzl2l2mw4nym5vKICUZpw74EVyleQMC16kxBh+KIhj5Uuwi0f3tLhD+Q4ZCXDLdBOHfgvn5c4Sfr5TIfOWO8qR96rCeuaKWFgIvwDeqX9wL3XwOM91hBDdXPKRA2pwNb3pmTcqXHGSiSgP1hQbfPlUgN5KYLZJLpPwRyKVm6gWKiOlTPL/9lmr+A7kLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFCviMgq9tPPoxgfAI50RyU39nu6TM9MVkVZB7UabTo=;
 b=S0+8/BnUPNhKsMA/x7S5pNJddibnj4UOVymt+dzabnLvdy1bxr4PWmCH/UcNyeR9ILwPNwP1vqli1qLq0DmCjipsuQOK379/wEihV+aXUDjUXsOtlGuPUMtGqT0p5vaApbRJSo6HTDtMSjv26aACSG5S+fI98NCF789JGnxOhEBX/IY32TY8t87g64iX//tRxJLxmMmQULSma2BRGPlR3JpJKX3l+NjTMggMBUcsI2TdWRQfEhik2Hr+pH35EChxwEKqarvGOJUuNzlJ2vQ63FpFvPPiKRUu/ZFv+7Iy+jHmaF2Fd6/dTYjROyqFqDeCPGNVwo6nYqFJcFmUQnE3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFCviMgq9tPPoxgfAI50RyU39nu6TM9MVkVZB7UabTo=;
 b=knBjiGPTlj5yaiXn21Ix+XCsBRqDTNm71DfEUuLNZVwtRMR7wEVPxv7qVOO/gyhb8We46NYC4ZSDmIfZ/Cz9lWFJARznOQXkxmmqtY2nuCER0vH/OGITt5EUYKOiU7MMT2zus8O4laNPbx5W5Jp1QEB/kCNqXSLjVkhkd7VlJyaja2n7L4GhcBWJbemW0m7w9erf9pdSZy5gDg9Ld8rBcfvqA7YRDAln9TxyyHhVzwDXcEViHpZPog4lM3sCa00WXggxpXWTbwJnXuF2jvzXbFqnwN1efvPrbq+8N3vKCE+MS1oZwUBmiKc/Lr+zNtgqQqn774dlIA44X7AaA6RY3w==
Received: from MN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:52f::16)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 18:34:18 +0000
Received: from BL2PEPF000352D5.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::67) by MN0PR03CA0028.outlook.office365.com
 (2603:10b6:208:52f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:34:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL2PEPF000352D5.mail.protection.outlook.com (10.167.254.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:34:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:50 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:50 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:33:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Joerg Roedel
	<joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <djbw@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 0/5] iommu: Keep a device blocked after a failed PCI reset
Date: Tue, 3 Nov 2026 10:33:41 -0800
Message-ID: <cover.1793729707.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D5:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 83981f65-0ed1-4ed3-75f1-08df39d9119d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|6133799003|10067099003|18002099003|13003099007|56012099006|11063799006|5023799004|261021123027099003|261021135927099003|261028144727099003|261022105027099003|261022075727099003|261102123227099003|261026140227099003|261026121527099003|261021121427099003|261009223027099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	YIyhPfrBGbgxRr0ZFJe+ZvTnTEtgUhHdQ+G+BdG0p0f4j3Zs6kUrxxQSAQyN/XTt7WTKwkCTgmc85fS6OIJbmFbed/WXGtIK3623OpvoAkciGaTxggm9spQURYl+uIdk8PX4q/TpzbI+3eAznadLNXAasdbO63Sx79T57CR7lxlqI7YDWRv5GmgTT4pOY+Pu4sdglLoZ2CAeKK1U2BgBh3mjNCSza8pOpWs5H6VKcAwkbJtjDA/btCvJjSby10U1UfULBsa902WZFacUsWHTLGg4Nqpm5KJZTD0fbYn8qkg+2laRSB1JAbrcMl39WTgYPj8Io3eXqTHd8sWl7gxYPsnG8LdGmvb2L7DzIicOZY6Pw81iyaU2XUdwBZo/QZm1i2MXD4ihXySZt9of2du3Gd2PVzuaCME+/g+NnWNiL0J4eZ23NGXVZFrk182r/YeNsb/ygcibRbSZdSHuRWxkfz59yL0rYp+veZcxqCEf72YsB2jsi7yr+5nyBZhyR/pMv3NDYyfQETaGsGbHN+rWDw0c3fL9PSReGJN2dl0hlu75t6TR9gkJbQh8GA19r3lDd4PZ0voD2y/AIU1j7uB8JxqDAGFo3byjuHZhyWzff9yGVY+ydD3pT74VLjpfRDyPv2B1cpJuvBnjJt3CPEiivzmTwGDqizzSb9I+0efyAV7m+wyxZFLR+01dXMtCC4d6phbIbPYm+yCvP+0ESRplDg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(13003099007)(56012099006)(11063799006)(5023799004)(261021123027099003)(261021135927099003)(261028144727099003)(261022105027099003)(261022075727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021121427099003)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sXgS1+lDEEbtCJnlvzsC/ht3uPMAhDbkBeQVGdhHsgkzBLTp4JKQE6tt/ss0yRNzGFZ51hutx4ShLfKMqfkWVRWY2gl6JZehLDBB64izDQoCfWV3Dn+0Vf7quJsqBjb9fUWZkUHpF6/Xi1aevHDMBtvgGDwJZAm/E3jgdaL+oxgmQriHtcFrgYW1rTi1+HxHTbI7iUKSOixla75mIwoAb0P/Bg0efJfHP5KY24QJLq7jElGlCzYz3q0Hrzb9R9KID5C2NA1oGWVz23vOUwC/a0+G6OfUoLkKYWunjzEsbLUjCDhwJijsgDE96J9bu++D6LneuxU5vQkQy0bPnvw/ieh2RfFYDDpbIq5e+hXAsQqpTk0BeFrkPbXtXxZEU0CD426J0Tdex9nXm3o72t32OwXMweBbQCmrfAs3nqPLv9X+pL0sHDQUYM6GivKMvZaC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:34:17.4438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83981f65-0ed1-4ed3-75f1-08df39d9119d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352D5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916

This series is split from a bigger SMMUv3 series, so that the PCI and the
IOMMU core changes can be reviewed and merged on their own:
https://lore.kernel.org/all/cover.1790188510.git.nicolinc@nvidia.com/
The SMMUv3 ATC invalidation timeout handling in that series will depend on
this series.

pci_dev_reset_iommu_prepare() blocks the IOMMU translation and ATS of a PCI
device before a reset. pci_dev_reset_iommu_done() restores them after the
reset. However, done() is called unconditionally, even when the reset has
failed. A failed reset gives no guarantee that the device cache is clean.
For an ATS-capable device, its ATC might still have stale entries pointing
to the memory pages that the OS has reclaimed. Re-attaching such a device
to its translation domains could corrupt the system memory.

Thus, pass in the reset result to pci_dev_reset_iommu_done(). On a failure,
keep the device blocked until a subsequent reset succeeds. This new policy
applies to every ATS-capable PCI device behind an IOMMU, so no IOMMU driver
needs to opt in.

First, fix two PCI reset issues found along the way. A probe of the reset
capability must not block the IOMMU, as it is only a state query. And the
cxl_reset_bus_function() must not report a "cxl_bus" method that can never
succeed.

Then, convert gdev->blocked from a bool into an enum in the IOMMU core, so
that a failed reset can be told apart from an ongoing reset. Also, pass the
blocked state of a device being removed into iommu_deinit_device(), which
lets the release_domain get the correct old domain.

Note that the PCI reset functions do overload -ENOTTY. It might mean either
"the reset was not attempted" or "this method failed, so try the next one".
The IOMMU core cannot tell these two apart. So, it keeps the device blocked
on -ENOTTY as well, with a FIXME and a warning.

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommu_reset_failure-v1

Changelog
v1:
 * Drop the Assisted-by tags
 * Split from the SMMUv3 series above
 * Carry over the Reviewed-by tags from Baolu and Jason

Nicolin Chen (5):
  PCI: Don't suspend IOMMU when probing reset capability
  PCI/CXL: Probe the underlying bus reset in cxl_reset_bus_function()
  iommu: Convert gdev->blocked from bool to enum blocked_reason
  iommu: Pass in gdev's blocked state to iommu_deinit_device()
  iommu: Pass in reset result to pci_dev_reset_iommu_done()

 include/linux/iommu.h  |  5 ++-
 drivers/iommu/iommu.c  | 87 ++++++++++++++++++++++++++++++++++++------
 drivers/pci/pci-acpi.c |  2 +-
 drivers/pci/pci.c      | 37 +++++++++++-------
 drivers/pci/quirks.c   | 13 ++++---
 5 files changed, 111 insertions(+), 33 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

