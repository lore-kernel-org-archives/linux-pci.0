Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022131.outbound.protection.outlook.com [52.101.96.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33838306B1B;
	Thu,  2 Jul 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003362; cv=fail; b=U2bl66QrJesqpordg5/BMrL6hJ+cMFazdEjabqWzTeNuSVEIw+7OqQHpOwvYNk7UrbY8kc4q1VswbJyY5Ku7wu0FzlVSMlpbRbBfM5nvUqDwEMIIgEyx37mLfVeiFnB46KqSX4hZMI1616z9QMQIswgZEYs1H3qrEt3KiCvVIUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003362; c=relaxed/simple;
	bh=gMFVDaYoK3NOcMUlueVR585dudK/ZlaoVJ0l34Hjv24=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=QiN3lrR6be+KtAkdxCAZ9Nn4hdsnQdfcmjohx4PVPW8KpPG5J1mDz9iGDTiD3p60w9JzGu57SbHXDxMlHHpDEGoMyFBHBERNalaWk/YlDHgjJHEMPweSn5hgfzkzsvqNtAYlko58uj0D1xOpkkUo2oJzlvAj6SfkBNLz47Yusrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=f7Q6RV9l; arc=fail smtp.client-ip=52.101.96.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="f7Q6RV9l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCClLl0BdogzHen6ZF35MpNiOMrTr+nOeLzA9FsPLprC/H6EYTMpbzA08xMWu918jkdfo0nIf0lmQ6ifbk2UHyx/MiLz62E/G+UjRCeU25c7Kzyurb3Vb7UDgnk0gKXxpRnByLqKZDoU4ofldHNFYA3SbMowQQgehfMzi0nAcTmuV/VXu6GREupGPoD1gwwrXfEGfjSGbJw8mDfS3lr/rQSVBhW5GPL+Nsh8W4w0nR1vrL013Fxtyf4rhpjnLeykd21x7GOHMNWB8RPvZ8rIwd6q71MBNYPp4SdKSkYJQUtO1poiEhmQ3wZPWFFDAtoL0J2ZZy/J560bFnmWOVAwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sDOZyp8nP+6QWnTzkO1tYnEpO0GHkCM/78rvlXHEjE=;
 b=YFlAkKh/ZlzfDcECkf517gutVPNK4cn3n2yyB7QiEMBWIh+fgGnPLbcD3ZSKWYL6je0CvVTOe9Lz+tv8V3BxcCrj0CPCHypekX/4LRBjF0bOS2kPCak5rJUQSPLnQFZjFrfrA5OmivB1xFO4kWqllb/FtS2AwoaHt72brJsnW68HF/XYeDSviAJ5eeq4JJlTY5znqhNq5MrMgVPPTmgDceXsQ3wbW6BMVt8TfrQZxZCJ61YpD8PejvSN8+fijT/LS+QkDHTQTARWMkCE9WwlpdaqFRkw7FyoDdkrdCUK+WGHyBRHx0qKJzdf5HA1hVb5F5g+EckZl7s8Y+hliBvHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sDOZyp8nP+6QWnTzkO1tYnEpO0GHkCM/78rvlXHEjE=;
 b=f7Q6RV9lkIoxSVvUczrLwGmhLIN3nZN6IN7j07GpUK1muo8aLxu/quTJg1xvqVPrRw6JVp2E4WpX5BJdssYGb07kXWhi6RxyKy/iMjwTzSPaC7wONnUsH7dZrkt9CW0zR5gRn7XkHypKDF+Icfr3JnHyjeDJWSgUrjP82yJL86o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB2041.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 14:42:37 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 14:42:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 15:42:35 +0100
Message-Id: <DJO5XTT3MOPY.NFTTWA7QMSYP@garyguo.net>
Subject: Re: [PATCH v2 3/4] rust: completion: add complete()
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Maurice Hieronymus"
 <mhi@mailbox.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Lyude
 Paul" <lyude@redhat.com>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-3-6fd6684f2c14@mailbox.org>
 <20260620094815.8347-1-work@onurozkan.dev>
In-Reply-To: <20260620094815.8347-1-work@onurozkan.dev>
X-ClientProxiedBy: LO4P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB2041:EE_
X-MS-Office365-Filtering-Correlation-Id: 45055450-8bd4-4d82-1171-08ded8482912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|22082099003|4143699003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3tuG8oTz7Hnc2q7dGZ3g1AZ7txPKpAcJq1VloN/VUYLq57qRF+gggsnqcupdweZagMkHJAotAMGI+OaVHdJN1VjoEqx50Z3wbPyulQlwKeTYayiMFDBovb9kSYwtTOJf5iA7JpTKJ2Ul3YodHKx2OUwfgRYNRYSCivgP9Zh33WzLJnRzV20rPpKYJeyXwnd0aTc+F1KXrCQBLTB5UcGoSs4XP9jFq5HTNUBJCEyVBM0MiuiSMCyjiHx68DZbxjv1Ei42R2qxEmFLBvaP9jX02V7OIg8CcsBwDlscLgGlUAm+ZDYR0UaOPyeiIS73umh6s1kqAcxT7Kev4B7W7+7lcQo/HClbgyVWDwEPHPzGggKcnALBdFlmhqT2lh5vtZaWafEbnP+7XG1TeVlSgpgxl/q7KQoxIyQix6c0WjCGzB9OXo57tQFjgTpqDK/2ZPIEsYQfxkS3hpNjtvkyUwYqe1NQkQAvXVrECTjHtiLfR4Wc+VqY8tIMVwPZHMgGYOFdonfOYvzWDxz8DrgAwnGsvhHPNEGeYkze1FGFqG1AleEhXwxT2TzSV+vWZl0dvXcFFCs/C3qQWFaNQUj0E6pVWdICYb5E/I0wMb66eK3lpYly3nNglnnQMjLBntppvEqAkUsYRqSXI07yrkXr2G6JZHZif4DmjNHNkVsjHWo4OTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(4143699003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGQ4WWV0SnJkUnh4Y3AyeHl5WDBxTlpvUDZXSlNlL3lRa3VrTmZSOFM0dGhH?=
 =?utf-8?B?aW1tVTBCZkV4bGZmZXRBdzc2cTduNks4U0dpZE15K1RueVpjaEsvTkY1UkxH?=
 =?utf-8?B?SnJkK2Ria25GcXNlSnZKdThoMkNaU2pJVWtjNXhLOUZReFVOSll1dERLa2Yy?=
 =?utf-8?B?VlplZUpibTFteE5YL2V2djF2R0pSUGt4TTVmVmppYlRZTlp3MjYrQUUzc0sz?=
 =?utf-8?B?L2RrLzZZYzkvRHpQZ2NPbkJXQlJuUnR4T0wxamg4RlZldUFTazZhS1pnUTdH?=
 =?utf-8?B?M0drMDl6NGMzTjhLOE9mMXgraktsT2Iwdi94Zlo2Slk1RDBmbHhvUTNtVkYv?=
 =?utf-8?B?dXZxeHVCak9xMEhSOGxKdlJxcjdpbkxVRzVmdlBnblBwQ3JQWjl1aURIbjBB?=
 =?utf-8?B?bUxQUzIrRVRBb0NUdFRVVU9Eb0NWdTUyelZCby9mV1dHdWFpZWE0UGZzRUpC?=
 =?utf-8?B?WGVwSmw0bExoaWptOTJmNk83ckZHUWVqNXNHTjJSNDR5R1RHSFE1UGtSVjBI?=
 =?utf-8?B?ZGlwYjhxSHVoYUc4UE1rMkZRN1lxVXkvc1JMWHFhcCtpOVk1aU9GMGduTkc5?=
 =?utf-8?B?Z1BPeDBNa0ZtL2dhN2ZtbmVMemorcStJN3BWSEVVZmZTLzVCZGZ0NCthQTYv?=
 =?utf-8?B?OWIzTEVjWHovS20yOGFoUWo0dStaalRFak1qV3QxdU43Qmw0dEcwWjRxT0N4?=
 =?utf-8?B?WjZGN0pKam5MckNQSHdpRHhnLzJ2UnFHWFo0L28xMThsbmt6S2R3UmJMeXMz?=
 =?utf-8?B?Sm15TlJ5ZXMwZTNGR2xOZForQnJRUTdnOWNQWTUyWWppUjRGNFRXVVpxUWpN?=
 =?utf-8?B?SUhWaHA1bnA2aG5KaVF2MHNNS1pVV1FnNmF3TjY2N1B1cVNuZmZUSVltN1oz?=
 =?utf-8?B?WmZENmF4Y2dTRHZyZC92VGdERXVrN2RzYlNRaVplYzVoTXZvK09GQTFvU01L?=
 =?utf-8?B?Znk5MU1SU2pVYmplNHBFSDFSbC9GMVNsYjVsYnVLVWlaWk5FQXNnRjBIdDZy?=
 =?utf-8?B?STBkbk1FRThVdVY5cGRYM3RCS3NFS2xqSy8zU0FkWTl2V21kbXU1bGtkY0x1?=
 =?utf-8?B?eFZjQWczYVdyZVBiZGx0SzNmcXRDZWI0WUJNOTY4MytiWHJTYmptZi9VdU9E?=
 =?utf-8?B?anlMZFI5TkhjT1FoYXBpKyttTUdHTmdoaHV5bFRHZnIxbjNNUm4xSlNmQXY1?=
 =?utf-8?B?bmIwTGJVUnE3TzA1NlJoQVBrZTM0aGZmOXV5Qk16RHRpbTM2eENYcXBUOGQ3?=
 =?utf-8?B?YXFCVWt1VzQ4eFZnNnFpZnE1Y0xTS05MOG14OGs1K3p5Vi9BT2Y0cFpkcXNi?=
 =?utf-8?B?WEtrVjFRaVA4a2dWZjdXaEx3UlVlOEU5MUhpbzNhM21XRXFIeTJNK3RhcEVr?=
 =?utf-8?B?bG5sdVpNbG9rUW1FdCtaamhaOHkxd1lNRmtrSHJERXR2NWhOQzVZSmhwVEFx?=
 =?utf-8?B?cFZnbWYzc1pSMlB0LzMyS21md3BQNTY2eTJ6NXBMdi9YdXgyRVI2SFQ1WkNs?=
 =?utf-8?B?eElndG01ZUc5S3YxZ0lJM2gwUndwa2dtTmRCUzArQmhwZ3pnaVhHU3lhT1Q1?=
 =?utf-8?B?N1BTK2NwbmhxT3RvMVFXN09DZkFCMFFBK3dmSDUrSk5hY3VMSVcxcjRJSFFD?=
 =?utf-8?B?THJCQ0kva1pORHdFLzJ4Mm1yK21jY0tJcUsycnFZYmlFc1ZxdW1UZWhrc3Ri?=
 =?utf-8?B?VmVTaklkZWk4K2daMkM3MTJhckIrZ0czZjljYURuZFViWVcvb05FRUNRcE01?=
 =?utf-8?B?eWdYV2JWRjZwUW5CSnJGVWpkM3RZakJZb2ZLOFJ4ZG5nRysvWEg5SzQvMDcx?=
 =?utf-8?B?dU9XakR0Vm8wNlE1YjliSGc2TDdjY2RDZXpPZnFZQXB1THo2Vk1ISkZrNjEz?=
 =?utf-8?B?YWIvTG1aQlpDM3ZHb25OdnFRNlptSjh5RkQ2QktXYmR3MGp1SFllZDhqV2Jz?=
 =?utf-8?B?NG9Cb0V2dVY4dktCY3BKRWhpQkFJS0t5bVFzcHExNGN0bHV4Ynhvc2RoeEMy?=
 =?utf-8?B?T2thTnBjZ1VybWpYdkJlajJaYVAyWHJTUHhhU1pwMDRlNnlvQkJwWXNuRTBn?=
 =?utf-8?B?c1ZRWmRYclh3aHhXUTlWOEU5OEc3WStLUll1RzRYY01NeFJRYlRKZWRHVWJC?=
 =?utf-8?B?T2FoOEFjN29ZS1FMa0JCYytERUFoTVNhbVdZbDg4V0hGSy8zSEk1ajM0QU5D?=
 =?utf-8?B?RTMyd0VpTzhnVERVYzcxRWtKQUJzbkNoNVNtaTd0eU9nL1lzMmJBc3NTZlMz?=
 =?utf-8?B?UTJuZ2ZPQnV4bXBRSTZhUDIxQXVYekEreDJ5Z2ZIcXFXSzBzTStiV3NjbHlR?=
 =?utf-8?B?R0R3a1VZbGRjaGkwdFpkV2JQajgzcWpVZncvU2JjSGkwRmVVTW9Vdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 45055450-8bd4-4d82-1171-08ded8482912
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:42:37.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcsHZfIMp94jNhGDA+PiTTw3LrmEi7US+llQdHuaHNJz87Hk4oaOxWDkgY8mEhBQyYHQDNDjI1JzoHR214oPbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2041

On Sat Jun 20, 2026 at 10:48 AM BST, Onur =C3=96zkan wrote:
> On Sat, 20 Jun 2026 10:45:47 +0200
> Maurice Hieronymus <mhi@mailbox.org> wrote:
>
>> The initial completion abstraction only added complete_all() and
>> wait_for_completion(). complete_all() marks the completion permanently
>> done, which makes a single Completion unsuitable for signalling the same
>> event repeatedly: once complete_all() has run, every subsequent
>> wait_for_completion() returns immediately without waiting.
>>=20
>> Add complete(), which wakes a single waiter and increments the internal
>> counter by one. Paired one-to-one with wait_for_completion(), it allows
>> the same completion to be reused across multiple cycles, e.g. to wait fo=
r
>> consecutive DMA transfers to finish.
>>=20
>> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
>> ---
>>  rust/kernel/sync/completion.rs | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>=20
>> diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completio=
n.rs
>> index 35ff049ff078..a54361b53644 100644
>> --- a/rust/kernel/sync/completion.rs
>> +++ b/rust/kernel/sync/completion.rs
>> @@ -90,6 +90,17 @@ fn as_raw(&self) -> *mut bindings::completion {
>>          self.inner.get()
>>      }
>> =20
>> +    /// Signal a single task waiting on this completion.
>> +    ///
>> +    /// This method wakes up a single task waiting on this completion.
>> +    /// If no task is currently waiting, the next
>> +    /// [`Completion::wait_for_completion`] returns immediately.
>> +    #[inline]
>> +    pub fn complete(&self) {
>> +        // SAFETY: `self.as_raw()` is a pointer to a valid `struct comp=
letion`.
>
> I think the safety comment is a bit weak here. It would be nice to add wh=
y
> self.as_raw() is guaranteed to be a valid pointer.

I don't think that's needed. Saying `self.as_raw()` is valid is a sufficien=
t
justification.

Best,
Gary

