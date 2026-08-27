Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CAE4A23;
	Thu, 27 Aug 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811378; cv=fail; b=HSuvsAEtHoIcdmFMWmDAc+Y3Qy+aoz+UOtJWIIHAD2u+zQZ9IKFDTx/k+PKxpIIvo/HqwgqS9waTKJRwuMtwXITHvqmUNVkbMZ6o2dEMdUkeQQXFP2n7G37rQDVC4jHtx3USUFtHsItrJas/FrSx+7gpu8OJjmfNKn6hUJB4yqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811378; c=relaxed/simple;
	bh=KLUXl4z4RQD9hpyLTfCNmdv4KFSh4/u0N7eHcyQHaIw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RSspv8sqPz4Pzz/dWn44GYG6JQcL+3xEHkk0/IjmjRqJ48RfhUC6RFVIj2Tu0Vle+ysWiDDM1FSc8KgXZNeLQ89Cz94bEXkzeTImQzBjoFvO5A/f0cX1PwiqYNUbrs40PeF5zSq4atGRg71gOq+d4jrR3OGa6yGH/i4aeOc8oNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQZLiSIV; arc=fail smtp.client-ip=52.101.52.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQZLiSIV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJQ7stJK6Hfc4j9UVWMGZOgQeUeb0UyOtf7YNIgCiCrhiZDsZWiqFFb6o1oCz5BgzXHRD/PP44znOhA/x2KlDJuxQh+Pcyncg9hRjDIN2ZRaIG2c7WxxdMMI8TYNiR4s0fndb6Bt77t1HcypAYIQmabGol/4tZbUFYe9f7kOKzRVxTKU1urlyv/8bQ5198atRsW08hr/Osg0Q5NIR5SK8xcYROUM90baxswkTZJjCD9S50YbnMNu+AcajGZNh6hw7n3EoaUWMoN3NjJO390zRwRo3KVxPi9HNsB+nlca4d1PILU1GdEEbhedWcAZ1nL5jQcMCCrFdXYShTUmeg32Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g659//zQCVr+yrnIJiBwf7nckbvLwIV/9ExGkEPQ27M=;
 b=mAsO+GzPLwnIDPv15rvGVGOnYSVUNo6tQODG9eFoD0P2yHU8YL0Yv/EBqyp7l+UDhyouy9DIHqNrf44NJXttdKnctSqHjLRk3XYlqsvWuBvjsV1TXwaX3EPiO9k8UMT1R6TRHBlHOSVHooxdVSrw2gJw4EYOQjmtZ3UFiaESY0s7ZEwuNwsoeAvIr1HJbJ+HCMswp4QIEPWWz2E8Zor3PxuNhvP2rlsIEc9UVCNyve/hI8RYV/fnsFXrtCxNHZSNVfAYVYgnLbL74hWOFpRfmrecU1oKDhXnI4/Ir8GR01Hu1GMjRK/No9/i//5YHHA3Dpfp/RJUfadJSLGFlNsfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g659//zQCVr+yrnIJiBwf7nckbvLwIV/9ExGkEPQ27M=;
 b=pQZLiSIVbdBRuBgGbXTvzj/bRVIONyXCEd5pIIfTFoLeOOZSNu27TGyFPVNmL9tPCXllbrl0pLqK1rQsaxU3rowpqwPD5M7qeCyKb3+VxpEHUltNwASF1xkMc7YhenT390f/b6K+UlccpcIT4TwrRXHx/DGyosjhag8pdEXxzLwl0WxykituaY9vQFSMjpjplcsanLhKAX5ychObz3zR6GdreYKYqZIaOvdRNOSfyZJsXziJ4MBVWNnuF13euSQxHn/1WgVXZWvMOkTdF8iPU+W4g8VeocUAaoDOLarFoPn7qepO5FbdAMSoCiPDILU1glAshW1V2Wg4bduzRb7FTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 06:16:09 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 06:16:09 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 15:16:05 +0900
Message-Id: <DKZI8IV8X6Q0.27QMUO34GOFQ2@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 01/16] rust: io: register: reimplement as proc macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-1-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-1-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TYCPR01CA0206.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b60b872-788d-48da-943a-08df0402af5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|10067099003|3023799007|18002099003|22082099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	uI/vYf5dZG+gWstDg3YIPKslVzBHH1uoCmm16PPl8VweMBugH7uUGBW87bNeqlsGYUOUp/91CMiBHfnd0Mrgu6CvAyXtn6X6qsdQu7oYdM4tPxk5tUFu0k/YnFd9QyFCw67tb34Y92jiERYdyLifMrYIAOpmJKFStWrgUBv07icmQ5q4ijvxCvR4g//9J1cxpDBPwipSj32xbw3K+OCXRkocw5cKEnUAZFojsHSUNEpGuGTHJvvyDgnoUDdPIedIs3Thk7X/zmm6kVDvTm1cRpWW5rCWI3SCHS4NHt3XgkxGVA9gvFoga8xCk/KwFMNfLqnCVKL88HVD4qENq5itQ3TNmFmTzNhT/g9ccPuXvPDIuX1Qf9gzDDPXEANEVzXReuvXyjsWpjXmh8anB5mG8yJRakFj5LOCRf12ngwnkB8F6Pce7DWVnihjTtlf4hJpUFr8eNY7aQth7X/Lx/Pr6GV3npO25hZ7ZbUg6lai9pWF6tkOiAQS1Yw1cRvSGxpTs04qYeXWgjtPmll8yam3+GT9BaVSe+BNzaPLy73chlkhj7WhYME2VzYA70zZDklAeMkWIXBCQFVfXewC7lp1nK6V54P7KXxgRbzmrGJcf75+yNc+Prc4q6xN2y0XJDhTp+/7+y66iGXNfkTMpMNXDc9bVwsveoKdrYXbef6OQc8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(4143699003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVRiZUJhRDI1REk1ZngyTHZzYWtWRW90SUw5QzNOT01EZ1RlUmlvaXcxTXhm?=
 =?utf-8?B?eEdJQUhWRFNiWTE4VGVTS21Pbi9DRUlxbk9jbkY5Sk5VcDZyakhLczZraEpn?=
 =?utf-8?B?blRKUmlQbEM1Y1BKQWM2TE5zSjE4UlhMSC9OV2pIUGUwY3ZwOVVvYUI4alE0?=
 =?utf-8?B?cklxOHhybmtsdjBHUkhyVFBnZHZzQ3J6ci9OZExTR1dWZ0hoR0FKOUNHa25q?=
 =?utf-8?B?WUVheTZYTGdJL0xobjBVYzBJdHZTczV6QncvcW5HS1hhSGpRWC9nQ2NxWWZr?=
 =?utf-8?B?WkZ3Vkp3SzJCNGQzM1RmcThmazJPMGxsM3FYN1NsV25VdXE4Qy8yNnlSeWNX?=
 =?utf-8?B?enhJZ1lVUmpnVExIYTlndkg2RnJPNncrbU1xWGg0aThpUlBiZ2JBb01KNTM0?=
 =?utf-8?B?L1NYd204M0lRNzYxdlVSWnJPM2Q2ZUU1Y2NlV3RlSGNkN1B0dkFBdVFGS2sr?=
 =?utf-8?B?RUJUWjlROVYzanBXbGhlVHVPZ29tbWJJVmN4OHIva2dzZSsxQ1ZDZW5OM1Rr?=
 =?utf-8?B?NkFNMXlMNWNRQTJGVk8zR2plSUJXT2l3WmpMa3dmOG1KanJQeTlYMEJteTdC?=
 =?utf-8?B?RjdtbzdDMzlkWXB3MzRMMlFQWVQrVDhZNUtaTi9Cb2k1czFVL0JYZDk2RDNy?=
 =?utf-8?B?WmxvSlludFNnUXlvUnF5QUNTSDBqKzN0SzByM1lxeDRKcWdZcmMxVUsvYVoz?=
 =?utf-8?B?MjZ4dGQrSTY5ZGl1cjhxQUlmclp1K2tuODlzUExhdWY0T2JQQ2w4aGFMYXRB?=
 =?utf-8?B?dmpoeDQyRXpBMVhKQ0Z3NmRDZmI5djhheGlUNnhCdjFCTEIzcERNNmtwT003?=
 =?utf-8?B?WHpTMlNnSUJWUnZjckorQWRpc003aWNTRmwyMTBmMGl1eEd4cUU0RGFIOEx5?=
 =?utf-8?B?TFZpZGlIZFBCMkVuOFZ3d0VSYVNPT2V4THphWlBkSnhWT01TWnYxVi9ReHNG?=
 =?utf-8?B?R3l6VUxTeldPMDJqcVNLWnduNmYxYUV4Z2NjRXFoY0pNZTR1Yk03VTYyeDBi?=
 =?utf-8?B?M0Z4RFdBSllsanZBdDBKTGV5WENyMHVCRUNXL013bGkzMkVqZ0VYQkFES0xD?=
 =?utf-8?B?YVQxaVBnNloxY0lvdU05UDZWamwrRGpKeHJiZnhMTUFxTy9uUVM2SFVIZUlp?=
 =?utf-8?B?OGp1U2h3ak5iR3E3Q0lteVpzY3RaQ2Ird1NxZFNMZlBpa3pBYlpRNDFUeHk1?=
 =?utf-8?B?cDB6RVpIM0VSUldGTWN0S25KbTFyblkveW4rWXhRa29NdjBmOEVqRUpOcERQ?=
 =?utf-8?B?RHBNbHkzSGJ2ZHlsV0dKRXlZOW9keVpRNnpMYitRNE1Zb081UlFFRXI4dHdu?=
 =?utf-8?B?MjRrcDBpTlRzOUpiUllrbG03TW5PUEhabmVEeS8reVplTGZ2TlBZZVNZc0k4?=
 =?utf-8?B?RGJMTnJYTUFxcjZXdnMvYUFtUlY5MUt2R013NElXRVhSelJ3bUVGaGswVTlH?=
 =?utf-8?B?Q2VlN2NkRHIrUlBOak1VS29hbDdYUnY3YURMRTFQTVNjalZUZFdRMVZIYmRI?=
 =?utf-8?B?b01XeTRpUFJlSnRDQ1ZITU1tcjhXUUdOSzc5bVhtTDZ0UUhWbFU3eWNGdlhM?=
 =?utf-8?B?VUIxLzhUKy93SHpGN0xxb2FnQm45TkQwaFpnQjlJandxbXFMWk41aE1NQmFt?=
 =?utf-8?B?RHlXbkZHWmU4bDZZSFYvQ3l3U3ZsOVc3QXY1WjZ3bk9aQW9JaDAveS9XZmlX?=
 =?utf-8?B?WDJPaVhKVnc3ZlI1R3pKY1VrdFBFVGN1ZC9pOVJMY3ZOQzVDZWJJODB4TDRO?=
 =?utf-8?B?ODErQWg1elpLTmpYcTlodnhOL2U2VElnVHVMdWNrNGtYeTRRR3BoWU9mMndP?=
 =?utf-8?B?endVQXVLUUNMc21YZERVTktvd1UyTE0xc1RMY1NBcGhFSk41dGhYVUxybllW?=
 =?utf-8?B?SWQ4Y0lCUzBtVEpqRERZaEYxNUhPTERMRGxLUzhtWDZyZFNQbGZMaGxGNmcy?=
 =?utf-8?B?T3dkYXp5cWhnS1AvL3YrOVlkTVVOWUo3WW9PckpINWt1VHZ6NnBSdmJLNGkv?=
 =?utf-8?B?ZTlqMnRrSkZueWx6d3p2OEltSTI1M0U3bEFoUTFsRzQ4TU85M1Y1L0tvNnoy?=
 =?utf-8?B?VFZyMk02VUlwdWJISWpFWnpiK203eDRwK3U5akRUdXlZVGplRndndWIvYkVY?=
 =?utf-8?B?NE92Q1RDRlZIRkNZN2xqWDdici9CbS9sc0hDMzZIUEd5OVk4MG5CRGRyY1BB?=
 =?utf-8?B?UENOSElNVExnbHozY1EvSFg1ZDgwa2oxWU5xWXpJRnRUNEJjRnlnSm9zV251?=
 =?utf-8?B?VituRTkxVkR6dzZsRjNMOWgyekFHYno3UXpEVVZjTTJSV3VpdG16YWNBZzRs?=
 =?utf-8?B?ZFpMRXM2NGo0alVzOU1uNlVwMVlPQ2pmSlRuaTlmQjdVekdxRlppN1JiOUJr?=
 =?utf-8?Q?8NF3ZbS21vYewjgazqUJKvFuEOat/wqyCcJQw/7Vu6DJr?=
X-MS-Exchange-AntiSpam-MessageData-1: ES0t1cCWTprEGg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b60b872-788d-48da-943a-08df0402af5b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 06:16:09.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6Y1F/O3IAu8akvK96oBE3xzED1bGVI9Yos/E2sieHoafsvyHnt1mIufXYpPCGYOKVYVwQ5dT4/JaEg1w7FO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> The existing `register!` macro is implemented as a declarative macro.
> Reimplement it as proc macro instead, with no functional changes intended=
.
>
> The old implementation produces unhelpful diagnostics when things go wron=
g.
> For example, for code like
>
>     register! {
>         pub(crate) TESTREG(u32) {
>             31:0    data;
>         }
>     }
>
> which misses out the "@ offset" part of the specification, and the
> following error is produced:
>
> error: no rules expected `{`
>    --> test.rs:42:5
>     |
>  42 | /     register! {
>  43 | |         pub(crate) TESTREG(u32) {
>  44 | |             31:0    data;
> ...   |
> 100 | |     }
>     | |_____^ no rules expected this token in macro call
>
> which isn't very helpful. With the proc macro implementation, the followi=
ng
> error is produced:
>
> error: expected `@` or `=3D>`
>   --> tests.rs:43:33
>    |
> 43 |         pub(crate) TESTREG(u32) {
>    |                                 ^
>
> which is much more helpful. Apart from diagnostics, proc macro also has a
> benefit of not having follow-set restrictions, which makes syntax like
>
>     register!(name: ty @ offset);
>
> possible; declarative macro will reject this as `@` is not in the
> follow-set of "ty" metavariable kind.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Well that patch was a great way for me to finally learn how to write
proc macros! :)

The parser and generator are both simple enough, but the new macro
module would read a bit better with some light high-level doc (i.e.
module-level and most important types). But even for a beginner like me
this is almost self-explanatory, so no need to go too deep.

<...>
> diff --git a/rust/macros/io/mod.rs b/rust/macros/io/mod.rs
> new file mode 100644
> index 000000000000..39fa5bc302ba
> --- /dev/null
> +++ b/rust/macros/io/mod.rs
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: Apache-2.0 OR MIT

Other files use GPL-2.0 as license, is this on purpose?

<...>
> +pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
> +    let mut outputs =3D TokenStream::new();
> +
> +    for reg in def.regs {
> +        let Reg {
> +            attrs,
> +            vis,
> +            name,
> +            storage,
> +            array,
> +            relative_base,
> +            offset,
> +            bitfield_args,
> +        } =3D reg;
> +
> +        // Use register name's span for generated code, so error message=
s (if any) can point to it
> +        // instead of the entire register allocation.
> +        let span =3D name.span().resolved_at(Span::mixed_site());
> +
> +        let offset =3D match offset {
> +            RegOffset::Fixed { offset } =3D> quote!(#offset),
> +            RegOffset::Alias { alias } =3D> {
> +                quote_spanned!(alias.span().resolved_at(span) =3D>
> +                    <#alias as ::kernel::io::register::Register>::OFFSET
> +                )
> +            }
> +            RegOffset::ElementAlias { alias, idx } =3D> {
> +                outputs.extend(quote_spanned!(idx.span().resolved_at(spa=
n) =3D>
> +                    ::kernel::build_assert::static_assert!(
> +                        #idx < <#alias as ::kernel::io::register::Regist=
erArray>::SIZE
> +                    );
> +                ));
> +                quote_spanned!(alias.span().resolved_at(span) =3D>
> +                    <#alias as ::kernel::io::register::Register>::OFFSET
> +                        + #idx * <#alias as ::kernel::io::register::Regi=
sterArray>::STRIDE

Sashiko raised this but `#idx` should be within parentheses (this code
is replaced later down the series but let's make it correct
nonetheless).

<...>
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 24f96feaeb34..5807dee84747 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -19,6 +19,7 @@
>  mod fmt;
>  mod for_lt;
>  mod helpers;
> +mod io;
>  mod kunit;
>  mod module;
>  mod paste;
> @@ -481,6 +482,15 @@ pub fn paste(input: TokenStream) -> TokenStream {
>          .into()
>  }
> =20
> +#[doc(hidden)] // Documented in `kernel` crate.
> +#[proc_macro]
> +#[allow(non_snake_case)]

Is `non_snake_case` needed here?
