Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021115.outbound.protection.outlook.com [52.101.100.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA826C39E;
	Sun, 14 Jun 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781458700; cv=fail; b=ILCsjB3Mf1rW/FHNN2IypyIuQyDOBrFExytNiKReRwUNEoCigu4BiCak4piUk6ejGUYdDPFjNhNC+rUmoFSSDjUMz+QxeiskrLl3YhTqxSse2VZDMS8176hAKp29JuiEvbWynmUzPsNsCqYrEsVQIbA8qa3zbNveepjkbzOoWWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781458700; c=relaxed/simple;
	bh=jzMrIuBSjHSodzEcLnKREp/eioRTn+Nbld3A8ehHJ9M=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=NslTVv9JfC+etEALRG1kYhCyT67b4RMTePLDHxymc7T4xTthGx1iObI53DWY88aTuc2hiBQ4ZumwTx7YZt9hKpTKrST0mDjvqOo9ZzFk1c/aVo5FK3Gl0QSt9Qf4NeH2wUXqf7SvjAQi/gGhpr4ZaYj9B/V7quXVGXeV0RqKCgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Mhb/vRKT; arc=fail smtp.client-ip=52.101.100.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Mhb/vRKT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJOMSrkoHAebdVe8ukCLXKoeFcxVZMimRCXILQYFtVIW1qDAgTQa6Kita2yRTvfSLTfm0R1r5ULTv5gcs7Mb0hK+GFVY2yGTgstZjFVcQcdz953MTcQpGnkbraidia9EVSFK8k9Hii7qz1wtWf1qU9ai16nlrFBdUUMdbLa4V1tcIUlyEXu5tl2NThTy/3xDOu83DFJhi2PVNGmHqIqVxnrM+tALvPleXvfp1159C2bSCR2Ry56xpEQ+QTHNPkkdAoZSX91UsXKf8YzAKHryqENq6A9I0ldX/QMcHERKNdJg2CqFeqA2VKamNP1G5DsEE0Vn86vIiy8osvvyjdGiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpCabv23NmvcGTfM67LdOeWm523ksEXXwdT8v5p5ZF8=;
 b=gE49uo71Ctu755mEyMEuWyCpD/YH0fHTiD35SCp9C/auYsNc9fRcMH4H6V7MTOb6Y6exPgSoK518+Mk8PzNNUxiX2r0uIb+rFSFYox93tWrUPLLVZOiSuH0Acb643i+Mkvp0jjt6fLa85Ahn9ZmhopPVWWAw3nQdOpQo5olVPBiZSPXrxBHLdm2mPgOv6ANhpFzNzoTXz9r114unB41KBaD9uvhK9DRNrl8FTTn+RXOfwkbOgtMk4WZ2NHM8mO/sWQc2RsdEI9bBAfINs/qREKGACj6OKestS6JCfMSAOTEZdBem2W5KlGi1sCupMB69UkpsjGJ+47CKe67cmXSxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpCabv23NmvcGTfM67LdOeWm523ksEXXwdT8v5p5ZF8=;
 b=Mhb/vRKTk214c4xPUS23ZrAY1gCFw1flmA7trzhM1lezkJsI6epG8pJGwpphQ7OcXZ1oeUGQAp2mxSBDta1zhi1x+LX3IEZI9MGKNj94iCwo9CFeqVdv4wDGJNOhBVeMP9+FBAZlf/OHxm2tf67yOmzwM6JIohXVKfevEKzc+6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LNXP265MB2554.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 17:38:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 17:38:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Jun 2026 18:38:14 +0100
Message-Id: <DJ8YEIFVMQKR.SPHHI3ADO974@garyguo.net>
Subject: Re: [PATCH 3/4] rust: completion: add complete()
From: "Gary Guo" <gary@garyguo.net>
To: "Maurice Hieronymus" <mhi@mailbox.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
Cc: <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
 <20260614-b4-rust-pci-edu-driver-v1-3-e3f2471b595c@mailbox.org>
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-3-e3f2471b595c@mailbox.org>
X-ClientProxiedBy: LO4P123CA0458.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LNXP265MB2554:EE_
X-MS-Office365-Filtering-Correlation-Id: 12aeb187-522a-48e1-2a6d-08deca3bb6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|921020|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NMCqnh/7yZnKFFaV8bG8TNHQ48MkXofE4StNxNk67ZK6s8/eJdg00eklH1Pipl6ZVEw39wXXnLlVszDw4AaekT1JcalNsV4bgpuogqx/XwRdr4139CZ1Ju6YiQx0Ff3NbKJ0ueYbWbeoocMdAhRWcAaDXmDPOEWKca6lQiYUH/8EUgrag27lZ09IlXt9CyfBupCan0/IcIJFYAKw8tfotaZcWMfmEcwZeovl4rYOfvo/fhg+Tpf1yUyWFLvcH6LpNp24reBoplednAyUg/X+/8DOgtiLFYpWCqf6k2iUNtQQfSBE1CLUnUD6Swu3hOn/9JJYYFeBt9237Y5jSmlEhECjvrKM+zgstfIsfKAx33fB1gaWAcAwy6e6b9BUgKzb5pr4Kc2DcT0wkAqD/C2O0C7JPegpdXDLU6RQplmWEpiJuIZ0JEcM4I6fDttlILVM4vAQLPzeMO6rxKCvaZvBLYjqjXnVPP3GF/ZZKog6mbIpAgq2oARBUOEbX8tIUu73QiRJLvOJaWPIYoCPPK/ZQDlh/RLQdFwa3ePI2EWV0gVa9EAHM9CpOgNV40Bv6A/fxYlfPllAV7QkxSNaTH+1r2FyidvcWOIWNx8KKcvjD13XoN/pN6pTCyOG+7j4HZ4Di7MrD9hx1tPTSVHrFFqTWmA6r8Y5EFuk+BWeLNcUEmYrA0jGJCqdwcGFYItevopno/Wfjz+A+mWIATiWhn+PQP4vO7G8gKnqlIhEgaJAEh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(921020)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTl3bStwQ0cva3MvVkhQMG5EK2tLRS9ER2NFUzhydVpKVUI3YWlUODNkVHRo?=
 =?utf-8?B?SUprS2FZU1RzREQzVmM5TkloY2FtdFl1cGpTT2VTMzFMZC9OQlBaci9ESmVu?=
 =?utf-8?B?aTR5UFhzZkY3Tnc5VDVQQ3VtSXFrbFd2MmZ5SFFlOEdQR0NxU2JRK1pWUVBK?=
 =?utf-8?B?TTVJQ3FVdjg0T1hycW4vTmxZczhOdFFSSFNIaDBJN3pYK1RuNFpQa01lbDZD?=
 =?utf-8?B?cWFGdEJZSHdiaFhPVkFBclNhT3Jla0htZkw5M0xSd2VadktQWHh5aSt5QmVo?=
 =?utf-8?B?MTZLVmI2RG5nSWdqbkMyVE1LTUpxQXVEUDFMSGFZUUZBWTNnUVhwbFF0cXpQ?=
 =?utf-8?B?ZW5BUUtPMURWbjRITVk1clJrWWoxUXNLeHNhM1pZSEVIWXlUa0xYVi90TVo4?=
 =?utf-8?B?TW94QWRkY1hkV1lhdzI4M1hsNWswbVM3VzFnQUpxM2JFOFBhSGIrVFdmYVl6?=
 =?utf-8?B?d0JqWU95bWtYaVJsRGpwOGVTY0xwK3NRL281MWdlZm11YlNWaFg5YXFhSk16?=
 =?utf-8?B?OUJuNHBjcEk5SFhtRXRaK0UzVW5XS0Z2Z0RxcEJJZms0MXlRSCtQYlc3UXBO?=
 =?utf-8?B?eFZndk9QTTV6MENRbVpDV1F0amorUVlRVTgxeDJ2bERhTzF6SFErYmJ2cHhz?=
 =?utf-8?B?ME55M3lnZDJ6MVJPTGtWZTdRall2MWwxUVFmVCt4NEVadTk3RkIyTlkrZHBk?=
 =?utf-8?B?d0tkZHZPelZwdEdQNlhCWC9rK21UMG5CMjc1UWw3MTFIN0NqRWVHR3ZVckRt?=
 =?utf-8?B?dGVtS2xxRDVaTHIwTVpLWTBpUm5ieWFQdi9YUlp4eUJ1NmhJUWFHUU9BcDdz?=
 =?utf-8?B?K0hlWUNvbmdTbTJLNVc2aGlIMXcyeTdxR0FhZGkwdk8yUVg3SVFmUkFZRkg4?=
 =?utf-8?B?bjdEK0tTcGNDRndVcDJsdE54NDYxOUpCQmFEclJEYlNCOGNzNXlPYTByUDd6?=
 =?utf-8?B?NnFQaEZHM0VrTjhMQkQ2ZVJWaUJiK3pWTVNMQWVIS3ZPNUlBNWtEYVo2bE9s?=
 =?utf-8?B?RUhtSGZWdGE3Wmh5Z1J2dHFuN3U0alNnTnlOYVZCZWVzRTFOalByT2xBd3hN?=
 =?utf-8?B?VmdibEowMk5pQ0xLaWVoTmdVTFBoSFRKS0NEZHcvdlIzaUxuVHpuT1BQdGRu?=
 =?utf-8?B?TW9BS05jMzRlWnVCZGsyQmVoMnowZkZNRHcyYTh1MWZpbkxiOHp6M0RseThj?=
 =?utf-8?B?ZkcyNWhoR0J6bWZqRFEwOXZlVnF3Y0dPL2thcE9sSmlaY0grRm5ucmI0NzVS?=
 =?utf-8?B?MjNjSjhQQkZxOGcyVXY5S2ozay9lTjVPYlNJZ05WS3NsVkNuKzE2UlNJQnFy?=
 =?utf-8?B?RXFiRkdxK1JqRDVyUUxyTHNIdDdvMHdwREREclRsL1BTNTBmZzZWUUdZZG11?=
 =?utf-8?B?TGxlcTBJSzdBdkh6U2dVN3BoclVrQ2M2ZTQvK21aTUpicVdNSGdhQnZmdU5N?=
 =?utf-8?B?UzRDZldXYlpQbW5RbTRRRU9QdVFvMVowV3dqZHdRNWdTVUZ3S3NGdDJsR2tq?=
 =?utf-8?B?cW9McXphQ3FqZUVXWnJZZlRaN1ZjTnNscDlodTV1dWVtT0l2cmhuTCtoWVl5?=
 =?utf-8?B?QThBMEI0bTIyYzZkaDBZYkxYWmVWeFBDUWo2eDhRalR5T0FhRUtBaUJnc053?=
 =?utf-8?B?YkE3MlFiU3haWXhGbytVSGU1c0t2MGd3UkVGN0NtcENqSGY2VU5STnlhT21v?=
 =?utf-8?B?N1VoTFpkeTBLekRLRmJTbHFLYXJPS21qeUlCNkY0c0hnZXBHcHJqWVNUZEJ1?=
 =?utf-8?B?a1U2R1pTMkpXeUlTeTk3MkxGQWV1WVE2QVJOQUY5Zm82ZHYwSXJYWTlBR2dJ?=
 =?utf-8?B?Z0EzeGQzOGZWSzhaMjQ5bWU4ZlBEbnBwRFh4ZkVlT0VEZ1JVMGllNGlrcjBu?=
 =?utf-8?B?dWVzQjV4cHlGbnpTWTZ3NFdxMDFXTTF4N3VjbzZmU0FPS2NjTWlOY1hoL1lQ?=
 =?utf-8?B?bXBpUS9QVFNrUnVqbmRIY3hhdnVRUmpkV2thOGx6bnJBTHM3aVhrZkYrM3ZH?=
 =?utf-8?B?L1ViMjdtcExhL2RlSG5CUUt1MVJyaUQ3R3krM3JpVUpoTmlOWGRNZGVtYm1Q?=
 =?utf-8?B?Y1BqWkFpVHBlcU4wYzFmT1VhcnlGZ01KYTRPOHcvMEI0TXdkQUh2S3lEMmJk?=
 =?utf-8?B?bm05djMxWDNzMkZweDFJRzE5dU4rRWJkZFU4aURXaEdlcG1xYlNuWnducjV3?=
 =?utf-8?B?NTd5OWc0eDAyNlVoalRQbFV4eHNYYm1lUmZQQUlIcFJLK0dsUW4zMU9pbTJn?=
 =?utf-8?B?bkhvdXRnUWFEdTdIeXN1OE9tK2p0SFRseWR1Wnlvd0xnS3puU1U5amZMN2Fh?=
 =?utf-8?B?aU8vbjZ0NFJNNWppcUZEdCtkUWhJcjF5Q0hVdUpVdlYrSkdVSkREUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aeb187-522a-48e1-2a6d-08deca3bb6ea
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 17:38:15.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfPkd9r1TuzO9FJTqHj4phNdM5biWOUOEpZwZk50acoDoOe/Vb2ZnkGJRa+KTntjXmDQmnyoxaHVtsGEbBWXdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP265MB2554

On Sun Jun 14, 2026 at 4:59 PM BST, Maurice Hieronymus wrote:
> The initial completion abstraction only added complete_all() and
> wait_for_completion(). complete_all() marks the completion permanently
> done, which makes a single Completion unsuitable for signalling the same
> event repeatedly: once complete_all() has run, every subsequent
> wait_for_completion() returns immediately without waiting.
>
> Add complete(), which wakes a single waiter and increments the internal
> counter by one. Paired one-to-one with wait_for_completion(), it allows
> the same completion to be reused across multiple cycles, e.g. to wait for
> consecutive DMA transfers to finish.
>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---
>  rust/kernel/sync/completion.rs | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion=
.rs
> index c50012a940a3..b386b84222f9 100644
> --- a/rust/kernel/sync/completion.rs
> +++ b/rust/kernel/sync/completion.rs
> @@ -90,6 +90,20 @@ fn as_raw(&self) -> *mut bindings::completion {
>          self.inner.get()
>      }
> =20
> +    /// Signal one task waiting on this completion.

"Signal a single task" to put some emphasis on "single".

> +    ///
> +    /// This method wakes up a single task waiting on this completion an=
d increments the
> +    /// internal counter by one. If no task is currently waiting, the ne=
xt

Why does this need to mention about its implementation detail? The user of =
the
API doesn't need to care.

> +    /// [`Completion::wait_for_completion`] returns immediately.
> +    ///
> +    /// Unlike [`Completion::complete_all`], the completion is not marke=
d permanently done, so a
> +    /// single [`Completion`] paired one-to-one with [`Completion::wait_=
for_completion`] can be
> +    /// reused to signal the same event repeatedly.

Hmm, I don't think the behaviour of `complete_all` needs to be in the
documentation of `complete`.

On the other note, you probably should update documentation of
`wait_for_completion` to also mention `complete`.

Best,
Gary

> +    pub fn complete(&self) {
> +        // SAFETY: `self.as_raw()` is a pointer to a valid `struct compl=
etion`.
> +        unsafe { bindings::complete(self.as_raw()) };
> +    }
> +
>      /// Signal all tasks waiting on this completion.
>      ///
>      /// This method wakes up all tasks waiting on this completion; after=
 this operation the


