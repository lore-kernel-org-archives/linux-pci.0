Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D322B9BA;
	Sun, 22 Feb 2026 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771788955; cv=fail; b=MyxgfhbbZtixyjIKNJKYU9kkrGk1/SiwqgVPYgAZT4i3GgV0a5uqprMyhkA4lSjCXDXCQ6U2kFuUOcCZxLp5QQSrrgjGP6cZ7KEYiB/wDlLP7dWo/0+ARgmHYoPQRbSzAojgxxUd7fg9gm50hoDCmlsKxVEcnv1a7nA7Oo3JBgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771788955; c=relaxed/simple;
	bh=5em9EQ9o+F5PO6/i5Jl8kzb1iGzQYw2XXgHup8JmODw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eynz4m2zckTuK2rI1biLp0loHFEVxWue6IPTeD0vYY233gN6QAKjABJgfeZ2R3fPuyFLGtzPYlR21XZASqRHmTE9f2TB78vfaQ9mZAkMgqU44bEVFOlx3xz/3NzVtnn+WRdVgAMrjXUskHcErnjcXSxvkWjfl14gz8RFmUGzzyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rpXIxxMU; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rpXIxxMU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A91FssaWT4hzi0wLNiWzBCYopbfOwOAO8fTX5L1IjhEo3jIISLbP2TFGl8pppbNsjFnelYu4KptGrN0VHHd0jBehG116jYhNrQPLSo5jd/pdJhRi20dp6MxxrtU3AGPU6Tg08hokEdrEG9Zxh1K3eGTa4lGRPMr01EjANxyyAoMZy++1Lz46uoCCrVI8oGn6T0tS/gsvmqj6X4J6KR+iuO9ZtxJYpenRhuNREExdtHLOiTX2gIuO0ycsWIsGeOBHa4YEoQM0btTouD04kyZDxvBWpYVUBDnz1roH648Q/xXM+QzdxsbY0ZuGFlxksM9Zi881shmvW03TEJmuB5rXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJI2NSpiKTAXz8GZ+ggTGzeLEXX4wVhzFw20Ncn7VfM=;
 b=k6mgEE/WyhKEdsbNfCY2lc1YAFgLu6JHaKA7nwfdeGVI6iWQsvX83WXA/ooVSsBXaB2J5ypAEkJE2KgY+ykasDQgJ7BprXNwIsX3nvzsY9zeAHKqEOethB5XrKWOhrSmACO3m2fWqmdLv6jORjIdpl9hQASgmV9vvsXHVskXwH2rGM0JZsvHVDMZjuHK9piGeewoGp6IZZav9KgX3GXYYtGLtP0RMmD6ShJtZ7Tdc0K7fU/eBEItxbJfZoq8pLPNnhmT22aCYRmmoAwz9eJX4OmuI782+V/+83xFZvj35hA+L/R8HOz+BLpeqH6+0T7lsNnzUNB0gkljr0STkQHnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJI2NSpiKTAXz8GZ+ggTGzeLEXX4wVhzFw20Ncn7VfM=;
 b=rpXIxxMUxfaPUbRK2uRu5IwBxht7LJLXcez2xYYpsa1wHs0Z/PXY3m/Q1kIyBPDwdzvKUU8HOmo3HdFqTMj7DM1nFiPj2DGAUYa4iAdjjhkG4vHsvR7d2/Yx5ZIvadmeKFT4KK3WXzCAWFbEY+TeE67EruG664X2G7VU1WSbmFcAWeJKWMawcGQPLo57RN+l0Sve6wtaVxUH2P57YHKaBVuCgE5dUsJKorMqRDXYwFzEiCg9KbHQzKblgQoW+fsFsNDj1DBoG2GVX3frew6ZmnWGjctYBYf0XHHy1soKjgE9J/7UcibF8CurWaoMmQgqQ8gyaYEoM0A7tBTQH+Bwag==
Received: from SJ0PR05CA0139.namprd05.prod.outlook.com (2603:10b6:a03:33d::24)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Sun, 22 Feb
 2026 19:35:48 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::41) by SJ0PR05CA0139.outlook.office365.com
 (2603:10b6:a03:33d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.19 via Frontend Transport; Sun,
 22 Feb 2026 19:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 22 Feb 2026 19:35:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 11:35:38 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 22 Feb 2026 11:35:31 -0800
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
Subject: [PATCH 2/4] PCI: tegra194: Make BAR0 programmable and remove 1MB size limit
Date: Mon, 23 Feb 2026 01:04:54 +0530
Message-ID: <20260222193456.2460963-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
References: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 690db8fb-0691-4c64-6341-08de72499470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ERoiUTI+aq5jFt8+QLSIXWm4aS09wNm/dv43fAxZYW29rPisM3uzSIeLJ7LV?=
 =?us-ascii?Q?nFIDpCcGYl+o9g9r3yeSYIU6n/RTk7WdsPbdBM7kiZmBYcCnpD7HQFUX4+do?=
 =?us-ascii?Q?kKKytvUNEYtJAxEZN8Ln5BATdt0kexp+717WRZDRy97/ZnkZtqfXTdUmzNL0?=
 =?us-ascii?Q?M+AHQwyChlTnho6zE/S00nj9h85Tid487Pp7HBjfQqL7qzPsPMxDMrXQr+EK?=
 =?us-ascii?Q?Ddj+nnqWkCetQTHI76NBv8pcWQApkOKc2Alm2LfgVLzKH5qSsqKQ6/E58oPo?=
 =?us-ascii?Q?5NabU6y51ndddNTqPkLVYzwD1zNEGutKafotOqpbtcnbZ1VjrSAFHWn2f+oJ?=
 =?us-ascii?Q?CV4lIvTYr0P8Q0C7liYItVhuKS1vxOlLVRtFFFuOvn4pAace0mbj2H7siN7t?=
 =?us-ascii?Q?tW5ZzZ94S6uVw3mqFydw6hr4TYkWZ11fwt5U4RBEwHTbeKWND1LsAjLm85Fs?=
 =?us-ascii?Q?5ARFNXijRZK0K2NjuMR6T3w2BAtVZoShFpq88GcFHDP5tHxrWyTFx1pLWRVd?=
 =?us-ascii?Q?X4qMVMgCakOuoCZ+mlRO+OnaSHVVx2AZJqZVfqZeo02gw5pyp2fhLUmEms6C?=
 =?us-ascii?Q?ycKSaPGve+8uUrHQwGqm4v+yqFwR06PEXGgItmbAEIlrC0ZBftlWyU50G1Mc?=
 =?us-ascii?Q?dsCadaX7cKptnfDB9O6fR/T3MubRZWWe/9h+uIXLMswWvUG0zliA5dQlBNX8?=
 =?us-ascii?Q?u87gqP5u70qs/VItF90NTlYgnD62Uy6m3f16JR5WP6Lnr7XHN/ojphR7ujsB?=
 =?us-ascii?Q?l0LxM2wKMb8tEwqHS46ph0vUMAg8TrdnVlGhrWAgcLjDmsGL/FiZyeOoPobY?=
 =?us-ascii?Q?NHC8Mv5YcAlgLggw78je9FqM/Iuq/j84T4BRmKWt90+WxcMobnqXe5T06EFf?=
 =?us-ascii?Q?MM6Tx5kfpbG9TJZXrVEC8UHYj1mnGCkmOTn9+bbr453LtuWOc6uLT0eAI9ln?=
 =?us-ascii?Q?HtyeWq/Ijtca1wVwGcknhctzs3QUd4WLr5rhV6ofkgU2gLeMLR7CBHLb8rCV?=
 =?us-ascii?Q?2lMDI4Hhm+ZCmS6ZafdhdzicTDKklqOF+lcfpW7R5OO+W/RElDlQ+KD9nWKh?=
 =?us-ascii?Q?pQSM26OHIvbJ1xydAbe4LLhcolknXOsJtRmraloKd3P4J8pnxY6119mZ9jop?=
 =?us-ascii?Q?ZHoy7dES9GBvDw1qIreyDMWoJ2yp9NmcOM1j4bM0H2UIfJHRTACOgoQ7z8At?=
 =?us-ascii?Q?fFM1zkr5sG9FCR6Cw3PbcQaRhM/h8++chQUu4uJkz4j5mkcKK9Bw3Gh6Ih2F?=
 =?us-ascii?Q?s3nTN4ReNG2Jk33lfb7va2GvUVaFNdyBz0tzAw8iu8SY250KNq9H1m8HFbPy?=
 =?us-ascii?Q?p7ZYkrDAmNIoPyTJVBtJT/5qgN7bsh8gmQvMxhn5dpJcnphdoUMb0FIbpznt?=
 =?us-ascii?Q?Yk8q19K5GrwwTqP/bWPpGlSlEcIQ1/rSnpropjwZPPpYsrFroMh3g2dDZcx/?=
 =?us-ascii?Q?nVUVp+lrHg85GZaVRcEtOA4oTP1iCedtyl+Ch2eY39a++Ge5r9GoqozsGgkU?=
 =?us-ascii?Q?kWCegfaOvciOoYLi7APBIX6ce8DSnI07gCNhNYbk/I6fwuNCoe9tO4lCgSrN?=
 =?us-ascii?Q?WQWb5/phyzW52Uv5xO/OqnZ/8m2y8/UElgN7uJTKpec0zhjhiF8aB054ZgP7?=
 =?us-ascii?Q?aCcPMq1w1rinuEDekAwqOxmriSFae7Tn5nk+cac1SwdNMZ1ZW9dkhCICw0yd?=
 =?us-ascii?Q?D8JDAQKxLatYCtfW1w0GcyWo5/k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S0xb2rO3Yzj3P/gDAtR84SDEMrexugvKwM7NQyaYi01F2J0b6LlSmhhF1zmRwyzdYhxD1JQ8uxhdJjbP8TE3tDcejdmKoQzKsn5PxaZvTS3ZZWyhtmFxyyx6WVALkZJqVR0/OhWAsQruYOUEetuNTDgRridyi7gTSej19s+PnkMR7A69bwMXpsbIrjkZsdTHYUyATXGCdwhrHxrzoflNsqXRVm2xq9QYlFQgbHwsie1FUqCP47QA8bwY4YM19jaxhuj0eEPhYMoYb2xNiO9IF4EOkpyCWTxLQuF0XHSb9UWdnHw4bC3QJud421DdGOSNswbQtEdNlodlt960IARuyQv1zapNbXtBT97W78D7YeZoSUTqhl4k+lFukV7+0r1q/AVQYRNxOMfrmqOAvA4GnWapas4MvrGvSIMHH7B1ZAHaVLtclCENZRAbwhR16zUw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 19:35:48.1490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 690db8fb-0691-4c64-6341-08de72499470
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981

BAR0 is capable of supporting various sizes via DBI2 BAR registers
programmed in dw_pcie_ep_set_bar_programmable(). Remove the 1MB fixed
size from pci_epc_features and set the BAR type to BAR_PROGRAMMABLE.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4a3b50322204..3c84a230dc79 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2000,11 +2000,11 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+/* Tegra EP: BAR0 = 64-bit programmable BAR */
 static const struct pci_epc_features tegra_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
-	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
-			.only_64bit = true, },
+	.bar[BAR_0] = { .type = BAR_PROGRAMMABLE, .only_64bit = true, },
 	.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
 	.bar[BAR_2] = { .type = BAR_DISABLED, },
 	.bar[BAR_3] = { .type = BAR_DISABLED, },
-- 
2.34.1

