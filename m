Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B826ED3D;
	Tue, 24 Feb 2026 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958618; cv=fail; b=LErrndhI2yz0VOPROKNOm+LuCWytqaDOOP9I1Qb/zeU+IXDph90Dk5t4cNuXz2LvmMKIWt87xjKL+W7Xsc74Y/3lke0SqJQ7WElAtTPVR/XPA4SU1mHWHtJHKjXz7vGLWCH529Zrtttq6CrBhYdVul/T0SgpZE2TYPoDPJqSh4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958618; c=relaxed/simple;
	bh=sI13xaSwYwti/ggjw7PYpPoE5T5iu2u8Kf8eZAE7joE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYyEqxtIQX/8Plu35laG+tUrF7q3cK2MfGzH4uDkNYMurm5M4rKNIx+ettnOQ+bFiIM4vvEbL0sFsxwFOxu1+Jee/ZGQ61017gPpcVykAi8jDMLfhWdc9rXW31jqG7H9CfJy/Ol8nMiaWPVyxiUs+i8pcw2izlA+IYlT2fdJD+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X9zsGXE1; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X9zsGXE1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1afiRi1NBhKwavY0Vp0Ds/N7zUjbgrHTG84ZHyk77LBTUmv7ipKmAXJRuy5Pq8v7B7CKN8tRjYMOmEjFat5Rdy3a+jI8mHLy/Vat952pF61leXZ4y3WqMOGzRHFPLMA1YQW0KXt6iXnPmORVmNygTy1wbWU0kjfJllCe3UakBp1RP0+2gCjfmNuBREKClQAx4rIPo88Xz+kNxaBZuAsLEcmga6yoRnkwNQMKqtzjf5yJCE5a+qJM5gqI5WjWvLb53hARSb1ttylfiJ07I7pE4/WtvMMz+RiIznP8AXeKS3YYy5jnfRDw3OBwTrUtDPSP//RK8ODkjP6NnuXo/T+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ejxtmjd+leFDCLPlLnzsZoC0ONJIMPcfOeHYdiemfk=;
 b=U87zCFJ8P5KFXEaaqKqz3KqD9wSg4A12aOGrSOnPAmJWenNcXGBShCLIR5xoHPwTMsToOHd2E7BxWhK+eJC1iBT96h8nwK3zRwNlOZLxcEZzmnSIVRlFjrfIqp5rVrWHxSTxj0O94OEj8ogh1J1EKFISRlFvl635UluEaIZZV3gTpJvRu0lVSpMow6rt9+rHbqWdCwLirXx60U3fE5KnIuJrvx/4MISziTO0iETYIL7Kar29UETBWIvLVBef9xATlEBvyDE3Xk3PZIU0aLtzLWcg5C7UvSTNM5VcGfNDdFik/K34vlbTEGK+ZuMz4RQEKR1ChF94P1Ua+5lOgOlhRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ejxtmjd+leFDCLPlLnzsZoC0ONJIMPcfOeHYdiemfk=;
 b=X9zsGXE10ZF4ujlDZwqwen+sYFot79KMUrylQo4vhyC6nooOkC6x/0Q/MgEIZ6TT6zTSYIj1s1S5zz7N5zkgUcgHZa484Lxdg+qnrawIRDQ2tp0L/C8YInV7UZZJu+FhfgpnCRkzzFJYvfVRWRMvKwSOHupB7sBhENA6xKZqXrUj37FLnd1JCN5AybNagSuwmAxpSSzDc+0G3Cc4dKwKWteKfGbgsnFdl2zF0wMeegof9yr2mIIUytBvAr3+ZtPgTV/gmbhH6pPRDgkko2dmCm5fXqtES4hacfpZZ+c3qLUvXHD2wCI9f/SVY0FKdC8DIHX97LuaArC575dWFGf+eQ==
Received: from BLAPR05CA0039.namprd05.prod.outlook.com (2603:10b6:208:335::20)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 18:43:29 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::55) by BLAPR05CA0039.outlook.office365.com
 (2603:10b6:208:335::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 18:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 18:43:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 10:43:06 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 10:43:06 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 10:43:03 -0800
Date: Tue, 24 Feb 2026 10:43:00 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <aZ3xNJZV6YZv6QFf@nvidia.com>
References: <cover.1771886695.git.nicolinc@nvidia.com>
 <ad4efe2f85958ee1ab0673a1ceb0db5141852732.1771886695.git.nicolinc@nvidia.com>
 <20260224115534.00000ac7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260224115534.00000ac7@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: f52aedb8-bd0a-44a0-3d51-08de73d49a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3H0OXsbIJ9hQhKlyxwg0Bz9OWOQms73AtTUVNwgkmcYmoIor5Zciie1p9dz/?=
 =?us-ascii?Q?8yN6iT1uXC9SK1UviGtJFHpJgprhWUSqUGPBxq1SgyAYuXKyw18HdkBKZ0jQ?=
 =?us-ascii?Q?VkKsCigTYhp0KEbqgKEKDWgOtMU/e+oBstqgHujpYXdfZIeMq5KRJvN3fy5d?=
 =?us-ascii?Q?YR1Q9ZLFyp8iM30RR/7Jf93QIeust7YcOJ2azAbTY4NwSf0ARSvEqq04MVGO?=
 =?us-ascii?Q?5iqj49rAbRfX+k9P6mt9COx0fEFVqZAWSH65mOs3S60JkSK4KC+Ti44wCv0w?=
 =?us-ascii?Q?XN+gMIfb2CayTfFtkKPcWUrXyLzfB6uZoO93KT9uAenpOgIKgZf11UZeUSSr?=
 =?us-ascii?Q?5G2G1UZKG76AFrvZIe3zopOguDUtcn14ze9WS8gPA4tg155QaywPnIxPcubM?=
 =?us-ascii?Q?ihx1cn+1JqZ3A8W286cJabOd2S9BavaUGZTPWWcBz3yoaUu+njqa5MPEijvP?=
 =?us-ascii?Q?iBtlFHZSO1C5wSjVBZv9JDsf9E/xS3aPZZhehxwUtF7/yu8cYc4I5zvwD+Qx?=
 =?us-ascii?Q?s7pDUq/QecZb+QukzaSN1CLzNUh9pPxdWufu6m/fP7qbtMrE3uiESp98iAe5?=
 =?us-ascii?Q?LEs83gMc0mjpv7ASARnpTyEZaIkifS6E4C8RklfIJD5Lcewd76LE4MuZoQ5g?=
 =?us-ascii?Q?WLvw5exzc6+G3Jp8FYSKu7NkUh7Oc814innkuE6FJ2+R/5rpkesLziYHb4cK?=
 =?us-ascii?Q?/zT++hJG4AnHNU3RuXO1XCtj5gTtrgAEFVYXO28WKSmdejowP9EqKcoxnMkF?=
 =?us-ascii?Q?PKgzLod2j+utegWkzJeAMebcsgPbQ/9vlxaYhwBAHW8R6Mwuj9aUAkmiAmQj?=
 =?us-ascii?Q?Ym6YeLvb9fPyHjn2X+gQDnP2cQmPNpmBD2ZLfuz6w+5ujuZfoDw5VX8ByDli?=
 =?us-ascii?Q?9wsW38UiVGOfaos2AquJ3YTMeC2Hgu3rLalEAELv3dxgOQTTxSIiPO0BIYqf?=
 =?us-ascii?Q?BsdMwU4naluKdyT55KrUkH/gUB2h3V4DnSbDscN6HS0zo17e62J+lc9xB/JX?=
 =?us-ascii?Q?KRDpgujrTS71Je9UtP69YQeukk4IiYQNP78lCjniiRtXs5aKqZdkclBtvXI5?=
 =?us-ascii?Q?fiRtmD9pmW7nZiFGneFL3IGOcL2WDMi744KpY39eoyYNOj/9H/TptjAYNg2K?=
 =?us-ascii?Q?r8ixczbeT8cU46Nm6Wp2US0LL9nyT7iNtElC7Vf6+xDAhesVzVN8fHcMjtOA?=
 =?us-ascii?Q?IPx2rMiS7kxiUoyb31LNfOfO2E/JcZUSZBiIntl5OujDypJjgObaq9zpquE0?=
 =?us-ascii?Q?kBVtk1aeg5bhxaERIE8KA8Bl6l3R8YKBh1UtD2L3g+7CZsMnM0Ij+O7tLc3Q?=
 =?us-ascii?Q?/LKbuSnL6z+GtQ5ZcFnXVRNjEMBqONcg57H/n++tyS7wrC6gs+wqNbMAvNv1?=
 =?us-ascii?Q?SOwFWg3SnLj/HON4X8rOXZ7CLwXgeg8XmHF4wlwQMALxtq2Dv3nybLrUUPAL?=
 =?us-ascii?Q?K7fYYQTtEowncmBydu/1Fjk8qWIySZQO+mTYwktulel6kE0UMD9tmGEHINV9?=
 =?us-ascii?Q?yKy/sBmBfeSrckasqDjfaz0DI4pw87u3C6OVvvWP0ZDqOBtivbus4j+IGVoC?=
 =?us-ascii?Q?yhNzz+bmIT0jxC/BamCaS0VF7+IKH9GV/NVcxRh8hoOlLMaa//fjnQBbXa7D?=
 =?us-ascii?Q?QojfWgZemYC6REhsXE/jUbXBr6ANvGnvVrvPGMPe7uEsX5KaMtFEJHjWpxQa?=
 =?us-ascii?Q?J/HJeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gqOMf7vIn11I+gUa24sgOtdjAvpz09FzUJd20nje4Y0UhrHriW+xt8pFzL8jwDLSPZ04RbL30xirvbx00TMegBH29l4RPWjPdrGQ+fQR9o0peStkgKtOFgm9V6SbpJJyxaIo8Bz02lyOvXNp7QH9RTIGVLOkeigDGdwB2yNnb/42JwTQoI3Z7l8wNEUK954y5jlUOtrP1GEautQlAnwnxWdS1xkm44SFwJf1XPHOrvPc+dMtkDciJEpiAed6WDrSXevi5kWxgZzPwm0ZKU3QlVGrjf61xvEQ2BVZwBr3HY57fU8m7DdJKqpVQqd+YALboi22M5/hw72KFIgKxAw7K98pOCz1fGTfTPZclMZ7Ygp65YgLLXj3geGLi0P28ztXjfpXTFmnbR+h3Co+0FFpE/FnXgNsfiw/EW3/HeB4m1X+6d7edKLo3Az7tTEAKeQe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 18:43:28.9742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f52aedb8-bd0a-44a0-3d51-08de73d49a44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069

On Tue, Feb 24, 2026 at 11:55:34AM +0000, Jonathan Cameron wrote:
> On Mon, 23 Feb 2026 14:52:20 -0800
> Nicolin Chen <nicolinc@nvidia.com> wrote:
> > +/*
> > + * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
> > + * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
> > + * by means of an ATS request on CXL.io.
> > + *
> > + * In other world, CXL.cache devices cannot access physical memory without ATS.
> 
> Maybe tweak that to "host physical memory"
> 
> There are too many physical memories in CXL land...
> 
> > + */
> > +static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
> > +{
> > +	int offset;
> > +	u16 cap;
> > +
> > +	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > +					   PCI_DVSEC_CXL_DEVICE);
> > +	if (!offset)
> > +		return false;
> > +
> > +	pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap);
> > +	if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE)
> > +		return true;
> 
> Could just do
> 
> 	return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
> 
> Unless the thinking is there may be other stuff that comes here.

I will fix both. Thanks for the review!

Nicolin
