Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACF385531;
	Tue,  3 Mar 2026 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520981; cv=fail; b=FK3WMJ/FulCLIQyFt45bunqIIpjMQBwCgDf2yF74dCcJEEj7Qj0Yw9ikCRpGRP2WxG7sYmAIRnMbe79kGcO/vAnT9yS+Pi40vz2C0diDhLVxFS7CZmgsAygZ39DEgcagxQFuD+1O4W56RzYS1gq+G5mZW346AqPSn5ocjHgLob8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520981; c=relaxed/simple;
	bh=gCFbPZUWKAP5ZEFDkDnVu2zg0zAYcuANhEdOk9JNSQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fP8BFOMPcsjIsgDcyfnyN7MlZeX4jtGmSHWRxkMtkwRNwBXllQicU6mG7l5UvYnj6FvSuUttikc3cxe1yrEdRT6pZTsTGxgy5CATC/9viMlkYS66o8WYSWk7NWN6nwRV00DUdBfOFs3JHxp9aEFCCsZyz77xFofHGoKqutTtA+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1OWIZ/Y; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1OWIZ/Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPKB/idNf5IQxwEWCsPtjqhwDOSbS/cBXTiD2a3GFUdIIvZt6GHXGWFsla6tY0/sGVSW6rSbL3oVIRJTNfiJpBn69zjsHT3yptPquRDVT2P5PsQcjxg2+ZOJOhQOs6Ij+at+pzlxbP1AAdl++TIwUYvN6qNWmiD/GohlZeQLEVMrtk0wp02+ijlPh4eBddE0RImhyP/FgAACr/7wVwcj2Ir0d/9ZhFXrkou/hZ6Ji8Cx9pWNVKsULBA1JUi9wDryTzBW9SoFoziefDfB/Ehj83zHtYDXAedgZ8KQSxnre4pKj7JD0VaSnY4YHxdnijgdb407EgXF1yhTsYJe37E9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz6GZ8fZvRJUcCUnE7ufNE6yDtqlU94PMRa4pkBsAr8=;
 b=duQdolvrTZ7b8hAGPLKM04YcQ5j7o6zzwnavsgVq3fFWZeHQ+61rWv4nVXqGHfDMHPMO6qzjxhWKqdO9sK+RRk7jqeRfCGHzyNiqDvcz5sdoYh5Hico/a5SSbqerwcmqXxwFeB+m023bMmJ9QOevIIQQVLDwfEt+wBocihCO8RxhS3UoPyzWgVnHBOzpgUeF1Azgf4zjyjumS3wwkpiiY7XSAPJL+aod7D6CXON+Tkma+PrOh7Ju/1Uo+6Jj7FTYoKhT36hNPZ9MFmalkX4+HREFT3CIpaWhsX5NZ1xsFjYO0dFk9xPlAcu4l0tgWxB/v5BzGdEBQGsRyo/jlnzxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz6GZ8fZvRJUcCUnE7ufNE6yDtqlU94PMRa4pkBsAr8=;
 b=N1OWIZ/YSy2jo7qwF19PrTnUZZTTDez8rXqlB7OcxCWsSuXvDWU3FZZHWPcPJDHQ7mNYtNcxM9MgJfJSV760VDl8AVf+a3elhuvbbPWzF86fcfPtXzfigN6ueetPjJBB8zCPs3gxP/ra5PfHiInzVBkwb82X+UfIMfZSLJzaxNPgN2amEOjOcMLmdiGY+MWN2srGolNkNov4gUw5yKK9fMEAbJ4R0Jv6jWh7rrN6tO9rEohHaFkY0HV+7/3pr6SLpLPgpKISkFfH27qsLDDQbzyZ8sKvqGRreL7tGsd+ZSa2mK5tv6JjthMaJ+kvayLosICgRlQddH6sFYLXy6MnnQ==
Received: from BLAPR03CA0048.namprd03.prod.outlook.com (2603:10b6:208:32d::23)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:56:12 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::d9) by BLAPR03CA0048.outlook.office365.com
 (2603:10b6:208:32d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:56:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:55:57 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:55:50 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v7 06/13] PCI: tegra194: Disable direct speed change for EP
Date: Tue, 3 Mar 2026 12:24:41 +0530
Message-ID: <20260303065448.2361488-7-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7b1c6c-8d40-436f-726c-08de78f1f4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	ufd9s/QQ0Kq/BnyM4c4i3VmLQlXEv7CU9zbRznguvTy2isX+/ydNRIfjP2kgT1ZnQlUffRipTi2ZbEMCEDtIVnE0jSxZTfZHxXKv0DSVSfTUIXZcy8m3Erp/vY7FCGDc5gp2x96ZvZSpHR5aFknRubV0Y8DMmkPy/Nbf0m7Ek55RYgVjT88ORh3OB+bWK33bBThKmPAMcVDPXipNVSOe9jlIwmJ0xfnOWYcyciXeRGBN013J294jf68FbivRCFYOQa9wRPfgxKfq2GVe1peJPQO1B6AQHlPOqmL/jKHLz9h71l+SMmp53WT69OaFeLoJUntyJcBzts3XgdEAkFQMVHBlj0z+8vVtD1pRW2XU8d7jWL7a20HIfSPlYZgHnTLYLA6+0+rqXK+7FhLpNycpcb1bLg+sEyJi7gRsIvI5mO7Ps2HdwEPS4jp1cJrZ9ox/4rBwpKnfV5yWcbOnfHNfZ9mz95ZRgnpZ4Exn1Yk6kc+ED7CsYtsfcHrdZ05hlMCAoNNedzu/pAAsI6C+GBQjpkNRWgWtciFcuK3XMb4KFfNhkzmrJRMpfsiFwZ6zY3ft8OZBCyzBuCwzfuqVb/rB8r6kP6MjcEoV6xdYTXZvQ5bhzuWf+7VI4Y3Xg4YgfpvtsOn1g74o5aVDLDh1+8WX2e144vQz9ADRjgC1BIyyoC2HAfUVxDIy2G2b6Zu+k9oe5WPwdizqRNDqiAE4OHBrTamyXy4Q1vkRil+lRxtjmuPKiQekgrngM78h115VRV7ACvVqYfcqtqUMDgc3GlM3QdpFlu7yQZQNDff+aOEYfEHy4Raw3mk8sM64PcQGk3CUX2vv3g/YYDw8EZsqiBSyC7TqT5mOKzqyvV9YrI4C5uI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qTR/sUEsJiPd5FJbdipLCHvclE+FOXTXfzLuH72qacy7rpQxMQU8Rqn9rNOFEEW37wlcQiDlBoJtWQpdhUPcsOLJu4pqr54/nCkI5mSrGPL783ZAr/PKp0Ue7ChU65d3Gr5kzW/AvYm7c2bL7GcuV31rnfQ/aopF4O49TdMeIytv4/qQys3ykXvSTaAsqkaDCZMJFm7AEYyaLyNOi8L1HO5DQCPsKjmxfQugMqYX4YTsnikDFlKhE9BnSD3egLTfxxmZXFYI5K0Ah/9NBPM8jD8t72WqmFIKpxhaiVnQ6F+uh/LOCQDIRnm9/DKKJy69938y1KOo1LT4AaFZr0WtxkliJdcp9y0rZ1UXy9iGYEqtYOlDmE0a3WBGpLBOcU0fQ79A66H6j31UMV5mB0G9SJMRp2T8n5T9ctAlD9LioF8gnCI3kqWsJ9VBKeXBcHBH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:56:11.9244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7b1c6c-8d40-436f-726c-08de78f1f4bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522

From: Vidya Sagar <vidyas@nvidia.com>

Disable direct speed change for the Endpoint to prevent it from initiating
the speed change post physical layer link up at gen1. This leaves the speed
change ownership with the host.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7dcf3e3596dd..2da3478f0b5f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1805,6 +1805,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	reset_control_deassert(pcie->core_rst);
 
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~PORT_LOGIC_SPEED_CHANGE;
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
 		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
-- 
2.34.1

