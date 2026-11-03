Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793736006;
	b=pRvybzG/UCv//ltpNrECtEqr86Z4s24fL28wB7XD2WuGwK/wKIVyzosGmhqaJisGqIUk
	 iFflzV2Fqo1cxfGSM3o7n2l9F/oYee5FBBO4SYz26Uk36sI9oXxBU627CSATEdluUGtUW
	 I19PkNsRxWCSkOa/o1197cmoDZI7DGIQJxurnEsEdjjhmzRZb4FnDZhO8BzUGglGrznkN
	 6Cx0nJjhGr3qIqJaSdoCQLMmwlhkZw09OZVVTddsOB6WV+HfhrbeSYmTYItet6OTuVHx6
	 ilyGPRPTeVSlicgRR5zrg0CfAv8b0/NQz35hcLpS6eZQmVpnGZfHl1zavmohxNMttCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736006;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=vCTJcZhL26HtouoiGcDBVSHrwWRDvZYy/kvBwE7I+Z4=;
	b=h6yyOPko3Jm5k7UvB2OjOFosdJXpbH2MEg5ZijEAWTFeQiA2lEW1vu+XoFnoLSavsr9V
	 XkQM9X8Ui6REuJCS4zuEiWIduhUUOoVdx5nocHOFhias9gAAzVGpncUiEP0G0t+Vuu6a/
	 xEAu7/h99tgVG3b9TxFo69h56EpMK6G/iZsUJrWTyf1sXPM1bW+JA/+hsCkntFkis8/Ie
	 51DyZZZAZj0itYrZfqLgpg1kX4Hf7evl4rtoulkrmzutTDjPi8GEv4yUU4kLmoMXL+6b9
	 2hF6Ae0Emc9T76LEH5Fug9RHTebR82TntMHzLWOgN9Nj8ueRY5Ok/RCj0TdQCUO4rTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="R28vTRl/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.3
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E18606A339;
	Tue,  3 Nov 2026 20:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E18606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R28vTRl/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaqeYxOm7Thnq72ferVJM1sDWueWS0F3By1ia9RfZaC2uNMKPW6WiAlXFwu+oTVP1ozl63HCMSPX/HUp+Hg6TBquNHHrtM+/SPCHKjUCsLXJlSP9QF09iZxrjkluWP/H4ISaZXpjaGLSpOlnSYdY3m7xpdam0K1L7EWnDvdOQV+CZA2rbEomrMqJgs6eKR51tcy8jIyLQf3/FgLUvuDhY/q97/bWec1tUTcYvNPrwmf44Gq+Phj4VXMoWoKBcTQbnNKtQIQlTAwIb3aLxVcFYRHQsOXi4mSq8LXmn0QSIOAFFX79CFmLc8tkUrNhw9/Fc8biWWo6Gv6oLR+jSh5RwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCTJcZhL26HtouoiGcDBVSHrwWRDvZYy/kvBwE7I+Z4=;
 b=CeHts9YoqarVp2sNTL+Oa9cN6b+A2EWuFmmsmVB+n0f0O3kjnm+g13VU887gwk/bYBW0nhmdjYxCQdDWGs9/mNo1Of8EE/aXiQ8GunYKMvbKTGjpH9zVeYuI7aoDHx9NsHZIwY3F2KiuGm/e2VJ/ZcagLkdbKlrZSUbZa+1VMDsqG5MCteWJWVPIez1Q6dYQmrjL/pJHjwRFtgU0N26PSVirsPIYUFH5ysBS4s1H7U1ULnkMNPOn4vrMtyjoCetRjeHdynYSl71NmhFoNmH1bbOqkadLEAENdeEKqhYit5AqdSeqnFQKgQPeaNadIX+WpHnWcnxmTXoO50jqrF3SZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCTJcZhL26HtouoiGcDBVSHrwWRDvZYy/kvBwE7I+Z4=;
 b=R28vTRl/V/r9t+kn3kaA+keb5kTBIcm+Za8MusYF7g/sgNdz9pSLnGZY59aAPR0Dzn5Oc02OdmiU7GilKuPwOaD2xbLf9e4T+IWiHLU3QoTI8H+xH3Kmi7z10eYnTGEInHJi/wad9ZjH/P9NnX0Yti4ylOB7Do/YcyuzI/aHxO1IF0XIm0e1PJGHWIFfYp1mbYstj2GnWj7CwHqgWz0xBri/PezZzAM+RG3rJOuF2YyZL7de+H6TP6Lv2AfTpdY6HjqMMJSprElux0zXOTtugE4j6VgIlTrixKL33R4ke8wel+iNlD9pERR4MzYdXdnZ/Wv+95B8mrVd4YaxCaslZg==
Received: from CH5PR02CA0002.namprd02.prod.outlook.com (2603:10b6:610:1ed::14)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 20:00:00 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::87) by CH5PR02CA0002.outlook.office365.com
 (2603:10b6:610:1ed::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 20:00:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 20:00:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 11:59:40 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 11:59:39 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 11:59:37 -0800
Date: Tue, 3 Nov 2026 11:59:34 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Joerg Roedel
	<joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <djbw@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 5/5] iommu: Pass in reset result to
 pci_dev_reset_iommu_done()
Message-ID: <auo9JmNGdaVZAVy2@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
 <b8a1c348a5ef457bd75d882aaf60b9156a5aedb3.1793729707.git.nicolinc@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b8a1c348a5ef457bd75d882aaf60b9156a5aedb3.1793729707.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd22e3f-bc11-4765-4eb6-08df39e50aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|376014|1800799024|23010399003|10067099003|22082099003|18002099003|13003099007|261021135927099003|56012099006|4143699003|11063799006|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	tZhF2EbeKpK3lF54234u+faL6LkY7fBO6BzMwJ1dkB2SGgN8TdK1D9CWm9baXWooWta41n1+Qq8Q4tX0/eQrXS+DhlXvRaRIZ7OVazNm9qnQs6Cr19ru3oR29wuVoygbL+kb7KVuLGL2TSUfxBg9jN/5sYXCmnEROLtsqBqf4HQJQPGLEnGX5A3rJemwtGNrSMmBRjJLku6dqf3tH23P7ChTniaeNqxn285LEf7Orm6XwgMkfZTHObuIrcOdW7r2teZu0bxe82Kl8Ggk5Nd4cqIKgloCXYUX4CYx8vfe4jyXxBtPY5QtUl4rYQojLy8wNM8nbPG5EF8NYaa6otd+89mhUJjI1SCz9uZRwE+++YogrYLsg3iuaApWo4KCvIJDH1tc2Sqiq6UvFBQguSD7V1UobQh4RmTUOYgQ4b7XOJq6ooQA39WF59KJQ2W1qpRwb/aDT6dA8ioDlh7OSr9YN4TnjSv0dsasHe2xPU1Rq18NsI/4r54i4pFLIRhgMo6HweZA7wuREXN1Htzf0BSqI+SDx6eU57RvnykS0DpzsWQUy5p7GUEzVxd3xvMMjOLHgvWvVVZcF2YaKUlljcfjf8xLBOb0Nfw0TUJh/sGz9DCmAvITOLisStNmy2gwe30jGtWVR1+jLyTWRWXDZzLK2PU8Uh5/vk4+D7ko+hVrJ/ooGVFbL8Y9jZDozwxElJnxSpQIR7VKMgY9Kn/TiWAqoQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(13003099007)(261021135927099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g1iAqhyZzYwiVf2+7yfFse9bPsXdsmZG3LhL5RAzp4ju512iYqLh9eSfWoaWFzsvUJh9Z4xX2HJo2tJ3iywZtchFMy5w4rR9dtt8TV4V5HDrmq+4wHhWQtlKCODsxDdsC/1SC4VrNymIS3OS0BOYo7m66xQL/iG3uCOaOe3+6lFlg5P5NjAnWWDcvo4Ct7hOxnOWbaVxSD6vBdd378RXNk3xKoS0vUyK/ULSftDjQXrHaBsqxD3uDQqOFVyFpNTq6sNAh6t5fKn/DO6sRZoOpxcuqYXI8z8AQBrOCXUh1c/w2czdWqxiywknpo/SrEoQ52B5BFxp3XGqWFr0Y2nRJlBchi+x9Vv3O0YGlgt6T0XaWZjD9nTNfg4qbT+MlkvgSHCVW5pGCHe7+LmkvnGpdnV2cMZrth0agxI2Mtmh9W3JRgFvVe9OxnSyynvLW1TR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 20:00:00.2233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd22e3f-bc11-4765-4eb6-08df39e50aed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852

On Tue, Nov 03, 2026 at 10:33:46AM -0800, Nicolin Chen wrote:
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 3d3e95cb9f7dc..92e81460c2d8f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4416,7 +4416,7 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
>  
>  	ret = i->reset(dev, probe);
>  	if (!probe)
> -		pci_dev_reset_iommu_done(dev);
> +		pci_dev_reset_iommu_done(dev, ret);

Sashiko pointed out a finding against the flr in quirks:
"Can a nested FLR failure inside a device-specific reset quirk be lost,
 allowing the device to be unblocked even when the underlying FLR failed?"

Justification: this is deliberately ignored, per Jason's suggestion:
https://lore.kernel.org/all/178786269177.3808739.6763094519382046767.b4-review@b4/

Nicolin
