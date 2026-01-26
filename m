Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A03112A1;
	Mon, 26 Jan 2026 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413603; cv=fail; b=qK/fSPGPZwRhARw+MqqHG2sCvI6vAMv8mv0fgiqjG4mxJjJUU8wpultD7BmjJ584m5++3H/KifVv3S6EY9i5w36j3t81rkyEEXTB6t5t8ECMJwH9ZdY7mNgHmqbBLjutbesBdyqKjPbMJtqv4yZT9gQ6YfEWN4VpcZfth3L53FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413603; c=relaxed/simple;
	bh=fdUdzvD3fCHk35Oa8W7mNLd8BUIfp8gYbK7ZMpcvec4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+oZ0r0AQ0qg4Lygu62U9Fcf1HTOra7N75xs7DKaVutJLHc0J+ScPszjOUJNHKHYqHq0C1/K7ixk98FovlEvFsjEbM9H9mgK8gwdSNeNnVX8+qEeCCnmupHAxeiglBBltN4ipV/g9opXFqiPyZqhPWTl2XdwQhNwzoY4DYd7qC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iI/UotfQ; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iI/UotfQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qg+0P/N8DImadmnPceFFxevKzpUVwoYyMydGnwl5rJ/Kqs78CjwFLAzSbxhHEdNxvm8c9zuis6NlqM02ZXTDS5UA+PBUae7X/v62dcLVheNIauQ47lspJxyuccda5Ebgl7uoT/vrsGJz0Up+jZ1R4xx7943szSexd5Kioaapos4IWM3/MlHkjEmM2E8NHSGgj70ynWF/8YDFLDWburPeLaI7r75pzIJb0FF1qhTZhrY00/hng2H86zyiPDq9zCZo2f8spC9EETKQHpQJ2M1PMAdG/KKJ6W/oQVstXXXk6KyRytdaRLeNKEeJBDrjX+cqxgB6Tp5cAbwGN584Qjuowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42kMpugwCbXYIBdaQI8kvRGura+i3welQBah2lhlWw0=;
 b=axpQwTVMqAPD1oRANFYHWZGwUlTiC4Bqk36TIJzTeIJkgABO7YdxCV5kwcRY7EX//df3nSQor/tIbLJAF2R2cTNV+5iMOi3GzcnhpaLDjMsV5a2gCEarVa/rUMMZ7MTymiTjmCq0aH+3mcSSLIAOkFe82VJeZl0Eo+CSyi3dAZS7eBX5GwIKMwspHrFVkjvvaeP3aLD3Lo4PNUQfI/PSMrBtAbRaOOrBpcugZrXoS+2fuHIIlObun0vLQISW3sNsmk4oNV0ROQ7kukYDPUp+JjcY3+qA4bQGzOB2H4GFgPOsXyI7RVruKEm3085Pt2sY7QMHzWlOwbvYxs1FjENKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42kMpugwCbXYIBdaQI8kvRGura+i3welQBah2lhlWw0=;
 b=iI/UotfQJV1yaOQpklsYf04FdjKkIEMDTn085oQqhU7m9mcll5kd/IH0bm8PYSGG7cMxMpRfwoHnKipIxo2DgSHdNs3fqbTIhPokSIJHq9KYbJ0vIQPrXMrz1WRKFVULU9OkGj3Oka8hqHdTeZL/1nFhqkfsS8BA6EaGBWl/e9yb57SLLBYt3tFmV8RyYrMFZQG1242OpaWmM3s/AQhxwJVfdmR6hbQqy8H0w/cvp+V0JXc3HQqc/QevyP6czbOfCWAxQDoHCNfP61kdpBAd1//E6xylCKxwIDGUsnfc3ekEDv2BjSnOJ3yOZSuAHMN4XYoYxr8aVhimMBhCj28J3Q==
Received: from SJ0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:a03:39f::12)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:46:37 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::62) by SJ0PR03CA0217.outlook.office365.com
 (2603:10b6:a03:39f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 07:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:46:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:46:25 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:46:19 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 06/22] PCI: tegra194: Disable direct speed change for EP
Date: Mon, 26 Jan 2026 13:15:03 +0530
Message-ID: <20260126074519.3426742-7-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8a2c50-c585-48b4-9905-08de5caf090c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xaAD8Y9uBPwUkklE8Yczk3YsTc+vM/ii2huFoLVtKurkrVGVWWDpgwstu7pR?=
 =?us-ascii?Q?a5CzVNtcvYsaW8Kjp3Af7Jvh5qpNfCybcaFxomUP9Wfux4MRtRILNhsRy3Sl?=
 =?us-ascii?Q?DweCRmsRB+kvLbunHNP2CBt/HcYS2m8Ss1zTApiXPLYZxqWgEUThWRpRuBoA?=
 =?us-ascii?Q?/VdWfKHVt5ZOqowJ95IVWExiWz/Yb899Hv347b5WSCXDDt5jcnOQMo+N6Tkd?=
 =?us-ascii?Q?D2gXV8uM99Fp9QwQnFTMENhy0RpJNVZdcEYBxgjk/+2ekb/qv3573DPDHJgo?=
 =?us-ascii?Q?etTk0qxeO5uB40Ej0eacknjNuNv6OiZTc/U6iU4XOY+94TM3Jn3fFnUMMe7x?=
 =?us-ascii?Q?b+QKSu+/8rpv4FNQEq/SV7FJ2uquF1YG3qnDIcLfr2pJ29zQr/hf5dRhsKPE?=
 =?us-ascii?Q?jsUaoiUL0zH4pgrUgT6yNH0zC79+qHrj7396/fNpvGxaXfNuvYGkdy3V9k6v?=
 =?us-ascii?Q?t9uL4tlqg0GmJGzueIqJ8b+5qGIo2YGTuNEtkR9xyrv9De4+U7PPMB1+jopN?=
 =?us-ascii?Q?7fDnw8A1FcusZXC3//Fr6R3kD5mEVihKUwO7qHqRlMxS9mnR7jIkpRf3tO1z?=
 =?us-ascii?Q?68xWIZemb4it5K0TokOvrAdb6qZe9ANlhaCc7EbhmQgwCOjYPFxNOfYaHn2B?=
 =?us-ascii?Q?MVj3djbOex96Bh9AfkWN4w9B6+BmoH1l9ICHqU3NvCZXol0+ZvpTRvEIPO4a?=
 =?us-ascii?Q?jGdFkaRse6uFZctnDVZQfwAtmlcURniIjjkA7ZrBzTK7GqXaCXE2y1IQ4Lnw?=
 =?us-ascii?Q?EEIg5jXrKQeyrXma6dBr81HwVhN8dwP04bv8c11EBGRPRBk2/nkaN5Jcw69p?=
 =?us-ascii?Q?UO89owh3mGLGv8XilXfWeYfoy4gt0vATV+uMG43y9WkheSHWz7ohOffAboxk?=
 =?us-ascii?Q?pgnEe6So9HB9mLfaoac2leSIYsk83LJnaVwnuaal/UbPs5LkpFABE+YyT/YB?=
 =?us-ascii?Q?0DxlVMB3DNMD07GQWBW5xQ6R/La4RFSaxopPRfVqjDD4jXWjde6V8nVPiFof?=
 =?us-ascii?Q?Nqes4t9nYELBoeQmX6HDwDH6KWDDwQm1sYjVNxeT6YtJOWv3sxm4f65PFEIz?=
 =?us-ascii?Q?SXcvxXBfVq0w16vI24EAhp6mO/oC4slkjH8MjRCkhtYemROoe/FqI8ctNmBg?=
 =?us-ascii?Q?ndm9BDMdszNqhMRSBLtVYwzPW/mGLhVlCc2sDPpvFsUS0fDgrVkM1VWnMCn4?=
 =?us-ascii?Q?kguf98j3bbo0ZmdwBqW/tbMMT+Ex9UlWlsudxW+qFDYR8XDLUEnRuqq+nosN?=
 =?us-ascii?Q?cfA7mw8jD6UZ8L36A88dsB5G9QAxNy3LJzAhDt07AVQlYaqyqKZxXmz8VBh5?=
 =?us-ascii?Q?zFn5SFVXnhYwdshIhp2f43qGmbX3wynjHxVWGUkiIIIDNuUWgM4++DHYL+YZ?=
 =?us-ascii?Q?z4zdfbd/Q4JCymKC7i86vyJQ69j4w05k9tPpg1A6PS4WmX0DmR0ElFPfNl3h?=
 =?us-ascii?Q?1XNo5La0wriokl/Fi0qqfZx2wwN/HPQEUBpz62/nRiddyq3hEx2dk6N7y0sw?=
 =?us-ascii?Q?1xirUorfN6zwBaOXBoPpJV41jmHbNyM8KhqKfXeDyoKe3m+a1VNttHWPPear?=
 =?us-ascii?Q?Wc9geBs8g2zKl+dpVJU2vcY1JiqXVtjVkuGl5vKQsddCDahbiYGxrF1h0BJv?=
 =?us-ascii?Q?wTK0xe5WHfPFVMKpRuxvSgLjS7hsdwo3hywo9tuniJNx6zvPxQZQ7/fwEbpM?=
 =?us-ascii?Q?RvOqQHbAc14ppeYwXAUqLe99UAI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:46:37.3761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8a2c50-c585-48b4-9905-08de5caf090c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338

From: Vidya Sagar <vidyas@nvidia.com>

Disable direct speed change for the endpoint to prevent it from initiating
the speed change post physical layer link up at gen1. This leaves the speed
change ownership with the host.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* Reworded the commit message

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index d3d577d5f67b..25f933a578ae 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1841,6 +1841,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
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

