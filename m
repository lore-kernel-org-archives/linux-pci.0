Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3F72634;
	Thu, 19 Mar 2026 02:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773888176; cv=fail; b=RUlMWqmN4R+oZwz95ZsaK6mLrxAtkz9aJdovSzfULwXuvIF8imbdZGUXqMg26CTSGUYZzQvjpBFD/P8QDisWJQ3V83n4yTv8veruTy+wWt3tyB6BI+rKDG6wK4B2TAnoKwCa9PwNP0OjHEMbX2mJav/9CsrKyHsHkcPeMympr0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773888176; c=relaxed/simple;
	bh=iGcD57jVir9Gz4pAs9bq7Cpba47dOdcGbp+F4QBIL2I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM7rYAd8gOeJjWryLDfEnvNqXWu0zrZs5aL5cxXLRkKEP+MsXnky+GghliONmA2hcfxWapoZcq51MjlRqyUNk6Ad08Xd1Qe9D4q6N4rEolbBhiPvgdW45nMuAHa28hPafQ1YMkAJbZcEmPBxJqNTegAvU21QEXXI7JRgRMbAsgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WAZLJYjk; arc=fail smtp.client-ip=52.101.52.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WAZLJYjk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwNDHWzxAZYjpXXiY3e/xvGT2KKaNBSgI1waz7Yj8Ey8H4yuap0aYQJdcANtztXZic38PbOcC0Y9Y9SPlDXZ1IbB6qJCQoR/5dowBuYXuFlYV6bUTG/44+jGw31xgenblNoubiv0ZnApUBZgCK1VajBndLpxl7BwtCgfISMxCSm1scEAaf350agPU8mPN9NKvkZEdd29vCv1OdFDTQWN1YwKb2Xo2+DUdXszHbCvbPezS11YjSfPBdLfLvlrBW6Et39Xy++SqpUXZZ0AsZ8BRkvd3G2Y7/yf/Aj/hCKvxzAXLNL/Ybfj+76V/zeJE4GpPsCRMXmEEy/wRwYaHp4gJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZLV2TEzH/17EOwkZurU4wYXBVhQBPDq9h1jWNvrg8M=;
 b=Lz93Iy8U/N0a9bCzQSXPlzeCNiJvZClmWm++bc+j/kkmfCzpi/BZ6E3pshViucLLDzS2hMy62mYCOs+1OmyTjOfG6CyB8sJGfjoVEi6HALd4e3Yh7k95vD11qdG4ES+erYlK1rMmA3wJktxXfsaU9zHDKHDr6l/hYe1UpZ1qIJsZUBykvJWHh70zLspEReusrR5Tfw1w+exDECYiCJmijGffKfYAtQcwhjZk38Lxz34umsLuaZKrGB8jx4Fwr8MU74AYkyaNznGher562sb+njcDTNIFdVNEDr/66AAHp/dcc6bug3P07/u0Q85ik7nbWkoPVJqyy/NVa4GF5EnvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZLV2TEzH/17EOwkZurU4wYXBVhQBPDq9h1jWNvrg8M=;
 b=WAZLJYjkJQ1gnGAc3vo2oOYRWQPpTJ9DWPkymZtEWEH5A97ImQPD9svoG4szuo0ZJyBVvIxM5wZbo6zVOrRPwwrcQ2y+5R2pvcylWWjvh8juF407uv83iizLUo4sYwsC3TVY/SsTOXRaOJ7x7l686ewEV0emcK1TqZx7qaRPvRqQtjeFbiEZ8/9aBfnZ4lktET8CooHsoKTAc6od/B98YK68AfZJ2YW8sUuexJRB9399UtxHvIG7DVUJDT46QEzlhb/ZioNkuRxtPWl9uf9lJXrM3Qi6kFPbyaFXVvKWKjL67dSHyMQha2w9Wf4AUrR6o9zRfiIbmmN90MqFa0KQgQ==
Received: from SJ0PR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:334::13)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 02:42:50 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::a3) by SJ0PR05CA0098.outlook.office365.com
 (2603:10b6:a03:334::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 02:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 02:42:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 19:42:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 18 Mar 2026 19:42:46 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 19:42:46 -0700
Date: Wed, 18 Mar 2026 19:42:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "joerg.roedel@amd.com"
	<joerg.roedel@amd.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc] PCI: Fix nested pci_dev_reset_iommu_prepare/done()
Message-ID: <abtipPYeAEpg+vbI@Asurada-Nvidia>
References: <20260318220028.1146905-1-nicolinc@nvidia.com>
 <BN9PR11MB527657D79BF5B16943BCEC258C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527657D79BF5B16943BCEC258C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b510eb-e71f-4bc3-4af8-08de8561367c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|83080400003|56012099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	QjugP2WEvmycHbD5t0lvYgNS3joFNCiaK3D6/opAKhFIUG1gaOVa78Lyq28nxuefOiDcsiWXMC0q4ET23ZVzuMriSTxDaaIhPojI3RU9pq9nT40i14/deDooJn8Bpq/PlhfX0Cq4uEAVvDdCaM3YMHDg+M6lS/WgfNP/jS0flc6NhN1InWYBuONiZ+k4QtQbTrG7C1PEwiyzFMphwxJL0LqS8Z6vGq50bsQXJiSb6ph2NVY9B6MCA0eP8Dh/xu+LcdSptUjG8vtJ/+0D+7b3nkIWOI0mM1LGyxA54SoC73bDtgJsZlk2DYDr4bGLH2N+lBX+bwLKH7HKMPIPGMqSUvGGkFX2yYteCtCk8RuZi5hjb1gOXoHG641g2yYq8A0iGfMRX710tUZe0Bfjv8DIQsuIf4IMpo2DAgyKctRmNmGtcetNu+Da2FwwtTj8kZWRXhAJER/kHNeWbKHUA1t7pfV7qyy4HmScG+/jisTuwJ9Bmu7W+QfgW7sd4aFRC3b6c+ZqJNkeHULBmQ9EuijHInK7KDcdXdKk/qouzxE4f3BEYZYYOW8mw0SABlV9LsSgdWYNcB5p63cvlqR3adYnRnFVugd2LvaezMiEyMtyQLO5NFUFvVFDzwHfISREFDw+TWh+z8dCW55XLq+gxtu1VG9bl/sXHCdEbqPakeZP0stMjASc+ZNz1aOP8uXO8WW0sPENZlfrgkSoqSWwhNH5JOT4s0NIUpDZT8XjR+u/oj5t/NcFb63YlR4BaHASp6qoIGpJj7eKpcFppmHFKTKUaibcdO7lYEo5isUQYKdoJBlwEvh48Q46wk8FVNr8D7OCF8vLrx49NXSPdDghox2N9g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(83080400003)(56012099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3Fkynx3ygbc+J3PpHDaPH8xAejUKuVePpTRyI01sKWO1gAr/M8Axp4uYHNhV0ZJ6HbnYVgZhNlmKzIYbb12ur3G3R5ExRB0b4+BaSYgb+RmS7LX2ADELxRceV6Dld2F9VZR24+PvVL7S95NiCJjmwK3gAtBxPidA/dOeAJrBKs6zXAsjp+GrJeyS1RYLiTfynUe5yKfkzFVES65HJOSm2SZdHXMRGOAbxhjJ4uDMXn9glDjz9po1YU5pE2iZ9QoUOPn/qTIVve1kILpJL+lM6MIJGRQeIbQTD06hxXvdLpflUialZgu+bH2jzEKfDayCPHWnr0lfPUOk4qPHWNjGtel0v+4+7pTXATm+Pqoi5UiNOY4SUuvBANpZFF2mT6V0/xWRPfDyWrc8JlUUf95N1oLBLLCDVRmCIcfinVgUa3wJugfZ3yLzPlYU/fOPu+MR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:42:50.5425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b510eb-e71f-4bc3-4af8-08de8561367c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098

On Thu, Mar 19, 2026 at 02:22:39AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, March 19, 2026 6:00 AM
> > 
> > Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
> > internally while both are calling pci_dev_reset_iommu_prepare/done().
> > 
> > This results in a nested pci_dev_reset_iommu_prepare/done() call:
> >     cxl_reset_bus_function():
> >         pci_dev_reset_iommu_prepare(); // outer
> >         pci_reset_bus_function():
> >             pci_dev_reset_iommu_prepare(); // inner (re-entry)
> >             ...
> >             pci_dev_reset_iommu_done(); // inner
> >         pci_dev_reset_iommu_done(); // outer
> > 
> > However, pci_dev_reset_iommu_prepare() doesn't allow a re-entry for now.
> > 
> > Digging further, I found that most functions in pci_dev_specific_reset()
> > except reset_ivb_igd() are calling pcie_flr() that has nested those two
> > functions as well.
> > 
> > Drop the outer callbacks in:
> >  - cxl_reset_bus_function()
> >  - pci_dev_specific_reset()
> > 
> > Replace with adding the callbacks in:
> >  + reset_ivb_igd()
> > 
> 
> I wonder whether it's cleaner to just make pci_dev_reset_iommu_prepare()
> reentrant here.
> 
> what this patch does requires additional attention on specific reset functions.
> 
> e.g. reset_hinic_vf_dev() has a special logic waiting for firmware reset
> done after calling pcie_flr(). With this patch the _done() notification will
> be triggered earlier than expectation.

!

> the original way is more maintainable with prepare/done equipped in
> the highest level reset helpers in pci_reset_fn_methods[].

Yes. I agree. I will add a reset_cnt and allow re-entry.

> btw the AI review tool gave a comment:
> 
> https://sashiko.dev/#/patchset/20260318220028.1146905-1-nicolinc%40nvidia.com

My browsers on both Linux and Windows blocked this site :-/

> it won't hold if my proposal is agreed. But it still applies to your quarantine
> series which relies on accurate report of success reset.

Would you mind posting it here, if it's not too long?

Thanks
Nicolin
