Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779989;
	b=sAsGOvoDpqsLWU8joh22z4AQ6g3jPEkW+f/WOTABXsYwneGvrpmtTdIRplyn+ZIeUbo0
	 hLW9fQvCBLFVfJxgHNiQCjlGZmqmXZwq9nbat+c2pCBe2SJSVFvCCbIioVi6f7DAWcjhy
	 ZjCeB0PblmNIxylRgm8P/mkAd2xHnOVhUUmXIEXI9z+WigV4/Nqud3dMsDtOAY93R6wYc
	 dBGrf8XZk18Tb8LcHI+ohxinMpP5oo/5Ecp/zSFfS08zeXiGjPi7w2c6sOOEcTdFqGT+U
	 giM/eaRTmuAUF+rgUrsIC4FvC2MXLM8yR4pjnqbwyAeY6Bwz/RLVyZqYzV7X8iLgZJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779989;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=/ULIELLMq+slXU/sG9438UO3G5HL8Kylb05qqaO1XdM=;
	b=PdRiMjqEsr6Tn8lehA8XWg1yzQr6LAMGcIQdn5PXXG84fA7FaLF3+k4CRDLnLj0rC6Hg
	 ezdAlhLaO56l8SjO5nlpaCazkUffdjbHo8tpPUhfuUP2HM0zEvne+WTZ4qhRXAkzUlAi2
	 +n6HFNSwpmgs2qigiByr9wqk80XDyt9bKC4f6MxnYbrP04DTZvE/kBnzT7rekJatJrl8v
	 ZslEFZpR0fsoOkX+Q9nCbHMaKQOvo90Z7r66cO9t+Bj7DmsV2xkhEcU3wO0OR65Xl7GwP
	 N4rJ4KW5LzqFKNB4oRBUIwc1nr1r3khh7AgCGJzwaplKTIqDQCL9y6mDm9Rwjt4joEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nIop1Dyl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.61
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C1606A321;
	Fri, 27 Nov 2026 11:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 895C1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nIop1Dyl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLGblmfmz2LE37Fftk2f1r0QPw0lRAhHEGvl02aEqYKZnqqpgPd6XOl3LJ1T6z3SzkolX0w3fULUUvyNnoBLb7zMgzZiO3T176sF7qAijZ42Dp5UI69q2+5BnncnMO6XkWEdBEyDZK5v1tN6obAIGJJKRBKiGMJ1gdMh/QDQLG7p7xuVy8GV6Bsaix4g2yLdS+1hGsSc/gKG8fPwXhWcAglo6aVA75k7WKFFXfvozZE0+apJer33ICmiFYzM7v0dt0wxV3caX9u8PKlPJ7A/0hJsgwuUG70R1Q4DrabXowi0bjMlwB0QJZ2iWss24Zeh00orNtyQcqmrxYIEwrU6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ULIELLMq+slXU/sG9438UO3G5HL8Kylb05qqaO1XdM=;
 b=gsDwc1Jk+GC08ythdZMisfcLxhNkaOXqWwgFhmwTKnqkMiHomTGcejDy1dSo92b5YgIdEVUgC2neji2AS/hA1iEIZ3pgvFv4wyFx+WNvj4GSsNWyUJbFe1atknYleqpvf8o1UX1dCST4fSpjEWgoiMVXl6tiUpiUBdadWrGZ7fO2M5bo2bGoCTzRejTwdofAOd9uhSv7T3mJ0SoFhEMVj4Uxilq7sqVa6XZmhvVuVFVggv+yU6yIPIEZNIuPPDdd0R6R6lVGziFLlwkUa5wtDAoPnMO1dWTc31a1gPg58eIfBTQCSKQ4zjrJj2wc+JEq/WLF3bYn2uIioWo12NfYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ULIELLMq+slXU/sG9438UO3G5HL8Kylb05qqaO1XdM=;
 b=nIop1DylusnsibO69k43E/yMCoW89mpox0BpVDowTnY+1RWNxKe9JVsGYilCQejNBTMr55jTh+gsnqr0PX82iQ5395yKbP7LKlcXTxwPQshBL9CSvP3lbjSMzAa99bhjJZvejivLq9QVnn6VfDLitAuRyKe92qjXTtbJRtcYmQBkcMdzjgqJiGXnH/3jt2k5Iqky9+YfhHe+TxpNGxBx3ff4x5maAAqX8zLZeEUE+KZ//voJfD9d44VMCZApSyYb/XnZRpGEHxvx3UD15SMYTrZk25FawMtseuKHMxa0T5O6sJb5CCiKn/3JLiHcnsKKAH68pbRLQ+uicC9Ls2OhDg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 11:46:21 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 11:46:21 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/3] gpu: nova-core: gsp: fix the PCI location sent to
 GSP-RM
Date: Fri, 27 Nov 2026 20:46:15 +0900
Message-Id: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrE2iJf6uIhaqg7Eo6SAScXfF8
 lu8d4GQZxKoows8HSy8uAAVR9BPnRsJ2QaDTnSulC7QLUeHo6xojcVsSK3ODVVlQhCS1dPA57d
 r2t+ym5n67X3AfT/0xypKcAAAAA==
X-Change-ID: 20261127-nova-gsp-dbd-4f3d26be980e
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
X-ClientProxiedBy: TY4P301CA0030.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::9) To MW4PR12MB6873.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 1dc5bab4-1de7-48e2-25dd-08df4c7c0e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|23010399003|921020|10067099003|56012099006|11063799006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261102123227099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zvaSAHO72AautjtMM9/143pkxt9/jqXI7kmHBZUMw2fPZ/got4wyYgMslFodryZGd9lUoEk61JAk5L6UXUeHbT1rkv/nz3Qtj0ReMGnU+Y4jSAmWQvuohkdC374f2C7PRAvwcyvXbXV68RW+wr7DeiZzTd31AlUnQ0J7Otq5/RplzK+LQ0dWeiAjoGws5yvvossOzZuIpHt34adK09mnpy2vlQ5Bjicigs0lSGjAGLKM0WcHbM4noIxJK+s+cC4XU/NKuK4z99IpsbMQM2IsGJkjZ6UKKUiS8lSK4XFJUMG+gIJVgLctKFB5+MH0cIuPWsG+Wy70CiKR+aT4ySGVfIoOJHJHETUdqP/0+JQXtaCRIq+QyouWkdRwZNWgkgwRxYGT/suFz+ENynpBpn+HkA7NSmFiwwUn9/2kvU2uJ7vzgIRV5AzXUMZ5e+X1pM2nxzLyJSftUrgzuzXUsHLkBwoLIlNH2cHA3eaDZrIo/XnM341ryGoXC/gSYg7pq/FFg2WOmdDPFpWtpmd+JXMfwqqWXeRrxE1yjvRB7VQG6rLWZ/xLXgC2Y9aVHqLLZwVMHIM5EK74ob8NQM1ClNSdzk5mUiazkd479iP0EO3o3tLZDcf0fKJ27E2Yi3H1kEosGwgSng/5aVpYQ2osp5JhKE0/gGM/IBkcnXGZm8RK6VFbyiDLXGCJGcZRaR1E0Gxy6htYV/zM483bEm7/0HU46w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(23010399003)(921020)(10067099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUpjWnF6UEltaytFWE5EMEo0bzlRTmNwTGVROVZqamZQK2h4b2ZvVm1WQ0FC?=
 =?utf-8?B?T1M5Vkd5eDQ1ZUY0Q05PN2hjNEppTHZlOVZTMVZXZTlxYkpRSFlPRjJSVzRE?=
 =?utf-8?B?ejVlT1cxK3l1VUxZM2R6eUU3M2pmOEx0WDV1L0xIRi9iM1ZsdTZYMUtLUDZN?=
 =?utf-8?B?c1NBTE9xWFRsTitQNzVCWXZ2S1g1UDJjemhWaHQ4OTFpVDA3dy9Yc0Q0a3o5?=
 =?utf-8?B?RmxTdXdrOWRVOElacS9aQ3h1MGlxQlVJcU1KTDZLUUJYR3ArUUgzdDRMRnRo?=
 =?utf-8?B?TFZEb1NCVXVUS2k3RWhFdXFIVjNzUE1BM1ViK3NnaDZ5VDB6NkVXWUN5b0s1?=
 =?utf-8?B?U2sraE9ZbUo3Y0gzODUzNHVhRGQ0ZnE1QW1oTk1zNmI3SGlycUJGaTltNDNw?=
 =?utf-8?B?N2RNbnhYNWdNRTVBN0Q2algvL0Rkbkp5aDNXY1V0SmVoaTVpQTBZZ05USVVJ?=
 =?utf-8?B?cDZITjVUSnV0d2x2MjVMcktFR3hZT2JIZnh4eWV5cC9SRzI2R3V3YlB1RGtp?=
 =?utf-8?B?akRBTE0zK3RKM0ZrZ2tlRXB3TU9kdXN3eU5wa0Y3OUlLMTVBTG9hdTBESUdJ?=
 =?utf-8?B?T1NLblBGQWJPTTFDcWc2a3NmVThEWW5TaXNCN2t5M1Y4aUp2bUdBVzI0TzBJ?=
 =?utf-8?B?M1FKaWhXa1JUaGxPby8xemtadnA4UkszVGVJTDRPa1g5Y3VIejRVTTU4UW5Q?=
 =?utf-8?B?K0ZFUlZvU291dlZFVHkxY2pud0ZvbC9id29IcTFLYjI1SEpzTkx1Y1FFSGhQ?=
 =?utf-8?B?bjF6VStkOGkvZGRpVmYzVHVlcHlUVUtvSjN3bk0ycXAxck1SNm1WZkh0ZENm?=
 =?utf-8?B?NFJhdTlqQlJ6eUdueG8yTXRBdldDbjBBME54YjRRRjFwcVN5aFYwWXBuSDNU?=
 =?utf-8?B?TC9sRmZSS0VkU2JqVnhjS2NQSTZyNzVldHh2MHUwOXBJSnBHR0FOamdyaGk5?=
 =?utf-8?B?VXJKUTBMTTNFdHpqVFZUR1BGMHpjZkJtS0JhdDFNNEJSN2FzNktiY3RSTGJl?=
 =?utf-8?B?MXFFWVpmVHgxU01wV1JaYzdibUhJZGZ3RnZjc1dxbVd1SkIzWjhRTzhyRFBU?=
 =?utf-8?B?dTg5UUhVRGxQSi9WNk5kd1pnS0IwS3h6WUhzYmJmUy9PVVpTcmw2UU9ObzdD?=
 =?utf-8?B?YUF0TFkzejl5L2ZEUkZTR2J0TGM0azJxcStYM1VhQ2pwc1BTV3pja1oxcDB3?=
 =?utf-8?B?aFhrSlgxRU9tWWFNRlNqRk9hZTM2VGwxdmYxdGFVTCtQRTJCL0YrNmJTVERG?=
 =?utf-8?B?UUtpS25hckxsZVYwajBPVWN2MlVieGJmQmhDemI5b011N0NDT3RMUXZEL0Z0?=
 =?utf-8?B?aSt6NFoyZlZDbjdJVkYzSVk1SlN1eXdKTiswdFE3TEo5c2h3bWFWbnorU09m?=
 =?utf-8?B?S3ZBUWltU0M3bmtwQnN0V0RFay9FbzExNkt6RkRkckVYcGVDTjZpWmhsdFNW?=
 =?utf-8?B?VExrR1AzMXRCekFKdkhwRjE2bitFVi9HeUNEbHFFbVBrbXZITERyQmQ2endH?=
 =?utf-8?B?dVdJdHVjWjlQNUlBL3ZXSkZvVWNNL01BaHJoc012SThMMTlNSnAyYzNya2Q1?=
 =?utf-8?B?YzJvQ2FERkx4Y1FEUFhXcHVqclRJekozaFQ3TGFmbUdvYlR5N2RyVW5zUUti?=
 =?utf-8?B?RU9WNHl5WWg2TUwza1ZJRXpyK3Z4YmFEaUlSQUJQRFV1dHJxbnRvV1Z5dCtz?=
 =?utf-8?B?Z2M3enZIQzNob1ZRZEJ1dlIxVXI4cWFUWWVFcml0UWZ5YzZjV0M2NE5lZWs1?=
 =?utf-8?B?N0M5aFB0L1JScG4zN09lUVNRSDhmNXE1L080Uk9vdlBVZzJkUlg2RlFZamVo?=
 =?utf-8?B?bUxNMzJNMXNZT0JZRGZ5bjVlOUxJUThKY05ZZ3kxeVE0eFh1amRLZWttT09U?=
 =?utf-8?B?ZnBKT2ZjZEdicjVTd3RZRVA1Vkx5MnJEQjIwUm1TZVpobDF3MnNYMkVuSktG?=
 =?utf-8?B?TW1HZ21ZdTlDNEk2enFlNTlmZGF2VnRTekxFY2NGMHhBQXJaVzk1Z3NqVXND?=
 =?utf-8?B?Nk5rdmNjak45T2FrTkhxNWwvVEFTK25ZNWFQUFJ5K3JrNXhMblJHNS9xOVU2?=
 =?utf-8?B?dEFma3NPbHhqUWNpQzBJNWd3UVdKMExZRE04QTVuNXRpelRwdmtsLzBrYk5a?=
 =?utf-8?B?KzQ3Y3l5N2F4TGg4VHIvNHdlOGx6blpQdG56RG1hZTJZVlV1U0g0K3kwUERl?=
 =?utf-8?B?WUFoaDRrbzg4T3BmRVJtb2c0bVJpUXI5RlpaNnRWeGlYaGhQRW41alVIQTE5?=
 =?utf-8?B?UUVRNkhFT3lXR0tSR2d1QlZvVm00NTNxejNEbHlHTWEzY1NiZ1RMa1prbGZX?=
 =?utf-8?B?cTNqVVRGTGVJWDJHRGMvTDVBZi9kOXhKaVNHS1F2TERUK1dKdW03VW0ycDI5?=
 =?utf-8?Q?KBX8srK0S81KU0cvAlVmmRysOEm7HBQmWYyihBSx0wvgs?=
X-MS-Exchange-AntiSpam-MessageData-1: M/vhbHO7ly0owA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc5bab4-1de7-48e2-25dd-08df4c7c0e56
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:46:21.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4CSJdq7LywANsQe8MgNTzUX0UOK+uHRLbLkc/mEVFZgB/beePyI/CbhP8FGMXgyEhdM64Rt9TzD3MU7Jv66Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

nova-core sends the PCI device ID of the GPU (bus, device, function)
where GSP-RM expects the layout built by OpenRM's
gpuEncodeDomainBusDevice() (domain, bus, device). Both only match for a
GPU at device 0, function 0 of domain 0. Patch 3 fixes this.

Doing so requires extracting the bus and device numbers from the value
returned by `pci::Device::dev_id`. Rather than doing this in the driver
(and in every other driver that needs that information), patch 2 adds a
`Bdf` bitfield to the PCI abstractions and makes `dev_id` return it.

Patch 1 documents the constants that `bitfield!` generates for each
field, which otherwise trigger the `missing_docs` lint on public
bitfields like `Bdf`.

This series is based on drm-rust-next.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (2):
      rust: bitfield: add missing doccomments for associated constants
      rust: pci: return a bitfield type for dev_id

John Hubbard (1):
      gpu: nova-core: gsp: send the PCI domain, bus and device to GSP-RM

 drivers/gpu/nova-core/gsp/fw/commands.rs | 30 ++++++++++++++++++++++++++++-
 rust/kernel/bitfield.rs                  |  3 +++
 rust/kernel/pci.rs                       | 33 ++++++++++++++++++++++++++++++--
 samples/rust/rust_driver_sriov/pf.rs     |  2 +-
 4 files changed, 64 insertions(+), 4 deletions(-)
---
base-commit: abfb640b2374e26de8ff81d488c39d8254db538e
change-id: 20261127-nova-gsp-dbd-4f3d26be980e

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

