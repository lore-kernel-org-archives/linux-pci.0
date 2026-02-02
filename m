Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB369326D51;
	Mon,  2 Feb 2026 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020025; cv=fail; b=hfzLAw5zwInUMby5d0oCZod/zYsdf48aJj7JFOc6puSUHuIoiK/etraOp5S19volWa+mxX4CsIbvHCW7Km038cEyf6x7lz+vUKCHlVwGwLyv8MpvEosGQCXpzU+rTindiQAIeVigZWX5ophA/GetSSKRarl3RM35hobOkSHxIuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020025; c=relaxed/simple;
	bh=zxAa+REJmcm0njEOcm4OYj/KH3PrzIZDivUY39mwd2k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=n+BTrOfdaM8mvitv/9FHQmS4/7kdRIObW9hYh57+n45ICDIRjAgnqkpRfiskiOnHiTA9FkYZpMMdwMqtlLmQI2R9y3ZvcExUVXo8XyIDWPWMaO8f6T6IN/MOodEVyLkaP5yEpAAk/t+bdyfjtS8Bmoc+POdaSQiw6RN6ep65szY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F5UBGe+2; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F5UBGe+2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+WDjGMiS3v3xtraOMRmbSd9N9YaYIcASYv+q1l/YG1lTb9FzaFFdzA2440oGS0xmv+07z4p+oh5KxXcB8vIhf7NmDTYiVa4gx4bA5iV9IjkQ+vCskTHVPaBjt6tTd2dnKdFY3+X1LRbknpaIreuSHs0yLdT42Qes7ACsDgzgAtUgQ9h+tVop2h23TsP9/F4MqPMQjWydwCS5nAe+wdVIkGwOWAi8qNarDr+iGQKfpXBX6TOKqRgSki7aREpewB2z+uyl0CknLez3c5OkOozDJB1t3icKOvWLakzR9q6E791ssCDTcBfIHVL0sEZayGNij7D4SMoFiDlL0AZ8IQfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwFLPFCZ+Q/b+O4RAzsDjtOaScCudqTxeuot9NgiEaE=;
 b=PzumG7x5kSkmRzOhbFhyi/fexQvfBtm2TezNSrZfUtH9B40NxQhQlctor5SgH4sM6dH5Ple0mRvjHTRyuzWjGleWhQMqAN2VQZnf7sdKI9APFcp8pqNbfBYUl5aNvrzKxgJziIuWlaT1LCWOyZe8jFgHXqrcYjeTm32mehuHonjSADpFbwtOGmI54GXSzlaSY4jgtkCm3Sv9clWT/+7YZbMAkbN6KByWFg/tGJjO7Hi57VVwsHjQS8zjBdKfFWTJB2CLuCgAi1lZzdCJO9P930NSTfUY652BWj4smXJdj5cZS/Br3WbHszDbmTQvYPR6MilRI4hX6Y2tG+gsjk3OKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwFLPFCZ+Q/b+O4RAzsDjtOaScCudqTxeuot9NgiEaE=;
 b=F5UBGe+2pMYsWjGxRJPWQYcjrCM5pKrtEEUIIn/A0cLIEUfw2IIP+PpmGruz94ZdUiN3oIlknqebDRFvT2NBumq0W+c5xSWPkPxc9uVErVedDQDwSkQoqFfjnWzHk1L+nqwswuMPBSG8bDE3KdcVVTTwU9ecAmJyoI51unQhmVba/1sxxM6UUfs9LeIh6kLETjAgngJjTcxnRaoiXLibTr7Gy302ldLWlmqRpJCiHd+A80ZWyv0M62lgqrCBnkC7I3xeSNJ9sGp23ANv2TxQM96NMf76BGNF0y3ZNp+i3gAWn1Cyjb4kOcEga1DWqoK0q595/Kk9LMNRPAC7HQuikg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Mon, 2 Feb 2026 08:13:23 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:13:23 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 02 Feb 2026 17:13:01 +0900
Subject: [PATCH 2/6] rust: io: mem: use non-relaxed I/O ops in examples
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-io-v1-2-9bb2177d23be@nvidia.com>
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
In-Reply-To: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Zhi Wang <zhiw@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0145.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: b039d591-70d5-4120-e8ef-08de6232ef38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1hXVGRYcnpBUlY5WFh0UmpuR0lPRExaUFBkSFVobFlNbUd5WE1LU1Arb1lJ?=
 =?utf-8?B?VnpRZVFibjF4TjhRUTBDWmVVMlpPcXIxWDJQMUhHNEhITTlzSEFWMkE1a2VQ?=
 =?utf-8?B?Q3I4UkxnWmtwZHZzdSt6SkpHSVFURGNjM25ML045TnhnUWFjN3RieXhBVkIz?=
 =?utf-8?B?MHlIZVE2Z09maFRRS3dYV0svc3Mwc1RPb3lwcWptS256RHZrQ2xzZVJDYVRj?=
 =?utf-8?B?Zkh6TW5GUVAyd3R5UkdheGM0dVJwY2FFVDZFRDg5WWNkUHByZkRJcGpZWXo4?=
 =?utf-8?B?ZEM5VVNEQ2VCNVhsQkdLaWNndEVoNmwrTDlpdEVvYkFlSmZJN0FPTlJiR3c4?=
 =?utf-8?B?dHhjcmptdGhWUlNUa1Rra1F4U0IxazhEd1ZiLzhmSk5ubGNDU21yY3ZhcTBO?=
 =?utf-8?B?U1NXNm9lK1VhRW1zNlZsb3FpWVgza294aExpaUpCVUtYajV3dm9NQVlXZ01w?=
 =?utf-8?B?WnpVdWM3cHBWTzFxR1FvSzFDVEw0c2hOWERJNEZMNEYrSVNoRmlqUWtpb1hL?=
 =?utf-8?B?MzRJUlIyaTQ0cUozOEZ5emVhRmdxVXdhS2N6T1hvT09icDdFWFQxTU5GVFhw?=
 =?utf-8?B?V2d0UzVodWNGR2l3NC9iNDJzQkd1dGhjVmJwdlYvdEVMTVBQdXkyTHR1NXov?=
 =?utf-8?B?dDhoMkNBS3VJeWI5cFBoN1F0ZWVDR2g0K2tXaHhQRHdVSEVRbmVQaXVZUkxi?=
 =?utf-8?B?aGx6aXNnRjBJZitZUmJZUHpWaWdSV2VUbUkvU3BKRU1Qc0x0ZFQzb3lmaWZl?=
 =?utf-8?B?dXdkOG11MTFWL0pHRkFvNUdTNGVya2RyYmV6SU5UVUxjbmQvL2Zrcytoc3By?=
 =?utf-8?B?SklOQklVS280SjN1aE1SWjhqYlhKeHF3QTRSci9MRkQ4cnpOenRsWFdWd2NM?=
 =?utf-8?B?ekJ5cFZsbUUrZVJNTlpoTGV6SGRTS3lJWVJnZGZFWVNBdGFEeG1HQjlQdEUx?=
 =?utf-8?B?MkJsdFdxUVRqTHhBU0V2WDhXa2FrTXBMVWpsTjdNdERmUGZrcG5iL1JGcEIz?=
 =?utf-8?B?a1JodTQvaGlISmphem1ucWRzMWdtRXBxNyt2VC81L2U4dzVNVk8rcTk3UHZ1?=
 =?utf-8?B?WEJYVmJoWndMcm9ZRVdBanBTcFdreUc2YURieTcxNlFkZG1iMk0vaTBPRTNX?=
 =?utf-8?B?ZVppT1M3S0dkMncwYllSejJLR1ZGKzgwTlhjc0JSczIzRi9BY2JyWklWMEkv?=
 =?utf-8?B?emZ3MXhwTmJkdUdsSkhCRnVDOVBWOUpBK3NRYS9PVEhnM1oyQWJQM25QbER5?=
 =?utf-8?B?aHR0QzNCNnFSOUtXWjNXSG9BTUtpS1U5S3ZKMXJPZkNicnlsWXhuM3g0ckNH?=
 =?utf-8?B?MXBYNVkwanJrYW1UUU9uNHJWRnYzaVc2WmVRa2VpeE1EZy85cW5PUVM0YkFM?=
 =?utf-8?B?UFJmTkVRVFdSYVRzNGQrK2VxWjJ3TjJieHZjZjg5dHJOanM3OFh5VlV4KzBN?=
 =?utf-8?B?aVZzUGlScEl5N0Q2ZFRONDd1QUtRVUt5aFVoNGx4eTlMZ2hBbU9FeXFaWnQy?=
 =?utf-8?B?Z3dnYXdPclMwNFlPWW1sTEIwVzZ5QkJsU2NPUXZkUW93am95UFIvSUZkVkRN?=
 =?utf-8?B?NzF2aU9YUElMNmg1V0hici85SmZLZE5vczVKTDRzZlVHWmF3V25PRWtYSU40?=
 =?utf-8?B?OWYvVGdWbmJuMkU2OUlNcXMxOURidmgwUXVMUnVqOUhpdjJrNXFSQlhNVHVO?=
 =?utf-8?B?UGhlb243ZWVqNW93U01qb0VjSjBqK0UyVFRmSEZGcjVTV3pMa2JudElTdGVo?=
 =?utf-8?B?b2VnWHlDM0hydEFycFZvd2dIb0N6VEdZKzhxNTN5Z2h5L2RqckFzT3J3aG1i?=
 =?utf-8?B?Ykl4VmNUSHZ0ejNrUXNSYXNHbnQyTUpiL0FKVUp3UW9vdU9tbDRER0lZVXhW?=
 =?utf-8?B?YmRrU2lMUmVyMk9UU3lUUkZ3c3RpWHBzOFlWOVczN25XWkhaMTZXazc4VHll?=
 =?utf-8?B?RG5xamFiRm5oS2VleEdnQTd1NHR5NzNhN251b2NEaFFsNjNGazlvcGEvbFFn?=
 =?utf-8?B?N2lMVWJkSWZmaVpRaFRYYVE2RzFaYWpkWU0zY3FDd05LdW5ySGxDS0tTaUE5?=
 =?utf-8?B?OUhOcGtyWlN3VFlPdHRHaDMzbzZxQ1FTTjBvQnM5bjl6cDc1aHFBZ3ZrZ0pO?=
 =?utf-8?B?c0JWc2pSMjBHQmVSM1FRSjNEOGpWTUkzekFVMWVtazlPSGpmQlNnWERkVXda?=
 =?utf-8?B?MEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rnd2OE5la1JKNGtybnMxRkF5YituZ2lxSjB3eVU2VGdjRjZ3QlVITWlXbHBN?=
 =?utf-8?B?NDhmc0YyU01pMThVWDRMMkR6R0UwU2IxN1VGaTJnanpoMGdtdEVXL1JubURX?=
 =?utf-8?B?MXdZTjNURm1uOTZnbUwzc3k5N3hVdWN6dlVKYVFzZk8yNDhYdGdHTXJ2bU5Y?=
 =?utf-8?B?cW5nS3h0YkRlVU9kZ25MZCtNNnQwd0pxZzVubHRkV2J3SlRTYkgyT2lvMnlY?=
 =?utf-8?B?V0dubW5WOXdkazhqWVlqdmNEd1JwMm1VZHpJVWRPLzBFc0srVklPRUlPWWhp?=
 =?utf-8?B?Tlk0M2NPbEZMMmhQY2FRMGtxeXFNN1NuaUpkd0lXUkxVNHEyL0FyZG5leHVF?=
 =?utf-8?B?UTNSYXp0N0N1UVZuSmtwUURhc2pLelBPbHZmMWlxcGZSMkVocnU3cTM3UHVy?=
 =?utf-8?B?VjFQbGF0REVKV3M2djFGRUJZZUtqRCtYd0RqWXFKc00zSnZlNXVMQmVsa1FH?=
 =?utf-8?B?N1ptbTEwcm01a1dqK2p1OERHV2hhczhHbnA1aTVDVXJDbjdOUnU1bnhBQnUy?=
 =?utf-8?B?MDQ2MWZKZ1c5b0dDcW5QY0hxVXJWUjN3NDhRV2NJTGtFeE0zM2xmSkFRTUpm?=
 =?utf-8?B?Z1RmdmdZSGIrNHpmNkp4ejIrZ0JYVlB4RlRMSy9jOGhIc0FJd1pmZWpVVHgv?=
 =?utf-8?B?NUlaZDZwNGtYamM1VHFUU3JreXdITkVXRTY3ZzdVa0V6ZmdaQzNMVkhhc0tP?=
 =?utf-8?B?eGhSTlo1YStEdkdsa0Y5bGlTVFdwQ0I4OXZIMXl0V3FOelBKQ2hpaXJ4Y2tO?=
 =?utf-8?B?azhvWE9FTzlsaW9RRlpsNnU4dm1lbjcwNGxXYXU2YkpNYisrOHZYbWZXMURF?=
 =?utf-8?B?RWx4ekdUNnVUWW8xVjR2MHFTWndOc1lNYzI2MllmUGg4cjRma1ZPc21OY0Ur?=
 =?utf-8?B?ZTdpQW1IVWlIckUvQy85eXBpYjMyYUJhTm1mTWhqY2JRQzdGS1RaeWVEUk1P?=
 =?utf-8?B?MGpweE5XUlNuU21DU3JIcnVVM04vOW0yZ0RvUS9uY0RzS2txWmhGZnhsOXZx?=
 =?utf-8?B?SVlNSllLWDJiLzQ5K0FxcVNEZmV1ZjRGYnA2RzJHaFo2L1EvYXRkYlJMa1g0?=
 =?utf-8?B?cGIrRWMxdXRkVmw2YWxkdFVDaFpoRk8ycEdMdnAzdnJ5MktwRm5lYytzVTBS?=
 =?utf-8?B?aVVCTVlTRlp5Y2tuQnVPdTJhNS9jb1piZG14T1lJZkpvTi81ZzB6R0dZc08x?=
 =?utf-8?B?OEFxeTF4L3EyRkhoVG1seDMxeWZGK044ZlpSa1JvV2FZYXV0ZzdsVDFySjAx?=
 =?utf-8?B?Tk9EUlhVdHhpVy9Hbmx2UlFvc2tGWG5ISFNIVDJmYlA1NllHcFBnaUJlYS9W?=
 =?utf-8?B?bXlGcG0rWTVZYmZCNm1IeThPd0lLOFZGVDg5Y21lS2VDbm9XM2JIcnYzSHhL?=
 =?utf-8?B?ZDNucWNoU3RJd2RIdFQ0ajhwQytMRDU0VVkvckhiQUFPUW5FZHFvZnkrajFk?=
 =?utf-8?B?R0krVy93eXdSSVljOW1JME1pS0JueE9DNVhSL2J6TXczc2ozSUpuYXJPQmM0?=
 =?utf-8?B?WHBYNWpaWVJvdEhvaXV2M21pN0VmODliNHBLWVdpM0RIaXdPL1dpL05FamJ1?=
 =?utf-8?B?bGlYUW9qSlY3YlQ0VFh0V3ZiTTBuSENITTBzbitXZHRIakZObDVhWllRa3Iz?=
 =?utf-8?B?Skl6YnF5VUpYS0NGcjZ2NEtGa3dzemcxdHVaV2c5TzdzOXpvL2FEMjNOYklJ?=
 =?utf-8?B?YmdyNWJTa1RNSnpWeklXd2hBQjlJNWY4TFFXSnlMNEFQQlBNNlEwMk5jUUo1?=
 =?utf-8?B?TmFXUVJzYUNnRHVxaEtJZG1FdThYeVRBN1A3dkhWajVqYm81YmRrRittM2Jh?=
 =?utf-8?B?djQ5UjZrYmlGU0hRdlppNXVxVWI5cWh2UVV0N2Jmc2FMaEUwK3JEL1h5c3Zi?=
 =?utf-8?B?TmRNOVlnYkNZN2hYQzQzVjBadVNUMEF3RHoxSjhUSU50cU9jR0tOaThBWnRW?=
 =?utf-8?B?MmtQZ21XU0lnOXVuSk5BM2VtMEFhSFNVRlhUblByUGsxY3FURkhubVowMEpq?=
 =?utf-8?B?eW9ZNWkvd1Q4WFhYeDZ4V01wRFd6clcvM1ZLT0RBcG1WL1Z1OE1WWHFOWXhL?=
 =?utf-8?B?RTNCeWVLZjh6a0hJbVhqRzlTNmx6cnlLMWJTWGZ2eWd6cTAxTytXSndUSEJp?=
 =?utf-8?B?TW02OXFwak1aTm1CNkFUZTAvMlBvRmdQYndueEIyWEh5Z3NKV3V4TGpucmN0?=
 =?utf-8?B?a3hDcVhzUGtNYTJLVVRJVDNYa2srM3hxRVpIcWFCZ05ISEJDNm1ZSzZRL0tH?=
 =?utf-8?B?R1lISW9uK3U3UlFDR2VORUFpYURsdVZWSzJnNlZQRmIrSTBMZXFrOUcrUUJ3?=
 =?utf-8?B?ZDArYk02TG9JcEJkMmYxTlEvMXZMZHFJKzc5N3NON2VoQVVhYjhEaXZ6anVQ?=
 =?utf-8?Q?CLJvGq+hlWzIn9crtq1SQfQt4Fnxp6Rl5X8/glRyTaxFD?=
X-MS-Exchange-AntiSpam-MessageData-1: qqJVVS2DfCpH5A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b039d591-70d5-4120-e8ef-08de6232ef38
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:13:23.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amM/RL0vAQLhsxoL3EgMod/of+rXYHhFB8YgKcSVQAFO+RvTPuNh8PQEoe+Q86UxhhEBQrX3d4VR+VrlKaAGiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

The `_relaxed` I/O variant methods are about to be replaced by a wrapper
type exposing this access pattern with the regular methods of the `Io`
trait. Thus replace the examples to use the regular I/O methods.

Since these are examples, we want them to use the most standard ops
anyway, and the relaxed variants were but an addition that was
MMIO-specific.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io/mem.rs | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 620022cff401..7dc78d547f7a 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -54,6 +54,7 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     /// use kernel::{
     ///     bindings,
     ///     device::Core,
+    ///     io::Io,
     ///     of,
     ///     platform,
     /// };
@@ -78,9 +79,9 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     ///       let io = iomem.access(pdev.as_ref())?;
     ///
     ///       // Read and write a 32-bit value at `offset`.
-    ///       let data = io.read32_relaxed(offset);
+    ///       let data = io.read32(offset);
     ///
-    ///       io.write32_relaxed(data, offset);
+    ///       io.write32(data, offset);
     ///
     ///       # Ok(SampleDriver)
     ///     }
@@ -117,6 +118,7 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     /// use kernel::{
     ///     bindings,
     ///     device::Core,
+    ///     io::Io,
     ///     of,
     ///     platform,
     /// };
@@ -141,9 +143,9 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     ///
     ///       let io = iomem.access(pdev.as_ref())?;
     ///
-    ///       let data = io.try_read32_relaxed(offset)?;
+    ///       let data = io.try_read32(offset)?;
     ///
-    ///       io.try_write32_relaxed(data, offset)?;
+    ///       io.try_write32(data, offset)?;
     ///
     ///       # Ok(SampleDriver)
     ///     }

-- 
2.52.0

