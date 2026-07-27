Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D63DA7F2;
	Mon, 27 Jul 2026 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140065; cv=fail; b=mLN09oThu9G3aQmxlmTlzztEbw5QcI46ZUZRkyc8IPK8FEY3+NNfcKToA93DbU2JSZ81369YvRnK5pc0ZqpsbPWD7+jVHHhX3RwcAW2NIyNkqAcU/bKODLtiY5PP+WiS/UUrWp4LSxbWg0hXUlVyyWfO74PJyItwTfrlxrF+zxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140065; c=relaxed/simple;
	bh=95toJqyIYxGexmP4tLkXDQhYJPV3F1ZxN18Ipqqe/B0=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=OHUIFK1bH7dKCWp9BhggezOFhgqfN2uuxY3OF69AkAiBFB9gSAfFXzhNZ4l41kYFHjnWVzVi2c9AljBk9O+/6obpi9tgfPmaiGYnJ4i+iahEganLm0V1OmggVziHLDUdvLkKjtjKm+Tle6Pv+HapDqVTD5+SqBGNnGunKBtdXe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ONLgdToM; arc=fail smtp.client-ip=40.93.194.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ONLgdToM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSLdES/k527eS3g5jL013ZLhfvEAJOBKPFsDT6769tOntkFDqJmXRw1xgHlWZXARz4S9nClLASAJsBU9zXNovUJc9j6zBSLtC9xnnPEYDFN2/TkcjAvrb0hoa0597nQYychSqnnbqXc3TL9roE026KFEbfXQRrQomrl3fksTBejinjS7qnuyhZ+Yd8WXWEHAavXwb9qx0KE5DMK/EeLBs7BLtyAC+5ytTWJrEIbfgDoqVkxB1DXj17rgh5rBU1udJFuuAO2i6n00nxwRMvF8ZVcD+06+yy+KqwNHOsMglo0yc6Nu4L+qnT57bSiJ4ExFK0fOgV567OCvBdQDAsnhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGb41rIOmKOz3qADZdB9w/56poMdQKzTmWM+nbrJZJA=;
 b=dEQmJsAQdqKZeMqelnRWp8/2Fsk5/WRkvmVB1ApO/1XrAhfNZVpi5a5a/fN2G6WSlDIp3J29vdv024zaIu3JJOa4WySA27Tsbfbgohp9uupnVkGQ1KCwCzBFAaXE9g7P1hH9TahEXt1q6R0NdX2Z0sqcxwhndJ60Wl9wOG/+FNNBaBZpLV5brxtkxQCO9aXTpS8U54p4B3fkYloewQBPN+7fYY5x7n4JyGz0kxsTNU4V03OTU/ZsL757amBCnTtCSbU4fxjRLqE3nkrUhfB1yhvNpUq9KNRA5f8ykP7ayZ8rXGQwqy5+svYcqvwMTjRo3kEvnYPC+l0igp0SFBXTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGb41rIOmKOz3qADZdB9w/56poMdQKzTmWM+nbrJZJA=;
 b=ONLgdToMULNEUk6HNbQAmlBrRiRlu2CWG1v3r3I4ODss5EeBsg9O0Pd6ZXQ8DG/Iflk2CNN90/kt0BrmZbp61/28J2tpD/m0Fx48hv1utmR84LoxyQM64sUSGeiNgETtk2d0m+pM8+pgUAkKF2J5Sc5JizYa776wMNvoTsCATpk9AX7P8FbAOXRbS8g5mmKrSTweqiX8dw+Qbj016sYL5l62JpfoB+/K5XP6sCDZOUiFoYcz767pSw9YdxwfWUp/hSDnO5m2754m6SAu1rnUjDVWRWV9TbO7I8TbKbMwUHT79gdDO/wc7xJXF8Pz2KDRmGZfoEPVGFcd2/OWtsz2lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 27 Jul
 2026 08:14:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 08:14:12 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 17:14:07 +0900
Message-Id: <DK97C0MWLGFS.3D544FUPW2ADF@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 01/10] rust: io: register: allow explicit base type
 specification
Content-Transfer-Encoding: quoted-printable
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
 <DK6LF1ODPWC3.3QQV3SXQ55SXP@nvidia.com>
 <DK6U0LR7D57N.3FW1CZG9R42YF@garyguo.net>
 <DK93SOJQHSVI.1UCSJRLNZORJB@nvidia.com>
In-Reply-To: <DK93SOJQHSVI.1UCSJRLNZORJB@nvidia.com>
X-ClientProxiedBy: TYCP301CA0051.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: e7aea654-5585-40ef-789b-08deebb70a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10070799003|4143699003|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	37hVDaDkjQIH0yQaNGECxMGK8z2jBJTAt7OIybbvJDoeb5aPgwqJyyAy5Zl+sw41dSnVJ3Tw9WKEyXZ1bqx1zk8Q6hQ6jK5YvQwBNt2tBbzyRrA3haRF0e4djjQ9NfabfqiiOusRjnFNOoZfErwBnA1BQTMl72H0E2sAcYnIN3qYIgm1xIDxY9Bm4F9KpgmDghBS02kS2NHomE2uSBnBAR9XLJIcdIWgrpvivGQadIw+4MW19wkvLl27GTd9NIlTkG7MTxEV9AwCw/QvhoBcfOY38MJNxdAe1h1/N92maQm407jd4BH1RUgrtJbX7cOchEf1YIeFY8e2+DDY7HVwBew2KWiX3oHvTsiJe1oHpdmD47xUTJzqsfEaZafU1VyvLLwvg7I95NYSBUfQGE/wEwv+eIuWV1mvfNHcfZvvz2BThVKQ97gv3/IJxZOgRxYGiO+zztuSB4EynQmO7Bd4OhRnk8BWtCBGXUCwELQccs37UaUuO09CkypYlRx1nf/LqL4KLBRqWUD42r1M6etrOYs8GnyJqpL1IEXiCOFQCMN+TG4GTUgA5LdrGS6QmfemBrqp+moqhlp33dfPrUeH8sZvZxgBOAI1FZc9Qi4IYxJLN/NKGShJAAJ6t3cH2exiMwBpvA4sfOjYn/Zu8Sw+IQ+AlHG105l0EPyiv0167Ks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10070799003)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVI3dENLQ1pBMlZRb2tyVjhJNHp1clF0aE1QWUVYcG1HVGlWa0J2OVF0SEdS?=
 =?utf-8?B?c1lHT1FzMml4Mmw2ZWo2L3ZqL1RQWWEwd1NkLzRWaDRFTXZxRlVkRzh3SHRT?=
 =?utf-8?B?NGdRUGNCUFJWVHVtRXZwMkVpeG1DempYSXhQdldTeWhyS25TWnJpL2QyKzND?=
 =?utf-8?B?ektnK1V3aDU3bWRjalp6N2pNbUQ4STdpMFIzZk1BRUQ0SjhmU0x6bC9IYlhK?=
 =?utf-8?B?NFdPRmdpYlNRL3dmZy9SRU1zUldtQ2xyMmlhNUtTMk9Ma29BMmpmc0lUSzYz?=
 =?utf-8?B?anR4d1pLVGJvUE5taW9UUTkrWkxYTm1ocHloNStFRmJKd3F2QmJmTVlDaXJp?=
 =?utf-8?B?UWxWWEhJdE5sZGhOc01XTlBJSFR0OEZ0VGs3RjRxVk53RVhYaldaWjRkUDRF?=
 =?utf-8?B?RUYzV3NEcHV2bDJ2WkJFeURuRk5UZmNneEN4Nlo2VnZoTUZLbkY0UDdPRitk?=
 =?utf-8?B?WEVJcERwYlZVMkFHcHBKZjBTOXpuQnhYTU9VRFovV2wxYlk0OXFGZlZzamVj?=
 =?utf-8?B?RWVtM0ZFelFEcmpOUTdnWjg3eXNvLzBKVHkxKzNWSEQvRmJqQnNUa3R4b3p0?=
 =?utf-8?B?ejRxTW5sc1JGS1BoQ1o4SjR3bTBuRzZpa0plUGU2dmlWK3VNQ24wT25JWFBN?=
 =?utf-8?B?MXJLRjhabGZMNU42Yk9nMGJrWWE5KzkrZmpYQVNCOSt5TDFuT3ZzdU0vQmRN?=
 =?utf-8?B?aDEvQlpPa29JNElrUm54d2ZsbDJ0cFNjdEpIaTYrczg3MDZsN2s3MGlpK2Nm?=
 =?utf-8?B?alhiK0crRUJhcTdDcXNFeG5YMkVaTzFBWG96SjBTRUZhSGI5U1BLV0IrNktW?=
 =?utf-8?B?R3Z3d2lpN016TGhUQlV3ZElOVWFTOGhRcUcrdm9Dck9adXNGVGVPSVJzSTZ2?=
 =?utf-8?B?bVdUV2xsVmhDeFZ6RU9WdDRXNlFXNmxBOHhHVit6RU56Qmorb29oUjhNNEdE?=
 =?utf-8?B?d1Z6NHJYWmdZOTBvRGswK3czdVM1UnE3VVZ6a1g1WWl3WTFROVNwdFVhbnQ4?=
 =?utf-8?B?SUVPVlNHajFhWUppM2hqYXZmdnB4dTJJVlFCL0IwbDVnQzFTNzNIWE10QmVx?=
 =?utf-8?B?NENWT2JkUVpjSysrRnFmbzBjZEtPS0Q5L3VXL0JETVJlNXdoT0syd2twZjZ5?=
 =?utf-8?B?OUFSVE1Jc1ZrVzQvalhKVHdpY1pFSUg2Nm14WG5GSGZDUEdKYXNFZnZncUJ6?=
 =?utf-8?B?SVRFN0lMUVNmd3RQUkZyMFFJOUNIR2NBTzhaNFVyUndpekNlZ0hWaHZZalRZ?=
 =?utf-8?B?VExpWUdEZkFFYndYdVJhOU1LRUlaOFN0NUE2b1JYcGg3eTBSVkFHcVRvRVhr?=
 =?utf-8?B?enMrOG9vLzhKZTB0TzBrNXlURG5YMkZTZGhLWDVjUFRubnNsbEJha3NLT2xV?=
 =?utf-8?B?Z2dUMnE1cGs5NEhqWjF4bzNOUXppaERrQTcxSUZ0MFhLRHRSeDJteHYxMHdv?=
 =?utf-8?B?MFBnUHpibmxMVW1YWWEvU1o0ajNlSlI0MjVyemRGRjRCTU5TMmxNSFJRcHhC?=
 =?utf-8?B?dUs2YklpMGdCTVAwMXRYZnF6Uk1va0diUVZoY2hPTVEvTjV0ZWd3cktXQ1ln?=
 =?utf-8?B?djNSQnllV1VWVEdtVUtaOFg4cDFpbjNxeVBDYmxTTTFuWElaTnJIam1rWEtH?=
 =?utf-8?B?ZXFvT0Z3U21sQVhGSi9sYUFSUEJXaHJHUVVOakFrbnN5cXVBQUF2MVZ6V0E5?=
 =?utf-8?B?Y290RlZUWTkyV3pNaGlUYVpCa3NHTXl4ZzFZUm5mWnBtbFdRaWhGdWM2U2lC?=
 =?utf-8?B?amhPejBCSWc0ZVZBeFE0MERRaTdzQjFCekhHSC9IRlZ5Z0Flb25CZC9aZUJ0?=
 =?utf-8?B?ZkZsZnRWVlh6SWcrcGc0VU1EZzBTMDQ5ZjgwanJMdW1hRHVvVjdRalVIbys1?=
 =?utf-8?B?cFFhOGZoeVY3MnhsWDhxM1pZU1FTZlZWWU1RSHdHOHJPdExRTUFRRkUyeVJP?=
 =?utf-8?B?K2ZGVjZQa0x3UENJSzRuejJiZUN1Z2oyVUwrbHgwUkNJME84TjE1YXNHZDQ3?=
 =?utf-8?B?ZlBiT1VtK3J1TjF6MDBuU3VtSkVBaHZaQXlLY21vOXpQaFRZMkpaM1E5RXhv?=
 =?utf-8?B?QTU4akZ3TGs0cy84RWs1VHFzSCs2YUx5cVZSSUhYVE0vbkY1WE1CSUxjVUdy?=
 =?utf-8?B?ZUNSaGs4NkdlQmtldFo3VklscWhUY2QxSG9VOWVYVm1tME9NZFAxWG11WVdn?=
 =?utf-8?B?NGIxWXBpQjVqUnVVbW1IbGJEd1U3TGI3WGtQM0RkYVdPamNYaEw2QmJYNXdz?=
 =?utf-8?B?TWdOV3JlSkpqVkRVNWRrSnYzZ0w2cnhvWnVsV3FreUJEN0JnZzBBZ3VESy9z?=
 =?utf-8?B?c1ZaRk1mblBmMG9MZS91bEI5ejZUd01GSTFYK3dTcmYrckpYN0pkeUZuR09v?=
 =?utf-8?Q?fGAFT9MU5cuO7SaN4xMB1etrDRdcr/HNeIEldCOfXGWNs?=
X-MS-Exchange-AntiSpam-MessageData-1: nzxftxoPEJZhpw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7aea654-5585-40ef-789b-08deebb70a6e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 08:14:12.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ1HnbendRUyK2UlZkKZVd9Ko00oOZ4ftXHqW8NmEYGLs9n/LS4xRmU5KyxoBsVsXHmchD8pr/YU77DL8xdr7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172

On Mon Jul 27, 2026 at 2:27 PM JST, Eliot Courtney wrote:
> On Fri Jul 24, 2026 at 10:22 PM JST, Gary Guo wrote:
>> On Fri Jul 24, 2026 at 7:38 AM BST, Alexandre Courbot wrote:
>>> nit: the base-commit trailer points to a commit that only exists in
>>> linux-next (next-20260720) and is not easily discoverable - it would
>>> help if you could mention the base in human-resolvable form in the cove=
r
>>> letter.
>>>
>>> On Wed Jul 22, 2026 at 1:54 AM JST, Gary Guo wrote:
>>>> Currently registers work for all untyped I/O regions, which is not ide=
al.
>>>> It allows registers defined for device A to work for another device B =
and
>>>> there is no safeguarding at all.
>>>
>>> This doesn't sound like a real concern. Registers are typically local t=
o
>>> a driver, so one cannot use registers for device A on device B even now=
.
>>> And within the same crate registers can be isolated by module if needed=
.
>>
>> Even for a single driver you don't want to mix register definitions. E.g=
. if
>> you have more bars, e.g. if you have subregions of registers, like PFALC=
ON and
>> PFALCON2.
>>
>> Your relative register design uses an artifical marker type to distingui=
sh
>> between two different subregions, which is a very good motiviation to sa=
y that
>> registers should be typed.
>>
>>>
>>> Even if we restrict the base type, the examples given in this patch onl=
y
>>> partially address the issue: registers from different drivers using
>>> regions of identical sizes could be used interchangeably without
>>> complaint.
>>
>> This patch set gives you the way to do newtype on regions. Ideally all d=
rivers
>> would eventually use that and not use the `Region` type.
>>
>>>
>>> So I don't think this patchset addresses this particular problem, for
>>> which namespace isolation is the correct solution anyway.
>>>
>>>>
>>>> All users of the `register!` macro know what type it will be operating=
 on,
>>>> and that type is consistent across the driver. Therefore, add a `base`
>>>> parameter to `register!`.
>>>>
>>>> Currently this parameter is unused in the generated code; it will be u=
sed
>>>> when all users of `register!` is converted to gain the parameter.
>>>>
>>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>>> ---
>>>>  rust/kernel/io.rs          |  4 +++
>>>>  rust/kernel/io/register.rs | 79 +++++++++++++++++++++++++++++++++++++=
+++++----
>>>>  2 files changed, 76 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>>>> index 95f46bb75f9e..c5f07c38e59e 100644
>>>> --- a/rust/kernel/io.rs
>>>> +++ b/rust/kernel/io.rs
>>>> @@ -883,6 +883,8 @@ fn try_write<T, L>(self, location: L, value: T) ->=
 Result
>>>>      /// };
>>>>      ///
>>>>      /// register! {
>>>> +    ///     base: Region;
>>>> +    ///
>>>>      ///     VERSION(u32) @ 0x100 {
>>>>      ///         15:8 major;
>>>>      ///         7:0  minor;
>>>> @@ -1028,6 +1030,8 @@ fn write<T, L>(self, location: L, value: T)
>>>>      /// };
>>>>      ///
>>>>      /// register! {
>>>> +    ///     base: Region<0x1000>;
>>>
>>> I'd prefer if we could limit the `base:` parameter to registers defined
>>> against a specific block (like the current relative registers). Having
>>> it on all register definitions adds an artificial limitation (that e.g.
>>> regions must be of a given size, which may not suit drivers that suppor=
t
>>> several generations of hardware with varying BAR sizes).
>>
>> This is more or less intended. Your driver code would have a fixed known=
 minimum
>> size, even if your code works with multiple generation of hardware.
>>
>> It's just that code touches registers outside the known minimum size wou=
ld need
>> to use fallible accessors because the bar is not guaranteed to be large =
enough.
>>
>> If the code is written so you have dedicated HAL paths that the register=
 will
>> always exist, your should just create a new type for the larger region o=
f
>> specific hardware generation and define the register on that instead.
>>
>> E.g.
>>    =20
>>     #[repr(align(4))]
>>     #[derive(FromBytes, IntoBytes)]
>>     struct MyNewGenHardware([u8; SZ_1G]); // This new hardware gen has h=
uge register space!
>>
>>     register! {
>>         base: MyNewGenHardware;
>>     }
>>
>>>
>>> Top-level registers are currently working fine without this, so it
>>> doesn't seem justified except by the safeguarding argument, which I
>>> don't think is relevant here.
>>
>> This *could* be done, but this means that we need to change register tra=
its to
>> not have `Base` assoc type but have it as generics. It is however proble=
matic
>> from trait coherence POV, because Rust complains that downstream crate c=
an
>> implement
>>
>>     impl FixedRegister<MyRegion> for () {}
>>
>> and conflict with blanket impl.
>>
>> Also I think this is not really needed with strongly typed regions (see =
above),
>> hence the design.
>>
>> Best,
>> Gary
>>
>>>
>>> The syntax (specifying `base:` only once at the top of a register block=
)
>>> is a great improvement over the current one; if I were to pursue my own
>>> fixup series I would definitely have adopted it.
>>>
>>> Still going through the series in detail but wanted to raise this point
>>> first. Overall I think I like the direction, it makes the falcon
>>> register accesses read much more naturally.
>
> I like that we can remove the relative register which feels
> non-orthogonal to Io views to me.

Yup, fully agree on this and I also hope we can find a way to access
register arrays that way (IIUC the current blocker is
strides/interleaved register arrays).

> It also feels natural to me to specify
> the space that a register is in (Region), and you can decide what method
> you access that region (Mmio, other, etc). The cost seems to be that you
> need to specify some region on every register, but afaict you could make
> that a Region the size of the entire BAR0 space, or a non-sized Region
> and just have all your accesses fallible. So it's a bit noisy but otoh
> it's nice to think about what space each of your registers exist in.

In the case of Nova that's something we might actually want to do: as
their name suggest, registers are split in large blocks (PBUS, PFB,
etc). And we are currently trying to move every register out of the
global `regs.rs` and into the module it belongs to. I am not entirely
sure yet whether this is worth the effort, but we could also split the
BAR0 address space into these smaller register blocks, and assign each
block to its corresponding sub-module. That would ensure each sub-module
cannot access anything not in its region, while also allowing the base
address of register blocks to change (as it does sometimes between GPU
generations).

The question is, do we want to impose that on each and every driver out
there, e.g. can we maybe have a rule that doesn't take the `base: `
argument, and in that case provides the original behavior through
dedicated `IoLoc` impl blocks. I am not sure yet whether that would
work, but if it does then there is little cost in providing that option
imho.

To be clear I don't see this as a blocker, and I like how consistent the
internal design is.
