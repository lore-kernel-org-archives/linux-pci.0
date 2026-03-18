Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B74344DBE;
	Wed, 18 Mar 2026 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865821; cv=fail; b=XvyPmNGf7XN/ZI0Qa/VpIThWa1DS5yeqjuiS9o55fxOvBFaawhz5KttnRTHQKcM/SmU2sXIRj8KmkZEdBFPQMddf8L7vGWfRpsn/+7KuSowgGNQ/y6ODoTRxVEPHN8z+fwuDTNwKy9X4QKqSQjpluAe+8M0q+ap4c+TRsY6INyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865821; c=relaxed/simple;
	bh=0OYZQqcTcCem5fFY0JQwnAhseHX6nAJEalDQTOSEOaQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrWzeDuG6kncJAq7LPh1Onh7Ay9rT+Xu6aKBPJjI/m4maHaE6BAuXhHghogQRsR/uwzgGvgb/FFu9znIPq6rrOqqpr0QTr8EeEN2FA0NU1gbEYir4WVbnspnzB0xabbpfKCT/6pBT6dIlAXLGwd+p16RCYDybSWcdoOk4TrkWaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tQXdY19a; arc=fail smtp.client-ip=52.101.53.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tQXdY19a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqrVwwI8gc48TcCHKt+iROJu0AtHHKLj7XrfeSZCi/II7tJ/eUikJjcSu26T53UUNTWFTwHG8izVDxvHdJnKP8+aCm2Z/Nkf6keoT1AixU4jNJLZKi5LHZeRmcBzVYLDCgyKY7nATRONVQocE+pMkpfLSI1ukAeveWHHWnrZSthKuhxw5eMsQqUbq+HSagnh17tUlkGRPzAvx7n7OwAupJuLem4tX9OaWTEkc+fupRheAJqelyxFFOnKURtEshjTrCqxx21iNJOeFvJ0+0FIqlMpVLeK6MYCkTf5wJupp3Q85a62tOaq+KLBQA9Bc6yoauOCUuod+VD6gnDGWlyeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3fDHkI2qPB1DUqkyaQvkR3G/pgMN8f5h5Oy7NmCvmo=;
 b=XJSJqtLKvtNwnd95rizYXO6zz+mRbuDgpr6b6Q68BofQif5f74506bdLN/HBrjopaQwpPRE4vdZkP72s72TW5DWNEOaSdJ8vm1TlOguR6HQb+oFO3P9Q1qaJi5aoGmgwh7akiMppYouN3t13YJ21oCg1nHyCQ5FVMyf6w8qmbpdBFncFnTheOi7xSSNCPHKJX4WmJCQakknv8GAbVuE+JzdxzS/MGTT+vSAXj+gszcK/e/eJW6TLo09wMNhCfosJ8QTmw0FrAhO8Xin1NIBfFP+Ot7NXgUif6qqzWbyiMhhMgPPQTiunzODUyT79lvmoXApr6+r1MGabuA98gJTjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3fDHkI2qPB1DUqkyaQvkR3G/pgMN8f5h5Oy7NmCvmo=;
 b=tQXdY19anuyZvQAUmKp8uLMEgAtYg5ucbRweYU6VIwSf7gzmSxbqDMRrD/CBViABktTPyke0437NPNrOya9yc9U0lQhq4GDC9oRGSn2D9iAO5MVB65LBoPkFwKeY5U+RFhif6sJbtyCDA6lcg1nr6a4c9vqpxRNk4iBMKpKeDTPiVaWKRC7diYbVCWIkHuNv3a0UrRHTk9FeJtJVjmXVTVf8C5Lzzi83biEAK0pyq9NtvHAvS9tLMZB2J5UCmR2mGxEpAlxz6wU4IX7btkU+AJ0Aolieqjb3vHfddxpJQXYnawPt7zlZ68hqZ4tfMjwb14B01l7cPOwsfJK2uKwCtQ==
Received: from SJ0PR03CA0367.namprd03.prod.outlook.com (2603:10b6:a03:3a1::12)
 by IA0PPF12042BF6F.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 18 Mar
 2026 20:30:01 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::90) by SJ0PR03CA0367.outlook.office365.com
 (2603:10b6:a03:3a1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 20:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 20:30:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 13:29:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 18 Mar 2026 13:29:40 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 13:29:39 -0700
Date: Wed, 18 Mar 2026 13:29:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: Re: [PATCH v2 3/7] iommu: Add iommu_report_device_broken() to
 quarantine a broken device
Message-ID: <absLMm//pcete6+D@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <c5390aeaeccfa86a1c79f26d2c0ff5df380940a4.1773774441.git.nicolinc@nvidia.com>
 <b4085354-93e4-4484-8744-d8c7e7718c57@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b4085354-93e4-4484-8744-d8c7e7718c57@linux.alibaba.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|IA0PPF12042BF6F:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cd655d-99d7-4cab-0851-08de852d2105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PFVBmLSnmCrxagtIRbMsOTkHF6Z+caTN/3idJfVuM0g5bKHAFnDRa4w8xKqC/7Oa5HnV9mEE1e/7/HT3ww1KkHaevm1d5KzdT7pp5iH8YHGHCWENbpHP5nhBJtOj4I1Y5e/b+EzWqyqwR6uyuMWNFpiSR8UsqLxQOBRYhr1PZHqp1NpmBoPE8jnEwMIdoXK/WWBRJHn9HedkGKg/lEL6s8ZGF9sFheXe+1ad6pqwUF1T5QutOOliXCOysKoq/uKwO9Ogg3Q2YU5xCqYnny4teXa4LbOBLyXw59B2yh2N0jJLThS2uMeFrDFRCkwMwoA3cIfWXigJrgo6okjkIEA/1o0vHRvl7ctMxmBUraMkZhNVfoKalDvLnTYrFSaYLWw+GPXJ1XE/usPGBNsAQfEVo6AOU43EXALx1rkHm14A9uixlHgyk5zBCQ5t2nQfOS2AV+C0k6sprFJimuCBhzg/riqT1yFijaOK5gsb0Kwql65c3hZLPaIzsnAT08yM/MIaFORGNtlD2RLgmP4vKfSg8ZNzW/oswXgyx1Lfe6ilIgrx85zoai/z80KJL8V/c/8nA32C2IPr6Wkes3BR4Q6CCBvsO0XsxlITUuK3Gh7gzRcxeUl2swPK+TW1eQ+IAPw/QYfaSXRS2XeWqd4dR7V4ux/Y+4udjIFEto2H6R0oXZqV194YdogBUSqgE2ERSooeYPmzETqZU7XZAUnVnOc6g4+0suWgo5GpKA+KqZcl5jh1AQQQVnFiaH50ZLgMG4K8hEbmFfhDtxVPVXr/1fEfxg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PSn6biYdu2wxWtm3knfzc/cJs3VGHCrnI+2JcNv5cqkAD4zWqpt/XSVJ8d5L+TkYeP4mHgraEGFy9YyJ958fL6/5K5RmlOeHXWEJtFGdcPV07h55HGilzAtLmEpwlnL60bsEYLm1xLm5gI5oxqKRqY/utVyVlntXlwhizkb9fGxoSao1Mia1W8OjBBI5WxAv2gBrE8hnra0Rq3jgnbfE8c5mG2hNdJHDkUBbtTEH3O6C/zB2/i1xEuLOMNnrUpCj0qD4eLCnBmnrFD21D1q6WlDazW12xksdhGqWzXPnqWPSuaBQvM2Do3FAUPWEx3ELT8QMbO7NDrKs2EQDP9+pBU6fwd4S8NCnQ4oGd0pnLxX7cHt5tkRTSFMOYeaNLlU6mJ+rY8JCd1xXutOTw0BPtnoiX2n5MRnm3904MjGraVPEpritfjm36UzPn2DKjaLU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 20:30:00.6038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cd655d-99d7-4cab-0851-08de852d2105
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F

On Wed, Mar 18, 2026 at 07:45:19PM +0800, Shuai Xue wrote:
> On 3/18/26 3:15 AM, Nicolin Chen wrote:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 9ba12b2164724..9b5f94e566ff9 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -891,6 +891,8 @@ static inline struct iommu_device *__iommu_get_iommu_dev(struct device *dev)
> >   #define iommu_get_iommu_dev(dev, type, member) \
> >   	container_of(__iommu_get_iommu_dev(dev), type, member)
> > +void iommu_report_device_broken(struct device *dev);
> > +
> 
> This declaration is inside the #ifdef CONFIG_IOMMU_API section, but
> there's no corresponding stub in the #else block. While current
> callers (arm-smmu-v3) always have CONFIG_IOMMU_API, for API
> completeness, please add a stub.

Yes. That's a miss.

Thanks
Nicolin
