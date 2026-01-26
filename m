Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5A3115AF;
	Mon, 26 Jan 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413580; cv=fail; b=PRJ4Xg6dF7SnGtXcJqb777a2+5tSDjTUQH6uZbnmsCOq2G/Dlfp/kQa8MsmY/4cvROS9NvK7LeidPG8ReREEYVBC77zDeEKhn+NdNBX/qzs6Fognv2j8pVGzcxIVS3xFN6KjahkxzmpgyD7hpwy/zuo0tRVnk5ZkOBvVXKYCY/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413580; c=relaxed/simple;
	bh=/4s3NUrwJ8S/aDeZLHN61L67ou9TiYUr4SiEqN45Oh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcLLWteTX6wCNj8jnn0fQ6jJ1nYDKcvzg1m3+9b7BjGWTvsrdYRsBRrbergJG8IYrcXJqXjzotRT8d9zvt2h8GBUKRmd8jcfHmvArcxfUQXVtBBICT6I/l8sm5D9DtbVsrb7+BQ3GZfvVT4QNUBMvZwKrV4OV1uzLmAyYRkgqXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=evLZ3wth; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="evLZ3wth"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TafPsNOKOBBj0WdQDgV6zrrfJ3MyEWkEK7tJrGQw6PeKBsuN1uZNKjRl6ZmNjUbAcR8dUapz0XBeFRJ0hDUwGs8kuENHz/rsCEcpk1d/xOs0PSR3+1rH8wfGuLcMljd5sFIrzFHFVTG3KfaverwRlxacYGpzZZF10eWj4OIQJD+ET2ur7Xfvcd4CjK1On2ayrSS+T9y4KYUw5neD7AcOx+wdRkRtH9du30rOVQwrhuteoRfolg8M9u7RrcTh2aRSEVVHbUe9J9jzqVUv0HtZARlF1qmfaUIvfzw2KrgepXupwPpxAGCq9dYTWgCIe7VqoqcLOoiadgqft20TBwT0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gCOxLXhrgoF1voDwDajsudcyKLXP1NEIZX5icsSgmg=;
 b=n9VQerSl7t9KbwB/q6iVeyUn33OhdhLRK98iPjz5qLDyomIIvYtjEBIJvMa/5gbwmQYR2KLdXO+dCA4kPSZpx0MfJSSftn0Pnm9d89d8Zo3UQjgsf/ZcTLDDRQflHUGnhrWSwBz/64Cq/o6FtLhUVBvMrN+9U+B4ynuc/YZBtO6U/h530nNQfWFyO8Da57Hh57lTQn7F8655AOTDE45gnxe/Zuuxcrdz3pqNLHn0Y6uDCjksDjAbI8zOE9r3YHM9EvgXRVgbiRcZhEMLXD/DGUxSGneyvs79lvOgTJ+BJLPnePlIDxfZ+yk2n3uS36+/ct5cxXqOD+tyCxk/n9tOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gCOxLXhrgoF1voDwDajsudcyKLXP1NEIZX5icsSgmg=;
 b=evLZ3wthp7JRk1r3x1ZZMS6j2ElX6Cw47Px/lh+kOQy0kWlIkmVIgzh3/2P6fPsoDZ0R8E+E3klBbnIMj77I1I4CU1b+e8r+jzYOTdk5ekxJK9VjqA40YQmbYShIe4bk9kSWKomQ1rGf4R+VOr/e3K/FoA/2ip4ee3fSHLu2b9semkfiBkT5tAf2e0HfBYUfgR9Nlj3YfzAnmLuV+T8evq9uWvUqvabgJbJzaMq18yGbVAqUJTEGnSvUEUN3+cR9CrRBYE29phCQJIf9lHEtsTXqY3Ju0oGF04zMo91yUTTYRCEi9eZylze8yBlXolHUBQwsEXANUZKfAKjvnyAimw==
Received: from PH8P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::16)
 by CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:46:16 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::28) by PH8P221CA0064.outlook.office365.com
 (2603:10b6:510:349::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 07:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:46:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:46:01 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:45:55 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 02/22] PCI: tegra194: Drive CLKREQ signal low explicitly
Date: Mon, 26 Jan 2026 13:14:59 +0530
Message-ID: <20260126074519.3426742-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: e97e943e-edc5-46be-7ca4-08de5caefc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lUdhTkX6BHZVtVTZkljmSb2VHteC0nlBFiwdEaAGXTelZEH2GggGypi+la9h?=
 =?us-ascii?Q?FkkgkklpppPGg96R5zBZOhpITPToi+fe3wfr5WkWkUxEZ18mUyKGKMHRHhwa?=
 =?us-ascii?Q?El3SCyuEjo0IqGSkLDULRhwKVnv0gJtDMv1dkKsLEZbOjzYkau+EsrhWrWVH?=
 =?us-ascii?Q?Ux5tArtZCOds/0EVOeOG7wGhoIqy0B6nmtrvmNfueL3mjOOaswXB2iqS1ELa?=
 =?us-ascii?Q?RgX2d2Q6XBpECy6Lfjw/EUlm8bETWQnBoOLnNfgsp92fzWsVodYyvVj04IH5?=
 =?us-ascii?Q?Kbee+cvkdxAZsZnxqBGEPmo1SWFL7SxQKeGDu2hzEONd6/UFtRf+DLCb/7Fk?=
 =?us-ascii?Q?n4FGBpscB6tYHtJLX8n6gmX62rtmlk+xebIjT587dCwmflS8mfeOtJkmIzx/?=
 =?us-ascii?Q?fjQTy+hYzMIzpOw504WE+izjPnjfYUhzQUbbq+b50xSAAT3bmUZ1KSpPv7I3?=
 =?us-ascii?Q?gF/hniJIwqDLvoQQoHVtkOKp5Ky/+xuKvQ/VvY9ozh9mdWXeP5twuZ4MLjhs?=
 =?us-ascii?Q?jiiODa3nT4YHrTOWmqBtJb74VAP+ZnFLhS9TnM7QZn9WMvElpPHeyfUHty5C?=
 =?us-ascii?Q?1F7wzJHzgFswtDr2oHRSlbDdBojFB+zJcUZPgz/osMJDQenUuH7AuZUZvLNg?=
 =?us-ascii?Q?RlyXD+O4uMcbD2cN1XuDztCuClo+YbcGpxGksugB/BmXWxcIts+GWW582Fic?=
 =?us-ascii?Q?CVNxeYKJVkWY4ofErx40DDhHF0QHkM74KmivdpVtSg4TiE3RkwBe35s1GeyU?=
 =?us-ascii?Q?RT0MTCKbkAZe0eoGuolPFrftVsbtcvHNH9kF8WsaGnykv+plYq7GSaoIHz1V?=
 =?us-ascii?Q?qr14oRiT7uJTdxdOOypiAEWA6G9eo+6O3AJAOz+3CgQAWXgMbO9QE2SFy1rv?=
 =?us-ascii?Q?Ey312yY2MfaMPjauRtmB3avyTjn+vFsxKVuG9HoSL9tS3FJqVYngY39YGAtf?=
 =?us-ascii?Q?6p6hUZMUUAp/ZNeM3UASuxZ0fskbEjYRdXC2jDl74c5Rj4tMKCIRsrKSQGUE?=
 =?us-ascii?Q?1YXn4Kqw6sE+ishqtFnCXH9WMEMeLGGir2TPhYkzjHwoE+BLoF6vfObB3MwK?=
 =?us-ascii?Q?K9P6eQ0bhI8t8PWBnzXRT5ATBa2potBi/SOtqj/B7OOQYXvTYzPDJWWRJnZf?=
 =?us-ascii?Q?Ds3w23ZCjgqs5+PQK7o5F9hC1HM5mC8NZ5hJ1z38C9glKffiCS2ZRr+5qsm8?=
 =?us-ascii?Q?OSkb4F8+na9DVRbfkRJO6WnTudRJRMDTrCbaTaHAKCsNGN5UfteAfWC4IcgL?=
 =?us-ascii?Q?WrbA7rX5UxXrJAHjs2ORO6A+ZBDJ9yxgFhwYYeodhYAC1jnu8vibXEVR3DFj?=
 =?us-ascii?Q?yQ39z1ZPq9jiCiGqN7mjAgsUcNVmq4DLe27j2QoIRhZhz7iVxCc2FPGvM9CV?=
 =?us-ascii?Q?LOkAEVh5HnozbcanmRPLl5e892yZAFHy/xwIcMCqy7v9UF8RbYfDttm11hFW?=
 =?us-ascii?Q?F237065LoJwcW8Sj9qfPwRfod2le7o4hDzaLJtV1szXydjeF2GWE7HwczMdm?=
 =?us-ascii?Q?juh/qzVyoRxZxQEKIvbNnacN3taAVFgGT03ZEusJDDTJERdTuj1LA7M953cu?=
 =?us-ascii?Q?4w2zrq06NRVzPzFegrYyIHAur7PHSFInjrUQVB82xm5H04FzcYwqDsjj10wR?=
 =?us-ascii?Q?vdmPbJCBFZ/mwOgjVAu+GJ8+Od/TAgZmoQsr35HqAyEwOjikPJaZA//VvEBB?=
 =?us-ascii?Q?SCJ+wlIMmZU0T8Dc+iXldyw4I3U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:46:15.5903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97e943e-edc5-46be-7ca4-08de5caefc1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280

From: Vidya Sagar <vidyas@nvidia.com>

Currently, the default setting is that CLKREQ signal of a Root Port
is internally overridden to '0' to enable REFCLK to flow out to the slot.
It is observed that one of the PCIe switches (case in point Broadcom PCIe
Gen4 switch) is propagating the CLKREQ signal of the root port to the
downstream side of the switch and expecting the endpoints to pull it low
so that it (PCIe switch) can give out the REFCLK although the Switch as
such doesn't support CLK-PM or ASPM-L1SS. So, as a workaround, this patch
drives the CLKREQ of the Root Port itself low to avoid link up issues
between PCIe switch downstream port and endpoints. This is not a wrong
thing to do after all the CLKREQ is anyway being overridden to '0'
internally and now it is just that the same is being propagated outside
also.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* Reworded the commit message

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f4a13ca2e742..ab2c3f07ed4f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -44,6 +44,7 @@
 #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
+#define APPL_PINMUX_CLKREQ_DEFAULT_VALUE	BIT(13)
 
 #define APPL_CTRL				0x4
 #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
@@ -1454,6 +1455,7 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		val = appl_readl(pcie, APPL_PINMUX);
 		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
 		val &= ~APPL_PINMUX_CLKREQ_OVERRIDE;
+		val &= ~APPL_PINMUX_CLKREQ_DEFAULT_VALUE;
 		appl_writel(pcie, val, APPL_PINMUX);
 	}
 
-- 
2.34.1

