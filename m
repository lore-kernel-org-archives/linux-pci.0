Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793975183;
	b=Nzyqy7XEkbtbm23nDBCQWKxY4JmTxF9lMDqa5CXmrbYgZQ33pnm4Do80RBpxjx/kGey8
	 HaBHSDfUmVcLa9rFn8XrEwuHOkvlrRpdVHaS44roBoa4taXFePIt3kC13oDUzcqHw7V2y
	 87eofEfIu2BCalpDPIxR+XqLhu/neOki2VgfBrGnE3SZAQyNA7COjukC2B0UvPdaJv1kH
	 HvcUBKGqs7sTjA6a5KR+QWXtT+Yyih23t8L+/xEduAI5GyK+4kGDqzqA+L4rxx7n9VCp5
	 7ELyVoPGwl8odpobsbE+0J8dTdkmw1fhzKgBVaCKqFaNI38wCglUWGSzqOF6udk2ozg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975183;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=aOB3P2krM/KBhdBKMZu1iyAtEZNTXqnnBcosenuw8Kg=;
	b=rdwOtq9savCSJxqCEZ7XQagbueQoBUkOpRB0Vsf4YGQZaNjJmMQxpRYiS5xISZW7YzIx
	 kNq76vTSzTadJbwOwJMMCRjZBeut83BqpICfTgvsu8uMzuLnr2MLbTGZDsY9tKQhfbSux
	 IgscxbUhVZh/updT9mPDNSULJldkGA/4PGoy5RMXEr3gAzhcfe2Xqk0ddEtcUBX3jVkil
	 YhVuvEdtr2bdT3WreV1qkPIa5ORdvbhJBjdfy3nAq8qydPs4F0tKb5A+AT985AsZZs/1k
	 E+hqU9QSATfQIm6VHlkvMsTiYhhEsn0URuyaaHPAyiNrHRnj6WCmc52AhICjIehvvoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X6xqJz4J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.54
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6001D606A326;
	Fri,  6 Nov 2026 14:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6001D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X6xqJz4J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhzkCMqrlkxINbnmPMWm4A/ZsZuXL89lX+0m6dCASypySLYXS3QadDzPMpx05D7MjSbjYYEYRS9wuJbVgXekC8bO/Ry4HSh776EhnsfAibBvMQVLktyGv4PXUX/VgUg2Ls0p6O4OQ2h8rNsIAGdpKBkis4eIhDjpOmj20oETdkNcl12z0T58Q1NsFfoU52yzDLwJO1y9XKT5Wo49zaKXXGIIN9WmIUZnlE5nhUrEK8tnVYfFttTCcNtKT2wAdh9MC0WhKiuQmh7oEHRhKfdacTVCHsBuCYHgF3Q/6Qsp0qP2c02duUVX2Sr9YYm1KxsRZc4XrSgl8wfb+3dfbfrEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOB3P2krM/KBhdBKMZu1iyAtEZNTXqnnBcosenuw8Kg=;
 b=AwqGoRO15V2yhe5LlumQD7MChA0w5Rr7hQK7muql+Dq7XdXgRiL9fJ3jYIMA5g0h1lv3kvScMdqCcVH21tZPOb7ZBqXtqc9AdpVZ6AeEZPD6ze97OyLl8lmqvNWBg7eZ+9/9CNvvk0F8ajftPsFF5dulX2iI71voPZrmPN+CEPk1ZL5sa1MZHY8ITd8Bqm28IxHdTUHzmuP2Txql3VN5bU4KqQyoSm1D9zoFWCAILeZH+nieITf9vpNH1fRtQF2xICYdevjioUrr7gbBoh+Usd8T0o4C6MJxRVIG/a6F681vrOuyhwi58b9f+ZnqZZY1ln3XQVj0FDV6Tvmtdf2YlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOB3P2krM/KBhdBKMZu1iyAtEZNTXqnnBcosenuw8Kg=;
 b=X6xqJz4J5lf1cWfxnt7ud6F28jz7DVYF9QHGnZzLUu7DjRgC+yn+F/ZXDvAcAQ681sBoI0TQ0B8hBKSGQ/vD+18+scas3+toAdNzpAu9IsD7PbbxO5z2qXDJhUEx7TDxNENrpRbk/nLOokj0WQ8MZDV4pT6M5BF1+IIcjWzb+AH9asL3mR5M5dZzrp4doArFnYbffehagPcwYoN1iB07UnKbPpE/BwMJWp2MR3aby30mJS88ZiUhJlX+U0LBDH/hh32eO6KfjZrnCbqqXSh0bYHwD2dnnh8AsWz8E35nKp9Ikdcq9bN+jgsYPhJlEuwnzNDPA5+t3rzLk90joCoimQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by BL3PR12MB9051.namprd12.prod.outlook.com
 (2603:10b6:208:3ba::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 14:26:19 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 14:26:18 +0000
Date: Fri, 6 Nov 2026 10:26:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Richard Cheng <icheng@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"aik@amd.com" <aik@amd.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"iweiny@kernel.org" <iweiny@kernel.org>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Srirangan Madhavan <smadhavan@nvidia.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"terry.bowman@amd.com" <terry.bowman@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"brads@mainlining.org" <brads@mainlining.org>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"rrichter@amd.com" <rrichter@amd.com>,
	"gourry@gourry.net" <gourry@gourry.net>
Subject: Re: [RFC PATCH v2 3/5] PCI/TSM: Derive the coherent-range IPA from
 CXL
Message-ID: <20261106142617.GB770409@nvidia.com>
References: <20261105152909.53452-1-ankita@nvidia.com>
 <20261105152909.53452-4-ankita@nvidia.com>
 <au2j8EmUZmyeNs1h@MWDK4CY14F>
 <SAWPR12MB999267C601F3B004A274DE4A72B0762@SAWPR12MB999267.namprd12.prod.outlook.com>
 <SAWPR12MB9992676C0AD7255BC8D9A6BD4AB0762@SAWPR12MB999267.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SAWPR12MB9992676C0AD7255BC8D9A6BD4AB0762@SAWPR12MB999267.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0335.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::26) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a9fe8c-f935-48c9-57f0-08df3c11ec4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|18002099003|4143699003|11063799006|56012099006|261022105027099003|261026121527099003|261028144727099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	WpT56bKsToSMIdTYN2zOu93ydEJRskf6BOtTOk74TccJHCVoNz6yLjMNK/jJ7pAUhkLlGZr92US+T+y9t1uOKAxE3cTeiYebz70/zGbTcXpxFupRFy5HtwQvsOh5bTNtGLcTv42LD0I19s2mbigsVycjMjSYObrMKXJwc6VOxlnqR9fhARVTVS85PMy/Q6xFYPjuSu97EQfJeZ6PJ1jFwQjDYQpLe6G+ponBg8M+yTrdfCG9dl5QawZQMiwC15FI39deGJHw6Bl/vbS3J3WDQYzMLLGzwZJ+jTgVao+B6JItlB4NlGNerhANf8hLB5QlORr1wnpPxFD5zJDtfB4bfEDxiEOn2UXb2jygC9VLnU13fqGwJIqM2R0c4LrXeCMRpWXKYu2ceJhpZTB2OCAllWKJKd1LKV1+dGZkdQzrWMdpWz1taRdJkEKD7UoVCQ7jgs2m9NVwU1rBh/6BKe4bsqtrgMg3bFkf/cHAnLP5cHKEOGE+bWrAqsNX4JdY40HN73T2O4Uw9Ok6gflMTmeuLfK91GxxgXUCmgGJxKtx0WhOEPCadjz2T5PImy8CQUGkaxULpMVQM7/1eItgMnow+/UlgEnuaZDMeHam3KDLUTVdE4DqPeflASppuCYITT0rzpGtB7jugJ4lTqq2DYJnPRMX4FBJSKpnWUyJ/aG+0hM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUtQeXk3NVk1OE1neTRJYm5hYWk1UEtqS2QwUjEvVjloQmJpSUdldWxscFFO?=
 =?utf-8?B?L3FzajdjYmg2aGh6SmhNSlNNYTZXZXBHZkVvTWJYc2kxZTVJQlJONDY3dzFG?=
 =?utf-8?B?Qkt0RUhFaXpVdkFsRU1MR1F6VDRkQWRlWjljUDZJTWpnclRIOGtnVnlxcDBF?=
 =?utf-8?B?VlJ0Tjg5V2NMYlBQQ1BFZzJzU2tkSjlXR3VkYWowb2JaTURCdUF6UzRZZWNy?=
 =?utf-8?B?VHRDTHdzZ056SXN0UDhPZys3U3V4Rm9VRmthejY3UlpvWTcyWVJJaEZaNEQr?=
 =?utf-8?B?NGExUXZMOExtZTYyNTUxYW1IMzB3aUZrNmM2SFkyOFpMT09RK2hHVExlVzRE?=
 =?utf-8?B?WlIrWU92bHFEcnc0K0JxakdjaXhCNFl4ZzEvR2tYQWhDNkdRaG9CU0o2WjF1?=
 =?utf-8?B?Njh2VU90M1B0V1hHSGdjZkZ3WVozejY0R3g4ajNqdDd0M2VQNU5zTVRMSzhB?=
 =?utf-8?B?RkxuVFRnS0tkTUpPRDZiYUZyOURhTUlhT0YydUcxNGZuWlAydHFrN3BBbzJ1?=
 =?utf-8?B?MFFGalhPSkxwbEQ2Nld0TC9uMi9GUzZWcm1YeGpvcjBwTWNJUkdyQXpyMHdT?=
 =?utf-8?B?U3dxbHFvV0ZxMWFGa2oxTWovSW9Jb2lUWSt2SFdKYjVteFVOL1BUTjArZ2JG?=
 =?utf-8?B?bnBFY2duS3lGalRBOE9sdS9aRG9kUkFRWVZlMU82V3JXUUlrOXlvMUN5OUFD?=
 =?utf-8?B?MzZmamFnMTA2U0J6c0E0UTFGaThBSUllVGJ6WUlNVmlYWkN2dENxZklqL09X?=
 =?utf-8?B?RG1qQ250amJxekdkQ3hvK3Y3UXhaYkNkYmpzdGxNVnhKaHhDZEszQVZhTlFi?=
 =?utf-8?B?VFBmR0w4UlBmSDNOWjZhMEZ6Z0ZTY0tlOGdLaXFEcWNuRmVLd1JYZmF5RUdq?=
 =?utf-8?B?QkY5bWpVWGNSSmZFaDFkTGlKTU1uK3JmcjN0aklDakpBYWpsUkE3K2xxMUQ1?=
 =?utf-8?B?a0wxQ0RrS1V1eXhOb3ArQmJxMzNyR1hFRUJlNDRoWHRPU2greHdMdzJPcWJu?=
 =?utf-8?B?RlJzU2hIWDYwbUorMFFKeU1hOTJQalhxUkgxelM2dGltTGRxQXh3dmNLQlRN?=
 =?utf-8?B?UDZEMjZYc282cC84VGJyUDZpa0EvbU40dVE2WUNPcDJ1QTJrcU5nSkUrQnkx?=
 =?utf-8?B?YlhQdnUzOEdvYUhQd3V1M0JNZStTQ0lyZ2J3cXNRS0RTak9nRVR5NUdzUzJM?=
 =?utf-8?B?dWtJWGduLzFTdmZWTGlXa0dhVm5IWFhweTdzRXEvN2I4a09uU1JIMUEwYmU3?=
 =?utf-8?B?Si9lZTdiUzNvZTgyblE0OFA3WkdTcXRBRGZLWTRVSGd2RFJJYU1vbWdydEsy?=
 =?utf-8?B?V2t3enUra0tHNlhuUkpnZUxadHVIQkZzZEF0dkI4VXRjUVd4VFBtV1JZS0k2?=
 =?utf-8?B?MDlvSjNkUXFhSU5wMGxiL1hvd3NDN2xSRUdGd1NLR3ZvTG1iMDZCcGJrdnlM?=
 =?utf-8?B?MWNrbU1CRXZHU01tQUNpRlJCYzlZREF0T1ZxQkNyTk10cDJEaTFtMm9XeGxq?=
 =?utf-8?B?bkxLbElNcjYwTzNJTXk0T0FzSzdFM1hVcUZqRTdycjh6eEwyWEdzQkd2T3ov?=
 =?utf-8?B?eGpFZHZsTUl6UnBBdjJtUDQ4aCtUOHFZTTVrSDlLSFZpcnprUXRyRE42djl2?=
 =?utf-8?B?bkZhMGFGWnZZZU5LbjFTV2NkbXVVYStoVm9pamc5amZKVWdJZlNhVERHaXBP?=
 =?utf-8?B?cDdsZ01IaU9ldHJFa1BRLzNrNy9HYmp4YUpYMkk0cEJDY0xFNmNlYS94QzY4?=
 =?utf-8?B?N3luMnJmQWgwdHdwdWNHSkFVeXFMSUUzenhLdWk5b0Nnbm5pWXU3STg1V1dR?=
 =?utf-8?B?RVFKOFFEbDJxT0t2bmNId3BrNlZmbGlVd0QrL05zVEFYcmRKVU9oTDk4dmxT?=
 =?utf-8?B?a0VqYWxUcjdwS1Uzd2xoZ1VWTHVlclBHMkdnZjVKcnpDb2xoT3lDdlVIYWVw?=
 =?utf-8?B?L2dSZU5XY21tS1pKeTNiUUIrVWNuRVZsZGV1SlFmK3UzaVQ5bXBCNGpENG5l?=
 =?utf-8?B?M0dsaGpjMkpqSGhkYmNzNXVpM1BrZy9kZEllZXZZdTUzcUF3bVZwd1FMb1Fo?=
 =?utf-8?B?TExOSjFDMlJFSEY5K0tlMU9tdXc4SnFtSWU0ejJaZlRYcUJrT0pPVXk1ckpE?=
 =?utf-8?B?ZEZ1aWs0WWltMnVITXFGdTdHYTRrNzRmZXAzZWFHZTZRdU9QVWJKa2F0VlJh?=
 =?utf-8?B?eUlpQjJyNE5WczlncWZNYzdETnV2eWdGMXZOWmYwdyt1bElnNHFTZFIwU0w5?=
 =?utf-8?B?Ry9TNzNFakJEdUlPMGlKM21mTUNHNXpxVzhmQ3c5YTVOa1NGdlBEVVIxRlFV?=
 =?utf-8?Q?GUregTBZurMDSnc6qx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a9fe8c-f935-48c9-57f0-08df3c11ec4a
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 14:26:18.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1giBzhzxLQte0SovPe1MInWyW2DDjjMt4enkH38JU5v7ZxHJAiYBlF8ZsrKA5y1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051

On Fri, Nov 06, 2026 at 12:38:35PM +0000, Ankit Agrawal wrote:
> >>> +
> >>> +                     reporting_bar_base = tsm_offset &
> >>> +                                          ~((u64)range_len(&window) - 1);
> >>
> >> Hi Ankit,
> >> 
> >> HDM decoder window can have non-power-of-2 sizes, why do we assume a power-of-2 size for
> >> coherent window?
> >
> > Hi Richard, yeah the region base calculation needs to be updated
> > to correctly determine the CXL region base for the
> > non-powerof2 sizes.
> 
> Just to add, IMO determining the base IPA of the CXL region using the
> interface report does not look straight forward for this case. Trying to
> figure out a proper solution. Missed to mention this as an open in the
> cover letter.

This is the same old problem, PCI SIG messed up the interface report
so it is not usable by the guest.

The pow-2 thing was a work around to avoid that, and it still works
fine for CXL.

CXL's non-pow-2 doesn't change anything. The TSM still would compute
the pow-2 starting point and use that when applying the
offset. Meaning it rounds down the CXL window start to the nearest
pow2 alignment, then uses that to set the offset bits.

Linux makes the same calculation to strip the offset bits.

The real fix was to have the interface report include the starting
offset, but that didn't happen, and it is too late now, so oh well.

Jason
