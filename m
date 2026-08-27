Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12845000;
	Thu, 27 Aug 2026 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814117; cv=fail; b=I+WeDNH5rZTpS1LMjBbzhTgknjEja+3DXA+9xVVc/sE7Gp+aHxWECDvbo5CXEJEX5zIeYv7ICy7YfpoaPN/oQWMzLHOHaSUpNwp5f+1m4LPDWOJwDVFri6sTBwCjkbFgWUFueR/wAdnoJkQaZ72I5MZLNCQq2BfZ8kx+b8J19o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814117; c=relaxed/simple;
	bh=6ypyPF047ZL5k4OESZRqEcercnHx674PncOtByEd2r4=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=g8EGS1YxL9LWQKffwP5ByD+HjnFOn4lcmYtNCiR4FXLR+KQJo7IGRB8NnqBhG9rBra0sQNcwnJD5qhMAtbxTqb/nC/NMqFnSZEU5SLJI47wUF7glAr5d900Dni6LbNBIfgWtQdwbp7bJ8NoeWPnVqYMEVCQk8+4nWAa1+MLeOlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jE9Gj4Og; arc=fail smtp.client-ip=52.101.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jE9Gj4Og"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y555JF/+oPN7UZoHAWGeuR9Q+8Zdy0pG4wFYXVoEh4Lm+yDQur9JLYmm2SOGg/S77EZgic2WWX83H66aQHKW64u6G3a0cM6DEbSs5Jg/mw5PfqxjzTwPqeyBhIGL+BkbRVXmcWPQkGwgBBZpEaU8G1wqx6THdXrOtYbc6g9v2fjcgKdO6XtmtDiVZJONhUY0E7U0YrpBm4WSTTzL571opQr3Z5jJ4kAnhIayYjgZW45NSsDbFqmr6ttwJ6XdoM6QEWigd1sZLHN3sRHxwD5H5/0aS9FHjwJLgDN/4i0cY9daE/asFwkjYXfFcAzjbLB5h/R6kHP/cIRvCz+ffebRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ypyPF047ZL5k4OESZRqEcercnHx674PncOtByEd2r4=;
 b=oHpVEauk2IZX9/H0R/ViFO0jVwC4RGiXJOt46Bux71bHOQ+6Bz/6fPIzuVuPaRXPkl8zhvhKlawFjufydTLuV54WqArlxBwzEm5cGyi5/Yn607grAdVAlSFYUQc9aLPVPTE+5T/nqlyb1iHCQgpHFNlOBi437cNGOKR/+BLOylhzIhfePBGsNo095voKz9Lvb03PRbvRdNyuFidEotrqUp9ioZ38O9tbfMskHAKKBxoXe/SC+fyAEkwTyP/kxn1S6Qzzpe1UT+ecW7BILjMOph8lKolXWZmznsaqyV9orB+pweZLxvjnE3OKuKpRwKb7OI6BDMQdG3kVbf2Qyv3BWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ypyPF047ZL5k4OESZRqEcercnHx674PncOtByEd2r4=;
 b=jE9Gj4OgQpe2LZLsvUlBAx7qlUlgTGhCMpUssE8ZY8nNQM90DvMXVyYXMzu2DDfBBGN8hDoVAB2SxyVWO6ir7oQRDORjjaftbRuSA28GMKyKSl+QBLgimkgSAXiqSat9FKZYYVCsvcCd0r9hUPXScagAAKseIPatUDQqRzPDcgiCFRQg5PNvVK+X2MUH/dHsK+5emx8rA0z6r3CD7FJrhRQ9Xup06pKTyKJJ39dQzPKOWzpSfdmNDC1C7PJaASSG0kyml4UjEQi2IgMueUSGat+gvE4HK1avQe1AbmiiVkaOCjr5a+Bl26PYFAaLMfYE4Qictu5WKKmH2xSu7ajAPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 07:01:52 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 07:01:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 16:01:49 +0900
Message-Id: <DKZJ7JFNYCXB.2U27C3L3NTNJ@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
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
Subject: Re: [PATCH v3 05/16] rust: io: support register projections
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-5-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-5-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TYCP286CA0121.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: e566ae3b-ff98-45a2-f0f2-08df04091238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|10070799003|376014|7416014|56012099006|10067099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	a3cKJq/OjkAWAw/dY/tvDHLwBpfJ0ti3KrQ6Rj1zqmhp5CsM4Ru8hi6tsQkDLptyKltCRdmLl+ToHKEVOxFkYwg698DNLY4H5xC9Y/ye3V2Xw9fq8jRXoXQxInl6lES95L7rJEYBvyibkhdKzLetrS33f0/14TtyodTNob8v33v5wezAT4GBiy4Sxh1LSm9RhoJJepy8151m3RpSDaQCDk+UKg39sB7jaBZdD7qk+pCEPPgInEKsbG6sVS5mVIGCrGAbMh/3OSzq1IV31W9hzGTJVs5JE/qVREgNACA1UCeNtrkfoUWarylhR8hUTlPq7tU/baOPsNj3pXaq98HhjCexMWvQoHlNfnvIqhVPU0HwAMgEoMBWe44BoUshox9SM26UT0ifEoYYVJkMAfIZ6UFNJWC4hrFLz+9AxkJ6Tv3lof7oQAmrCqst7NR/+XJ6AgBFDQ+X11bumpgU1SFeLEBZ6xAN8Adpd6/94BpFSK3HTE6+rjLhFQzo8BxhxVhSkvCnNWcF8pIT+oSCVM6c6T3/eAroF1yjj2nObOwUTZTRkd5Zl6ZGyTyANlbcKvf+XVQYH0JxryKXktWVJaCZ/UEr/XpvJWUjkncJ0VCpYkhApubGZabV1LVFN9Wop/xV1L37EmuXcvaQxoav9H3ENwMzoscqhhu86fNulFm7S+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(376014)(7416014)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEp3TmM2OUpDSjZLVTBwZTRFSUFVazdBU0k2SHBCV3o0N3JOcy95QVcvNEZv?=
 =?utf-8?B?aGZkSjNhc00rczQ3RHdRVTJXV2s5QXFUbzh0bXFrSC8yRytGTndtRE4yMm9n?=
 =?utf-8?B?UzV0cjkwZ1VEazJmUWVrbk51SlhrOVorR2ovZWlwbmNQSnBiVmswK2ZxR082?=
 =?utf-8?B?bEw1TGRCekdHUWw5c0FOdFZHdU56dWhXeWk5ZmhnMms1aks5b3M3TmhIbHVY?=
 =?utf-8?B?eXVTV2FqQ3liL2tFY2pnRUlTeDRsemNKSnR4aEZBbllROFRyQXJ2c1JwZnRh?=
 =?utf-8?B?T2lydzU3OWdPU2NuL21rZCtxN2luUkthNW01N3lPL1A5cXhLN0VNVlhFSGtW?=
 =?utf-8?B?cG5DOVpudkdJMVh6eTkrN2lqT2lkSWN6VXlTQVFPVmQzUU9OdzRKM09SOVFl?=
 =?utf-8?B?YjNEdE5TVERxY0xSUTFCNHpnbEgwOStwS2tla3VYdnNQZFpFYjhmSy80Yldv?=
 =?utf-8?B?UmxoYTRzdjQ5UFp0SkhOWkVORmZuMVJVRnA5c29CRE1lZjZtb0dPNENQZTNX?=
 =?utf-8?B?YnovbFJUaFcxallJci9jTWpwUnFpc0paVURlampTNEthV0NPMEttZXR3S3VU?=
 =?utf-8?B?TzVUSEVXRGdCSEV6Ull4RUNzU2c3K0xLaDY4SWJNb0YxWTNQcjhHb2dsWmZo?=
 =?utf-8?B?cGdUaTZZRCtuVE1wRHNsRFcrUDBvTEdhbFRiVnEyUVgxWGM3SW1NMGNyRUcr?=
 =?utf-8?B?Ky9EdTV2dk81anpQSUZJdXhTL1VpNDI1a1FzeGxmRUZQNVZRSUZCTVRnT0tF?=
 =?utf-8?B?NnRtbzJCNHpPWGZFR1FreXNDYlRhOWJWMWk3Q1lVdCswYjdoRTZvRGJ5SnVG?=
 =?utf-8?B?SEVSWTJZOFJxa0UzTENmalZ3bkUwUFg0ZmFVb3E4NEVWWWw5QmZXbzd0dzg1?=
 =?utf-8?B?SFVhOHVzc2JNQXRwQ2Nrak8rWFp1SXR5Mng4TlpEUHYwcDVycHNBZ05oaTl5?=
 =?utf-8?B?SE1NUzZTUUJ2bktwa3Y5SkNZL0xmOEhabXhyd0ZiTFdYWnRJNnMzR3BtL3lo?=
 =?utf-8?B?MEQvcGEwWVc2Y1AwYWp5TGVUWVlqNktYNC9YMzBVa1kyeHdOS05BM1NVN2Z1?=
 =?utf-8?B?Q1haL0FjTTF2QjNtY3NCaVAvbnlwbVN4OU9XZkpRNEUzcmM2cEdKQmtSRVFj?=
 =?utf-8?B?Sjc3akNpelZyczNpLzROVDBqeHdsS1lxNmFoYi9ENStWUFhya25RMFZjYXNC?=
 =?utf-8?B?WVBBY1l5aFp6cWd6REFEclIya1RETjEwSlY1OWNXOFJYMDk2WmtpWGxPZHlF?=
 =?utf-8?B?U3h4VzB0eC8xWHhzUy9Hdkl3RUJGYzJreWMyVXhTWTJsNmlQbjlObEp3Q1FO?=
 =?utf-8?B?czVqcFlFMlNMZWlaMHFHWUp2WkdUL0grMkZzNFY5K2ZrY2pPeVRRNmZaTFh1?=
 =?utf-8?B?REtlVHlzUS9MZTF3UFZiU2dmUUd6WVhEZ3kwL1l3VDRqUHNsV05nSS9NVTdH?=
 =?utf-8?B?REZJbnBlQTF6Z1hXc2twSEs0d2thSm8zZzRKU0tiNUkwcWJsakF0NWNQQjda?=
 =?utf-8?B?dndma2lBcHQ3R3pzbFJndG1SMmxIcHd1NlRHUVpTc3JwZUVjRWpZcXlqeUg5?=
 =?utf-8?B?NEpCeUViVjM3THFLMmJpTGlqb29iUDV0WW5WeGVhMi9JL05PU2ZkalN5b0pv?=
 =?utf-8?B?QU1YamFNQWhoZUtwVFlWME1udmYyaGpUYXkxb0U1RWlURlphNmRDQ21iMGMx?=
 =?utf-8?B?YnlrSlJMdEcyR2VFTm1PM0VxZzJLNWRzbkU2RlY1eTdJeGRKVHVlTlI0ZUFw?=
 =?utf-8?B?MGxmYzFJZkM2a09QTGZ4RTRqRjc2T0xzSEVHWklZNUhha2VKQ1hoR3VsU29L?=
 =?utf-8?B?Z0lMdGdzbkxLQWJoU0I1MjJvWGFkRzM0Nit1TUhrb20yLzdMRkFXZjFGVG1v?=
 =?utf-8?B?VkFyOFJPankza05FVHRTVFg4YklLUWx5SWVjUXhCYVBBbW8ydXQydE5GbFNJ?=
 =?utf-8?B?eVBabVNoRG9LNm1aUldiQjlselkwa0ExZ0g0M3RWbnpZRTFjSXcvdHVxN09l?=
 =?utf-8?B?eGVaY3FpNVNoT0xJby9MZ05TNGNLRVhUOUh2b2tWQUlYampNZ0lvTlJ3d3RJ?=
 =?utf-8?B?MlVQZFRrNnVFemt2V3ZDdi9sdzJVb2NQK1Vlb3E1Y3BLc1Z2YUhJa0ZZT0Z2?=
 =?utf-8?B?Sk9YenBKY1pqQkpXK280STRWeExoUWprZUpnTkpRelZhSFBrbDQ5dWgybXVC?=
 =?utf-8?B?LytGdk5jbTVDVXhWdkYxbzRCNXV0U2RHR0FCeWtKOWpKMlZ5ZDRNVUszdFN3?=
 =?utf-8?B?ZlUvdmJ6V0l4Zzdvc0Z2MUovWU9jV055Qko3VEQ4TGZQdmt4UCtOeWhYOVh0?=
 =?utf-8?B?SVpyTWhpd2hsVzRla3VFSHVoNlQ1R1JaZDJMWWltU0lIQ0hXZDNPS0tzMFps?=
 =?utf-8?Q?g0JcvoOUBvG85k4Ke0Rlj0hE+V2UkbhQHqO2GFWd5Lv0Q?=
X-MS-Exchange-AntiSpam-MessageData-1: vAJ2Rgi48fFFyA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e566ae3b-ff98-45a2-f0f2-08df04091238
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:01:51.7788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HcyfqxACiSnmk82FRvl9YsCKpzR15RydACDuA5KeDQh4GVc+rY4DpZ9zARWnmSZx6v+7yK5KB7vVj9YQxxa6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> `IoLoc`s themselves just describe a projection from a region to a concret=
e
> register. Thus, support it in `io_project` macro too. Also, update method=
s
> that operate on `IoLoc` to use I/O projection.
>
> Documentation of `io_project!` is not expanded yet as the example works
> better when `register!` type can specify base type. `io_read!` and
> `io_write!` gains the ability to operate on registers as corollary of the
> capability of `io_project!`. Examples are not added because `read` and
> `write` is still preferrably used instead.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
