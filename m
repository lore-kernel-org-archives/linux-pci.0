Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022087.outbound.protection.outlook.com [52.101.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828C30C17B;
	Mon, 15 Jun 2026 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781518941; cv=fail; b=FNIFTog9lNP2iDMank75lz1dZPzITJcx4FWx1JYAuEGfq6B1dR5IFdAuPIbAAcPReoMsqGc1r3LMxYpg0zCV8x4eAoReDdNWplycn2AAEAL+FLbuvIPAKgyr9cPoT74rUSxLOVwWxz3Lb7GHCS6+Wq2t1aJy7wJ5F1WHpNW9aUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781518941; c=relaxed/simple;
	bh=imthxRUw/gTiVld48rsP+BoNetCrqjAADqUtMzMpByg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=NT3XVEkzezzDchJomWI7Ogp2SM+UBcRN24TPyAbQg/57TTCGNri99rl5dRFkluf2DByGaXUE0j4Td4aL+BKFQV+YCckfmMX+AalugqlkPjcO6WQfX1eSRRbwgMMA0KBj2cw0Gm2c5j3aqlj+unWy/WOVf3kKj4idqe3J5++psA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=E40ZYt9e; arc=fail smtp.client-ip=52.101.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="E40ZYt9e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeqbCttmqigouQYKL7xAqMMjdDjrMF6ir01Oe9FjLFHoy4WjdmSYEyYPHQwpZzDYs1rnx3RaTwp+Hc5nAbycTA/eVRdqZ7URVZQ3KJMZs+zftoWtsbk5AZE6txI2njW1dX+T9fRz594/plLK1bAuTWFZAg0DwLkM+bQH8yddV4753kH6C8itdN/9+Yik48BTkXe0IBwjdn6qXhgfEaZl3+frBJYWKfyhrDbCuynBjA/6tOSUm98+DTzakmCuEh3DkfFWH1nGUmFgwqDZSGHT3wDLxgXpTbD3QsBFXv6V7tJo+sTgFldir+qsQSIg9yoG8cyQBbFQkbbk3DHTC+HirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H/SKRl+RGTYsUoYCo7qgtx+V9axqER00dGCcynM73s=;
 b=MZup5GrjqOdJ5F27uwUS+k0URJE6xqLJW06WCTEvvf8leZo1vztP60eKcjgynCNJeuf2xmJ6Y8xw8HH7ntoWrgqQSbUaClngkZ3rYMZLMHDLjftEY95owXM3xkLFWxUb0K8NHAXkHfP13R92t91Kfkvy2FaLoGjM2/AMlGl2qkaw7jrvCG3fXNsgK1afhmaM3mbMDSiBdHBje/WoEYB0N9VLp1gys8HgOd1TCHEDJNlo8JOeuUe2Ldfbo2ESfIJZESpmiHtidulG3MVJemp5RjktyR4f+dm0oFJVSyts+3ZCOxF57CUtcRsLASe1LTcExD7hTCBB/iH2RnOFL+yqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H/SKRl+RGTYsUoYCo7qgtx+V9axqER00dGCcynM73s=;
 b=E40ZYt9eFkBZ5dYE7PjFua1GU/3L5dhsOGt4JpJH2rSty89Z0Qzw3iZN66aYi14nYw4Lcjwxrx/315JjmI79AzFhHBkxL9UPZM9YyAaTvS4iyNhG1BFuHRJisMFvIedVumOU/P2iOgufgxeFIw0oyFjmzijosi9vwiyqIR0xv5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB8469.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:463::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:22:16 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:22:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 11:22:16 +0100
Message-Id: <DJ9JR8VSQKQ0.3MV3AKK5YQW90@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 03/20] rust: io: restrict untyped IO access and
 `register!` to `Region`
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-3-1f7224b02dcb@garyguo.net>
 <DJ9DA9MXXIC3.2RHNX47QLXZDH@nvidia.com>
In-Reply-To: <DJ9DA9MXXIC3.2RHNX47QLXZDH@nvidia.com>
X-ClientProxiedBy: LO4P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 3226bfe5-8f76-4697-3880-08decac7f97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|10070799003|1800799024|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HdBn/Y3hljy3kMZFrC1AmxFQ0Xaq7V486KDlO2Fgy2/Hw3GUwtETMi3CKGnz2Av5b4tDzchlvFdejzk5FCej6xcZTrF8j4Oc8PwrcB21oUPWJ8Ioc7nHxkbOnvTC2xkeFlQIo4TU/X9pHuqsZfPdQ7IotPTI67PsLkJROqfZmfh82kgFU9j9Vm4CNMyfvxcE+hARhRbvY2MeW/8LUZoKkx1CrATi408mWy2PgWlv1pS/Ifd+ehwvyWEvLhT2nj9vw6PJa6bry7DH4sPLC42M9YjJPHISu0romDEL3Zisk9a468eodvEqdoqWbUco/J00TVTZ4HTs4D9H7uguUx7kJ9C43WzxZCo1L1Vu8k/dxQBCLZmyUn0Lt5g5lXgNERQn9ppiIWfOek4nOJe+BnAxxrZ5EN2W9av1fXex5GiwLCS3sXktW0FKMr2sxeM6HgCiPDKA8vqO26K37nmp6H2DWRW5y04wLx3OrH6NYt6mPVmdwzzkI6fbfBhbWge381WiGlkLti0JOGrR9ggXIqPoA54LyHh+Ir12EQoJxmJazU8G48EGxpt/bbvmxEXLxKXaZw5N9V9ZejknhyByTAYQKva7GQO3pSXYSKRtcjGwMhwa5PZfxP73YLAr45k/smNLWtyEbkLD653g2E7LCpJ7Q3t4bOYHU++7Mld4Lc3AU9i65KTaJ4uBvw7+rRVJza/W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(10070799003)(1800799024)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTJCbTVFT1lsbXZacklWRmpQSHNDeGU5VE1QQjI1ejNIdFBTU1pUbU9wNXdT?=
 =?utf-8?B?Q0VOcGZpR2xqMW1EaEp4TEM3TjBTZENLQWtNYjZwa3kzTXhsbmJqS3oxYlQw?=
 =?utf-8?B?Smk0VXF4dFFOM0RYQlpPR2NlZ2U4Z0VyVlcxTGdTNlF3M2lBWnlvTkxSRGcy?=
 =?utf-8?B?cnpYOEVQTlpINFRGVWg4ZEpvOHYwWXJyTEQxaUR4YVJPREI3YmVUc3JjY0h0?=
 =?utf-8?B?a1ppUWdRLzVXK1g3eHg4eUhkVHJEa0FEQU5HWkFZU0RSKzVoRkV5b0lMaFF5?=
 =?utf-8?B?OEQxQnFhQTQyOTQ4akxkVzh1Tk4yZTlIN1JIYXF4MTRyMWJjME9udkduTWhP?=
 =?utf-8?B?Y3RiZDdOKzZxdjM3K3ZQdm4yejkzZVdWRVZOWHE3ZEN5enVvRHA0ZDZHQVFV?=
 =?utf-8?B?ZnpYSklKM2w2MHFna3ZwOTNoRDIva2JIWXZseFhFbU5oa05DMERFaUVwQjA3?=
 =?utf-8?B?SlZpbkx2bUc2bGN5WHZ4eW1vUlBqb3JoSUd2cERVem5jekloRk1EeDhrbWJJ?=
 =?utf-8?B?Y0RENjVWRUdIWjY5WWVZVWZTdUt6TWxWc0RQMWdZT1Z6ZUlpRWNQUGpVRXdG?=
 =?utf-8?B?WGFIZzBVVENacWxRQiswOTl5bVFsazVtUXJJNm02Rjl1dzhYQ1haQ1dZSmdv?=
 =?utf-8?B?Wkh4QkpsM0xQNTRiUThhb1YxV0NnNjRhZm4zMEU1azY2M0U4dTdhaGU5Q3VE?=
 =?utf-8?B?bFlKblhEa0t4QjJ6Vmo3eVZXUW9QV3Q1UC9uNmpUMjlvdHZzWTFScUpvWmVY?=
 =?utf-8?B?VlVudDFnWFV0M0pKWUlxaVN2MEJsUnE4bUsxWlMyT2FOc21jWFIyM2dxcFpD?=
 =?utf-8?B?Ym42SkppK25vTm1BRXlnUFVMSWJWZS8rQy9vNEN1NEtqWlNRVFAwbnVVNzJ1?=
 =?utf-8?B?VHlyN1orWG1WQW5kMVpyT20waUxwN2JKTW9TV2dOY2V5N3AxR29IL3psaTJu?=
 =?utf-8?B?REJVdkFFdGxTSnFQNldKT3ZjYk9meld2UUlPZ1VPYlJGNmFRL3lyaGlEN3Qr?=
 =?utf-8?B?MDg3S2dSQzZaU3RiNHBOaTcrZENRVW1UUDNVaEdQVEdlbUhXWldQU1RJWEdT?=
 =?utf-8?B?ZDExS2VnL3V4b05JaGNielJVQzh1Um5xWEEwaFJjYWo3UmhJZGNiazJWU2w4?=
 =?utf-8?B?OUxvM2FjVXJwNlN4dDFmaHFwdXZ5RHhJcHRwQUFsd0NWN2VpMDcwWThoeWpC?=
 =?utf-8?B?SmowaUduNzN0MVFqZEg1Wjl5SVQvRXJxb0tKV1NiRy9EUUMrL1JvOEwxM0Vv?=
 =?utf-8?B?M1VXbnh6MHdSc2JkTkt6M2QvZE1DY3lwMnZNcVlYSWdzVG9oNEkxVk5paHpY?=
 =?utf-8?B?aXhTaG84T1piUG1wQk02enpCRjlwdVVnZXVqdndEbkczZ0dhSDA2YW82YWRr?=
 =?utf-8?B?clFvNmRtQ2doUTNrRmFOSXRzOHplV09qYjNKdE1FVDhiQ0VNbnk1MDFQWWZt?=
 =?utf-8?B?QzNGT0xkOE1Va3hDWUpTY01YVHFkc1FWcWE2YlhvNWNyclJ4UitnemNON045?=
 =?utf-8?B?WXE4UisyTElRTFE0N1JiZGhlZlhEeGN4bGJ1aUt3dEhSUUJPbytQRWJub3RK?=
 =?utf-8?B?TndDOHpEOVpqdVZqSXg4cGRicjdYc0lqRzYrTGVLRmY0S05CRStNaEVMUGI4?=
 =?utf-8?B?NHlGdDFmS3Z6Um1NbWlKNGFoZmFLamlCTTRCekk4L2kvWXZQVXlHREk0eE1G?=
 =?utf-8?B?dWh2elI0a1ZYRFoxeU5OaUhtQ2tweGU0dzdNSzArQ3hoQ2VKSy9SODFHZjZs?=
 =?utf-8?B?VVVVSmZnaXRHaElwNUJrMkRncjAvTnBsOGlTa0ZycWdqZEtoQlRnUUNtL3Zm?=
 =?utf-8?B?U2hhL09OeC84eUU1MmRuZW9scGVpUi9YbXpRZnBrL3hScWtqeGtmS2JiaUJG?=
 =?utf-8?B?a1VWem9YSmNxZlZjNmtsMjVsd3RSQ3dwQzRoQkY2d1ZSM1hTNVNneE1uN2FW?=
 =?utf-8?B?WlI2eVpNWEVUbk91QWxNbmtMTkNWc0VKVVBqVnFKWjNRVDRoYkcrWWRCbVZU?=
 =?utf-8?B?OXcrNGZMZU5UV2J0dGYvdHZ4enQ0cDZ2Q3B5OUc3TWNDVW1RNVlMcjFUclpa?=
 =?utf-8?B?bUxvck1iODl5QUg3V0Zzb2JCVXlyT3VMZ3cwNHNlNFNyR2J6YmgrWEJDcDhW?=
 =?utf-8?B?T3R4enVUaDRzZXZ5UjlCbktkMHorY3dVVlVTeFJCSkpubW44YTZrMFhTNjh1?=
 =?utf-8?B?YUJQczZ2TUgvbEdRa2NOWXVLMkJUN0oxT0FQU1htVitZb2hLTlFuU2hrMXo3?=
 =?utf-8?B?VFZCZ2NEaUlYbkswRUY3cWtGVFlJSEp3SkxYOTFYaHZzUndGSGF3UEZzaTJv?=
 =?utf-8?B?bmNQbTNXcmMremZkaEV4UFExc2M3MTRKTENRcE5CODkrSGw5SUtFdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3226bfe5-8f76-4697-3880-08decac7f97f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:22:16.7269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2RRGEHSq4NwKLPG2UZOqZU1jP7FuTfmlzPBTW5/TfN6kXH+hkSmSvKfKkBSAatm7ll2OvE5lTPntljESlg4AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB8469

On Mon Jun 15, 2026 at 6:17 AM BST, Alexandre Courbot wrote:
> On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
>> -impl<T, B> IoLoc<T> for RelativeRegisterLoc<T, B>
>> +// FIXME: Make use of `Base` type parameter of `Region` directly.
>
> `Region` does not have any `Base` type parameter, so I am not sure what
> this refers to.

Hmm, this is indeed awkwardly worded. I think I want to say

    Make use of `Base` type parameter instead of using `Region` directly.

The idea is that with `IoLoc<Base, T>`, we can have

    #[repr(transparent)]
    struct Subregion(Region<SUBREGION_SIZE>);

and have `RelativeRegisterLoc` just become `impl IoLoc<Subregion, T>`.
`Subregion` then itself can be a `impl IoLoc<Region, Subregion>` and we can=
 use
projection to get the view of the subregion.

Anyhow, that is all further possibilities, and I'll just remove this line i=
n the
next version.

Best,
Gary

>
> Is this to make relative registers tied to a specific register block
> type? If so, it would help to expand this FIXME a bit as it might be
> difficult to understand without context.


