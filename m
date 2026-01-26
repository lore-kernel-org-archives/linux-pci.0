Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D830FC39;
	Mon, 26 Jan 2026 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413570; cv=fail; b=swm7Lzl78VEeFQYl303soyAYJY8Fqo5gXAvbmvilFKcBO9M7ts3za1452vLRMzvbTL4ZkzRGqbajhY3uS8ac1sQdO4q6UZXCWgCOX0w7lIaandMHD93FNpjvq+eBkCcFPYnCXAt/1meKMgIOq3n5xF1zTL/i1hwqO0n5toqIlHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413570; c=relaxed/simple;
	bh=L0s6nzw7EXh/K36iE6Syu39kcaylIRy0JjG7rj8GppM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+01nGODKc31MSLyDDk2ZKO2l31W1SQJCj418uznB2/xMs6PSyx7rrfHKYb9nDUbVpbZSjuCF3xXKlb9nDzB/5yzV7j7Un0tUQ8tjvXfeda6ZDJ4tmvPj9JwqQ/1sFNGZ3St0oc1Yu0ex44LOx6jNIPG9Vy06jjIeKXZq5PDCnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VUutpalz; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VUutpalz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4FZ8LqN6n77PGjZB6g1MLfKGqMSibQ0eGmXwt6zSXJSlCq1lUjsL++yBGAKX4moRO0c9JakLRMHFRXvxF0oWAruqX/wPzX6MaKfh4q83Ol764qD6ClMlDiTxzZAIlI7PB3VrohVfdrdNWSGq/yoDY0oIKlb/8Cg+qxQIf2z/dSCSS9xIgDH+BmRmJEufzrhc5U8SJ8jEMKf8JWm03RmoYX6y4ToMX7JvA+lsg5xpoRPppLaHSOEZ82n96u/6vW9aRmradr8VijzJ9cTkRgrWDhAEDFPvk7oZxwMm243GaYbAg8xb1Fj9FmtxzSwKcRghUw3Q9XPbj5WjkI2FVbxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/4w3gr9gy7JWTug+GFf4J/Zotz/zkGZgyliSqaDzVY=;
 b=fG65VFv4rDftH9F1z6CxtjsTWGqXRTnbszxM+SN18u9OlG13CD3QNiQ4RGHZJJ5bLkm/gDX+FaSeZ6Q0Dgl9Zb/GBpLbxRztpd0osH04m88qB0gzMgtEHM9NczUXQShl23/dLJajNiXByhLxXMLNDHtOQluMvkIHKaAuevKvrznjQEc+pynKBYiVtWZlqvFYaPW4ug8ufuD55kX4EaMwlyx8o+h9BQasbRiIQxNHLWyh1AvUgQ0i90LZaUleZIgkyZCARonCIYeLx2hQrSrsaxunPOoxi+nNFJkf9mZFAKxrDocd571vOUSCb+UTzpP/oONIPYXw0i6vsCkV397F1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/4w3gr9gy7JWTug+GFf4J/Zotz/zkGZgyliSqaDzVY=;
 b=VUutpalzfiaKhysojIl34/0eKFRq0ouu/5tYYV3xHYM4kDZxBV1Bjlr8uqUt3Js0UPYYjr/jlF1kHCFLp2aaiNXR9F9jE0s5qbnfM9Mko6YmVt0KD9yxlrktFhTdG6lhKL5ox6HAy56vMjkObxUIYjyG74HS/5qH4Wu/zBlI40UMVISIWI8I7vRdx7JeDeAh4wDej2AJuvEDrhgtxoyg6ufVYG/+7g69BNq7qI7GAf9yto76CSCvf3mViX8DPkio7+mliKu8wT0L6lU0a87WsgNhP6ZAGHuL1ChrOjP7iwGEnguJD4SHWWnEECA1QUJ4gaU1JDmxn5+GsTi7q/0fMg==
Received: from DS7PR03CA0228.namprd03.prod.outlook.com (2603:10b6:5:3ba::23)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:46:05 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::75) by DS7PR03CA0228.outlook.office365.com
 (2603:10b6:5:3ba::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 07:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:46:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:45:49 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:45:44 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 00/22] Enhancements to pcie-tegra194 driver
Date: Mon, 26 Jan 2026 13:14:57 +0530
Message-ID: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 22da76cb-5302-475f-3180-08de5caef5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTNyWUxUV1lhZ0tOcE9VaUZtL2ZBV0tZbjhHeTR6a0crSXU5QzVpaFA2Y0pE?=
 =?utf-8?B?SjMwQllja0NjTW1JSGJzOENrRTAzMms5QW8xblRFZ2p5TEtuN2grYlRTMlMr?=
 =?utf-8?B?ZkdOQWJjRFl3M3h1K0ZlQVBZeHd6MFh5T3drQld6cTc4eTRNZmh3SkEwczhX?=
 =?utf-8?B?WWpuZG1CL09yMG9IMlBHR1Z4MW5yM29aUFQ1TzNpQlNuVGFrcUFZSjA5VjNN?=
 =?utf-8?B?WnhQN1dsMUd6cDcwYU04TFpOTlhwYWU1cU1md2VRRXNqdjJydVA4eDQ4ZzlE?=
 =?utf-8?B?b0hER2NGc09CS0x4ZTJ3TVFKQ1VkTjkxN1pXYlYxSnlXc1BhL0VYbG9NWE1I?=
 =?utf-8?B?bUxQT3BQakx3S0J6UDZxMkdwcVk3Z0ZSWTEzV0hGUjhVWVhJaUt2U01MOVJW?=
 =?utf-8?B?UUFwYjRtTVFHVGJvbzJ0dGI4L2Y5ZWxrUFRvWXUwNlQ0emNLcmxKTHBINm5Y?=
 =?utf-8?B?clFZamYwS1FUem5tYjIrQnhBZnhHaHVsRmc1Q2JBQUhsWU9TekJQa3dQUTVH?=
 =?utf-8?B?ZFl6UllKVFlpM2p0TnV5VDBldXpTVzVicGJsVHU1TUtlSVd2TExMS2c3Rmhy?=
 =?utf-8?B?MVBOcW5EOGIyeDdJa1p1OThQMDU4QnhvUlRDcHZ4S2h0WFdHUzJFcFhqYzBk?=
 =?utf-8?B?WWtxNUE0Zk05VUxoWm0yMi9yVGZhWURZbG8yUzQyZEdhTVhyajBIU3llUCsv?=
 =?utf-8?B?bkFEemhFYW9nQms1Q2hoZGFTV2lVNG0xRXNuWEY2cnNIbUphYW5renlLenE4?=
 =?utf-8?B?VDVaYlNwY0FDdTFwakgxSXdhNUF6WFFPOVBpYjF1VmlsWDBRZTBlRFRvUzNL?=
 =?utf-8?B?MU1EbkJYVCtYcE9pSzhKRFY2c2gzd01Eclg0WFFPQUNUWG1HTVhBQXh0eTR4?=
 =?utf-8?B?dEF4OHBGbThpOHZQNnBMUmVEUlJOaHlVT0NWTW5aNy91ZTBwRWRqTWlxbklG?=
 =?utf-8?B?UFlOZWtKRFZhL0xtaytWS3Z3N1o4Qm8yZk40TVdTaUpUWERpbmROV3Q5UjdZ?=
 =?utf-8?B?MzY2NEZvQ2RVVk0xNkQvd2Rhd1R4S2NTTHdqdzdIN0NPUnBFZDVmYjRobWZQ?=
 =?utf-8?B?QzU0dGdLRitSQmVqUWd6OEpLdjZmY05qMXFEbmh3U2J1eFVNWWhHZzYxa0VD?=
 =?utf-8?B?aUFvNWVGa1RYb1d2RmxOUlBYeVR2eitHTVhDMnVtZFJleHU3VS9CLy8rdnRZ?=
 =?utf-8?B?Y2dTV1pJWjk1eUtTZXJtWU11TVl6Nm1HUndkcVBEcWN0dmZkRjRsb3lEcWF2?=
 =?utf-8?B?NWRnWGRyR0FmTmd6SjUvMWdVdmdCcTFVTEVCbUZLWUNkUzFUSkxQVDVpNUNu?=
 =?utf-8?B?Q2VMNm8xMmFtM3p5MjNJWnkzNU1iMjZHcFI3TWZINjB3YVJURU9wOG5jK01o?=
 =?utf-8?B?TnlzSlEyT29IUTJPakkrQTcwaWlnMXlBSzRBbnhSS29PUm55Q2ROemFSMnpm?=
 =?utf-8?B?RmVQRGJLQzBCNlU3MW5uV2hJdHZoL0h6dWRYNTVLdjFOaHlVVTNnZ2NHUEp4?=
 =?utf-8?B?aWl1TzdCWHZhTUpxUGtjL05aSkM3VkdLU0hNVVVWdFpWeEYzOWtYdlVIcjI0?=
 =?utf-8?B?SW9NYmpkMHJ1NHpuY2pKTFY2ak5zUDNVUnVmZGpzQmxvSllhd1N6VkNCU2k1?=
 =?utf-8?B?Rm00ckJIVWR2ODJRaHU4Z01JdWczVHZFQVNhWTFVOHRIaCs2MDZwb2dXajlq?=
 =?utf-8?B?WFhZTmdVVHdTRlVLc0haN29oQ0s1OG1pOW4vUm9Zd1ZJYWdlSU5ETzAxUDZT?=
 =?utf-8?B?Wmh2RDAyYzBaK1ZRaVFTcHRYUFhFNWtWK2xiSXY5aGduZnpmb2g3N01oVEEz?=
 =?utf-8?B?cGhxc3loTFZqQVJjMThUQWFZNUcyRTNrSHdORGxUQmVOdDdBSVRTTHZhK0VH?=
 =?utf-8?B?S0loQ0M4QnBaUHdWVnN2c1JEZ3hzK1hiOWV6alQyb1haWUhxUk1KOWxZM2Rk?=
 =?utf-8?B?Z0lqb0xLYTlaTW5zS1RiWWZKbnN0MEYxQkRlNzViWElXNnViNlRpL2dKanFs?=
 =?utf-8?B?dnk2NUVXcDdWcFVYeVFzK3phRFJoc21CME5VbE5nakw0V21HWHM1SXRiZVBF?=
 =?utf-8?B?WFB1OVBwblA1dk9wbHpCUXFyT0V5Znk0S05WRTZ0QzVNc1U3eHFFWC9CcTZr?=
 =?utf-8?B?d2prUHRWMkh3Z3E5RGZsV24wckhaZFRUZy85V21ZdHpWUkJ4RXl3bndtUS9H?=
 =?utf-8?B?V3VpNERvVlJrZ0xYMFAvOEFQVlhzL0JzaGxETEF5Q0o2MGhacEI2eS9pc1Uz?=
 =?utf-8?Q?caiMp7XaTrKN6AwZ5eI3ASRpKNCNdMjpLJWQDS3rww=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:46:04.8794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22da76cb-5302-475f-3180-08de5caef5bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233

This series[1] was originally posted by Vidya Sagar, and I have rebased
it onto 6.19.0-rc6-next. I addressed review comments, reworked a patch
and included four new patches. I verified these patches on Jetson AGX
Orin(Tegra234 SoC).

Disabling L1SS capability based on support-clkreq device tree property
is moved to common DWC driver, so I reworked below patch to disable
just L1.2 capability on Tegra234 SoC.
 - PCI: tegra194: Disable L1.2 capability of Tegra234 EP

I added below four new patches to fix bugs, commit message of each
patch has the details on the bug and fix.
 - PCI: tegra194: Add ASPM L1 entrance latency config
 - PCI: tegra194: Use HW version number
 - PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
 - PCI: tegra194: Disable PERST IRQ only in Endpoint mode 

I added more context in the commit message for below patch based on review
comment in V3.
 - PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration

Rest of the patches are same as the original V3 series, just rebased them on
6.19.0-rc6-next.

Verification details.
 - I verified both Root port and Endpoint mode controllers on Tegra234 SoC.
 - Basic sanity Link up, configuration space access and BAR access are verified.
 - I verified that ASPM L1.2 capability is disabled for Endpoint mode.
 - I verified suspend to RAM tests with Endpoint mode.

[1] https://patchwork.kernel.org/project/linux-pci/patch/20221013183854.21087-1-vidyas@nvidia.com/

Manikanta Maddireddy (4):
  PCI: tegra194: Add ASPM L1 entrance latency config
  PCI: tegra194: Use HW version number
  PCI: tegra194: Fix CBB timeout caused by DBI access before core
    power-on
  PCI: tegra194: Disable PERST IRQ only in Endpoint mode

Vidya Sagar (18):
  PCI: tegra194: Use devm_gpiod_get_optional() to parse
    "nvidia,refclk-select"
  PCI: tegra194: Drive CLKREQ signal low explicitly
  PCI: tegra194: Fix polling delay for L2 state
  PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
  PCI: tegra194: Refactor LTSSM state polling on surprise down
  PCI: tegra194: Disable direct speed change for EP
  PCI: tegra194: Calibrate P2U for endpoint mode
  PCI: tegra194: Free resources during controller deinitialization
  PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt
    registration
  PCI: tegra194: Enable DMA interrupt
  PCI: tegra194: Enable hardware hot reset mode in Endpoint
  PCI: tegra194: Allow system suspend when the Endpoint link is not up
  PCI: tegra194: Disable L1.2 capability of Tegra234 EP
  PCI: tegra194: Set LTR message request before PCIe link up
  PCI: tegra194: Don't force the device into the D0 state before L2
  PCI: tegra194: Free up EP resources during remove()
  dt-bindings: PCI: tegra194: Add monitor clock support
  PCI: tegra194: Add core monitor clock support

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml |   6 +-
 .../bindings/pci/nvidia,tegra194-pcie.yaml    |   6 +-
 drivers/pci/controller/dwc/pcie-designware.c  |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/controller/dwc/pcie-tegra194.c    | 268 +++++++++++-------
 5 files changed, 181 insertions(+), 103 deletions(-)

-- 
2.34.1

