Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894696;
	b=t1xbMoJVhREaPZCGECfUD2U8BhAzpm8NWBRg9LKtO/jNmr6QrgXCbMS35nwW/udDzGs4
	 z8QI0PuiSg/Q9L6nhXUMxCoBAVqtnYvbl1xUyxZ+/WGZMnfUBZCEjBQczVYMl/mHPv3jv
	 pG/VNDbpWWXQt+jMxmvS4BII0g3g0mdGS03Tx3RG5W2sZTwINKeiYM6I0W7ITJ77L8HjV
	 f3pjs0xC7zUecWUwGzFCS9uxh8WE5MCIw4evtnbqwTnQGVWfPfYOTca42CA3UAjqj+C0N
	 eQNrvVBHUI08pYKqS1aYGgo96tSUMHLuJRTFMjsfKIWzZ/nrN7yqGOJh7dRetrSu3+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894696;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=hdzuTwXcOe9JFuLnZVbVc79gmyGxUqAsLtXgdMwFR6A=;
	b=e3sstW+S3K2PYLdu48sJqTe+Zxy9knXGiv3xKQm8yi2dtu/KdtmTJ4hXOVCxi23Nm84V
	 6yS5moEaC0kMNF4IZDnSw1bXh01GdeegjvJyuJY3KvRO+3pUnztYox4+Zb4ozKaQOOHo/
	 E74OdjNuOFvx1p8NPBA75icysYGS3OjwsUE0Ezd88t/wFbI11Odp8U00lj65G9kFCCfBU
	 A84cDfQfLpYOmunDkyZaCT+MeFLpkFkLZEOD5Cb0hBYalsRyhQtity0xaah6DV/wds53/
	 HkZbO73Ulvtdn3gXKEB0Rkef3+gaSscHxZbgkl1JSYmsiOchq9wJXBMuF2QOg+Dv9gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fXzpQjK3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.31
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3EE606A33B;
	Thu,  5 Nov 2026 16:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD3EE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fXzpQjK3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GO7yIFqC5xLur358zGTJ3XsVsJ/p0Td28rdpNCSspqIHjxjsrWkdnCkqIdemc3WHncTm9cey1QpgtDZI0omLLhGAB1gIJyffvO8mmMJSruJB8PdJEbkkTGF1z+hh/QOJGg78pG7LHXVEDkHGFxpAJEWoGYBmJV2i1aGzOrzdSALJrQWE2M/pgryaripeOqv5Xow/zfT7C8C8MbccKdG9WKh11Af6WcJaXpaSkcGiLjn4N0uykE5tG6En8BZfFN5aIzzyafvdSC5w7RmvC+rGwbr/+RBlcflTb3N+CziLK3oUd0uiTcbeYrPHmKGWALpumIafKRda0U2D5BMdnf/LcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdzuTwXcOe9JFuLnZVbVc79gmyGxUqAsLtXgdMwFR6A=;
 b=hwhR4qal2OTpAL0e8reB5ZFrQiQ/vyRkTvw/WT90LOM8jwi5JRI8qUy1uSYwzjWYA+WycuaNFWV5WWEO9qtTwCiCyKLoX6Q9QUX4tHkUsOEDhneBdt0/+dTTXhp3xECJAKZQBHrt1drY9W7zNjKrMSLwbWDUBGWmBtTIQysyp2MMDRcT2qmmsYJM7pUR8aC+6hrMIVneROSK53W/l8BqkEWdAA9OkXIHWrqZhUGGjVslCTZH5I7Ey3YqHohnH+qDLDba8qKlqV8atvbbjE9oMONyYq3PcxgA4mAf7450qW2qlTGd2C0QPi0h33qIAhFNSJCBOJpBqunoHRKoHsCukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdzuTwXcOe9JFuLnZVbVc79gmyGxUqAsLtXgdMwFR6A=;
 b=fXzpQjK3hXQ+dfhM0mBDEnooWpzgM38xrXMBg2mPeY6VSTa+YLrMqDEDJCWp9ZjCsavYhZ41Ca+RAHbDI8ClhjWbsHECwl6/Cc9bJEJrfbqlJ4jobZ3DuLAZcPA0AlC4NRhCI1jDIois9eZNo6vg9N0/8Ie9cDEwOFRq5mJ/OzfrREgjsKSz/T1NvetBXXfOkttYSPBy9FEVPDMViXjk4TrtmhQq0NYz5kj+Al519Dgjg8G5BIfAV6Hwp+1foPes3+QwvYiQwa6+EinC6vE4HmN/4WGBHZ3E4cQPAD3UqnOWz3XzUkZRGrIamYlqdde3ISYiZbCVYaVKD7Dy6ca+QQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SA0PR12MB4462.namprd12.prod.outlook.com
 (2603:10b6:806:95::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:04:52 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:04:52 +0000
Message-ID: <f6b34d25-f56a-4022-9d16-4a11f5a7f054@nvidia.com>
Date: Thu, 5 Nov 2026 08:04:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 11/18] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
To: Li Ming <ming.li@zohomail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-12-smadhavan@nvidia.com>
 <d581f2a0-dd9e-4d0a-bd19-639c1bd9b832@zohomail.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <d581f2a0-dd9e-4d0a-bd19-639c1bd9b832@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH5P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::13) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fec8237-50e0-4b98-311c-08df3b568690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|921020|11063799006|4143699003|56012099006|261022105027099003|261009223027099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zBYxOBBx7Ai8/4jqPFrVyL977vX75x+VGwZRCw8J8o3pReHdyKAoIYkk607OI8LBDmw5U5+EPLWRZVw5welv79Kddou31xMfaBYEb/roaCw6iYaLYNzMNmSjRyDKQrwvYUNbmrP9q6zeSik93ai31Uz/6yBpQo0CiCKr6Nztue6/MxdLJ90N+IARufjwDisPS5xokFTlSpqwhevSH9PObGG7mwOl/iRlLtmFScAFrKKQfO+PZ3p7JXYuMOWkyrD1LuScbVEkTTpAkjowa8FVdrwAVKgvY20dl93utNYT4iXVy8X6cTtUX3od6/5z9IATyj0OWArkEX6pd6lSwwlTY29L0jf+wOjO8Y03m7Zd9/clhKwDSJjMRN2XGvY5pW1FNalLOy1BgWJ5gMsP6qUr+EE1uqvc2kCHU3JKvfSByckGxyGv196TyKdILMs+pFed8qo2RPKjgdz7/c5a2+1LBcH9W6qn6GByKmoF72YSytqOHHWv7rnpnkoO/WD9fqVnU8jstYEIVQSjFTV3JMNhRiWIhaYEDoK72GTJwG3Bgz/lkqfSO/R3Pubp0Vv4Hh+f+9p6yM0IdnnrLLG9ha6pYfH+kh8jSXJVa6xSl17TZqNTgCHQVsw2f01vJElNdDHQPyFyVCShAs0fSn3uvYAmjYyqPMAOeFQMEDJDVZ/kbbSA6duHo04E2rGpUhxoNQ36a5ckD0Qg222hiVoprM7TTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(11063799006)(4143699003)(56012099006)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHdPSlc5QVBvd3dxUXowRG1mM1c0T3FiWHZTTDVCMHgwQUt1VEhEd3NkRE9T?=
 =?utf-8?B?MU1VNmF2Y3RoTjZoSlpJeUY4SVZ3TGdsaEhtZUljWFd3QTBLc3Y5L3JKdzFw?=
 =?utf-8?B?WnRQdGpZc1VMM3dyRUl4R3RtcTcwdXRKSWdXWW96RFJ5K0l2T2M0c2NSQ2hX?=
 =?utf-8?B?bEZaQzc1Qm9lZ0x0SnMweVM0RkhHcFQzS2lmVzF0L2daSlZhclhFaTdhM2Zv?=
 =?utf-8?B?dFdpUGluWFVyZzliWUpwSUxaWUpvTlNOandWRTdxR241Q0xmdjd5Z1J0ZXZ5?=
 =?utf-8?B?NzhwcytHclRxbFJJNEliLzJlQmhFNlBSMUxZdEcyRHYzL20xWG53OUQ5b2M0?=
 =?utf-8?B?bVk2VHdFZ3Y1WEtsT3hGbTkvclg2WDU1ZXl4RXFBT2lZU0o5cWVkWVI4MGR0?=
 =?utf-8?B?dXQ5TDZpVmgrbi9lMXR1VHZDTWpnSUdIZlRxUVBtVXAvTzJnbmlkNzZTVlBh?=
 =?utf-8?B?UHlrOGx4OG4vUnhIUkJyb1RYUGw3MnBNSEdZeEdJRGk3Z1QyM0tiRlZlaHlP?=
 =?utf-8?B?T2JKc2dDYUdwU1hBc0Fpb0YwQWdDdzNhMGVWZ2tyU2txTW5QaUNpM0pZdnNH?=
 =?utf-8?B?bklLY0g2OW05MFhwNVdYUk0vVWZOV3lsYVQ1bFlHRkhKY3kzb21PZ3FncW9N?=
 =?utf-8?B?K0VaOVNFQlMwRmJFYkY2WmxTc0J3Mk0zUkNzVnJOTmU0aHBmWTZUci96VmNl?=
 =?utf-8?B?RWZpV2R6Njl6RkpZZUY4eEJwUXdtaUVRYm9FdVBZbFhwM0t0bHRXZTF6RGVL?=
 =?utf-8?B?NThYeVpsYTRmTEVXVnJtMVp4SmUxNEhLZUNHeVJQeStMY2FFcXMwdWpiWTRX?=
 =?utf-8?B?NThETjBEWUtuZ0dFQTRyUDRwbjFndW5UTDZoOTdyL3R4YWgwNFo0dDFMbm1r?=
 =?utf-8?B?SDByekZCNkJHeTVka2I5TFk2dmdsT3lVWVZOZ2d2TmExMWUvQ3pydDlENzFW?=
 =?utf-8?B?Z2g1eGNJUHV2T3RIVXlZVWJ1TlN4bU5EWWsrMnF0Y2xZWnZRMmJQWTV1UDdn?=
 =?utf-8?B?dE50SEVzellLMzV2TXo5aXk0aVhjLzZBanU0TlUrdFJmTmtKRVVmd1B5VXYy?=
 =?utf-8?B?bVYzTzMzd2hjd1p4WHNBWFJLVmNhOENnU0tvQUpsb0Q3VUh6SGhCQzd4dmE2?=
 =?utf-8?B?djhESDkrOXVpYm5BajBOY3N6QTFXOG5hWE80Z1NNQURaMFBOSU1IV2NmSjh0?=
 =?utf-8?B?NDZGcEdZQlo4a0RhNGRPbERFaThYT0JmYVdVZ0lnWXlnOVFyKzEyMUlHYkd2?=
 =?utf-8?B?VTUvYldoOXA5QURGY1lqRVFORFg2VXlhUGtOempRVlBmQ09xYmROMmFrdlln?=
 =?utf-8?B?RENsZzhOZHMxdlU4NnhUVFUwNWI1VGpXaEpXL0ZZK0U3aEk1YmpldWRSMmtR?=
 =?utf-8?B?TDRJRi81aVgxbGRIdk5mSnZmTVlYVyt5TXBsakFwdVhrc2o2Vmp6eFM0d0Nt?=
 =?utf-8?B?VnZZckRqazRmUGRlNkNWV3NLN3MwWGlyUDNHZTJxZmVjTTF4aHFNdWJtbzZL?=
 =?utf-8?B?QzFmcmRFL1BYNGtwYXpzaU0xT1AxMXFSYTRMbVNNSFNER2UrbGVZdFVwU2U1?=
 =?utf-8?B?TnB5MTQ2OFZ6RVRSaEIrNjlrOVlGSWhqOVpROTRMSnJzeWFMVnF0eG0xdzla?=
 =?utf-8?B?WUY3eTBTd0szcW1SWEt4V1FIYWhiK2YwbGQ5cFVLb3IrVnBCd0JubDltOGtp?=
 =?utf-8?B?K3QrdVB4MjJvVW5FMFhmTnI1Slcrc1d0N0E1WGZlamZrR3dmWjhTVzluOVRy?=
 =?utf-8?B?b3hKNllwWUxObEd3TlFKN0k1RTBqTGtNVnBNWkNVY2swU2RSV3ZiOFNXaEZi?=
 =?utf-8?B?cC9aOXZBS1hDMFl2NC9URTg1cFFJNjRaREhFY1IrOUI3NVRJM2xGbCtvVWtq?=
 =?utf-8?B?V1QyamhZbm1FK0JTdUViWEtHQitaSlk1Y2JxTVVyUngvUmFUR1NsVTFydmxI?=
 =?utf-8?B?WTlxYnVXU0ovWXAxVXZQTkM1eEMzM3FuUzRUQk9KdHBDTG9HTU5OMlBZRFl3?=
 =?utf-8?B?T2JWVmQ1bnJwaC9aMWlPRjlHb214clNYTkhqd0hjbXlCQ2JNanVzamJuNjJR?=
 =?utf-8?B?Qm1FTTJyejdXUVFjMnVydDRFN0xQTEZjbmUzVzhVWS9mZHVZcWpaOUJJdlhM?=
 =?utf-8?B?djV3eVBubjYyZEFheDZrcVdjV242L0lBY0hlV1p1RTU4WUtreHJLbDU4QlJw?=
 =?utf-8?B?a2QybXpPWTI2aUdHVUlNOWltOE53Qm1qeEdrME1OdVBYMnI3dXpBVnVYWlEv?=
 =?utf-8?B?Y0Jub3ppNVZsQ0pVeERBdGxPYzFxdW9EdGNSdVJ0MXJnZjdNNXZNSVQrcWwy?=
 =?utf-8?B?TTUxenZPcTNBUjNTaHpDQlZxZDBwNTZwMVJtV0d2SllOSGNiUnVRQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fec8237-50e0-4b98-311c-08df3b568690
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:04:52.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztZn8Me52p0UqGzkq8les6ch1Sa8y0yhpNTQD/1zZwnN+eLr3UK7wdFQVFLqPfXUjIliw/pDyzt4k9tp6qCy6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462

On 11/1/26 11:47 PM, Li Ming wrote:
>> +/* A published cache is usable only if its HDM register block was 
>> mapped. */
>> +bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot)
>> +{
>> +     guard(rwsem_read)(&cxl_rwsem.dpa);
>> +
>> +     return *slot && (*slot)->hdm_size;
>> +}
> 
> Hi Srirangan,
> 
> I raised a question about why using cxl_rwsem.dpa lock here in v15
> version[1] that may have gone unnoticed. I am still wondering why you
> use cxl_rwsem.dpa rather than the device lock here, if the lock is just
> used to protect assignments to info, I think device lock is enough,
> cxl_rwsem.dpa is a global lock, it will block other flows in CXL
> subsystem that are unrelated to the current device.
> 
> If I miss some cases, please let me know, thanks.
> 
> 
> [1]:
> https://lore.kernel.org/linux-cxl/20261011021422.3428136-1- 
> smadhavan@nvidia.com/T/#m7f8d0e51d4cfe09fefcebd93d49dcb916be9198a
> 
> 
> Ming

Hi Li,

You are right, and I'm sorry I missed your v15 question. The PCI device 
lock held since the cache check already excludes other initializers, and
no CXL driver is bound before enumeration finishes, so no cache mutator
can run yet. The DPA lock is not needed to publish the cache.

In v17 I dropped it and removed the cxl_hdm_cache_present() and
cxl_hdm_cache_publish() helpers.
Thank you.

-- 
Regards,
Srirangan
