Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020098.outbound.protection.outlook.com [52.101.196.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50AF353EDF;
	Sun,  5 Apr 2026 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775431293; cv=fail; b=Wicoe5DL6gOiwOA2ZxMOhWj4Q894yBy/sgJD2AdN5kUUfFi1zhGZ01RApmF3i1zghnsK4Qd/a/nxjRBcySXAIxvZQLHihR3EV40BUt0ME8wEG3KHTeu8qvkddbklHkljSw+79q6bcCtD+LQKyXb/1hM5t/KKQ/aQD6IM1sbsH20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775431293; c=relaxed/simple;
	bh=+zOah+eH8bQTV6F+/8XBWsk9uLi52RBA3N35rNAgOOA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=JMvKrjJUUHbAkUWCaQJDKXmWX34uj8Bb8F3Us6tbePyPxzkX7q9opZITeimmJByD5FEzuY8op5oXgasw3rQaIbbP850HJyhO8wS8Rg8tnfuspzXvA/7aPqd9fPHUQyQ5p9ecDBkxYilAox3fKarQFcdNO+UNCseKHJBPsY8wP7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HeUXbW8y; arc=fail smtp.client-ip=52.101.196.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HeUXbW8y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+ItvPXigNcbOwlPp3YG/G4Ja4PdpN/3/zwdJdKZFytJJZbqcfPdRwKPR4DgsTJRRvSIgRVnfgb/FEjCvYZknesPiGP4sXPd7d/On9RNUR5UhCEad2+hvOVNpTYeKhQWsUjI0l/RZGwmJg6I2F0GzebzCZ64W3KRKDeC6u4zXv9LjEt5OMxOJlb/bBdKmUGA+/k6DbpQuiItWBvASFzWLwSghbOotvU/42GQeJOE4phmD8ABIfB7eXweitZYeLC9MZtcg2oxpqTvqV6PyauL7J8v9bn4JlA58zh4IVGNKVrC4NfgJdgY4mQuy75ie8nWoS1tQUt4KDHFQRkzepoSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zOah+eH8bQTV6F+/8XBWsk9uLi52RBA3N35rNAgOOA=;
 b=AuC/WgcqT30E41fZx3+EDCGEFxdnPfj41+UsXUHQD36Jj3K9qNwgVaQSSsT0WLX5gddarLk/QhY2/Mi4cPLZFJS3J/wEkWqYQmIz9YzGW06QKcW32xqaJrWJ94OMl3YxywR/urFpvJfpZNBe/HMGbN7wEos2AcbTmt91DrBjrYcTOx+irOlP8JKmAZwiTWc/opsVqxhD+BtEwDYhcjHHy3Z7exVVggpCYjAU2uwmegyMgHONc9vQ/jdNkc+AuGdfhFgH3z6KsBYg6X+ksSlgAuwuy38txtxFE/vCeaZk3fs2DRD6zzTKe78hAbnW1VTrVPwqFXihmirGUL7ICQdUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zOah+eH8bQTV6F+/8XBWsk9uLi52RBA3N35rNAgOOA=;
 b=HeUXbW8yQDNv0Sb6r4rQPSNX/J63pFwimUXPoTmQGaHZNvirL5zIJBGFF385YizJ7r5iI1WoRHyDZglB7sHYrI62AvIKRouaCPKzhfvJVJFS1S6TKRgmxJ0mpJhCBAHH/C6cxBmlgwIJEj3fo2ypy79cZ1jxZBl40Ms8nWwf7xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5602.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sun, 5 Apr
 2026 23:21:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Sun, 5 Apr 2026
 23:21:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 00:21:29 +0100
Message-Id: <DHLLV6ER6L2T.JF2CXDXSFJX7@garyguo.net>
Cc: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/8] rust: io: generalize `Mmio` to arbitrary type
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260323153807.1360705-1-gary@kernel.org>
 <20260323153807.1360705-3-gary@kernel.org>
 <DHLB3RO3OSF5.2R7F27U99BKLN@nvidia.com>
In-Reply-To: <DHLB3RO3OSF5.2R7F27U99BKLN@nvidia.com>
X-ClientProxiedBy: LO4P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a01c771-98a6-4331-a9e8-08de936a111e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	x+z+pEaJVq+NQj32ZNO9bWS1xPil5/zWkYFbB6mOIeqE7QM4w2GYozle4M0gqs4dmvGa2+OV6Pf+UUavSVB7KHezQWUDG7rZ8i8qR34vwhY3Rf59JVqWYnJzctI1v9NBgIILmxZCcyRT8xfVa3RhZ4OVwVvr9VvzyfT//SQ52shW1fwEP7XV2obwZ05tGJNpA/bL3NXPEId3wfs0oe5TjjBMYOHbr1QTIGcdN/yxbs6Jx54u/MIwfrm44hJKpTlVAD3xiMkKGI3VLSBjLUqQ2ssSjhR1fRwqFhw+2U2LAqcl1J8rh2x1ovwrLIlc9mdtzE5RleNKS5cJsELw9flCZEXcOfMU/BjH2kyLRhn7Ims+Ipu+8yFUMQ7IKjpj6UIaod1I+OPE6u+OJSzY9IjQgFY2uuBtQV0RTxSCM6ZAlezNLjAvXKhxJaOukWxOFXK7UZiwUg7Gz0QVT6HtoHr54nwra1WWbdYEdxeFQCc/c4xcQe3vU+PvTENfp0CgOK3FPkx7YyGeveBK1REr/9ek7Ftrf4U7HLdasUmK3x7BNbLIykgXvdA8GAYtrhzUoC+H12YCItoMV8Mtmv+TbA2VeZLP5gUPNdho6CE3scIgL0kIunKlArOYJ6iq3kvD4WP72q/2tsw9BA/L25mqeORk9f+DDzGdU5toyMMAZWMegoOolE1YUe21t9HSivlsrtRwAcqFMfLXyKbimdhBX9mLVS1HtL31deRJCbQM1Smi978=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QThKS3kwa1dVVDByYlc4elo4Ym55ZHVobGZVQ01ScWpBZko4NjJvYkJhUUlx?=
 =?utf-8?B?VHIvNGlpSCtTS3krckxCeUpLZ1NIeHJtTDJmU0xTTmoxLzZPb3hmTHpWUHNo?=
 =?utf-8?B?Z1Z3SkxLbG5zSTMxZHcyZVI0Mzl1ek9DaWM1VGorOUFaUVl4MUJ5QXp5SjVC?=
 =?utf-8?B?Q3prTkV6R1ZNcWdsR2MrRjJ2bWl0TVRlNllJYXBQeXA2YTZKcHlIVEd5blR4?=
 =?utf-8?B?L3E1NzFEQU4xa3hYdjlRVlR0RlZpbnlEY3FEb0hqT3d3cjZ0UlN1ckdoUXlu?=
 =?utf-8?B?T21EdzhqcDU2dE5NK1BCTlJOcHlSZVhGNkdPRWJrQWdGUUVobmxpOUQreXFk?=
 =?utf-8?B?VG9Rb1ZLSGNVNlVqakRDMUYrSmJ4K0dvaHJMTEx3dlRuT3V5cmRKSzFHUmNY?=
 =?utf-8?B?QS9OUWwxd01Ha3lyeld5NDREcC9iL0IwYU5LRmFlNURZUDJDMyswd0FlaVUz?=
 =?utf-8?B?ckh1TEJvU0pZMHQxSmtTZ3JpeSthVlA1ZlN3L0xMM0VPYlZsQzRLNGJ1RGZC?=
 =?utf-8?B?TkxoeUlyWHRYQm83VlZlK1FLQXpVK0R0aTBhS0F5eXU5eldqMHNtQTlNSGcz?=
 =?utf-8?B?d2xDVlQvTFVyRXh4M2FqRlFTMXNUQWdGWkdlUDgyTTcyalBuTWhjWS8yd0k1?=
 =?utf-8?B?Qkh0SXJBU2grMUZqV1oyTWdCK3NjUjcvVmN0Y1QxcU9sUHN2dEd2VDhSYk80?=
 =?utf-8?B?V29CYkRqbmFVNGZUSWc3WmxIa0FRTDZkK0lHLzNpc0FDTnBGQWt5MFJLaEZz?=
 =?utf-8?B?RHZsczNBRmUrSHZNV0ROcGN0dVBnaFZRTG1hTlJCbGlFRktDQXVBRDgrRTM2?=
 =?utf-8?B?SnpOTEd1bGg0SU53T3VLV3VMV1FyWVU4NkgzUStwNzk2dDZORjU5UGNXZ1pk?=
 =?utf-8?B?bWJwVUpaUVFnMFNIMWMrbEhiRUdwYkpSbzNnaVZkVzNSNG5kWnJIcW1xejFI?=
 =?utf-8?B?WDNCVmcyZVZKNnM3WGxHbWQ5bE9vMEkyVmk2OXhWbGVEeGFyUjhmRzM2MG0z?=
 =?utf-8?B?YVRtNVlLRHhaUm52dEhiVVhkVldXS3pEbmNGTlIrR1FpeXFjWFRuTFJteDN6?=
 =?utf-8?B?Ym9QcTdmN1RoeHBPWUZ0MlhaTHlTNkI3alAvVWc3UThFdVp5dlhTNFNvZi8x?=
 =?utf-8?B?Z2xIZmw3b2JKRGpwenJ4dTI2bWNNUEJtRkdjZ1R4U29ZTmZwVUtZaTBDTjlJ?=
 =?utf-8?B?bEFLeWpaTWxuYkYvSzFyR0g2Y3YyTzVIa1ByWEttVDFFQTdTS1BzeFRrZGd6?=
 =?utf-8?B?RFBEdWlwQTNOaEtEUFhjdTdOQzM0Y0pKaDFMRE9DUWdveHBvS2pVV3RpNnpU?=
 =?utf-8?B?aWdaTmtDTi9Da3IxVjRRMlYrUDFldVhzQmZWUERxdEt3YitPRzcwN3lnTW5j?=
 =?utf-8?B?Y01oUUMxaXUvWVE5K0JjQkYyOUVtWmhqWlgyTlE1TFNuOVAzbVVkd1psL0NR?=
 =?utf-8?B?S1oyS3o0Z2xSeUF6UGw0eXIvaXd4WFMwVXgyQ2hsVkdwbUI1b0x2aWREeC9j?=
 =?utf-8?B?NFI1SktkdHZrZk9zcTdVbk56RGRpK0FhWDBQZVEwdzM4QUY3SDRsTm90aU9G?=
 =?utf-8?B?MjQrVFdXRDU2cmlZNC9ZVVBBSlZxWm9TbXAwcTNmcDNUejJwZDNML3FqS2JS?=
 =?utf-8?B?OXZsYVo2NXo0OTRDUHZ3aER1d1o3WGhnd2ZGajZvUlFILzN4dXg5YVlRU21W?=
 =?utf-8?B?MjhBTEFIbTVsQUFDOUp4Rmp3WlVFSFgvSUtLMldhR2VqYWU3bHpmODg2MnJ4?=
 =?utf-8?B?VVVhakVwT1V6ZGtlVDdIR2pLOVlyTnN1NTU4SnRlZ1ZUMTNXYTFydms2d29E?=
 =?utf-8?B?UklRbkRXS3JFbWRRbkFVMXNTVEpISVNlOHFoL3BVcU01dUQvMWV0ckZPejdn?=
 =?utf-8?B?Z2dTcys4eTBDN2pyekIrOFI1bGljL1hBeG94dmpLbXpBSkFad00rNlhEcmto?=
 =?utf-8?B?TlF1aTZNV0JuWExSUitCVERhSnE4OEx1NndPUjVRQUlWck1GWEtqY0wyQzFL?=
 =?utf-8?B?MHhoSXhSdGh3c1kwOEgwbXNJdlNIV1cwVzE0YWpZV3h2cGJBSFB0VXZoK1dW?=
 =?utf-8?B?WmY1eUd5VDEvczg3RmNDOXZFMldQTWVHUmJpSkZ5NkQybXczeFZjLzVVOXhP?=
 =?utf-8?B?NzVHUkFhellVdDRUSjd5SWVTbTBnSEx5TWRwbWlXNjZuNnZvVzdUa2lhRmhZ?=
 =?utf-8?B?Y1RmeVRTSkVFdlh0enVPNXpudVVETmRKWC8rT3FuSFJlZS9qTk5aMWZRWDBS?=
 =?utf-8?B?RHYrdEpoWVdGWXR3Z0xpUkpNVjhnYW9HYTU3OUI2MDNhQ25MQm9mWnBZeU1p?=
 =?utf-8?B?MUlQVDE2bHc1TjZKZ3lWZTVDSCtCMENxN0xkQjV1RSt3bW5KbXNMZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a01c771-98a6-4331-a9e8-08de936a111e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 23:21:29.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEufMbD/ngVZXt809TggEtmNAFdBEImOmti1ZbFQ3XEwzFNrfKjBHweFHEDYP9Ex0uCqMkgxXPZi2be1epVOvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5602

On Sun Apr 5, 2026 at 3:55 PM BST, Alexandre Courbot wrote:
> On Tue Mar 24, 2026 at 12:37 AM JST, Gary Guo wrote:
>> From: Gary Guo <gary@garyguo.net>
>>
>> Currently, `io::Mmio` always represent an untyped region of a compile-ti=
me
>> known minimum size, which is roughly equivalent to `void __iomem*` (but
>> with bound checks). However, it is useful to also be to represent I/O
>> memory of a specific type, e.g. `u32 __iomem*` or `struct foo __iomem*`.
>>
>> Thus, make `Mmio` generic on arbitrary `T`, where `T` is a sized type, o=
r a
>> DST that implements `KnownSize`. Similar to the `MmioRaw` change, the
>> existing behaviour is preserved in the form of `Mmio<Region<SIZE>>`. Thi=
s
>> change brings the MMIO closer to the DMA coherent allocation types that =
we
>> have, which is already typed.
>
> You probably noticed, but the regular `read8`, `read16` remain available
> irrespective of the `T` parameter, allowing the `Mmio` to be accessed
> using both the structured type and arbitrary primitives with an offset.
> I cannot find a reason to label this as unsound, but it might be
> confusing as it makes projection an additional capability on top of the
> existing raw I/O methods. This might be worth mentioning in the
> documentation, or maybe the primitive accessors should only be made
> available to `Io<Region>`?

Perhaps I could add a new `UntypedIo` trait which is implemented on
`Region`? And I can restrict these methods to be only usable for it.

I would actually prefer to just remove them, and say you should either acce=
ss
via projections, or via register macro.

Best,
Gary

>
>>
>> To be able to implement `IoKnownSize`, add a `MIN_SIZE` constant to
>> `KnownSize` trait to represent compile-time known minimum size of a
>> specific type.

