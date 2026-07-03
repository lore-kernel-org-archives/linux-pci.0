Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A583D332B;
	Fri,  3 Jul 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084186; cv=fail; b=fM+3c/C8cdWW422Q8nliokmeT+jGwnQjj4+hSy/XChFlVDaLq8IvfaxvtTXtWclUwTfcfV1V9b5dfMEHon5fe1SKNVPvjHMm8tE0Zk6vyV7ItLC9hEIxKLAtOwdn4V/7M8QAyK/4dJB783mMYup/KyztXh8jdqWPPJyU+CfZMfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084186; c=relaxed/simple;
	bh=84I65HPOg4j5Xpbp7xxzJcA7HbjYThmuEyHUzKxSzkk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=tLyVUqL7auJg4Tv8IMTpDQDEqYkCLaseLor39OhsAjxVTzug77HYMT6t2Au3u8WQMcVacBrIpo4dmQjspTWIl9d/wRMbrS83ZkMRrIXSMV/yhWc94kUgdl3CJ10E7UiKOtIbmXEjzBqorgVVzbpyKrsqXBe90fsIyowvNJ0l9kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZpF343+w; arc=fail smtp.client-ip=52.101.52.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZpF343+w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZzU390RWBlMsyEwj1Y1zkz3xmV1kJGaYaiYU3pDtLgvzSGcTKOdJ3y5QjkX7nbvRIWG0yVJqyrbiT1E1Fwo9B4wF8TwoQ9puabfg4pXQd5Q7GZ20BZDUkWfv1I9MZKz0hucYpdT2ymh4Y0Po0UzZgHc9eHzJWuRbmSyF05gkdP0G6cQWPCyOlgrKGx2W8horJlApq3rTLsuAmcebNrzq4jXoUoS34Gn8mJJ3OrK5qH3bUaelD8Fgo29fav4cVH6lELPVYHaH3mYdeIyXbiFyrYGQaLurvprpOUvKpkuAOG6C6HixP4s+II9fgJqbETC9/bG+slzFNBI/yPgpv7QLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUdoVXhR1KCLlcPlse4qWTrVXJxj9PJc2TMpXIBHIDE=;
 b=i18P8alZaMUdgR9vFepUvSB9RT3jBQZqkeQgMm6jKIimbBGcG/wwsFiRvmWriin53oX/cFY4tHyb2aR0L/g+coc9v7kNy58Ek4JFNGSA/6QHczIeFcnFnCQl24CDOmKmws72H6/5ZP5oyWvjLJai04y4Wlx3rAX4NFDgc3K5QoIB+IUfEwstVcwjQUqLXjRInGiUsCuvJpmc05+zjou/yRj0hiHzxkZThOpahF0aeM40g4H/HTrUTahV9AixAzkgzzjvHBtYZCHdRZWEKkF1MH9bZ5B3DSC/zlN/MMxk0+je6WLy6xqRTJczPxmflZwk6FosNU9h32vHrWzw9YckMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUdoVXhR1KCLlcPlse4qWTrVXJxj9PJc2TMpXIBHIDE=;
 b=ZpF343+wqQFQJNCCNzIBFW3o7ysLX2sVeMKnzxqEtsyHgTHk3lDW6fbpa3Biuum1/HrfbxyDGqJfVQKIf1V2wddjHm3iO9fdyHeKS4vaA0RMAiQMnU/kaJRFquyY/vbtLfiHk4Z1iYKHcV5Xtxw5DcJPKIrfDgn73rBYbSeZpBpi6rOI+b5m1SkPyqREKHv42KeWFcnEhFECgfkyB+PijNz3hslYYu6KKyXLlxlsgsBmH22zCQfMeSXGsV0kfx41Fq96QSreV+yM/ojoKfNEGIYlAwFdHUysyxQ7/O/P4sSdOiZtOYNJKxpsYTftYMfGQ6VcUmzjq9w7zjbzaBseig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 13:09:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 13:09:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 22:09:35 +0900
Message-Id: <DJOYL5QPEM76.1N99BVDVHB8VS@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
 <DJOLKP1V1IDU.1GWHOHBG9CS7@nvidia.com>
 <DJOXUW6ODKCI.1GLNDU00TDJWU@garyguo.net>
In-Reply-To: <DJOXUW6ODKCI.1GLNDU00TDJWU@garyguo.net>
X-ClientProxiedBy: TY4P301CA0038.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: c85ed451-a422-408c-87e8-08ded904566a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	7sQk1l8o87Iw9xf2jUgXqBUuGd+xoISIMZhl0vIaVm1umHgkRKUHjynPXZccmOjffu297jsHv3FKeVep8HQsO2X58+qCi9QLEr1pYVL6oFU6kQLIzKCPe04obC99yDridq4Oh4Vns5baq4fPVFYtkfsdK7eTW68L0b9aFuxIZr2koPGlIYfdopwyTBArXfrTJNpF2lvnFvZpVTZqWpKCUgh+tGKt5x+LPdiQWkMc6LMj09Sspz0vFAmH9x0nSdCfIIZuxK2oiZBbTgHnlVxRNGcHXvk+c/isiMFACCBeSejP+5cVHfDtvGZWohNCfmIsLLYuDsci9qQOd4utXPWKhCQM+S9RqL6J05bC8EYdLUhJRsmpqtAqquGvfa6rw+U2ZJ6JoPfiCs/PEqRLHqLfDo8/AjkJQQa2QavS9Rbe7/E8ZoNAXrOahLrSjfdl1PqnJ/a7HEHJoF/LMaW6XOlj5asuI6dvG6tY9oBS0MS6RabfRBA2AizLVVrhak6kBWbkLk16kocTeXbQmK+uggJHlx2Sk0FFYsdn7qF/dr9ENpvlM/owDGUDzf3z99NIWbJpJ9xF/ty2zb8C9pFfWDlmurKuim3Fcy45FEjhzItNlsYHZcuY2CvBbYFYSEAWDGu9/RXBmXxGkEkNI6FghYgYRJs4mJ2ZliB/wI1il77vS8M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjN5eWhSM2RQb0NGSFNTNWhKRGY3Rk8zcmdKTXRRaE9GWTVUZWNuNnowUnJp?=
 =?utf-8?B?SXJtT0pMWVVxRGpNRCt1ZU9nWHJuS2x1SmJHS1FGS3VLZldYTTE1eXVRTTVU?=
 =?utf-8?B?cEYvRjJTQm9kT2duS3dia05WWWhpQkx0cjZPRDBldWIvMmhpYjBmWHMzYTJP?=
 =?utf-8?B?OGRqRmF0anRZTWlZS1h5QzhHQ0RDZlVFNThiV3NtMllLNWlkMURaLzN5RWp6?=
 =?utf-8?B?ODltOWZSam4vZDkyVUtyRGtJQ1hob1k2cFRZKzR3Nm5hU3EyY0NTdXA1Tys1?=
 =?utf-8?B?dVVTT2xYanZOcE1QcGEyYS90cFdqZkU5QzFzT0VGc0toRDVTRUFVaENrcjgy?=
 =?utf-8?B?S2Zza24vanJJT2o4eHEzL1B1SGM1a2g5Zmw0NENXaDJnekRGSXlXeWJVLzNX?=
 =?utf-8?B?ZHJ4MFNKamtmU2I1a3F2bnN4c0pmMVUxSHRVSTRlQ2dOSlVQTUI1ZUt2b1pm?=
 =?utf-8?B?dUVIWlVaNXUvMHFNZ1FDNEw5SVdsNFhxdVNxTUhNYklnNGpWcVBzeXFKaFpT?=
 =?utf-8?B?c2hRWEZuRnd6UW9tS3BXMzB1V04rUDJvVDRtMS9wbG5Zci9kWnJSVG1xejNv?=
 =?utf-8?B?dEVSam5VRFdINXVyVm0wemE2WmczbjRyTEhnWTR6QkNKMzVpTmhPSGczV3I5?=
 =?utf-8?B?ZGpIYUFNdzl3SG5TSGhxZlRlMmt1dWhEOGhjVlhaRi9ZWC9FbVpmcCs5Zkl3?=
 =?utf-8?B?bzBvZ3NxUE5vbGVCZWlmQmN5cXFoMjJjSlZxZHFjKzV4a3VuaFlWblZ4ZmV4?=
 =?utf-8?B?bjVmNTByQzEvSzhsNzJJcU1rV1hrUTYvVW1ucEk4QWVFRW92cEF4QlorbVQz?=
 =?utf-8?B?LzVuSWZiYTlSRUVHUDJqMTJLd1g2MjV2Tkt4dm5LNlcyVDRkTytkSTdoNUJN?=
 =?utf-8?B?cUhRVWo0d292S1F2USttNjArNHFhUnZPNWxxMVFMWFBnbGNlR2x1bnd0QjJ0?=
 =?utf-8?B?aEFBSjl2cXVhNXNsMEIzZGZRYkViTWx4d3JrS1RKQTRoYmpZZHNuMnFHL1hq?=
 =?utf-8?B?TnFyQWY4aTB1WlNSOWxPVFZTazg0V05MVEZPYmQyK3BxV1hrWGV2SlBrUWg0?=
 =?utf-8?B?dWdpZndyQitXZytSVUdHT3VxQU83a1ZYa1N4MzViRWsveGJoRndrZHpweUdC?=
 =?utf-8?B?Z1ZFT1o2azBPT1h0SHBzblFqTU5hWHV5eGlMVFh5TGFBbVJHNTk1b3FYdTM2?=
 =?utf-8?B?VU1WZUFGZHY0d3JwVlZDblJ4M3JsSGljR1pxenJPVVdNL3Z1cUpZUGJTZkJa?=
 =?utf-8?B?OVhVNGRHelBFRmNmZmg4OTZrRW1ZNlZlSHNxMkV4S3lWUlcyMG9neXdOc1hQ?=
 =?utf-8?B?YkQ1TUorUWpxakgrOGdqRFV1cEJpWTYrYmh4aUdjdXlNVzljRi9UcHo5WGFW?=
 =?utf-8?B?cmovSWV2N0VCM3ozeElvbEJEbk4wVlpVc2tWa1liMkFPWXYyQ1dybUdBbXo2?=
 =?utf-8?B?cURYbkZ6ZUozVFFkeDZuTmhrR1F6T0pMdjROMldtQTVhZ3k5T1RFamRjckI3?=
 =?utf-8?B?Z0Rxd09qZWF1eEFyRjlzWlIra2hrOUpIYUZJSkU0MkQ1b2I4OVppSVZ5aXNj?=
 =?utf-8?B?V0t1UVhwckRxaTRMTTh1aDBYbUFKSjEvU1Frc01rYk9RdkR3OTRVQ0dGRWpY?=
 =?utf-8?B?TUJnNDR1cGNvNUF4b3VjT0NOVFFOa2V1K3VWZnMzNWtRTmtJTC9HeW1ONjZi?=
 =?utf-8?B?WWhDMnlJSVpISnVNYjN4YXZ2ZEFURnVKVjRDbitHQXZ6blUzTDg4aW13YVRW?=
 =?utf-8?B?ZjRRTXNqMTFZZGN5ZWtvZVVrL29JdXR6dFhneWxBTlF4MU9LWmRES0E5cmZZ?=
 =?utf-8?B?WUo0YnQyZEdJODVaaEtpbjBNd2swQ1F0VlVCSVAxQ3RRTk1GRWE3endiNFNi?=
 =?utf-8?B?R25GZk55aE9hNWY4NmxRZTBSa0txTS8rNmFJUmpMOUN5U1NncGxvUXFSSTFJ?=
 =?utf-8?B?ekR6N044ZWYxR2w5dmoyNndnT1VUMWJSNVhxK3dZTTlsaitCMXBpWXBNTE1s?=
 =?utf-8?B?czEza0NYU3k5VHNraE9ORi9NMklxcXVvQmZLWnNPdFlxUE1vaERibXRHS0xs?=
 =?utf-8?B?a1h5dVRBeG9rUUgzWGQxOTFwQ0RheElTajhSdzM2ZG1DQmZEaTcrdkZxRWlx?=
 =?utf-8?B?MWV5RzBsdHN5WWVnWWZ2Sit0WHJFN3FlUXlINzdPVkZaazRmVWNqeGlhbnRK?=
 =?utf-8?B?YmN0QW1lL0orcnNQSXJOVFN5RDdCUE8vY3FqQk5Nb3AwOURMUHJvZnVUekhC?=
 =?utf-8?B?QlIrOVIydU96d09WQzNrOFFyeHEvV2RrNHd0cW9mNmQ5cW9Ra3lkenJlS0hr?=
 =?utf-8?B?NU5yM3AwbGtLbHV2WTJVblhvRVFTQ1RNelFBb21CcWFkd1VWUE1ucjdEMGpI?=
 =?utf-8?Q?ezalp+unb3jUCILG0gZjWz1PNLnISwE/31W0TFjds8NB2?=
X-MS-Exchange-AntiSpam-MessageData-1: pZg2sTayVpDHUQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85ed451-a422-408c-87e8-08ded904566a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:09:38.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jm5aVe8BPH7tNuyUB05hESYfIYQ8g01FcLec14718i04NTqMzLG3hIceEP2yQHerOD/o+amp0oAQvr/pV4ALpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903

On Fri Jul 3, 2026 at 9:35 PM JST, Gary Guo wrote:
> On Fri Jul 3, 2026 at 3:57 AM BST, Alexandre Courbot wrote:
>> On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
>> <...>
>>> @@ -309,7 +312,11 @@ pub trait Io {
>>>      // Always inline to optimize out error path of `build_assert`.
>>>      #[inline(always)]
>>>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
>>> -        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE=
));
>>> +        // We cannot check alignment with `offset_valid` using `self.a=
ddr()`. So set 0 for it and
>>> +        // ensure alignment by checking that the alignment of `U` is s=
maller or equal to the
>>> +        // alignment of `Self::Target`.
>>> +        const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Targe=
t::MIN_ALIGN.as_usize());
>>
>> With `Region::MIN_ALIGN` being `4`, my understanding is that this will
>> make `read64` and other infallible 64-bit accessors unusable on untyped
>> I/O regions?
>
> That's correct.

Isn't that a limitation we may want to eventually address? The fallible
accessors are still usable, but it seems arbitrary that the non-fallible
ones stop at 32 bits...
