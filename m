Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779989;
	b=YPI3bU0/+RxS99wxZjOOE2pzg8GLfdnIIgRivdBD8C/MhBv0q8BUsjZ+YzoyBN4QuXCv
	 Az5B3dp1OHPrLhAwsVtB9qpd01L+RYnZ8F6gNWDM9umuXsBD1X1xDiEp+9dxTZJcxiexQ
	 wFwGZr+AogYg/lS01eNpAlQO2FCRpzoprxiUFWUhjdj1jbLibE/dva2urV2fJAkmRcXV3
	 DMiC3dfY66yKeYZpQrqN2hslfui9a/gd5qltybBn/aMf0gf1BdL/vCIAh0Klo10Bxb9yn
	 Fs7OOvVQvIXPT/j0FIuyC1g69blOOQWx/cffkaz8Hh6WMoKlXuJzLyZA22Jr65XLBQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779989;
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
	bh=yEqgGd3/VJRA2mdAMBgBqcAtTSIdVc+0B0AQkzbsaOE=;
	b=bj8UGmR9xVkzUZHsvNcoTHULw4MstDCt/OmOppCMoVUx+WBejJUO69i17BggHhLXyOGp
	 AZJI5HwFLwITp6X9CAFvY8cIMcuqW/e9lZ99nmly+2jWpaINeERXA9AhqZTBsnCuUMjVQ
	 Q6M6gl8izLeNuO7Rx9NSLwLhxk+7m/dGR1NngLFjqtcuuTP7Lr9eKV796gIIrGRbIP3ge
	 zcXZbM6h3sdNe7HlKGptNId6IfxnV9SjBSYVPYfZd9ztUIY2A7oov6f2+ks3NAR/NZyru
	 EuFq4YYa2toeKxbGbqZJGmCxeDYdu87HY6/8v/OXVThOeylXTRWKJlUDWWXcp4WEFaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kA4lTl+F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.61
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA5606A32C;
	Fri, 27 Nov 2026 11:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55BA5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kA4lTl+F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hH4I8r349mTtkY6pFyCIJ4oGGqclaeACiEDXgdAX6s3BirElTVGkGn4PDG1RJRvTEaQvkGFEL0d2zB5Sk26CNVpCLbii6k4aRZdV6I3DCJt/PX32+EQDSV6Lus5WZ2MP5Mb8t1CTRA1fpTLssVvjasxIdzNtv3emwfNx9BewGYSmmYtE6i45XG6R/kXNLSaYri5PynUf3cZCPjqVOTqeAX5LYhK2M3fjvtXB0mT7fLgDdwJ7IG68esWTt8kl/o2dzzeKNG6tJTqWCMlgb9QtjOIpu6Vs7GPjD4vdaChZwHvTKSsICPVKeFJRYCMs2CEIAKtYr0WXgeqwMJ5QUrwwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEqgGd3/VJRA2mdAMBgBqcAtTSIdVc+0B0AQkzbsaOE=;
 b=NTATqNzj/+YAeVNzqVtby28Xi8AZnoodvu5RC+3IKzgjxDAcARTa+M+63UzaVdNEaYl3+Z/MpyHbWNO8jfFHzIVE+rx8VQGW8mw0Jq8q9PDafAv6ci6nEeCHJc1WtCGS2sVCMFbctRzDv1xxHIKdoc8C9mjDYla+fyuHZXVjDaY0wquaO1lgOsDdQLj/U3f5oUNhPU4qL4p4IA+KHOtFDTmwT38/TeloEdV/1HUFigkpWga4phEi1JcwhdrlhQxpI7auKQDJeMqr4sQUJEvNjebokzElCBKFyfgVcrEGKajizN64SgqO96HXMJVdQl0oAP4NtQ3TFibKGdGtUoSLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEqgGd3/VJRA2mdAMBgBqcAtTSIdVc+0B0AQkzbsaOE=;
 b=kA4lTl+Fs9zAspxPcxPmKyYNvnbmIxV8OcUAO3pgFqulZRVWuWQP9YdAvIa3bkdvE7KsFIS8MdBWSKF0CT0sTRdP1+aZnl9peOsoq0wPSgtWszwcPYou4dt7FTFlbcXse6Lj489U5ynqVX8LIuPBpkMhVxCrRmf7f2KVwYM+l3EcHgpvwJkW0IpD+As0uubdGvQKr2kdwst1lcFY4rNRbcqHI+cB9XaL8xk2rZyoJ105fL6elglOUTvTVy4eNONDtQaiFTtFOTZ6yXBEugszvO2QkrVwWPSsxymQqoaG11q84cmNW0H+BmiLkacFEwrvQNI9oYMjQcMLTmyy6SNVXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 11:46:25 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 11:46:25 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 27 Nov 2026 20:46:16 +0900
Subject: [PATCH 1/3] rust: bitfield: add missing doccomments for associated
 constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-nova-gsp-dbd-v1-1-0fb5f7c2ce63@nvidia.com>
References: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
In-Reply-To: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pci@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0123.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
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
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fc58b5-a9be-413a-1830-08df4c7c108c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|23010399003|921020|10067099003|56012099006|11063799006|261021121427099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	52/btgTHagzc5+kkvJ8sLT9YcbnrZ+G5UW9j8WD0B+sB6Kr1athWScnyweaz7bHBJ847LMdcslWVKVdd4J4OU1ycRA4MFbZIbur2k3fdSRhXZnjj0/00c8y4NEy8qwLJmysAEFC+xj/BBCkOjv2RWwEAvvKOTayvITQdAj4MS9pZRSo7th5Ix8P2Ouv8jJT71TSmQvk9KnhORa7LWSL9jpq6M7SbcLQJzC7H0BWNIeJ+MAQeNaV68DxMxfjJdXrlZUg5m8Feb6ZijgUFfFybOTWZOADRZAl9QeMH4G3TpGe0xMb+nuXsAMZZbtoJDc+OxdhlWRoevTjH1LoQ42Ot1i4BpQOweo8Qa4/JJhxKn+zoEHyAz2v22PZ+lrsV4R7SkeRr9HSrLwZBcb0gxiZeTIxYzXO1khs+k0IWJMKnk6gl2L3Ww6x2LBQvwZdmlMnM2QJD9oGxdiV4o8lKN8m7jKHcuBWBR0F+170mWsJ0O5NZAWNlHxhsceKQSJIee2quWrZdiTEvoRKaW/juw5TbfrfTiUI4xuMyxk+6rNZqf8fewUSxka+dr30GMcvWu7ypwNiqH+NUdzRmQR6kmAUpoM7/cilXN7EqxJp1jTUvz/JO5xXFyq/aisauW6jGYlsx/3a0d0HDTMAVmK60fmbz+ycXmmJM/VH2pqsLRhcipsjfGHFLgUtAFXo/Iy3sLW0XZIg8Pr+Vs5Jo73N0Fx8N9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(23010399003)(921020)(10067099003)(56012099006)(11063799006)(261021121427099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlRsYzF3VU9odTh1K1hNa2ZKdUE4RkVGemtwMkNyQ3N1UUJiKzJHbndjdTlw?=
 =?utf-8?B?YzRYdU5XcWlHVFo2cXp5Q3hheGpXbW5KSzJsdXczZk4zSU9MYjFuQ3ZFK0xj?=
 =?utf-8?B?dzBnSzlEOFhWUUZmVDk4TmFlNWtuQkR6SnVOcTB2aTBVSTN1RUhyWXB0amZu?=
 =?utf-8?B?YjhXemltVzc5eTJFbFlMcEo3Z3drZWp4bHhVa0lJZm0yTDlDbTU5d2tLZDA1?=
 =?utf-8?B?TSthejRqSUZJTmF4RkpqRkwvcVZZVzRZZVo5R1FPbSs1anZyS1p6MGRlcUZa?=
 =?utf-8?B?NmVmQlZxRk1RMGNSWTZhYjlhZnpjdVl4aThYV2JGekJ0R29vUHlRZ3o4TjNK?=
 =?utf-8?B?YjluOEF3YWVicnliYUN2SnYwSVFGcUNBamYyR0JtR3BaTUpvU2lMZ1J4SHU4?=
 =?utf-8?B?M0hWeXhFMXdqMUFSNlgwYUNLWkZGMi9FeVRCQmpzMlc2eEQ1TnhLNUtzYWVw?=
 =?utf-8?B?U3VrVGhEQ3NjaENVNmJSU3hMTHA2dWZ4QXBON1ZhalB0Q09DaDJ0UmR4Miti?=
 =?utf-8?B?NG9MSW5yc2lsS2d5RlNRSEVMSVVPL25rWFhnZ2gyOTM2MHNjeFZnK2JzWmtG?=
 =?utf-8?B?N296Mm9HMXJ2MTEwL0pvMDJpWi81V3RTZTNHV3JJRjFjL3Y4WExXK2J3eTI0?=
 =?utf-8?B?SkdWSkl5cTNyTHZyaVZ1U1dKRUorZVVtbDNXOWdZL295alE5RG4xVkl3WXdW?=
 =?utf-8?B?VjYvWWxKbGlhUG9jS3E3L3MzajVzVEUwRnQxbkdDZDdLK0ZoTlN6bDhnUERC?=
 =?utf-8?B?M0ZTU2pqcWRtQ0UxaUZCVFRIT0Q5REk1aEZBaGNLUGFQZUIyOXJpNUthOUtB?=
 =?utf-8?B?eXQ1a25FSlRUVFZFSUZPR2NkY2RYbkt2RUhoU2p1QVpoZ0kxbGpVWmQrWlls?=
 =?utf-8?B?V3lkUU1GZkUwYThVZ2E3bHhhWlFzNFFVcHhqQlFQOWRxQTMzQ2pnV0NXNUNH?=
 =?utf-8?B?ZlpldVMveElXb1RtN1dxcmtrSnVQMmozVWxpWHFUdFZJNW5vcVIvZHFJTU9l?=
 =?utf-8?B?dVMwd3c3MEIyWGYxVDlnSnpaVU5nSnNONzhPaWwwVnZUMHZjOTRtSUVLYmp0?=
 =?utf-8?B?dlA1R2VlN1lJZ0UvaFpGUk00cnM1S0VSNVBBQ2N2NGw2QWFPbFo1c2FaM2Jy?=
 =?utf-8?B?bUZiTzRxQU43Mm5OQWpuNGJzbFVkQkUySDRmcjloWUVKcFdLYW9iRUMzdFl3?=
 =?utf-8?B?bHpyQkpOUll1N3BLbW5vSjBydGh0RytDNkpqbHhoT2ZTSnh6ZEUvUVlGbEsr?=
 =?utf-8?B?OUoyc3hoU0RHMVFkRXU0SG9hekcyQmJSdUdWTWNNdTF2QzZSV29LKytvblYv?=
 =?utf-8?B?dVJqZml2REVMOXV6OWl6STNuR3Z2ODJqVnhnbGZKTnlPVDUzSzVNQmlJaUQ2?=
 =?utf-8?B?M1pycDBoWE43Ynd4aE5KN2lnZFhneG1LditrS3hOT1p2UVA0OUVYd1lra3VR?=
 =?utf-8?B?NnNvcmczaWg2UHNrbnVFdngzYm1tT0dXUVZKYmhvMjJuTy82aFVpc2UxRHY4?=
 =?utf-8?B?RUVWK1VZampCY2pLb25RZFUrOGZzb2lEcHJrU2lMZmFScmdJVFR0ck42UkQ3?=
 =?utf-8?B?NzArZFBVNnI0WjJKMloxTHdjOENuU1lWWTJxSDBna3RlanpNWGswbFNIV2hh?=
 =?utf-8?B?WHpIUFkvV3JQbHBjS1VNL1lXV1dUd0FDeURzbU9EbS9uMFRQSXRJZjJwbklC?=
 =?utf-8?B?TlI4QzJBNTJ4QUZLa0lHR1BlRkhYdGhONlgxSjFNQTlpYVhENW84NWVpWmk5?=
 =?utf-8?B?TSt0U09XTVhwaGNSTEdKYlJHYjhHcVhTSDVJYlR1ZkZZSGVhVXRiZENqL3Ft?=
 =?utf-8?B?MnN1U3FVcHlENVc3OWluZS9pWnB0YU5KclUxeHFnYmo1U0s0QlN1VWNnWVJH?=
 =?utf-8?B?dWhBaU9zbGZVK1BOK045eFl4QmZYSHpza29aN29VRnZNOU5mSk4xWmQ1M1cz?=
 =?utf-8?B?UDdPaE5UN0lQTXdwcGZVMWpGbmZWbGNPVGJvdGVrV0JMK2l0YWZCeHRmL3JF?=
 =?utf-8?B?dUpiaVVWRU10NGxGdmhBWFd5cTUveEhTOU5Yb2hXQkFJY1JFWDY3dmFUaTZ6?=
 =?utf-8?B?TEExSERWamNwQ2xibGx0WHZtV3c4OG1GTGVjQW9nL1loa0tCak5oTzNwRDkr?=
 =?utf-8?B?U1FvT3NhKzliNkJtdWZMM2tyYVd5Zi9VcThJWTJRSzdzVlRudTR2c3ZyM3ho?=
 =?utf-8?B?c2R1SGwyWjRybVpNRVV0TnQrZ0dZSElnMHJrT1d4cytwVGcxVWo2amZTbkZi?=
 =?utf-8?B?WFRuSWZIdkNBc3dvMWpuOVlIZEROTExkT0lpaVVRMDJNTzBFS0dlMVRNWGIv?=
 =?utf-8?B?S1hCYXVpR01oV2xlYmFhZGlQS2ZyVW5PS3F5ZFZBM0NMakFvei9JTUQ3NStM?=
 =?utf-8?Q?cmGfGUo99Jw6IZefK57xSo/tWAwHePAKt7YczIZQMyu2S?=
X-MS-Exchange-AntiSpam-MessageData-1: jImj48nadhTRnA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fc58b5-a9be-413a-1830-08df4c7c108c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:46:24.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWXJ2ik5if8GERzb7YYhxQupTwDcqyP/Fas+LHHUJ4gjLOVkhsYz14mFzkcUBY0ST4oYtBJNOQ8ZHh1b4sdEuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

The associated constants describing the range, mask and shift of each
field do not carry any doccomment. This triggers the `missing_docs` lint
on bitfields declared with `pub` visibility.

Add a simple doccomment to get rid of that warning.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/bitfield.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
index 8d7d78175336..22b1575c177c 100644
--- a/rust/kernel/bitfield.rs
+++ b/rust/kernel/bitfield.rs
@@ -386,9 +386,12 @@ impl $name {
         @private_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
     ) => {
         ::kernel::macros::paste!(
+        #[doc = concat!("Bit range of the `", stringify!($field), "` field.")]
         $vis const [<$field:upper _RANGE>]: ::core::ops::RangeInclusive<u8> = $lo..=$hi;
+        #[doc = concat!("Bit mask of the `", stringify!($field), "` field.")]
         $vis const [<$field:upper _MASK>]: $storage =
             ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
+        #[doc = concat!("Bit shift of the `", stringify!($field), "` field.")]
         $vis const [<$field:upper _SHIFT>]: u32 = $lo;
         );
 

-- 
2.56.1

