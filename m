Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022122.outbound.protection.outlook.com [52.101.101.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF1384235;
	Thu,  2 Apr 2026 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134644; cv=fail; b=ByJ89wkURhEwpHnQazm/H3OjiwMRt2Kt3XrWOFe28ylQb/Zx0IW2GvWAn00hjh+HZdec7pdxscHpLszb8gjwJaze914syYtoyMEwLRdJ7P5cD5G46Jjsq0pzzIVgK5P8Kq+7mXW24Giir9AqDg72gt47H/QptIL/X6ne/EsIG9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134644; c=relaxed/simple;
	bh=P+VdVS8TO1+loyNyUaX5vjyZ+7EH83suDqQG95nWA0c=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=kmNO4l0SFvB29diFmVNzGU0ucxxGaAdOg7DmgE/IhFw732beF50lCpAQ26JqhgcFGPLv4pZ4atPgMpJ3kgt+60Mz3ZMFjUgupzVazVmvmk5Ye+FeTCcoXRdMIode9Lf4hybeau8NeqNBfeMxSLrk3ok2WWKf/EI6DwS1HMk2+ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QnYqZ+Tb; arc=fail smtp.client-ip=52.101.101.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QnYqZ+Tb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOshInJuihJlRDOHOQHheHo9VBlge9+snemxNZaPgonQx1+OLcP6ydBwd7t+KyjuW8yY76IDxScC62FU+TXd9VK12wl2TWSNWDRYiw4GpvVtK9iTZb0jLBpTsE9wQ63jWGrkYfJGJsQRnQOckSy9smxWnO7UTmqMRcm0y7y8q8ixf7sHDTDKgAox9jH4edm9WhLD3JmnlR/FGgz3HIpsTE/9K5BmIxykHgN4qUpeqyTeusIwTcx+yedTNH9XGHi4WBmXUEAV+58s2PUL7eUex8329eGpxU4IMxBlNcHfNq8EQtCn/HOPUIKPQgtQdpnge4nTsHobCZ1Boa2mmXCV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEsE3x6kP3e5/onLtqPyykZT980R7FIUlmfLfnh2p5k=;
 b=WXKhvC9iA13ZrBH6c7XrOeJ2URbgts+ckGqeYFrTnWOOpc0jMtDCDAps8QQwewLYUPrzXshACqq+UwGuItLNhGxKCzgtgthYuNqQpxQL3SWfQFeC3kFPe3TOG8CC3qHJmRSf3gHI6VQ0L++DEtMPuA6BZRHZx2VrEEXaCggoaznB0TqsQ2dllQXyXomQ+qjtqcs+D5L68mhAqgpzPNIzextckYMGX7dP+5ska2npJknHqtpXqlUj4CLVLeg1YWv/1pXUx1Z/aYqCcoBvtf0EGzJrShtfNvIwOhL2TOzrrBotCxiu+4Bmc1HoqoRuRMKof2SVdlq8TyKm3Pc13D5kUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEsE3x6kP3e5/onLtqPyykZT980R7FIUlmfLfnh2p5k=;
 b=QnYqZ+TbEzW03SlaVSGS5EFNM0DRru8d88h27GxNp6Op9a+wV5WfIzVwKsWrhb8ZCgycrEk0L909Eh0FmHkXmZw89blYPciHrQx7OcLhkNSrn0+H7ifk/SOUt0Wg/aoqKvUyHqVSGJbNHMZnVDh7Y1FHO5C/ty74oA6ooGDPB5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6960.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 12:57:12 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 12:57:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 13:57:11 +0100
Message-Id: <DHIOPJTS4QBX.3805F1AFFZAOK@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Gary Guo" <gary@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/8] rust: io: generalize `Mmio` to arbitrary type
X-Mailer: aerc 0.21.0
References: <20260323153807.1360705-1-gary@kernel.org>
 <_GdG2BR4qqT-8cwpiurteKJJr58WPTCsM6UyCU0NsA1DK6yTNMiSGOBZlm79OMaLm_tIMM7feHDx7mKljWea4A==@protonmail.internalid> <20260323153807.1360705-3-gary@kernel.org> <87o6kayc5t.fsf@t14s.mail-host-address-is-not-set> <bhB8A8DQ2KuT2rRe-Niqt5dPHRePikSsZfFL2XCGm9ABnQEpzHCN7f_1CfKvSOhXffGqseuceJL6XoBlwA_8aQ==@protonmail.internalid> <DHCSCWVI38X2.2K7DBY0YPBS5N@garyguo.net> <87bjgaxxe3.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87bjgaxxe3.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: LO4P123CA0259.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c195955-266c-4c94-84d2-08de90b75b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tT1rBxZc1CCH8+oLmWMirkBNJeuAlptpydhM85sOAHVk9Eg+yFUAjGkznehXS37gr8/TROOTBFKoW8BtsLVIxZHSJxdoefYbzaJujZyFNuivccCK2Mo6ouhdPJNQSZEerYOtv9qm0aTz+F+a/O5YCjg1+BMlCye5RhfQPHZFpksOtSqDgIzJriPFTkw/geFG3HBX4spFl7LvdPbeAR9o6LnacRyiGaLx/lgwCpzdVoeO26dojuGxqkHowOGs2bmfOY7A/gvdCxB6j1Ngkhzv4q2oVPsoNarBdHsfdrR20DjqoKQxy/NcFG4NcGXlaph081EIwp89ik96lCgS0msMqRWKX7hjAgxcb4WglI5zaDNbSrI69cBfsyYpEvU9ceTy0/iqyy5o77UYpjqYCK2y8wpW3wNoDVlVutxUEOuAdIhqofTwP2FdGpzfTwfTKjLGM/oV+n5gDxS0GZk0xKAJ1p1dD7zsXT+X4Sry0PxO69FLN+zJC+oAHcmzqNoj0FzqkbNtC2V2kNmGiFR/MwMav/xckBlQY7naIZlS35FAPj1P5ACK2YO7bCFe1yA4kseqZkSX8/rvDZG7GmoDFTTMKrRq4hD/AZLXQ+tMpYQAZQSkKyfgKhkJStm+jWKImFhgp/Dazw3CqfBJvUBt5enlB8K+XyvvOgcKSyqyMXx/ByXw1eqYuQhmlN0veEWWukQcv4pfFP+SmS62m3OQC426z20VYxZfvWwkw35h36PDm5iz5c/aV8S47Z2CeVxfquYx33WGzrf5DBC5SiWnVuPg0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0tIbXhEUjdieWs1MGZTd2ZhY1I4ZURiWURXTkt3TENQWnNkQkpna24rRksr?=
 =?utf-8?B?VWIrQnN6b2FRWitZN0dObU1HMk1TbFd6Wm1SQWhoRjRHSE96OGpkOWlPa3lH?=
 =?utf-8?B?d09Va21xOThLZFpJOXlqZFM5OTd2czFPWFJ3Znd3bGFRdWRsNk02dXkrQ2tB?=
 =?utf-8?B?SEg3SS9Vc0pMYzc5UnhwalBLb2MzK3BNT3R4THFNcHpObUZ3bzBuUlVWRW53?=
 =?utf-8?B?eVBBcE1mZ0sydFE0K1A0ZDRBOStwbi8rcCtwNnZMaTVyOGs1dk1GdWJxalcy?=
 =?utf-8?B?MitNUWwyTTZFM0ViRG5XMVJiM3Z3a0hpQmtIVDJZSVJFVGxjdWhvWjVDbXZz?=
 =?utf-8?B?aVFXS0RyS2RXY0NsOXpzY1BDaXFHa2dFRDcvbzVYOURyOERpYnQ3RExxUzhw?=
 =?utf-8?B?VTZ6VWNkdG44a2FNMEJobmY2aXBOTnBkV2l4UW9ZUldRU3BZQ3RBQUszZ3dj?=
 =?utf-8?B?cm55NURvQ0xvTVliL1YzSVJaTFkyOHVDWUR4dXVOSXcrVFR0UllHaE02Qm5y?=
 =?utf-8?B?MmR0cExvcS9BQ0tFU09uUElVNzVqR1dYRndCNTdKSUMweVhOdWs2VVJ3bGJN?=
 =?utf-8?B?UTBhV1VLaFVsZUNSQWlHM01PamUweC92aEQ2ZE9hSHhOeHB0NytoTEY5OHAw?=
 =?utf-8?B?RFRaajMxdERzbW8xcm4wTXdGRUtSSUtqNktOQlRJQUd6MXgxU3QzVzR1citM?=
 =?utf-8?B?NW9BaXZNU0UyUDNoeXFuUkVvZzgvd0k5bXQ4dHJkb0VGT2RYSENHeXZ0YlhQ?=
 =?utf-8?B?eEl2WGtCVkgxbTduKzVxQnBqK25PRzJDdTMwd0FpOWEzRzk0KzZ4VjhiZDBz?=
 =?utf-8?B?aHhGK3lDSlJzMS9hT0JGZm1tM1YzaERUZVFKeSs0blZFV1FSb1Vqa0FwNzF3?=
 =?utf-8?B?bTB6eFlvbFpENGxZOXI1N0lsL0NJSzltcE51YnZUQTVmZWp3K1ZMSE91YnV6?=
 =?utf-8?B?T3JvSWszSStQMU83aXV1RFNWZi9oa040VTN6OUhIdTZtaEZjS2N1S3VHNlZR?=
 =?utf-8?B?S0g1RGZBamVCdTJmNmErQjVsWmJZY3ZjaEUxb3VQakhFTVFRbk9jTjhrQUlQ?=
 =?utf-8?B?bW1sUzArbHRuN1NWME1lM2FHSUpvUkZQVjhvUTY4R2xscnNlZE8yUXljWkhE?=
 =?utf-8?B?NmNjaThsMWd2TmlrdFhOdmtUMjBUM2w5UjdNL3lLb1RSd3l5NncrZTdQMEM3?=
 =?utf-8?B?NEpBMXdYcVdsdlozS1YvWlhQVEhHT1ZsTWhvTUF2MXdDOHJiaUJOYk8vOVNo?=
 =?utf-8?B?MTlYbFZhZVVydDloNFI4WnU2TmppUXloUFd5T1BhaWlvMVlndzR4UVc5enZa?=
 =?utf-8?B?Tnp1TkJoMEZ3d1F1b3kydjNneEcyYmEybHZOaFVhVVFiSFJvZXZkaUFQRlE2?=
 =?utf-8?B?ZVpGOVdRZ0ROajk2WGpKT2cyZFNIekNtcDJjVEpFMTI1QVBkamY1blN0cGJL?=
 =?utf-8?B?czRaVi8rbWVKb1BxcGYzZ2RHZFp1dTAzaDFSQ3B3NFpmQlNBWGdtbXFsYis3?=
 =?utf-8?B?NU5MZkNCcExtYk9ub0hiRm9RYlBScTUrRUdkQm80Nk1DV0J5NnZOd2J6aXFq?=
 =?utf-8?B?S01Uc2NXSFJOTW1FMlQyOE9QK25wOXh6RWdDYjY4UDBFQUl3c2ZTVVU5Y3BT?=
 =?utf-8?B?dmpkWWg5OVFmMkpaYVN0b2NYS0UwRURnTWE1RmM3MzFxbjlkdHh6Tk5IQlNl?=
 =?utf-8?B?WFU5NGw3RFpkOWVTQk1CN3p3TFczRG9OK2pTQW9hcDlvWGNqb0ZZOVl6VlEr?=
 =?utf-8?B?b2duZFF2YzFBUjlBK0p2YUg2M05zSGZReTNZVTFYLzE3ekhiLzNQTCtmczFk?=
 =?utf-8?B?M3NkWHdwTGJCMS9uVEtjOFVpM1ZHRmdTOXpxMTdqQUJmRkt2d2NHQjRFZVpE?=
 =?utf-8?B?MCsxY0c1U2ErZVdmUVI1ZWRhOGloTXlVRFhEV0c0d3h5VDhlSC9VNUFyMlM4?=
 =?utf-8?B?TWZ3Zjg2amlHcGxGK1V6anVFZENGb3MvK3VNMjJtTkR4Z0RYcUs5R1daL2s1?=
 =?utf-8?B?cVlzSzloaHU4aitlRzhmWTlzN3I1d3hqVEJ4VE44MjFaZ2plSW1GalJBUU5X?=
 =?utf-8?B?clRXeVI2bU5YOS9jNXlqUFV6cVpRdlcwTmVOMjRnM3VkUjZsaEFvMHhKK0lo?=
 =?utf-8?B?NnpHdERSV0V5bFZmSXJnbUQxTlM3TXBjd1Q5a1F1M3hpS2NEcnJYcm9OS0ds?=
 =?utf-8?B?dzBCRXEzUEh4WHJ0Vit0TTNvN2JlKzNnYWdGNmFmOG1UaGtBN20rTStLUGpV?=
 =?utf-8?B?YTBNMjgzWGQxeW51R3M5Q1krMG9JVkxzdHpLVitVbjQzR1RHVjk2cnh5TWdW?=
 =?utf-8?B?dmN6N1lJZWl2QTVtM2ZUSzBEUyt3L3Fuc2U3Y1NtYUtkWWJTSEJ0dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c195955-266c-4c94-84d2-08de90b75b75
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 12:57:12.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGtDJC+TucAPcGo/VLSDuWfimOD1Go+xRa3vq/ag0nT/cksT6UDseh2qJ8jxxI/WC9RsUx1U2bW2qF6+r3kwAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6960

On Thu Mar 26, 2026 at 6:23 PM GMT, Andreas Hindborg wrote:
> "Gary Guo" <gary@garyguo.net> writes:
>
>> On Thu Mar 26, 2026 at 1:04 PM GMT, Andreas Hindborg wrote:
>>> "Gary Guo" <gary@kernel.org> writes:
>>>
>>>> From: Gary Guo <gary@garyguo.net>
>>>>
>>>> Currently, `io::Mmio` always represent an untyped region of a compile-=
time
>>>> known minimum size, which is roughly equivalent to `void __iomem*` (bu=
t
>>>> with bound checks). However, it is useful to also be to represent I/O
>>>> memory of a specific type, e.g. `u32 __iomem*` or `struct foo __iomem*=
`.
>>>>
>>>> Thus, make `Mmio` generic on arbitrary `T`, where `T` is a sized type,=
 or a
>>>> DST that implements `KnownSize`. Similar to the `MmioRaw` change, the
>>>> existing behaviour is preserved in the form of `Mmio<Region<SIZE>>`. T=
his
>>>> change brings the MMIO closer to the DMA coherent allocation types tha=
t we
>>>> have, which is already typed.
>>>>
>>>> To be able to implement `IoKnownSize`, add a `MIN_SIZE` constant to
>>>> `KnownSize` trait to represent compile-time known minimum size of a
>>>> specific type.
>>>>
>>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>>> ---
>>>>  rust/kernel/devres.rs      |  2 +-
>>>>  rust/kernel/io.rs          | 63 ++++++++++++++++++++++---------------=
-
>>>>  rust/kernel/io/mem.rs      |  4 +--
>>>>  rust/kernel/io/poll.rs     |  6 ++--
>>>>  rust/kernel/io/register.rs | 19 +++++++-----
>>>>  rust/kernel/pci/io.rs      |  2 +-
>>>>  rust/kernel/ptr.rs         |  7 +++++
>>>>  7 files changed, 64 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>>>> index 65a4082122af..3e22c63efb98 100644
>>>> --- a/rust/kernel/devres.rs
>>>> +++ b/rust/kernel/devres.rs
>>>> @@ -106,7 +106,7 @@ struct Inner<T> {
>>>>  /// }
>>>>  ///
>>>>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
>>>> -///    type Target =3D Mmio<SIZE>;
>>>> +///    type Target =3D Mmio<Region<SIZE>>;
>>>>  ///
>>>>  ///    fn deref(&self) -> &Self::Target {
>>>>  ///         // SAFETY: The memory range stored in `self` has been pro=
perly mapped in `Self::new`.
>>>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>>>> index d7f2145fa9b9..5a26b1e7e533 100644
>>>> --- a/rust/kernel/io.rs
>>>> +++ b/rust/kernel/io.rs
>>>> @@ -44,6 +44,8 @@ pub struct Region<const SIZE: usize =3D 0> {
>>>>  }
>>>>
>>>>  impl<const SIZE: usize> KnownSize for Region<SIZE> {
>>>> +    const MIN_SIZE: usize =3D SIZE;
>>>> +
>>>>      #[inline(always)]
>>>>      fn size(p: *const Self) -> usize {
>>>>          (p as *const [u8]).len()
>>>> @@ -169,7 +171,7 @@ pub fn size(&self) -> usize {
>>>>  /// }
>>>>  ///
>>>>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
>>>> -///    type Target =3D Mmio<SIZE>;
>>>> +///    type Target =3D Mmio<Region<SIZE>>;
>>>>  ///
>>>>  ///    fn deref(&self) -> &Self::Target {
>>>>  ///         // SAFETY: The memory range stored in `self` has been pro=
perly mapped in `Self::new`.
>>>> @@ -187,7 +189,7 @@ pub fn size(&self) -> usize {
>>>>  /// # }
>>>>  /// ```
>>>>  #[repr(transparent)]
>>>> -pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<Region<SIZE>>);
>>>> +pub struct Mmio<T: ?Sized>(MmioRaw<T>);
>>>
>>> Why not have the `KnownSize` bound here? I think that would be more cle=
ar.
>>>
>>
>> There's no need to put bounds on structs unless you need them for `Drop`=
 or use
>> of assoc types.
>
> I understand there is no technical need, but it would help communicating
> how the code is intended to work. Unless I am mistaken, T will always be
> `KnownSize`, right?

I think most users don't need to know about this. All `T: Sized` will be `T=
:
KnownSize`, so if you're using it with a concrete type then the bound is
already satisfied.

The same argument can be said to document

    struct Coherent<T: AsBytes + FromBytes + KnownSize + ?Sized>

instead of just

    struct Coherent<T: ?Sized + KnownSize>
    // ^ In this case the `drop` does need `KnownSize` bound

But this just makes code more verbose as now you need to carry `?Sized` bou=
nd
everywhere.

If there's nothing other than documentation purpose I'd prefer to just leav=
e it
out.

Best,
Gary



>
>
> Best regards,
> Andreas Hindborg

