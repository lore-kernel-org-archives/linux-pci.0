Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793277812;
	b=gLpnk65RbZmC6UzXclZjituoLM/ThkoHBdshCmcu+nsIdfnbSKS/Ve5uR4FqmU/Rns5Z
	 R5qbPR8ekAHAdGHgw5yf5/oEliFN5yA/PGJDN9b70uTl6QWUZdFqSXKq+OroV3AOvzpSq
	 /Dlmxyc+qAHvxIi9fkA2iHLyOVv7kcJo9R5iaK5tMW3/ONJvRUnl9/TYiIgyj4gAafEPv
	 oBKbq43SGIfMvIGq0nn/bJNpdvHF/SnCeQ/TntynZFdbDqVIgMNoEnPWAPuuPdwlTGjzX
	 ZVvWItfOImaCt+txV+sUoA1jIgOuzIlAi7FGWq5eVTSF1YN1J2aYna1cG7ovVP0xyIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277812;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=f/Be/r/0+o61KZQUOPjZcG2yniCeh74DiO5qcZY1yqc=;
	b=UJ7s3FLIxQT+cDmtDe5/vyG1CFCIRdMHWME4dGhAwrd5Ks3cehcXMZPizD9KH6UvfXvd
	 6r/tyVsVJWL7aJFGL4p675e4whn3he1isA/NDJ0moXh0Kcd5BM9bySW2uoBXwmwFAK5b4
	 XDvop1G4E7noatNrfHmD2SnuqZP1o3HkByF2dk2vu3ttXbxICsVeqaXJMGp/knrMcQEkS
	 bV8HTYbr4WPFvvBrkxMJOgTylPJMPU89edqqQFb6Ko/Wp7UxhnRaBmHudOKgIBNxeYh9k
	 M2IntDA4oQMLLjIxXrrO3IMhJKRwnB7Opmhn2LWNYAiek3ed7XBBwTbLbuBRfEZeAyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CInIrfi2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.17
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2992606A31A;
	Thu, 29 Oct 2026 12:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2992606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CInIrfi2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxBsnfXwcrLbInzOjMTsBzOTC4/iSzP9KXtu8/1So7WQTAKSLSB/HPCAyiji7J99XkXBGPvOhZBgRZZmwnzI1E+KHgQTes98w9Z52j7kWZhVbr5YHnLpx94Ea6JcM4qUs0IDKp2S9SxI2SgWFZl02XiHFzWQ150vTvV6KIhA1wXGbLjdxGRy3EcqNPvXRrtIa4hcsLbZWO8WgbGTw4EDas7Wp9x5/pwXG7J8OJfTpNrJVplAfvYGehlSXsBSVR5moVqgsypAUfILyeBuFT26gwAr9lIYab+zwKFgYmkjG/T4K78k74AVtNHVxqNo+uV1XCi8lG65qKzrgk5wvztsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/Be/r/0+o61KZQUOPjZcG2yniCeh74DiO5qcZY1yqc=;
 b=cj80gNIamr7zmuQoFG5c/4bhAEHYD4NL8GyqJhN/iFlwt7m1FAKjDlUXuogbVrc3GmdzDDyxS8+dRZjV9wLFVoIklIfzr/XrSAgoly1l/Azfc+3zQTjVkqI7R/SlwWGU0xv0Y3VOG7OcqDyMJfhKNym/QTw5IWx4Pz9vOS4fH3RENaEsM/pKTz5PfLWXwYhO+5rCxJMzPx1kzWD+4n2fUx00GJ5kIzJ2r0ihsmB7rY4wqcNv7+Z1Y2zwvkkjOT/uXBeJ7rmXRS9s4e9xRgkB6KtojsItCqMUlWb8WpMjbUbHx8guiH59gtTv3Dr2F9FEI5D6cXQs1PKimnLPTygZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/Be/r/0+o61KZQUOPjZcG2yniCeh74DiO5qcZY1yqc=;
 b=CInIrfi288jguocrBCxRRS6idMCHUh0dMnDmes6LUZgzp4QtjcbPNCdASANAvhjwLbsqkBODLatZbsKVma9E1en4UukimpnWgiq2r4bdA35swBXuKuxArmpu6ANUeRWdFPv2DWVzYzRzdqXucw5JYdNyyBaZaz/nVp4OxDUBgZML/T9JZ3ENdy+viwUR/tG6yQMIE4rxXDNqhFHY1qhXHc9lmX4LdRyN+xmV84fKiqNn5UK5Bg/6SHrTqQo0NPNz8LSEHDDuuAUbKP8q3UyHpwGTTXVl+4MQBU/omROK1F3rmqUouWWfrM6GJzhoha5M2lEFW3UfclFSbiPBN4w9Wg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LV2PR12MB6013.namprd12.prod.outlook.com
 (2603:10b6:408:171::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 12:43:28 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 12:43:28 +0000
Date: Thu, 29 Oct 2026 09:43:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, iommu@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 13/16] iommufd/viommu: Select vIOMMU operations before
 allocation
Message-ID: <20261029124327.GF3040767@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-14-aneesh.kumar@kernel.org>
 <179321444125.2412245.13201160469751061592.b4-review@b4>
 <yq5a7bj0c3xq.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a7bj0c3xq.fsf@kernel.org>
X-ClientProxiedBy: YT4P288CA0052.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::7) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f548cfa-9fc3-4534-bf6e-08df35ba3b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DhQxVtcfZUe0uT27/aYjA4bmK013NPt9lssw+hN3aRIE72HseYuYYOcQLFdkIa6uu0Hp6g5Lo9rT9cVoU3unhFxkrYRe67ca2FaYZGUR6bHkxTz8F0TdPb6rfVsbi1b56xCN6wO/SKQWLLctWd7Lh7AzCiPjgk6ycYuYwPwch1KLJel34DLDVyc6BdhmoUwfTf791iDxJ7x7ulFmKEhy548l+db+89pHm3NDUQ5FP2Z85ipanfRAhk2CLVcKpkAVmuB9KRyk98oxrFsSwe8SqOYuZ3kyip7y7kmeNUOLGtzwH5rUomcJQRE9i6+idqj3+81PSiMnHZHVhlJHn57vI2yC0FhK4lyE+wFZ07VdH5RSlfJGoofhN0qu3Z58JGdivAD6OE1kqmBd6R/M9okO2aODBDBGp5z1FcSsoYVdiHqLAVwYy847H9dQ4uh5WvNrtecwUHGTSBUpmqQcboAb/k0VDUqoKNZh0s5APJ0EM1dawmv9fWGsTCb5TI/t3+PbZuWhqIUZbmm8RN5briDRgdGP5wkwIBeDiKeYdsfxn9cZNqaSG/QpoEapL9Q6HUuHsQWT89104rRC3EqCp0zKLvkidvQKjwKvQQWUSouUTu3/3O/gZNL1ScTfBj0LEhWJXiwrj/i+KQpEcfOOc4Au8N6MQEmrNGkFTHVY9oXM8CQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3y2EhUf9YYOLkywnyQrvAUrHqvTrTgYS2rG8EglQqw/X/ge51uwk41I28z2?=
 =?us-ascii?Q?/qrAIEoBLLQrF5LzJlW2d0WvSwzWO6o0Ta/U30xGpCOeJG8MhbNiQsOpCEAv?=
 =?us-ascii?Q?cPMzUVAZuaHV2H/Ih7k00YtwgFzbfIGvWZHN8BP5ZJMIpp5MWjw+O4oaQMw9?=
 =?us-ascii?Q?TPwffTTOIVZSHmCitZgQd1iRU5dOCHd554Q+hexPvKE+pz1HgY25OMl/VTXz?=
 =?us-ascii?Q?T6x7req6CD7jcomFZVdznCkvviMRRUNBTVhoEJLVPBEJpNnUbST0dPhURQkE?=
 =?us-ascii?Q?7Iq1M3BqLh6tQMDfurvZdxv/Fo1eUbzHojj/lWq2mU8O/81F3S2wUmfvD1Q1?=
 =?us-ascii?Q?qAYiFWYKM5dhfGaoW3dh4MRhpufgZNSVLvCEzFUVvsy390jOLp7uH/CvVClu?=
 =?us-ascii?Q?klICNRojI9Oz8meX+vVLWG6BiTSDqMcOPFbyBnQY8uNb9Nwi+cwgCtaH7Q1o?=
 =?us-ascii?Q?lMXjNfd11de1lP4lIkt7A0jECzeT/NVm9p5oWXPamLh8DVs5PZhjelL+fGcA?=
 =?us-ascii?Q?LtHW/ivK4Sdr4lLmfvPj2KEkUta0YfJ++jdA08eKRenndd8frbyijFEp2c5M?=
 =?us-ascii?Q?J0sqfvpwcWeLyLYwJw+p8HUbzW1/zCDLShjTDcbI2J/A4fQ/lXAtxIDbudxs?=
 =?us-ascii?Q?9jU3C4xTI20YIpR3Ud4NOmd3U4skF6gMFZHkrEEWEJmsay33cuCpf4X5gdcv?=
 =?us-ascii?Q?cYS0GJk1UnruNeXHRAM2UMIKc0Gr649US4ZN89CMWPC+fN7zXnVp07h0EoK1?=
 =?us-ascii?Q?YgzTXGLlIbE7AWa1jgn6UGgdU0AgBzLrHDttYw+8UlVava4K4NUKTQa51nTE?=
 =?us-ascii?Q?38cPioKYJWXhH3TdopZWv4iobuEZdKDZ7sDcj88yjLkODxS1uJa1XuXZPgNl?=
 =?us-ascii?Q?NHYZ8ad2FIj2n0uGOh+8c3RQoKJiLdUg7o5syoV/iEIt/fWJVgJhYSK7GZhH?=
 =?us-ascii?Q?yWplUwW13gsLzvBvlAQuLANBFb78IwRpafmiW/X8TqDKuKIdmsE/V91HjULp?=
 =?us-ascii?Q?n8c7g+GKjXQ62zffT13q5MI/Mctc+ZqzT7WF9AH/IsFia5ZOyRX+jqVSDf/Y?=
 =?us-ascii?Q?HdWD0KApN41BqYbJ9HgbY2yimJJSkPNaKqBlcy0XEVIO47W2oSf+dy/oN4lM?=
 =?us-ascii?Q?zECeSx3DzJ4d+X6XQqr7uqiPjN7MX9ONw/4j2CAuh65+9dJ+ekOrMtblYjpS?=
 =?us-ascii?Q?0gj00PsSPOcw0wLW5PnDePdKn4mYoPOCWPyDuZcH6TvkQUVnBDGON+r3yTNn?=
 =?us-ascii?Q?lNOLQHyaBXttrL7fuFeJugw2L4JoDFRlxBjYu0q0a16czuNEvjZIyBO3Dpb4?=
 =?us-ascii?Q?eJ6OMJrz2jYOdlSX6+W3L5sQ5V7Bu/s0Q8ukpwfEWSOiziTKwlSPRswBd9Sd?=
 =?us-ascii?Q?o2OY96APy/K4onaeLglivR0hMZywQpw6Sml9t1aBXLA1aVXyQbQtH9pz62/1?=
 =?us-ascii?Q?maAfK0Ut1B/2xXEvRNu+jfTotAUL0/pPA25YOA2K9lCcPNgBI9ggFtXQBwtf?=
 =?us-ascii?Q?y3P7hsRGcCXqEsmzz2vnJDxgFrBL0SAaRp0ZrVHAxM50+bVho6RkcHoOuBWi?=
 =?us-ascii?Q?IxNlNZ+gUcyofWNUIVZ9w1xaSpNAU/D8a1LJtxmKL1anrY7COoga94hOAxA4?=
 =?us-ascii?Q?E7wgkr4zv5czr2QIf7aPvLKz1f5I2Vo2RlD69HQu4VUiyHj4fPYglptkiyAU?=
 =?us-ascii?Q?49T4WNd3Lprrqmcxq+x6T+aT9u71npj314VYWQr9u3OguAuU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f548cfa-9fc3-4534-bf6e-08df35ba3b0d
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 12:43:28.1788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHP3QL9wAEYaQpu+WOy2szz72MdGqqS+3t3eVta+NpwiTR30K+j097hiFblp8Z/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013

On Thu, Oct 29, 2026 at 01:51:37PM +0530, Aneesh Kumar K.V wrote:

> modified    drivers/iommu/amd/iommufd.c
> @@ -41,7 +41,7 @@ static size_t amd_iommufd_get_viommu_size(struct device *dev,
>  const struct iommufd_viommu_ops *
>  amd_iommufd_get_viommu_ops(struct device *dev, enum iommu_viommu_type viommu_type)
>  {
> -	return &amd_viommu_ops;
> +	return NULL:
>  }
>  
>  int amd_iommufd_viommu_init(struct iommufd_viommu *viommu,

Yes, it was a mistake to let this in the way it was

Ideally maybe lets get Joerg to pick up just that patch next week.

> Alexey,
> 
> Could you look at this and suggest the AMD equivalent of
> arm_smmu_get_viommu_ops()? We could add it as part of this patch.

It needs a whole other 20 patch series from Suravee to complete the
viommu work in the driver.

  https://patch.msgid.link/20260930092344.5616-1-suravee.suthikulpanit@amd.com

Jason
