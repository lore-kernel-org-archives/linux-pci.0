Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A64390610;
	Mon, 24 Aug 2026 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613780; cv=fail; b=Vf8P0gmOQkLmnrZ55IdWJnyvczxjGztLX7w5dxWeZF0J758MhNh6p9X6ucMEeTR/+u9MNV0Ard0DI7Rn1R5bP4SjSZ6qxpWMXjZjc8t1ce1lGbvao60k/IjavM4pnAqsjyV7zRagi4Yztcn3E7HbcwwjjIGMOPZw0+y1J2W68tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613780; c=relaxed/simple;
	bh=owo99rk1zRwH4+tNLhKxX1sKP72QOvxVSfs/s//4NPc=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=IFiH0sUTXeq8iq4HuVTSwBVRE7K/2tNtFuB0OqHNEFgPmG8vX03opp2l96THv3XhZaemtihOhDAdtrwYA/62BHakwYuwMYwPx4eeA8pbR9r+2YBcROwO31Z4/mLRXl7vT0VWvBSYhDnKOm7pyIk+Pl3YmvxvNyxB6wFPcFDohrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TEbipXoB; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TEbipXoB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcBCbjCWLtwcugQ8jOg0SogD9AL2clHNIHJvL6TMtBZ6NnQffevxSc3wAy5DxS7NMQopNanZA5nIAdMaBUteS/oSwhsCwVuf/7af2T4SSvSU/KjMyl6u2G+RCzJDUfmj2c/Ch01AKLbRzDzR0+I5acOJ92OZyalt2xWZevKkJrZWLb3zzfUddi/mK/XlBVOiQcOQ6rglUSqMjEqScpwdAnJ2p+9YQAWnlmIz81SgqY/OL4KIT1Dgw1WtKE1CXY2HADirN7PjGU0mrSR2cZWS5NvvgJp8GZbuEct1zfvWuNJ4pQjIAE7+EB+dkd7bv+VZgpSMOKLg13KK+IHKQO6zNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QicaBYhnO+24VlGNzGaXjvXcOvyAQUjyz28VLDc21w=;
 b=cLmi2k1wvsWwwdo4JoV9eYJCsYwux7cSnF6Nzbac6Lp4sXu6lRZDeJB5jpuNUe21LlVg6xkkmfBV7E7rbTFTiFStT4ODjmer/+G+/fuWuhX3sIwebh3XeaIOmDpBhaK/qZNiVlNZxH4QYvPBwShG31HfuRGHm4qrtMBLjMnEgCFmKoc00KjbUSwIa9xG9tV6IYHU2sGY3kn552HOKNjwePOIUMtEjWR6IIGK0eRJq+QYPTMXzkW53fiVB8HMrZqU3ZmX+UJyd22Qx+9dPbqhr/3oKKocUyjohqtRbc6ROceQstOYbyWnm6vguzFvjr6ARkFK2TsBlsqB7i+vy73XQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QicaBYhnO+24VlGNzGaXjvXcOvyAQUjyz28VLDc21w=;
 b=TEbipXoBpg6r9wMBEo9Q3kudZgyZAD4x1jrkgzSxdbenNrhjJGNtkOP/Fgv+c6sz6/5RaNj5uIFSjxeNly+DkZkmiSYxX67+jDlQLSqnEjhqynThbmOalCiyqZHsZ3bwHxdOEMtRtdk6kATPjnzVHKDR3pIvp4igRtlM2xDdaxXdpEOpzAo9xBNfIR6dG9Z5ypza7TRdota6HfxgmgJnn7Yq4ozdTXiSoq8aySbjET095MUuC68WUioNEZFxv6fnVDrL/WvF6jTB1C0u6RDWnX2cEB8u8906TAldoCCYuFdy+bLCKCro9RgBOGwrEMooVe55VHxIwB2DSgaUejxvRw==
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
 23:22:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 07/18] PCI/P2PDMA: Document the Address Type
 assumption
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
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-7-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-7-94426b96de73@nvidia.com>
Date: Mon, 24 Aug 2026 20:22:50 -0300
Message-Id: <178761377055.3197084.12191528318950950293.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0415.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d28e67-145a-4f58-7f69-08df02369f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|10067099003|5023799004|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Hf+gD+FE9torXAia+FnHeY0wTqfTwxAFck6XcmFGpKBai0xSxI+iT2VCTJt3P5hh/F2+VgCYf7A59MBgJkQGyw0EANw2lhvKM1IiDg8Zx+h8HTjh6dDO6RydHcHoUogmaMDHpJ1SdVcmbxzE2UdlDNhiBwkGISyzBccNnClgmBmYOW3Rhg0M0Vy76/XZZ4DWKD6YBN78Xznv2zAzNv7t7h+qCUAuFC/RLpZPg1z7TNrWpFljDrNTjTAJa8g4DlIW6vYt3Ix51J+N8IIHbF43g/igJlabr2jRmtoR7N+UqowM0BMlJTxg/d48A0beFpp26bNnlO9Ja3kM8epqWfdhNywLf/OPoRHKEeF1PSAx6tTG67jRgcKe7q+ny851epjb1doMV/KscsSQe67UG0DrZN019AFjLzrYpNB6OhOzQWu55iwaoaU+yhvMaCplZIx80to55Q4DG416z8Mx9Fe3vsHmUrYDgDo5YdFYTDUEacwvQIzBeRpPARvo6c1AKANC6xMPmvNWJ3FtfCiE7IRmBfKLAwXtx6Kp9UHRhGR08DIxpyIhlYA3z7fAee3uNBUoQcgrOqwEakQdO7sLK57bYOmPveT+MA362Gi4d7LqCFugx3einkbRxWL/kT/1TFWZKfFzkht11/3AC0SHGBgHhCyMdBm1Kp4SoXqms6BidX4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFIxcW12aXZHMTlFRDlGNUhxZHFHRTNnNnFjNUdudm9xb1dvUytOQmJxVEtt?=
 =?utf-8?B?YVFTNmxGSUpRUkZBSDltK1E5Zjg1aHAzQmk3Qkw0TTN0TURNdjkyRUdxTm00?=
 =?utf-8?B?VnFZaDR2UWFUWEhhRlQrdGlaMWFnZzZ4TVh6VHdtaFpNNkMvaHFTWlpNZnFh?=
 =?utf-8?B?WllPR2psbkdibUdzL2xxM3J5TkNja3ZlaWZNazNtaHAwT0p4cURjNWNxR1pN?=
 =?utf-8?B?eUR1NjdweVZOOWtSRGQwSkZ2VzdvbHk3a2VQSlV6QUpya0V3aTRrTkF0R1I4?=
 =?utf-8?B?OENYSDF3T1IyaDNBTnRKTmFXNjBNSStUSzh2dWUwMFpLODZvRWhHNEFPM3RF?=
 =?utf-8?B?MExLb3luaS9GVmV4RnJrSWZmOHhtdC9rMXlhNDU1MkRHK0U3b3hWM2xDZUpJ?=
 =?utf-8?B?YmFnczM1WHh5WUxzem9ZUFAzWWZsU1NlTlRYUWl2cjc0NmtkbjVIekpOUUNm?=
 =?utf-8?B?Y3Vsc0pSWmJlNko0c1E4VlhnQmhlU3lDcTJ2bkhjVUMva2FHTWRGRG5yWWVZ?=
 =?utf-8?B?TVg1MkhOaUN0SS9HUWpNbS9hc3JLbjNzMlRsd0w4M2dSUkM0L2JLaW1RdTBz?=
 =?utf-8?B?NHNhMFFQOUROV2s0Y1pNcmR1eG9tZHpSOUhUTUFiNVhUVVk2MUxpeGtxOTdE?=
 =?utf-8?B?c1ppaVJSS0lDRGxqVVhOL3lUUXZrdk9jN2VtNkV0SHpuNGVUb2RUYWQ2cnJn?=
 =?utf-8?B?MnZhdUlWNmI5dnc3MDVGT0c0WEIyYXVHeGV3bEFLNVNubzFzSEZyQ29UYVdy?=
 =?utf-8?B?K0MzTXZJWTZuams5MmJyaUY2RDNqOThmVUp6M0VleVVGWEtud3I0ZE5EOHVH?=
 =?utf-8?B?ZG1FbEJQKzQvUzZhS0Z2NVhWS3lMT1BqZzlzcmZ1M24wZElUYU9aZVpCYVJR?=
 =?utf-8?B?RHRFYlZkUWFPTFZRNUNhL2puQnNnODY0SytSSWVyT0cwZWtyOS9HcmFHSmVU?=
 =?utf-8?B?MXNXYkdZZys4QVhQU2ppTU0xem50d0tTRnhTejRxbVpsQ3ljMU5NYm0zZllP?=
 =?utf-8?B?TGQ1MDBwZE0wUTVERk9IcXJvTStpL0RrTlFLdE9vTzBlV05xMjZZVlhuaWZw?=
 =?utf-8?B?SEF0dElNUFVPVWpuaUVIOUJncC9qMzJ4ZWRZRVVVamFRWTI3elNiR3krZW85?=
 =?utf-8?B?bGY0ekVzVnE3RE9FdlFnSEFtUTZLMkdwSkFHT1FIQ3MrRTA4K0FJMXRWNkx3?=
 =?utf-8?B?STBvWFRTQWJiOHBwNkd4ajdRRjl2M1gzMmxnSXhCb0Z3SkpHU0ZDUks4VDNW?=
 =?utf-8?B?MjhLL3N2Njg1cnMrVHFmeCtLNDAxWDVjZG5meFFmdGhtdFRCM1ZDNDZ3eTkz?=
 =?utf-8?B?WVpKOGV4SnFDR01hYVNuRzlKa2dDT2FXaDllNDN0S0swbllqR1ZmSzhSZWV4?=
 =?utf-8?B?UHNlUE9Ha01uRDVoUXN2elZDSlpyNVZhVUlOVTViNWJMdDhadkNkWkFxb0Ey?=
 =?utf-8?B?TWV3anpxUEpvdWxDa2d1WWhwTDhwMVlJTUt1Rm1WdFRCRUVsS29pK09EV2tO?=
 =?utf-8?B?V2RNanlFbGZEUEExZkU3MnpNRDlXOVVRWW9CRHR5amV3anBlbUh4QW55Tk1r?=
 =?utf-8?B?MjBFYTkwYkhVMjBiMVNPbWp5TlhqOEhaU0gxVUxtc1ErTVZ5K1ZVbUNLN1Ey?=
 =?utf-8?B?UndEOGt1VExFVkdIR3YxVkNOemp4Wnk3NEhFQkZpTWdPUnNYTzVFRTF2bGJI?=
 =?utf-8?B?QndFZmJseDAwcUNFclBBMmVXMEQxdXQ2ZVRvZ1kxRFEwUmUwUFJkNnM4RE5p?=
 =?utf-8?B?QVROTUJvSFV4WDRwUTh0SFlDOWxTdmViZ3hHb29naHRrbEI1RmRzZnB5eGw0?=
 =?utf-8?B?UlJNaUljcGpyblVHY21YNHJMUXc3UGVUOWlXMitOeUxPK1dsUkdUWGtRYUlE?=
 =?utf-8?B?UmMrTklobU1ySnlzc2pZRnMzaWdIMTFRaEVUNHMwbHpPcXRIdzRmajN2SWtU?=
 =?utf-8?B?MjNPenpvRVNxQXZRYmNkYkhvOTd4UWl5QmZPWlcxY2pnZUlic05sS242cWE0?=
 =?utf-8?B?SDk4Q3htY2RrYVNNdUFxTVh4NlZ3VzNuNUMrOG1CMEpDai9OUkN6aEZLcU9H?=
 =?utf-8?B?REJSZjVQUGNQU29VT3ZDSW1pLzBJblA1YTZFOEtjV2dtcS9Wbk9VM0tuMlZW?=
 =?utf-8?B?VHJLdTltdzdObnNjRTRMVXB0TE1rYXgwWGJkamJJTHFrYzFPOEV0YnZDaWNP?=
 =?utf-8?B?akhyU0ZCTjNMbTlKNFlXMnhsSU10bTJJbXhwOTQ3OWNRcUdmVDVsUERmSFE5?=
 =?utf-8?B?azU2OXRFdGVpc0J1UUtBUXBQOFN2aHY4bnNrSStnM0I1VnpDU1NBeEFxS2JF?=
 =?utf-8?Q?hJyv6w23w5ICB/MNH8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d28e67-145a-4f58-7f69-08df02369f44
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:22:53.7831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REluJCYg+J38WkmDShGSwZAsvGR96i+tyUvhOBj60PB6/nKPuF4bf70fdgWEqT3b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

> [ ... 21 lines skipped ... ]
> +This evaluation covers the ACS controls that govern Requests carrying an
> +Untranslated address. Unless ACS Translation Blocking is enabled, a Port
> +with ACS Direct Translated P2P enabled routes a Request carrying a Translated
> +address directly to the peer regardless of those controls. An ATS capable
> +client may therefore reach the peer on the direct path whichever mapping the
> +kernel selects.

My note on the cover letter applies here.. A user of the p2p subsystem
kind of has to issue untranslated strict ordered TLPs otherwise the
ACS analysis is not correct.

A translated address routing to the host bridge for a peer device
still requires support in the host bridge to hairpin back out.

So I would prefer this is clarified to that that exactly, using it
with ATS translated TLPs is not defined.

-- 
Jason
