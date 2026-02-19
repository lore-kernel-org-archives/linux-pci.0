Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63430EF64;
	Thu, 19 Feb 2026 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483537; cv=fail; b=d4N7KRVITQUnMjry4PI9wkMyt52q/2e128R2QvCFPw6MJUfM0HhR4+Ts2doxdYIRzugiCmffLcsCFET6FRjxTMIeV/Wanz0gXRiwiHpEsOV/ZCKJTiXG9+5UV1Y1opKdQEw2OuCiTjffm3hduVFkS/5fISihDAgEiOUD5lwrp7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483537; c=relaxed/simple;
	bh=R3DPrZlB7TB1/2UmtXbgqMAmPmwJ+Bffb0o7CBU97AY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PF/Mx8X0C2M7pvmF3fYLC1gftBkC/4AJ/fYKJ+omAQYFBQW5MRdEc39MJJZyS35JTPfB1d0I7aKGk7O4kYKwfXIaKxdcxEkfYe66/EtVJxn68FOeMsSrOucuzJCrYJtv/LqbkRUzwRbqWekNAOg8CbZ9dvwPW9loz3jwHJBcSFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PeMqhhjh; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PeMqhhjh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPFic4C4Xa2UAxNU8IhEpnpcxDvLeFi16foBDXcSx87BDeQ++MCLU6XHbHnBGIjzHSNoO/v4aMZg6b0DjuG3sxVDEf/+P4k1TRhdhhz8TwX7lp0rPtJB1KylU7bPqPv+7nGiJcxgVW+4yF6ps4aBUONgt5RmLtL59BlR94gyere0698bQujskNbGS6HoRKYx880IqIxeOZ4Vnepu1MGUcpAt0WOV0oOWIeDpQVekI3/95ssrmSwVtAhTttt2/ScEsYQ8jFGtYvRpt9fn3c8fvbC7GNCOhMJps0ce+ftsg7fzJ+XrzkeDLbAe23dQwukiI4jBnNHS1zZoOkm69fdx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzYe2JkRE9EY1QMSNbum4UC+WYgBZTEPIHRvQmUUcDY=;
 b=ql0sDcQtSzrPS7zVm5SijPHxuR7HtDPktFDhGx0nXWZZjQybtvqp7FD53CQuLM0e4Jx/ubzltRuap17WeBGu9djIEK12EcsHt9J0lihi9UmFKCRMx3LDhz/dhwzR0hzOzkciYcmOZLPMaLYkWizVQui1TOqzaHIINOB5xMv6qKdg2+9MbLIsT/Za1TaluNZdE6PhDOWvaJuJHFjDOMN+796bfy6d+HkaXLfOJeySrkjuYDYjEKjcLQ5evEL7+1yBkZsLcrxvwqYdpt/TP7xR8b4KO3chYnUw3zL8KzYg1jToiFHc2gjnoViT+AQU20qAilcUYs1kUmkJjhCmiUjcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzYe2JkRE9EY1QMSNbum4UC+WYgBZTEPIHRvQmUUcDY=;
 b=PeMqhhjhGnxZdjsUHmEIHH1B1qMxSltgA2elc3d4P7ZdRrNxL0gAlmsdcaCZHIPFj3fpJmXezQoqOlUS7ICCovo1hI/Osp5vhBBZBFPdsDEqUguy8NN+hhMRFEdj8hxNnvxeAH5xtSazcKlHKc30fiuwhC27kYc2jUxPQme0nws=
Received: from SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::25)
 by EAYPR10MB997807.namprd10.prod.outlook.com (2603:10b6:303:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 06:45:33 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ee) by SJ0P220CA0009.outlook.office365.com
 (2603:10b6:a03:41b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 06:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 06:45:33 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 00:45:18 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 00:45:18 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 00:45:18 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61J6jDwh2156628;
	Thu, 19 Feb 2026 00:45:14 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<fancer.lancer@gmail.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v2 0/2] PCI: dwc: ep: Multi-function endpoint configuration fixes
Date: Thu, 19 Feb 2026 12:15:09 +0530
Message-ID: <20260219064511.695086-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|EAYPR10MB997807:EE_
X-MS-Office365-Filtering-Correlation-Id: 831513ba-864b-41a6-5d10-08de6f827b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?whIB0coT2gBP270ZkpOd9jmMGTPKQZEB8ZuYiQ2K7lUakkg8KBkRb97tm8+c?=
 =?us-ascii?Q?CFnMNojIZw2Zsj/xvSNet2vK/2h8qGMzy37UP3XrUzV7VlI6a5cqibWX9Q8v?=
 =?us-ascii?Q?5eFRjjUgDAJ2TTsNk+QhS8UKFhtQ2EfWmW4sD81I54zccq3eI2dJF9zfN+FB?=
 =?us-ascii?Q?8/rSnn2rV/o8gzNVvA8RrRBwJhNzB9QTfxOwVprnRM+pancGjd/6dzCr/pB2?=
 =?us-ascii?Q?gJvJk+yDz9i/zEmDvERIOpAlp7GO8cHUsltzGSL12tsrByLW9ozgI80tiYkx?=
 =?us-ascii?Q?HIB816YTCiI8xc7zSMdrVB/Mqjtzj5JIHuK2UHZyepB4+bQCS5tLlR7tdXcG?=
 =?us-ascii?Q?gNFfEyfDUytFsJ7p/0Qmf+1PtzE5NJzUGgF0VYu9XFDuwpkbHA/ImmE+xuxP?=
 =?us-ascii?Q?INS2N4BvSG8yGF2L3/J03selLQ6q2b7tL9vX24e0zEZ9lMYU3xAFH8acdWeI?=
 =?us-ascii?Q?oNCbMqgjVaFa24BMFn37D7SibYkM/DjEcdipnPZyapPYP6w/nLJQTXq4yrLi?=
 =?us-ascii?Q?HhusJF9plV8WHhUwceosMy+Fv4j0hO2K8iK/Ab63Mya26dsOkHbMkMPeuIlW?=
 =?us-ascii?Q?LfJ1w9ZeTd3QL2bYop4PzB+xKz1tq1uMLXdUaN+uzbScnq2Uj0lERuunZJZE?=
 =?us-ascii?Q?S0m0HAl0uq9HLABRFGAxuYIAG3p3xwvSSTynrLDRjD/SImAx6z1YamU8sntd?=
 =?us-ascii?Q?jTLlaNwtF083cEUPiipyUZiJtR0MxgVJERxkoe4Gea3rWPWfrm/Bn6i0bMcQ?=
 =?us-ascii?Q?vY4rkXev0HN4cNv/ES3wT4W8mdPqB77f4QuFg1bEdjbIrH8jp9aWN9r9/27c?=
 =?us-ascii?Q?iENaVe4iKE7LmDlH7+cUfqBs+YyRmO/+mjULve9pLs3tJ1EfcDxz4ZBNINgG?=
 =?us-ascii?Q?QkPeLjFzqwBa59PSx1gwB8AQpiNQLHvPmKtWlUNIXBRRrHDUd2B1GsEH9ABI?=
 =?us-ascii?Q?2ncXj0ZuvHVX+/Nm5QbuqtZOr5Z1fLERf8UzAMCZjoQkoV0TA3Ofxaxyqub9?=
 =?us-ascii?Q?LfCLM8G7tqiq4QkutcbplRRPQ+NzV6J/ka97FtPm+OeP0c+x3iAH+SNByJ1E?=
 =?us-ascii?Q?2K2sq1zaCYWmIAQcHsLwiTHvPEjeo/N5aBB79ReDI28YKh5O41dcX/uZ1OCK?=
 =?us-ascii?Q?1FKYmB45RyfkTiaEJJeRAPMGtpKe0tapBdee6OpBo423wxLw/OxGDEIrdJR+?=
 =?us-ascii?Q?VkDSm4h4GNvCfBVuth53BmvdSeuI/WWIzflNNFIgrj2k0lcn5lBAlNtY/yDo?=
 =?us-ascii?Q?E14oVdjVHHFrUpBHY/jn2UJEcQH2T2nJB4kOcjhU66/l8vgHUXXNOZoN1G29?=
 =?us-ascii?Q?pLmgmVVNhwrLn60e/r1vYoyeNte2qTBnWGYleC/YNxzfqxw2W/0JkxJCopF3?=
 =?us-ascii?Q?YrndeoIqAz4H+zs68EKohWOV19nli1mam04mgH5HWcywRi54gQW0Oj8N+Qwh?=
 =?us-ascii?Q?x38BvuJlIdqmIb3wuZe1wqUZe1vUGElwknyjvTX15laU1nwHuIqC52Fr/1Ko?=
 =?us-ascii?Q?VdPFaQMW/IGrhVL1bAKKKCmCD1SUbkeMT23WxLhQZuupQYPRcdgrB1WuKfeR?=
 =?us-ascii?Q?DZb2T+P1olgxL3bk2btilU6fC5g70PPebgqvfGhDzW23diDHx1VvQigiUoh6?=
 =?us-ascii?Q?tFfjU7mK/IuAism0J5WoGRhomMn2ffLIq0RfrWpHDINm1F1vWqQVw52JOBTH?=
 =?us-ascii?Q?B91ctFC1nKYjulhJefwxDHmH/+E=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zKpfEc5SvT/zPyYMxYMH3k/omkvJ7jyGE/FHQMt+bLxL3Orld/jZaSn93dOaQ1SrDpb6y9wIys5SSAhRXVhllGx1FhedZB6gqzQ73dZfPdCu/9O1aWJ1VVS4RIUK/tZi6PQXQYXUql7MMjNamUAn1hRkV05r3oqfdH62P/I7hHhb21Dp3oYbtpzd01/0meheQYsAEKFE71+FOoDNxIfWc1+Kq75IN3SvdWXTimjIJevGGvNfkBKqXZRnJbpbX43fsnNBLDBD/zur5zu04rIANyErAOaZ9oMIMrskXaSdgfM8sXlUc7ucpxK6OoayCSTiGzV1MSZh0CMDeYwPP2NIXBdgjv9VWU1uWkVICpO4ZkAJz7r/mDQx03d8bNbeau4ST1th4ZJiz6tNfCsm9O9P8+TDMtyQrMKL3bkbDl5lnfHZyrdSmNdseMwOTMy3PtV1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 06:45:33.3739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831513ba-864b-41a6-5d10-08de6f827b1d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997807

This series addresses multi-function endpoint configuration issues in
the DWC PCIe controller driver. The changes enable proper operations
for physical functions and enhance the multi-function endpoint support.

This patch series can be seen as an extension of the patch series:
https://lore.kernel.org/all/20260130115516.515082-1-a-garg7@ti.com/

Changes from v1 to v2:
- Fixed the minor nits in the patches

v1: https://lore.kernel.org/all/20260202072758.101845-1-a-garg7@ti.com/

Aksh Garg (2):
  PCI: dwc: ep: Fix MSI-X configuration to write to correct physical
    function
  PCI: dwc: ep: Mirror the max link width and speed fields to all
    functions

 .../pci/controller/dwc/pcie-designware-ep.c   | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

-- 
2.34.1

