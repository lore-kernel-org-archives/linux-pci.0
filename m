Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E61E3DDE;
	Thu,  4 Jun 2026 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605215; cv=fail; b=IFym2nRJGbwqfSqb2qsjl2jHXlf44YRbJnHjuTVWOyqf0quiFrO8VEa/38PKlwILuyGMpEaHAdCvISBdLZ3e68RnrQiSAVmA+NIT0AUoIBRTliKk3zaGqOUOkWknsqDY7BoTO0bPF8aT2UhNi3xETCysquDITIbd8OeHMdr9P8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605215; c=relaxed/simple;
	bh=9zZzyrBF2s99oJAy/VUcMD5yvUgwSkLnF4E26jGo4Ps=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izvWOHyrWj8gAtXonetIiOt6gRwd/xqzpL6p4M9/84eC+NHPuadg8kH5eQYkclZCMAJgtjGHEBvrrddMjp8drxU5TdrwjqwGXOKVDk83Wy2Db5KkthqRH6krNOeB8HkUVxgKhoCcCfGRZqBvay9XnTKgHF2CvpleilBxniT4Ksc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DLhhlnh2; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DLhhlnh2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+GqPuu8yBl8Nf+gHD3o+tf2or+yE1Cqz2bVFC9PTRwXcupUpi9C2b1RE4oxcjx1DgcQzQE2HPl/H/XhzbY2QdYhNclq50DUfYtQvGToukIIEYatrk8pbzleVm0nixVphNcuNotuMPjnShJrO6dcytGA3bPUdROmzkY7nxoe9QfX1oGgw5dz3RyqbsBIlbCn+ME4P76+XXCV9OwSF4HsoZXbUdOdyZUKc/AvgfpJdW3dEstYcArpZ7G/+GJH+Lg85ReNnspJ6z5ahP95rEPxQM6nli5vNOc7vbCB+RZxPdGCJXj0w8DLJprjp9JkCBAyxZ1TahpRrbqy0aUc4N+tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdlnEtA1tLmN9JfDk/jCDK7IQ+P4a0oaWLZKJddjXt8=;
 b=PZ71W2T96RAKoH7C3VGkoQvRc9Wf1FKID8Fe1UFXEHZeUmvW0x9W325vESLNa8e6iHSd6DzVgT6j86RbRH2Lbu+PFdH1ItB4TVDEl2sO8Dyq1X5yNlX91C47TeCTv9bYBR62rjBNMjjfkK893ELazXdvj9wJz0Kpn2gfbQ9yPMN2QcSy7a5YGZ89SNDst11+9IozSMvHVEe4+5xD0Xha0eKE/Ar1RBHsQ2Ce7zY6bYdwwaH5cCGGSyq0Mbq1iM86yN6FVLiU58+xf2+OOy9EFzvYb4BHhRjL1akyNC339HeXVgjdWltlCIWnCkjfiJF3HaZkwQgkTRoZ9zQmJ2lt1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdlnEtA1tLmN9JfDk/jCDK7IQ+P4a0oaWLZKJddjXt8=;
 b=DLhhlnh2HI2erekSpvnBRf+yfWxC5m3P5fqLXrmLP5nn8FgHjL+w8N9DhUvmdfgNVgz5Y7moBP6qW8nl4VrJnwG58mRueZ1RHQZnzwAdxSycvvbmGphDsAPG1n9HP1eI7TAKPeHIhAoY+45BsnquOEDinSA20VCtFlyPPAzdu+ycFUQpE1Swev94nyS6JfQZuAXSXBulg2OngAACoNyeKVHrCveufqWAxr5Vg5w9v8ysPNVgOWrWl2F2zXYvFToWib2eDh1DVgPxH9orareUS80ZaocI0unHp49rYl75D3IoYLvhimBm7ExNbvL31sv3wuJm5/YVPybZIlR9I/53qg==
Received: from BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::10)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 20:33:28 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::6e) by BL1P223CA0005.outlook.office365.com
 (2603:10b6:208:2c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 20:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 20:33:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 13:33:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 13:33:11 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 13:33:10 -0700
Date: Thu, 4 Jun 2026 13:33:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Baolu Lu
	<baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Samiullah
 Khawaja" <skhawaja@google.com>
Subject: Re: [PATCH v8 3/4] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Message-ID: <aiHhBIwMhJ3DsbTt@Asurada-Nvidia>
References: <20260604182116.3179005-1-praan@google.com>
 <20260604182116.3179005-4-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260604182116.3179005-4-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 80896dc9-a2cb-44c8-433e-08dec27888d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7OT3DVib5V+ktozIr8OTzHJnovN/TqdnnjXbBgk1aI7h3p2WKjLrrdswc3HYUCjoXIhUemIJ0XBJ6lL4/kl5dyR9OyUwvB79GfE/e9En0/FmGAmdEP51Yoc8CBvFrcfF4NEjunQPBkS1lyT79aUHXKg5ZgkJDTIjLvtHFn1/EIT6hIduQJaUSTKJWiG9OCGMbr0t4g6l9UBh/qCfWEYcMjK2driBscVsog/GNlXFpPN3/pwALbtJHz7YKwTJ11KpnlAA8jDFDWSUp13R7BIbaepKd89eaybVSKxkksZU8Fs7Wsd/0tHsQTIIKvej+KFiO/J8nJ2c93S6LcZ7rS5+GST+UwJJ/2ZNEg2n8wzep1cVP8IQTzFbWomzAPhpxNF8C4YD1RnRZAGEA2sgaWIIRwBke5NHxW1THRWuVitRA/J/uPjcQeHx2EYjKw+gxu0cGiZqgLupYYf8lIfIEY3/aQRIsYaGqn3JgyICR2fIXQ7xdIns9Jzoao5g6Lz3Sn8U4TP9Tz2tl7KJNrzsAgTN/ODyrkm6+rXmGaMjTteeBSC5/NYkkVXGu1y5NraF13fS0GAYu9l8nq0aBRD7+tCrrXiAfCd7Reuc06DxU6SbtbsSUpqrBruqxEDdUQ9Rk4RIq6EbIuCmg0J6yXDFGPClqmHqwKQByO6l7uTeIT/DZXdGWrfygflB87cD8eFtHLyVjI6LMnv9TrzO6twkc/4o4KlykuwOdJnw2Cqrn+nyQoM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	deitUMlEuMnIWiTeNmeh2Ow/lf8wE7rq3nGv0MBV6e6jumc+GY8DQGlifzqF8u9yzlFCwaNdQ+FV7sfxxde/xwee7F6grPk79HBsGv7taemGPA0QlKXKgSOXOAD+EhiR/Ken73f5kiCSDqFiv8EnRZGHprBttEDkAmvGWoZ1IbMbcRoIY6KBVkIB/eUkQPPzdgJaTrRUoG0noTIu4ALzYSY0BlDjOjhGx2roAKrbfkuKj6+xeputO9y91f07DtfIjSRnODXABE27gPVKmWWPMZ5VPDTAjvvaVoz1jOLdakte4+NbaMDmIp3evcZDtLEDB/+jg224sVdo+Q+b2QUCk/VB5Jb1Q2O2eDGtdZJjZGUn2z4IP4bHSj3yaTlmQUS4+HYGR/Li78xDv1fNKEDZCG3dnRbUe4EUBOryAuuJp2nkduVUlyAn4vAE6yYPDnst
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 20:33:27.8688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80896dc9-a2cb-44c8-433e-08dec27888d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862

On Thu, Jun 04, 2026 at 06:21:15PM +0000, Pranjal Shrivastava wrote:
> Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
> WARN_ON(). Since probe-time checks now preclude configuration errors
> any failure during hardware enablement is considered a kernel bug.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
