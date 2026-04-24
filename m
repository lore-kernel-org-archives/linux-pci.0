Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020114.outbound.protection.outlook.com [52.101.196.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161C31AF31;
	Fri, 24 Apr 2026 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047417; cv=fail; b=GTl2hQ7WzlfrPp5XzT9cXU7oRi3ualxIAmgTJ8z+nNK9vNoe/fBwyJNgh86LDKyQKXnfUAXNzTgPXXZaodhVQibADn6g+SgPm/3xZfc4XVNNlzVwCrZHmfH13oAR/F/QGeq7AEn0Onw3I63Vbo+0rgDwjUKre16Gphe5SgBn1YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047417; c=relaxed/simple;
	bh=hukZ6jfrBbMsxCq/TN7iTP1PkrKrfUhpIXUAvmyQFlk=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=hG7iIcauQ8QDaqOMmUZYCkuf+0yT66q05ll98/m1kYP0GdYzFBYAY37WOmCDQArsPv2SbrDPSNuuk7DxXuEwlf9UAlXk95A6KjByqxDL7Pazq1NPf8z2b50u5wH15YvWEoEMtUFZJ2o5Cj8n/g+go2wkSaSGslJdLNWXwGy3b14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xfFjDDOc; arc=fail smtp.client-ip=52.101.196.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xfFjDDOc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt1hjvTNd6cDuCIR5+bfqKd1/svMFYaGb1ehsQAPtjXJUJqB+juAjGC0JHGhSxJz1j9Gwfjv4hjrVRlbUYiyoVyVjo6W7Vw3dggZv0FsGC7lrUZCSIsmQLXsq77E5vuH/xNzHGC6SixrHmUcySvjGxsaUOvT7SeOUnrNjT/B2nPDrq+x6a/1Em4vOJv2u/PbzsTNkGErPTCZmhrRetZFw16P+mEJhNlts19QjIFCMIe7V0N8JyYcUA1xga8YbLCHnlPbULqAcry8aa/9gI2RHOFeOFOjH0bmLwcLyRKbPnrLQ//5kWQbeeR1P0kPNvt6TebsqgAqhVa/y97TcjepRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM4v9BntqFLX1Gr+TUPCX6kTY97pBakAQdryUDM733o=;
 b=W/nPSrd3I2mUNMBHU4ms+QtxNHxY63rO0pGaldkv+cJ0giMfNm40llhxyAa44qzWsjhwHdbXz6Ss/ddZtOBvZ4NYZ0oKa2zidqPUOgp/ysimpgQLE+S2Xyb6nPhZw5e07XYf0hgndWUhAkQMUzOS+sYUEnn4C3SvsckUa9VGuMaNoho/+sDPED0nGWZhjslZ+VNNxyWEUXmgURhmGLP+H9ja3mWQghr3PqdoIrgriBDMmNAPVtQvCgbJkm8SYCFqWhDf1X2uur3aGpCPEbQbsSLX0vertx5IfTk+FHApr0gcGref5BSj/Bjf2MBWJvNv/GstHhg/Lun5u4o7MW8viw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM4v9BntqFLX1Gr+TUPCX6kTY97pBakAQdryUDM733o=;
 b=xfFjDDOcFOZI8tcDgnamNUmVu8b5zcfVtq8wJzOdcLcMSnz0aNZdpfPTtrXyS4X37JlmJqBM1OddjyLl3WwwSk6ICyawwb593br8Kx7IrpWrhMSGxQNdV/e/bmJP5sniahM8xpBzvH2759k4Beytjt/zZqSKf1QHtLzlbxLtXv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB1920.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 16:16:52 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 16:16:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 17:16:50 +0100
Message-Id: <DI1IQE7MDV4O.5B2DVIXMX2OT@garyguo.net>
Subject: Re: [PATCH v2 1/5] rust: add warn_on_err macro
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Boqun Feng" <boqun@kernel.org>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-1-2fe54963af8b@nvidia.com>
 <DI0I3TH8B8ZZ.2118S8MDUHG@garyguo.net>
 <DI1GL1FIGHO1.12VSIIQQN365T@nvidia.com>
In-Reply-To: <DI1GL1FIGHO1.12VSIIQQN365T@nvidia.com>
X-ClientProxiedBy: LNXP265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::29) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB1920:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7f7b5e-a9ce-4fcb-900f-08dea21ce476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C6lY+th/Po4eOV8NkK5WaMIRp56EE+mGTUaEuY2oV3JadyN5i/8nTzuJrY6K5Kg5eJ6aWQyDM2/phLKL5eSm1ep42KnmxgyOGrhesqsNpdJmt5f9yr/hQInCLzeZMUBCoMniE8B54+q8a/93q1MpM3csoSZYJDLMKb1gOJLFygMC58w1jc4ev5XrSSRLRK5p0a9ZfjKa4b8rcc6wmGv4EdfBGW6IRqcGpByWHwsojSi5EYi9p1PXgf/Vzj19BnIxK9iCmr7wUl1aJy4ZnnqAWRLYqSf6KdZHkiWojX7MJChy1MKUVl/udnrpsQtMJwnVJNpzJGH5MnqRVEY7isph1WIH3Qk1vS9jlzzbYpEwB5V7jbW5C4XY9u7SbvDRLWWtGAj0eR/+bKk8iBmqK04IEzJPT2zEdD7XVhufcpK6AAij3tynQodFeZDrpzfoaXzcoBe6r7SgzBGzHJtK7K7mXzbD17XgbR2EeE5GOFyVF/ynV7d1dASyANimsWol3dSUirZ+qb4borVHkj5jjfh+zvp7TFxnh9XLI9QeqOcMuin7gK+bFnqzZ9oj6ECcbLltF0eMPz/PPb4rS0zRl1/HJ1oBB0NQGerYQHbIIT/rn3wjSrnRO/gKXYTXWm4/2FOd+RLgNBUnXU0tWBSblQDY2WLdke9xskAZkSm145V7XyJFz7XHx5tBhR/GZwRt7i1x/hw9lAIAe5xPdWaPec7YhsceGg8ogLJO4g1rt2iixqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWt6Mm1sNitub0g1ZTlwRWtmZ0l0WW8ySlRWa0pwRGF3SHNFbVp2MjBjR1Fv?=
 =?utf-8?B?WWp5czU3MVJudXZWSDdYTi9YTDY1RTVZNW5aOEw1QjdXU1FpbGZFaTBoNGl2?=
 =?utf-8?B?bGNZSXBIWjhGU0dBdkhEdDBnSmlFc05RZ1dDR0J4TGtWQ1BUajFDRnEyeWs3?=
 =?utf-8?B?cnNZNWhjclV3Zi81MXRsbUN6eHZTV2RETmJmZTJzb01YdFZDYUdDanpNMVk0?=
 =?utf-8?B?dUErRUI2eWxUaWxrazRZLzJMUUYycTRzTTdRamhNZXNvR3hpK2ZZSGJHM1Uz?=
 =?utf-8?B?Q1VBcENYejloZVlvTjdEaW1aTGpxZHQ0dXdGUCtFVk9vZmwwTlJwQmxlRlFX?=
 =?utf-8?B?cDAwdDNEZzY1R3VVdFpNUFVhSHpqd05WZlNZRmIrME5PMzN4V01BWGdDeENa?=
 =?utf-8?B?dVVHbDA0cXBOUGNMN29CZGVNQW5XRndIZ2Z0cWEwZFBOLzJzZjV4ZVlhbEs4?=
 =?utf-8?B?SXZhOUFhR1poa2lUVTI4SGg1OVFtWTcvK2hjV21odnByYnVtRXlRMnYrTE9p?=
 =?utf-8?B?aGNrWjJmU1QvRTNWSm5lNHhPUHVYNCtlQ3U2UHByeWMxdXZjVWJGRTRzbTNj?=
 =?utf-8?B?TmpSR3kwa2RUcUFSd29SMllWekZoSHlwRURzM2d3ZzZSRGtsRDVEd3EvcTB2?=
 =?utf-8?B?SkV2NmpoZzA4eFgyUnMvempFaG5TY0FIMEpxL25KZG5LMlBZN2JtWWp1U1Zn?=
 =?utf-8?B?MkxwaEZLQWc4Z0NFK2F3bitNQ0JCTEJvRG54R0dDNXlJRG56cW9oQ2UwZENt?=
 =?utf-8?B?U0I3b0RDVmhnRjAwS3hwS0c2Tlpnc2lubHNBcHRvVGErSzRMS2R2aHBvMko0?=
 =?utf-8?B?bVlhRzRVTXFlVVJiS0VFdTQ0UERQa1k1ZFNuT3JvbWM4cmQzODkxMElYamdY?=
 =?utf-8?B?cGlJaVc5NDZobGZMNGRpNkZTM1JBYWsxZ0JPbUVObWZpMFNmK09iUTllb0lt?=
 =?utf-8?B?bzdJbkhJc0F2aGtQbFFBaWl6aXA0R3F0Um9IVTNrRlJHaTVGQzlrUGxzbHF1?=
 =?utf-8?B?TVFZY1ppZjd5UGJuSk95Uk1RYjUvWkY4UWIvUVZXeU9QWFVGekc2YjlwWFAx?=
 =?utf-8?B?N2xIbi9VSnZxZ1FoTUxGc0ErdDlsQ0xuaWFxNHVpM1dITUdWalVWczJzM2U4?=
 =?utf-8?B?YkFNYzMxSFN0eExhTEM1T2x1TFVzbVNsVVQ3VVpKU08zcHpMWW9ONm5NaTU1?=
 =?utf-8?B?b01GSnoraTVVUExkSXpQTzlORXR0OWIvOGN3dmF2aG1XbEs5Q0F1aDNNNmlw?=
 =?utf-8?B?OGNhOUNYVDlEM3ZhTnZpNUJlSUdYbDFyZ1ArbHlWYjdWTWcxTlVYSGhrS3lP?=
 =?utf-8?B?cU84UllBZ25LVzJ3bnhmQkhGMjZXa2VRV3c0UG1OVW5sbjF2ZnBvam5lL053?=
 =?utf-8?B?S0FKWFIzOGcvQS9ZT2RObUxIR0RCdlVWbVowMDlPYjZEK2NDU1lUM2NVNVNT?=
 =?utf-8?B?NFdpN2NlNkVkN040U3Q5aVFiQ2tiRTQwdzBKeXFIaHM4dlNLcGlYK3pPa1Y5?=
 =?utf-8?B?dmhBTTYrN0VaYUhiOEtDbkc5WXVpQnBybHY5cXRWR1RJZ2Y1Zm5vOHQ5cVhv?=
 =?utf-8?B?dW9mMitld2NicUwwSFg2V3EzSldrMnVCU0F4WWRZaG1nY05IUlJKZFhwQlRI?=
 =?utf-8?B?RUFmNzR5c3gyKy9SUnFsR0tYcndtRTJBQnBWSWt6ZEVaTUxVOEdWVW0yK3lC?=
 =?utf-8?B?UkQxS2VwN3BTb2VWZWpQUUJuWkFueVE3K011WHNhWkJlZEF5UGs4QWVWeW9z?=
 =?utf-8?B?MVhhWTVaZGpyV3VHcFcxVHA5bDdsdlFFS3gyMm5CWFE4RDZaTzdhWXNsdHJ3?=
 =?utf-8?B?MS9NZTYydkxkR2JiSVVmdUJIZHh6LzhGM3pHZzZuNVpZM0NkRXRXSUF2MTlU?=
 =?utf-8?B?dml5eDlxUmcvWTZCTkM3eU1SSGs4NWJ5TXUwQkkzYXR6SE1EQUhhUmhCZFNx?=
 =?utf-8?B?Q3VQL0s5bzRXVXRGak9UVDZZK0ZZOTBEendnMnkrc2xlQjRLbHhGODZDQnVt?=
 =?utf-8?B?eVoyMU1pZUNldVpJRGVGRUtnbkcyR2szZDNjTWo3OWlDOC80Z005RnRXdzVI?=
 =?utf-8?B?a2ppbkZRSmNYaFRYams4TnR0Tk0wSERmdS9sVzhXazYzOVhvSkkyQVdQdVg4?=
 =?utf-8?B?bzh0ZmV3KzlqWVhVNTRTTlVsM0RKcVdCR1NpVHBDbXpYMFBRRFQrcFBLRUdv?=
 =?utf-8?B?RjUyUFA3dVBOZFJlQkxJOEpNR3I1QXl6WDk5UXd0QXhQWVlkNFRER3JERWFv?=
 =?utf-8?B?anVWRDBtRjFxSGQ2YUFkejdWSmR0T05IeEx0VzdJaHpyK3NOYnppQVBVSkdH?=
 =?utf-8?B?QzA0SjluaHlLN0pDVFEwVjVVUDBDTWdLUk1wSTBkVXlzaU03ZEo4UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7f7b5e-a9ce-4fcb-900f-08dea21ce476
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 16:16:51.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANalSclYMio7W4gdWZ0A7gvwMvb2tLhBEqE13fZ84uVqiVxqcCbiA9H0j9UhryEk4sy0lrN/ddu/7+lm0GdG5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1920

On Fri Apr 24, 2026 at 3:35 PM BST, Alexandre Courbot wrote:
> On Thu Apr 23, 2026 at 8:34 PM JST, Gary Guo wrote:
>> On Tue Apr 21, 2026 at 7:16 AM BST, Alexandre Courbot wrote:
>>> While we already have the `warn_on` macro, a common usage pattern in
>>> Rust is to check whether a `Result` is an error. Add a helper macro tha=
t
>>> allows this.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>>  rust/kernel/bug.rs | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
>>> index ed943960f851..2fefc0aeef81 100644
>>> --- a/rust/kernel/bug.rs
>>> +++ b/rust/kernel/bug.rs
>>> @@ -130,3 +130,13 @@ macro_rules! warn_on {
>>>          cond
>>>      }};
>>>  }
>>> +
>>> +/// Report a warning if `res` is an error and return it unmodified.
>>> +#[macro_export]
>>> +macro_rules! warn_on_err {
>>> +    ($res:expr) =3D> {{
>>> +        let res =3D $res;
>>> +        let _ =3D $crate::warn_on!(res.is_err());
>>> +        res
>>> +    }};
>>> +}
>>
>>
>> I think `warn_on_err` could just be expressed as
>>
>>     res.inspect_err(|_| warn_on!(true))
>
> This would turn the verbose error message into something like
>
>   [true] module.rs
>
> I.e. the expression passed as argument won't be printed.
>
> That being said, my version has the exact same problem and I don't see
> how we can fix this without splitting `warn_on` and making it more
> complex.
>
> Since this was done as a small convenience, I think I will just remove
> this from this patchset and revisit later as a separate series.

Something like this?

#[macro_export]
macro_rules! warn {
    () =3D> {{
        const WARN_ON_FLAGS: u32 =3D $crate::bug::bugflag_taint($crate::bin=
dings::TAINT_WARN);

        $crate::warn_flags!(file!(), WARN_ON_FLAGS);
    }}
    ($msg:expr) =3D> {{
        #[cfg(CONFIG_DEBUG_BUGVERBOSE_DETAILED)]
        const _COND_STR: &str =3D concat!("[", $msg, "] ", file!());
        #[cfg(not(CONFIG_DEBUG_BUGVERBOSE_DETAILED))]
        const _COND_STR: &str =3D file!();

        const WARN_ON_FLAGS: u32 =3D $crate::bug::bugflag_taint($crate::bin=
dings::TAINT_WARN);

        $crate::warn_flags!(_COND_STR, WARN_ON_FLAGS);
    }};
}

#[macro_export]
macro_rules! warn_on {
    ($cond:expr) =3D> {{
        let cond =3D $cond;
        if cond {
            warn!(stringify!($cond));
        }
        cond
    }};
}

Then you can just use a `warn!()` with custom message.

Best,
Gary
