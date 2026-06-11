Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020102.outbound.protection.outlook.com [52.101.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2E4A2E24;
	Thu, 11 Jun 2026 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202895; cv=fail; b=O60XEZarufSg7P2UpCCI/lDck5TOivcq1eJH3ibjcczUYwdld+/oOcxKbsb1Y5hLQKUYKs3huQ8TJdLk0mEztFOapyCxffAlTHd5JL1AbUAo/fR27QXH+NRY8enirUnigccXQDvlS6yzFl1gnrQJePpC7cW3rVvi4YVvPvHuvc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202895; c=relaxed/simple;
	bh=m1AP2jI+ymqp5seL1IhHh+8GrQ1u+p0ylZLlJfLBC48=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=txpPckcISla+J3CChc0l2bNfpfINc+f9BsMSjHnFWBpG0pT6CUJYx+yZuxrm6Avd1twwqbiXp9vG7P8pZsYocCzJ4dazQq7bJ8Xt/ME9KQ/F9KGFjUt2pQW80Mlln2JevS0jMerdIK7wl0crmOCCUdt/Cr8HQXUUfidrH97TG6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=i/IFJPj8; arc=fail smtp.client-ip=52.101.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="i/IFJPj8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ci7LcpeILu9IRzwiwE4pXQcNfaI7WUT6Z87YSdcPv0JC6k08hRXtdtttEZqT4fc50HKTPLp7TcwMXB3jZyXouOahZBDPfgN/0DJllG9lEeOjjG00CIiJ+iHfmw8BIdbRO3QWBH7galOrFPuNDvywcUl/qrggvgX+dufkJWTsjhrE7jdOI6eotOwmOyych4v5V/mTZ8RQquI38NDLWeyGvLvCwE8i4UqnW13DnLcJyQj3YMsC+Ex7Q6LWUF+qWLMyXwRjBUbnhbq7ZNRfIfng8V9FYAVsbCymDpoolcdTjIeDhYQO+Xfc+LBAerYD4TXRNdxqVRYaTf9diazqA5L09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GjlRHIGhg8Li6VCmUCEVnJnHUzGIOi/zPAMiFDs8Hk=;
 b=WnA4TBNrA1WUXxGuEVKoqzaRxZ7o2QgIyFpNhx9wcKjbC+92268b0uZvAoVSuDXtb96UmL6QUHw+ksgNCmoxySJS1xNzY0capym0YQjQdI69Ahv3jtdeDyRawtQouVLtz8yC8K7pfUsQQHBkW8Ct2god2wk3+x5I9PkDwMswmdqST+39wnfCMXSSYv3Jz9RkTJgZXszpqFdLdL3IlYHTd4sR9urPY0Vvcgu/qfoysLi80E4DepH/ivSb0x5HBYNIPry9KR+zmTPwl+nmGorPVSWBDDZlgoqmnG53eYRr18AU+yA7A4iObTO7QNYe16pqespij+HRuRgZQrqNGe5Jow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GjlRHIGhg8Li6VCmUCEVnJnHUzGIOi/zPAMiFDs8Hk=;
 b=i/IFJPj8Ioh/Q+DBQc2zGHosFliA+WMDdD/wDmUFMmRi2Se5t56Cg3pd/dKwRTr8vAqTWvJbE4jTelnfR9QP6IHB9zqnoNJdq8FCG2lrGQEncfvTRIlXXmLbS1I9yQTTqxgYpa3A3ly/+Z3wwPZYF6kNb23e2TXDoUVoueDQ3jM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWXP265MB2248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:79::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 18:34:50 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 18:34:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 19:34:49 +0100
Message-Id: <DJ6FQ72JD6EC.3TU9TJVDGL3ZV@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <linux-pci@vger.kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 13/20] rust: io: add projection macro and methods
From: "Gary Guo" <gary@garyguo.net>
To: <sashiko-reviews@lists.linux.dev>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260611-io_projection-v4-13-1f7224b02dcb@garyguo.net>
 <20260611181418.1052D1F000E9@smtp.kernel.org>
In-Reply-To: <20260611181418.1052D1F000E9@smtp.kernel.org>
X-ClientProxiedBy: LO4P123CA0264.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::17) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWXP265MB2248:EE_
X-MS-Office365-Filtering-Correlation-Id: 52161c12-19d1-406e-5cf5-08dec7e81f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|3023799007|56012099006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ny5G4Ebetn5VDHvkMNqBKZ3YFAIj4Q71daPiVZf6Upgt0SK8Im+n8Zht2e+DOSolh/2AjCsFlARcxt2bJGWzU7ICuSFpFofFmkCRbyGFNRn98cMUai8qV4XOKvcoCpFGDM5e4dZYu3G3hU/QV7ZnNAn1Ac9XLCIIcO7oRkRYkqUEYqTPh6EG3mFVGOOwb9P6zcZp2sRJEyMyOGLQuY9GMZ6vr6YTq15Z7SPhpfsVYZQJuY15KItrgcufTeuol5JgkdOErWqdBRHDu0T3Owhos78hR4Ar9Kvyh27f+aT5psSqw8hNFsqFEPOLdZVWVGvRZHW8H57RXlJQXHOL1Yaejs2B1LmgqQV3QLbXsMk2zAD/lfj3DtjU9jt/J2wMi8jTTq22ndhvbzIBjTtIGwUBbdVBY8t/wntTC/cOGdfSzZIiBDK9O7+aX9CrTLGzpGijLf24XwwaLSaGstuZAeGKCxnSjO4E1xdtmlOgkoSkFJtv3ojzGpaEe+5zGgmw4oZJHClE+/TK7o7TNAl6rpFbS2Go0a4ZgNqYtRNjmYJMjs6r7vViryEImuAi6DwpXy/O1xiZEbR7Ujwes/nPAAFMxsq1nIXnTvI+OL2GfNkt3HMiJN6NXfMN4RrHQ5mGQyz4FfK5v9LOKIEu9Q3+JLiml28DaiuSqo/GeaO4Ed6wNC5QZkJp82Bh2w8xO7HKDcFM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(3023799007)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVoyaWQ2aXZ0aFlYbG1GbE9jdmJZYytDT1luanlvQ0hqM3I2bS9xYVA1UkxY?=
 =?utf-8?B?Ky9reU9pT3NOUVBTa0owTzJqelMvbHlJQ2p1SDBMQkJLUU1vejV1MzEyNGZw?=
 =?utf-8?B?Y1dxUVFHN1lPbjNCL2YvNUZCcEs2ZUZ5ZGpTVE4zWlR3bVp6TktZeHpXa3RG?=
 =?utf-8?B?V2F3QWpzYVhzWnBUWm91TVd6SVpzdGFEa0Z6MkVQbFpzVUEzYU9GZVR5WHlm?=
 =?utf-8?B?NENEWUJCa2ZZRlRSWDVrOEt3clNyK3lLKzF0U1dndW9uQjdQcUNXS3NEcEQx?=
 =?utf-8?B?RkpMUFh1ZUxhUXhUYzBhaHhKcHZoNDBqSUxjTndLVUw4NGQwRWQvMDQ1VUxw?=
 =?utf-8?B?ekJKM3pmTFdicnlycnduWmRURHpGY3ZVMUpOZ2NpR3lVN0ZDckVkeTVIR1Rv?=
 =?utf-8?B?NG5kUmlOK0VKSHk2TGtMaGdUeEFqWk9iUUhFRFNoNUpaR3poRERZanI1dUl5?=
 =?utf-8?B?L2szU1BVUkZyaFRGejJ4RTgzTFJNYnBFd21DVjNpSDJkd1hmSk5VSWJtZ2VM?=
 =?utf-8?B?YmZLMC9YSnEvc2Y3VmhqMDAvcVpUd3lqMTZMaFpqQXMvZ1pHRVVFRk9uaUNx?=
 =?utf-8?B?NU1xcU8zZVdyMU5ySE84Y29rMU1YTDVYMWE4ZzYxekRlRTdONCtQbllETnFM?=
 =?utf-8?B?WXlwQzEya3ZFVTBnMWh1WmxJVWplbGZuWGdOalpwcjEzQWExTURrWjhPN3V5?=
 =?utf-8?B?TUkzV2lpTWFZS2NBcWxRYkJvZWJDeVhVc3Bja3NFVVFwMndiOXFxbmVOTnJy?=
 =?utf-8?B?SzZqWlh2ZGNOL1dRUFB2M2V2bytWZVVNN1NJVG1sVWhZT0xQaXVya0FSbkg1?=
 =?utf-8?B?NDBhdSswYmlSZXNyQVp5WnI4ckNzRzYydi9YcUdFNDlhU01JTGNqRmlDdDhr?=
 =?utf-8?B?S0NXUTNCOFRjaldoU2ZsMWV6UTdiUk1OcjFSVnBvS0VZekYzREFvWlFBQTEy?=
 =?utf-8?B?VlhieDhwajZpQ0xUMk91dHFYU25EdFJHUnVjeHNlWXNjc2VGYTliV3NGMjE2?=
 =?utf-8?B?NmtDK3BXWTdsTlNCYkpuRUpaNjZqWUpWRzUrMU4rdkFxMnc0Vk9LL2F2MnFn?=
 =?utf-8?B?NFFJRjRKNytUQXhwNjZOc1Vwcm9pSkIzR1dMYzZOMVhyZ1h3V01CQUdMR1hs?=
 =?utf-8?B?ZHMrVCtpZllnZi9iTmg5WTd2aVhkVWpSdWhiMitBL29keDV0QW9LZTJyeVpS?=
 =?utf-8?B?SGJWaW5ZS0xjcWVQeXFpQlcrUnp4SGFLMnBROGJ2VDNqLzFCNjU5VDdycGpR?=
 =?utf-8?B?cWFnMithYkUvQ1FtTG15ZEEyYXRtRFZXRUtoVUc2T2JrWnNGS0ltanlrUXll?=
 =?utf-8?B?eFR5TlQreG1GYVRQZHNUanF3RlJWR095ZDZ2L080R2dleWJBSGRkdVFHRU40?=
 =?utf-8?B?aHZrcE4yUnpKckwyOVZpSC9QM20vRkRBUDhVbHdWd2QvQWxJaUp5MzdFcUJm?=
 =?utf-8?B?bEJVZnJVSmRyRE5GbDR1ODNPcWxXMWplU1M1M212UHFaUkF4ZVNOem0yaFFJ?=
 =?utf-8?B?cVcxcTcrNFhUNEdGMExvWjRrUzlPZmI1UFFuYm9NcjBkTG9ibU5sWUVoM0hw?=
 =?utf-8?B?SnQwcStBam9wRDR2Wk4yTjM2MHlEQkdoaFIzc3RTc2pZRFo5d3R5eVBEcnZv?=
 =?utf-8?B?RTVGelVPbThoZ2o3ZXVVdFZQd204b05SRXRIYlU4QitmMGJnczNjdDVFVVox?=
 =?utf-8?B?ZXRJTmcxMHU3U1BvK2NSSDM5UThWRUVvNm1hdWRDVmZ1MGxJOG5CdmcwSTJ1?=
 =?utf-8?B?T0VLTUFCRGZYbUhJN3NGcFpkNU9qMnRjckczcU5HaWJTRG1JcmxCellnU08y?=
 =?utf-8?B?ZktGK05zR29WbzcvYklVdjFBbVVyUWo4Mmk5eHNUb2VtV0YrUjdGN2JQaWJ4?=
 =?utf-8?B?T0F1Y0NRcEhkbVlWTFUvaDN1WHFUeHNMaHlVdnFTOW10WnhDeFVUYkVKQ09U?=
 =?utf-8?B?NDlzQS9waEx3eGkyTzFldXFSRW5RZkJLUkRhUEtFMEsvWVh3cXlKTDM0aFZh?=
 =?utf-8?B?L0Z0VDEyelRNV0p4aFVZZWVPLzg3VWlWTEdGblVKTFV5RWdsd2dvZ05pQ25R?=
 =?utf-8?B?SnFMZEczZnpRblJWVkx2c3hvMGxYSjVKaUpDeHNQbEt2R2JYUWNBbUpOd0dR?=
 =?utf-8?B?M0o5UmV0MzRpcTJHZkZVMERoUGxXSDVNSEM1bmdEUmx5dDdmQ0o4ak1mWjFn?=
 =?utf-8?B?dm5SbUl5eDJ0Y2dVU3FlemxpMGNGM28xZTU5cW92clRqSUJlMlpYWTJ0bzlN?=
 =?utf-8?B?ODFCeU1uRmhJd0pKZE1SUm1yWWYyb1BVMFRkOW84NkVYRmZZYnEzcFVCd240?=
 =?utf-8?B?VXI1eEVPRzJzZ2o5d0Z4QmM3c2JkbkdxamQvNHFqeXYvWGFWQlpOdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 52161c12-19d1-406e-5cf5-08dec7e81f04
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:34:50.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEt0avZ/PINXrypoNV3ZkuzzFDLSawErjs+xHOB73RJFwBUWMTIRKttYYToUljg4igwWY9Rjjs+vxwn4TAA49w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2248

(Cc list)

On Thu Jun 11, 2026 at 7:14 PM BST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Deriving `FromBytes` on `Region<const SIZE: usize>` allows safe =
code to bypass the struct's documented `SIZE` invariant.
> - [Low] Removal of trailing `//` on the vertical import block closing bra=
ce violates kernel Rust formatting rules.
> --
>
> commit 0616e76ffd1d8525b38835ead9f29afeae45c2ed
> Author: Gary Guo <gary@garyguo.net>
> Subject: Add an io_project!() macro allows projection from Io to a subvie=
w
>
> This commit introduces an io_project!() macro that allows projection from=
 Io
> to a subview using compile-time checks. It also adds a try_cast() functio=
n
> to perform size and alignment checks at runtime when type-casting is need=
ed.
>
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index 470ee2ed9849..c7a9952af995 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -44,12 +44,12 @@
>>  /// This type can be used when an I/O region without known type informa=
tion has a compile-time known
>>  /// minimum size (and a runtime known actual size).
>>  ///
>> -/// This must be 4-byte aligned.
>> -///
>>  /// # Invariants
>>  ///
>> -/// Size of the region is at least as large as the `SIZE` generic param=
eter.
>> +/// - Size of the region is at least as large as the `SIZE` generic par=
ameter.
>> +/// - Size of the region is multiple of 4.
>>  #[repr(C, align(4))]
>> +#[derive(FromBytes)]
>>  pub struct Region<const SIZE: usize =3D 0> {
>>      inner: [u8],
>>  }
>
> [Severity: High]
> Does deriving FromBytes on Region allow safe code to bypass the documente=
d
> SIZE invariant?
>
> By implementing zerocopy::FromBytes, safe code could use ref_from() to ca=
st
> any 4-byte aligned byte slice into a &Region. Since zerocopy only checks
> that the slice length matches the dynamically computed layout size, which
> for inner: [u8] is just the length of the slice, it appears safe code cou=
ld
> cast a 4-byte slice into a &Region<1024>.
>
> Could this lead to out-of-bounds reads or writes if unsafe code
> subsequently relies on the SIZE parameter for bounds checking?

It looks like the model is using background knowledge on v0.7 of zerocopy.
ref_from in v0.7 has `Self: Sized` bound, so it doesn't apply to `Region` w=
hich
is guaranteed DST.

This is similar for v0.8, ref_from_* methods would require `KnownLayout` wh=
ich
is not true for `Region`. So everything is sound here.

Technically, we *could* derive `KnownLayout` for `Region` by doing this:

    pub struct Region<const SIZE: usize =3D 0> {
        fixed: [u8; SIZE],
        additional: [u8],
    }

but this means that the size computation actually needs to perform an addit=
ional
arithmetic operation rather than just the metadata. This is also the reason=
 why
I didn't change the `inner` to be `[u32]` but rather make it an invariant t=
o
guarantee size alignment, because it would otherwise require a shift to get=
 the
size.

Best,
Gary
