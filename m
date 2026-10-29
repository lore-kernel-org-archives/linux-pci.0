Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793244909;
	b=NPvuXtAfO6zIo2tP8Kn1KhahGMa/Oras82rVgPwSNlGaKk9sjcdISk5SNYRSkdkuSXfk
	 AUp4yxBf07fRB1CyE1wf5JZQNhkMoxXypX04fE37wQyqQTh5sIPMB5MLTMrx/xMbYkeD3
	 lXR316eqxEt3eeSnxHe6gnbXIP+ACSTKv7DrAhpBTPWhVY0G3NOjCsf+c6bTbuqe4A3C0
	 WsRJjsBh9tlEsQzxj/rp8l/TDo5FORmpX6CwOhqqZwanbtCmYkV2YzArG5SyaNrT4S/Tq
	 jsMyyn3jAkHJVQS2mqVp7hu484OR/EwIeO7e+uDNd7l+p6I6Vrwr6oIldSRHLUnLnMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244909;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=uRPjkqBgC7NYpk8OA8MPRNqn8Hgg9Oe3VdAQz6MvKc0=;
	b=pwb6W7Nl+k7A3MF7CG6+ytcu+SvgtrV4njEpf3PRZr9vpi2MgTsobQQXob2B/VUvdczS
	 rqifqlvF+/fbxniLkqS69U8BKvbtovyQVs5v8K+zYJ1/YuO0bVxHSYn7LPbv2VjTPlQJI
	 MbxSRp2gAGdcfWMmxeftMdrcMgoEEmV5jcRzqiNYSfTFM9uNzBCA6elPM6B1Znmrm+obA
	 Z1rmJ37o36ikpujzwxfyxVs1WKegq67fRXtvz/ADedNQVfvosXTPyc2DJrZI+OmDHcj3I
	 htEjOm/5+NawLORq8wCwzdPiVXMDhG4cUB//PCpBFAIttxVP+LFQHZk/YZMGTN+L1xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M4sIim6O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.39
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAAD606A31C;
	Thu, 29 Oct 2026 03:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CAAD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M4sIim6O
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVNcpVUFDCHD25uH2DiT+5IOHoNdejMyF23UtDLeyyt25DTddN/MwX0LUPLaiDG+qlUSdJGOlOslcCs5QKXRUtQpKlbHED+24xVWtx+NgO+Co+It+wPaQrhgW4kAuNUhJBfErqKhv20lVWBpxAtkknErFVF32SV02Z6PKd55GK/71Dd0Rlr378yCuA4il+gbJJ/G480xIaFrycDfAiycSFzEHoesRu6iog4mrEBXBCyhmgpgLBt/PzhgqbEyqPN7dlC8Ui+vFz8yPfzMbrfw1fqg+KCGlkJq+FUwyaJkfU6mytxdcJoqUu8qZJ6pv4trqaSxuNRLEbfiVaaKoa+KhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRPjkqBgC7NYpk8OA8MPRNqn8Hgg9Oe3VdAQz6MvKc0=;
 b=TcVIEqtPRTF/5bozDlYlDV+up4KFIWJoHqFZhccnWzfxeIvsDcXofpLd8D0cNzqCtm1yoTtUB+GyGXDAykorWsufA9iBoXmaLzOt5dU2FFPYC0+EjWVu4l4HJhLp/gBsePw+/Zy7cKJmgbTq3z0ALUyBz4nnErRLij0WZppzFZSGnbgYxS8z7Cre7O1B92ao5rjqJFX0hr2p08HyYix+K28pVAW8dM28zOwLrEQjg0ipChxwvxl/Z6h0deBnvHPey1Z1JPO5vqtHhNtk8yUCyy1gqKPdjhvbDS/FuW4AuXO9aS5gktUqWfIJtqgLqXwKg/eDNV8yIRiKR7Jw+FLdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRPjkqBgC7NYpk8OA8MPRNqn8Hgg9Oe3VdAQz6MvKc0=;
 b=M4sIim6Osk6EnCnxMX8rzynp1IyJYvMj7k6RfIk2FW3bW55Y/rXcUNrJ32Ie+K9vXScud36ka71gXRfRPITjTDO0dVHr8AvgI6dK+d9sEmJqYwJz2FvJsMft6HEGWuu3rsvTsXXPdGIlg/KYf4qBA7bga1NNdATbTdplAl2QHd48onUR9oBOdj6EdUk2op2CZuw36sJ8//hPnP/kLJ96NUO24ywEjza9C2F2CHuMKgPVBxIeBa8w2B7EPu16P/sjNbxvdaVcEzLw368BZFJya93h1errvCmn/G88MqQR2l1aUbw3EPrCIZ6q0hjEN31KJ2w/vSUkhkwZP9WkcYM2CA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 by DSVPR12MB922022.namprd12.prod.outlook.com (2603:10b6:8:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 03:35:05 +0000
Received: from LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350]) by LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 03:35:05 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 29 Oct 2026 12:32:06 +0900
Subject: [PATCH 4/6] PCI: tegra264: Power endpoint devices before
 enumeration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-b4-t264-igpu-pci-v1-4-4d843dda0b02@nvidia.com>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0160.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::7) To LV3PR12MB9166.namprd12.prod.outlook.com
 (2603:10b6:408:19c::13)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9166:EE_|DSVPR12MB922022:EE_
X-MS-Office365-Filtering-Correlation-Id: 471df4f8-1080-4af9-a636-08df356d9f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10070799003|921020|5023799004|11063799006|56012099006|261009223327099003|261009220027099003|261009221727099003|261009221227099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003|10063799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	lEjS4Us9Ke6K2zkpMuMOmZpYCiMTejQVg2LrJVlvhq46gBkJdfKHIIEBCdjuvYcB4z/HS5j8jvZ6teA0lZb0bSTp5vbBQCER8TgXxYAOUKH/QrkU+HtNycL+kECVXcMBU6vrZwRuI3niaiGIRDfeQIJiCfhGHXmx377UAluFsf3dS7+k5MFRCNjOiLvP/cjkCdey5GtfunfHqGrnj9MGkAEFPkEf7s1TkxSur6Yt1ofII0DKLT9Wkrf0+P8A1Ds0czeTIk7jL/bYpfi0dXYJ2zGmudcHZE9UNcmga9ZPE0KdxN+Dbs2OTUzyUXpba7esr3uw+B1usT+joOjbF52DSDNtinn6uKICXGLuJm43LqFsdL8oeoqpJSeqpj+6HkqN1wvujk+UaIkbn2uXwM3qOVdmvj403sMAdehLgP2wQJ0cV9H64ejnNZmPdC6XLjvi/GHh/8I/nEY86YDbU0vsPuxtwAFhD2nlnsNOZNreKgCFuTeT1kSKzNX3oaZaqcxDj+XOJZ5YArSyqvqwYAQue7cE/9h2Bf1q3GMKx8KVXqH/Ng7PKp6/0ukiBhdhsneSbkNWUuB2DotVNR8IBOJSKeegBrEjxAhfo/kIa/uFa13fB9+4o0Eq33nKVVoXOqogQcWEOWXYcDsqB3ddV3wR3gjxEJv3Og/LSD0oeklbOWTYOe2MTMd8QCMBJP5Uk7YrQwSDHqccaD6HuASfe9AqhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9166.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10070799003)(921020)(5023799004)(11063799006)(56012099006)(261009223327099003)(261009220027099003)(261009221727099003)(261009221227099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(10063799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nzh4eVU3eU9venZsVzdMZEFNNDBiVFdSQ3Z0R295eGhHYzNxTi9Sd1p3Q0JY?=
 =?utf-8?B?WmlEYUtsYXhSb2daT2MwMVVMUWRxY0RKNjJtMlNqSmcrUDNoU01jMG84alpo?=
 =?utf-8?B?UzVDUXczVzBUS21rU3E3cnFrdjdPOFRQZDlqOGpMelp5WkFkSE42UjZkdWJm?=
 =?utf-8?B?RjBMTDRlR3l1dzlZakhvOEYraGpHRHpvZjVoMUlKdFN0QnRzV2VYM00wbnRw?=
 =?utf-8?B?M0R0eUdCV2E1YkNVdWtHUnRuVHhXR0l4ellDSHFDSUpZUDhSSk1xNy8zakNk?=
 =?utf-8?B?ZEV4YkZqS0hVcCt5cWp4Qng1dFNzVGFYaVJLZ0JqNjBMMkErM2Z0cUFoVWxY?=
 =?utf-8?B?Wm1FQXJ1eVJyNktRbS8xd0xxMDJWYng5YzFkaVpqMk00akdXcldqc3hVRjFi?=
 =?utf-8?B?c2xWbmwvbCtWcldBb2J2KzBZS2FCMDBUb1pjTlcrMndkRWVudnRsUk05Zkx6?=
 =?utf-8?B?S1lmWVRqTTFOOUYrTmF0QjgwMXRGZ3lZeTdEYnNBUzBiVkhUY3o5MkdUWFhZ?=
 =?utf-8?B?ejdoc28yZHRTR2JuNklvK1BsNHcvbGNjOXVhRWVPZUl3aUZSQk1wZzJJRFZj?=
 =?utf-8?B?bjZ1NjBsU05lRkdzWHc4QTd1SGhDRkMya0llZHFxa2tBUElFeVBhamtHWjFx?=
 =?utf-8?B?TE9zOEhoSE5TcWVyOHIvVmRsSE1LaVNGZDJGZnZNY0dsMDV4SFVHNmxvTmxP?=
 =?utf-8?B?bzg2RnBucllreW9hTy95bk0yOFRwZFJaUWhaSGpORnRMdUk4R29xV01SWm9l?=
 =?utf-8?B?eVlvK2xVeUxNdmtNS3UyeGFKQVA2b3p3cms2WG0zZ1pVYldBUENoSGVvdVFQ?=
 =?utf-8?B?KzdBT24zOUthL2JBdzBPNG9sWlFqZ0dhRTljOXNNUUpKRWE4emVIdUVTdFg1?=
 =?utf-8?B?K2dxMHlpVzk3YnpvRDZETll2dTNaQXFjZStrbUI3NVJBMndTM3Nwc2Vaa3po?=
 =?utf-8?B?U0VVUjB5aHJkVURtT3U5UEw0VkpyL0tjaHMwaU80QWhwWWoydjZHV3BTUklv?=
 =?utf-8?B?RzlqSEJkMXFMUXNpTkwzZnQ4RVpERlVqWFNjOGFwcTRyTWFzczVXVkk1anJo?=
 =?utf-8?B?WHAzc1hHWnlHbzkxQkltNGpGNTBjMWlHM1FaM2pPUDRkSlJLcHJiWUFrRnZw?=
 =?utf-8?B?a0s0NWRxTk1LNnBaWDZpamhvN2c5bVB1VVJoSnVNbHJlZkN6cm11dmp6bzF0?=
 =?utf-8?B?WjZJYlMzZFZKdWFHUC90SDNQdysrSWhRU295TWlZTVhoNFlzQWpJbGFxVExy?=
 =?utf-8?B?SnhDV21nb3Y1VkVmMmdQc2FUSVkxWGFOV0U4ZGZ0dlI3SmhLbThsV1JYSGVL?=
 =?utf-8?B?Ri9WSHplK3RNNUZPbytMcUR4dlBEVUxuc1BOUmlvU2hNcVhvVUVmU0ZaRXda?=
 =?utf-8?B?Zk5vRHdQbk1EWVJEeVhsWVVzRFQzWnhmWC9VT08rc2FWTk52ejVuLytzdEJh?=
 =?utf-8?B?WDZidEJPZHdTNFpBZHpNenJTVUp0UklFcjhibCtuL216UGM2UndmN3RMek43?=
 =?utf-8?B?SVJQdnI3K0lKTnZxYWNqOUg1bUY0TWpSOEpPUTI3b2ZGOHFSNG84V1gxK3A3?=
 =?utf-8?B?c0RlVjBhZ29GdjM0cG9XTkdLZ2FsL1A4YWpkSWVJMjhNT1FkY3FwWmZiSHFC?=
 =?utf-8?B?Vmc5R2J0Q0JXemJTbHVPUEtwVFQwNnFvemZjaDd2bVNGalIxV2YvNkNjcGhl?=
 =?utf-8?B?L1lsZXFHVTlrblR0bEN4bkxhZGF0cGsrbHNIQ1dSUW5veFE4RWlWcTBmS0Jv?=
 =?utf-8?B?NFZiemljaVRXUVQ3YTlJQzFUYWROZDZVczhVM2I2RnVHTmlHZjlCNkJYaW44?=
 =?utf-8?B?eElpN3hiMkZzelhjY2xXNURtNWQxVEx2WEsyOWVKL0pzWXlTVExhcnpnbTlR?=
 =?utf-8?B?Qzg0T1BYQllTc05kM082SVJMNXFsOVVRT2duQ0RVR3NjWjE2RC9vT0EzbDNr?=
 =?utf-8?B?bG16QU5CSkd3dkhwOXpkU0k0N2VhUFY1VUlGa3Y3MldnakdEVkhXMmMrTEk0?=
 =?utf-8?B?VGdHdUlUWTdyd3JWRFovWEt4Y1Zpd2ErbHFLT3RoN3RhbHlndWJjWGpDbkY1?=
 =?utf-8?B?YWpwRGpCbDdiVGNWWWQ5S1BYbDNEaElhVWJVcmJhT3NkeXdBcElxRmhRUllo?=
 =?utf-8?B?QW9HaU8yUm96d2RmM24zR09HZWRWU1JkaklZdXViaUxqTEUxOVphdkVRZ0pG?=
 =?utf-8?B?NWYzZTZnMGhCcXd5cGlDdG5wRjVPbW5YSmtsVGxxcnFvQU5FZUJCNTZmTVNp?=
 =?utf-8?B?T1g1eEVQVGRGZ2xpRkZmR1hvcUpreXQ0TlV1dWNPNldwTHk2dHdOSlgzbG82?=
 =?utf-8?B?cGpUOGVieGFjQUNyK053dzVveEpQVkRJRlBjYzlHUHNXdHg5MU9RbU1wN2tx?=
 =?utf-8?Q?PYkAWrgW/byvqr4rscd1+UKsZwkfWgDtbfawVg3sDciFI?=
X-MS-Exchange-AntiSpam-MessageData-1: zu12t6Jq8dySsQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471df4f8-1080-4af9-a636-08df356d9f29
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9166.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:35:05.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7oPZImq329Ud5GU8W8fkqrDxl1Vxzix7FWrSBk+ElX+VGjz6E2P3lOxRhll3WTAAr9wjYKRD1hQUD4QL+H82Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB922022

Add calls into the PCI pwrctrl framework to do required power sequencing
for endpoint devices before attempting to enumerate them, and select
PCI_PWRCTRL_GENERIC in Kconfig.

This is required for the integrated GB10B GPU on Tegra264 that requires
a power domain to be enabled before it appears on the PCI bus.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pci/controller/Kconfig         |  1 +
 drivers/pci/controller/pcie-tegra264.c | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index d246bbe37948..ab8cb1be28ba 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -261,6 +261,7 @@ config PCIE_TEGRA264
 	tristate "NVIDIA Tegra264 PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	select PCI_ECAM
+	select PCI_PWRCTRL_GENERIC
 	help
 	  Say Y here if you want support for the PCIe Host Controller found
 	  on NVIDIA Tegra264 SoCs.
diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
index c97576ab4a31..1d65ed5d0381 100644
--- a/drivers/pci/controller/pcie-tegra264.c
+++ b/drivers/pci/controller/pcie-tegra264.c
@@ -17,6 +17,7 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/pci-ecam.h>
+#include <linux/pci-pwrctrl.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -391,6 +392,14 @@ static int tegra264_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = pcie->cfg;
 	pcie->ecam = pcie->cfg->win;
 
+	err = pci_pwrctrl_create_devices(dev);
+	if (err)
+		goto err_free_ecam;
+
+	err = pci_pwrctrl_power_on_devices(dev);
+	if (err)
+		goto err_destroy_pwrctrl;
+
 	tegra264_pcie_init(pcie);
 
 	/*
@@ -402,17 +411,23 @@ static int tegra264_pcie_probe(struct platform_device *pdev)
 				    "PCIe #%u link is down and not hotplug-capable, turning off\n",
 				    pcie->ctl_id);
 		tegra264_pcie_power_off(pcie);
-		goto err_free_ecam;
+		goto err_power_off;
 	}
 
 	err = pci_host_probe(bridge);
 	if (err < 0) {
 		dev_err_probe(dev, err, "failed to register Host Bridge\n");
-		goto err_free_ecam;
+		goto err_power_off;
 	}
 
 	return 0;
 
+err_power_off:
+	pci_pwrctrl_power_off_devices(dev);
+err_destroy_pwrctrl:
+	/* Keep devices registered so their drivers can bind before we retry. */
+	if (err != -EPROBE_DEFER)
+		pci_pwrctrl_destroy_devices(dev);
 err_free_ecam:
 	pci_ecam_free(pcie->cfg);
 err_put_pm:
@@ -437,6 +452,9 @@ static void tegra264_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(pcie->bridge->bus);
 	pci_unlock_rescan_remove();
 
+	pci_pwrctrl_power_off_devices(&pdev->dev);
+	pci_pwrctrl_destroy_devices(&pdev->dev);
+
 	pm_runtime_put_sync(&pdev->dev);
 	tegra_bpmp_put(pcie->bpmp);
 	pci_ecam_free(pcie->cfg);

-- 
2.55.0

