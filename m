Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC662F9998;
	Sun,  8 Feb 2026 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574243; cv=fail; b=ldZajF6cI397W5Rf05H6s3PRQSlmEHFhf1rL0ZcGwylwqP7rwuma08RJev1BrpEGoiVwjkOyrwP9q03FG/0rR1aDqtkApZBrvaIKdgwJ9zvfE7ghpMlq/D5Iq9C/9/lf53a29pTmuEi0StvO53Z621h7s/EKMEWUUkkzm6vcCXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574243; c=relaxed/simple;
	bh=XnhzvDnKXl3X694rokc2be61RMZ+on//T5fRiI0NCi0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPVgWBP0oN2jFOzKU+ZmFNEnkuQdkPd1B/7G+NaC9Yq5BguEDDjpRv3qwn02y9oTUuRpaPtu3Pf1MZXbIRs+Lsm/0f8YM5hmJdzBZbYzIo6pU7sbIss9Fl5J1aTa7vY9lpBtxywZkFgQK+UMG34b1uhRJSv34IOqaXvSdiI20aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fg5sa425; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fg5sa425"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUvbrC3I1pYyMCPU0NmgY8kEypXA/eM6Ac3VuJDdFg2cju8FmX4lj9OEidEcmjRMDHuDzCObvDlHCXGvIzG64dSkFaudYt+VYb6Y3R97iblgwn1NjMp42wTWUdntkiLpQSjSPREr0fi8MiZhxxKdNm0PfJYudShDV4autoEcibkQWS9SPq8I328K2+j/HWRVAedniXIGhCFHDPm2JE21R00HzyIkW0SjNLT6hkpd/SzUXB7Rj64fMPvffEKtpJk4PvdX9oV5KAuh7ZE+HPfOIiiFNTMSJnzmvzESKYuRHcfVghWk9k1AaXLUqR857bR6mZy09MbnMdgRxiZ9ppmmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2xgV6N+VA5TW67Zh6jpjOJ+lSXAOkuyEhlkyoYMWIk=;
 b=JTASHfAGO+xp4ToGjuF64dxOMGbgSqaP7QHu8ecDqF6u6mHxQxAQievy3/9AQLkDccCOmSN/YcK4BO5s/myZpQanywPbw8X/ttuWajESxJ1AF4ySNKVEH7ZAU/ezSrLOI+UDQXpiQzjBqMLkf0OKxzITkv1DqTt514Y/EIEg1Z2YIaVdzBLD3TlRU6Gbwvpei1HOgSEUgNSvtfeNQpiNz84MhMXOltD7BE3mBcrCmdD0PYybLyc/m9HNL14lmK2nVYEusxXICuYegVXBnfnYxJM13Y8ZZMvd2DJvUJWUXAb64dzwBNbUv3+GTsrFCShJYFAxqF9LX7ODGIeKaqk2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2xgV6N+VA5TW67Zh6jpjOJ+lSXAOkuyEhlkyoYMWIk=;
 b=fg5sa425d/LJqgopLY6K2miDf8aNLpqHuHiaPb9GeDXimse94ca9q6b0Rrsj/qaBNEAnkqUp5mVuihdOnOvv25JCgOUUA+BWAHAiiqWKboP8uo2y/wNvG5AW8CWHiEUPRGTOowjl/sqR6oWuDESTolaKCXPOyn7gDh/8/cTGZ29VDjDqrZF/Y86Nu92Y5dvhUDwaDWu2m8znMJtLbuUF/wLdVUK9XwcignUzqQEzcF6zLbNYKF4WfcjFM0ulSkbELxVrO+EpSFsVg/Oomw1QmlyhI2Yz+c9W2XhvUk4yYuViOudFluQs72Y1BSKN+yM2RFhAG+1z9fAuzfe/Y/JC5A==
Received: from PH0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:510:5::6) by
 DS7PR12MB9528.namprd12.prod.outlook.com (2603:10b6:8:252::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Sun, 8 Feb 2026 18:10:36 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:5:cafe::b6) by PH0PR07CA0001.outlook.office365.com
 (2603:10b6:510:5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Sun, 8 Feb 2026 18:10:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:10:24 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:10:19 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,5/9] PCI: tegra194: Enable hardware hot reset mode in Endpoint
Date: Sun, 8 Feb 2026 23:39:32 +0530
Message-ID: <20260208180936.2026329-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
References: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|DS7PR12MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: 36dc0d86-167d-47d7-8100-08de673d5bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DTzAXIU1cXfywiQ+qtoyoUnx0D2xdbQ8ZoLxA/f5RCbdr7G2H+w0jDCOTpGY?=
 =?us-ascii?Q?dbXbDz/gEfcuY45AcI0jJezqOMlngBbShxeX2n+XgleZXGYOzkR5R5h0Wy4I?=
 =?us-ascii?Q?FJzYccaH5NA3hfjN0+ohC0cS1tr+evwRQ/4ZtzeRTVCnwYQEII/kgqy6zOmT?=
 =?us-ascii?Q?w8GPay8+xb//TLU16QdeFbf7YEG9hGR24RIcBNZaYATrtfV9MaKVLdXRqvJW?=
 =?us-ascii?Q?CpY9Cuz2lFk8Ppv4QEXWEQvUs/69ZaNqjliHmLctv4ERNNlo5eJvYq72P8t1?=
 =?us-ascii?Q?CrAZy0ltoOohH/LlvlFtVA3h7mthtcnZmVAgm3xFc1W1nsuHisl2nz8weGnA?=
 =?us-ascii?Q?bDDGQatjw8+UXHudYpdvl/Q/zHfZYEDUHm5heA4G6nIh7jZAjAkEko8r5f4/?=
 =?us-ascii?Q?8OHGQyytPOLiZeALHcg12FsGKCXBs6Rj1sacIYZEqwlTSuGEB8XIuK6nxzuo?=
 =?us-ascii?Q?WitRJCIyCxQJW7y5dkQ4gDkCCC1fkihRgJAbQFzBeUqJMp24WQd+1rMMGUgT?=
 =?us-ascii?Q?uq0ciCTvcwPT72I8t6t42jaX8/7kUYdqHscYQgcYGYT9PFYxYv0vA2uDEHtS?=
 =?us-ascii?Q?DrzZ2upPt2j778hsrEplNXX8YPbjXyoM6qoetHciXfbu16wU51N6cQ5B548j?=
 =?us-ascii?Q?NkDVp0bd8NJdmXTQdbitURW0ewMZplwtTsta1sBE0DL17i7JFJ4vw7tq3k/S?=
 =?us-ascii?Q?OvuQgfrNTwBq6+FEEWGM3xP1B6M1Vw1pA9Q1syZJbQ1kj8xxrusrBbn/mOXA?=
 =?us-ascii?Q?xJPL8kKj6SVfBKrra74sSLDQ3tvnm1unMSt7cohhW3NE8wxL53i9uRzpaiQ7?=
 =?us-ascii?Q?nv9l4o+db+VGlPOAoNHXw/bNGgsVkbyFGXUvVYQNoQRjXcCYZL6fYPjBEDQi?=
 =?us-ascii?Q?kb/wSW/UGI02Er/FtFQi0QvHET8GXpyOhism0kvrz6Zp7AFk2CJtJAUIQa4v?=
 =?us-ascii?Q?QmF+9mLwwVCPZwbrnX9GnJAh3TAY0IrGl1nZ8YSU85rONKivKuthjsJpVsd1?=
 =?us-ascii?Q?2+xfXxUe1pMQwIImbSH71mlk3bLdrz3F6nn7Tsrtv8ZB3mCURYdwnpWhMxOh?=
 =?us-ascii?Q?gMO7fQIcM5VtcTPVIZmGEhz1ftfG/Ylqwr8wr9ZF/0sS4yAI6p/Q5moKtjzO?=
 =?us-ascii?Q?8huiGBIX3A7cciPnIKpj4RX3rQhZCTWgScjw79DlSCkM0X2fhqqs32no+usN?=
 =?us-ascii?Q?13VKsZOBxWO89Juc62yL4+A1ihT9hHrQwNdNAm5zVye0D79bMyU8Ba/fIgM0?=
 =?us-ascii?Q?W7TKySQ6JBRJ8MB/VuSA7i83Oje9kQTEZoyrWtBFZWSLMj9/AIITr6iaW6Ol?=
 =?us-ascii?Q?ZDde+DU3hUppPZ3cirbNOI9xvC3zYC5yHJ4bGu4zeYRlibAwwE4pL1bFqQXe?=
 =?us-ascii?Q?jUl4rAlxn/5j2O9A0sGXLNTdJzBkIbA5BpKvdMf2ait39EYbwtIAh04fZAv3?=
 =?us-ascii?Q?nyNX6j5GV+VTWPaF4zdim8AyMNMj11plKYk9rTJ+9vye9w7dmwJ2z0SoXWqL?=
 =?us-ascii?Q?L5olb9dx5kNK0q2XhmQoAKVriJ+R6HMWu4dDAp8mH5oRUO/oZgc5Xxix4Sd1?=
 =?us-ascii?Q?1lP+PZw6qJafTK6kG1XqhArOG+FHEYwzZ7T7j1vZ8a4t/BFSwK125880ZhGv?=
 =?us-ascii?Q?+c8ELdFpd6LtjjXaLs7JBzLb7q3qmaSbj8QwgyuAKNKbltnWQp+e8pLEJXiu?=
 =?us-ascii?Q?wTufK63wVRY/Ub4gs4n0xZ9w0Hw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FdEEJ9CIVtyrrI2/4rRyrdG+Ko4R4+g0S3cY701BA5B/v6acRJq53hxD4L7gLeXHNlZxJjSxH2GzMlIadqh6V7b8I42i9M7ytrCPft0Ybp8yftfJ5RXbCtUobtTISX4IC+RDU7A6qSTju9NtWA5dFpH//cvkUM4TEiJNA94XG4S6jkkxDG+yfTKYZWaKWUMeSguOZ+pR+KCR9tvbzQxGUakLLuobkhQqZaWGqVoLuyOk/Ixjee6nYubWVvml3DwL4a11YHuGcS5oPSBn1HwWDe61atNUCNo7oFprSHb2haq09+ZD/BS5Cw5Ns+JgbohcrJXm9tR+xU6BUApCzXyavbfabnYqj8FtRlUAve5w9duX5nxfBBgx92nqvwyzP3SrxqYfdXYN6DtF+t6jl0lEegDN2D/bVn2TBvk7gz1plSyA3zI18A0JEt5TCWmd/ar6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:10:36.3826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dc0d86-167d-47d7-8100-08de673d5bcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9528

From: Vidya Sagar <vidyas@nvidia.com>

When PCIe link goes down, hardware can retrain the link and try to link up.
To enable this feature, program the APPL_CTRL register with hardware hot
reset with immediate LTSSM enable mode.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V5:
* None

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 110f2adb74d2..f6305a880cad 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1775,6 +1775,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = appl_readl(pcie, APPL_CTRL);
 	val |= APPL_CTRL_SYS_PRE_DET_STATE;
 	val |= APPL_CTRL_HW_HOT_RST_EN;
+	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+	val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
 	appl_writel(pcie, val, APPL_CTRL);
 
 	val = appl_readl(pcie, APPL_CFG_MISC);
-- 
2.34.1

