Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979853976A4;
	Thu, 10 Sep 2026 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082285; cv=fail; b=FC4X2oQMJB3JS578U/EfMuMcClDpnhmWEC3vLaUFKRHl1m7o89O2Ab8EgLE1yhfeaZ+Xz7c0voC+TG2IvjrR8mwNXod7CCULVRZ8P/AGjXX6XA2Aoo/sPp3Hgf+ZCebsN1UQi1hfjcUd/IVL6XtQbM0cjinUVF6M1ovH4jZ0HAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082285; c=relaxed/simple;
	bh=1FPVyrSbYzt6FHROrHaERpqUcSVfkF3T4+VvCASrxHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGNlZdRV8c2dw99ZXm8Wbpd51SAgTbUjfUpI2DZoYviS9WCXHSr/jygXJozyX7yxBc7RbXUVtVDU178LqzsPDcJt35+6VWWT5uRa2I4gS2Nc7vZ9NAt/frH3iOZ1Ak4D5FxT5NFC/d5CljOowOXXhc780eAdM5tITqu+xK2BCxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VEOEYK/t; arc=fail smtp.client-ip=40.107.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VEOEYK/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRBgHhFvr3gHrU02ojAqwWSfhB3vOjy2k3b4lFqIkonFFL57ebl7kswHGFj5PqjxCRs0knvj2yG40RoG6muroNipTZ22LYTJ48cKHM5Qeh07DMQ7xG/3hWLiyZtGaxNSNqDAzWwTvFN9QOKfK1s7LI3lYT8p80x5dNAAXLJUrhWILrPxDBEplF8TwHYMs4nVAA/C1hvPhGIRURlRZJs11/9AHwgFs6i6cL66Am9m+8wN4CGa0eZCxjyr8JPoc17gUY6pc+7mwYxaHjdXUSGrqIhqDzXVnkxkvBEUKsi2QK0RAJd784KobyPZTn4KXJr8Pxt1+GDlaxV3WPWhnp2tYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvZnDQUdwN5MuEEqCw7h1pu7ZSBxTS+mWYEFcTJlPKs=;
 b=iSVyOoXnU2EUj5hmBXyDjvFiSsHSgESt9evVjD98Rx3n+rdz35e0cGSnGBmb16FnFuRLwzW3TTUls/5MpiysmEgDJkp+pCtu+Wn4QieCRTvevOq9NohdzScmGJH1m33S3SaJJGkrG72FT8w0FpJFCw2DUrKxFnWMdZKe4K2zkGOxJGVwXeTwVNp3gN2XEjDJyqcZqbdXt4C4DCF6rqriM0+jZxMLkVWcSz4foD0ou7er5hAN8utC9OWiS3ghnSu/ohJyA2F+4ahQXYV78mg27VEKFGeAIUEsqgm12MGysG4yt7nOY81Qq9md+IILj+uk4H+rSk4l0qjRtGQpU2o8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvZnDQUdwN5MuEEqCw7h1pu7ZSBxTS+mWYEFcTJlPKs=;
 b=VEOEYK/tLCHgXTImFaot0cndj0f+XU/0PZoUiZXhi0Quc0Yl6V0K9lney3E/5WQdUHoDFwtsqx0K0FBlWRw11R6pPFlhL2IaHIPbs5LQzhpzl1R/WIE44XH4hhwm/tqtkgntSA4P+4QUfKU359MutXIBZgLEQUYZv4qZIbLRYQtnFxalXOPVGxghJv+2QnQ0M+pUZDdR2v3txaDWW6XGsTjybSQwu1KSlE30na0Z1N1SiXAGTAUrmHs8rN9jTd2I1wlT+4SqVjZTsIyRKQJe9Wzr+rjVcUTQeJNcywdUJz61gACZ/xxHsn+DHH9/R8MQR5c5oE4y1lZCMlZ+jxG/Wg==
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 23:17:59 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::7b) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 23:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>, "Jonathan
 Cameron" <jonathan.cameron@oss.qualcomm.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, "Eric
 Auger" <eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v4 14/15] PCI/ATS: Export pci_enable_pri() and pci_reset_pri()
Date: Thu, 10 Sep 2026 16:17:06 -0700
Message-ID: <49ce62ed61bd2c0626bde44aca33c515bc8acaeb.1789081084.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb618f3-df6f-4128-f11b-08df0f91c08b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|376014|23010399003|82310400026|56012099006|11063799006|10067099003|13003099007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9dq+exm2W1yhjwx70Hp9G9iyvR8OtwQInD5GDA89Ok5xYMZjqTi/6VD/85v7aobiP94IyM5P9TBQq+/IVLhhjfHvaLosFc9Hnw8ZmHUJxf1inyIB3rB3tyn0SW5AOLy3D7y3Fisu/+zs1zgAVcVBh7Rq8U0ccR8ZKuLGuFzBmq9/kqhE/hpc0LoRRvME1OsRhOSCD6drvS5bXtr9jaQ1OIm4AxEphDI6Q3i8C7y4rsmaCGwZOs+lowGFvTomVhE5WhziFoFcMITaobRyJ0lrbMtatVPEuJSzTcBzH9aHZmblXA07MABRB8XJQdVylC7jsDgm5+j8Gmd5uKA84CZ4e6oA3KaIpy+8Dcb0+sZtKnGNIhjAj188dfiNjvPVDIU2q0+b7adrq8YFqGfUN2b/ma9M6N8aJP1hdd7iXpx+thi+2p+c4FLJO5JUFzrKMoLoFcg7koBoGaVwfWzR3WJ5p2zlv6QcWGFj4j5XHQXxs/M27yS5+7Kw81N+HgCALXnWLCEFBLrg9UQIYgNbGVBV8mhaOMKvtPu9WYP5/HNzTgnL9srPoKH4mRjEUpSM2GPoLkgS0vYWFF/9xDm0jBca2yS59ObMiKwGS5QwWLElLjHA4aKEzqJ/WOLFzSRV+8bT93xHCIlzaqdRsQ2nWcPmWXzeJhTBscFyxxq3yySSSF5+PG4qv41HcWgJSeqt4yRT3YzNuPjrQar73OYuzUo0Mw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(13003099007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9QZPTQ1t4lYRlKvTLpgJPyjUxtAFcWs/SkMfk6+L17Y4wHutdAw++fZI9e9b1BwaCOBNqRiC9JNWC/9EW68GhTwGvfHl6p9KAdIZ3LxwwiUypLtLozAfcIyo6fVdPD36mnWH4t5o+74/Qyoox2zNrNiBjbcChJUdRM9JJr5YFNn/GVQQ2lA2G7Nix+v2RbPh0Ici2TDy60utHVUHxEPEzU/beEjxxMdkDKOR3Mr8/PWFJixcqHfPlLSD95iHWeUXs2sSNIUOsl6JjTbye03GYsBdDjuyFxDg95k94LX1eKVEOcNTo1MI1Uv6UHzQommE2NR5jfqFcvmMgrt0ufTca1xIDCGZ3H0cZeIRuV0axMG9h24mUzyE/SlZP1E708zMHq/q3TWDTS9Cfle4liJI0N57DmO8YPWinZn5t0q6GNEi27W8tOPeXTIQaJkab+qW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:58.4588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb618f3-df6f-4128-f11b-08df0f91c08b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Export pci_enable_pri() and pci_reset_pri() so the SMMUv3 driver, which is
tristate, can use them from its probe path when built as a module.

Link: https://lore.kernel.org/iommu/20201112125519.3987595-9-jean-philippe@linaro.org/
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[nicolinc: drop stale or already-exported APIs]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/pci/ats.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9cb23780093dd..b6de3c858d390 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -320,6 +320,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -399,6 +400,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
-- 
2.43.0

