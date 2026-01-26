Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087D223336;
	Mon, 26 Jan 2026 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769404119; cv=fail; b=hYA0yNpkVanLWMFapkCuhtx61RIWXHr780ZN8c5/LRK7E/hNSR2deAgdjy/YrXzjbSh/jO4ZpslYEjQLycGJ77h81flKt1WjKA08DwHFS5SavBH93+kvdrcXqlCWKGrkUfRDL5fDOfVbIVmTELKpBko+uZoRlbymH6o6+WzuD+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769404119; c=relaxed/simple;
	bh=G+oWTDViR9h42s78rewsWMOz413zqVU9jLrKamNGKUw=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=haD14X0Hpnct+k9Jn06jNaxbBQiB3ZItkrXcxG9i/9z274XRXCnx09ueEmR+2jBPAYgfPcYSBduRoO0L0j7PoBed/WxaMbV4b6X+KdOZyV7fCxGXZu5XPentmjNhzbxRifWqPe37dnUyn/L9AL1pra7JlE1HBh2PpkU/kySb9Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mNXz4IBY; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mNXz4IBY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlm4sXIXa3nxN0uhcG6Gid3LhrrYMUVm497RnGVhueuyKUWHnVIQoYgLuv2YGDoIiflrdE69frqetCpDwjb/GeEfQhBTgTvYfnfVUPjQEkPLWLbjL8B1RVCt/ya8951q5W8YVj9LxLmEAPftiYpSPJMP25gDMH3NebVoQ4+0gdg4H/oR1FbQaeGDFDI8+mjTs51RdQzbaCwhqrwvgcE5ULMDtPSUThi1GliT5Z7vaAM/lZFwstkSg4l+hlYvHUOzOzTi6pOrnzxR3u8bCQRuHrUoe8Cz3TATsXCXurgCfqFPxtT2RhbV0MPsxJqpWuc0l3cxFy6c97FKDUfwEIrG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTi7+7Ii80Q6mBVmOeT3LQd/y3lIjA5LUKJ1ZdaY9J4=;
 b=RFHlc519ukxToAv1LtZ15MQ8ahUFX3qyO9W62VAsJEuZq3MMzvLZCTVBEAGMC+2IprcDF5p+YjxDAzWbeFO3KDNHYgx663YJgguIgvuMh7Bln/SWtY9baV2nucZ+tJqQvu86tKX4t4tw++LvtrCA0u3xWHKXSLznx3a2UftZVSzV5YSMm6RthNaP/WQI+Ti/f+s3Ugn0raysRt6MbJ5OiD7o0MiDgVcOXLeGNvk5GOz5LL2+Jn4HYIArJ6cfY25+QtoHOO3rP/YVjR2X9CAna76h8npGM7mh7kjWffEAUN+lca6Qf1cLP0+i9SHMuARJZtnxe3SXngTZJXf5BzF6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTi7+7Ii80Q6mBVmOeT3LQd/y3lIjA5LUKJ1ZdaY9J4=;
 b=mNXz4IBYAc01pa7U4Qa7ze4KwMvVgDDqhrHc9PLViE5n9UDoYt5MFytIqBmP5ACGLHDBWOnGT6YU8sBZf2I9Au6ZBbv0NAXh2KEPb7uz0ipEiFq8UrNSIBe3yHXQi+lz5fvVxMik5oiZRY6aDrHptW2lX79LpqzjBhGoiRH3i+fnGMaGWyXMH2tCGF1/YmG3DnLyf8V4VRF0b1tpiFOMflJahFRN6Qn+WUwILbol3HRinO3CUszHh+/MVqPw7ZgFjDYyopm6qQjGpEqbqJf43bN97LIZjVF0aVPwWX2H4CEKgDa/A4nTUp82FLjHuIuQasrJrNIpDT7VxaYBlU6A9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 05:08:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 05:08:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 14:08:30 +0900
Message-Id: <DFY9EQP9PKG2.N71XAPSK2MKK@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 5/5] sample: rust: pci: add tests for config space
 routines
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-6-zhiw@nvidia.com>
 <DFUU4ABJQ3PW.15VQSR9ZOSG9F@nvidia.com>
In-Reply-To: <DFUU4ABJQ3PW.15VQSR9ZOSG9F@nvidia.com>
X-ClientProxiedBy: TY4P301CA0099.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6e3c47-9485-4b85-aad8-08de5c98f44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ky95eWFzWUVEL3FQbklmY3dpeVV3NmIzdzh0cEg4MUt1S3d1QTMycVNUVHZZ?=
 =?utf-8?B?R2NHdjhwN2hPeGJER21JUURhM0dVbUwwcEFYVTdyYlFzT2dmbHZYcVJ3T213?=
 =?utf-8?B?c3c1M2hqcnRQcmMwUVpNTml3K1YvSWJVWVJDZjc5aFJ0SXkzcVBZWDFPT2Rm?=
 =?utf-8?B?YktuLytCVnVwcDdEVWYzd1RoLzRxT0tkYWFhWUpTckxjT05QNy8zTWtISVI4?=
 =?utf-8?B?ei9vMENrNEZ5b0RHVjQ1Uk5Id1d5K1kvZmJaTitiTmVLTTFYNTJiZXF3emVm?=
 =?utf-8?B?cWF2R1ltZm9oK1BHTGcvS1NNTnBQenU1dmwyNlNoTWxjMjNHSkptZEdlQmhB?=
 =?utf-8?B?UFU3dnMrSmZCK3hLcGcxL28wSEpGU29WazNsb3JyUW5ZYmhzcGswWXJuQWxa?=
 =?utf-8?B?TjJ1UUw3TG41aWdXclc2TUNBS0ZlNXJnYjBaMkF4YXVMdG40T0doNEkzemEw?=
 =?utf-8?B?VlkvNDc5eG1mUS96U2VFVUlUbmlzSE0vK3hubjNzUHVWUGFMS3JLMXkzUlhj?=
 =?utf-8?B?RXRzbUhZRFZaMVBtRzIvMm1GK1dOR3R6SWVwaTJaRktBQWVLb01wTDZ2Y3Uw?=
 =?utf-8?B?RU41VnFCWlNyNCt6U0FPNFliSmxSQWpYU1NmR04zOTNOTVQ5eEZHaDkrSnJ4?=
 =?utf-8?B?dGJkZFJoVUpVbTFrczVMMlQ1bllKM0RHUnhqajVvbmVDQTlhSTBEVzVVekkx?=
 =?utf-8?B?RkpQWlREdjZvQlRmejB4cHZNZC9XVFFuL2dzWDROcWVLbENNVk1KdkRSZjgx?=
 =?utf-8?B?cExmNTM3bmpsVk8vdHU5NVBpKzR0ZWlJbmZqSzB2QVpsN3dxS2w3WW5KRWth?=
 =?utf-8?B?bG5OWGlHT29NbmVjVkhGTmp1aEx1VXgvbXp5bU4yeGFuZUlqUnVheHFTVU53?=
 =?utf-8?B?SnhNRUJEMDlQUjJVdmRYQXo5VVFiT3lRTGp2dFNNVGRCZm1xTHN3Y1dOdWk2?=
 =?utf-8?B?R2FUTElodU5DeU9xTTVqTUgxcEZnbGhJTUo5cENSbVdOL0FtcWhacm41RGtS?=
 =?utf-8?B?UnhlNGg5WWM2SlRyc3JqN3plY3RoZGMzRnVyOWdVU1hiUlptRkN4eWxuRmc0?=
 =?utf-8?B?ZEpnbmlOb0p6VW84UVBSOU5Fcm9BQ2ZVNkF5SVBvNGpjbElJL0t1TUo0QUg5?=
 =?utf-8?B?QUNBckZGTm9EdmppL095QXprUGc4T1Q2SzdWOW1RcVVqMUp2ZnpKYXkrRGFi?=
 =?utf-8?B?enBUNEM3TGNXekZNeU8xRHZrdkdPRVBKM2ZtWDlWOWZNVm9SOUpLUlFqMmNF?=
 =?utf-8?B?aG8rdUxRSXNDVTNLYTgySmttcGcrSk9NZERhN3dzRzVGcDROM2Y2d1I2cHVJ?=
 =?utf-8?B?MWhUODJRb3Bhc0dTVnIyQTlYRlMwc3MyMWYzRFM2Uy9IWDBxNHVqQ0J0YVRi?=
 =?utf-8?B?SGdaYzdsSENFSEhtTS9ST2NYU2ZUMjBTeWNvQ3B0NUJFVHF6WFMyaEVEREp2?=
 =?utf-8?B?VTA5SmxYMjJ0bnVzdEFtUUdGUGhndjJwNU1wNml5MmVoZWRSSE04WVFuUE5a?=
 =?utf-8?B?Z0RGMy9FVkV1NUt4RzV3U0RUV2RSZnBWWEtxaGpKUDVlZ0ZkbmVLMHZOTStW?=
 =?utf-8?B?eG84NllCWDNxaWtkUE5Objc4akJJNC8zeFRrdDRSSCtkMWVtRnIvUVlpTzIz?=
 =?utf-8?B?aGg4d2N4aDQybGRUYUdYZWdvQ2VUbldpa1REVW5jemNIK0ZwWDBLelBQYStP?=
 =?utf-8?B?UnNRRGloK3IzbXhDWTU2ejVvVG9LdlFqYjVLOE85WVRkc1A3SE8yVWh2d1p3?=
 =?utf-8?B?WWhxUnV4R2duU0g3dEgzY28zRktGTVFkR3JLSEt0elVaRHdNZ1ZXUUNUWUpY?=
 =?utf-8?B?OEhwRXNEcy9vVnlpa2l2WXZuVng5UUNFYkxrT0ZUckFHbUIrTGNSQTRwb05W?=
 =?utf-8?B?N2kvR2NQTS9aeXljc2JudjdoM3lMeXdab2d2NjcvTVdpOFBHcERxODBKV1dP?=
 =?utf-8?B?Nk9UMmN6OHRUUEpqZmJ2YUliYjd3Y05qb3E0eUpPSEtJUXA0bkNBMnp2QkZS?=
 =?utf-8?B?cTdYRlYxZkZ4NGF3Z1dNOUNjcjh3Q2lvMkd2ZnNuQk9GSWkwVndhVFg1Y21w?=
 =?utf-8?B?SVo2TmFWWWp3WkdnUVJVQmMxZGZjZWI3TThtaERlMmJaSGxKRnhYcmlvdkhy?=
 =?utf-8?Q?A080=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTdHOFdWRFM5VXo2NWVDVE1KRUhFeTJBZlJUK202Tzl1L1hQV0F1UVE5bHdS?=
 =?utf-8?B?RWN0dGtSdk4xazZ0Y2k1M3RremM0OERCeUJsRXlhbXpUbUV2WVNxeTN0aCt2?=
 =?utf-8?B?MkVlcEpXcGJtL05vRjZuMHV4UFJhV003VU0ybkg0N3gwZHcraEsrdHZXU3NN?=
 =?utf-8?B?S0loR0F2L0Y1MHMvRWhUOXFNYVF5NUdEQ1lWcEVIRVFHbjdZOFBTSTVSbi9O?=
 =?utf-8?B?cXJlakNKK1FQckw3ZVJiR3hRMC94NXNvK3AzOVY0Nnptb1hpQ3BmcTRhaE1z?=
 =?utf-8?B?MXBiei82YVBKdk5RV0NuT21Za0NOb0JjR3MySGt5SWJYUzdnQ1ZkREtHK3l4?=
 =?utf-8?B?d3VZY1hrZEtkbzBPZUdHTURDRmhIc05vYTNTUkN6SnFwaEY5dWxmc09XVldS?=
 =?utf-8?B?T1FUZ0tZVWV6TmhhcG5qU1NLUThwQzZaR3JHRVVEVlJ4MlNDNndOWENxKzZ1?=
 =?utf-8?B?akVPaVpUSHAxSXk2RHgrSjF5N3JueE0yejZwRS9JY0xITmtZQ1AzOERIS2R1?=
 =?utf-8?B?ZDRtdFdEMTFKS0xxZkxpSmVKSE83R0lZQlNWNEJuaUVWOWtPbnlWRkV6OU5t?=
 =?utf-8?B?bVROSHhBRG51b2RHMmdrL3J1S0h4TG9wTzdZVEpESkt4dVFLWDNkU093WTFm?=
 =?utf-8?B?bDJxenFZZUM3TGI5ckJhN0VoTlppL0xZd2Y2L1Ftd0FMRGdTWkdBOVpGOUp5?=
 =?utf-8?B?cUMwQTVtbUN0cjBUZkdSb2I5d0w3M3VFa256TWtaQW53UXZTYjRrL0NidzVj?=
 =?utf-8?B?eDNrbWhGNGd2SUdWZEdXMmQ3RHlaRUFJTHZYVzFhVk05VW1HcDEwbWQ4Q1Uz?=
 =?utf-8?B?ZmxrbVFaZWIrRk1xZUlBQ3pUWVdSZ0FSQnJSRktDOTlsNStPL3cwb1U5Y3hG?=
 =?utf-8?B?NVJyMGZ3Q05EMVBheE1PT3d0cjVvUldCbm9BanZNSjJFME1XOU15QnJtQWV1?=
 =?utf-8?B?UyttS0RNSnpDRFpSRlowYVZ5MzJ2VGxOYlFsZEpacVBKTkZ0NG1hNlNZWHFI?=
 =?utf-8?B?dDgrSUpUL2ZjaXFnNTB4UnBnalNkQmNvOFB0UWg3cWc2Y1piNjd6a093QVlu?=
 =?utf-8?B?dHdxL3VTYjVYTUg1MVBUczZaalV3L2RKU2hObXVFOWRYNGsvU3VEaDNQbFpi?=
 =?utf-8?B?TmRoWncycWNFL00xaEh6c3h5VW5GZG9ycDlKWElvb1hOOWJzVW92dUJGQ3Z1?=
 =?utf-8?B?OEpmU0wwaFNVeDRJQXRjeElXSG92Zzh5K0dQQ3F6RnlsYS9MTU1oNXl5Ungv?=
 =?utf-8?B?UmxsWXVIVlltdm4xY2VwcFZOVDI4Qmk2eEU5c2tTelVsUjdhQjJZZUZZSDN3?=
 =?utf-8?B?OUt0NG5oZ0ZGaWpkQjhlQ0FSNUorMFVIa0U5QXIydXhuT3dETkplbkxpZlE0?=
 =?utf-8?B?Wm1jbEpaVCsxZi9MMk9GMzFiMnNyVXpCM0pzaVFRWTFxWllzTkgwM00zcXJr?=
 =?utf-8?B?dFlGd2dqNVhROW1ESThRMUZNT0VCbk1BYXg5bjQzRnQxN0p6elRkN1NjNzhB?=
 =?utf-8?B?eG0zY0Njem9TMW84Ny9tRCtyMDFFRzVoYndiNzlyZWROTkVzb0RkQW1VaXhS?=
 =?utf-8?B?WkRqa1kwR0hCanRpUGxJcGxqMUdMVW5JQ2JFUXFWV0xpdjN1aEZ0NDdNejEx?=
 =?utf-8?B?eWN3Sy9uZWM3RXVMb05Cc29DcmpzanV4bFhYU2F6eXlxMk92R3JiRkVpZW00?=
 =?utf-8?B?ZHc2aFdoVTJZZFhwWERRdzl6R3BmVC9hWlR2VFlkOTJ0R2hraWJoN0hoMTAw?=
 =?utf-8?B?amtRdXZjNStkcU9Ta0czdG5jaENzNnRJZkFrQXFuSGpEQUtrVlZqQUZha285?=
 =?utf-8?B?Ulo3RTRZNjZvL3M5SDBtM2VodmtPcTU2K2NKaE9JRVlMdFMzdVJNc3NmR2hO?=
 =?utf-8?B?STUvYlNIQ05DVnJMU05uNE96YU1ycExxdHUzekxBK0k5UURDVXhpSkpOMzJi?=
 =?utf-8?B?NjhRUkUxSkJMeEtaUGVvSW1ienB3TlBMNTNCQVpFZ0R4akdWRmtQU1ZHNUs4?=
 =?utf-8?B?Rk9PUlE2OU9XNGl1STNkMlJyMXl0RVh5dVI5QXBXLy9XM3dVVTMyZjdBc3k1?=
 =?utf-8?B?R21sdDgwSDl0MldyTlpYbjhKdUlWTThpTnZUNHV4d3hxYkg1OGpEVUE3bFlV?=
 =?utf-8?B?U0sxeXhYVDR2Wlo2dWY4RTA5bmZ3N0hOc2x6dUI0a3VjdmF6ZlBmSGlONjBz?=
 =?utf-8?B?dnRKQUxvSDY1SUdXUlJOTWRqOTJaNUY1OGNCd1YyMit2MFQ4V2tXRGR2UDNM?=
 =?utf-8?B?MXVoVzNwN05sMHdsSnhrK3FyQlhLNlZGT2JCRkMwbTBvdXczOTVhRDQ1WW1k?=
 =?utf-8?B?ZE5mT3ZaVVdVTVdjNWRhUmNpdnp6Y2h6aWlSb3dzNE9uWnlKWDRTYmpCWVlJ?=
 =?utf-8?Q?Cx9WI7zL9V6u8Gs+wK8c0PX4HughOWvuKvtYlCXwBVa4m?=
X-MS-Exchange-AntiSpam-MessageData-1: dnq67nsu1p3/Ng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6e3c47-9485-4b85-aad8-08de5c98f44c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 05:08:33.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPsxczM4ssiQ7vcuYL5+ZbhB4bUSeZxIsPv/xGOnx6i5yAjkWkwTrqtNFk1lIImkfb5Sy5JH/YMZb5pWvpv2tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215

On Thu Jan 22, 2026 at 1:31 PM JST, Alexandre Courbot wrote:
> On Thu Jan 22, 2026 at 5:22 AM JST, Zhi Wang wrote:
>> Add tests exercising the PCI configuration space helpers.
>>
>> Suggested-by: Danilo Krummrich <dakr@kernel.org>
>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>> ---
>>  samples/rust/rust_driver_pci.rs | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_=
pci.rs
>> index 38c949efce38..1bc5bd1a8df5 100644
>> --- a/samples/rust/rust_driver_pci.rs
>> +++ b/samples/rust/rust_driver_pci.rs
>> @@ -5,6 +5,7 @@
>>  //! To make this driver probe, QEMU must be run with `-device pci-testd=
ev`.
>> =20
>>  use kernel::{
>> +    device::Bound,
>>      device::Core,
>>      devres::Devres,
>>      io::Io,
>> @@ -65,6 +66,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u=
32> {
>> =20
>>          Ok(bar.read32(Regs::COUNT))
>>      }
>> +
>> +    fn config_space(pdev: &pci::Device<Bound>) -> Result {
>> +        let config =3D pdev.config_space()?;
>> +
>> +        // TODO: use the register!() macro for defining PCI configurati=
on space registers once it
>
> I'll rebase the `register!` series on top of this and try to address
> this item.

Actually... is this expected to work?

> +        dev_info!(
> +            pdev.as_ref(),
> +            "pci-testdev config space read8 rev ID: {:x}\n",
> +            config.read8(0x8)
> +        );

We are performing I/O on `config`, but since this is a sample device
with no hardware backing, what is providing the data for the registers?
