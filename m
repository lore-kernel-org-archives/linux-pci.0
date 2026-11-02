Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618629;
	b=YEIJ/umHzsHwvrDYKBCwhhn4WWYIaH3ZYgtAiN12o70rwmk4dOAWLxLUoTCp5ORsfJ34
	 08LpVZp743WM/efn7BgEKRB9RsUo0n7H6B401GCjvoo/CCaaREK12SFeL8fPg9jca6Zr7
	 EeqORaGTdFZEWkdI9xSOmaRw4chmIpehpyvRJJYmiBsqaanUZpsx4OURon8FBf8lr6zQo
	 Es4++vuV3i7QpR2TyObo9zVCJKeeYK+B7vH/l37XZkWW+ugqAa00d77RaOtNWw2GMDmPa
	 vvgMFuiggglvbNsXJfMu4RD5VEj0xXwd/G3wiQVl7gNC8TbNYAZOJaAq8JpT+IzlJHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618629;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=AIQ78XCOci+WwDpJ5h1hIo+JHGAoUkVKQTNEZqf1ETU=;
	b=1XbfwxTfmU+KVBBaDCT+OVG+9MPPTRfjGyXzXuW1P2ogdkzkq6HHaylbbcrei4mobw1q
	 K0eh1YJ8S+YyLq+0R37p63BIcsTO+AirJFkkUXiGTPd4kOKzpSGcwhcj600ztYuU3O74p
	 WZFPY9ZL2BBk9sBR70kzumYhre82Q1S3kF20UB5igAZ5HLJ0W48AlSmGwSadKraxLu2VY
	 b2ZtclnXJfuT4R1WbBgpVpOMhT4ZZX5AYKGIVzaGzX4h8zl3j6JMQCnZlBw7PrGnc8ei/
	 XG32e/zy/JiVgXh9zjWOmdX/YxM1+WSNydGzYRhtubTkGVRLWk4YYUz5VqMtWvqvEHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eijlhy9o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.37
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23472606C40F;
	Mon,  2 Nov 2026 11:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23472606C40F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eijlhy9o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW1PUUFU3dXJWVHMGRuYje7//Hb6yKDuQ8TLanZ/YLewcm6b5ALQqYvJhfg9XyuHbHgGiW02SqbZab+V9SRISZGhQrM6d/vCQMdi/h40TvCuFJYYOIMKsiShlXF2KVRpR+qPMChgYkL3XMVX/cWs6E41qNbbH6HsWmjwyRPLj0H/IGZm58qKUF/HJq6DgInxPlPbslKNcPP8IWxPidnh+92ate+aGSZlW5nU6zVF8PfqVVgbCRxa4ZKeW7+/A2OkDtS1be3Srer+VVM0hGACEQl/FjyL3Xub0rV/UYZPNPwaWoarQTNOi9+q0BgJBcQC/QZ/7kuikKNc/tCf3eymgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIQ78XCOci+WwDpJ5h1hIo+JHGAoUkVKQTNEZqf1ETU=;
 b=KKvTMnN5Pu7ScWIygRBr/dUiVehfuGRLPVKN01w3jdbm7L6j/YhiFXTjjVlg44eZt42TRDPjb1BgNAw78LdvLUg+Klb5WIqpvq44zYlvOjVGMbZriGIH5Z8LOVfZONA0l3dAaiZR5JhleRDS3esiHn2QhQv1CvaS9yODyMjMr9piK4Pm8Qs91GCUll/IU09LpgHmIG6JK7tyUrzjrrhlgzZCZS0vINimIJ/Nu6wpHWhElWJtfLXM+EKR7Z2qgsWzxePGuowffNVKyDQDD+l8+bXAye9/Qr1fS3zopLkql8wJiJNL7GB963b+SVnSur23WPIk+PkBDYvK0bowkI747Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIQ78XCOci+WwDpJ5h1hIo+JHGAoUkVKQTNEZqf1ETU=;
 b=eijlhy9oS2OhM8gGIUlpResKqiAFllRB92SnDbA5zyqT+qzM3f+Eo9FH00EiOy4x3yUM4Ovj71iZQK0Ya6Yc9ZPCQX0qXs9TcAf8/RVTgeTdPhKtCeKaa5OFfMVH5dbd4TOLl18FYIMVDOsi5GyXelZFFW3tV/UvU5h58BYfLE58dvbjBVpzeVhXqO2eEdUAnERXX4NjkjNhWODhVIijRe3ZIFkbbKF+o+FapjNTFFtJwgVaLXoDDVFxHnKpbaNS/GgID/eJ3OAeqsq9j3mgKDumxSJu6uBKckbqIBtUOmO+fDkqLjdjv5DggvGo1Ga/sds5DdiRLT0bCTgltlrtLg==
Received: from BN9PR03CA0366.namprd03.prod.outlook.com (2603:10b6:408:f7::11)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:23:45 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::31) by BN9PR03CA0366.outlook.office365.com
 (2603:10b6:408:f7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Mon, 2
 Nov 2026 11:23:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:23:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:23:31 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:23:27 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <mani@kernel.org>, <kwilczynski@kernel.org>, <linux-pci@vger.kernel.org>
CC: <kishon@kernel.org>, <Frank.Li@kernel.org>, <bhelgaas@google.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <vidyas@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 2/2] PCI: endpoint: Clarify only_64bit for reserved BARs
Date: Mon, 2 Nov 2026 16:53:06 +0530
Message-ID: <20261102112306.4018464-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102112306.4018464-1-mmaddireddy@nvidia.com>
References: <20261102112306.4018464-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2383429c-a13d-4b63-7bc6-08df38d3c20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|7416014|376014|36860700016|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bGl/hvpLpjqg5bLh+PwzJsUL/IZ+wnsFytqAJpumf3t4tqsTq3wAsG0kV0zsa7cEThpLlM3WP119iT05jm1KcwHh0//H+1IY93jdDzYFaaGChAqjFCVl8JHYo5wzhiPePm9u4G2pW2AgNMqtVNCBAHoaaEmN2FjCWaEh8WnCbDIYWwQgsDJOafQu5dNIcFnFxEFcqZlG85lOIcucXxpXenERYmbb2cCqm5c5aDeDD+vixixWMwUBNmSvMOby5/bgsnsNTV8++xYEDgSMDIBkpYlVFLoXV8w4yjWglWN1UAKHHo/IHvNuYJ73jxd30t4SYR0VJoH4YngKL0a1IGx/DqU4VWQjSwqx8K+OXKpwxShaoavNh5deqWQRGu2ZUyImfIyOaiuaJBQx53COzb/YvG0Jb3L5LMFUaLbZmkJ54AKU/d4oqlK1rlbz91ENdmvcCZ27P46ZbkCgI5qJnklxNFz1HMndBDodNp1Gf5dA6fBD2/B8uN0hbkaiPniCUTGkLL/dp/2QLiHE2uEATO+ysfX6O/iEN2EpyFNwderR68q5Ew3YDRtphfXQht6XrtT/IhRXyg7oCyvS5Y+aYQHlV6VlXi1VBYZuEYbM3h9AZSlkaF2gdss719SXFMFp1mniP3ulZdGtNkgPu579+omhFQiOj9aXKmZSlNrmcqWTxy+rVf8i1r9ZAFYWE7M50LvKrcDwWp98VIhMIOvtCJRHJw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(7416014)(376014)(36860700016)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0xyzZ+2bhe/UC6iYjcUAXvFCKPRYq0Yk1vDuICwrNUMLxbY5X4mlqqk+luxGIudZPcAKUBEMzPma1BElBVTVzZOzMYLNY7iRBs+LdsBzlXLfnh3BAnNos7qqftfiJP9cqN1qq/OjLDTkeEjtU82OFppUJadMcSOl2n3h+TV5GkK8yVt54hvNOflNCNaB7X3g/KTGrXNrQC/DnfOBnEe+mw3hL0XRls29qhcx05iwp2pijtrGmyboT3Zqhqobp5UKWC9jQHc99sEjSKtylmc9dnqCE9KMV1jJUmj8vrD/DeoQqDOyct4uePw1aV8gK3tGX0FdmLaw8HrlaVFSOm59HsqfEW975yKGB5Typfc/ze0/sSxTwbeouFy4gkEaCB+TSkz0Txfp4UiS7AXtYy2ReuTw5KyT0utibFkqy0oKfKRojiM5djTb40xWjChdC68j
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:23:45.3144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2383429c-a13d-4b63-7bc6-08df38d3c20d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

The only_64bit documentation describes how an EPF driver must configure a
BAR, but BAR_RESERVED must not be reprogrammed by an EPF driver.

Keep the existing configuration requirement and explain that only_64bit
also describes the hardware width of a reserved BAR. State explicitly
that its following BAR register holds the upper 32 bits and cannot be
used independently.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2:
- New in v2, following Niklas Cassel's review.
- Clarify that only_64bit describes the hardware width of BAR_RESERVED
  and that its upper half cannot be used independently, while retaining
  the existing EPF configuration wording.

 include/linux/pci-epc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..2223842c372b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -292,6 +292,11 @@ struct pci_epc_bar_rsvd_region {
  * @only_64bit: if true, an EPF driver is not allowed to choose if this BAR
  *		should be configured as 32-bit or 64-bit, the EPF driver must
  *		configure this BAR as 64-bit.
+ *
+ *		For BAR_RESERVED, only_64bit describes the hardware BAR width
+ *		and does not permit an EPF driver to reprogram the BAR. Set it
+ *		if the reserved BAR is 64-bit. The following BAR register holds
+ *		the upper 32 bits and is not independently usable.
  * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
  * @rsvd_regions: fixed subregions behind BAR_RESERVED
  */
-- 
2.34.1

