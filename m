Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9C397E75;
	Mon, 24 Aug 2026 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613808; cv=fail; b=CxiGZrLIheO2vFAF20Uji3pxp6Ymke7F0IYWzeZhEjYpexI/QUzHLKs03SDsm8zAo8gJxfp0it6Cz4lqKspdaSc69qY1Vw1bNLvu8zhqCXabgm5ZIbnvGBH3OO9tcREBPbxI49H+JODZ+sgseGtIY1t8GnzfhfJRXEq5wE196l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613808; c=relaxed/simple;
	bh=32HnMfaN0elXC04eiVkSnyi7paZi+mbU8fA3p0vdMkg=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Gva16UpRnfqWayPhuiGTNTs8LNOAOGbTXnj9Wpjdj7NZ1ZafJ14mNmjaec8JviBzvA1oJ8h/x3ZHB/ZLQVkVbwOoV/Gl5TKCjRrBCu9+QS4ouw8vKJjUcKUxPasKOkK5Fh6DTXzRv7UrbuZIyejuQn9cSK3kxPC1LwhwTFBsWrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O97YyNQ/; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O97YyNQ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTqJXIuMkit1ArGVIw7FY+OkZyq1cxFN9AT0+jhyxpyOnxtfAuO7kuGxIFvJ7CCM6OjB5WaXc/VqXgFKekBEhbH+Xg1shy5NBHat8Rh1CnqMrVw6oRClPxjuxj9mbfdUnpUauP4l/c5FEm4zSaH6S3JCHJVgmMCPf0T6k1t9jzIFKlLHb85/9wxLNJrvdZr99u19snm0o2sCb8QVAqnIXPKqyrZ+cFVO+JkRna5rBcn7vd2K17S2zMc0FbMdq97zNVBLtLnwcIt6qnO7Y9hPS9ImJfBeiswfuIeTb7T6DMzbIAxQwGOzbX9TWAGgnQXGyJsy5AIDF4QicJhsRbOEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djrh/JbVJVHOUvdx64xWgzJzcWN/DMbCyJ2duqAptRo=;
 b=tPPb5v7jCww38zURl3IH4JN2UkulT9dh4ZvmeGQx/sFLYhSykl5dKhVJ9527PyAWFWoA8dIG5xi0JJU+yzDzDVgBr834nMJ1Kh9oxu+vs0nQtZ/eMc2JBNOkkk36OTJ4/U3VsgkKoLPpSfGt/MMf9BeiigYAcHvSzQLvR2SjDNsxtxRYahXTc00iV8lI545XarpLJtRDZgrwqyUHAmpCusc5qjzkcNqF4pgfGGGm4pmIH35ViroxuvUK+4CbkK7gWYOft5xOrH9vdTf6HCj5gDBeIpZhzLgwNoJ1gSwCpo0YpvKX7b4s2oncicCCe3aSWiIjHnq/8W/ywbe5H++28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djrh/JbVJVHOUvdx64xWgzJzcWN/DMbCyJ2duqAptRo=;
 b=O97YyNQ/Ygqwtx6qc9+rWPP+MjSs/Xtqish0egfbkMvgPmfGSmVgP1OHXvuL7ozac0pGHHPn3IoLWD29Gdg7wLTZW9DS5qNy1StlxZrJCrvu+l5lgIiu1WP1lCPpZ5pdBo30hf6R23XnXEiwcyemwhwiKw00K62QRlAcV0v2rd6EqANqYzOWUgBlsSsuOMCYNu36noxZz+95BlwSpG5B8dodXpGFhTckRP/SWcXInrBHMJcEM4YanFY9v4RGaklVmUCEAFwWUTMEN90JEAKDphAkKxBPqYTyx4mPA8n1E6KLWKXHakLhFJAreDbpHgDH4Jb/ut4jo73H1ZSa4TSfZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 23:22:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:22:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 08/18] PCI: Account for Direct Translated P2P in ACS
 isolation checks
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>, 
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-8-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-8-94426b96de73@nvidia.com>
Date: Mon, 24 Aug 2026 20:22:50 -0300
Message-Id: <178761377055.3197084.15973808736458853831.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d41691-aabe-46f0-9c09-08df0236a0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XV2IBvGQVFV3psMBxzfM1C0XDDQx+iSBfH/80f/Q8qxzFYOMsbrFfPFN1hG5tTsjhz8yNgCakxCiwqU4jLQC38GXYJ17RJ0y2ooTJ8Wj2KlB2ajqvJOKDIUwEO8d+Nc1LZoLMYoT43SZzqAtplj8HJuEjGFPcPt12Ih3pYy10wKpK5NVLJB7Yfv5fFuOdhmS1Mnp5WMysH9FRFpd56ZljpkLbrCVnV+0Mxip7O6dxhyrtDbIhX4AU52tl7bDMQwDwijJbi4yOyhhJJqGnLZu4TNrjF0OOyyMQ/81+flTJEapsoyLxnnwICY+ynOhVNSSjR5DKD7GnlSMkdY7Sjsoe+wb8JWSE+tWeaMRt78X6HQdIiDOnML6Bzigi/dQPd2/kcahXpyjdztJEz915w0uYBwxmqm8oOfRz8TjfbBQI+0xDapiTIrZZ0jjBuBHthMRf9J0MBoSzToLMJNN6y9UcYFFJbpl0l8WH72Z7Cjk8Bn+gNeTLnG8F9zAzAYk3yqnIs1DihuW2+9F4W913+zvcH5MTo3iBs1KovwF6dAsOCR91JuSjXFKsCovsqKmcHPho0AtoJWokz4Hx6uDhKsnsoU7wt2F09LshCzcImJ0wNlwarThPEBOLrTP1o8Mpti0vakMWqUZtJ/n1aZSmGtzfXNd9Jg3/CormTT1oMOuOrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTdKbytNbjFBQU9BZkd2UUlXdzErQjdZTWMrNTJoZG5Ibk1JNzlHYUZPMERH?=
 =?utf-8?B?anpPTG1jazE2bzZqYXVOcll0KzIzSmVyYS9TbXN2QXY5RjhPVUo2RG54T3po?=
 =?utf-8?B?Z3dlbmFILzRVbXRkQUdsbHJPS1d6Q290YjIxVnJQTm90UVZ5dVVYcUw2Wm5k?=
 =?utf-8?B?d2I4NnhueTg4VytBcVE4UDNham95b280clFKSGQrMWt4M29OamNPSllYTHV2?=
 =?utf-8?B?MWRxRzd0VUJOZGZsZjhaZkh0Z2p3ZHpyUHYvS1Z2cllSUHhTMUJDUm41V0xv?=
 =?utf-8?B?TGMwZnh6aS9PNk9Na1V0V2liSUwzR2c1aGUwdFAxcnI4WDNnQzArNXp2cVhn?=
 =?utf-8?B?dHRBK3hVVzdRVTdQaFZldG9CVzlzSWUyUldRNmMrTUtUUzNSRS9PSkFpc1JS?=
 =?utf-8?B?RG5CY3Vmc2FGT3pNOFpFUXl2SEltQW1kUVFEWHdvZ3B4QTZUditqd0toSXRq?=
 =?utf-8?B?ZU03QzdPSXlTazUrbUpobnZYR2ZYdUhKNXJ2RDhTaWdTZ3d6Zm5hb2hvbTFY?=
 =?utf-8?B?SFdLQTFIckttczQrSy9Rc2xsaUp5MlIyODdrZDZqSnFTajNKblhORW1iTmdT?=
 =?utf-8?B?RnRPUG04eDB1RjIwTmNnNVRlRHFMNXloTUdEdVR2Zjg2VUJoeXdTaHBXMmVt?=
 =?utf-8?B?YlUvQWtsYjZCUU9WbVNocDdGTFVoY0hGaGJ1RndqZDl1VEdGZ285cTlzeTlt?=
 =?utf-8?B?eHBkWmg3R1ZmS2hTakRpQXpUSmgyaDQvVUltajczR0tlMnRIb28zditvRnV5?=
 =?utf-8?B?c2VIbWkwTGhXb3pCNE81cEVpZTRtUUVVdXVId1N6TnpsaUFDbU5GSzRLSlZm?=
 =?utf-8?B?M0JzKytDN3ZHTGxrUUFIWm9qUmY4MXlUVzZ2c0haS0JobmhjdWdmMW05a0Fj?=
 =?utf-8?B?TFBEcW5lc3hnb3NYRXNDMm5hYjJydDV0RitjU2tjMThSUk90OG1yWnBrejNC?=
 =?utf-8?B?SDFPN3lvWVA3NXk2T2VmcWgzNXVmVTE4OHdDeDhSWkdyNFJBMEJ1YlNEQy85?=
 =?utf-8?B?RWRFM0NjQmF1NVRQaDN3ZUJyRHFFajNOUElRSE55UmQxeW90WldiVkt6REJF?=
 =?utf-8?B?N1dqUmlpZGV2Z1lXVjFDdXUyTWFkUkJ4YVR6Rmo2c2g1Q2o1VjhHaEk0b1hs?=
 =?utf-8?B?UUFDMzdKQ2lsZ0RNeU1kbS9vM0pKS1h4RFZuLzdNZi96a1pvVTc4L0x0WDFV?=
 =?utf-8?B?dUVNM3dOMitnS0ltWlBEcjZrbUpYTTI3M29YaDc2Z1NzRThxTFBtaEJUSmEx?=
 =?utf-8?B?b3BjNW11SUVxMGN5bUMyeEgyTit1TVlEYldTY0p2c2Q1cHpLMElKdjZpelQw?=
 =?utf-8?B?VEhKNjd0VXFXa0FyNWhUc1kveDF2Y3RtN1BjcWcydlk2b1lmWUNrKzhSckNl?=
 =?utf-8?B?QWxlQ0ZuQUlxbUVGTW5xOGxNN2lOdFc5UWVKR05qQVZ5bEcvNXFHQStzbmVB?=
 =?utf-8?B?Si9EQmNOdlBGSEVGb05ZNGJ6V3FBWjcycVRjV1FBZUs5SFNqcU13azZQTnZP?=
 =?utf-8?B?eEVKc1FIUktrYnE2RTRHUStER2NuUTFvZlZrTUJqb29xajlhVTdad083aFdY?=
 =?utf-8?B?d1d1YjJRaElKL3lGUzNtS25Cb2dMYlJkSkNmZTFmd0s1WHR1OEVBM0hZMkVK?=
 =?utf-8?B?Szg1TEpJM3cwbTQ5dzBPaXBNcGFOSm04emltbEpieU9NcFhxRmhtdUxkWlRV?=
 =?utf-8?B?enI1NWxuSVBQRSs3M1dPazRiWSt0UmRNSkNkbTZ2b0Q4bTZvRFNzVGsxRDhX?=
 =?utf-8?B?SzJ1OFFVeUozSE5hOU1iUVkvNkhzeVF0cWZvanpmWVBZSG5iZ2tMSmNBT2hl?=
 =?utf-8?B?dlduRjJhS2ZSeGFTcXd3NzJOWWJ0K25aUjQraDZ3UGJaTWNXL000TkttdEJ2?=
 =?utf-8?B?QmNSUmpKcE4rZFRDZmlWQmdkTGw4aFkvRlVQOUw1b2FZMTZrK1VzUFlMU0hD?=
 =?utf-8?B?QkVPK2R2VkNrcENmSXNaZWRIWVVCZ3dzZDVBOWtlT3VHWHU0aUZmMXFCYWxE?=
 =?utf-8?B?VnlPMnJ3d2N6RzY0Z2hWRkwzc052b1pPMVVheFMzOE9McXdjZXN0OHlITkpI?=
 =?utf-8?B?ZXpiYnR2S2N0Z2psU1VwWkJ3YUNWbXVYQ2JRV3FtSENvRlNwdFlZaE5vWHM0?=
 =?utf-8?B?T0xsRnRzb0JROFoyWjR3OGFwY0RIYzg4QlljS09WYlF1cG1wOC83NmNXOW1U?=
 =?utf-8?B?RU5rYnNiL0hzc0xNSFpxaEZCbG83Yit6QWZMQU5JcDRTNEJ2NWVodzlMSXB6?=
 =?utf-8?B?YW1FbXRldTRNQUZqQWkySTViOHpkdTJNaHpMRUR6bHVHNVNraVRPNlpyS29I?=
 =?utf-8?Q?ldMYzkLmcwpEYZa0Gn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d41691-aabe-46f0-9c09-08df0236a0d2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:22:56.3084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9JNKY1JrdRCalTXew7iWUO+r1yCHt2Bz4BVIOpiB08PsSOq3VSxlsV9nyb94afv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

> PCIe r7.0, sec 6.12.3:
> 
>   peer-to-peer Memory Requests whose Address Type (AT) field indicates a
>   Translated address must be routed to the peer Port/Function without
>   redirection, regardless of ACS P2P Request Redirect and ACS P2P Egress
>   Control settings.
> 
> Request Redirect therefore does not isolate devices below a Port with
> ACS Direct Translated P2P enabled.

No, this whole patch misunderstand what "isolate" means in the context
of iommu groups.

Translated requests are *always* isolated becuase the translated
address always comes from the isolating iommu. We trust them just
fine.

-- 
Jason
