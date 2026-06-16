Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A41EB5C2;
	Tue, 16 Jun 2026 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569093; cv=fail; b=NMTSCgTr5mi/DWEmDMxn2OU6uAgXjKt1PqeFydPmCH23+k6/1RuOMS3QF3I+CQvMEIrEygFjjgXU7jHR2d3eJblYFewbzO1zPdFinS6KWu9qxTR6KwCP9gO8PXFHihhz0LWzkk8rjs8FIMsDZWrAs3zBD7aHOblN/wNn2kRhKj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569093; c=relaxed/simple;
	bh=V7qL6uvfgNM71zoL/CCk/VIr0lrYVOCO9idkSon0Y0c=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=W+cYJCiOcM1bMGyGMeDS8TN49E1bbU2MYodQUXNzTJI86UI4lNMbL41sJl9uEeMLI/IQYJthurLat656vZSPRYdKIyLrZLU7SEZnrY6afVbhunh7jMg8djRlC5tppMANnjdBvo9G/9tDCzl/z3HDpx4vqLlCbyNjz6562oCqHpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=esofZpSW; arc=fail smtp.client-ip=40.107.209.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="esofZpSW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyYQXvaXnxt8fTnLHJx4hA9oHj8u5uoe4jSXzSjMEabozhCWP1Axxzb9x88eaG3dX3B06Ll33xykcbz7UVyDvFy/08Ap1717WD28Kq0D1OSLo9JzOsuZZOicST7/ddm8IZDkNPFvX8GR7/v9GuI4wOoQbmmMYeMf0oulP8ozqjarF3MrUauqljp2oXGCZjOc+GN+gUgs3SeJWPCAervugCU7O4DlMr1tXMp2DSCDVFIr9bK3z+vo7eYh0flyH1gg78OhYmx1cJXhIfh1J6B6oWLMw73tkKoTX5fBE1a1WV+FVNcMcpT5IulahzVxnPrp2+FXBF+6NhYKUuTOX4UYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5VmGH8uIGPBQlP8Jqnq93RZ9Q1J9SUwU+PEMjXmABM=;
 b=qAgd6DgV/5kGTYT2AgVD9hJBLUgoKZG1j5/sbnbMqwEAkGBCkOj7RxVWcVmoOip5LIDoz/GaGIZV4AbZVN241yCmozcLJdk7+NDJ4MpY3mQ1ZTb6hcbq1DWdOD0rNPIdWcOk6WJ4CSMYwvO+TNte/hAkYghgO13KBvEItvcNsKZz0lJP7jMfw7Vlfq/VvrufuMGVH/vLeeTLzGnBgJW0pZXo/3P8GbcF8Dt9alrVbWg1E01WMcFUWCxHxLbEqAXmyxLXY13ZtF5iuzFKFaSDLdHUYwwfjTpGIzqwyMY6BJ/so0mwBA3nCGvlKZwPGmq/ssmIlcY0gQGD8xs8tblPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5VmGH8uIGPBQlP8Jqnq93RZ9Q1J9SUwU+PEMjXmABM=;
 b=esofZpSWtMIg/EJXMKkD6pkI0HWvcH+SiH4/s5DLVuzl1kg9Fhrx884e8Gd0Nt+1NCyi/+zL4aExqsr0nsgNOiKn7rOviE/MltBfNPaNzl7d9U9iOCiYK4ERJS/2cWSgcNoLexd3QnVuyX0ZqYBKfFhCiC8+kfHByZSM6Fy63irjKq9kLrDXXtBHEb6SKoavnIuM5lEAPrmCx+96JxTNFfX32yKY9c4ldK19u5QJlI7I4SkSDZFnnUntL6AuKXIhSwBh73MtVR8pty0Y27fmWmPLJPTRqS+AxsTONrMH40cvgKRGFbCJMUZUeH5SQkRnwgwuuaUZxuLE9R58Sqa91g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 00:18:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 00:18:07 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 09:18:04 +0900
Message-Id: <DJA1J6H6Z6CI.3LLUM4T35FXXK@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 07/20] rust: io: implement `Mmio` as view type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-7-1f7224b02dcb@garyguo.net>
 <DJ9PI9NEJ92T.3D0E90RPSCXA2@nvidia.com>
 <DJ9PXYB91UDG.3BV4EJJ10RIC4@garyguo.net>
In-Reply-To: <DJ9PXYB91UDG.3BV4EJJ10RIC4@garyguo.net>
X-ClientProxiedBy: TY6P301CA0034.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 5027fb2b-1a0a-4e12-4fe9-08decb3cbd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|10070799003|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	riMdNv10ZBdq9rQUQZ2+AospGh3/lf0lFAyMSiVSmVPExFk1AJMZgyOHw96IHgEdVDQD0aZe9haoFzcTGSE1met1BktfbBOdq7SyCExV+KLhz69Pblhn1ekQQSjrg66nMl+9fGu38BBLyukMpY4aPebN9tJw+t1LAK10VrC14kbpj3+5YCLY+oiEjTGY7V37gWaBG1SQmQAhivTWOCCxLlfoihQpMkT0kCTk9luU+ZYis+RoiyCbamAJGvh4jXB7o52t6q51XcwI2wzQ8KHt6jzmP27LtZ6q3TpEH22pQGb7oRtHo+m9ZHSq/8G4e21PpitlkPhALsOaVE2MzoYhHoC1vgOFdTBbnvbT+CJZg2DFNL/E8BGlbRS64XlhgLfGFhmqX3AqPGIlPBAQhcLahPPFcnXgu/Gnug3i+mKIJoOD2Dc9bzAgdGXIS35D+ae7SSC5oM/8clagaGQDs/rZ7kVUy/qj0bzxYa6hgk01ZVSLvz/+FF273BASIuivHAWoYQGpu4RqQoh20TmlziXOgugFvv3pYNS2Eo7sHs13ICyL9sjyRiKxtyVVntjngxkxz9wNZxFuOy3jEKoj+rMKsgtlrHd5DbGn23aJg+9jqomFdclvjOmRgj4cO+pYconBnLFGK3oOs+Aoru6SsH5pByijlUS1F/qvPxQrmo1h9OJpJ4f8za1qHPhI2WwAJi+A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(10070799003)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azRhZzRLZWtOR09FcEdIa3RYOU1jWlorRGorUUxDS1V4TjJPVDU3M1poRUZ1?=
 =?utf-8?B?dHNZVmZmbHZtUDErcGg0WUhtRk1Nenk2Y0trYnFXNVA0RmlZZ28wMDA1N01x?=
 =?utf-8?B?WklwYkg4MGU4OFQyeU9HbWFQVndyenU5V3VqcXRta3VQUHlJUE1hN0RVbTA5?=
 =?utf-8?B?MCtvSjRKaTF6RzJtdUt6U0xLVnNUTEh0clFKVmJRb1ZqK2RPSnhIUUZCMzVS?=
 =?utf-8?B?SE5la3BmVWZOVlVEQkZoNVJEbnZiWVdlWktXY1JXVG11K1pzNEd4S1l3MldQ?=
 =?utf-8?B?ZEVQYnR0NnJxWFROZ1VHTzFzczRZZk1Sc0wrMlNWek9zdmM3N3VwYzNkUFhL?=
 =?utf-8?B?ZVJWV0tDc1BndG1rQUllRlk5TysyMDRjeE9QYjhRV1RPMXBxOTI3VDhMSURH?=
 =?utf-8?B?bEdEUlo5SjVyZ2NxTWNETVREWFZrQzhCRWZXVDJKdHlRMEp6ZWRwVzlYeTkx?=
 =?utf-8?B?RzNpamlKUDZNMTYyNUhQVUVVSHhvblgwWWpHM1BORW9ucUZXRy9UazJuREFK?=
 =?utf-8?B?bFQ5V2RrSHp2eDBnbmJ5NUQvZy9USlJENkdHamY5MW1acXJZTGZtNENvOGZo?=
 =?utf-8?B?VGgwR3N1K3J2WDFFRXNRYWp4cUpsQmNVVXVJQlUyRW4zT2lMM0J1R05IRjk5?=
 =?utf-8?B?TmpNUUFNSm1iTC9SaE9HWGp5Q2ZOYy8vblJWSmVNSndZelhHWFJoZVg1L3pn?=
 =?utf-8?B?VFpsRTNxclRsMXVwakd3SXFWam1QYitLckpYLzR4QzhOZkcrU1hjeTlaN3BE?=
 =?utf-8?B?b0p2bWErS2hrQTYxZVdhZnNNMWR4Vkc4TkxUUllXdlFyajB0TWowSnJFSmwz?=
 =?utf-8?B?WVMwREFqNlMzT3Y4dTcyQnFNUHUxNWlrV1dsMzl2dHg0bUdBTjd3azNrSWhn?=
 =?utf-8?B?UDVEV3I5L21zL1o0aUE0TVhPWThUQTdFUW54amxRWmtpNUJwOGkxZXhSVmph?=
 =?utf-8?B?LzEvSTJPR1ZWY1RDc3dlcm1EUU1TZzlWM1h1MUNITTdIRVRKYUpwY2xoSS9a?=
 =?utf-8?B?cFlublk2SCtkNkNEdkltK3ZlanB6K0crQ3ZRcVRmRFFtV25ZOVIwL3BVblQ4?=
 =?utf-8?B?endUbU5YZ1JNNmNyUFBXYXRvY2hBV3U1cTFNQ2Q1SFRXUVRlQW8wUGZ1WTZt?=
 =?utf-8?B?WUUyYklaUW11MWQ0Z0UySnc5TDR5QzM2V3pVaHFDOXdnZXJaSmgzVU5JQlg4?=
 =?utf-8?B?c2c2QklwMUpnd2lZSW5MKzJQbDNVTFBLeEx0ZUMzNVBnbXNrVkhUK282Nnlh?=
 =?utf-8?B?R0xnblBxRkIxWTFZT3RMVVArcEZDaUJZWjJvQSt3MU5UWE1Sd05PM1NPVHpO?=
 =?utf-8?B?cWFvVDVoOFgraDdGWXdGV3Qybm54MGZoZ2d0aHNNV2dLMzBvT2tieHpnS3N5?=
 =?utf-8?B?UEt3RFIzeU5saW13SWgySEtwMTMybjUwWDBqYW9ZeTFqWWxDRUJXc0FHSXpJ?=
 =?utf-8?B?TWNINXhpT0tUT2hHMG14aFVwcUJuSGx6VWh0aGJNemRPeGRsS28zRHpSSWxn?=
 =?utf-8?B?QmxTUkNNd1p3MEpTcDlsZFduU2xSdEtsTXNDZnNPUno1ZDdIdVRadUQ5S05G?=
 =?utf-8?B?bldnc2dZQk8xU1IvNTZwZWNkNloraGtjYTBvcTdSaUR4cWpXSVVCR0xVa3R3?=
 =?utf-8?B?cVZLMVk4NVZreHRPVHdrelRDOWNNWml4eGxZaE1uQlJlb050UTJBWFlkODZU?=
 =?utf-8?B?Ni94MWRPL0crVFdoSS9vNUxUQTdFZDFDbjV2dHNDbU5BOTVVVWlUMEdDTnl6?=
 =?utf-8?B?U3drY0tkejYxVDBRc1VONkFvemNoUGxMRllvWmsrQVh2YWhza01LamlRNE9D?=
 =?utf-8?B?WXFxSStaZWtjZVBZaWlWTmtzV1NmNjRqRTBqdzZOSzVNRGNVRnplSnFQYUFy?=
 =?utf-8?B?T3ZYc3VzVjkxVWdZMnJ0WTBkOXVnQWtrK3VnZ1RtYk40aWJGNVFVTzJSKzM0?=
 =?utf-8?B?SlY3VWVtcVZCdVVxSXR4WldaV29DSkk3TkdEYVU4Yk1Kd0lXSkZpV1E2Njlx?=
 =?utf-8?B?OTFlTTRpUGI3N0xkMDN6OFNrRGpLdGl6bWkxa0pTOUlNYS9Bbm52L3pnVVlZ?=
 =?utf-8?B?ZnJmMzlNTWY0Tmh0N2J6S21rU2J3QkR5TXVrcWZpMnJWTHlVREhrNXBtNExu?=
 =?utf-8?B?NzRuL21OaU5HZEdyZ1gyVlloZlpSQ2k3UGgvR1k1RHFpajF2ZUxWTjBxQjNs?=
 =?utf-8?B?VlBXM09rYnoyMUR0MDBXczBqWFduak4yczZ1WXpYd0dEWjVHS2RVK2ZiU2Vv?=
 =?utf-8?B?SkJKcGt1UWNHR3NqZkxiZ1NpKzI4dC8yQzR3ejJEc3ZodC9qZ0ZHM3NYekx5?=
 =?utf-8?B?MnZzK2NkcGYzV3FjbGxPYndDcTN3bS9JYmZaVmJudnhRQmFIakV5RzNMUTNw?=
 =?utf-8?Q?FZvh2FPQktM5UjCVQFOmWN7hsQGhyCRjbWDiRnrgPZuRl?=
X-MS-Exchange-AntiSpam-MessageData-1: ALzDgrfJi23I9Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5027fb2b-1a0a-4e12-4fe9-08decb3cbd94
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 00:18:07.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ti5zF0L7VwVexAcIap/dC/16RWiUQnqkSqk6ydyr1t8aDDhcuWeJLkCoC8eDu3xENw0o8oIJ6BHgztm6h+wXvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

On Tue Jun 16, 2026 at 12:13 AM JST, Gary Guo wrote:
> On Mon Jun 15, 2026 at 3:52 PM BST, Alexandre Courbot wrote:
>> On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
>> <...>
>>> +/// A view of memory-mapped I/O region.
>>> +///
>>> +/// # Invariant
>>> +///
>>> +/// `ptr` points to a valid and aligned memory-mapped I/O region for t=
he duration lifetime `'a`.
>>> +pub struct Mmio<'a, T: ?Sized> {
>>> +    ptr: *mut T,
>>> +    phantom: PhantomData<&'a ()>,
>>> +}
>>> +
>>> +impl<T: ?Sized> Copy for Mmio<'_, T> {}
>>> +impl<T: ?Sized> Clone for Mmio<'_, T> {
>>> +    #[inline]
>>> +    fn clone(&self) -> Self {
>>> +        *self
>>> +    }
>>> +}
>>> +
>>> +impl<'a, T: ?Sized> Mmio<'a, T> {
>>> +    /// Create a `Mmio`, providing the accessors to the MMIO mapping.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `raw` represents an valid and aligned memory-mapped I/O region=
 while `'a` is alive.
>>
>> typo: "a valid".
>>
>> <...>
>>> -/// [`MmioOwned`] wrapper using relaxed accessors.
>>> +/// [`Mmio`] but using relaxed accessors.
>>>  ///
>>>  /// This type provides an implementation of [`Io`] that uses relaxed I=
/O MMIO operands instead of
>>>  /// the regular ones.
>>>  ///
>>> -/// See [`MmioOwned::relaxed`] for a usage example.
>>> -#[repr(transparent)]
>>> -pub struct RelaxedMmio<const SIZE: usize =3D 0>(MmioOwned<SIZE>);
>>> +/// See [`Mmio::relaxed`] for a usage example.
>>> +///
>>> +/// # Invariant
>>> +///
>>> +/// `ptr` points to a valid and aligned memory-mapped I/O region for t=
he duration lifetime `'a`.
>>> +pub struct RelaxedMmio<'a, T: ?Sized> {
>>> +    ptr: *mut T,
>>> +    phantom: PhantomData<&'a ()>,
>>> +}
>>
>> Is there a reason for not just declaring `RelaxedMmio` as
>>
>>     #[repr(transparent)]
>>     pub struct RelaxedMmio<'a, T: ?Sized>(Mmio<'a, T>);
>>
>> similarly to what the original code did with `MmioOwned`?
>>
>> I tried locally and could build. This avoids declaring `Mmio` and
>> `RelaxedMmio` as basically identical types, and lets us remove the
>> explicit `Send` and `Sync` implementations. IIUC you can also reduce or
>> even remove the invariant section as it is enforced by `Mmio`.
>
> This is what I did originally, but this would cause duplication for
> RelaxedMmioBackend, as now you have to do
>
>      unsafe { bindings::$read_fn(view.0.ptr.cast_const().cast()) }
>
> and the `.0` causes the macro not being shared with MmioBackend.

Since `MmioBackend` and `RelaxedMmioBackend` both implement `IoBackend`,
I think using `IoBackend::as_ptr` in the macro should let you avoid the
duplication?
