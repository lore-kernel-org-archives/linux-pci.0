Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBCF3176E0;
	Fri, 12 Jun 2026 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271600; cv=fail; b=u65GX+Er0dE9gNMzo2OKOONjfVj0/NDENIR4ACJo2VHWjC2ImhVR3x+0EkU1XKUX7vchapqc4ZUczjKi+VAvZtw8f0310wBe+fKir6cqVBSybLnOZdAUsEfVpjkW5dz5eplwF0+LDjRigYjXbnaikA0nME3hBNWU1+10NNbfV5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271600; c=relaxed/simple;
	bh=pyKa7mIRPsgb8hvmL4W2+TgSX5sPWi8FpZWVuonhPlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dMDtwsagP4g2NOBKLWHWlvtgnx3FbihWv/MndQfWhtMijnZpBy+p0fMt8SMQNyW06fBEGIkCWUhyKg9Z+TVvxnGwX4zh/BoLt9qHju1Y9DGEI9vq5Tik/6dCg8BlHCBVbflg+8GD+Jnsc+h2276Sii3s73Ke2w1DcLq9j0JnKEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SBKerRLi; arc=fail smtp.client-ip=52.101.57.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SBKerRLi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/HBzG88k/oSBXIYjBOwn+w0TDG9RyFYZWdrB+6sU8R+nYv4r0Mujtg/kBfTLJKFjtWAH2AAYVK2pmBue/jzA4v9Wv9vAe7niFym4IbD8rQrsHHzZleGSQMHhzk6iIGopW2W/fbPR4512Euc8urZr/1wOQEhgDTxMBM9c82fLXs6LTqbqd/xRPsg5u2Ai9iwt01WQtl3B7hAr1jR3Wo8oejckAoCBgFhqc9mgk8cuUeeitgltTNZRMWfCaUDhJXkAgOuxCfKeVBRy8K5zy7z109R83lOwsvriS2NkDkL9aXQYW/g061RCMDKYHJQGGyxMDFB7QaJQD2FRUkUNaphQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=054vITkg3b68tpr+dzZKDEGGLvKoR4j70YNzzIQweV0=;
 b=txFKcwpKF6wsd+JlbhyZX2ibu/fSjXzecN7ZcQvKtc+pUrCvvKNh9bmS41eBgJBf7Y+rm7e2VmPeb3r5zb+gKmrY5bYWNzu/ta8yDCTjkoZC1Ahot17SMvfNHcdxjBWfkmc5aQ5Pr/sahQtmVgCwt98MhBIx2lIj/rkJjZxBKmeBcIMDXvU8LGOBSlCr1sd47UYoq8wTXghNed3srugTf6sxYVkgjLeBDaNjP8CV/Zm7H4TNY05a7UePzqv4fn0cwrf+sRwQWOCXRdmVCvkDvS523u4weTujU+vvRZQ9dd7cu74YfhXQBX0yzGzPAPjgZgeY0Lc51wpGDosrZNLt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=054vITkg3b68tpr+dzZKDEGGLvKoR4j70YNzzIQweV0=;
 b=SBKerRLi6dSuWRk1Z8AaAdjzoH3KKQMliWSqkgJ5gUwhe/w8cK+x47fwAggnF6s0tv8w2pMK4dTa6ox5VY4cEn/LdCj5novKs9QUtNVI/AT962auSiXJeGOeOQ1W3Kn6203uma7ytXl6rQF0x/Cy4JOlue5+FHi4jqc52YWLJM6g4RiNBKkswuXtTUF3WofpjcTb4Egg/UWkIrbEKw1nA3gkaMu5TlPX34dRjU3E1iEsAoJ7aviR1MSfKS6OugLv8dK/ApBF8DnC5JR/lDqBcDNHNnHNEKlEyvJd8QEg9YSdBO1cErDeYzn3knRFkRiB9IrvQkxkhTCkOA3CWjdYvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 13:39:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 13:39:54 +0000
Date: Fri, 12 Jun 2026 10:39:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v8 4/4] iommu/vt-d: Fail probe on ATS configuration
 failure
Message-ID: <20260612133952.GH1962447@nvidia.com>
References: <20260604182116.3179005-1-praan@google.com>
 <20260604182116.3179005-5-praan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604182116.3179005-5-praan@google.com>
X-ClientProxiedBy: BLAPR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:208:32a::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abbebd8-1cc5-4d71-6024-08dec88815e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|6133799003|11063799006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iw7wXB5B39L2cJPQGd6yJ+QBEbZE9za6154wNnHmZt1FOObHmQIWi6m7NDvLUYQBDdDXr8iO9vrl8EJLb1pBntrbYFTuGFGPf2O+A0Cn2NGWkxqQCf/9jqldZHIUQf/A/e+kWd2XHMxFdEk1TNjl5b7PnlLQYL6om9Q+INTuqGmDtH0Ka72DjCUrSgFMI9DdLGtfl3M/aLQn2C/PErpmFkqcMfOA1ukz4TKi+NKoz8C6BpFaRZvUbgLKOEohVh2oB1gdHOCw9M3gkcbz5zg/JWtw67zUl+93ToKd0TBF089jHnaHCEB6fXjd78HuKSMh+1NoZz/KAsI7r5AO5QFP8fxQvq5x1n8EQGA4SyyNRfxHEt5Oe4ymIsrNytp1BURNNYzGSiG4ugQX5BiZiC+XYl0ISdABCDzB3KGs4CO71vUYYOud7RoajPrbna9Bj4pSZlLF7in6UAcPHJjPaXNOSEgBI/RAsAgyBJM1uF93VBEwVJV/86f0+S783g5/3klB4ui60ShtkkwMgaAP6KQrI8VGM3mtVvvta6cj3iGMV6UPdil+Q72ntFWF7ZmXrIYy08PUcMlEydUj7ol/YyF4c6V8xy17B7LTV45yZ4jrl9qmu9u+eLq1lJ7LomwuL5mBgqVrs2jOagTMOUUMI85KusajAHdZ2jxvpODzX2OXG82Bie6Fw7DB2rSsNQnVkr7A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(6133799003)(11063799006)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kJNxC7VZeUTfd5unx2QBDBHzo1kge3+XBw6Iy2TbZJUP1V0ScQ1587OU68yQ?=
 =?us-ascii?Q?ffp7Q8XYAAWaCGicU8jdMMou3+/TRb+ecHjitzPpdppC9fQOFgADGGg0C/ar?=
 =?us-ascii?Q?y/urzI22qSQJc0iI2X0SjZ4hSigM6aqPLM4zsv0wiohPkEEmOIk9R8gXCmhF?=
 =?us-ascii?Q?yIGedW2deo6+oKEn2DwCcyY9hSp1NushuUxvTH+9oPIw5pVq4khsdV6D8zgV?=
 =?us-ascii?Q?fhkyTUkqWPpEuu7H47iOI6hcz2WkyqhX21ZSguoPPoEId+B3gfe3FUTosHDg?=
 =?us-ascii?Q?SW+1EgOEenPxo94Si3M9tMd3JrLm7RrK62ri1/qsUCShqR6/eR2n4nJMD/HM?=
 =?us-ascii?Q?G1GQ5eQDtb3ZZ+MB1XUls3jMFgdRl5XNbAAjQnGCNS/FslzH2hsmqI7IMvx8?=
 =?us-ascii?Q?0ch1tjwAz0sxeakzwJfUCzAd2Mckv7aogBwq3cgL8hYjlcS9JQZLN4OciKP6?=
 =?us-ascii?Q?pg01SWLbYwGpXqYLZJZGBwzqPuksZCZAOrJDnzK4NU4/7fmuYWbWeJin+6C0?=
 =?us-ascii?Q?JQ91FJg2un9fe2np/7OYu2jz4IEdL2aB1nwle+oEZspu7wIvvXIbdcw3A9Em?=
 =?us-ascii?Q?fsNx0aB23Wk6ijtLSpkD1agDs1y8gYWbKlsI0udSLjGom7/S9xtZLLvCnKRu?=
 =?us-ascii?Q?sbyXr/JP0YjVkZLKOQVaIJTIUOJbEkheUnLdbdBm2YCH2OSwmlgFek9ZsTMh?=
 =?us-ascii?Q?bAljjCCm2pRseq/83djvkV42c6hQ4tKQ0cryAU6yj+61R4fVhyZEa+/f7i4x?=
 =?us-ascii?Q?Lm2ek1axUxoJsDuwiBfmGxTbgmWeKb1exH7e3LuO4vNZLP30Uf7lvX/uFOgZ?=
 =?us-ascii?Q?Nmj5kWW3GZzmBWv7DcdzMCqAI5J71VlWAFIdvHQypVy/HoevSHr1mVrfq6T9?=
 =?us-ascii?Q?xZXOQu0B5hTer1K7DzyoryC/6gWVDjIpktYXcruNLfq5zaS6NqFmvRpw97Ap?=
 =?us-ascii?Q?dJhIcmNmrteKjiTppNL+BqUkdAQKrgSXcp4Vj4vzzP9a48kZQ2qSvRKzEz4E?=
 =?us-ascii?Q?ZXTB1e1AvDCh+dj5g0MrbSWxhgDanFrTiSVoZfJBKg4/LfduWZajx8OzOO59?=
 =?us-ascii?Q?7XGG9C18EGEPNsZK+gDUiXGFcggDpdlCz83ldKATOlCHCUMIfX5X8fFa0X/c?=
 =?us-ascii?Q?Sj/O0HcXykfgEnqoMvaRxgv1P4TY1p9ymyvu2tn+oAbS0a52pyZG2IGxmHLd?=
 =?us-ascii?Q?H7LpXoBJLVBHtIJ0jWpOT9VprQmALajLtsrJBd0pL5OdBKI2cPB/FvqQlMkn?=
 =?us-ascii?Q?r7jrwJcNuNfjACWT46K4/bCif9IA4GRvZldv/oFVbf8F7NKEYZoPJhDoAZsu?=
 =?us-ascii?Q?qJn1sGdldHBR6J0QMdvaI9DvgzV/l3rVOIw1RPe7A1o9SZn2bxf1Ph9m/vu6?=
 =?us-ascii?Q?vMFwmKxoQieejjukkd03N5agGADIwfclChpKrgxLGu8ds0mpr7abZHqKUE+M?=
 =?us-ascii?Q?Qvna6+cLUXk6F/iIC9VTiQE/sDIv7q34frBKB5IXBUNh7xIUrxLyAl5XFXAk?=
 =?us-ascii?Q?65Y3z08TSGIjpBUJrFBXfE7mqgYbLY0xa7wLWIeS+dhp5y05CUe9XDudTTT1?=
 =?us-ascii?Q?DenHS+izY+0sVhuQoSA+PAz0GeNyVxZ3pRYbs7RTEBIzvVleZ4hOYavbblh1?=
 =?us-ascii?Q?bzh8VkSTVj6YMbpHhzrLrRzAywN9t43RqkvOsscDDffRSs66jnQHnsfMXdym?=
 =?us-ascii?Q?d1d7ELOiCVYOa+d0ALYk3xY8HyISH9YhkM/ywE6ti1zKDQys?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abbebd8-1cc5-4d71-6024-08dec88815e8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 13:39:54.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQh5MsFppGmVq6vt8VqSD0jiA7Fuzur1EoBZwSRpfQW0Wz8vr4Zla42jIPSzUsb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494

On Thu, Jun 04, 2026 at 06:21:16PM +0000, Pranjal Shrivastava wrote:
> Update the Intel VT-d driver to handle ATS configuration and enablement
> more strictly. Specifically, update the device probe to fail if
> pci_prepare_ats() returns an error. This ensures that any ATS-capable
> master reaching the attach phase is guaranteed to have a valid config.
> 
> Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
> fails. Since earlier checks in the probe phase preclude config-related
> failures, any failure during hardware enablement is considered a kernel
> bug.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/intel/iommu.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
