Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021108.outbound.protection.outlook.com [52.101.95.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120070830;
	Sun, 14 Jun 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455656; cv=fail; b=NaYmNYi0Cot2RQIUBQyrC2haAgoODep8K9cAkIcQzDGGoj3xgQvsAdj5nKhpAeLwdI1IbMJZ3HiCU+WkKt+4DQ/V+Sz8o+yCoMszJ5DQTPJDPbSvMvmCewkIV//V3kCk49wuulZMX/1NiH25bEPmj6GbxCMhy4jnkvYc1KyBrqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455656; c=relaxed/simple;
	bh=1vQ5MZvn0WFJVZrbCuae0wQQWKSRO/BdYaSzH42YiJ8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fjUL3a5a7kzi9oquMua0HFdvCYV8gglKXmWg2s7DOwCxGsY1PQ0SPsm6tCwYrDqPb2uioowb6gSAzGETb8K605wErIajDLDS7iMiAULYfnpC2A3c/2pI3DIsCNsqbozJ8xjn4nheRnWZd4oIWiw0/yY2tPgfCTP7D1rVuhG0KeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=t/91dph0; arc=fail smtp.client-ip=52.101.95.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="t/91dph0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq/prgGJjYDbwKabXeI8RTAdMaqjiab1Lz7NUJ+UrZUc5s+vFJitR0l6E6hlwSXgrNZwqUI44z+yg27MS+Z7ePztttQyT8PEXW5BBCVa17WheO2z9VvxSYg4J6OQ5pUoI+v1eTTfcE4DzVaLtACVCsRM/Z/Vn206bBmgbbY8YGBjri1QCfh2Q5ROv+ggARiFRjY7ZGiqDLgh1NSunw/R4siNDd+sHNWJ9FKLzYgJcQjpHRfNJmxud9U5fxq8ACq7dS0ZNka5vUWm5GYh7xI5u5+gE+rmyLejnuor4dmpL3F8L4s6PyDXPh2jWs90sYGizhiVQLrwZJWwJ6ldwHuK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QxSPpu+dgx9avKmQ8MVJQtUbrCMOM8mg13WA7QoZfA=;
 b=FMqHUMsleT6ndCZrLADlQUvZoZUkIzhMi6VFUQws5Zui71DTaP74OFFxa53zTICe7NsCNHc65ADES8egwRLN9Z7Waa0D6a6BnvZMfeGUWDkEAVnfmQwr4/ynkIXFJ7Rk7UT2UlH/7DYxuEnzFMVg1mbjSAbQVQZQ2xxvAp1VxATflMbWbnEPeGHLtI4Fd42y8QhTM8GoyWzXbAasBk57a0b+Z1r1HLQGwVEGb2HMvNPuNqYnpUWi8sYPDrkCOVzQgp2HNVQuMpNWPQ3PmAAmI86TBHOnoW46NIJN/DOBMeWSKTs/HFLPtOhtl0gfUSlvx1EdqES2XAuIT0u1KtsSXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QxSPpu+dgx9avKmQ8MVJQtUbrCMOM8mg13WA7QoZfA=;
 b=t/91dph0JQkVUz6gd2i0rTCwL3wryVOAdojMwgWcu6uEvtOxFya19ZJ6eEUdBImBKNjdEggEsvnm6OVVC2xHoDC/YtKcJro5VEatilpQwy4SJZIhpNyCmBJoycrkG9Gv88f8NoctLEcUfBNr6DVlpfXlLNRdcXB/mnkibgTi1oY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2649.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:14b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 16:47:31 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 16:47:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Jun 2026 17:47:30 +0100
Message-Id: <DJ8XBNXPA8N9.3BBS3GADLP5K6@garyguo.net>
Cc: <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] rust: pci: make Vendor::from_raw() public
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
X-Mailer: aerc 0.21.0
References: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
 <20260614-b4-rust-pci-edu-driver-v1-1-e3f2471b595c@mailbox.org>
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-1-e3f2471b595c@mailbox.org>
X-ClientProxiedBy: LO4P123CA0132.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2649:EE_
X-MS-Office365-Filtering-Correlation-Id: fab5a278-c972-4a7c-52de-08deca34a0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|921020|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vk6yA7LFsvVyUE7JbXmjkqy1qVeCsk9CkL9lwgZQP9Xhi7r3hYsNC4S719jc/Tp5HnhwX2eA/wa7vecD5YhUsZka2tZPfyn5aZlg/zcbFhqL8qbq5KPLu6rlLFqJ7dO8sWd704nm6aI1nDeEjNxOAPyWiXnozERrN+krx7bE9x17FqlixB7jE1tGb8Cv0NDIluzVEZV4lHFLxPJ4MEI1DJL7g2I9OjWimHE35ZSUpUGcivE7qSOPoO5Cb7Jzqutev4h4pLd7y5yx9URxAu8J/WdSA4F9NAp9eVFSZA3/BScvRRIGDy18b7pl33XTkbGWFTpt7IzcHfj1T3ZO9Sa3o6isnicJ6UoSSbEBHyjn4EWhgqtVFNW9vKNShKpM4GKJXboIoPr0VRg88IJt1p5eohKPEQwJLTNEDb44N+jPasbx3ntlNWCkIad4uOmx8+6RcEQS+5UR8VAw7sK+boC6MowuOmVzTB82RCMhBmPxzjqv9c9sShA59U16K2ZIIETvzDiVdI/60SxyNFjlfjo2aaSIRGRZ/KvISIFYx6ofZpb6Iwx/6hgekZ20/rExMCMK80rcxyo+kxDAxzLF8UjBy540SmbLSnMeOnOt4tULJ/4eF2qlzPElf5SqbUtOXwNSnFTiEI8c9ebD9/6ag8xyMKS8/VSLUSuuoXIVfnxPtV8bo0qIPGmoBiKHnATZyrcE2hVkacFXH/vbWf1rDtBBKRhobQnhoK+Sglsw/la6OSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(921020)(3023799007)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wlo1Wm9tZGFWSkhMaDU0cVpld2ZTRFZmcmFtMFJNaFJta3NycHF3TzAzeElQ?=
 =?utf-8?B?ZUpLekt5OWdwSEZpZzM3dmVIVzI5VnQzN2t6TDNFSG5XeW5uUTdZdHBxVlZY?=
 =?utf-8?B?UmcvVEVNTU9wU0FpQ29xblpQUWdzRDR2YmROZHhaT0pvK0x3TFZUZ0orRTdW?=
 =?utf-8?B?UXVFZXpRcEFtNFAyY1lvekt4V1FvZHpmam01a3kwa0plTXlVWk1xVXBkOU9Z?=
 =?utf-8?B?bDBMTlhJWnhDOTA4cW9tNTFsZG9ySmRGQzRzYkVzQ2VXQXlORW1FbFptclRr?=
 =?utf-8?B?TUNxZlVaSHpUNUZtNS80UkdmWE9PdHIyZnZtb29tOFQ1aDdyQmgraDMwLytT?=
 =?utf-8?B?R0ZPQ1FsVzEyNkY5aGlYaGR1MkRnYjZaczNwVnVyTjZKS3FzSjZGTE5GM0l0?=
 =?utf-8?B?RFphQ0NINTY2YkRIRnVDZm5UWUNRMTJRbXRTeFo1ak50RkVMU05hMFhLajh6?=
 =?utf-8?B?WE1RQ0FRNzc2Smx1QkliMGIzWEVJZENDTnJiM0FycDU2SXJkU0NrUzNlampS?=
 =?utf-8?B?bDU4eDkyY1B5ekR6eWpMT01hRG96MS9pTFM5T0t6YTZVQUtsUWZjSHB4STNn?=
 =?utf-8?B?TXRJcURsZHJBTXBUTSs5V1NHeTFWZXJ2eHVCbEpHakN3a3NQT3JqblJCZ2w4?=
 =?utf-8?B?a3VndzRpT2R2REp0QjZlKzgzdVNQQVl5YVlWTFlyK3JpTlBKMHNGcmFJVmtz?=
 =?utf-8?B?LzJtd25QRXRENWIwZUtaVWcwVjA2eEpid1F1QnZLOUgzM2xNaDF3N0hrbk5P?=
 =?utf-8?B?RVgxN0F4SzkvczEycEdVQmFBb2VGS29sYm9NMmhuUnpNaXArdllWak1LVkJZ?=
 =?utf-8?B?YXBYWDdKV1MxbjBFL1l3VG5jYWtOVlZBdG9iYXpybklnLy9OOENUdTFBWHFt?=
 =?utf-8?B?dWRSZWRVK1pmN1hoNHN6UnZIbXpZQXBmSmFva2VtaG53QlVuMWc1cStyTFg3?=
 =?utf-8?B?NEIvTFRmd0tPK2RvOUFGMGRsL0pRVDBuNXBjYzRpejgvWUd6TXhBZGhRM2Fu?=
 =?utf-8?B?NlgyT1VWRVFEN3FCdU5tSFFkOFVEaGx5OG1xVEpOaVRndmkvVW1HSlIxRWhx?=
 =?utf-8?B?YmEzcCtrc2EvUldocldGRlNxZERUem9iclF4akhJa3E0dzQ2TkpQaXZXbUph?=
 =?utf-8?B?eWNZdmRIUFNlOFBQemFxTDFoM3BUVUVNNjBVdTh5ZWJwT2pXNVVlbmJhMUI4?=
 =?utf-8?B?ajhwdU5UVnkyM05BMnZIamNIVm92VnZ5akpmMkRjajhNZWg3REdjZGxLL2Rw?=
 =?utf-8?B?RTRjaXIwS29FVmg4bXhyWEFCYTN0VENWVmZ1NWs2OHZBeng4SUYwZUZIWVlz?=
 =?utf-8?B?cUlVUEFNZUFCSjlhalh3d0VFSTltOU9ncWQvWWFXVTNRaDEweFpXYzlWUElC?=
 =?utf-8?B?c01HZzVoS2p1NDByWFZ1SW15Y2lOVGJFT2NwMy9iUkNzK0d0eFprT2JhWnd3?=
 =?utf-8?B?NEVCYTdnKzJ4djMwb1hLWVBRNXJUVUJTOUhVTURTbjBTbEZVS3dRMTNSQXhI?=
 =?utf-8?B?aVRHQWZoMlNHYzFySTN3YXBFUDRmbGlRNEpDaVhrc3Z0ZVVtYldtMk0rWVFt?=
 =?utf-8?B?MFpSS2dibmFWRWR0WEMzYjZKR3FJbG80aCtucjFUZ2VFUCtqc2hoSjRSZjFj?=
 =?utf-8?B?NnhFVmdYUTdZRlRPMVg4YTVpdE82d01PdnpwRGdHWmpzczlBbGRGdDkwTEhs?=
 =?utf-8?B?RkRBMC9rWjFhNXBjaDNhRkE3eDd3Z3ArTUFwNURVN3JMVVRJNWQ2cDVEVjBJ?=
 =?utf-8?B?SDBmU2VJMzQxY3M0UExUZGpqeS9iSXJyc0VkSWRZcllzNTJMWjdVdEo5VUNz?=
 =?utf-8?B?V1h6dU4rdElDWDhxRHE1cjRXeGgwZElYSXJ6TmVNZlVQM3ZMNG8zUlkwSklB?=
 =?utf-8?B?MzVNRFRHb2UyUUU1WVRXTUxYamdpS1hDSktvTnZXZ2I2U1k2Vi9icmwva1Nr?=
 =?utf-8?B?bWFLZjgvMnJoMmsxaE9IZDI2NFRvcDkyakFneHRDNWtBMXpFZmpWcGJzaDdy?=
 =?utf-8?B?MkF5dDRySG1RdHNEUHNhdldmU1o3YkdUTHA4QURvSU5KN3ZGdk9TTExSYkdM?=
 =?utf-8?B?blBVTnlBTm5IWFc5RFJSU3dMOWVJWXpHaWZSQjNLV0dqUTJmL0RnakxmMmRQ?=
 =?utf-8?B?aFJoT09qYktaQnh0U3ZPSkY3V0pVYWgrSC85OUhJYzFmN2ZGVU5BSjhVNUlK?=
 =?utf-8?B?SlZLR1dpVi9oRENrOGdLOGZuNVZVcm1iQXpidTBIbm8vUGRsYnVFbEVaT1d1?=
 =?utf-8?B?RjY0K3lYZjJHQTdWT3FKNjVPcjRnSmFoV3pSQXYvNUg1ak9Wd28vNUVjSStV?=
 =?utf-8?B?ZDlFTjExU0M1N1l0a1pSN2o1S0ZoMGo0czR0VUhxVVNQMlM2cERhZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fab5a278-c972-4a7c-52de-08deca34a0b7
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 16:47:31.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18soypqyuqR6gF+NtUnhxCgpKeIrs0h4S/oQdoe+u9tQLtxrasxfYFS60L9t2gJ7RG5SYJIVwEE9wiaozQy42A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2649

On Sun Jun 14, 2026 at 4:59 PM BST, Maurice Hieronymus wrote:
> Vendor::from_raw() is currently pub(super), so a Vendor can only be
> obtained through the named constants generated from the PCI_VENDOR_ID_*
> defines in <linux/pci_ids.h>. A driver therefore cannot match a device
> whose vendor ID has no symbolic name.

nit: quote these code blocks inside commit text for visual clarity
>
> Such devices exist. QEMU's "edu" educational device and the legacy
> qemu/Bochs stdvga both use vendor ID 0x1234, which is not registered in
> pci_ids.h. Per the policy stated at the top of that header, IDs are only
> added there when shared between multiple drivers; a single-driver ID is
> expected to be open-coded in the driver instead. C drivers already do
> this -- see drivers/gpu/drm/tiny/bochs.c, which matches with a bare
> ".vendor =3D 0x1234".
>
> The Rust abstraction has no equivalent escape hatch: there is no public
> way to express an unregistered vendor. Make Vendor::from_raw() public (an=
d
> const, so it can be used in the const device-ID tables built by
> pci_device_table!) so that drivers can construct a Vendor from a raw ID,
> matching what C drivers can already do.
>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/pci/id.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
> index 50005d176561..bd3cf17fd8de 100644
> --- a/rust/kernel/pci/id.rs
> +++ b/rust/kernel/pci/id.rs
> @@ -156,7 +156,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Res=
ult {
>  impl Vendor {
>      /// Create a Vendor from a raw 16-bit vendor ID.
>      #[inline]
> -    pub(super) fn from_raw(vendor_id: u16) -> Self {
> +    pub const fn from_raw(vendor_id: u16) -> Self {
>          Self(vendor_id)
>      }
> =20


