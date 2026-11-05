Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793906025;
	b=H1BuX8tpjxNsw3R7WB3DFn3vjnEUNrFvWJIOs85G+bgCx9tPaK59JbxdiES0kmca0MTf
	 B2cota9aY0e2SXKrJd79TlqVb17DCgRjZiT982cdYBGov9QIq6eLG7f+kIYbocIIqXiRn
	 wzWg6mkITtzLu5tDVQeH3Ic1eQoL+/hWCneC/zeOAvPj7IgSQWZsumhAiTskcJybhx39r
	 TsIhh6hCUMBHvD+02W5GXwq7GnzXWyOSGUnzy4Z8UeDbthpQ0zbNwRzau77oo9xR/FXJt
	 CEoAYLriCMIjWzG/vES28WPmKi48VXq5VWOXD9aC6JJPAb4l+Dvf6bwx7AP6S4rKDZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906025;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
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
	bh=fT/GdW6figLxnCoxqMzuTffBsR2kRDwcttPZq737fr0=;
	b=wiQ78eECQSrcdLw2k+uSFXXSRDXsZIruSUTtPyT7ZkyLq8PWYnlf/SeekJRQ4Budg2Fi
	 AiAn9HsUeBfJgyl3yG6/Ct8PFdRRk6Mhwj4S1IRdy52gR7i4ScqNv+E9OYfOveIPrVErW
	 /mLSafhEuBVKC+QWgyEFNHYHyrKfNzxVadKhcSQEIc5QTI13O8TT63cRlQoLuHFhlYB1D
	 BH+hbmDfA2ckgkBdHhlsuweXCHCjHGJjVJaXqfsDXd6EL/97dm4DJ8bVPAC2wgSY0vZrs
	 0XEV+o13saULZqcmANsGheqtQz0XBBdtvteDc3YasOUBV+I07nukDmCXg908lsHIRhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F24EjW1N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.52
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE9606A31B;
	Thu,  5 Nov 2026 19:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CFE9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F24EjW1N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vG0fax/kYdnwbzd7jhc3MRC9oj5BIWqzgmWUCYhYtcmd8vgfIdnCxvg5MaVfX93M1LVmG6ApPs76FTSYn1MawM5pgXCrDiVt1Eo0UVVNP8/BEyBxIXmxUVoKZ6Tl62zeC0cOPBxEnvrVW62YC4K/vbOPNaZSw4NpNp6n4e69vFItdEiGKRU8jlWsXx/JHBskcLfvJmjB0vb6LUXhGRVAs23D/o03CANtRlCYysOEs8dOIhOwqGG7+uxT5Ba1qsC/NDVzJNZV0O9I6LTJrQ+fmzeml4Ut5eAp4/cUuuf0IFgZAehXqhmeXxiMR2lq2tLd93GMTgYyj6kE97F8EAyZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT/GdW6figLxnCoxqMzuTffBsR2kRDwcttPZq737fr0=;
 b=kh5aj/KQgUrMv88C3GvZecTsVi1CkWVvwW3/fME7ZGPKL4b3nE0aXCZRjzfW1TGsc5HaHOjTrAeOmAiyM9LZShwFvQHeCoqngr5wv45ru+EJBk8vGMpvZFghrEy1MH3cfYaMMydZKTKBCC5M559nYlcCHUOnyygTjFvprsr7VwC8qleaznzy+KTiRaZH3adVRpfKUIyS5qKhVw4Qtcbo98VcyPVaruNkIShAYZ9NmSpumMrrN41ahOZC/3VG/2zI9Z1/GTmYkmMRL7BwCc1WE7/AusPjCofAicxzAaKA59W+MKhaLPYQa8Ro+W/cOQcEc4rdNjSXjQg6nuZAJngZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT/GdW6figLxnCoxqMzuTffBsR2kRDwcttPZq737fr0=;
 b=F24EjW1Nrz0Qizy26OtXtsnLCfE+zgozDp0vNqLrVyW/zZZr2XAS4eLN5nFek9aHOueR74MRgpR2vwVzjneBSSET24zrvfSDB69zGPb1bE/S0Mz49w7SgLe2qBQLB/heX8og1nFpadm2tQRwdxNdoOvRnkScsXhiLjMtl/T+SfUC4whXe6GMbXBJHIrjlM6aNpjS7Ov6H1Y3Y7zJcTJHuVkhrWcTldoBQVyc3jxvIBcweGNKSP+TUn6HeJQxZaFrdsiH6ZSuqI2LUIvPOg4POLx+bTV2WRx/zBhJXcXuzHHJoySsRnMpGA40R0HxcsSI3uqtRWH2OEB5Off4POIKGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV8PR12MB9229.namprd12.prod.outlook.com
 (2603:10b6:408:191::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 19:13:23 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:13:23 +0000
Message-ID: <fb3835c9-955c-41ec-8fc4-3ed91e310577@nvidia.com>
Date: Thu, 5 Nov 2026 11:13:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 11/16] cxl: Validate and synchronize HDM ranges around
 reset
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-12-smadhavan@nvidia.com>
 <auApYR-A3qihqLbP@aschofie-mobl2.lan>
 <370ae30d-8550-44d8-9191-e9638508b291@nvidia.com>
Content-Language: en-US
In-Reply-To: <370ae30d-8550-44d8-9191-e9638508b291@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::15) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: f697fb7a-f848-4c16-f799-08df3b70dca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|11063799006|261028144727099003|4143699003|56012099006|261021121427099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tVvwbHs3815D0yg8+hYQqjLPoXLyGLgI7qFdZPKwKzeAKoD4CaKUbeCmt1CVCvgP0KKWWYcWw6rTN/coPivkJfPf7TilfKLjmHCZYlgJ++0m5Q4KdTD/QE74ZmFpy8HcLwr5e9FQ/PRj5JZSqZZ9y1lnjkc2lpKh2uir3D+TsBYh9cIV/uPYvLRjBsAl9gDGA7c2GfV5ZjgoJrUWhTDC8nmjyorpEPLNdlE/oAAck3+2OoMx+4M0zCwhUkblz2WhP5YARhlzl2LfwsABYzcEq0YBM8fFbVkT0ZYiPWPin+A/Y1/BLM/ZbMBItszSMIbtJBig77JCOuGeGgUItzmQ3qWegszni2uzSfIK6/fJegaKpwoMZrXDgjiwMyaJF47f7kYPR54FAj8AuDp9KgJpv4HJ43B/dXrJKJ2uITG94SKvJllNx9DWD0beroG7/txipKHuvgvWWvwoSUObVOJ9EbgWoi6CPamn0YY3OnaBYirmnVsJYjoad1H4ymdvCKY7wOxTJ0gkwPckP00euI8kGUAYGI8LeX6fV4F7cAjWg2g51PlJ1FUvEGBIfMdiiLdwazdIhtfULpIBX8ZGzMmZPnpXzQl27GepOLhRYxV0qZpqFN0E8ruPuX8wo7qJswgP5Eac0Ya2+l/jE6znb5jYMrAsJ4ZrNL9FmjVyPmX8ChA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(11063799006)(261028144727099003)(4143699003)(56012099006)(261021121427099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE40Nm5Nc3BOSUw0dk5lTy9jTlN3anV5L3RFS1NWZnBQMGJ2OS9ZNlhhMTlH?=
 =?utf-8?B?ck9NR2gyRS85N1o0THd6NGN1cjFSTUduNEdlV1BmaGM3T0JJeGEvaUlPamVZ?=
 =?utf-8?B?RmJham9vWDl3cUFJakFXc0pmTjhwazRBanNtVm55ZTlWRm9JdWdFRnNCQVJP?=
 =?utf-8?B?WFF1ek4reUNiSUc2Q3NzTmVES1NLakxIb1dnRGM4RExRQ3BTY3NLRWRZaFlq?=
 =?utf-8?B?dzl4U1ZnRGpUTlFsQ2xnRWZ6dEp5bFBPMzd4cU9FUzgyVjlVdkRpZFN1WXhR?=
 =?utf-8?B?c0xSM1Y4WWozcDF2QU9TMHo5SmswU3FxL1d5ek4rZkU2SmNUaFRDWmwwRFdr?=
 =?utf-8?B?czlKcXl1ZmZHN2tPT0xrOGFtOGpmRkVjbjFnS1BaSis0aXF6M291S3p3ZzdR?=
 =?utf-8?B?bWQvTmNubUlvVlFTQlhIUHNQTXZ4WVF2NkhkT1RZbk1VVTd4OUM4amxuT1p1?=
 =?utf-8?B?QThaeWhzTUxnSS95a1lwYS9BUVJsdXArL2RUdWRueXBPU3luMUVpcWFSR25K?=
 =?utf-8?B?SG5QVEVKK0F4OFhGTkhUY2p1MC81Y0NyaFFFbGRqWUhxSXg5S2NMV3pGaFNh?=
 =?utf-8?B?L00wU3FheTFHSGF4MkVpUUQyV0doQmtzOGl5bkFMSExWLytpYTB4NzMybVl4?=
 =?utf-8?B?M2tNY0pCdVhXTTkzbzlOb0lZd2ZwdHBOQlg5MVR5eEV6OFVrdElqRCtPVW0y?=
 =?utf-8?B?VGhSbHo5dWdPeDlLblRhTVA1TnVqNmJyd1p1VGlITXgyOGdGTjZCaWk2NkxM?=
 =?utf-8?B?aEc5bXN0aXJwamluZnlyR1RYdUpMdHRTQzBZcDdQZFQ3MU85OGxpZSthYVEx?=
 =?utf-8?B?eEMxRjdRTFlaTnpBcllJNFJ3Si9wQ0FnejdtcUpxRmpVUkJmRDN0TTAzaFQ0?=
 =?utf-8?B?M0VLNkk0c2NFV0dvbEpjaUxMVWxDMDl3VXF3NkRBQWQrSS9vckRmclNlaVVt?=
 =?utf-8?B?N0REOXhhVlRmNWdPOGxVaHJZQ0U3NEtUcmNDbWlwL2piRnJDVjBKOUd4MVY4?=
 =?utf-8?B?Y3B3c3ZkSU04T1c5YkNSTEVhV0lsbk11YTJ3bUtEeW4yRDNZWms1TVpUVWxL?=
 =?utf-8?B?dDdyQ24rY3Y3SE9PQWdqUEF0VkplUDhCQ0o0a3pjaEYxRUQ2dm0rbnhSSVhG?=
 =?utf-8?B?NWtJWkF3cXhmM1EvdHU1empQQTlyZ3pVVGJGdEdGc3RRK3JIVkRMYXpCbGo2?=
 =?utf-8?B?YWJLUkV3T0p6UVZWZlN0WFlWUGNVL3FzSnRPR2tNSjFUUUhTQkIzVGoyNVRa?=
 =?utf-8?B?eGtFV1lQc1VVY1lWdTRCd0t5Vnl3bzlYZGFwR09WS1VsR3VPbzEvbjhVMjgw?=
 =?utf-8?B?QUVNbE9qdGxxYkhKVjNFdHRqTHY4UXJpcW5LODVuMTFZNWJwSS91LzREQ0lP?=
 =?utf-8?B?MG9Wb3lXVlJlcktTNHpXdW5GVGlGd2lZa2VMZmRZTU1OSDlGQ3BoSGRTQnJZ?=
 =?utf-8?B?SStUNXVycGIyNVlYVHF0QWNoQ3Jsa3E2MlFrK1dqaDViaWJaWW05SmVSVGFT?=
 =?utf-8?B?VlRoUnk1UnFWcEtUaldpdTI4KzZKTUYyOStUL3N5UmZlMlZheGcyMWQ1VlFn?=
 =?utf-8?B?c21CSjBzeDdUdjJVbDhicmZyaWhFM0VOS1JWbUEvV0hnVVcrTVVRY25YSy9l?=
 =?utf-8?B?KzJ0M3B3N1VLdlBYbmZvUlZsSzZYbVdiYm1Oeks0a2FiL1Bqb3ZBWG9YekUr?=
 =?utf-8?B?aHp1YmdkcER0eStkM2Y1NFZTUkRlOE1NVU5MT3p6NW9XU0RPQzR5QjcxV1hx?=
 =?utf-8?B?NUxXUFN6a1JWS0dBMnI1dHZ0cTEwenFHbFNnYmhVOTRHYTlOUjl0YTR3eDlL?=
 =?utf-8?B?ZW9zMDh3Mi91STRya3dWZ2lGRXg4YXlyYU5Fa0VRVjFXZGd0RHp4MitYa1BU?=
 =?utf-8?B?OStsd3lnbUdRajBtaFpzMTV1Z3I3UVpvOEtCa1FXQThsbVpNRUREQk9HTmZF?=
 =?utf-8?B?NWM5b1NHMlBCUUltcFJEY0JnckUzblJKcnlzL2lTSzkzeFBMaXN0R3FidEE4?=
 =?utf-8?B?TEMzazFrYjBlNThvNDhVekNQWW55N1RlOXQvMVErT2FXdmNla2pNSk1WT1Fu?=
 =?utf-8?B?QkpORFFlRW1pT3o0dEE3WHZTUVlKWSt5U3pIVEpjV1pjaHl5TnJqdStxaUZ6?=
 =?utf-8?B?d3cwM2llMEZDcUV2NThwUklhN3k0M08zZVNtRDk1MEdaQXBtWDBjY25QV2Jx?=
 =?utf-8?B?cU0xZ2hva0FDTmdlVEpMZ1NOSUJUQjN3eTZRb0IzTkI1RzIvaHR1WFVqc0o2?=
 =?utf-8?B?Tzg2dGJJZG1sS1gvR1lsL1ZpMGVPYkdZQ3N6cUt0OHdBc3NUWkh6eXJvMHp0?=
 =?utf-8?B?Q2tnczBUdW1pSnQxQ0dPdUNrdXE5L01iZVRrUzkzZnRJMWpqM1hZQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f697fb7a-f848-4c16-f799-08df3b70dca5
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:13:23.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVVdZMlwoemEYE48sDDK+DRuX3rOONYJbi1bykkuqjO1yno5+sCTitIIdQCdpLKJ5Pe4jSkBsuIT1Gl4LybDpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229

On 10/29/26 6:43 PM, Srirangan Madhavan wrote:
>>
>> I'm not sure you should include the links in the commit log since
>> they are to a private git tree. Maybe just include below the line.
>> Those links are on more patches than just the ones you added
>> DaveJ as Suggested-by, so very that is odd too.
>>
>> Anyway, that's for you and DaveJ to sort out 🙂
>>
>> -- Alison
> 
> Hi Alison!
> 
> Thanks for pointing it out. I put suggested-by and linked Dave's branch
> as I wasn't sure what the right tags were.
> 
> I moved the reference-branch links below the patch separator (I can
> remove them altogether if they are not useful) and removed Dave’s
> Suggested-by tags in v16.
> Checkpatch was complaining about Co-developed-by tag without his
> accompanying Signed-off-by. I'll reinsert them once I get ack.
> 
> Dave, the refactor starts at v15 patch 6; after the split, the related
> v16 patches are 6–13, 15, and 17. Would Co-developed-by be appropriate
> for any of these, and can I add the Signed-off-by for the applicable
> patches?

Hi Dave,

A gentle ping on this. v17 still carries no Co-developed-by or
Signed-off-by for you, and only links your reference branch below the
patch separator. Would Co-developed-by be appropriate for the 
aforementioned patches based on your reference implementation and can I 
add your Signed-off-by for them? If not, please let me know which 
attribution you prefer.

-- 
Regards,
Srirangan
