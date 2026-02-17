Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA22BD01B;
	Tue, 17 Feb 2026 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771307756; cv=fail; b=P8Pk/NOoSjv83tRGLqF5MO1E6Q4kMs8Sunri5mjJyvPus6ieA6EtMp74pesvkwuVwS2TaJYEH63Zd82OArkbokaJTOGc5c8qL6oJ0ESYVU/a71x5rOTcPAzifacmupMiKura3tCMP4yreaP+eKq+SvYOAwSAsW//RhLC/TPFd3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771307756; c=relaxed/simple;
	bh=h/M5MH29yLFJbVuQZql7fL31S0SK4M+A+uX+dXvwSQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhO3IMdup1Bx3t8PrCQVOngulXKCmx5r3kkvNYdbsG1jBSTs7IrG5nNnUpfugjsEM3yAS7jd1q47Gt3pA70CksmxLbbO7Z+Fz2TVmcy/h/e30GCETqrsc+wYTDkHPor1z5aYYQIFct5zXBlRGlZ0FXbwF9QeRLYYGuTRLze7U/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SZzbBpqR; arc=fail smtp.client-ip=40.93.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SZzbBpqR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPzd6s7haG3eSi/jV+fdViXIgIgVHolcC7MKUPcpsZFFwLHHTnVtf6WUYNnDVpEcafXIeFflu14briHtTW5M2Cn/t8BosQyT0i3jSrGKPPB91iwploofSueRNpW2yoxoE3urI9BugHF7sz12QFTV1QQkiBbSGAOit1GkleEoljby46OJTBxIGJQ29oPfkgz2t8C2qvhWLRzwU2mmoWO9Nv7uljDJijMHCB/uIY1JWX3F4utRG3A5CdF2Yx+nX9nRuEqadyv7SNuZSAXKmwb7OMR7HjO9fRRvQUdTio3QDay8hVUQK32frmSgx5gNtP6fL0wyKsMtMNFn09gA7/OqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikMGrWJVm8hEqoyXnwKvcEjxuDLZ1sOPl7J4JTKX0PU=;
 b=YQLbhVWo4jW9JKmRpdqlJ70nkgvMHmpKIxbtSvPNMxGyGgDVAGkcSCniJYgoVwWXDXCe9rK1fE147N5wa8pDSfwFJLXGDPaPIHa2UsxRHRMFiW2CyZ71V3vAZVSiZuWCSuDILaEqdwQt1TpV1J8VTn1yknx5eGXrySLcOOKL6M67m3VQVyyxYKezghJmG4NRct7LaK3GHQWvLUwCZ9vKjMP37pMLainSSTW7RmmHp0UGTF1XhWg4HUy2tokIxxRirpHnhvUgQcI6ec+XrrDsD06EEaAiShSGBL1ojGQ8zz7+mc5lOWBW/G3iyUNptcsw9pUY0a70PuMQc5mqTzdt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikMGrWJVm8hEqoyXnwKvcEjxuDLZ1sOPl7J4JTKX0PU=;
 b=SZzbBpqR7ASfVxYpOebGH7VRt11LmtpeiPc9ab0MdB272R0L7ahQ837huH7fk+hKjLoUhgi7uMrHxtZe2uRkkj32k10WoRWNcfMu/DUpshGsLb3kjg50PKM003DJVnjppbwnbEG3xMpQLTlys6kx9VAwmHG5LJJqYvGB1vis7pb7WPHAxRpyC6GuR26nJYzDDq6yNgNIxii/sjL1Zb6XZpVg0Xtmw+ZMeDM+eM7r7YxkW0hD2bR6pRqXkTHZYta8+FEIRCWsALAu78FYi8ZomICdDoReGiEL+ixOzQHK5A44EuHSQMOG4jShXuNWsVEpseuRRqhmbVVnzAbFm5hGWA==
Received: from CH2PR03CA0021.namprd03.prod.outlook.com (2603:10b6:610:59::31)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 05:55:46 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::d) by CH2PR03CA0021.outlook.office365.com
 (2603:10b6:610:59::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend
 Transport; Tue, 17 Feb 2026 05:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 05:55:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 21:55:36 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Feb 2026 21:55:30 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Niklas Cassel <cassel@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, "Thierry
 Reding" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>
CC: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/4] PCI: uniphier-ep: Convert unused BAR_RESERVED to BAR_DISABLED for Pro5
Date: Tue, 17 Feb 2026 11:24:44 +0530
Message-ID: <20260217-master-v1-4-727e26cdfaf5@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
References: <20260217-master-v1-0-727e26cdfaf5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c8a17f-83d4-43a6-07f8-08de6de93186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzNKQ1BiREthWEhuanc2OVA2MUZXUTErYTRJb1pSY08rYTRMK1FkSU5lb1ZJ?=
 =?utf-8?B?azRXOEg1RCsyNEtrQXlEaVRlbktCRnNheVQ3aTZyS2lpWmk2cnFjUExPUVE0?=
 =?utf-8?B?Z01RYThvNHBwVmZ3T3JDR01ZZjV1V2dsZktXT0krUzJIUGh2NEpub0VMbEsv?=
 =?utf-8?B?b2hneFBxREM3Wk9OdUlBTnI0Mzg5WGl5S1I5c1U3NzM2VXFycTZYTjl2Ukgy?=
 =?utf-8?B?Y3FLQkdGd2ZIMzAwRWtRVDVVR0h2Sllmc1BBdTJwaFEreS9yZ1dwSFBwbHRT?=
 =?utf-8?B?aW9NN2pKcXYzTEszc1ZobEtlbXdDWW9vMnNMZXFjeWJSY1lOdUVnOU5qZm9Y?=
 =?utf-8?B?YUpPb3NVdnR1NlVvVnk4NUV4eVExRk5EeUZ0RTVmRHppZUFXMHExaE5TMHV4?=
 =?utf-8?B?cVBkVnI2amExazFGemw0blZzMWVvUUxiMllBVTJMa0xiRFZhREVMTWp2SFJZ?=
 =?utf-8?B?OWlvUnFGZUI5NjNZc3JqQWxVL2NXS2hSaEVRcDZyV2FnVWVjM1RJVCt2Ty91?=
 =?utf-8?B?aGgwcm9KWmxHdkJKKzNqZ29Ib2o4SDhySFkwR2oxc3VONXRMVVFNK0t4VHJ4?=
 =?utf-8?B?US9ZYmY2TU0xQVdWWnMrMVZuaXBuQWhaZHR1eXRzSGtzbFFEQndreGR2Q3d0?=
 =?utf-8?B?VmE3NkRyQ0NZTW9HZWZobG42T1hMVmUwRHZVRG45bGVNdkpPUkV5WkFRVFd3?=
 =?utf-8?B?T0pXb24wVzFBYi9xQ3IzYy8rRHA0NHNHbGVIQ1VJN0hWQTFFaTduUWVNQ2Zr?=
 =?utf-8?B?cUJQd3hEc2RQK3hjM2tGL2xDaXZDNk9IR1pTb09nRlJvVytTaWhEZEN0VjRO?=
 =?utf-8?B?SDFNUGNjWGlaNC9sYnp4WTJaMDczaHM0VXN5WVVlSmRmYk9UdW9XNTRvdW43?=
 =?utf-8?B?T2VmaXZmemtUVDlsWDJsMG9rdWU0REVGdXoxTWFkQzVkcWx4WWpxdXBvaWN3?=
 =?utf-8?B?MXhxMytoVDRvT0t3UFhiOVJIb0xuRHdoWURVTjZMUUVVNytwUGxSRVFzNk9W?=
 =?utf-8?B?M1BBcnVpa04vdDBkNHE2K2ZUdWdET3NXeE5TMnVUU3VWZkQ2Z0NIcmM1Tlhl?=
 =?utf-8?B?eEJvNzVSSWdYdG9yemxlUXg5NlptaDZOZ2hsZ0g0OGNKSWo5TjJldG9oU3Jm?=
 =?utf-8?B?RjU5MFJvTU8yYzJwS2JWdTBOY0oyVklDMjcvb0xSSEd0MW1wakxWQzcxRGRO?=
 =?utf-8?B?dmhEMk1DczJZMUFObDltYklGSVRRNC9TU2l1OFh5ejJUZ2JhenJhTWpFTUNo?=
 =?utf-8?B?N3U2L0FRYzhRbklEOXJGb2RIemxRR1J6Zzh0NnJOeUZnRWIvei9OZ0JxNG5F?=
 =?utf-8?B?WnBPSG5hVk8vclVGZ3Mvbk5sSGRuNmtPSTRKVFdRTkJMYkowd2ovdHlXZWRE?=
 =?utf-8?B?UlVBUGZKdXZkWHgwRm9Rd1gwY3Y2VTJKSHc5N3R0TU1sQUFsL0ovWHdnUW9Z?=
 =?utf-8?B?ZTZENHpaZEo0QnAvN0dueFhjSlhCS1luWnplTlROcEhYTlBjdG1JOWMyc01s?=
 =?utf-8?B?QmtidWw3OXFiNGMyZ0tzOWR6RTFjM1BIQ04rQm9WbkVoczRMak9ueGlQR1VC?=
 =?utf-8?B?SkprV0RvbjNadmJnSVkzdWVhWmMwZHBTZVJuZXc3TCs3eHVGTVY5dW91Z25E?=
 =?utf-8?B?aUFOcG1HVVFDR3I0WkJ5b1B2Q1RoS09tdW1vQUF3N0lIY3FxNzd0VkdPN0NK?=
 =?utf-8?B?RlMvMGprSWViVE45cTFnNEJUKzlEMHhCQm5EUnZjMGtYaHdTUXdLa1V2bCtv?=
 =?utf-8?B?dmFYa3Z2cHJBem9rRzZzYlViVVFmaWRLZ29EdXNBUE9ZODhFTkE1UVN6am1x?=
 =?utf-8?B?LzhCby92MGpGN0h6ajJORlFBQ0M1TWFaQ3FSdUp5MExlK0tQZ2FlQllPWGNJ?=
 =?utf-8?B?YlJDWXcwc01Gd3k2NlQzVHAzY3pRalhZVm4rOWQvT0J5QnpFT0gwcFVjMzdC?=
 =?utf-8?B?Q3U1SWo0eXNKWmI3RXFZVW5JNng0cnRvOG5JSnorQUY3b29CMUFNZk90Yy9x?=
 =?utf-8?B?dnVjcHBOWjNuVi9GWERjYjFyV0RZYWFnV3BScldtM1pROXR2Y0lFV0RtZVV4?=
 =?utf-8?B?QnBlV3hvbnVib3lMRFJud3o5Yk1uckdkNjdyMEhJMVowS0lUbkc4VEo4TXhQ?=
 =?utf-8?B?eWtINVVlTFlXSmVlYlM1eXI4QzhDZGR5aVpaeHZNMkY1WmtXdkVkeWJ2M2Z3?=
 =?utf-8?B?VXlWaXozZ1M3NHptMUJKQkRVZDg5NHdEeTFMdDNyKytUeTlRcG9sZW5DYnNM?=
 =?utf-8?Q?dld4B8Mx6sp/i1jC1LEJQGQebuSWNXrtcEYPMeaXJI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xL9pivzZraQ183HIiOKgbtHYg+u4LMJHbGnh6+vNszw9ao2K+SUC+nyJGvcMIBT6kP3I3962ilpZJsvqELSJC2XUPnM+UJxbTTJj+NLhSR9fM5QZJz2XdLaorP+RLpY6egYvWzmYf2b/w5G38lUvxiauXrVuqMJg+LzmCcPF/eC7SAD6ytE6aFrcpdY0+qDwS7HTcX+DcTMfV6DLKHR5dPPqIBdjhMy74BS5w2dxOBMPPRAatDal8/Qx2rC07j0W4TcsrfQ6YTsbUGyWzvc3nHJCzHCmAa+UFLWOqNmxaKMvLV6OzotJKvtWM0ACLHIEy1+LwvQDqoEIGW1cZeIVtyQghB6fVqPxjqVbidp7fdrDpUWsatj7NeMyouSIr5kfa+pG3xHLrff2hNAk3ADSTvdnAN0JdX5A/jSSsFoJMPtKSk61TztFCm1ypT+oavwn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 05:55:45.7126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c8a17f-83d4-43a6-07f8-08de6de93186
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675

On Uniphier Pro5, BAR_4 and BAR_5 are not the high half of a 64-bit
BAR (BAR_4 has no only_64bit set) and are not HW-backed; they are
unused. Convert them from BAR_RESERVED to BAR_DISABLED. Add comments
for BAR_1 and BAR_3 to clarify they are the high halves of 64-bit
BAR0 and BAR2.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index d6e73811216e..cf5131eec7bf 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -425,11 +425,11 @@ static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
 		.msix_capable = false,
 		.align = 1 << 16,
 		.bar[BAR_0] = { .only_64bit = true, },
-		.bar[BAR_1] = { .type = BAR_RESERVED, },
+		.bar[BAR_1] = { .type = BAR_RESERVED, },	/* high half of 64-bit BAR0 */
 		.bar[BAR_2] = { .only_64bit = true, },
-		.bar[BAR_3] = { .type = BAR_RESERVED, },
-		.bar[BAR_4] = { .type = BAR_RESERVED, },
-		.bar[BAR_5] = { .type = BAR_RESERVED, },
+		.bar[BAR_3] = { .type = BAR_RESERVED, },	/* high half of 64-bit BAR2 */
+		.bar[BAR_4] = { .type = BAR_DISABLED, },	/* unused */
+		.bar[BAR_5] = { .type = BAR_DISABLED, },	/* unused */
 	},
 };
 

-- 
2.34.1

