Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8BC3AB496;
	Mon, 10 Aug 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354165; cv=fail; b=PNuZtgiO0oFiRI+aIVEK6EGwnsohzg2IVwI0NxEiYXjKpe5jX5/FC0anJAP2fHWmNvxTsVJB6ztBxQP2nFr9VDEcV3kdxfH2jc2YYPqKF7CBTvj2/VYjIjrQBOaCvPhjk3dhMBV6ZRUxyNZ0m5+e4PkCeI45guk6De9yIpUidvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354165; c=relaxed/simple;
	bh=of8u1wqraS+93WbZ8V5lbPLyUZwg5YG4DjLg6liBFGM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=agH7iOEd2h3t/vT9eYw73JsckDDOn4DGss8u6iJMdly1vaDyFOfreuW6YQzccmQgGo+avNHhSrn5d0OByjGMbfZwS1p4XwiSQryGqbunTIRfnwuIs+k1D6gl5yMWEui9guxcmSV2WVMMB58kOggG1mPuDRyH88o+I4/xLSDOI8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W9xu9+AT; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W9xu9+AT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAJJgqfMW/mMB1muq/XscM1+4wJQM8xNAMhd1cCLjGa55IiaN5PAJusLNJdEEchhnwlSDMB2DQTV7v1b/en27tBPyY2Bx2r1NU8o/2ejzZAYeZXw04p/5JOFAOAkjfFCNRkAryAh4eLvwGyq5d57wrRcBh5KU+S29DSoZbR8qo/Omm3cui6bA8aA+mlJjEK2eARWMj5BdiEtFsnRyE3ypAyes0CvppvP0qdmUnYMurN1oxt3u/3jh09OoACOjGVTg7feHT7FBojzHzu78fr+09ytK5h6s3x0YR6e4WIshO6fGUJ4cVyquwrE7o4s03ITdglfDNI5SjNBDmyROWjDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCp5kxtlIaeaApeHLeI0eQZoJcar/k7C2+lIfAUStvc=;
 b=m3Y5JbGBJsmWBtPDIjBqcoQFc2j9mvfYdbEkNj2JFFw9tQtZzXnuQHKwyosnznHYTDzqGqVXldfMZe1oN7IGrW3K9tLxzTt0pfRaqPIErtX5XtdgJIKF6jkbbREb+bQZYYpZq7L0/8xfbuZQrX+RBrGQg/Qq3JosmStsYebf6TbD7BzM7qcoq8p50TMq/tqjhlScRwkBDfJU3p6kBwJsUgdTUVzYqUw9gaPBmKs//MajQLDVv28g/Y+T5mr4oGndfqYjuG83L1uD++/YPdBlawcmHNHQAVxiPkTGDwuv8q8y/5uuJa0PqfDKa/DFvTI8p8yv+i+rQI0HAWL0UFCHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCp5kxtlIaeaApeHLeI0eQZoJcar/k7C2+lIfAUStvc=;
 b=W9xu9+ATuTMCzNyrfQwEG0SyrJToknTFTVx1jR1dsUOg5JDjeQFYImBpAHzezgRngq1csj8iny8ZrJu5JnJ13op0A9MhJWJXnddtfGODnl7nHVkCDUqT9O/AMq+YaGyY2q8DvS1QBkucNB7hzuFz+v2V9hF70uWe4XFlI2L4ejRzOlP2OvY7BYCvczfryVtchEH1MZTv03b5pcmF75opnEsGnb3Ccvwgb0FFlyPwmaD9wgNe4q9kZOlD9ERF7LyO1jlBx8xr73cvJWY2Uk7GdLFlGPgPMTuNFkjLesMsHnXxv1GHJyg70BaNgBaFyc7AKB8Wvyb254WsxqcnQGVHMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:29:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 09:29:18 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 18:29:14 +0900
Message-Id: <DKL5P5CJC170.3EFWNHBMTTIPS@nvidia.com>
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
Subject: Re: [PATCH v2 01/16] rust: io: add static `cast()` method for views
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-1-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-1-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: TYCP301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: fe536854-40be-4119-c63b-08def6c1d98d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|366016|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZP2pD5F74OO40QGjEFPPRrRyP9JOn+bCSdioqUXWv2eOkPMyhl4DkjZ3aBimmECx/TmG3d9blEzb2T8H5l2ENaht7fUkFNgDf5ndP4seWc53wTNExoIxu+nuRPKmdvxyBjoq2mmlNCRTCcPLrwEQSlGzzaNAoRmt+bIM/STGbZAbUmnSMRzUZ1HC++HZ1UU4bSkDEg4c7OGMP0PPZQGI2IVEO/RE+ZW+iXDDreWdVUdaEPvqEa2v9ifwcKAxz0L5Qqv4hpBAoeVDKWe+D9G8rLLFf7nk/Mt5mgYCQ/HFUSZvnfNosnqCJvjmuZubO+zT6Ad5G0bxa6KRLNPTkXqG/qd4fq1M+4EODx2s0E8JzxVfPg17MzX5FaiqdBTuVOB+6x+Xt1dY+FerysRjK2+2/9mhebiBxXijYvLY1MhMUFbB8sxrE9Ax/CdbXcRg9/5nCsx4zoYvm4x8naa1Pw7NhL3SnJAcETmY1inVYb3iXBDmTBJlNyzZHRz8GOkKJI9J1BAKlN1n23mgv/NqoLoaMDxYG0/TYhDGRQnx/l63B/dLeUaFvKo+ZBDn2ifflA/515ONvQr1RnOjYbylInVN+dGYGf/ewlAVm3Gx6KMc3jtTIIayaXS+jQvTrv893hMR1JavKUvGdRe+6PV71oT8z1pZwhKYF08vBNUMlzdA5ao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2hTamo1Y01relcyMGR0dUxDRzFVQ0U3NEV3U0JvRUQ2SkloMENkQXcwcC82?=
 =?utf-8?B?NktTT3o0a2JrUC9sN3ErR2RVMW9LQ2N3cVAvb0lRZlpDYU5ocURQZnkvM3lp?=
 =?utf-8?B?c29nNVp1QU4vZE1OTXFDVlNrRWhjQVNPa0dFenFnMG5lL2luYnlmeW9aKzcv?=
 =?utf-8?B?UkdsdmdHdTVTK3lhU3N4TlV0U2FXQ2w4MVNrSEhlb2p3alQ3L1VkV09aQm1Y?=
 =?utf-8?B?bmZlVFRMYnB5bFdyNHNxYWhVZmpxRk1xM1NQa0xPeVhIQUpXYjVpUk9FUDhw?=
 =?utf-8?B?bUF1c3kxZ0Z3eUMvS2VUV2hXTmVlWWFaTE5FeTg5cFZBcng1M2FrSC9EKzJS?=
 =?utf-8?B?dThrRXgvcWMybWE0VUJIRUU4M1RFTHBjR2MwRC82a2cyK244SXl5Nk5SUS9M?=
 =?utf-8?B?emR4eFk5Y1VUeUFzWUhvdGpSZXpGd2ZCUVF2RUpjN0NXTms1SUpPTFFQNGkw?=
 =?utf-8?B?RVcrdEp0bVNORzczVU8wd3dmemMvS2hnOFhtUXVQclQ0a1BsZnNCUHZqRE96?=
 =?utf-8?B?WFBPbzFzdm5ZSnRMVi9ERzJSd0ZaWVBWbHI1endYOGp4emVIbEJkYklWRmUr?=
 =?utf-8?B?K003UFVPSHZhVmIzaEJ4S2t0bVpDQTFiMStOUTZrT2NNditRODlxVHR5MDl4?=
 =?utf-8?B?Smlxb0s0OGdoaFhIUDQxcXMwL0NxY21FTlU5NFY1V0x4SDJmd0tLWGRMUkxw?=
 =?utf-8?B?aC9vK2ptdzZCVG1JY1dYalZYejEyVXVTR3h2UXVTVHg1czh5OWtSSDVTMys3?=
 =?utf-8?B?Q3QybHlPc0JqWktUMDNUMWJVNS9MSm1razR4M2phUlRaaDcyc3V4T3NDV0lh?=
 =?utf-8?B?Um5rSG1vSFFhYXJ2UnlZZnBMb3hVcHRscVRXOUdUbzFJYnBkYWI1RGwwcEU1?=
 =?utf-8?B?OHVhOHkrWGpSRi9UQkxnaTFOZ1IrTjJLTUExdkl1QUpDVkwyRTdtQlZISFpN?=
 =?utf-8?B?Y25CcUoxWWJLOVpab1J5TVBRTTNFNkprNUsxWXk0bW1rSm4wQThaMHFZRHdO?=
 =?utf-8?B?V2JXQjF0WDRIeTRPbTBHYXF5YzVlQ0lMMkZWS0VQNW5DcVZ1WEova3FWRko0?=
 =?utf-8?B?aDlHQ0x3RUtmNFR5a28xWmlzMnE2dk1keTN2Z3ZmL0dBUVM1UWgxaEJHcEFD?=
 =?utf-8?B?YWpGUDNKaU81K0tnS2FGa01mMzAwbENjWTlMU0tLZWNOT1ZHSlNuZUw0YWdE?=
 =?utf-8?B?TjBQaFBhc0FWd3VPQVY2MHV2Z1p3bGEwcEs1SkNwbkcyc29JRTBZNEdReVpN?=
 =?utf-8?B?eW5QcnMyR0ZzdkpLU3FSTzdoQTdNeEtCK2JTOFpZaHptc1Z1S1pjanlQTS92?=
 =?utf-8?B?T2ZEZ0dFVjlSQk43QTU5UVBiSTY4SkxHTXdhZ0kvcVlKMFN2RUhBV00yZzgx?=
 =?utf-8?B?R1Z4Q3lJZkVOQWdFTVIrNkNSd1Y4dEFvOUhWZE83TFFGYldtMWplajJzSFAz?=
 =?utf-8?B?MTVMeEhwaXFLZ1Z6NjlrSzR5OTdBeVZiRTUxbzFLT0ZZeHNKd3FINHJReDNQ?=
 =?utf-8?B?WTRYdFNmaGRVTG95d1lQSGtyT3FvcWF6WG8zZDlURC9RSzdaeWpuOXJwOXcw?=
 =?utf-8?B?bWRBNmRTQ09yWkZ2bmsxUXFsenIrOWpJdnlFUldIQU5tdUpNRGx6WGF1K1VP?=
 =?utf-8?B?TUlmcEsyb1BkWVRjcm9FV2NuZFRYUmdwdCs2QkFWR1BGcGhoNFQ2bjhSWCt2?=
 =?utf-8?B?Z3ZtL0cyQ3J5WmNQNERkbDRFeEZ6ZWRIR3pjRHk2bjlLaVllNDcrYTlLZXpX?=
 =?utf-8?B?cFM0WmVTWFg0b3NKREdyZ1VLR3BjSU9iVVdOYlkvU09xZTJwa3Y2Qm02akk0?=
 =?utf-8?B?Z3ZLbTFpejRkaTBFUmRUMlNERkJoMkJ1QW1PL1l4YU9WY1kxY09LNmFtT2lT?=
 =?utf-8?B?U0gyREpkVGRXcVEvdm5OYWFKcERQUGluMDNOaGk2V3l1NTc2bFBhSUtOM24v?=
 =?utf-8?B?TDl2cFVtSkl5UHk5Yk9hUkhydUxjRW5jY2t3Nng4endTbDRLR3VrMm12SEF5?=
 =?utf-8?B?NnRjOXlTM0c5R05yUWE5S1psOTZqbWhpdzJMT20wS3FhQnNkbTc2bXRxMUp0?=
 =?utf-8?B?Y0M4dHFPd0RBcCt3OXp3VHRDaGVEelB0eUdsa1pJcG1SdXVUeHgwUjVHdjNn?=
 =?utf-8?B?UE1wQkg4MGpWVUI4ditqSU0rU0Z6bzFqbFBUc2F2OXI2SVk4RlVrYWV3eUpr?=
 =?utf-8?B?dnJBUGlBVHp3dzhTZENHSzhCbU9tZEF2cnllSTNRVmIrTHQ0K251Qm1BS1Mz?=
 =?utf-8?B?Y252WE1NYkFVbG1yYmlIODRKNlVqOFRCdzZ3a3plL3NERmFCYzJ2TW1EM2lK?=
 =?utf-8?B?dlRGOXpjNTlFWVArNHVoY2lVcmNRMjNlVmUzZ0R5WVRkKzhnUDN4Zk9hL0tV?=
 =?utf-8?Q?AHdahAy3+UYdVcvj1gHKairEZiZIz81QWeIYTzo9/uaJC?=
X-MS-Exchange-AntiSpam-MessageData-1: JpDJ4bOhF6mJng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe536854-40be-4119-c63b-08def6c1d98d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:29:18.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVTOz8TKEHzd7rBMsZcRLIbLxctyYD+vRLQM4Oqpmo9qMPpEuDiCBN/x4mBKQeHxnPUk4EZSmLeR1K644PeHrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
> Add a compile-time checked variant of `try_cast()` using the minimum size
> and alignment information.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index a38c20ba3d23..adfc555de7d0 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -436,6 +436,45 @@ fn is_empty<T>(self) -> bool
>          self.len() =3D=3D 0
>      }
> =20
> +    /// Convert into a different typed I/O view.
> +    ///
> +    /// The target type must be known (statically) to be of the same or =
smaller size to current
> +    /// type, and the current view is properly aligned for the target ty=
pe.

grammar nit: s/is/must be.

> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::io::{
> +    ///     io_project,
> +    ///     Mmio,
> +    ///     Io,
> +    ///     Region,
> +    /// };
> +    /// #[derive(FromBytes, IntoBytes)]
> +    /// #[repr(C)]
> +    /// struct MyStruct { field: u32, }
> +    ///
> +    /// # fn test(mmio: &Mmio<'_, Region<0x1000>>) {
> +    /// // let mmio: Mmio<'_, Region>;

Should this be `Region<0x1000>`? Because as written the `cast` right
below wouldn't build since `Region::MIN_SIZE =3D=3D 0`.

Also, looking at Sashiko's comment about `KnownSize` we should maybe
bite the bullet and make it unsafe? There was some talk about it [1] but
the reason why we kept it safe back then doesn't seem to protect us
here.

[1] https://lore.kernel.org/rust-for-linux/DGSDGDIVUHO0.P594H9B4LLO5@kernel=
.org/
