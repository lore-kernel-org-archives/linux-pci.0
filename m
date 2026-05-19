Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5382332EAC;
	Tue, 19 May 2026 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191237; cv=fail; b=VBusgqOXrH227IVB9hA7iCkgTxeDl/2jgT+QfWxWxHpIbQS5Tvb+RjJ9T7051YkbsWSuRXoCvVn7FHdga4729pMv+ex2+PcMCdEz/u/26YC1PkZQjjI3TjsKWGziLWL1sD7ZkkfPh3SPIgSaJtNnkdYBcFibDkxaFUB//xYOAiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191237; c=relaxed/simple;
	bh=Rr/nCJmG7cPQf/5ye5ulR1xN5DREDULA3lQONEUgJ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iHRXSxxs8xiEfuM4XDcCBVvLxWCEZnX2y3WwbgxXeJwhyVAbk2wRPM9+UruTpXBl/SJyZytJ9TVuo+dKLiBiS5TdK0bI5RVIwrjF6wf0rx0oS3bSTFmesk8swCzwS2FzEuH3ndCF0LPP31aB9UM5iGxgvt8OwsEh6Z+J2unbsxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hs8YesVj; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hs8YesVj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVxo43Wh+OCpEnQNw/9K4Furvv53rhN2ZFtjDYxnVc1ijZH9oupY3oK2n9ILFrgzF8dShKEPraotuptqqG7zfVyibddBbJKmPg/GvqB6mTK65ktJbohukEsDMbntpt2eMCIpxFVSLfZMfpM6XXa2NfhlajJTP0TaZcGC05BxEUtBnuyI1nmqq/8v3MRfdlFaIBkmeV2RFlAnIE+igRK46A0TlB/km7zL6DcpxpXnNxTYt7K2OwLquQY2RnKLEDxuDg4of+KHuF6GaF8zq0XILnucFYA7lqKMM95bBftSjjB75Sp9daHRUJat0hJhGSA380esWqhBwa1AUEgTNVjBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUfaaZJQU0OAuavpsKG/PH4aZOGRFz/KRjOmEESCYDA=;
 b=AHyB8HyRa1bIVsKNXp4N+YtzRvTHoUmf0Oum37JsAkIMj9p6h62XkWaiUc7lci1dHdaH3ByasdZ+VZENE3ijDcEa1uK9XVPXUae6RJqUsMqOtE3C2zgUoihyy03Sej0Nm785T2HctKPy/qoDiTiJtJzz3DMaxRD4SPwl9ZC0+3zdZVcofz0RH/VuoJBilsOeRD7UqA831OpOGEPUXhsgrxOo16cRrSEB2xXgnfLX43jDHcdaRZj7EtPNmyVCOZ/25+G/WXxoGQ82wDAmfboWMYVl3Y0WemjiACVrySQCWqf7TMyEGXwiXbZj/AiLdGkvtiB1njULOk9sv8MnfCJxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUfaaZJQU0OAuavpsKG/PH4aZOGRFz/KRjOmEESCYDA=;
 b=hs8YesVjpGqxwynki71NJrTMwqjdyageSmlIC/HD03TXxCINxYDxfYl8TBYsb9aKgRidrRicIGBsp2hrvN55jei8wPD74Uzul60DhAUmxeICm5hU+xWCUjMB1FKbEYQAMzOXNtVGyHr/ak4JooVEkEYGK26ik/bLgEEN7V2yjYZ1S/K4tjBTP+G6LsQG3fFBo9ftiAqIHm1m9xzkBzVWf1AYutQCy6GDiBfiJORclwPHCy6ut9mHVbIs23gLDyysU34mtMIRQ1UCd1DrKZHyLzsSeA9jQ14jLc8xLUOoaQ1kwfA+9jPjsqCZfHKDzkOoQrjhoIcwpkkgaHwe3ZhsLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 11:47:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 11:47:11 +0000
Date: Tue, 19 May 2026 08:47:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 07/24] iommu: Defer __iommu_group_free_device() to be
 outside group->mutex
Message-ID: <20260519114709.GP787748@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <bae489d600425a014bfed1c2290ee7c0c657f198.1779161849.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bae489d600425a014bfed1c2290ee7c0c657f198.1779161849.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 46616802-ac51-4724-6c14-08deb59c5cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	5aR1GcB1/ClWzTS2sNhvOgF8FYsPFNfkkFJUrLqG5V6m0VeJh7Wgr15HLJ5KfmnGB43TkIpKm+sqf5lV/6F7yVd2Td9q+gxgUf7jtBYnOpEJYOB4yELO90uxgV0+sJUE9sflT4WFuxpHeJ2aVcQz8I80X25xhjrFg8TfbzQNCLrQI7HFVmF0cnExd7l6Or0ajwDgd0iiB36ez5H/PI6n1JZGuxjKWKH5XYCb8p+/HtnMo99xsg1yJTC9364FPk6X+ElUrrWajS3PNYZ/B4wxKFkVsSR0Bj/qw1w6d1sVtRD0P6NBmOV1syVz/BThkU6ZWc/ZDDmMZ+JQPY2QyJhX+nWGDuf5y/s7Al8aTP4QzYicdF3P1RycK+SBEvtSjwmyxmuTAXLAPTKKzI+Oj2O+Q9ejg82N0EYGT1W6OT0qxzhhwAfx5CIwAuaZMKT37N4e1bhbH2/WBdO75ylErOxqrHjkAYtEkdubAeTZQdN/2xb8epQcjj+orPritAshl2Cfow0Pu8LsOkFtxawxeh45alozg/y9eWVw33JlZ0ApwlUXaieTRWtwy79efFPJv080fuY8YOXM3Bv3woJCqGC2VuGoNfQH7iJyRruO8GfRlDGgkNBKJ5bPtpzsH1YWt0YSLD8m5cUiPMGtF2ELxm0zHP3+AmhIr9qBgVLG0uwYPiV/GipajgcciSVICGeHD1Pr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QpdxjBXxC4lU03xEyMpQkdbMB5XjTjidQzM4olJlUljjdef3ZVc4r5/YplDg?=
 =?us-ascii?Q?3dEz3A/XsOgieiIpa0TJyTWm83Yqdpy8N3FszFK5AJ6I1wp8iVwCeprD4USL?=
 =?us-ascii?Q?4mMNpFLJLumgd7MSMwU7CGYzLpyJaOR6E8g5D1DYe68zDO0ENCvKY3qXDDcs?=
 =?us-ascii?Q?jKAWwFqtuq6WOl8iOvCp8sm7s/gdVywXjK7fAxQqYfUa9mccfCw7KLW6xXeU?=
 =?us-ascii?Q?tjLB+iNyhjSwiDAv17eIt4pANAQ+vqQ5OMoOhyGSxcmUtsjRkQCRRfv9/ns0?=
 =?us-ascii?Q?6I8l8WDn2NOTLGMxIR1ds0hS+HScmuk8UTXP0aWwVPEkN3u3P+8Brd4dsHLN?=
 =?us-ascii?Q?DQxc6xvegXWISFAZU+gdA8OeGuvosz+Ig/5fV6xE2YwtO5rUdU96YErz3Pca?=
 =?us-ascii?Q?bNc+pLMJgTHZkwWj4txeYJn74oH8gOoHsir9gCJ0cULlIBeqbNhNCxy9Rodo?=
 =?us-ascii?Q?Lij5LmMtTJ8hzWv0fsr4qIzCGcMoIIHrnmJ33pcFxfQBJjR3TOHJh3wguYjG?=
 =?us-ascii?Q?Ak8EsxuqfS/vB80UCqDcUg+tbYqC8sN2CYG4opJswHrJOB+0P1aYDnOwU4aM?=
 =?us-ascii?Q?/iiY3cxgboylcl5s1rahLsH3zjeZqtL/bxQO0o+P8yoRDmesjGntMQSzrgvT?=
 =?us-ascii?Q?QYboXujQiKnv5ypRwKyG88NTJF25yNE+Bq5GwjAuuJTbKmrNEavnB8Ze8Koe?=
 =?us-ascii?Q?saT+P2KmHQJ5ytOgvj/+zwbGZaJTKHjNv5vDDhwBhRm4OQDVQ5/5qAzt67vu?=
 =?us-ascii?Q?pWp+iQGcffiUOD0ng9zx/eHtKD1tYnhcrg1DGJhNHtWlivEVPL6KDUPbWa3T?=
 =?us-ascii?Q?96KyZRdmF0beuA/9tdHOxMsCxH9qwzARe1dMCkbdYZgA7o5nonwq5ZdHsPAg?=
 =?us-ascii?Q?+qi86OARXh1pTNRtDS0X0cLaNjSK6BUqVf2fXkNOW0kb0C/t7PUJyn7PtmBi?=
 =?us-ascii?Q?laboBcCf8L5EXl/bZ3AwGmYsXYp5k1x+u0WH8LKI4UHcK+j53+2lficanuJF?=
 =?us-ascii?Q?1DpzUyhLOst1H1ujPqfG9YtRileMIH+Z2kJzXjXeXHK13e86N0VN/fyJ9Utu?=
 =?us-ascii?Q?TOi1/aedMvMbi0yF3zt3anWJNRXBPMERSsCYMt1WijzI6YBplNJ+wK7XjWOy?=
 =?us-ascii?Q?b2HiSDpZOjML11fKmxz6uqyNZYrG17STvOZVwyzZXAJCSroaVWXHoFaYBJk/?=
 =?us-ascii?Q?5YosJv2qh0ott04WUCel13nseAp8JX9p458VojFkTfmdBCuA7Pgx3gHb6lMM?=
 =?us-ascii?Q?t072UdI+y03O4KhLuxhtf9oSS/dJfpBqAdJxdTaNWuLgwclD90NoM3aZc4M2?=
 =?us-ascii?Q?oyYmWQ7vL70YX1MSeOnEQg2YflvyPaSOGJPlqecSaSrfftBxA6dgd8ojAfNO?=
 =?us-ascii?Q?BZVO9esOkqptNy1JyIn6OFJWqACTbeju67OAl8wDCyqDbAo+1lqC4fRnbrjZ?=
 =?us-ascii?Q?ShQwUMoJwBOp9c1woq8ty9axw/tq+tupGNK/mjrXBHf9VVliZk0wsuiaSyNw?=
 =?us-ascii?Q?1ZRwJM4oiGxoboqqxkqdx7+uAlxrBwVqOEHh7PhNivjANe74sqUNvz8+FrDh?=
 =?us-ascii?Q?/U/z8qNg5y5CR8kABZgjFDmxV+C3mNJxGndVlXkD9QgMGuMD/rY5Bx4agb49?=
 =?us-ascii?Q?gdrpt9ltpSRNg7yzut8Y1ga97PHdv5z2aGJq6FrNqb1IqbytSRcLehOzMoZl?=
 =?us-ascii?Q?7TL0wiVEBv6oIlXl1NYKu+nyAOD+vVpBfrd2qA5WpcDdQ2P5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46616802-ac51-4724-6c14-08deb59c5cc8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:47:11.2171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hwv/CgRw/V7wNbvFTplNe/mpcgvcb82mVrtUiIWhwz83jTq8OFuNPhrJF+OVkVHL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673

On Mon, May 18, 2026 at 08:38:50PM -0700, Nicolin Chen wrote:
> __iommu_group_remove_device() holds group->mutex across the entire call to
> __iommu_group_free_device() that performs sysfs removals, tracing, and the
> final kfree(). But in fact, most of these operations don't really need the
> group->mutex.

Are you sure? sysfs requires unique names, and this mutex is providing
a guarentee that will happen. While it shouldn't be possible to race
remove and attach, it is easier to reason about if we don't have to
make this assumption.

> Subsequent changes will introduce sleepable operations to this function:
>  + synchronize_rcu() to defer the gdev->dev put past a grace period.

I'm not keen on that at all.

Jason
