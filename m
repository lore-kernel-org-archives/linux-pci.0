Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6F33839B9;
	Mon, 24 Aug 2026 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595217; cv=fail; b=TrThjG7w4NTT/i6fEL9lGZfQ65pw/GKQT95DFHNE0BcfejsrBdPmD7ayHdwuXQ2LKv1OapI8BT/NA69lRNLOKqMfMmuxYYzgtgjPC0GpmIiVAhwUNMh+I5EsH3hYhbU5LYyrBIfhUh8fHda9AYbHIsMu1+rCT4eh9RKlcvWXQjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595217; c=relaxed/simple;
	bh=h3TmAn48lVnQEu252tSGhaAAQA76P+V4FMlTuJcMgzQ=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=iK9+tAmXGGYxIOv4ciMT10Z1KCcDCbGsFlgI9aZWEemHedlf9XmNUgV+QI+ailLw9yhrwMQO35wTdlIOjhrUlnR6Xfr1OoaG4Usz+hffsuGJHyVRWtls0JZ3ht0IHuk4QQlUDZMIR+EYZimRIhStEsy1+ZmOVh0arplWnXLhvlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ubKGylzV; arc=fail smtp.client-ip=52.101.193.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ubKGylzV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmrhS8oWL2/0RKshIaMeZVSRD5zxYR/BKaOnPv1i99AWKicl9BL6T1sE7d61VvSF+IObNPDxFlLlDG9dDcbdR1fs9N5hyFYmU0PhKWP1BHTFtrd6w4HhmxhnRTo1tI1kEcvPJ2Jsr6AaSnlzAUWK6cPAgnM19FbKJgtMzxU68TpodZ/hh4uJ61rmrJL9jHSkxRaRzi4Hkt90QOpWlgDXVEtNV5gDfhvMlbn0cmXkSi7zKQ8K6HlXNB7h9WYW0hwdt+1dSfAwfYwfE7/2hv26ChpkLDjBSjQMvu3MgY8Alx1KmUPWbqkq+PtV1wyqFKavkbU0qLMIWAZnzbOInjMcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3kyR1ofF0zFtdY2IbMQIwUtoj/MqL6wkqYlMFd7i3Q=;
 b=ZiPNjlLgszUzMjh9WV60QNIuhlmkgzLXhifPgF+1gk6ZEMZHpZUy49OnrGmOWD8sJ5zag1TofKTjq33aOTUVUKyxkp24aUGRVsdivigyPj8oGa6odQ5kDD7f9SAamjxXLmO5gReClZoTO+M3G0T9lmDtbdyBcVw9CZxrnt3jq4q7cjF4zs02L2CYVVM68hgb38RwbQiggQDedenCu2lUJozgn6nWZhy80szK6Wu0ZLqhb5wxGjn13lR0cL5L+Psav5boBFR5Z6OztgTgbfldJZUwvfrFd1p2C4xO01gJTmYXb4XPn2zwpWD9oUM1R7wZylLmpA+6v7FbUwyRJCqSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3kyR1ofF0zFtdY2IbMQIwUtoj/MqL6wkqYlMFd7i3Q=;
 b=ubKGylzVGtB6RrxC14vcxsqlA7A/Tuc8ZoTNcIjfA6dcOsIyHYeV+pOws+HoZ7JFP10mxeCy4vsCw+GLLS4YneqEfM4cv/w1t1s0dpoYZswOMtECA3wlsaX/wrLTVtZVbMuzH34+EKoIl+Lj4JRL7ZuK6jlYSBnplJyzOFkVNSQssFRncvcsRWKHFOI9IoapRJeUgbURSiCz6RNRDmlRTLs6LRF/lRt1vL4jk9hkY2wty5vrJHW5BWIWVsGBAu+i/E+3f05vZU7rortR95wB//US+ieL2zJbShW4X1wb9kFwwhPIssM/xLTfc5JttRaVyl9UKp4NX9BTJMqy2nNckA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 18:13:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 18:13:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/5] iommu/amd: Refactors for ATS robustness
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>
In-Reply-To: <20260824122347.1588592-1-praan@google.com>
References: <20260824122347.1588592-1-praan@google.com>
Date: Mon, 24 Aug 2026 15:13:21 -0300
Message-Id: <178759520115.3131778.12333086025639368747.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: d52efb23-c6f9-440a-efb1-08df020b63a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J3nnLJdC4B3Rs+smimjpyRJuZqKkkW9K719bhwB05N0CRzg4RNt9kCpGC4wJnzei7669HzeYniM+4SgL9eA05zFwzSp3cD/5qKMgZNvHHMuxXPrFvJ6zo8stNhEffy/LoVKTocE/wWfED7V9ItRDLahn0CXxwLD3Qvc446pbGg6R6GLbeZ9QHxjve/wiM+B94RIBCYue5UMV5jwcbi8137vEJ0SnZ/SEbpQfwwtu3KQQkEoVkCdfVaFZMwuCL5lSTrEhfcgpM06qU+OAWR3U6cVC4Uor4CC2/G89Gtzc0hcrsIrZcYV59iOgdBux9B4YVtNMFsYNM3uAbzYYCCzasIPUi9UQF4f1tDnhDjGtZzqkCkPD51ZLd8lSBhxFbuyHuoe3dJhf3ZLNp1LQItCS4zJ8Ud8s3KV0HobgXWMH0YyiHqvTap+0TSx4Zn1/ZOFakkRy9Y7gDzn2braCaADM3mUf69f+GR1a92TxdOC8dxIqsXI+AGYbdzLcoyvjk5Z1rf77E6LgWflEl5bQngs+SxP8PKb3MWjJlcBCEsbWroEgekAig27LMr1vMQ3RIMSjyROXopFWg9VwSAdAICecCUE7HKdbCXaHEJVt7VWZlLywSG8PJgNC04vtwJ+IAAQymBiYI0dKG7Nx7PnjZ49qtxQ6iWqBabI+AsR8DNX6TMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZExqM1lud0t1OXA5VEdUK2wxeC8wajVMeEd5a05oVllCRnhzbFIwMm1tcUQr?=
 =?utf-8?B?azZBS3R0QVcwSDd2b2N3ZG00eVNCQVM3SC84azI3OU4xSVlIVXBIQXhkVG1S?=
 =?utf-8?B?NXY3ekpmZXZNcXF4akZQMGVLajFMcXhGWjFsL1B1VmZuU0lKbzFwYmJJWmFv?=
 =?utf-8?B?blgva1labzg1UUlUTTMwdTZ0SVFLQmRnODAzaE9KU095M2lBdk55OUZDaUJn?=
 =?utf-8?B?K1F2cWJNaEZnVVA4ZU9sYXE4Ly90cXE0MGgxVFg2QWdmcmVUM0Q1cG9Qdnpj?=
 =?utf-8?B?c2lRUlIrYktZOS9WTHA2QmQ4b1BrNEFlZHJlZXJGTWZaOXpqeldzeWxvZS9a?=
 =?utf-8?B?L2Z4VW56MHREUnp2UE81YkgzRG1NcHdXdkQvaFNkQXV6OWJhTjJtSmNicmpP?=
 =?utf-8?B?aDQyKzZYRDVnZjdBTGdVb0FaVmk2WGJtZkVrS2ZlbWZlMFEzdHlwSy95VWls?=
 =?utf-8?B?NklmM0FTSDFCYmJuVzhJVEdNekkwWFN4MENWSUtyRkNYZEdNSlV3WlorRkh1?=
 =?utf-8?B?cUdiSGxrS3RuRUl0dWZiNG8wU0tTNTRLZURxQnR6UWhqQVVwekFVRFdRTmdP?=
 =?utf-8?B?WW9WR3FMa1NIMXkzT1pOSjJpTzlvT29JMk84UHVrUnp4TDg0eCtRN3grMDQx?=
 =?utf-8?B?OTh4STFlSTVpOFlXdjhkOVpEaml6SkVrZms5RW93TVRKNUdZcnppSURMeTFN?=
 =?utf-8?B?dVhRdVlBaGYyYnRiNm1mWFBWZVRCem1BZTJyQit5bEMwTmNFU2FVUUpwbHRY?=
 =?utf-8?B?U3RvTWpvZlNQRjJiQTRvUGF1MmZHS0FqVFF1V2RHaC9pSGpKSVhwWk9ldFhN?=
 =?utf-8?B?U2NLL0ZwWFc2Wmc5cHB6aDJWb2dFMWtNNVJRRUVqVVBCbzE2eWdwdEVPSW1D?=
 =?utf-8?B?bHljM2krL1NSU3hDOEZFbFBITnVjenkyVzBCZmdzSHk4cVI2VWx1MGFhT2Nw?=
 =?utf-8?B?MFJuNE5JZ2VkQnFxZGhPRVNkNm5NSWFMTVJCdmF3cUVBTkI3YkJna3JYWWpP?=
 =?utf-8?B?QmFTOE5ZekYvc2c2U1VyU01VcDlJUkI5Q04xaDVGbFhhR0h0UmV2cktTeTc4?=
 =?utf-8?B?VTNoeHl2Rmc3WExCSnRmQm5LS0hCOFB0Q3FpN0E1RDBVbktjeHpKR0tTcmR0?=
 =?utf-8?B?aitFU2pDTzJmNWJFdGgydTdqSGVBK1pJNXRYWEFiL1RaU1AzS2tya2pXRmFI?=
 =?utf-8?B?aHZsdkJzMVZZS1dyTEFxN1o5QlkwOXcrbytIVUhnREY5bEh0Rlk4dHB6SXND?=
 =?utf-8?B?Y2F6YkpTekV2VjFBVi9SbkYwYXBCTnFsVGtycENmR3hKOXpxUFNiblFENlRu?=
 =?utf-8?B?bUhFQXR6NmNHU3hsVFZRVkkzWFBnRUM5S2U3RDR0KzFPVXRYZzNJNUg4bURl?=
 =?utf-8?B?aS83QUxpM1MwY2NVekU2ZEl0c0svSVAvT1Y3Z01rZytDSlVJVEhzWk03TFlI?=
 =?utf-8?B?NU1ZOFFta2lpemgxQjM5dkdYRHFUNTRvVElzUUxpWUZQY1hjcWhmcXBZd0dF?=
 =?utf-8?B?MlhWRGMvTks5Uk5tbHBBTHVTdDB6T2YyaUtScDdCd3FxU05haWdaS3RYVTd2?=
 =?utf-8?B?YWpSVlAycWhMbFBqS1NZSXJCdGFScGNRUFlxejcveVdtZWI4Z1YxbGxFeHNj?=
 =?utf-8?B?bGRjUWloMzVZNlFYMjFmcFNwbll2VGlnbkM2WnNyalo4enpGVFF0ZlQzZEdJ?=
 =?utf-8?B?aVdnL21mTW5oaitSSFJZT3BpV0M1KytUamFMTWU4SVZ1dk1kMUZEM2wwWVJF?=
 =?utf-8?B?bGQ5UVNCQkczODFjL0YyTkxvWkdmSFFoTlNhQXRFY1I2d0cvNElJajZoMTI2?=
 =?utf-8?B?d1ZDRit5UVlXVFlCaFNQUGxtejh0NXl3MFRPUWgrV0N6andpRG1lYmtET013?=
 =?utf-8?B?YytwT3B6K3FmSWJHRU1aallkcmZ6T3QxYVprdS9QMy9iT1pZV0tIYmJ6Ymp1?=
 =?utf-8?B?aTZxeU4vV3FrcmlyUDQvVC9tdkYxZ05nVlVqZi9QbEo1TGFPOXlZRzFyaytS?=
 =?utf-8?B?YVBWaTc3UWVWaXZoSmE2ZlJ3ZHBHb0hSMXVDeWtDMHVBRis5dnhMMTVFQXVE?=
 =?utf-8?B?YXFGb0tUTWtjNFR1ODcvdmxjS2tZczJZellGSUNwanhwcnFIc254WlhEYWZQ?=
 =?utf-8?B?Z1ptejNjeC9ZTWJoMk01R1dHV05qYXQyN0ZvQkpqa1pOMzVvLytzQjhjZ2c0?=
 =?utf-8?B?ZTAxYmZzdngzWEVtMXBXZ2pqam9sWDEvQWhIWU1RNGpjKzBORUhpVHQzQU96?=
 =?utf-8?B?V0pocWFtbHF1UE5DNzBIZEVtekJ6d0Z4S1VvOWIySUMxdHNTSEw2bmcwc0Rz?=
 =?utf-8?Q?KoXjMD0e68tmkHaX6Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52efb23-c6f9-440a-efb1-08df020b63a8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 18:13:25.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySVXmtj7wbk38wa8MqyfzKo2diuSwfHqZb75dq//5wpqv5po+CMeO/mHr9cgwUeE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

> [ ... 41 lines skipped ... ]
> Pranjal Shrivastava (5):
>   iommu/amd: Refactor device probe and capability initialization
>   iommu/amd: Fix DTE clearing and rename iommu_ignore_device()
>   iommu/amd: Split probe error paths to preserve IRQ remapping
>   iommu/amd: Fail probe on ATS configuration failure
>   PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
> 
>  drivers/iommu/amd/iommu.c | 199 +++++++++++++++++++++++---------------
>  drivers/pci/ats.c         |   6 +-
>  2 files changed, 126 insertions(+), 79 deletions(-)

FWIW something about this series is mangled, the first patch was
changed before it made it to lore. Maybe whitespace damage..

-- 
Jason
