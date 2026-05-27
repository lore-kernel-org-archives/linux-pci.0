Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020077.outbound.protection.outlook.com [52.101.196.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6313EDE4E;
	Wed, 27 May 2026 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880388; cv=fail; b=CVhPLESlvISvzr2Hp3hKjDjCfAfP74qBly7tp2Cs+LMD9tVI6di3irktgdlwfhHR8MZnvFQIfAgLO6x/b05X+XmmMCpClyt8bgjw++NZ2M21OuLxLAxQsx217b5NXEdSR7zwnw2+phJN03dF2MQD/EFyaA3KzT+jAkm1iUFL+sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880388; c=relaxed/simple;
	bh=cbRWyNymDskkU6PGcYvZDD3mNPc01hhrOvcO/gNt7M8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=jDpQ1ao7M09XmNiTUJjVIAZX7csmDdhEJ3EKZIf0fSPXxzmJNj4tyEs1YsPHlZtQ9AJx+2XbAbbS4eooid8JqUjZY1+8RSTSVRjOF9sYlPSijJTSpseVTE0NwbVgwOOW3fOI6fSWpb2fCqVVw0eq6cjsdbCqoH8RS+4/3z82WEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PeobERpM; arc=fail smtp.client-ip=52.101.196.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PeobERpM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM30cBVDDUFGhjPMKvaRDIPRpcv8QflGl6sS+BRGlpKII9LeDSneWkRjr331rzs/JJrtdPH1T1B4HoYmjRt24939nEqCA1WLv9KYszjqalU0OpF2qSDiiahxxaLtDmAd4JdOQELipQyWhYoqKFX+CoK1qeBi9BJw+WVHED/2quufKON6DSV4kiB3yA1EtgQafacdZ7hbNIxKiGrDGRadFyT+GapuOV30EKkCtSFvjk9gW32GVNXUe4dATp/bDHAHmhKj/qnMDvWzum+k1CuVYITXi/Ador5rBh8bWr5VHFn36nUaBiwEL5wCKcbt9X0+W6H0QjjotzOe9ery+jWQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EI73U1rue17S46cSWLuaI/j9gCTjHUgvPArA/Jc0lA=;
 b=kbcfTfqv8CS9mZLPgKCtng3mEDSKcvanfsgdLM5mK79PQ/S3wwqio96RIX8o2jfIq5nMpgKG6P4RA5ZR3HUBZ3n7Vt1WFGYlbQXrSJTrdwVHmuBR27VQYCfRN2eML9kNnib8iat3CaFO0VBi8hSKd4Rm/UNCZIfypm+M7bs4dM4kSmb6LeXHZEctQIOTNZoEPDHX8GCr20XK4GYZrn6h6UmfVO8VNjxXnaHyZZdZLUnB1F/AT2HOqbu60xQQ+JFZUkODIa4dp6piQ3gjH6hPhntmEdIlFcnK9sqXOANGu0C2QiWP5ITaGtkTjarWy+G9fWe/+ksdgl7RgQ5tEYGXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EI73U1rue17S46cSWLuaI/j9gCTjHUgvPArA/Jc0lA=;
 b=PeobERpMz0agxfCmcQa0I29Xx/+1NEIYXiJ2h2WEYoKS0aOFMe7qh5cHtDMDMD8m+e1FhCydD4KcbPX97yFti7AFuGZrxxqOQ2iPGZXtrNOCZJMHy9fCVs2IRycp8MgAX3pacFRDIbZUy29sfGpKhgkEVbveuWPoo8nCJnJOSWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB3108.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 11:13:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 11:13:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 12:13:01 +0100
Message-Id: <DITEXRBFOZLD.V7Z5AFF3JXBO@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <devicetree@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] rust: kernel: use strict provenance APIs
From: "Gary Guo" <gary@garyguo.net>
To: "Tamir Duberstein" <tamird@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Rob
 Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260522-strict-provenance-redux-v1-1-0880b65fc17c@kernel.org>
In-Reply-To: <20260522-strict-provenance-redux-v1-1-0880b65fc17c@kernel.org>
X-ClientProxiedBy: LO4P123CA0559.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB3108:EE_
X-MS-Office365-Filtering-Correlation-Id: 15781d64-550a-4a94-a2b3-08debbe0eaed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|22082099003|18002099003|921020|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ak/nmbDMbzxwTmsog/3Jce/X/MD4GUuQpv5bM1RkzQqiSkyafuwO0TBk9yQxRiU6KF+euzSp//5aHxyyZziblqLk10VZTckFRy5G6WedU3MiYErF4s7nzS+proLLF1Tp//g19d3ZWN/kQj8GQolk8I4mB71MiiOKpwxUWqVVLHD6WRHKa6sPgZpNQmr5u/gFovr5s92qC5rgwBo5dU/75sXgtpV70ksbh02gbQUpvuyLS7L2xiCHJNQRaAQQHP8A+VQdVeWR/vzp0BrJaSLgTZFtDUbFuRwtCGwXJhUfy/mOIEnQ3suSUseggz0a4bOidS8qQ3WEDuM/LxcoMgSK2sl/hyIrWA9gfQs8F+o36tt9T7XtTXtdaClp9YYnUcov8HAHZ3kcRTW9G1NPP5Nry/+vPyWMoRsSfC3DthQ+yD9Y9QtYSdY5YXpRMDsJrS+YiM2/mK94yK/ZXY1ivMz+QKhmnFAmUIlvVd1pZ5Dpnxn7bU56NVnJ7UVAecDd69LPbxCzOeh2I3X7GBat+bmfpxzfyMPOcT8U7dj5TLme8MV+9cnVFiKdNZKudQ1sHoqG5oRi6K/y6ciK6+E/L/8gGXUWuJhryq0XzrMA1Rg5/vbeh4KyM6KIHtf4iF3MzFnI1ixIyGSX7pXA6xY0/T9cZec4l7zH8dPXPLbY0xDiFU+T2xhBky4XbB/BSTUuL8H2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(921020)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXQ4VXRka3FRbTFpaitub3BaQUNFTjUwWUxXeDczOWo0aEdUTGtTWnRrNlRJ?=
 =?utf-8?B?RFo5RGNMLzYzQllkaXlOczNiRU45bG1iZ2ZhSG9ZTVpMTlBXWXBvaWlNQzBh?=
 =?utf-8?B?b3ZoeXlzdXcvalNkSVQxUFQrUStnT2xnU2FFNnNWQld5aVY4TGdpdDM1Lzg1?=
 =?utf-8?B?aVNIMUtpRmFvWTBtR0VEaVQrRWZYQ285Umg3Q0daamtiMkVxYzJKeEgwQTd4?=
 =?utf-8?B?K0kzdGFoZUFLbVdNWDk3eTdjMmQ4U3JWOUduelVaUEoraDRVbUhBNHNQekZC?=
 =?utf-8?B?b0hVVFU1UWcyY2htbGY5S0JRMTRYRTh6T1lSMEZyMU4zenhZUEFSTFJ3S1BN?=
 =?utf-8?B?LzZiZmJRZjJ3L2dwcEM5aEFTOGIxMmZSMmhDbzNNUlJVWnVCZTVSaU0vU254?=
 =?utf-8?B?ejJRRU9zaVBDczJ0RnhQbFdKQ2lGenhXeDd6K2pVc3dESHZJZGhuRFN2ajFv?=
 =?utf-8?B?WkpIUFRETnI5bjJ6dis1OWs5RXdYTGpNQWQwTFRpNGFURWc3cWpsNXFLKzl5?=
 =?utf-8?B?eTAvR2RiVmw4dndwNWtBSEY3eTNqNjIwVm5XRFpxVytZd1dmaHdYaTJlYXla?=
 =?utf-8?B?Qm9pQTFMcWJ0VXA0TkhZYUhlajdzNmE0ZE1BUjZON2hPbXphaWZuQ0R2SlpZ?=
 =?utf-8?B?ak9tWk5vS0NvcDJrWWJ4T1JsbExJdlJHeWJVSjJGdkxnTW1NckR5cGZIdnpn?=
 =?utf-8?B?OTRYTWgxVGtuL2xBdkRDTmxVM1FJb1I2Q0FQVEhkQmowRWkzRlpURjV2UlJn?=
 =?utf-8?B?T1BKWHB1S0tRZUd1K0JkV2RBYnUreEJldXlPRmF6VFdBeXYxYTR5amNrbFFL?=
 =?utf-8?B?VWNWVU1MY3JEYlNDQ2JsU2VSUmVuZHZMcWpUOTJSeVE1bE1uSkk0Y3lLWUtK?=
 =?utf-8?B?NTRBV09pRnl1aFptWHo0eFRXNW9VczA3YTZNWjV6UXp0SmVBMlFwV0R3VCtE?=
 =?utf-8?B?cjI2Vk9mcjhhQlRYM3QwRXdpejlkN2N1TmdjZjlBWmk1OTBNUVpRN1NOWHg1?=
 =?utf-8?B?RGNpM0RUamFYbmQ0MlNOZ0l4cEtET25WQVJMTWE4V3crNmg5WGJkNlRKaFpK?=
 =?utf-8?B?eGFacmRiQm03Ty91TE1pMTVBWmg4ZnhiYXhObU5jR0J3MmhjSi9SdjRmNlov?=
 =?utf-8?B?RmlCbEQwZjkvYm1nWXBvcXV0M2R3S01kT0xTRllDZlV1SlluRlByMW13cXNH?=
 =?utf-8?B?Y3UzMzRVRmNmMkhUYXJnbVp5TVFWcFdSRDNVekpCWXR0K0lBeTBhNDFtQ2NG?=
 =?utf-8?B?bDRuVzRCeERsV0hLOTMvSCt1YTZ0L1ZXdEpYeUdOZ3dHSER1THhzUHp5THhY?=
 =?utf-8?B?c3prSFVDdm1OcmFxbG9COE1Xa1htdG1ONE1FQWRGQkhEcGdxLzgxTWtwRTFa?=
 =?utf-8?B?M3FMNG5LSUNTVC9neHdXUUdhMjBhSGZaeUoxY21pVlRCaXF0UDlZOW9rOGcr?=
 =?utf-8?B?RGFPaExjcnQxaGUrL3UyOXVHVTRTSGs4YVN5cVpzMkZXNFpjQkJpcTNCTWs0?=
 =?utf-8?B?ZE0yZlhMZEw2Wlc5WUY4OFdKTEpVdStleHFVMVdnVjU4M1k1aGdRTkdFNzBL?=
 =?utf-8?B?emhLYXJyNW9EUC9DZWNTdHJNNHJ4VmRGK1Q2bmZyazZuOE5mWGhGbThpOXBI?=
 =?utf-8?B?b0lWbU53Znc4U2F6M3F3MDBRS0hLS0J4dzM5c3U4R0dLNzJsZmcvcXg1QUJ0?=
 =?utf-8?B?UGhIRFF1ek4vZ2lGUXdBMmNpSVMwRzFiZVlKcVoraGZmeE1WYmIxZjFkN2lk?=
 =?utf-8?B?VUd0QTFZazMrK2wya21SRmxGNzl4TU85dVJIblpqV2tNNGU3ZlhFekdUeEpm?=
 =?utf-8?B?V21XQmJtZ0pKWUZXdGlXdDkrdFJJeWdsN3p0aWxLRVZXYU5UclJsVUMvVU9u?=
 =?utf-8?B?alRvWWVYVUY1NmZmU05Cd3RJaUd5YUxQbUt6WEw2Y3AzanVQSlJ3L1RCd3hW?=
 =?utf-8?B?b3FQdkZmUzlkWEJQYmVRaGwvS0p6M204NFBzQ24zUG01VytGSlFWeVBVMFQx?=
 =?utf-8?B?eGx1dWNEcDdGejMvaEExOXRtaHhEdjFCd1RzN3FmdG9Ga0t3SkhvcmVXUGJS?=
 =?utf-8?B?MUxJQ0c1T1RWNG85VVlDaUhwUnZGOVNrcnZNRjR5aDl1QlNmVm8rQ3VmcWxJ?=
 =?utf-8?B?WldFSm9zY1JsUkp1dXpoVTAvMDNBbExUM2tBWVBpTTM5R3RobGdsYVZvVC9P?=
 =?utf-8?B?Zy9aZ0pEdXcxNnVEd3RxYkV4cE1Vcm5yYkMzUGVvc2ZkdzMyZ04xYkZ3VkIr?=
 =?utf-8?B?K2lBZmlDVmhqVVNOaEJ5RTdIWko0UFdnVG1wdkpJNjZMZmIxVmRvL0YyTXlF?=
 =?utf-8?B?OGRScmczNWIrRG9IbjJnYnhVZzk3UytvRWFRK3p1SDdnT0FyUlJ5Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 15781d64-550a-4a94-a2b3-08debbe0eaed
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:13:02.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDOJ1ULCDTC427vboxEv9Hp9r4frKDCSOTNvOHwkj3IhxIG2R0qwnpon72ob0+lP3QggsthJq6RC9B1khCH6vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3108

On Fri May 22, 2026 at 6:19 PM BST, Tamir Duberstein wrote:
> Replace existing pointer-to-integer and integer-to-pointer conversions
> with calls to the strict provenance APIs.
>=20
> The strict provenance APIs were stabilized in Rust 1.84.0 [1]. Since
> commit f32fb9c58a5b ("rust: bump Rust minimum supported version to
> 1.85.0 (Debian Trixie)"), the minimum supported Rust version is 1.85.0,
> so no polyfills are needed.
>=20
> Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-prove=
nance-apis [1]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  rust/kernel/alloc.rs           |  2 +-
>  rust/kernel/alloc/allocator.rs |  2 +-
>  rust/kernel/devres.rs          |  4 ++--
>  rust/kernel/error.rs           |  2 +-
>  rust/kernel/io.rs              | 10 ++++++----
>  rust/kernel/io/mem.rs          |  4 ++--
>  rust/kernel/of.rs              |  2 +-
>  rust/kernel/pci/io.rs          |  4 ++--
>  rust/kernel/str.rs             | 16 ++++++----------
>  rust/kernel/uaccess.rs         |  2 +-

This touches many subsystems, so you'd need to break this up.

I'm also refactoring in my I/O projection series which I've already
converted most stuff that I touched to strict provenance:
https://lore.kernel.org/rust-for-linux/20260421-io_projection-v2-0-4c251c69=
2ef4@garyguo.net/

Best,
Gary
