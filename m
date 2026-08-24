Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DD18DB01;
	Mon, 24 Aug 2026 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613779; cv=fail; b=mpOJw3sMvmqz5LvxQfRToHqyUkRmG+sC1NJKDxynWyQ/JrLPnvY2jSvclW9A+ljlmPZ3LsZURMwQlfmLdw+4MP8geoSELSvn0H7DtmqkP/3teoTbh94A8cHxl/IxaUNmmB4U3SVr8Od8XchjU1ly1xSJpNU63oRlSiRfWW1yQQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613779; c=relaxed/simple;
	bh=gJ853r4ZalLFr6tWnWeNeonQ3utqL5V3IXOAd8gvxFM=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Gwh2f+DpJAg0ivZbuuJVJPCKAkwkCtC+6nB7axUtlJ0ybr1Tv4frtqEGIO94j57VbK8Y0xmNO8mwIwX3S6dHIAnMvrWvCsf+6O0hD/KDWwUGICFVciQRcCVRQJVt9NeVG9N1rHL5OCaiUs1VUnxSinpmWqfZVppH6ZjmjXtH534=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cDlN0m/l; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cDlN0m/l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au1TQQOUY+pHxDhKUEYJtWBFRABHlVy8Qh/NAzEv+Dyimt3f7MlBXxBHM1cqSCMyTSwSsJ1glOMyD8+0BOtuGTswR7CmP59l6TAHlhxb6rb+jEcEZ58vgDo753PQJqoXERq+X7rS7fSH6VrOMsUNkwBMfXRdnGXYj7v9vq+GJWJKZzqU1OXVf4sFkjc9YoNLRdtFgRK2eHTJgG7+yrZiuyiPMOea/Wo2b7DinhOFhAXUwTOowQ6s3EkJ8V7RwVFWMWjaPqLWzV3p7KTHbh2+WDP39WHzyZNXqS6edSwd3pSu3Be97jAnZcrx0O7o+EjpAvFgHJS16Xqu1kv/J4ztGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDoSfNA65PTsbWqi90hzJZrZsWdSu1WJvNjeNYX/nUo=;
 b=lc/gPv4NFBm2BCTtVt8vS1ckQk088t4F70sX6p3GsOJmPgT0foXZWnjUb5u+5QRERC0XlE9hkWGsLsaLCt1vF+nM6ZgF5AZAiceZ7s9zb5i7NA/lBlJ6eZYmy5HkU/6SmszA7k5/aZTGAME+ll48GYOb6tqqBjC/8mi8yrZC9c4K9z3GgeqWxPK1jS67woBZndLsPF0bZ1XF/xvB3sp1zAT2K/6GCCn7Ovurcols3MmBLKO1I3XMX+AYIPtoxlWIEPDAamt11Cjc+eQO235qrbR/mEHtiwU7i+nY0KOiWXy1uUsEjT9spDlHLzTA760CKV53PVLMyZxUZqE3ma+/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDoSfNA65PTsbWqi90hzJZrZsWdSu1WJvNjeNYX/nUo=;
 b=cDlN0m/lkvCN8b1ui7K5yluX5od6ctOWTKUSGGVeG75ISSnDVyeUh+P/VwpSFs1YR75cEgnh3zRyS7E2XTQ50qV36FlBBrVlFJ4DcjqzSMZgvON5epyF2zCeOCy5gCRkdzE+jDxzRx6Vwb3cIW+N+aOcwtSGCLDt/G2xYDSsJB72fe1zJsYPdYx6UTGGyHkejPecRI5rf/FWk97ez2Y2u5wXhwVykUccBxhPl/47wYHat0tK9nX8vTOWf2fk6FNRCdIfAy+r3Xb5zLNTWvZ4BstokvhdlmV6/PJyOC9sSDbsHNG9C+iUB48d4wkjCcyQQRMuMCJZpzyGZb2dORjgiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 23:22:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:22:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 10/18] PCI: Account for ACS egress control in
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
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-10-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-10-94426b96de73@nvidia.com>
Date: Mon, 24 Aug 2026 20:22:50 -0300
Message-Id: <178761377056.3197084.2573998749847027711.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 3384977b-8d91-45fc-03a4-08df02369f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|56012099006|10067099003|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	s45UKChzHxI0XoF8bFZqp0MYhzrdZ/s7TQrr70EXi5a9H1iNPVJaUuJq54UQIu9LC+CoHQiuJXybfAEpMGg42Z0z/KNU5yMsBjvldFhnZidOvGWPa5qeFvKYMzbIeC3g5g2J6qOxbRDKjDimElAAg2UXnqe0kg+rveFK8RBUsD/yKumlktiWGBLMc2dgZ+aCvcuCJmE9XZUkN2R/3hcQh7ESYgnvXmLL2hPvab5l61CbT/0qCMIww+tuyRMfuBZ4nwVJOcAmS07toK2WoIWweo3fY4TSbwBPFoOqVCXoyuoNHHriYQ9W6MReKzFiGVdIRNW/rHE2hGU165FUNGbNQ11ECNB9ehGrf6EkLYxVNfnkO5NjU3mEb9z1/mcgVh7YESdfsIOW3/R5uis+hItwLQYHrhty2A6K/8M4juFC0irTp3UzquOf/QamlfOOZczyZlkCjuJg2QhmSf6GfzuRp2z7BS8Db6CoEf4LCn2PBHn6pLBBAeiTfUy9f6kbJfmAxW5Oy3UcesjKUEvfreIQAeoE8opvbH7dg26lE2SZ0vqt8i4kZy/5TdnuwawtJygpLt0amyBRIoAYVymy6yGrK6Bn+Mf5u8q2cO8xAqB9nXDDfHgYh+XSoJC+J1gKai72QW9Eji7Bmh7Gyc4HlbdS7+szFCyBkwv1ALFKpQH43GQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emdjVmg5anh5Y05GTlh0ZmRhVG5qeFZyc3BTSDFsTmxuMGhRaFpWUG83R1NI?=
 =?utf-8?B?NjZzcmRJamRDTG0yd2dEZ29YU1JONlJvc1hzbkdwN3ZWZTk0MStFVUhoQnJ5?=
 =?utf-8?B?ZndqdHVqam8wYTBHcVNLS1FhN1dJTzF3T0xZU2hwaWtuMzBtaEpGQ0xxbXJ3?=
 =?utf-8?B?Tm1PaktYT29VK3RQUjlCWEtmSUp0L3pVUExDMUN0T0FTL3ZPN0Z1YjhzbUZz?=
 =?utf-8?B?aWlPa0lPdW1ORnMrVFB6UG1iQkJQQWF6UkYrazI4OWNDcmo1YmFiSWgraXZz?=
 =?utf-8?B?dTYyRGVqY284UVdGNmF1M0xtNTRsamxna0lpcUdFKzZqTzc1ZGxGVDZjY0Zp?=
 =?utf-8?B?QjdIb1EyY08rUFVjeUJZbWV0enU1cmpSeVptTTI0eHFiVkVrRTlnQ3loMXNm?=
 =?utf-8?B?TkFpNVFrVml2NHp5cTZqY2d5L2hOSmVBNUNuaVdvenY1T3ZGZVN3c1RKWDJp?=
 =?utf-8?B?MFRmdmhHK25PcjNTWDRNbE9SNGRjODhoOUExTVVEbjY0S0tkQ2ZBUEc0dXh1?=
 =?utf-8?B?K2JkQlQzdUhhMlRqREJzU2t3R0VZVHFnRTFnNzJ1U2xuNTc5WHhtcTNmWlNK?=
 =?utf-8?B?V3B4M0w2eks1MkE0NXlYTUVCejNDeWoyOUpHYTVKU2Y2K3lERnJFNHhzOXNF?=
 =?utf-8?B?NzBzNG1TWkFyNmYyVUI4ODZkSmtsVlJiZVM1K2NZOW5WUE9MREVLUVNTQnQv?=
 =?utf-8?B?UFVzU3UyMG1pSDZEcnprSTFXdmtFRm1hWXBBY1d5RWg0UWJMUjlRakNkTUNQ?=
 =?utf-8?B?TGp0S3BvNk1iRTNsOXpUd0ZZR1YvZWp3SDMzT2pjWEhHMEVlSnh3ZkxnTWE3?=
 =?utf-8?B?TVpGYmMrLzZ3R0FsZHd5VEdGTjdvMkd1ZWRYZU5teFYwcm5aWDBSNWlLRk8v?=
 =?utf-8?B?OEd0cVk2QmFpRkNobVIxMEwweDArdTBad29nR0t1ZUl4OVZkM2hTWTExYm5Z?=
 =?utf-8?B?eTVGZFNja0J2T1A2ZFpobzRPK3RxQTYwVHc1Q3k0VW4xNDNlREd3T3BFU2d0?=
 =?utf-8?B?bmpZZXpaSjB3VndCMWJrQURTV2RqaDJ4ZEhWNHE3cnpZd1oxczM3QkVWLzdN?=
 =?utf-8?B?NDRYNjFXWnVJZENRZXBwUUM5dHNHWWxieGZWY0ZFeGMwSWJYdkdRUDlIYkN2?=
 =?utf-8?B?ZE5DTXlyZUtvNTZkaUNFcVVGMkZhRlQ0dGhGMENYSW9aMW1VM3pQZVY4eFFm?=
 =?utf-8?B?M2hKRWExZkZ3T2N6YWozQzNETFNlUHEvdHpGcW8rNTdiUGFLdjRLY1JuWnBI?=
 =?utf-8?B?TWlQcHFBOE14ZHdqU3VsdGVaLzVlalk1S3pwU0RBdmdtV1dzNHdXWGh5czBL?=
 =?utf-8?B?Sm94NEtPcXBUK3ZQRVBXbWJON1B4V2xLZGg5ZVh4V3FMKzF2Wm9GMENWU2ky?=
 =?utf-8?B?aTQ3NFBRS2tyelBXOE9yczVINytaeVVZbEc4ZXl5L3pMaDhYRGFSV0lsNWF5?=
 =?utf-8?B?VTM1aDJlcGcwajlRVXh1WTVEa2VmNitUaG9LRGVJdVVBcXZsRHNPK082Y3cz?=
 =?utf-8?B?N2tlYUNVQnorYnVYdTFjSjMvdkF4VGpNdUVaZGw0NThPOWNWUnNNK0lDMHZ1?=
 =?utf-8?B?OW5Mek5sUThyVFAwMCtuVmRSdDVnWUNaL1gxbDR3QnlMdWF4akJkWUJDZWdk?=
 =?utf-8?B?UUJBWGVaK1YzNVd3ZlBMTDFQSFVYTFpBNUNhUDZ4d3VVMGYxY0hZUXZnZ3Qx?=
 =?utf-8?B?eC9tcklOdVdsUGx2UmtpSEhaZ1EwODB3b00zaFlsSVAvQlZ6Nkhrc1VKenUw?=
 =?utf-8?B?SllSd0V5cGxCa0M0Y2swZFRFcThaVlBQUWt0ZmFwc2ZvWXJqSVhtV2ptcGxw?=
 =?utf-8?B?WlY3ZHlpZFg0Mmt2WTRIVWM3TzFFNEVBZS9DM1k3T2JCNk9YQ1EvaGsvb0o0?=
 =?utf-8?B?N0REaUZOWFZCaG8yaWcyS1NvTkoxcS83M0VCVko2dUE0TC9ZZ3pWNUdwNmpF?=
 =?utf-8?B?eS9CM0NreVZabXY0L0hFOUYrbzVnOWVHd08vRmJIdnFuZmdYbUtTOTVCR1FY?=
 =?utf-8?B?QjllNUdkS0gvZkFUMW5teG1FMTNaZHF3bnVTQzJGYVhNd0NXbXlhS1dId1lT?=
 =?utf-8?B?UXVjTjlxTmN6ZWlvSE81OU9vMnlDNEsrSk1WMzdsaEpjODdSSzlpcFlPcnI5?=
 =?utf-8?B?cGZFbTNHQXRrTm5EOWJ1RDlUbllCd1VsWno2Z2RHOXpsbjdhWEpEcWJ4d0Vt?=
 =?utf-8?B?aGJiVVUzcW0yaDA5cWsrOEJpVzR2bXIxeUtYdGJHcDYxa0dFSk0xRG1pWTlC?=
 =?utf-8?B?OHZqMzNsYWxiSHp6RC95QTV1RmVUa2MvNGxzbWZJRjlNUTIrbkI5UzVVdHlH?=
 =?utf-8?Q?/wsIhR1kZCwEBhMIYe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3384977b-8d91-45fc-03a4-08df02369f4b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:22:53.6824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOpXfQm+PUN9wygmJfe3yZO/pDGEL5LTbkf9RHCKKU8E/6v3WStkxkktPF9xJiCg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

> pci_acs_enabled() treats P2P Request Redirect as effective whenever its
> control bit is set. PCIe r7.0, sec 6.12.3, table 6-11 lets an enabled
> Egress Control Vector override it: a clear vector bit routes the request
> directly.

This may well all be correct, but I'd prefer not to touch grouping in
this series working on p2pdma.. The grouping logic is already not
doing a good job with the spec and we can't change it because it
creates regression.

-- 
Jason
