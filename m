Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793324001;
	b=veBarMZylp7YwbGZM7E94nD4Jd1CGtnPx+AUDkjqkHwcCWzgyXlY452dLPhI5oCn1UF4
	 TTpiABV5EQr+ZR+XLGU/e+oRkt18RrnKnxqOUhaYdZTcRudSN7gjTVuRvQCvEqgQVCXzx
	 jGkOAaM7Sv9RoTbX13uO3vrMQnkdtYlo72S6E6Hv7ge+CFC7A7gGQIt9HrMdGkhtAuJ5d
	 +0jCjXJJzOg+BH7NnHwTJUBXmTKwsQGdwMEd2wWpUxzkV9NAQ1ct6Bw0/lUqIjthEZPuh
	 VMZx8vryCnKQFCnHR+sk5f4cRKdKJ40LnogBtv2hHbHOO+84CXxmSZAoEeSaC4CaDCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324001;
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
	bh=asQemxJQJmvANbfaAnoLoH2faOtXbjlO3J3NctJ4m0Q=;
	b=s8CzJQtx/lgkzD9eScbee5vII+QvCRqp+jnGg1tMcBFFL6/ZmqWyVM5N3SJm06oEQgZg
	 EE37vn87HS9q7gD0Sxaf/EsUZ/XEmAX0X7kOStyhIk/Y5ywtJw6hct8d5zWA5NHwk4elw
	 YSIzLafsoqC37kzADHHAmwP5qjmoBMY2/eflrqQdMuA7kFY5jsxmpTF+ws8kk7fL4zfEj
	 4WM4xhUpW9AXhiDiYqKx424CVP1AjvQmjMBU4XkP7qkL3HLcRirHdEJN9kBNU4yCJk8+e
	 6GHLV5aklfcxJ15E8JO5qodtYV/Oizf4+pTZF/LiVhpHNhW3eJF94MzOPaapF7lcI7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hihbsd8l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.49
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA53606A31C;
	Fri, 30 Oct 2026 01:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDA53606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hihbsd8l
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJ0r6/TGba0AmQanj92JAUW3tgehDnUaJydTc0iz+Wmk3lyfSREJOC+/9qq8A7J/vzl/E0gn/K6yaTA2dXlFs2n9QRKnhe+/mZZh2z0vs+9/5HUtcwYgYjreS6dcfi3kwiYIClt38QKPxsPeeUpXg0i/Nsojct4Rc0SD7BgL5pycI5XC0CcX0aySGLLnG2ptRoTNtcZKhoCQ5fAFEZrA3dGRFR4NlUDgjRpUQH0ZIZxG1+r2Svb7OE3IQRj0mpI+QXMKapAoeJvOXRe/YT1vSjFClGlop0fUdP18IFKf1yFgnAeSwXv3aYimzBEGSEAcVEUD+nbbCQnrdIFMWcbAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asQemxJQJmvANbfaAnoLoH2faOtXbjlO3J3NctJ4m0Q=;
 b=Dbt2U4YbEP+GQFPrZdzm3DKPFmheX3iXM21UqgeYNdWRLo90FuKl605g0q2C59Q255rOEtmaywp9Ybv6Kb11uPE+vsSfdJ1FG+B5EQULNEqV+GfcnqZZseCzmLGJ99glyEbjf1+5zg/l8SPWMsveKyJ4j1QBzpQeSBXBGlJ7iQjjN5+yae2StjFo5ulTj645NJeCmaLS5ZYBL31X0MkP97/4YQ8/REWujyrFHMdeu5mvxulAQ1JBx/dnLCmHQF1CEtc401mZP91ksCtUG+D1PcLL49nY1rhh92kNp1cQf1wJsSHL8MFKhDc3mb9AoTJAP9EoPdwztstlMOwohiZQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asQemxJQJmvANbfaAnoLoH2faOtXbjlO3J3NctJ4m0Q=;
 b=hihbsd8lWFcJy3a+hDu+aE89ucvfmBM3LU2yJubvYjyNn9bxIMjzVidCldGhrS2G7IgXyd18ruCaQ6IzsHQioUns6FTzaemZsgatMwZ6Ix/5Hn3iBAydQkosRmEs3gA7MyRcmg5jmtknBCYoyo5KVFoCEJ7qz2qRn+TCfQHtFbrb3afMK/AAgGcRmwUzp6SG0Bnhe+KvmOWKs4GwY4Xrccq/E9Zt8ujnaDTzSMD2CHE4YHz0zMnUmN8Sh6bQgkWxxS4tPP/6UYo3SXaAy/iG6pfk2Xmz/IC9JLqEOAwA6AhP0MzWG4Urz9fHFzy0c5oa4yT4prOStlwk4Sijk6SIZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB7383.namprd12.prod.outlook.com
 (2603:10b6:303:219::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Fri, 30 Oct
 2026 01:33:15 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 01:33:09 +0000
Message-ID: <34632b64-c86f-4853-8d1f-8e75ae674398@nvidia.com>
Date: Thu, 29 Oct 2026 18:33:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 10/16] PCI/CXL: Add CXL Device Reset sequencing
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
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-11-smadhavan@nvidia.com>
 <37c6f2bc-53b3-4260-aa27-04f89c45e950@zohomail.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <37c6f2bc-53b3-4260-aa27-04f89c45e950@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5eef0d-32c9-4a68-be28-08df3625c0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|3023799007|56012099006|921020|11063799006|4143699003|261022105027099003|261026140227099003|10067099003|261009223027099003|261021121427099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	8B4rgnQOZbmZMlS589eJBalQqdiNPgs8WLE2P5OLBHtyBRG+WTYQKsvERENL5pVgfFtH5SwWfvdORxug2zVgppzC0DtkBqnnNskt5dlDk4laWZ4RzbQJHPstI49kuLB/DjtsQgbalJXJjHXcL3cDXZMKl4DUQrA/l9BDclX1dnIrJRQsE6ILaZd+yvXEDWDaVbOSG9KchSGf89S+4xLiV2lJ8SU9+PO0isr8wK/09fAb0r2h6zymb5P9K21wi0Hl5RPtAs8vJFTsrMe9i5iJ/gwEgLtUSFJE8VYige1cNTp/TCVUfOZp2aSIxw1bkcGMMc7DpFW1ynfG25WLP42hbt6PMiTgaUXBSnVHKnVQq3UT0otuwuaTjAKrGPWKbtMvlpSGHCXG6BXBgI1ics0eVBVETeEtosTjQneBVhBaqofqlRzoGoOJVUpWcceqJPS67jSniEnOYvt6oVYncAzF2IeO1IsTiIQyb7NE3MmWFRLscc1/hwZ/utaOCXzgFrPc+YOxgWghVvcfl7vSv9H1QS67vvfDwhwuFUkTMyFf37/l4h8ssOje5rGzEb2RfyX2rS4Apk9K/QeGpyLQh77U15oEQBO2tC5JFABORzKhvnEHknYdIVSYUROfb/W6T/J7C5FYTLM3OPoAmdApUHSqZOrxnEQkgAicxNLKWYhF/ordER+6skZxOh+zC43Bp3P0nvV0QM+4CEVpq6F/kKFeHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006)(921020)(11063799006)(4143699003)(261022105027099003)(261026140227099003)(10067099003)(261009223027099003)(261021121427099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWM2dnlzODNuSFJkOE8vV3F0alVXNldiOFFVUlh4aHk5OU1lSmxaeTFpcVVJ?=
 =?utf-8?B?cy8xSTVDSWlFU3pqdEpSKzZJMThEY21HUzFCSkptam8vR3Y4TFRUVHVpM0tp?=
 =?utf-8?B?a3pFNzdwSm1NRkdnYzdXcW9PUXNCWWFMVWo2bTlhb1dpOVF2NFZSZGtRZ2pl?=
 =?utf-8?B?WWplZ2llelRrdXZwcjJNdUNkdG1QT08yaHB3ZjBoWEluZytmMmM4SENRL1Z6?=
 =?utf-8?B?engrTTczWENqK1RaMllXMmtDK0dPL28zOStGR3JnMTUyWWpZWUM2UWk0cTZk?=
 =?utf-8?B?ZWE1Z0dhUGx6TE1XK0YwMDZzT21HdmhweHdCYkY0WlRoZUphanlKUUswVk9X?=
 =?utf-8?B?aFJneTc1L25Sa3BDNm1zanJJWHhaT2gwcDU2UythYm95eENKQllpMjEzR2VS?=
 =?utf-8?B?bmpBVGRESWJkcGpVZDIwQ1RrVWJPVWZoOFZxUDhpYk1sUDBVTkcwdjVRMSt5?=
 =?utf-8?B?QnBZNTJYNzJWRFVSdVJLNzlmSnQ3T3Rna0xHOVBTb2Q3ck1YQjBmWE81T05l?=
 =?utf-8?B?aDIrc2xEUmdLOWtQVlllVXBXYzAxNmZiMzJrcDYxcnNBbTJpY3YyK0p6TURB?=
 =?utf-8?B?Ynp3N3lXb2w4OTB0R2pWWURUbjFEWk82WmxUZWpIRVdJTmtmNEhuNUl4Qita?=
 =?utf-8?B?ME5DK0pqL1Q2c3pRb0JHTFMxN3JVMFV0eDdJK0p6NFhva3BPWC9pc3IyZ2tV?=
 =?utf-8?B?dDlLZjhSVVJKY0lrMnMwU05VOGVVMHphLzBmZThOaFN4RVVNcThMenp1aUlw?=
 =?utf-8?B?dU0xMm02ajdIZ1VLU2Z3M053MkphS0gvYzVwYkZlSTdFLzlGaHZTcG9FbXJT?=
 =?utf-8?B?TXNiV2x3STJZcjluZ2lEVlQ1d2xXaU5FZUNpaG9ERXhUNktDekxycEFVeW94?=
 =?utf-8?B?N0pYbHdSSmV5ZWFQdmVaRG5UQlJENExIUldpNEJKeHNIb3NDaHNhUzFzUS9R?=
 =?utf-8?B?U2ZHeldwR1VITElsTjh4MDRITk5XSGhTMFhKSmkxczQ2RmNxbXY1TEkrZWFN?=
 =?utf-8?B?T1lIbzNTZUQxQnE3Q3AwUFpzTFNMYkNmR29TSktxUk81V2Y1cE0wYm8xMHZB?=
 =?utf-8?B?Rm9jK3BNRDFHbHFpdXU0YXFFR3ZwTkJKZWxlYUd0TVk3MlE3QWtqZ2t4UXpp?=
 =?utf-8?B?T0FKUjgxVlV4a1hEUW5PbDdUWjNSZUFieUM2Q1g4Vkh2ZG01eFo3d3ZLaFR3?=
 =?utf-8?B?TmFQdWhsUFdJQ09jRS9DVE4xRGY1eU0yVFh0K1dQcEdQbnpRcWdjNURqRmR6?=
 =?utf-8?B?WXJKNWFRc0g3Z1FleTlpdWFmVXB6NWE2dldVR1Y5cVZRNHRFUkR3RHdiSzQy?=
 =?utf-8?B?OFV3Y1BCWGZlMzN3QTA5M0ZJaHNINFhSdytoSEFiQTBjS0dTcXRTaVcxc3lp?=
 =?utf-8?B?N1VMZlVENGphNy8xVVFTb0FlQ3NIWXhXNjAzSXZ4RnRDSXowK0M1a2p5dzNz?=
 =?utf-8?B?QXVVOWkzMHg1eXVGV0hsb3VHZnQzR01sdERWME94TFN6aUpXUnRibFpjNEF6?=
 =?utf-8?B?TkNYd05VQVpLOG45TFE5L2UyeUliaVNFSUNoY3Q4a2VBczlMb3dhSmdaTndY?=
 =?utf-8?B?UC8xTy9SSzJiY3hFaE9iRWozLzd3MW9WMXNVeHNjM3NFRlp0Zjd2ZVE0L3pC?=
 =?utf-8?B?RmFzU0JlUXNEeDlIMWUvUDRFRFlvUjZ5U013ZWU0Yk9DWllMR1VsSlpHUlU1?=
 =?utf-8?B?QXhLcGdPVWpOc1huUE1ZS0tJUmlCNmdHRGI5bjU0dFRQT01VSFJkcTRsbEhx?=
 =?utf-8?B?YVFSNWtTSW1JWlAvN2lTRjdQTngzTm10RVk0VXNNbDJBTFArS1hyQXBja2lW?=
 =?utf-8?B?RlFZVWZFb3RVcHVnVlVrUXlZeHk4cjY2VlpOTDNSZ2NVd0xtZk5YMkV1cUxR?=
 =?utf-8?B?aTV4U01Cb0lVTkdaelZub3EyZjQ4OUxNTnAvQ2dtaVdFczFUT0w3VDhseWkw?=
 =?utf-8?B?RXBFbEV5dlAySU81b1Bkd0owbXVaUHNRNXZsYjI3bFN1UUQ2ZDBGdGhQaXFU?=
 =?utf-8?B?dkdYbUJzRGtvV0F0LzRBME54bnVLaHBNbzd0c0djQkNiakpsNC9kWW5CNzRH?=
 =?utf-8?B?KzVXK1A1akN5RjNoSnB5ZUx1c0UrMFBlUFZZQzdqSnVXeE9iY1AreFM3UjBU?=
 =?utf-8?B?K2tMdHJwazdwenVuMW04VXQ5aWVsVWxMa2ZQcTFMWEYvQ2RHMGdpaUVFeUIx?=
 =?utf-8?B?OVFOMXlzOTlkUzJUSDlMT2ltU2huWkZYVGsxOEdRcWVnNnZDOHpkS1hoWnU0?=
 =?utf-8?B?SlQ3LzJDaTY0WkdoTlRieElhTWtiYkpZT1E5Qy9uOFc5RkdIUmwwTXpzMXJs?=
 =?utf-8?B?SDVNYmhacmVwR2FnRlM2K3kzeU82cjdxOWZiU2ZjVUVyT1VJdUs4Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5eef0d-32c9-4a68-be28-08df3625c0f3
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 01:33:09.0250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiGa9Q/bSNH/DSaxf4aAfiShJgoQcCDrXU9lOV4Q54xdk+zfz74BPPw393PX/ZQC1GSCBvk2BRduS4vtT4TLLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383

On 10/27/26 8:01 PM, Li Ming wrote:
>> +     if (PCI_POSSIBLE_ERROR(status2))
>> +             return -ENODEV;
>> +     if (status2 & PCI_DVSEC_CXL_CACHE_INV)
>> +             return 0;
> I think checking again after deadline is not needed, if it usually
> happens, it means we should adjust CXL_CACHE_WBI_TIMEOUT_US.
>> +
>> +     return -ETIMEDOUT;
> It is better to output a warning before returning -ETIMEDOUT.
>> +}
Ack. Fixes this in v16 and added warining.

>> +
>> +     idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
>> +     if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
>> +             pci_warn(pdev,
>> +                      "unknown CXL reset timeout encoding %d; using 
>> %u ms\n",
>> +                      idx, CXL_RESET_MAX_WAIT_MS);
>> +             idx = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
>> +     }
>> +
> I noticed that the worst situation is that we have to wait cxl reset
> done for 100s. If my understanding is correct, userspace would hang on
> "echo 1 > reset" until reset done. Is it better to add a pci_info() here
> to output the reset timeout value?

Done. Added a log print.

-- 
Regards,
Srirangan
