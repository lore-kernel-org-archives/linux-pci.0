Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.103
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790462;
	b=nj0eyiCK9XAR/1TYt7dDzM2mQBoJ6Sn3VKwHPhiLp9KeN0AYS0UGJuyUUP1D8PpqYsxg
	 Lkjr02WvfvXznWtUL5gv6yqKQCfcvOuWgrV91CTim1T3vGiMaSBBm2CRsbYcfMO+YKs6S
	 5WutljsyAqhVCfMtqm6Kwhgb+JC8wLuZqpw2R4MrXdt64Gq/YyBab8dZI1L6EYYEf/0ag
	 ijvcjWAO9tmpMYzmHMwfJTVzfQn/W94n9QLP0mL5saAtAP/P6UkvGjetwlDvMejJsecNj
	 jG3i1FBqeoSH0Buhn6LtcGSBSPi35KXVnYMkgGyqQWa06zxxAAhZa1HWR31tcwu7F4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790462;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=+HtZgRWAJPCuOI4+66uQWN1VE+x8uWI+FbBBcumgHLk=;
	b=yly7hsonyMnQbe76+ZFfzWpmDG+bfShhUDKIvtqm+s0a5j9o6EnFrOnxR4UpT/ryXDRD
	 Cjn/awpyYzRU6EBh01lwgY6TnhZT9CqYOv3GKxYt3cWczKo3Eqc3LCKhpLRE0ceTjYYhI
	 Nh4qBA125iZTFseXCcQDD1nwkwQYAX6PXDHguqlaWMdJNWFj99zGitPZRvA+OXdEa7vnK
	 B9V8QksfADczP9ZnSpeKUeQJ3GLkR7L85Gfk5oFqdqfBlXX32eWAlWNYt8qaGIK3/GiIL
	 /YVNS5+7goDEB/wWfEZsFFeFasgVq6JGMUGOOap3DxWhNA+44OfsGyWtljJxzfB0dkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=pmLspOQF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.103
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020103.outbound.protection.outlook.com [52.101.195.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79C606A31C;
	Fri, 27 Nov 2026 14:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D79C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=pmLspOQF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2ZFO2jwk7SOO76SLIGJopm8Q+tK6yd3a0VEQCRpHYB5hF9c9I3eSBgEtwU9TKwv2JNOi1EyjwL8Fg66UkXBDulRbk96hhdAegI3VWlJFwj+cH9aslDw/wLReoJmKi/s+3/za9dbJJa2MGClUxtYj8BfqBrzUetTgKG22TY9MSo7r10KOMI+1512L3+Zlngt+Ja4453DiruUzjcG2ukU7Vd5turp09AOmaeSSeVUFe2Pym+PomSofY5H4Kej76JKIp7grbS92MEO86E9a5DarlaEjH/F1CWXIbF5BUK6+hkaHh3DQdgFAUU8H9XxGvJ2H3mzcS+xttC0TO32FjGgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HtZgRWAJPCuOI4+66uQWN1VE+x8uWI+FbBBcumgHLk=;
 b=deq/sMLI6fO78lxD9oSV7FvnveQi2nT6Fx5aJnMqbrvlrjnz94wLaIz1QZXOMNiyy2Rmu80Qmu9fd/tt8N+VhIITB74QYW2swPBD3SDg9PD1pOqwJe6dpXN2KcRZU7wGtpXSqhrMTzCxRjkNB1JzPS97wfo1nFh4kBqg1bz7n/iNUn4eAAV9FEkc3RK2bSZo1k7GRQGhghVbiljWTIS+76b+amelkiPtSR8dCZhGfcaSd8UW3OiNcTMFv9NK5U/ingpiMWFsWMbQ3FP4R7+SR+IZXHz56sxFA6GNpUWwNi6Y+8uzg6JA5t0dA6nBE4P0cDGpEoOlTNlKi02rryB6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HtZgRWAJPCuOI4+66uQWN1VE+x8uWI+FbBBcumgHLk=;
 b=pmLspOQFVYXKH3ldqcrHatNIoRWoldhRtFL9kP6uTtlTUMKs+ghVS1a76D099xvHzLVbtStkzmcTJAhiyA3vtF8o+mefMRIl/vDB0cY6tQ9nwPWzf33fEwPNSaw3A6h3FqGSEPTwgsR2Aiz77AGUuwQeOwdcn1QGRaFO5cApOZo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWXP265MB2823.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 14:40:57 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 14:40:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 14:40:56 +0000
Message-Id: <DN62L6PL724V.2HIAY6WVTYPFP@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: pci: return a bitfield type for dev_id
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Alistair Popple" <apopple@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
 <20261127-nova-gsp-dbd-v1-2-0fb5f7c2ce63@nvidia.com>
In-Reply-To: <20261127-nova-gsp-dbd-v1-2-0fb5f7c2ce63@nvidia.com>
X-ClientProxiedBy: LO4P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::9) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWXP265MB2823:EE_
X-MS-Office365-Filtering-Correlation-Id: 51eac577-9dbd-48bf-3cd0-08df4c947271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|4143699003|6133799003|261009223027099003|22082099003|18002099003|3023799007|921020|260925021311599003|260925021911599003|260925022911599003|10067099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	N3KmW6qoubn7GqTzVDCXBiP4gKxasNFvsjAuYYrJl4vwLXvE0uVf9q1Kv2xQ1YCo0NlfM+Ca3ooAIvpzGJzYJkK0s+5JGp79/eW47yD6n4STCs/3U67Wmb2iNOAGoDDmRaWL+h2oL4gYNRFaeJn3EQV3q0ROu5b4qVROCyNMhCFh0KAHHCpcgQY5eEAT2c88997mj8mJan3XrA7HhqRW8wULK9g9hvJpzofO0Hxqtqqzpka2CXEImkFywrcAPyCBHrtZ2oyrgK/swVFL8kQvZU2oKKzzjVUeDj4TU9n9bS6hhYrEJbgAmh56NGGgfIUs+Rn+xAPzdG6nxaoCZdIwv4K9gsmTuQAGtrSBsUpNYT90SqNYhGdVrnlCfZFU9HS+Ro/1dJAGDZzxgIsFbuRyEfcotKanB+EJG1DvG7WoaTlxH+XaAYunvWX01F4maqYQjLRllLZ398W0qhHd3sHG6eJ8FtkWK1ZU9JEJUxghFL8b6HTBlQWWcVFCYZSFctSqt1bCkTJdF0zrB1T47lLV6ZxzJbosP68lH9fxh+hITbf58mA08b4E4F/wrQzCdTPfRMMnqSPUvg0cZnpg9x5hUZIyN2rY/+a8O+s7tQ6X7A18zKMgst7HjqpQxmDYn9i9N4s9adT8dHXWUcdVq8JcQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(4143699003)(6133799003)(261009223027099003)(22082099003)(18002099003)(3023799007)(921020)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEV6QWpKRnZ5SjR3ODBTMEpaTHUrWlhVd1RoVEJCbW8xOVptallVb2RPR2VT?=
 =?utf-8?B?TXI0OEF4UkIwTmNHZnlqaktzdWJIcjNqRDl2elh1Z2pXYmczbmZqT3BiR3ZT?=
 =?utf-8?B?Q2NqTWFaa2VVZXRpRnhSVnBuYzc4alY1TEo5NXRXUnBXYzhxVXo1MkpNdlV2?=
 =?utf-8?B?OEg1eE5SQ3dCSmVTZXdsSGk3UkxQVlpLQ3BQRXlCVXZqekRNNHBLM2hlTlZF?=
 =?utf-8?B?aURlNXpUMk5HRHcrbzhLcUQ1V1A4djM1OGEzV3lQdm0xSUtIZU8yeEJnMHQ4?=
 =?utf-8?B?K21zY0FjVmNrMTZTdzZBNHNOWENualNoS1BMYWdWcEEyamJuSEl2b0l3VkpK?=
 =?utf-8?B?N2Z4V0huTkM3YkhpeERFOHBhdlQ0WDRtNTRCbmtpWHdIT3QwTlJLWWVvcEc5?=
 =?utf-8?B?WHVueHpnazQ5emVBck1OVmpidXNDK1k2aHVzY1JHTzRjVm1UZk13WVJuOEZZ?=
 =?utf-8?B?Z0dKZkFuR1lwQW04eTVub2VzWmx0aW45STZTRkxwMzhSY2ZZUjFuNVVhNzZ1?=
 =?utf-8?B?TmFrMm5vL0k2aEJUVXUxRkZuQjd6YzBpdXhNYmhKU0J6eU5yUkZrTjNocUdU?=
 =?utf-8?B?UTRiTXkvL0dzejlrdjhsWVF6dXlCc2JyTDNub2Rxbkh6Rk5iWHZEdVhyMGJV?=
 =?utf-8?B?UGxNWFJIbnF4bStnZyt0UjB5ckJlTUZEV01hQUhTTGJPQTJJaW1TUTJmdERY?=
 =?utf-8?B?R0tLT1lOUVdZQVNZNU1uQkI4VHlvWXFDdUVJelE4UkZWRXRPK3BGS1NmZGJi?=
 =?utf-8?B?d0lIMVpkSVpIbGEzUkJrUlovVWRlZWVMamNMNlpQaTkvMncrMlhxQTVVM283?=
 =?utf-8?B?b3lRakFxSkhWV2xzOVM2alYxbmR3Snk4c1YvVXVDdzlEL0NDYXNud3R6Q0VG?=
 =?utf-8?B?OEZCUlNMSUM2ZG9nVnAzZVk4MmpQMXU0SXdVeEdxcE5FbDlSQlJiT2xOWUI2?=
 =?utf-8?B?L2pFNWxtbmZLVUZTcE9PK290ZUZXbXdtOGFrMUV4eU56NUtabkhRMEpzOUUr?=
 =?utf-8?B?QkxsSTN4bVVzSGh1UWowNWhaV2ZvWGYxREpWVHErUVYwOUlkcFlOSzNBakNJ?=
 =?utf-8?B?S242ZmVvdGsxWk9IUWJCM1BZdkZabVp0bkNSdjc1akZMZFdlamZsQXlvTUVj?=
 =?utf-8?B?WVZrZnNKV3JXR2c0T2MxWjhBZDV0Y0p2bytiUTlKcDRtOHpBUVB0Rmx0T2ht?=
 =?utf-8?B?b004cmhxWElMc01MWi9UcmJ6Ny8rUjU1alZoWHVpa1lpODBPeGFSRWowVWNr?=
 =?utf-8?B?N091WWRVWWFRakl3Z0VZcUJQV0FTYXlUV1VGNStVTWVrT3dqV0hjcVJQMWtE?=
 =?utf-8?B?NWdUMUx4ajlvQXFJTU8rK3VodWJPb3pwSFc2U2owWlRBdEUzaGRKOGROcEFD?=
 =?utf-8?B?akp6UzV0bW5ud21MSUp4bjkwWGExZ21xNi9veEg1Tm5HaC9jY1h3c01kTVdk?=
 =?utf-8?B?UnRxMHpKdldCQVNtTWNscGVYLzNqeXRJVms5UFJiRnJQei9oMDYybmR1NnJx?=
 =?utf-8?B?RDMvTlVpZW1oRmZ2c1VaYkdSTlhZLzZqa2cvTjlZajRYWTFkSlJ1RTRPVGd0?=
 =?utf-8?B?ZzhVOUZDblBxTC9RdW92T3dYY2UvY3lBQ3BNclZXOWh3OHNKMGtBS0JFTHE3?=
 =?utf-8?B?MGZLOUMwdmxsYWttejBUNnBZa0I1K1NXdDF2VXArbkFaeEF1M3RyTVNwenB3?=
 =?utf-8?B?dGI0TW1Fb3VlNEZheU8rMi9SREhqdDdPbll4RFZ0dUZvV1l3eHp6V2JCTlp4?=
 =?utf-8?B?OUNyYVdydW8wdGtCUVhGbDdnVlVnWnpqK1piN2wxSzRsdmVZNG40YzhNUnRL?=
 =?utf-8?B?ZCtZWDg5d0EvMVlCOVRFQ2xydnpCZlNoc2tMN1hsUVdaNUE4T0dpYnB0RjBC?=
 =?utf-8?B?U1pqZjA0ZEJWbENBR2NtWmJRbXZ5bFVSY2g4OEVLTGsxaTEyTnZ2MmxWUVo3?=
 =?utf-8?B?K3MvalJBeUZJbEdYVVRIaUhFV2p2cjJHbit3eFNrM2dTTEdjandIYVJ6aFNx?=
 =?utf-8?B?dDUwdzV4b21hZk8xOXhKUENLQUEyQ3k2YU91YlR5NVRZcDZ5WnRmQmdkZ0NH?=
 =?utf-8?B?UlpYR1JGM1hEYi9nZ1dldVRFN0xmeENGMVV3WmhUVytiUXd5MFc1S095QU1J?=
 =?utf-8?B?V2llU2R1dkdNbDllZ3JwMU8rQjF1Z0FVRmJ2b2RVZW80YWNmSFV4ZUsxTTRu?=
 =?utf-8?B?b0sxcTdQRnRtYWhqbC9yRERQTmhrVjk5bk1GdURQNlgzNnhpbzJsSVl4UWEw?=
 =?utf-8?B?VFd0TmhBZUppZmttNStQS3lDRUFTZ29KRWFURjY3cmltUVVkUTZ2OWZIekph?=
 =?utf-8?Q?E2A+Pyi1ceioE9GdZj?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 51eac577-9dbd-48bf-3cd0-08df4c947271
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:40:57.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sm01JAX7M1rTrRKQGmjI0eoL62QTZ5Ciyswbpi8Iw9fwfx2oKcU0aVEJXnJfO9aY0yrFNGI3mgckjXC6kvpA0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2823

On Fri Nov 27, 2026 at 11:46 AM GMT, Alexandre Courbot wrote:
> The return type of `dev_id` has a well-defined bit layout encoding
> the bus, device and function IDs of the PCI device. Add a `Bdf` bitfield
> defining that layout and make `dev_id` return it so users can benefit
> from it and are not tempted to define their own BDF type.
>
> Also update the current two users of `dev_id`.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/fw/commands.rs |  2 +-
>  rust/kernel/pci.rs                       | 33 ++++++++++++++++++++++++++=
++++--
>  samples/rust/rust_driver_sriov/pf.rs     |  2 +-
>  3 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-=
core/gsp/fw/commands.rs
> index b4bdbddad79f..37b89e62387f 100644
> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
> @@ -88,7 +88,7 @@ pub(crate) fn init<'a>(
>              gpuPhysAddr: dev.resource_start(0)?,
>              gpuPhysFbAddr: dev.resource_start(1)?,
>              gpuPhysInstAddr: dev.resource_start(3)?,
> -            nvDomainBusDeviceFunc: u64::from(dev.dev_id()),
> +            nvDomainBusDeviceFunc: u64::from(dev.dev_id().into_raw()),
> =20
>              // Using TASK_SIZE in r535_gsp_rpc_set_system_info() seems w=
rong because
>              // TASK_SIZE is per-task. That's probably a design issue in =
GSP-RM though.
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 04a6d240afb2..0592b220767c 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -6,6 +6,7 @@
> =20
>  use crate::{
>      bindings,
> +    bitfield,
>      container_of,
>      device,
>      device_id::{
> @@ -17,6 +18,7 @@
>          from_result,
>          to_result, //
>      },
> +    fmt,
>      io::resource,
>      prelude::*,
>      str::CStr,
> @@ -279,6 +281,33 @@ macro_rules! module_pci_driver {
>  };
>  }
> =20
> +bitfield! {
> +    /// Bus-Device-Function ID of a PCI device. Equivalent of C's `PCI_D=
EVID`.

You can use

    #[doc(alias =3D "PCI_DEVID")]

for doc searchability.

> +    pub struct Bdf(u16) {
> +        /// Bus number.
> +        15:8 bus;
> +        /// Device number.
> +        7:3 device;
> +        /// Function number.
> +        2:0 function;
> +        /// Aggregation of `device` and `function`, which are commonly u=
sed together in code.

I wonder if this is actually true, or is this just a result of existing API
being designed to bundle these together? I quick grep shows that the combin=
ed
value is most commonly used to make API happy and packing/unpacking happens
immediately before/after the API call.

For C code it is done this way before it avoids having bitfields. But given=
 that
we're using bitfields here already, we can just use `device` and `function`=
 and
omit `devfn`.

Best,
Gary

> +        7:0 devfn;
> +    }
> +}
> +
> +/// Formats the ID as `bus:device.function`, like the corresponding part=
 of C's `pci_name()`.
> +impl fmt::Display for Bdf {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        write!(
> +            f,
> +            "{:02x}:{:02x}.{}",
> +            self.bus(),
> +            self.device(),
> +            self.function()
> +        )
> +    }
> +}
> +
>  /// Abstraction for the PCI device ID structure ([`struct pci_device_id`=
]).
>  ///
>  /// [`struct pci_device_id`]: https://docs.kernel.org/PCI/pci.html#c.pci=
_device_id
> @@ -700,10 +729,10 @@ pub fn revision_id(&self) -> u8 {
> =20
>      /// Returns the PCI bus device/function.
>      #[inline]
> -    pub fn dev_id(&self) -> u16 {
> +    pub fn dev_id(&self) -> Bdf {
>          // SAFETY: By its type invariant `self.as_raw` is always a valid=
 pointer to a
>          // `struct pci_dev`.
> -        unsafe { bindings::pci_dev_id(self.as_raw()) }
> +        Bdf::from_raw(unsafe { bindings::pci_dev_id(self.as_raw()) })
>      }
> =20
>      /// Returns the PCI subsystem vendor ID.
> diff --git a/samples/rust/rust_driver_sriov/pf.rs b/samples/rust/rust_dri=
ver_sriov/pf.rs
> index 8f9958683528..c367c891abf4 100644
> --- a/samples/rust/rust_driver_sriov/pf.rs
> +++ b/samples/rust/rust_driver_sriov/pf.rs
> @@ -34,7 +34,7 @@ pub(crate) fn submit(vf: &pci::Device<Bound>) -> Result=
<u64> {
> =20
>          dev_info!(
>              pf.pdev,
> -            "Handle PF request {} from VF devfn {:#x}.\n",
> +            "Handle PF request {} from VF {}.\n",
>              request,
>              vf.dev_id()
>          );


