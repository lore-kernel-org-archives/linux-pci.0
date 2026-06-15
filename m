Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1756B30648A;
	Mon, 15 Jun 2026 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500691; cv=fail; b=VCml8lJaa/igd/EY6ULOXd/rw/ycI/tWSPcdnrKJ5WI9RsUeoID9D22+Ojl522Ompw2cz0yRqjJZIHo4CoFdvTdzMzEpENm5L57tpLYp2H3XKNRonkjA9H6S6jXRukpdgf7g6o2st5BBpZw2jIKaF/XeiLuW9uZAUmp9Hdovoa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500691; c=relaxed/simple;
	bh=G9LRm4slI3uIOfeMgT0YBW7PM+HqGX3tZmGizE60bBI=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=G3k9AUdNRG+zJJwf4xbsUn/301TUAWId4kXspj+/360ZbdMN3rKWqJNwqByB5JU00N0rQJkovogSAaX5cVTsdO8aDKATeR/L4kcxro0MHvuuk6eaXAZkEZPieq3Ki+dpi+rPn808/byW7SeX0s1xJBnQHpKPsmRRfo14L5zi1us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XWHjreZV; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XWHjreZV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmsXJk+Kaan6eO/Y9j9nV39tVugnKbBFoQUpHdq6HRCNgIRDIjOaQfp0GGDeyMo/2n+w0F5Ow74DISLCvy7nKDlCKcvAbTALRXgYqk0a1+EHZiE60WchS2x9hvFp+ALnI3i+eJ7UOOkYDfMlYAOelnbOlGCyZ59wTvbWkydn9RxaGVoKHpH+J9icOBh/npPPzeIpG6uw6T15dv4XeuuvIdQNlwDEwZqD9bJDvtwonYVLSUhllGL+hsJKC8uIaStmK4vKC8dUgAWr+3HI5NJ0RzIRbPBG+McUsOocg7P69JrVg0HEpSxlD5d+WstvJE+6+l3FcJQtOWvOOLS4/5F61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsF7HHL9noiq0vIKfahf0eqtBgr4fhTH5Q6IVAnqdhQ=;
 b=NIeFJrdG4QIS3otbrJM3c/7LACzLYmSoz7Jw4CzM0rXLHAaHtcyjqvTmL1qonKdRORw+xXo3Ea1XpeGAyhXk8yUn0e+3WNcUqsvzW82Kxhz373dViXaUoZfnzLDD4RRsBu1SVbK0G1uF+3Krxl1wE1ZRPgQ+yl/hidfC6W1Hbm4bX4m7CDVxC9EvSq7befWqn+O+swInIo1ev3thSeogaOtvVR3HY5i0MY0FDfiuHrzXp7dGSiCnPIzK3ApLRVRfYEqjSkNbWOXKbUzt/B01R5Zy+VITUjDh/DSWwV3HoYeZl7aV4o42ujd/Nqnsz4XSRKyG7pAHdvNtWIboZ1IUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsF7HHL9noiq0vIKfahf0eqtBgr4fhTH5Q6IVAnqdhQ=;
 b=XWHjreZVFHx1f6AGFaJovk/6h7ewNWK7nDlIyUqVzFS4bQQMqp8+Yz4OwwAblfdGEaa7VoAZADEkM7GOFvy/lc9qnXcLeKOk3HlR196oIDswCddlwqvSd8J0opnhlwW+R6tmP0w2d8/1+/Yv5ODlOxFoLLb3zt/MHaV6drdgsPqGNXZCT0DP2aXgXWFaacfdkHnyWVDK5gc3ZHwglCHqYgTnzRJsEVSSLbHRYiu90nI1ViWu83/W/GbDcg6KxXVBTb4fp2LskfVT+YGj3c49dVRAE7BikLD5jHTH+Y1AUs/DKZLBV1Tl5crMf7kb6CJsmnXfL5dnm4ioGR4CFARzqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Mon, 15 Jun
 2026 05:18:03 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 05:18:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 14:17:58 +0900
Message-Id: <DJ9DA9MXXIC3.2RHNX47QLXZDH@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
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
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-3-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-3-1f7224b02dcb@garyguo.net>
X-ClientProxiedBy: TYCPR01CA0168.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d242fee-a1d3-462f-b726-08deca9d7937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|10070799003|1800799024|4143699003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KAOXjxRRekUS359moOh6pg+09+dF1wyJEfAIHnKs88QIiHDOuQFjKeqvmoSPmWYqD8MPfbZYlJisZQjQVZ6pqWvz0Ore52UqlfDG94X3/6zkFYzdmYnI3atgNAZtEoxdCpMuzvv3rMRGw7WwSCwRM2DF05eV2ZPuOpB/sTqEuBdepdWzcgSGkC4B5B/yTipF/xCuJxwMSmqunyM/p3lsI0B41bbiuqd6fUKwVvcYvml2dzXUkr2kPHhEvap69Yk020UHoBNCo3noooDVAw8mNDeY0r6Cfw++yZreJU5Db1ErE3kAPojeLvPqsoa0jKdgj/Cc6aYyogjGHBfo1uJbq2EiUEJ1i7fUA3FQL4iwDgVppnGH5085118ZCocJD5cmsvBPmCAmEGVKW77eoIb2x/eNJSiAz76EQMUbBKUnr/CnQQYTCj4IDsprL3QeedWajKzyJs8dlvtNDjbNhrhxcrvypjupoE2UX+YTguP/VlTiVkWsBkqzWF4r9EFzGnkkXNXVgU28tddJuOiHsJCDLqbrKkUHVxyr+c5abgwy7Pp6WXPevdpkvmkrQICy7cZ7zEafCRyIL1LOlMESICcn1PkEzGh/UP+ucL8nPar5jZFyB74nX9di2lbpt53OdYbutR8vIpSK5gYLHNLbCV994jc0K5jzAGjkGywUhzQqXViSCRjl97ko1S2xGvsXYcVFGiaLw3lViAJeTHZWC/SlTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(10070799003)(1800799024)(4143699003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWNReGJUQ2JleVY4T1lBRmExTTBUQnJDZm9IV0ZtWHI4Sm5CY2hZYkFUS3VT?=
 =?utf-8?B?bHhmTmN1UTBJemlLS255Q3l5MlVEV0RCVGxpbGVnRDl4RXBVM3doT0RrN2lW?=
 =?utf-8?B?NHIvOENnRnB4ZUlWKzZmUy9vREhyVGprWHM5bmxDT2E4Z1hMdUFJWXBqTklM?=
 =?utf-8?B?cTBXcFE0TDVCaGtBM1VOaXo1Zm9MOTBIY1cwTWVSWE13WlA1Vk8vU1VLNlRN?=
 =?utf-8?B?NWQwb3dsaldrNGZQeVkzZlJaQ3pSd09McHduUUlqeldBMkFIRENvZG5IbmpV?=
 =?utf-8?B?TnNVTU50dEE2NU43ZldyTnVwK2hYMjVHT09JWEFiMmNLY1JvbnZKcEJNNnUy?=
 =?utf-8?B?UWhtSUc3bFB5eUNieTNhQWtDM0UxUDlPVytCQldSck1RU1RrSVRvOVRLNmpw?=
 =?utf-8?B?ZTduQ2dKbTBsZXFYZ09tTE9qZVJaQnFFV1lodzUrNUNGZ3F5bm1xSkxjeHZs?=
 =?utf-8?B?bTVTRDNUT1ZuMkowSE9xRW43TTRYc3d2aXY5Y0l0bnBXTGxOQ0dQeUxiK2JC?=
 =?utf-8?B?N0J2YTI0a1pKUDhJZzE5MUwrTGRDb25pdURmN1plcmNSYktPenQxSjFmQXgv?=
 =?utf-8?B?TFVnb1RvaS9YTkdNRU95dlpFbjJrN3AvamxWS28xVHJ4bHBlUzRjeVpjRkM1?=
 =?utf-8?B?VUNISCt4U05Pa05MVnN0d2dlL2ZzT21ZTEpkUlRyR1NlSzM2Qzc4cHBIdENN?=
 =?utf-8?B?Vk9WU2lvaFdOcGt2RTdQMEhMSFZFQkx6Um45RG16QUJwSy9ESVVGQmIvaVRa?=
 =?utf-8?B?Wml5ODdYTHA2R3RoZnBpVCtMczR5MlgyUEZIdmhhVUJPb1J6bWl1QTQ5T1VR?=
 =?utf-8?B?ZVA0RmorL1R6dG1IdDRnblI4SFNqUHFtMDNRL3RMZXp0TnhuNmxaYURmQ29G?=
 =?utf-8?B?cWJQWndVVmV6ZWhlOVkvSmQ5Y250VzBDWlBoUHRET3QwK2x2Y1lyTVdNdVZ6?=
 =?utf-8?B?dTQza0wxd3d1cDJ3bnlHd0VZSVBFTm5hSURUNnMvOXlFV3phY0V1Mmdlbk9j?=
 =?utf-8?B?ZlE0YWJnLzF3K1J1ZWozUjFHK09Ici9DeDZKSTRwUVdZQURKOWIvcWJyS3RS?=
 =?utf-8?B?TU1qd3Z0ekR0c1VRNU1YdnZYdGgxRk9kWTV5cGx0cE5SUGJiZkJrcnBVbXcz?=
 =?utf-8?B?Zkw2UWtYM01aZ2JyM2FnL0FGQWZUQXlCYU1NeDh1OUN5c283SUJEOWlCblVx?=
 =?utf-8?B?TFMwREJJQVRyZUdhNU1zV0Uya09vQ21SK0Y3MEIzdzZtdVd3RGZCem54NlpC?=
 =?utf-8?B?Ynh4VGg3clpmZld4WGxvTGxRYlRnUnA5TjF0dkJMUFNqQ2VxS2RlUHcyMmFl?=
 =?utf-8?B?WllWT0FnclVLNUdQeXJjNlBuRW93ZzI1U0owa3ZYVmpTeFRJbUE1MGh3VWx6?=
 =?utf-8?B?cEV3RndLU2J6S0VxWWhvZUZZOHh2TkV1QUgrUDRUNlN0OWl2eUc0RC82ZlUy?=
 =?utf-8?B?c29Nb0VUdGsvWXM1aU91TisweUwxUWJPWG9nV3NCSmpNcjA0dy9SV0EvcnFL?=
 =?utf-8?B?Tjdvek9rN1psMjJCa2lobFJZUS9uRnlCT0l5bDFDR3IrdVB1NHZmNFo2cytp?=
 =?utf-8?B?RTVXOXdCa3BPK240RUhZSDEwdWN5STRMWUpKRXlUSUQ5eXdJQVhMSEV3Ry9T?=
 =?utf-8?B?cUhnbndJQThnNHp4dVMvRmJSTzloRU04UW52Y0lSSXd2WVpscXVDT1pjb3du?=
 =?utf-8?B?dXNWNWN6dExhMzJjSlVXenZxK29KWG1sNVJ4Y1RFZFpZaEtqdlQ2VHlscDhu?=
 =?utf-8?B?ZnIxdmgyeEhLTXVYbkYra2lwNjRBRXhjcllvOGxKRjNVQ1BROHNGM2JzcVQv?=
 =?utf-8?B?eXlRaGdoS0RoZTVPVkd2M0xVeUQ1bWNCRWFZMTBHRzZVQ3NCY05ROUZ1VWFO?=
 =?utf-8?B?UXoxU3JsazhacmxQMjFqampRMSs4OENUMGFEQmVXais4UFAxczJyY0RIbDVy?=
 =?utf-8?B?b2FEYTBJdXhud1oxb3lLMDFJQU5Zd3Q4RGFrRmpqRG9LMDhiY203ZE9oS1N5?=
 =?utf-8?B?bjN4VTU3eTQwWkhDRVh5dHlzM3hwV2tKUlhpN052dFVRamo4QnNZc3NVbzUr?=
 =?utf-8?B?V2xFaHQweFI0eFc5RmR5bUdZMVFvR1hwNXhkaExPVEh3VS9BSmVkZmhDV2h0?=
 =?utf-8?B?RXpPYU42NS9aNE95TmpkTFpOR2ZjcUZVSi9oQVFaZWsxYWJ2N00zV2NRMzl0?=
 =?utf-8?B?V0dXd0w3UW10cTVMNnVaSTJqelR6MTBadFMrY2c4MldETHhNN3d3Z0dPcTEw?=
 =?utf-8?B?TnRCZTJLVFV2SHF1eGZ0RmptOUU5QkJlYU8xRFRDbUdvQit4WFRoZnBCSk9T?=
 =?utf-8?B?UStoWGh5YXV0SE1EbWFPbVM1aDZqMU9BamZ3MFhhTTRNWFhsRklRZWU2bk5X?=
 =?utf-8?Q?ahUb7RCvuUHIf3Z86F8/n9prw2/PGxpfNEJyKNx4tiJCK?=
X-MS-Exchange-AntiSpam-MessageData-1: uprTdMCbXUKaew==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d242fee-a1d3-462f-b726-08deca9d7937
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 05:18:02.8685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzGT9M3SlxAplg3FlKi0H7wNdZnRIcwYyOso3U8q/iqNZK8ogfbGuZkNWtLqW2d2z8jgqtVPsjAV2Gq9nUyv6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796

On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
> Currently the `Io` trait exposes a bunch of untyped IO accesses, but if t=
he
> `Io` region itself is typed, then it might be weird to have
>
>     let io: Mmio<u32> =3D /* ... */;
>     io.read8(1);
>
> while not unsound, it is surely strange. Thus, restrict the untyped metho=
ds
> and also the register macro to `Region` type only.
>
> Implement it by adding a generic type to `IoLoc` indicating allowed base
> types. This also paves the way to add typed register blocks in the future=
;
> for example, we could use this mechanism to block driver A's `register!()=
`
> generated macro from being used on driver B's MMIO. The same mechanism
> could be used for relative IO registers. These are future opportunities,
> and for now restrict everything to require `IoLoc<Region<SIZE>, _>`.
>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Link: https://lore.kernel.org/rust-for-linux/DHLB3RO3OSF5.2R7F27U99BKLN@n=
vidia.com/
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

<...>
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -113,6 +113,8 @@
>      io::IoLoc, //
>  };
> =20
> +use super::Region;
> +
>  /// Trait implemented by all registers.
>  pub trait Register: Sized {
>      /// Backing primitive type of the register.
> @@ -129,7 +131,7 @@ pub trait FixedRegister: Register {}
> =20
>  /// Allows `()` to be used as the `location` parameter of [`Io::write`](=
super::Io::write) when
>  /// passing a [`FixedRegister`] value.
> -impl<T> IoLoc<T> for ()
> +impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for ()
>  where
>      T: FixedRegister,
>  {
> @@ -143,7 +145,7 @@ fn offset(self) -> usize {
> =20
>  /// A [`FixedRegister`] carries its location in its type. Thus `FixedReg=
ister` values can be used
>  /// as an [`IoLoc`].
> -impl<T> IoLoc<T> for T
> +impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for T
>  where
>      T: FixedRegister,
>  {
> @@ -168,7 +170,7 @@ pub const fn new() -> Self {
>      }
>  }
> =20
> -impl<T> IoLoc<T> for FixedRegisterLoc<T>
> +impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for FixedRegisterLoc<T=
>
>  where
>      T: FixedRegister,
>  {
> @@ -239,7 +241,8 @@ const fn offset(self) -> usize {
>      }
>  }
> =20
> -impl<T, B> IoLoc<T> for RelativeRegisterLoc<T, B>
> +// FIXME: Make use of `Base` type parameter of `Region` directly.

`Region` does not have any `Base` type parameter, so I am not sure what
this refers to.

Is this to make relative registers tied to a specific register block
type? If so, it would help to expand this FIXME a bit as it might be
difficult to understand without context.
