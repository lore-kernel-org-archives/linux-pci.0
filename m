Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28A369964;
	Mon, 23 Feb 2026 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872414; cv=fail; b=nlB+ts2JafHnjhEFiIvHdU96h0eZRajQPBAZQXOleJZ3Z0emASUcxGkpVgCrJvFO42YUoo/NrsHdY4/FBB0bmpwGAQP9U4X6CgFpW1qzpALQ7Cys989UFdm2kx1H5aU3BD01CeHblju22S00EMmg4P+t7+eYs2lKzLkFIEbD5Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872414; c=relaxed/simple;
	bh=dIEnf8PhkqgFxEar9yauqsIDGyQWaIRhVK2U1kpT+wc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/RbtVCzkZ6GUOCQY7f4QQ8olLd5Dtj3KClFfE438uKwbsIV2XsCGYJww7OqV4BlbRk3N9qa3ttCw3egBLEXDdUdkFu6h8uIh2QT3dKNhZpD3syJw6RjSYXbj4NMZl4/9ye8bhBzzHISXP1g4VZMoBjsCkhLGSwEXBy5/MQlAc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f3syEi24; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f3syEi24"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zR5/UL742KdBRX39eyVvkdVUKWGd0Tu1Ggqli15KSJMzSUU1ZOhRpjzLJ3foqmfaqNInneGq22H+woRDSOdWychyXFlCHL/ZHNAMC8OaLM3Wdafqda4PP1o5oyD/Cdg/BXg4VmuaaZ/PrJjV63vepOblSdYx3WG7zs/etvcYRLjwj9YIDFiiUICfkpwwnLins5qttPzi6dc8KpGRK7TEhM9U0q+JTUOQxJWOk4rznHuypc+vXV8AQ+qlPn1l44uuru3GIUVx9F5ftLhg9hPR2T27634V+Qb6x6/oMXJ2t2IEFGXUiS3tdKge9KFFNcfOpNANtu86EoUMB9MWFtkl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGG2j4jgj3iUjvffm/yine8zENyzXhmWrO/QMTwIbSg=;
 b=NV2Z+xiSzvcNvgF4v3B9o0xZ0eyiBptLaIv/Og+CuTG/RpHl7mZXDJMayHM101nQa9Bc3YpUmItuEm/61W2JADdvaJOPvLYXWOCuFWI3Nv3T15s6u0LNIqfGSzHk4Za/ykg4zP/b/NqsudfPI4H+fDP7S1Yc8h8Ix9XNioW8q8bJp5Bk5Vg3Q+9wXmsZIfRV4cpxtVV1HyS50wVBpPgA7GYMrF0Ghqz8aRopAj5zqot0j1tolVEuIrgLQfTJTt5hVbVR/GoA887ApF/zwWKplx7AXONukRJXsvYj2Sa0DczIybX/tgRajaD11MZEkFRGR2kft1byakEfZMnys/aEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGG2j4jgj3iUjvffm/yine8zENyzXhmWrO/QMTwIbSg=;
 b=f3syEi24Zl0ZE4pLHxdiuKTtsNHLALawZgi0roe8kTWpZ43/MPifkKWo7luzXL87n7dqCdC6zTNqFqpv9e+zG83aX8E+qsyJV8oqgkrlGuDFNaAZ9CA1Mnre8RRcvweO9C1fpxY2tkO6zPPX8vjf9I0V1czxCW9bm6rhL/9Uo5ewygQz/Pq2pBIS7hKIo9+ucHK68nm1m//2Sb9sK5d62mdh23/86NGevJlQ43EIjIM5aw0iLVBqucvEfiYRGDKcnd2IR1wekpGrfRlqwjs8h7Yh/sFgwK1+OqgjrAUX/xvBUAmEa3TbMYINLN9dQiDVdo8QsNLohovo31TiNWyK5A==
Received: from PH7P221CA0073.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::30)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:46:36 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::e4) by PH7P221CA0073.outlook.office365.com
 (2603:10b6:510:328::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:46:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:46:15 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:46:09 -0800
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
Subject: [PATCH v6 2/9] PCI: tegra194: Calibrate P2U for endpoint mode
Date: Tue, 24 Feb 2026 00:15:31 +0530
Message-ID: <20260223184538.3084753-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 771df833-c95d-429c-83dc-08de730bdedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8c5qCz3GqIVeRJBwH0rH7uVn1ueJm8jYC+R0tRB6c/VOUES/1Yy5LM/bsNah?=
 =?us-ascii?Q?3UGZRE7I3OmN7NEdIu9x7FsHw6CvHNgk7GM1ih+8MuFGtc+RDWnWwhb7agMh?=
 =?us-ascii?Q?PbOJKNq3wR6Z9OG270U9kUqylk9S1T/QO8ncOvZw1cmc+hHl6kUtgG08ogm9?=
 =?us-ascii?Q?0PVJuJRuybkU6+UilGGdp5lVB57ooXS6OLsu7lJoCWwiyacyh9WxIhT/+tyN?=
 =?us-ascii?Q?x2BQYZzjv1828FiASPwB+ViqJiPyp5A+bmMHjYiJzLm8Uvajg2XhCALrqOX8?=
 =?us-ascii?Q?Dumziw1aa0Qeh6dFwbTml8ttdHPiWxw6EscUm7pQDLvCuv8tBldapuTCjAAa?=
 =?us-ascii?Q?KnB0i0rTFswrxGj7qtZHJ3lqIrbAeehXhDhhI6kZDYG9h/XW6eEPNS7GeiAA?=
 =?us-ascii?Q?y5Bq6HAbrVaprZqyRl5bKQYlcaNCnLVDI3UrcppQ5o4vQ0qw9TZ8+oQokCPE?=
 =?us-ascii?Q?rRf+4+ejOrQAb9n2ISaAdjE44OPQiyFLJJ7E0dplao2BLY/fAnK4qbdVKbNW?=
 =?us-ascii?Q?0tfosf5Dpcv24Q3rbchCsQs5QhlFmbgDi7UBy2bRLNEu1JmqDymBe9QTibi5?=
 =?us-ascii?Q?zLXJaLXa38zbaH5p95MtxT555G6B+UtlDnECYWAq2zcffy/Cq1iqRMiDYqdw?=
 =?us-ascii?Q?/nYb/KmBy9OPsnUXfmPgcend9j3Jgg4FnYcIhftvL1FgBk2X06ykRdExTJO6?=
 =?us-ascii?Q?iI7n67F5YMjMWGwc3qvCZ7DHQZiKk3qz6WTH3MlHVfhjZxAIRriiqgaRdJZY?=
 =?us-ascii?Q?qkgHqoQ+euzs+hjDJ7tKTOojgbwSqlnSCf8hg02Bai/CLmUF49kPTvEqYr87?=
 =?us-ascii?Q?HIjOpTNFd7lvtVwBkgRvhieiENAAH2Fh1TmhjbXpXXqvTBnw8RErBILusxMS?=
 =?us-ascii?Q?JSxCEXk2K6MdgyYwMFk0Tod8b6EEdFuqqjNvyguQTGw1JpNj8owC5TkhTplh?=
 =?us-ascii?Q?fFmjK9kXdK8pdw87mSRYDxtluFkylUnwFImAgJJhhR8AJMimfE4gFDq2or99?=
 =?us-ascii?Q?Lyw+EIg4kgyTrj4Om53jLIixy+7voquXYYzW6yiU+0a1mXSWYxnf3y5dUgOh?=
 =?us-ascii?Q?73HXvHv4aeEWQSCT6Rx2BYJJ+/4CCkPLyIrVANvEl0hHOH5IQtziQJLa/6Zz?=
 =?us-ascii?Q?XDBFX0CgXUK+cOFNnVnT4NVlRncHKTDNKofhCkztCxnjCkSnRc6D1QcsPWX/?=
 =?us-ascii?Q?EeBLt3c0NuYC5CSBh8w8VkWHkoV/inqPK/kKFLliRm9t5CEPFZumcJooA80z?=
 =?us-ascii?Q?4soUM00uBbxywKvTLaw2GVTNncBxsQEi+xDXB48G3Biov0rjYgRnN3sF2KQa?=
 =?us-ascii?Q?IFTut/B3tmclrTUpzakmKMBCWpzOlaqbRtdfWDcP9X+Bqb1yyrqHyg9rmvB7?=
 =?us-ascii?Q?ISBTi9aO30kcFyPmBGdBsW9FskXvgPNBNCEVqlfRxKaQkUJE3XIJrKHAuAJM?=
 =?us-ascii?Q?oCo2kYfwi2JXkgbaxWR49W1QF5aDzALwub3ueWu89Jrkd6xE1hyiXu50uY8j?=
 =?us-ascii?Q?FfUxgJalvWUO8fMq7H/HcldZ5m3GE5LicOeo9N8YFlPynfHoZVgc2X37KDDG?=
 =?us-ascii?Q?Ny1vxDabCG1TzRbEyns7BWLODBmV4Ls7y7DivxTK8MgcVIMfh3AmkuPtreTg?=
 =?us-ascii?Q?s6bYAIVx/Zh0jG4QIneytj+c3YL/fWmH+HAzJt2HTSfc21xc9zztRRMvTHCT?=
 =?us-ascii?Q?0QfmglK+c1KEm3T6Yoz7dli+9YQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OpdMtuWvyD6cfq48zNvGZJVngPTkSFa7TqONplAzqyz4Lg3h0oQxQOzQ0N3x5OR4IN1zXgL+u+W23QmTr9C0FYRHNRb2lJMZNf7seb3Na1OEaPPWJgv5IDTrPHZN5RjxqRph5lOPymZYT/ZHA+3We0y6wMn52hivSGj70Ah60YP7HiCrGuatIdblVOhYigpY3RmtjM1RQ9IfPvuHx8N3EM/cgut9jnBGAAUa9ygvWkHl2WChR5juSAXklQ7ity8xY5GrHoq9bbvPgRQzSnWqGiZvRRw+m/X20LqealTz7WEIqd28CUEemDQVTKME/06gTjn9oC2DIqyVeQ0PxcsT1oTE62eQum7DKYAkmUD+e2FcsOHk8I4HMmkJLRK5+3HCqqpXIEnXmh5Z7sck5rMkP9FISFIf0t9evmH7Ul7nZpeUtyKbSet3imyU8XrZ/2+g
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:46:35.2623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 771df833-c95d-429c-83dc-08de730bdedc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549

From: Vidya Sagar <vidyas@nvidia.com>

Calibrate P2U for endpoint controller to request UPHY PLL rate change to
Gen1 during initialization. This helps to reset stale PLL state from the
previous bad link state.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f026af7c2ce0..51bad99cec31 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1058,6 +1058,9 @@ static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
 		ret = phy_power_on(pcie->phys[i]);
 		if (ret < 0)
 			goto phy_exit;
+
+		if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+			phy_calibrate(pcie->phys[i]);
 	}
 
 	return 0;
-- 
2.34.1

