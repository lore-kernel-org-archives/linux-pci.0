Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793214484;
	b=T1CmAGkWVnWA4PCZbpdzZDsqU+mzt7mWcGAKuzKqBSpI+zOw6g+9JHiO42MXKiXBNqyo
	 Q/rZtIrNceyJVVCpu07LF1bz4+C7K3cvdYYdC5Uhpa2M0CaG6+pT8QZ8DpmW2DzZdKeui
	 9VOHI4zLWJHdMycWuNXrFPQ2N6dwcDJNZLyYTLDNbW1L2nXuOAM8fPYqzZI45dct4ZLhn
	 GEOaFrQe7DS5rMap2hXUb3sXovsp+V1bkvQGuD4Bk73ODvKg668C/E9dlUsDjfL5NX2tA
	 RQzCWfxnL98Renkvi5JCUJl3o+YqTa9lujQdXoIdalg0OwjzFI7p5hTGw0yHR+ptxXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214484;
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
	bh=+7ZlI0hJ+qh1qxI8jvl1Qj6n6rRcH6YmHA3FcX2Dw6w=;
	b=UXZNQZwCsQ2QOIuX/w5Ia+fO238HxrKnqlwlJ+hf7p4z3If+hr9srrJr1Ck+TcELf2hC
	 hkr3HWwDkayOKPU9QLQzjZrFjUd824ThL56zuCTVqlHa3Gl2o+Bf1aH0izlonjl3pYbzg
	 l2C5O+ye2TwTXZ5IWZIW4kiS1F2Hgg/rH8UjpwKDU9C6Sd62SmTxp05rsW1eatgQdvFT9
	 XxyG6b7TfXyS1uPt0n8CcKSr5NbqX716MBepKQhyh6aOIM8esH1w9fggg4f6fPjjQv6Zd
	 wSci0VE4/V08UkwkTvrAuSzRqC5lgT8UssPVSevU0Vp3XfT7nXpJPpWiwCPNHhPX37w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iITvNJ5p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.66
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF9606A32A;
	Wed, 28 Oct 2026 19:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BFF9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iITvNJ5p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqS10qjMZ33HC/ACqSqAMMvDJ4ac8NuFSe4Fd+laR4uk5EAtctPMFEGDInDlonm+8sYHrhWo7SeYiq5Aq6LcfznvZijy3wNGEMes3paVJXzgUUt370JWtX+tGBwkPoJ7ZVIOzXB6UcPT947BuMGMXfCCKBlOZGKqF1YCtu4KwCx1zTxMNB/gayIWhqoyQ29JPA8s+cOXO9EvDTgXzqmlq9ZQ/NgWalG99B3F87LMOf/u18QPUYbBNK1H7QgJpVOAilClOtxEWmKFEpA6tqgH5vUE2ByOTgnwORk7Ug5zonrnY5wJcz3jT7jgOhjf870zj/IxQd1oGXphSyECLjvl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7ZlI0hJ+qh1qxI8jvl1Qj6n6rRcH6YmHA3FcX2Dw6w=;
 b=QH1Hqv9UN8Zq7wwcZ5RKrYWtmyaWi3YDg/iXn1uAsZumpiwoOlwwiGrWAwOKI/TAciQxCCdyZowrmh/qMaHJvrQVc7siLaaYLlmLOEj2TM1pGew5yEv1zVEnXA/Yf40N65Biw65ur58MwZCk8n/VOCc3aiLJr6pkGx5wp5JagxOmLP32Y3vVy9srP6CQE0VndZnoWYWBMjgLKtu4LwTcydi8+wJH/3wJYP1pBJ1j0rPdEyhVaYH7dTA6PiFkwm0ERcpdDlGKM9nXGkuhdDXDP9fAQFZ1uA+5rSBLr/9ZRkGJd9iGOUvwpnt+CR43jxPdVGhtwbluDG5zu7xtPLrAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7ZlI0hJ+qh1qxI8jvl1Qj6n6rRcH6YmHA3FcX2Dw6w=;
 b=iITvNJ5pNolR2UiQaZTet2Uvx+BE6vYWVRi4wiL7E8bgI2uHGUZf2ufyXdh4k5o3LAXK4mBcTcsZ7JLS0+567QjUSRLRyA+rcmF3IKisTMstJ/fA3gw+p5W/7oIzvWV2BKn0k2Wmv8UHFcRl12BClm0Va4WNUva5CR7GFRuYt87aQQV/BAe0n1+51QTrfeL1OZse0pE0e9DE2WO1PODOV9XB22bzPUE5WiiKqPu0NuNsfky7vW+/SLeTxqg9vIkP2+0/kXMhz3yueRiY4Y6bcMbDkYH24IUsRb0KK2/STNcJwppwiY2e84krAAqer3EyEIee2tEan44q8cT1WFEv2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB9027.namprd12.prod.outlook.com
 (2603:10b6:610:120::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 19:07:26 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 19:07:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 08/16] iommufd/viommu: Keep a reference to the KVM
 file
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
In-Reply-To: <20261008055955.4014342-9-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-9-aneesh.kumar@kernel.org>
Date: Wed, 28 Oct 2026 16:07:21 -0300
Message-Id: <179321444108.2412245.11042349815557793096.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT1PR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::31) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d63d5f5-1ef5-444d-5a90-08df3526b2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|261028144727099003|261026140227099003|4143699003|56012099006|11063799006|10067099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	z/ZRizwAK4sO2PYWpUOeI2zn8wg3Zt8U7/poFzw1d0/oFtIQDeiqsjTpH6fYDH9aM2l7odspVJnHqgyMPfdVrFqRJ8aQ/e2prXRgMlbr/McBAVglLjOjDj1Hat1GydpWDFtTmVPwVTt/lzeRPiDiWWc7O8r7847O4wj477jR4JerqGphGP0DXhHUsEJvnUI3J+lhCJhDIus/S/6npgCHWLsWgEgtIYKlbPUVP1gwY4O3fDYvf2JoZQseLlTIzQALqSCIV8DISJSx2ODP/QaW8v66a5ZWJftRFKlqMYWxWcUheC6qNmUjPZBAclYKxQCAG5a/UXur4PGrFBgAnR4iS/WxgsRL0Jw1ddg+xejlTXBWLw6PfLD5kydJeyutytl/GpQlbnb1MPR9UWiX/ZyJRpkzJkpj0aZ+FtjCrdh5BxUWuMSnLzivhECQakQ/sxvJSwew41uJScyXCUfirkx/sfmoOVLKAAQeTZo3p5tslG5h/ApdpLsOpBLHJFfbylm/I/JAQ9DTBwA2mxL0Cxf32pXLrVLAdmFWFTMPibfUvg/eotB0WJAspKGBqzqqyTnpOkOJWhDCn2S2HricnYxd+h+wVeNm9X3vKzYrlCnqSG/Su+EAI2J2M7XOiy/+9FkxgHfdKHsYXSN3FZ4mQIfMmYfuujYWxX/yEtnmd+xB5do=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(261028144727099003)(261026140227099003)(4143699003)(56012099006)(11063799006)(10067099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXhST05qdUVsOTQ0dEhrVnRHTTBDZ3psSGR5T0oraUFGRmEyVG4rQ0daRkUz?=
 =?utf-8?B?WTZnaER6dy9BMzFCQWNQVDR1K1Z2UDAwdU9QLzBaaDJ5TVFqZUMwMStQZnlu?=
 =?utf-8?B?TjJvcUl0SjBTZjJIc3hyaEFiSk92YVNwNE5Jc0dEZHNmNGQrNkpqMjJyREVN?=
 =?utf-8?B?cnFlcHpNdmRMdC9rNzJERWlJUG1QcWxmQ25HZ0ZGMmNrcEpqdDliQmlMaDc5?=
 =?utf-8?B?WUFGcWV6dWM2YWM4NGVQdk5yZkJBZ1BvYUQ4aXQ2SFBHZVBXVDBEeHBQTjNI?=
 =?utf-8?B?cFNrc3ovZk5oU0xyeVhrWTI1T09PWWp2Q09WcFVJSnJ5cGdrRk1xK2RHdDdk?=
 =?utf-8?B?dXB1SnBUSTdDbjNMNzNWUUxnRzJqLzZjTVVKMEVROXJOb0hIVmtrZkt4OEJQ?=
 =?utf-8?B?c2ltMFJMbDBCL0M3b2N5REZGWGtmK1Yyc1pIY1pXYUNPb3FtblVzVVFCY3Vn?=
 =?utf-8?B?N3hNNDNBTnEwTjRYNkREelZCZi8zRzdNNGk3eHZOUmVuS0NHVEVnbXB4Tzhl?=
 =?utf-8?B?MHdmdE11MUFmbTAzSkhUK0VGMGpWVm0zLzZiL1BxaDVLSGVvNW5HNEJ2QmZ5?=
 =?utf-8?B?WjJBMFUydWE0UjBUQ2lJUHBDdHI3VGhLUjA3WEpUR1dLS3NrWnJWY2VsbUwx?=
 =?utf-8?B?VmJobWRTZThLME56eVFDVTc2WUE4cThVTUFsd2RlUWRXS1JuS21SanRTRk9H?=
 =?utf-8?B?aTBGMzdpbkxENlFoUXhidC9XZ25OQkdLY1FWUnRxYllPNDBBUnJobmxob0lY?=
 =?utf-8?B?U2F4L2c3Wk9MOEppQVkzOG50d1FxcStrWDh4MmFmSjVYbVZueVBtQUtPWFRB?=
 =?utf-8?B?SmdTVDNCbXplZ2h5T2NPbEhNR1lybGcxTlpTdTlrVVNyTUlHN1RXWDVMRWFa?=
 =?utf-8?B?UjJESTdBNGpUQjFBeWtWWjVqMUJCdkVWWW9RTFN0OFY3NDR3WXorNUdBZU1I?=
 =?utf-8?B?RXNidWNxVHRpdmpIYWl4VVFsR1YvUXk4dnBUM0xJVUJYbU9xU3U2U0krRFJF?=
 =?utf-8?B?b0JvRDBwTHd0UTRrWUNXNEMwZVgyNkd5a2tFZzdTUUlnV292ZXExdG1hdTZ5?=
 =?utf-8?B?L0tkR0dwcFNrSkRwMzFnREFaTjdFTjdHNldHZEMxaU8vWjhRK3dBT09mOFdn?=
 =?utf-8?B?cm9JY2F6T1BRV0o3QTNZbGJIeXcxaVJmUlNUakZSQmczOUcxTnRqT3pZUEgv?=
 =?utf-8?B?NVY2L0FibXllQXFmQlZMZjI5eGxkdm9kTVRxU3dVMzl6dS9KalZaM3BmL2dz?=
 =?utf-8?B?ZEtFZGdINDdLRFRUR3I0cVJxb2FtVzIzdWFhTmFObVJ6ZWFuUUdwWG1LV0xN?=
 =?utf-8?B?VXIyWGV6a2JDeERoUjFRQXE4Qkd2MWFNVHhjOTlLQWQwVWJIVjBzdmtjcWlj?=
 =?utf-8?B?a1pmZlNkOXFWS3g3bHovekJoSlRhcVhkdlp1QmMyRzdaanlzUkJYYTA4L3Zp?=
 =?utf-8?B?RklhbUp4WlMxUk9RZVNJaXJnTXVnWWhpSGFCRmQ5VDk0aWVCNVpmYUo0SVA4?=
 =?utf-8?B?K2QrandxTXZ6WUVBM1dqZ1lmcytWaVNEM0F1MWE3SEpqOElzR2JNNFFnR3pF?=
 =?utf-8?B?bjE2SXdoUFRRVGE0QXVFcHNoUVc3UXVWak8yYXEraVVSNDlycFZEN3hYekcx?=
 =?utf-8?B?QnVUSlBZVmcyU09oMTNYeG5sMWRxWVlna2JoWVU2dzFYbzQ2WkY1Y1dIdEhr?=
 =?utf-8?B?Q1BPZTlTQjdKUStjenZrQlo0d1lvaUVISHA5YW14YWJpLzlSRnJOdVFhb0Ja?=
 =?utf-8?B?TlZuZmNSNnVyeTRBdzNGUDFNTm5wVUJOWUl3QWQyQUIyN2VCQytFQkswMkI5?=
 =?utf-8?B?L3FGaWFQUm5HazBkMUVhUnpmNUtvWjJhdUNaUkIrcmR1WXNoREZycmZqQ0Rp?=
 =?utf-8?B?S1NKQ2lBRGp4c3ZRbGFaTFMwWnpFTUtIVVY4NEcwaDFmZjRiUEtRWmlBMVBG?=
 =?utf-8?B?Q1VxVXhxaURZbWRQR3YzVU1qeThaaWFpUFNvbFJXc0dKMlZidUNBNWRyN1la?=
 =?utf-8?B?RHZYMVR4a3NWSEJQT29SbktjUHVlZGc2QmRIWDh3eW5pcWIwZldYSUxlRi9t?=
 =?utf-8?B?OWFVeVpublZaZHE1Ulk2QkdTaEVsSERDalYwbWxxWTZpMTc0VlcvWmhXTmZM?=
 =?utf-8?B?TThTc0hQek1BNWRKVTVPbU1KbVNSZTJTYzE5bEoxVnN4eVYwaTdBejJUa1M3?=
 =?utf-8?B?U2h0ZlVIQ29FWnZaOWU3OE9Tb2ZBTFlIRHBUZ2dTRHRQcU9WeUFaNkhGUVQ2?=
 =?utf-8?B?MkJWUGs0YXVwQUx5Ti9GVHJjaDRCcFg0ZGlHdSs1blE5dkRuNEc5cEJ6bkQv?=
 =?utf-8?Q?lvE2KKVtVsVuJ5NTDI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d63d5f5-1ef5-444d-5a90-08df3526b2cf
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:07:23.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJqnmfNdatVeRWfombgt0dxQJUdpbI+nLUdl3+VFo+XfP5CC5bbrYGBRrD0cZhx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

On Thu, 08 Oct 2026 11:29:47 +0530, Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org> wrote:
> The TSM vDevice operations need access to the KVM associated with the
> device's vIOMMU. Save the device's KVM file in the iommufd_viommu when the
> vIOMMU is allocated, and take a file reference so it remains valid for the
> lifetime of the vIOMMU.
> 
> Release the reference when the vIOMMU is destroyed.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
