Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151531355B;
	Fri, 14 Aug 2026 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715810; cv=fail; b=J/ueEReT6OFAQTINkkANOM83QE8w8UnKhxpJCvacvzZqz/ljD4WZjCAkJpeTaHp6gsq+OoceHz22C5k25zgzz1KieXUKrwmYue2y3tkvvomuUrFbWr8ERq2wo+qswjvHcH9FOnP1t124JIFAMRhm7UlE53ElXdYa4kH/St2Haq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715810; c=relaxed/simple;
	bh=5wjr2PAXouZiRDjhYAci5HFEzUOyVWXw1GPRyDL+r8I=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=bvdr1T4MmnPm1DjoFKs9NzIRs6aVzmxhDCSkUibzTo/hZl6Y+dM92ZrScg1UTARMXEyBmRslrvN6imipBtsApZGeAG06f0fS/z5l4r2YIQsn08HFfDtc4/FwcuAEEtfEN4u2dMTSjiSDmfoq7OqDeRjDMYerwqgPqdCEi/MDWPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d8LDDHda; arc=fail smtp.client-ip=40.93.194.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d8LDDHda"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbUtWMm3/nNit+aGEYMlxfx6AjgK23+0KAkUwUxLOm7M2i8Q6Xj5NwtG2ElLFUKBt49AcC+iGuqeAhXfz7QShOQLClmtLCnX6VYnyEFIvwQtU0Q8NbGSFpJHi4WwTuxtWDO92Jfr6d5GhixfhiiPeoCmrXOpQWcPlvxY5C1dmNu9jvmd6Den9hTBA7QITvZ+gUs7YfgNZDxaRdDOc+4BAgvNUUNMYBVI3cSmLa16AKxSN34uKpSPJ+pexnslzQjvYZ68O8O429kzPoLonKD0mJJ0TwtCVHbTU1F5ylrJN3ozqZG73uhZfD2WPHKxCq3kV116B9pzQVXEbQjTFUhBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxKYaHqbcCmzeeu25NksX1+F+99mNKrOsJrcaiNJ44E=;
 b=SdXhTSA6YnkptXWQhyTvIruU4CtmER7Y/mlcBioK85YUZ18hN8W5jj0g/eQklE/XCpEYd71/x1X1VDd9BlJJtarVSa99KYDAW/xPV4wADJrUk9W/PVMrwe3sdZirdHwU3vFCawD+e+A1cEWFmqZrmJAgZ20qroo6/YYjeMOjlFQqEgQ2L2U5P5sfQ46N7NZuyTbSK5FnYllc4hlNhCxKrzS+QWUA8Q/CLr3vITcSAkqN6TsLRt0ZHXU571aznj9gMIw5FSzWlO9Be1JwIgPv8jojK5Yza5zcop+wQUnFhNFQBEk+U8riSdZd+axXrgXaBsS90FMzoTWl7GTX1cGnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxKYaHqbcCmzeeu25NksX1+F+99mNKrOsJrcaiNJ44E=;
 b=d8LDDHda4dPnMajGRDuhgZsnP3kNdZl2bQtTJQCICXa3ncDEpIkcDIUBQHD4vunFxovRfwbTWiB0xl68GtT+4YdbAuhKsjMnEKkL+twZv7WEE1DFPjdEOoCva/umHnLKYYI7Y1+HRjSzdm/c0QMJqgiy3DZFSaXL2locaJ3iN7sUOqosNBycHyp09KJ0dqz+sPzVZjLC5GLmhiEV3TCRX8BGMCmnd0k9o2pmzbDLGf81Bu1xDablHvxa39b6IpT23xvwOXVOpmb5Sz3R69gxIt5lJL6I7ZWubPWf9D34HZLs26vAXdqzwiXUT39rIYvpiFTK/1m615IHeDJ2eqgslA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 13:56:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 13:56:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Aug 2026 22:56:36 +0900
Message-Id: <DKOPW1CN1QBT.1HI40RH52BKCY@nvidia.com>
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
Subject: Re: [PATCH v2 15/16] rust: io: register: remove `Register` trait
 and cleanup macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-15-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-15-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: TY6P286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a779f6-76ce-47d8-d054-08defa0bdda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QqCIpvmF9NOC5C3WE93isY7/BwEPTtFZjADTPfyG7eVR79g0npjWizNnp7CmF67d2PHdlS15puGYPAGylC3Wj5wh2JJwwbgd0MQ2mnP6BtYrIkj/iHcv1zCY0GRBmDRHS1uYOQGJTPq9i3DYj3ABoFAkuq+ZXDsx0V0hTEZxjFqkn4lk/gnV+cjIzsHBNWIlz7U4bKBZB5VOmpuaY9z/H+2VEnBXzgZt8JQukXsxO82awbJVRIqilD8JRJXjXbRVgRdkhYzE0Pl0LahkLfQ9lPYQ06KKVxd3B2nU95kGh04FQdM7ubuyhXC26xYmacH8Vklb68sofDKHK8gGHKhAc8PefnAW0PO6OpuylXJctw44noJ2o7iRT4oG0DyXMzvtB4XQy3YjaJ8sTh7PJy83+d9ACq4LMc8+ZRYepRpfuUrIOonBLsWedTcP5Ou8mfO+K4u8CAj0uLk1qHxLrbI3MaoDieeb/GbtH530aCnSxc0m9PJkYxFsgRXzYBWefJoGevOLE4Bfh0inMncgaY6xMN1sbAMIn43W7ftRpPpWSb/newM4LEhoglkRaxCgQd7/P5Ew3GKa+nY+xw26uFDZyq8b3oSNQWvGfdvQLslflDuKiZdYb07VYPVRNV4HG2C6rBzWB+ODlQQsxVcX0vAGGaNjgqOJyR1iAhdhxm8IdjQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1h5WHVOTTVQVFFvcEorVzh4cVVaS3BMYmhPNUJzZmh4RlRLYWtuWjMzclM0?=
 =?utf-8?B?c2cvU0U5NW1CNzA5OUtJSkxwVXJNWTJUTkxOa2lndmRaTy9sejZoa2RrWEhS?=
 =?utf-8?B?YWl2VjVoN0toWXV0ZnVydkV6U2NvajRmQmVwWTZLVEwwcXJwQ092NzdINDNr?=
 =?utf-8?B?V205UHQrOTNjWHdmTXo1RzBPOXhBUnEvZWhlNDltQWpaSCtvMlgrM3Q1Wlpk?=
 =?utf-8?B?cWxjekV4VlUxRERqbGd3dGhjUDNWdWYrd1BCV0poOVhLZ3BKd2pjaFdhUzZx?=
 =?utf-8?B?U085Y0dGMnZGS1RBR25iajlaNGkyTUp1czkyRUUzOGM4NzFlRnFtbXAyT2JB?=
 =?utf-8?B?RVhHYVpsSFFZSXowbmZ1dHYvNXd0cHFYMndsZjlnaEdjbnQ4LzhzNjRyUXFJ?=
 =?utf-8?B?WTJ4NWtaaXJwZi9zQ0VjVkJ4YWhaNkdTZWV1bVRtSmF0cWRMWEJUWEJEbmxU?=
 =?utf-8?B?azBqRFhyYlc5NWczYXBueENzQ2xnSW84V1VNYi91bGFCYm84WGRTaDBUa09W?=
 =?utf-8?B?OXY3blJ2NkJxQnk2dWpKSk1qZDdQc2s4R0w5clNhcTh6d0l6cmFUZ1A2c054?=
 =?utf-8?B?QVhXZ2lOb2pjMU85NCtLTVYvYWxDMFVxQ3NtZ3JVWXJkNDlZbzQra3cxNVJn?=
 =?utf-8?B?NVNHYVlGc2JwbHFjdG5sWE9sL0N0SzBrU0RwOG95RmVBSlhRb3hPVXBpTSs3?=
 =?utf-8?B?LzhqMFNKLy9UbE1SR2tYVkNKVGxyYVpRTW81UXlMS1lIa3ZtTnBwQ2d4UlNp?=
 =?utf-8?B?cG5qWG1WUk83czMzVUtLcklVYTJ5NjBEYnRDU1Y1YWU3OTZ2V2VtWjBYa0VE?=
 =?utf-8?B?WVY1cVJYMzl5dXRqVzY2b1pPUEF2TTVRT3ZVQUEyMk1KNkwrZVBQOGNTOHpt?=
 =?utf-8?B?MHJrQnJ1NVJvU204NEs2cmhPU29pWGhqMmFHUy82NVUyZkFLWGdjVkNZU1Rt?=
 =?utf-8?B?MFN5ZXRRRkkzRXc5UkFoQktQam9zd1AzUFpDc3FIN05yZERXaXdBNTQxM1A4?=
 =?utf-8?B?SjNRZWs0Q2d1UnJPMWJXY240WEd1c2pWbGhmRW93SEpydG1FQTQ5cjFYNlFD?=
 =?utf-8?B?ZHhwdWZ4TXlqOXdMWXZUZ3BmNkRva21uQUNYaGRoemExK1M5SHZ5QXRLU2FK?=
 =?utf-8?B?Wjh3SlNaSWszamxNRTBKMnZlNlJvSk5xdW5RQ3BlVHVjTFVZaVFvWC9vd2N0?=
 =?utf-8?B?RXpFenpNNUlnWTN0Y1NQM3ZNa2w1dFQwR1YybkdGZSt0QzdHREIxVm96RW5a?=
 =?utf-8?B?SWJ3a2I5eE04eVI0RnhpazBRNWF1ZjJmN2Q1V255MnV1ZEFQN0tWOXZ3aWxw?=
 =?utf-8?B?YkI4U2s5b0hPeE5MRkg1UDg1WWVsZytnVXBZMnV4MlpqWGhlQ3NKcXlGL3d3?=
 =?utf-8?B?a1dMV2FHVm51b0R2Zi9MK3FQbHJBZEJoelFKblgzTWhyS3ZsTHJLdzNKODJj?=
 =?utf-8?B?RFBVdVhEbkxQaFk4b1ozVkIrN0VjQnBtcTBhdnVSVVgxaXhiT1g3SzhJakNs?=
 =?utf-8?B?MkZIT21ieXo3bjBqV3Z6akpnRWR4ZHZ6N0RPN1JCamVyYWlEdHpCQS9lMU5P?=
 =?utf-8?B?RUpZV0I3VzhqcXhQMHgyRkZVWHF1OGdoRE1lNHV3NWwvSGFnUVlTSFJHZlcz?=
 =?utf-8?B?cDVibUlVREtGZHBGdzFVUVZQUGZSbXJZQ21XV1ErZGNhS2JhUHFJTGo1U3FT?=
 =?utf-8?B?UmI3OHlUSkIyS1k1cmY2MW96UGtEUU1KSXRxb0o1Q1JjZGd4N0hWeXZ5M2to?=
 =?utf-8?B?TkJVVnFLZ21ZaXJYc1pzak5UK0dCYjZ4aXM1ekp1MUtQR3IvQXZqeE5LRVJW?=
 =?utf-8?B?T0FYVHdvNkZjdjl2Q3FYZ0hHUGhQT2FUYmVpZW9EZXBTZDFFYkp2c0dWUmlN?=
 =?utf-8?B?ZUFCMmhIK2lVUndhbUJnZjRoSzBhUzFjcm1wTENyc1VzQlB6UlNXTkZiUEE2?=
 =?utf-8?B?c2FYMmMrakVwWlJ1ck1lUXVTQTNGdUNVR0ZnbkZCMFZaS2RFT3haK21WdnIv?=
 =?utf-8?B?T2RGam9ZbFpOd2p4QWNRT3ZmZHdtZ0RTSElwTEY5dHo0TlNyT2d3elJ5c3BY?=
 =?utf-8?B?NUZIZFJwdTdDSkVJKy9jWVAyWUFIRXFNdXFRcnJ6TjV2YnIrYUJuNlpjYWlK?=
 =?utf-8?B?VDNnd0xldktrbFZrdldFTVRDdW1TUGc2S2dTbHJXbG9qR2NGMnhXTE1jNVJF?=
 =?utf-8?B?WDBFd0pVaHNUajVDSzg5VmlOdElUYXM2SmVPOVdNU3VGdk5UUnRBK21mSkVM?=
 =?utf-8?B?ZWJuTWFJc3JmMlVMZ2N3eit4QWlHam5CNVo1c0ErM1Y2UjVBZHE2M1h1eGk2?=
 =?utf-8?B?THZFWi9iYW9wdDNWMjhMbFpTWjJxekd2cWppZ3p5ZWJ4SDBYUHRQVkVCc24w?=
 =?utf-8?Q?O9XGn9Z2Q3zruW/RkpoaxlXfQhAtn8+euSNgmFdq1aKJa?=
X-MS-Exchange-AntiSpam-MessageData-1: O8fPnf5Ux8Shcw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a779f6-76ce-47d8-d054-08defa0bdda2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:56:40.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOV+48RmtUOkVXuoIRfKE6UZ6GXYzcETg5HXWJp2orhAQwI7jXCK2H+VEHTe7xrE9AS1nYkelNt2pM1pDS+IDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258

On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
<...>
> @@ -601,11 +605,22 @@ macro_rules! register {
>          { $($fields:tt)* }
>          $($rest:tt)*
>      ) =3D> {
> -        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
> -        $crate::register!(@io_base $reg_base; $name
> -            @ $crate::register!(@offset $(@ $offset)? $(=3D> $alias $([$=
alias_idx])?)?)
> +        $crate::bitfield!(
> +            #[allow(non_camel_case_types)]
> +            $(#[$attr])* $vis struct $name($storage) { $($fields)* }
>          );
> -        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
> +
> +        impl $crate::io::register::FixedRegister for $name {
> +            type Base =3D $reg_base;
> +
> +            const OFFSET: usize =3D
> +                $crate::register!(@offset $(@ $offset)? $(=3D> $alias $(=
[$alias_idx])?)?);

Btw, are the bases properly checked when using aliases? It looks like we
are expecting the base type of the *current* register block instead of
the one of the alias, which if true could lead to inconsistencies.
