Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793214461;
	b=Q3tDPk59KHYfaAelVvJYybxIYe2zB/Vhu4L2rx74FZPxBILXKv3Klb24ZypD7/eq77QX
	 hZ7QUwsG889PPwoMehxemAKh7EYkAWHoiNFrHmDs82tu31HpmAHzy4ZYma0VgbDBm794C
	 TA25q6UEsSGW94mlhDhv7hNZhGDkyhjJ+Rz7P2k/hR+eiLQOfPe8PY3rAyPVcsszcjzq2
	 gJ4tofyx/E66uZjbRB5BwuR/o95iejBlrAbFCZvaPtAgK7iVkysKaKL9yArmhcaQrPVGR
	 kVoh1LdKCIdjtnTPgP3Nr/27ImkMbqHPg1gjywLCwA88mIqv+9yW+57Mokd1ViPQ68w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214461;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ThwgCZrJumpUXydZ6JKyHybc/p37ReTHEsXlsfBqK0M=;
	b=v/rre9STd3ze+uFssON9tysjQvOvmyTt1eVVDXx1Fmvmg/SddINhOg705qSp99z9HY6V
	 ec/nEVr10i4C+v+AxTqFLivShriKKDSc0s+ERDn939NEFzolwuV3XTiMh9eDc1Nb2xgv+
	 bLxtMoeFuo73F0NMF/jZRx1AchuzjFLJIuRkR1Zll0puXjgoSbEgPugcgctskEN1IWKqq
	 DqXdq2A77ab2cNfPeRd6FSLPYZPUw5j1hiJ3Rv1p0sOz/CRGJrYtIXbOovIzFiG65mcn8
	 mweicdSZAvH8HSHIXELMAZ7/1R8rVMKXSj2FzroKHuEDJ+jtnC/hHUJ6lyv3WAw7DQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GvoqA1Ad;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.54
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A260A5BE1;
	Wed, 28 Oct 2026 19:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91A260A5BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GvoqA1Ad
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/ueO0E7FflCk0wxfuSfdnR8HRdk2dhtFYt6Zb6Ux0khqeDYHAdcO9kxt+CU4vp+InOXWv4vfJb/rzpfEkwjkdr0sOF3EE5zVlxuUF4iFUypGKMNiKuglmW35oQatJU/lXEZRxHO75ElGIR0CGoilz3Vz+9Szpx05OJWqEew5DG5PSWAU2nn7A3oBNFlZaPLUlDUPFezKOnwJfIFSJgqifl1UCpPsr2pdX1aPew2CCFovtyhHjEEfK0mtXr2PXOuSxlBHl/mYJ8IJdKQ3LcYL6N3Ic8Mo2aa3YubzHb5ndRkqN3FfF5o0G0cQqYQKf4UEEThz5WtG49shr4cQtGVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThwgCZrJumpUXydZ6JKyHybc/p37ReTHEsXlsfBqK0M=;
 b=HPjzmxHVkttgbVIKVhT0axRjP3PQ3L5jYYsX9980VOMnNR92WhBHDVb4ToZoJfO9NEz3guQVtQuq0UcVojGmLzc5twotYqk4UFr0g+1iTd84dWT7ID5Wfl136GmDzjhcemaM5WAeG+7gEL+mpbcYtOA+8g4XaKDnICo/T7sqF7SXO4m07kzgTBjj2LF9SdC1oPMQJqnUcyLB78YQH1WbAPirlLsVfbr7vOPzglLQ1CphW2pmy1t+Nwy32O4Dtrq2YDmUoPHu1t+pXw9WLko8V5OzlkbokfP3T/4MqnKd8rkbs11AifUlmeudSxZ7Ivw0Zen5SVSsibFl/XrpQnYgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThwgCZrJumpUXydZ6JKyHybc/p37ReTHEsXlsfBqK0M=;
 b=GvoqA1Adp8B4QD7Mp6v2fO1A8tG42KpBm0q7PKN3VuC0+nk1yUpq3+GCmjkVYjtVU9/1nMnW8l9X8ITvY06p1TAqc+odigAAwQPre5f1iwCYy4NhR9Er4b8ylnxFNPvTwk9yUattP4xRsdDm6BvSusutTDQWnTZS4lSKUw5aTVHBTu9yXJIFsqaFYIKEfCMMLK4CsgZlOJI2z7jkn/TCE53nmaz99Vkku17yTvFWMMSeTSerIxA9CZK9IJ0Sg26KoWcWWiIYKt7kkYp1/gvkJwk3EK+G+zdw7697lfAanBusL2WAtxx85p3XLsxnQbwQvSBKOfZyxasH5xoj5nE4iw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB9394.namprd12.prod.outlook.com
 (2603:10b6:610:1cf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 19:07:30 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 19:07:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 12/16] PCI/TSM: Add vIOMMU-bound contexts for
 vdevices
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>, 
 Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
 Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, 
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
In-Reply-To: <20261008055955.4014342-13-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-13-aneesh.kumar@kernel.org>
Date: Wed, 28 Oct 2026 16:07:21 -0300
Message-Id: <179321444124.2412245.10256331355179306703.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4P288CA0094.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::22) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dd75e9-d425-4c92-8c25-08df3526b313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|261028144727099003|11063799006|4143699003|56012099006|261013131602099003|261009223027099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|10067099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mFt6HSz2Vtft5rZUnttjWohoSa5RKY/f0lo/FW+OrNoBH/7slWj7pfjMjHjuVP+rIYl/Sct/PEI8aX9SXBmPa4sc2vmOs6szPsaxVp2ZpgmvBaGJxYyrUci0aW37YJ+tK4f27rKPlSwYSbJRZxEiNyiTa1HRF91b4f+NWaNJMKsXe+OuMau3jcE5bMbNB8ejs4APjw5S2X/YMbyRndLtJYZ62B+Z4oed2U233KXOG2TvNA1L9b9QQ0IHkfoZkkLYQGRxs33c8sTEO2Q3Py4RxH25OWZi7qw+V2MuSNlRZ9etDbx4z2hOTAHUJkLYx/lpEPjW+mLCzn+IoJMhaMIls0mcS53weWOArAVrfv5RNF68UJ5c9w5RN8bAbQBqQOoDJbXxMKObNOr9f10H6u7VtPVsC0QU7L95w6VRFJOkZfXRgg1fgy8HmeG/6+IzKDBrPOFrXDDs59+p7BE3En4rLSwNVxkqv1x5e/HQbXryLJAmlmQDZcFV/hlrfuhMvoKjYbMUyTPzrsMS220eO1EbOTwm4AYMN9A68Ysvu+A2uJTHb8HBNtalM87lfFREdLLJKi0CpgpjeXhPK4Fd9Cl38jqWprtC0xONOPXH4urhRftlHE64VNXyGaddkIkmVg5dRvax9khKKoz8vlWdfKD81xgYTHbj1zlvECr7k0Zn9qE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(261028144727099003)(11063799006)(4143699003)(56012099006)(261013131602099003)(261009223027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(10067099003)(261021123027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlM2bFdWVHhNNFFGbTNwOXdSU0RYNDVtd1lxY1VVUEE5L1NlTThUVjh3NkdH?=
 =?utf-8?B?MUdyT2g2WVcybU9Nd0dmRC9jRm1oaDh5S3hMRTRLWW5YOUt2NzFoQ3lGWFhu?=
 =?utf-8?B?WXoxUXc1TE1MRWE4SHRuQ1RLQVNNWkZjTjZsWUxrdTEyL1pmK3pTN3pRWU9I?=
 =?utf-8?B?VjJWNHIyVHJBNmpIdTdHMHZuOUlrMVRTQ0xvVWZnbHBrQVFiK2s2aWJieHVn?=
 =?utf-8?B?ZGN2S2hQRXFwUWw2RitkNERaK2FlaGVOY3RoYjI4SGNpMmVvOS9lbzNmOTB3?=
 =?utf-8?B?ckV6U1NxVVlOMHNOdmo5cDNQa2VQKzhrRFdWaVFhV2R1a1RkdUZMbWh3bmty?=
 =?utf-8?B?L0Z1VG8vSVEzVkRMdTN1NkdmcG5YYVFuZXNOYmR3SDlDaFRpemNQeTBzZk1I?=
 =?utf-8?B?WUEvMFN0WEduV3BQMThNVm1UeVoxOGJ1MXc4eFhGakNHZ2JVY2gwQ2VqeFBS?=
 =?utf-8?B?MWhXdzA3K3JlYStPVWlyZXZzNnlxYWhlVkhpUlp1ZktFM0lSOENzN3pWckx3?=
 =?utf-8?B?RGptUEtsT0lkd3ZHRm82ME80NDlWdGNVa1dMeUJtMTlWOGlEZHpmdjVUb2xU?=
 =?utf-8?B?QWhyNzd1U3FUYlVhaU56cEpHNE15VEY1WkdWUmlTYWp1a3A3UTR0NUJ1NDE2?=
 =?utf-8?B?aVN6My9XUGlORHFGTE94VU1lWEVWRXVhc01OOGdzMEg0ejU5cVk5ZVMrekNH?=
 =?utf-8?B?MTViTHZZM1AvaWNnZ0JML3IrODdlS1pjaEtEcFl4VTN1ZkQ1WjNnYURTVEx5?=
 =?utf-8?B?N291aXZ3TjNBalhXSldacUJsSncwVUxUSHR3K2NUQ1JPTWRhaE5ib2I3cUxG?=
 =?utf-8?B?bTVZQkplZ1RVeElmaXVGSnJSRGZNaTRJajhENy8zUHNzcW9UYkZaTE1ZemlP?=
 =?utf-8?B?S2xLSmFkbWxGUk5oMFBqalkwTFFSU1lZN0hUWHVSZTBzb245aE9PUjFzb2RS?=
 =?utf-8?B?dWtxcThyb1kzRFBEWE9Kc0pydHVCTndvUDJFUEdPcTRlZnByU2lPZGw1Zzds?=
 =?utf-8?B?NDRndGJmN0tiQy9uWjcrMlY5UFhRZjFwTldDSHhZdU9rbWFCem5QczNhc2hF?=
 =?utf-8?B?TVNoT2Q2NWRDV0Q5NUt0L3QwQ2M5Y3lNS2JyZlBXNXFJcW9qVXNaQ2pzVW1M?=
 =?utf-8?B?SSt2Nlh2YVdqVzl3a1I4OUN0RWRCemhWZlR5VXNqOGIyWWQzWUQ5cE5rMkFZ?=
 =?utf-8?B?WXJoVnFjcHh3aUtVV0U5UmJnajJydllsTURCd0ExVXhkZUJ1dEM1R0hpajV4?=
 =?utf-8?B?WDducmR2REl6ZG0xREVacTRiUnBpbzFOdFdYRDBGWmVjQ1lkczJpVm1ZTGha?=
 =?utf-8?B?RUJnQ2pEUldnZW5xMEZpRmdhRXdwMzJnN3YzYnhDNkdPSi9kME95d05pd2dy?=
 =?utf-8?B?TktqRHFLQ1BYNFBTeDY1WXYwbFFiQ0tUM2JmRXF3a0p2ZzBWdGFOOXFtSVFS?=
 =?utf-8?B?MDU5VGtrRnNaK1phOW12Qk80NFhYS3E1bXFuZTVsVTBNTkVja1M1eUhKL1VK?=
 =?utf-8?B?YXBuUHVqeEFVNk9lNGYrbmUvUGlqTUwxNEpkOXZvS0lrRE1PWGN2c1gxSEY0?=
 =?utf-8?B?N0cweng5eWNqcmRuM2JwSldHRWQ4SEs2aEtuY0gzR3BTekdFMnJQSlNWNDFw?=
 =?utf-8?B?czJkSDIvaFFuYVVqUVBjNlBIMjM3MWFkRmhwTEhRaDNSN2pudWR2cm05UlQ2?=
 =?utf-8?B?Undab1FCYkRxVjI1aE9mWkVQN1lVcDN3YUdKRXprV281Ly9GQTRJbTFkVXg2?=
 =?utf-8?B?RGxQMlpFWVVBM3V6TkdUdmtoaFVyWi93MHRaVVJWUSttYVNzRFlRS0JIOEhP?=
 =?utf-8?B?TnhmMDVFRmlrc1BuZXJyaW9VTDYzUDhuNVd2OUQwNlNKaURzL2ZaREpvclcy?=
 =?utf-8?B?c3R4YWNDSTJjTlg4Z1RFcy9hQ2NjNmZYeHplY2I4cVVrUlJLNXd6d2hkOG9J?=
 =?utf-8?B?NHoxSFpRT2tzOGpQays0Y1VmMXI5YnBQU1E2SmMzaHpjV2RlT2NuazhuRmd4?=
 =?utf-8?B?SmNFdjBvZVlocVlON2ZUZ3NzRStxZjB1ZG43WUwrRHZYL0dxL1JGTnkwa1lV?=
 =?utf-8?B?dW5EZ0k4b1MxTDlEZ2ppdlVtU2dMODRUMDA4MG1IT21XbTlubU9SZGRKZm9S?=
 =?utf-8?B?WkVmK1NYREowQjl4YlBoeVBOMFJ1d2VLL3hwUENsU2h3YlIzbFVaeFFjSTVU?=
 =?utf-8?B?Q0RVTVRVQmVQVmlobUR3Qkk2RnoxVFZHNGhtazEvS2xQa2c4WmNNVGlLSHVq?=
 =?utf-8?B?ZjZrdFVQZlNUVHIzQUJRcEdmYy9uY0F2NERFV2pudFJVUWdCNzZrUk1OUlVj?=
 =?utf-8?Q?F99P2jGTLK4JXrmmQ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dd75e9-d425-4c92-8c25-08df3526b313
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:07:24.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3y+/4hpctCZu+uoj2AunhZQq5FNHfkVWHhoqaiPQDziZjl2NM6Unrvw5c5LaDvH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

> An IOMMUFD vdevice must use the same TEE Security Manager as its vIOMMU.
> Pinning the vIOMMU backend keeps its tsm_dev registered, but does not
> preserve the connection between the PF0 PCI device and that TSM.
> 
> Add a per-vdevice PCI TSM context. Verify that the PCI device and the
> vIOMMU use the same tsm_dev, and account active contexts on PF0. Reject
> disconnect with -EBUSY until all dependent vdevices release their
> contexts.
> 
> With vdevice binding handled by the backend, PCI/TSM no longer has
> generic bind state to report. Remove the legacy bind and unbind
> interface. The sysfs "bound" attribute reported the state maintained by
> that interface. Remove the attribute and its ABI documentation as well.
> 
> Cc: bhelgaas@google.com
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  17 +-
>  drivers/pci/tsm.c                       | 230 ++++++++++--------------
>  include/linux/pci-tsm.h                 |  71 +++++---
>  3 files changed, 137 insertions(+), 181 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 55ea1db749a180..4c64b30544cdca 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -654,6 +654,9 @@ Contact:	linux-coco@lists.linux.dev
>  Description:
>  		(WO) Write the name of the TSM device that was specified
>  		to 'connect' to teardown the connection.
> +		The write fails with EBUSY while any vdevice depends on the
> +		connection. Userspace must destroy those vdevices before
> +		disconnecting the link.

Probably just generalize this 'EBUSY if the TSM is in use'

-- 
Jason
