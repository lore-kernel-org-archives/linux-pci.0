Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1872E43A7F7;
	Wed, 23 Sep 2026 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188634; cv=fail; b=O3Vjfs5h0AK6jTnUd6iKTiu9HPwpgnPGA5KYMb+u2bHfll0aWLKfaNTe2u1e4AWeGFH5N1/kCSn2YS1m4xX0QQlp4A0iKymkCaLwIWc371H8alr/D4ilnV6lzHsHJBCBJwb0a0ONTSqElXKoaRrRTszPr0o+/24V6fUrQm37Umk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188634; c=relaxed/simple;
	bh=stFR71eHoz/1uyk0oyWcRe0rFUQPkOU02XH041nCqW0=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Ul0rxbLinRMRUaOsfGu3BzoWCzaFuxjlqwvb/imbBrFUu926+5z0pMf964i8LoGRMpZgOnYnrGEjZ6cK48OIvdvRfCBbyDUVPvWfhHuxm+iuBSUIJnbLdvq34c/YcgGdbbgIarSEv1VJ8QaZRxyU3DH5MrfZS7qU5ZpRm8W1tlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B/hBz7DH; arc=fail smtp.client-ip=40.93.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/hBz7DH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNO1ledCmOJe9B4Mxb9yDTwgSrgM9vNUoDDmUw2uwWY9s2Mg8dz6vedqjw9S1S4g095puVZpwV2nWMp0pksoPD+XX0C5NrXsKSocYFw/71HPie7QAb681wTWUF5+gOEgMsoqW2xpT88IjHeA5grDgKfTCknnbRt2/BegfLfmE9xuqrnmLMA5gTV7HqDrB8o5fYdV9ga3WjTTCPlAilDiwkP8vu7BRQJ8T/7mYaHK+kDfcRlOvH9EYQinYAd7dpquVYpOECz5UFEOZu6C5XoiV4XwJ1IOYFfixs9m5HAuP1k1H/EqatOjHK+ctWTFCT463QTanhKXd9t5nOZCDj1aSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2A6B2I3wDvhohTsIa2IAg5DJXz69IkCtYeSFF9Mbwg=;
 b=eJ0r8ouEniQuFstCpoqGM6Zgbqt6bhRLuf6MnkXT8ZiXPqUtgUWr0IQdJmaiBmKuxBhGrQLGZmaqf2VlFp2RAi/tQz45Oaa4GUb0uI3svWLxQIbLJzt7PpXeEY45pelAV00RyB2vU/ikhsbBa56TZTtlVTx6BdrKXTTf22GDFZpiIU/6tQejCWzBlWF7RZWBO0yNakL5ZqBxOHuxqxkcEJRZBMw1TJMUMxyTX6YMsOutgg5Cgx1W34MP5G7E2xgDCmLb2Z3rnZWtjcZDxmNgaknnEAVzMdXz9HWgHxAeLMJOXHuggyfatPEY3q1ZmSNYNtLDAZL5YGv4/IxCHjYqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2A6B2I3wDvhohTsIa2IAg5DJXz69IkCtYeSFF9Mbwg=;
 b=B/hBz7DHJJACUPE1mA+eNcOxLGcEUGBpamW3zwC2CwS4/kCeynXEJdrTPC5sA+kM9pQoBTnKpOHAJT/UfzqIbpXOsgmUdiTxpcmuJci6ROX6SR7CyPCUfYwuxCpbn0ka7rZKiwX3MzsQPvZjnmx3YYBiOVla4tIDf5OPlxhnRM+/hRFvbA7+A6TQrxfrWGAVpQuYBAG9cwRP5RK3r4jCz48vCUMQBCPqiCjfHzgaxAzCLrNebmpdcdjqFzQN2B3ici0lB7H0xomjAquXOluAW/oNA0n+JPtBjwcDfd52ha2/DAFX/o00ueCl94ZDKGFL4s8XKViDt2H8jFIiVbv7XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CY8PR12MB7730.namprd12.prod.outlook.com
 (2603:10b6:930:85::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 18:37:08 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:37:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 09/15] iommu/arm-smmu-v3: Disable PRI when no IRQ
 handler is registered
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, joro@8bytes.org, 
 bhelgaas@google.com, praan@google.com, kevin.tian@intel.com, 
 kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com, 
 Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com, 
 bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <ea41f8fede603737093390772bf6dba393593407.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <ea41f8fede603737093390772bf6dba393593407.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862539.3334538.3114713905817706869.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:208:239::18) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3a475e-818a-4c0f-a17c-08df19a1ac8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|5023799004|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nwl2p48An+hS75N5gs+35nWrrtDF1Q8ei+f967eRc1HiQz+WFCxdFfh57dB8zZkxoFj0+PZRwmlGUpHqxWMNedwCXV57Qr1GCeJUP/n5jo+5ssSvTs74+t3OgOu57nj6NiO+u3p3KQQvSjDf1Dv3fwl7dNK5/Wr9WuVfmRCy0DYdRfpGtZ6Dz4mES3sKCLa2jZcwYJWmFozOaHWHpVfNmFaTyZv/xqqfQ+wBn/VBiEMhmAE1CZjANxannFtSRBKrsCtxiBGXs93JmDMitfLNsXE9OnZZSz6WIsHvYVUD1MgRCFRpI521HtxJdviwgzKrr3xowXfphmTMHdpx+hOm25hvuAH0/dhjJqHiNZyApwr74z4mZ8EK4Zz3BRvx8rTJt4EjY6EmHSzxi+WcBGXG7x7NaBynBiee5qrr64WSoCODFpnL6daw1oP8snFLYp1/VQycJIYShppizs2D1sMLzHcySB7wynKD2xW5moQsC53GSX5akl6+XT34CZNnjscuTuMSCRJ9maq+eULP9v3BHT426H0nq9AtV2FEy+qDDHzV9wMsRB4S5m4dvbjKhQ9wUkugtOmCFSLtj4dh02qceVgPTlV2jz1oLJJxIzWmrpWLp1p8pYiZ1nu6YftxVzlKqlGyRVEF55rlp1M5HkvjGRZx1a3nVOwpvGkOqz9tEyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(5023799004)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWp1TUltQUFJT1BTZ0EybkZkUkZ1OVJrT2lxMVQxaWRncCtXaG16M3NPQ25T?=
 =?utf-8?B?SjNVWVNuV0VEb0FIa2xKalNhdkYvSVlldkU1Slo2eUI2ZVFIN3Azamo2R2FE?=
 =?utf-8?B?d1JxUE5DaHhuT0JtbnkvNkhlekRLdWI4NXI3OTZOUm5HK3B1eU9Pem1zcEdk?=
 =?utf-8?B?b2VDM3c5OThWUHdRRjdQUGNGM2I5dTFoR2poZUdabnpuUG9GSmVzM1VZQVZY?=
 =?utf-8?B?a1YvSStVcGlwREZuT21qU2xqZFB0VUl2YW1NcDBpNmNpK1ZnUEZodzRnQkpn?=
 =?utf-8?B?WVRuemdNbDF0WU9kamo5ME5MbFVjUFhTTkRZelBkemxDRktSR3o1MDRQUzR4?=
 =?utf-8?B?ci9OKzlMcFF2UFZmNlUwdS9XcFlyaHU0c0dXMnFEYWVwaUZLS2h1QWFxQnll?=
 =?utf-8?B?Ny9oTFJWRjE5eWVkV241TC9GL3JiOVl5SVRMdmJXQmt5SEtmZzVoMUkzNXBu?=
 =?utf-8?B?VGp0aE1vRVVGYjhQckRUYVk5a0VHaEh2ZGZpTit2SmR6MEdKL0pVSWtVRFlT?=
 =?utf-8?B?dzlnUGI5YWxNZ3Nna3NMakxvV2xZaCt3MFozVmxOalVsRXUzSmhEYlBhMVFv?=
 =?utf-8?B?eDl0SDU1YzEvT0I1MlRZbEZPTW1QWkh3QlBUMFJFRFNMRzgxMzc3MXZwWndL?=
 =?utf-8?B?TXhHQi9yZyt0eHQvT1psc3FvelhtQ0hDaHZqMG1LczhDdjRlR2lQWWdHRW5D?=
 =?utf-8?B?TzBTT3hEenIrazl1V1NVbERxVWZHcG4rYll5MTRJak84NmFiV3UvVjlwYmV2?=
 =?utf-8?B?dUo5VEQ4ZE9kUTNGbWxsK0g4eW1waVZtdGR1OXV2VnRFRnpKUUorV0dqR25z?=
 =?utf-8?B?NnBiOHRXbVpKanJuMzNtQnlWU2pLY2RjV0JSVk1jTmd0bTFTN2pLb0liZEps?=
 =?utf-8?B?Zzg5b2wvNE1EN2JwQU1iRFRzK21wc0wrVDQ2Wkg4Qm1BT0xrdHFNNFVhZjI1?=
 =?utf-8?B?MnB1ZHlyMHp0MHB3Vjcwa3NKRVF3UmJMTUptby82Yk52V0F6RzJGaWFnZ0Vo?=
 =?utf-8?B?eFlTZCt5MU05ZnJub3dtaE8yWjhQaTk2MWovOCtFYmxTeFM5b01lZVNDNklL?=
 =?utf-8?B?TFBWNTdvcXVPTERlZEoxbmd1SVpUazhDNmo1c0tTdXRiZXF3TXdEeVQ0a2No?=
 =?utf-8?B?ZUFsRVlpNUR2b2N1STZ1K3pJMG82REJneUxGSTNNU3YzTlZwZGJNZTFWNVVI?=
 =?utf-8?B?VFZ5TVBVMmVJWTU0THBGekN4VTZ3b2Fna29ENGdlNkR1REJjb2ZFQkQ3OUpj?=
 =?utf-8?B?UnlWeXk5bVJKcnRaYXF0NUl5MDlIUFhUeHFESlpjeXRjSVV6VGJheGttYUtz?=
 =?utf-8?B?eFF1NjZhM2hnOWxMa2NodlEvRUk4RGVYUmNJZUI4VDdRRDUyNjZRRWF3aUdy?=
 =?utf-8?B?WVVqT3JKVllRMkx5ZUJwZUxRNmFRa05hUitlNFgrSXpTUmN4YndjU2lwM1c5?=
 =?utf-8?B?aXhTWDMzbEc5cmdkZ2hWNEg2VTRqQzNPSi9PNmw0YVpwdittZ2xJdXIrZGRp?=
 =?utf-8?B?VDNFWlR4UmpXK002cnArYVJFbFJhN1Z6NURSQXc1b09nTmZHTDA4aTVlU1ly?=
 =?utf-8?B?YndJS05VSGxWaUhETGtUdldCUjZTTXZwMEJ3eUxMV2hZbmEvTXkrVlg0TXdH?=
 =?utf-8?B?M3pXWmJsNEZYbmpWMXpraEoyU0lhRGd2RVJ6U0l0N0VBNHhMRU91Qkw0eWNo?=
 =?utf-8?B?UEwvajU1czd0aEwrclZBcTJlNGdsaGdhaUhjT3dKQU94akxBQmp2bkhrWWlk?=
 =?utf-8?B?S1RVelVNQ0paYnR5VDhRK2FlZWV1QVk4MVhPTm1URVJDVVFpQmxEZFV4T09n?=
 =?utf-8?B?LzVaaDBGaEpjYUZnZHZMSlgwRm1vY1h6MkVEZ0xXa05mbkVwOXMweEFkb2dB?=
 =?utf-8?B?Vmd2eFFpUSt6RW9tdkdwYktJYkpsaC9mN1VuN2QwRnE1S2ZEQjQ4VktVT3pP?=
 =?utf-8?B?b1ZOR2dyY2poVExQT2pSZUU4ejc0dWZUVEZRc1Rma1Q2SnlmUXM0eVZMSlQy?=
 =?utf-8?B?MkJnbWdNbEJvK2x5MVNkVjUrQjNza2N0NkUxaTM2WnR0dDU5K3MzVnJZbnRj?=
 =?utf-8?B?N2QwUzBLODN3Mzk3czRRNi9kVUNMdHZvdGN2UUVCaVUwMFM0VW9Cb3Y4Ry9t?=
 =?utf-8?B?bFlJZDhJd2prZ3g1YTFpdlM2ZmhiQ1ZOMnlNTjY4NE5Oek90cEdIQjgrTXkw?=
 =?utf-8?B?U29SdTdGbGQ2aGdsRVJ5VlRGZTYvbE9YNHBHcDFReG8wRGR0Sjg5RytYdnds?=
 =?utf-8?B?YlJCbHlTUkJrSnpqU3BCWmJIc2VJRzhMMUNnbm8yQlNNT3lJckgvWVh5QW9w?=
 =?utf-8?Q?O7c+fQ6ziiy3D3LNxR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3a475e-818a-4c0f-a17c-08df19a1ac8a
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:08.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PssYnXy8RyfNSXXkMcjJYkv3hE9c/lVRK6B50+5KZoign4cw0AGwR7BeF0Kgm6ra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730

On Tue, 15 Sep 2026 09:38:21 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> arm_smmu_setup_irqs() can leave the PRIQ without any registered handler if
> its IRQ is missing, its request fails, or the combined IRQ request fails.
> These paths warn but leave ARM_SMMU_FEAT_PRI set.
> 
> This function itself would then go on to enable IRQ_CTRL_PRIQ_IRQEN, even
> though no handler will drain the queue. A later patch also enables PRI on
> such endpoints. The caller already enabled CR0_PRIQEN before this function
> even runs.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
