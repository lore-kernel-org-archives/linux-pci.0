Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5523A5433;
	Thu, 30 Jul 2026 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423019; cv=fail; b=SGUhucM5GmsYhEem7OD2nB53elqlsy6IGUMW7iqmPi5zjNZvSN5+0a6BO53PLnYrmKtypbPYSYLoC0MWPiCXCARN2xitH6r5JEin+XxtuO9XRXPV6kxDqCA05HorwsjStTFDH64SvAFl30PZCtgN3/YUUXI63Qv6XU3XDphmYq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423019; c=relaxed/simple;
	bh=KpKm0A1+Ss6Tat8g06m1f6/U0fFGHEJXvedQPcvgqsE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=gN/pOnJ7UI2DVctQXncU/dAS+s55Yhri0OAh8A2gPmW/fw7Ivl3/UdPX0FyEkwHHdxRfAoRhAKAiM6shQ8buDit1n+G3vGHZkBepgAat3xZKDj8kbT/e36dGjVgd07l80lwdg8gl0o10uBYjC2Cb3JetFEc+vyumbhoodGwF5jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RecgZFDs; arc=fail smtp.client-ip=52.101.85.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RecgZFDs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNO+O8Qk7KgpCfQhhmD0X2Rw1iogJwWFvz6PN8UJNuOJShNNCp6kvJoBizdh1SEePg4imb0Trv4UBC0KmKe6VVZhlj3zfQMeNHcNk4N7H4GKFYFaj39mWytzkLZyrnnpl8/GzhY8DtjMoaUHrDadQr1XwU1gwGwbL3FP8qm2RMLVGHO9y4NsMfBWn2LYWRfuJD4RNg1kB0SVb5RnK03rKSguuvpx5x3vgU1ARD5OrAoONs7cEGnx02FtED2OCSIKKAxKGDzDRkGlEk2AD8JWV4NpnIix2J71IfreJQA7+1b3omsBQIkDVk08yKcQ7nYzGAAxt+k7KnkNw/lpHC4pLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpKm0A1+Ss6Tat8g06m1f6/U0fFGHEJXvedQPcvgqsE=;
 b=FooALEKYfn113affwrP57fXxiheC4pe7TBzpiGogESBR3ZMTuya4j1qdCPgGp2ibwdivxa0LkDlwBGshGJ1YS6lo+yGr2XDQaslArJTajVAkGkk4c2u8uAUvqlIEl7h90Pq2OrUygo+vdXkokSnuszdZIKu4dywKJCuVzZryrP6JGghqWeV6FNfAJCtQ/iGBtM97Edg/sJX62vaaWjAZM+kCmbG68Ht54LNDDAWkBiTENLSErmvac7tLl+iFvM7g3O9XRNBWUfTXpk1ZjljBSs+Juwlca5WAh7Ni+pJyogGVCnQJwwQh89vuFXQXsmgqBhLx0/RdRQTxKQNI30B4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpKm0A1+Ss6Tat8g06m1f6/U0fFGHEJXvedQPcvgqsE=;
 b=RecgZFDsHs89pKWN9B8qG8SFGGKYrNesNEo08IQudjfXDNBl+37SS8q001Ih/0wEeWpeB17mDL7TwfJb5ZB1UtkBeq2sGgvOqabzQw+rGHGsTAoz6VVQdQdPJBYTeNk2XUA7Pb/w2hmdiw0vTmI4jHxBiEWLjTsxQ0OzcB194GueBIPQOOCxqyIuWz5tDsOi1P1m3aA5LLVfatCL3GEQSdE3SaZWV8MoJKQ7PXMtfUMPnc1uyWuTwkXRZKCFFzyonnkyGI1TU8nDG0HhcYqbDPsZ303viij8VMYWhvA1delD9CszTX+VqJ0JD/BpFbxat3u218k9WmJcLFzdBETCqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Thu, 30 Jul 2026 14:50:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 14:50:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 23:50:06 +0900
Message-Id: <DKBZMU8RORN1.2KU656RXNCJ9Y@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 01/10] rust: io: register: allow explicit base type
 specification
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
 <DK6LF1ODPWC3.3QQV3SXQ55SXP@nvidia.com>
 <DK6U0LR7D57N.3FW1CZG9R42YF@garyguo.net>
 <DK93SOJQHSVI.1UCSJRLNZORJB@nvidia.com>
 <DK97C0MWLGFS.3D544FUPW2ADF@nvidia.com>
 <4c82ae0a-d424-4aec-8423-3efdf95fbf63@nvidia.com>
In-Reply-To: <4c82ae0a-d424-4aec-8423-3efdf95fbf63@nvidia.com>
X-ClientProxiedBy: TYCP286CA0210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ec620e-8fd6-45ce-cbf8-08deee49daab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|23010399003|5023799004|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HptDLJvUBui+Qi+9i/TctryOO7en4bm4bQ0DyAQ1yrhyHn+ihj05otUliObZroRjkO2gS09iiwWMXruu9fVs9qTrRO72nbdwvdICq+rYlSCfy6rgTWCw8KAQH4BO3flL5OCJAc7slMv/x2+9PBfmLAk3OuJFDtx6esg1nYHF1+3gKmM5KhPjmS8PfwcyWQcrbYCBa+o4Qh1NVCz12WxMMIrpURjm0HsiNVdcXbvwJoD4dINvwsmFdGxAaAGqVticmaCYmu05JfO774Gj8YyCX4doJs5fjjFlUpJpjuzyYYZ2Eh/r/Tm6nW+8sqRa/WPSiBY6BFCiresAtm+rDD1Uc0qT9MBiKF7xBBQ2f7XfGMeZNFotaQUyt5nw+uhdFppcVasNXgYJQOk1knLxv/Gnz6Uo8Amvm+XWlJ1AT6/MjBNrIE5vMUmrJ9qeOdUXgpvC6jIxqSA6rm3I0NN12LpsvjF5WgByTplUxSKr/fihwEsRyKwSvLv27J7/Wp06g735yL97Xd5BLsOI2qjJHQeEUZIoL2zzK1vpjx4YIYkspIdflckwmYvLa9ggmlBlM5sj4OTZMVXqxmNnBShsjCftFUiyTtmUap5WyK9HIpIfWycfHBmB9rk9JQlK+F1vkP1OCVnzK2nwyxrXhpaBuFmypG7q8GpaZeIO1aPfp1rAAnQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(23010399003)(5023799004)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d285dllORCtvWUJhaXdWVFVMMy9EZEg2WEpjbXZ6cGk1RmZsTXpvT2Nza294?=
 =?utf-8?B?OHg4YjlaeVo2cUQwL0I0MTJ2OUJqd0FHby9GenBPcVNCamdPUGJucDdqSEJa?=
 =?utf-8?B?Q1h0b0YrNVRGUU9VeUo3YjBGcFZIbmptZDJFekVzaTBPNEFCVmxpbWQybkxQ?=
 =?utf-8?B?bUpOWkdlWUFON1djL2F0VUlBSVQ1cng2NHo3TFQyYTVCZStaQkRuL0tWam0x?=
 =?utf-8?B?S2JINVNKRENXVGVQYk9ONEg1d2piZFdtZWlmUVA1L1hPYnhIcCtTNVJheVhw?=
 =?utf-8?B?YklVcER3VTFpRXRGZjRjN3IrOU5aSWU3SDU5ZGVwdDh2SUdBOWIzVWs2N1Jt?=
 =?utf-8?B?cm5GQmJlVGRyS1BOY21rNzRYSW1rWFhiZ095dE1DOThmWmVKdjB2SXNWY2FS?=
 =?utf-8?B?UDBhNmM2TzBYdWlCZWt3Vkl6RFpEUzE0SHZDdURqRmt1NFZwQ2xwRGpIdVN5?=
 =?utf-8?B?NVpBeVNadnlZbWszVmNWcE51dFpSNm1BVW9QK1hLa3d1WUF2TXhQSGFTM2sz?=
 =?utf-8?B?OVM2UVhid2hCRmVldERHa3NWSDkxaDlHWHZNRUJjTjhSYWtYdXNjcWpzbzhr?=
 =?utf-8?B?bEpTQXRmNEpicU1Gcnl0WUVkL08veXkzTjcwcjlTZW5tRnFLWVdmdXBBdVFE?=
 =?utf-8?B?elNOc1hkL1RveHlOVzVRUCtDOXJucE5iY2IrbDc5TDl5OVA4NDkzanFjdzEx?=
 =?utf-8?B?dmptSlVKRUhMNGlZd2oyblZ5KzJ3bE1yT2tnc0ZPZmNqY1RXNkl6dk9KUUxn?=
 =?utf-8?B?Y0F3d1UzWlNJaU8vcG9vNVNGcjdsOS9taE45MG4xYTJvMTRucGt0c3QvUk9N?=
 =?utf-8?B?QmFUWTlGY3JIMDVuWWhCM0VCS21GM09ZMW5yZGpFUVp2cEp0N25EeHYwRXhs?=
 =?utf-8?B?VTJwSHVlZlk4VFJwZEpZaDUyTHhPeEpEelpiVXNRZ0ZEODU3UTF2dUp4V0hK?=
 =?utf-8?B?U3ZCd01iUFY5bFNSTVFWZ3EzNTVocGZpcFpSeGFlM0YveVZndWgzSWRIdGhB?=
 =?utf-8?B?clZueDlXSnROSGd2blVvSzZkUFYvOW9ZY2hQQ1VtcjZkMTlXT3dGNlVkUWRl?=
 =?utf-8?B?ZTFGQ0xMaitRS2dIWFRTcWN0Vll2VU5Ka2VNbW8ySXJaZ1ZwNmtsemhwWTZH?=
 =?utf-8?B?VkNWbXlCSHdSdUJlVFlKTzJYYkNYZjRNdThYMXVxazdrN25FVHJ1d1RGd2Vw?=
 =?utf-8?B?NURERGs3T0UySWVXUVh4TG9VV1BUR2xHZFBvVTEzZmJIbXRRelowMjBOcUpU?=
 =?utf-8?B?T2NJR1Z1dWphMmo4WEhkVW80TjVrak1QT3hrNEVuQUlaUGtSVnZXelBSUVV2?=
 =?utf-8?B?WHVVWDBmalBCemFoUEVlSmNGa0M1MXJPYVF3cnJwakVLVkRkQTVRZit0eFV6?=
 =?utf-8?B?c2dqUC9pOGJHcXpteEM0aVdrUi9NeERuK1N6bzNkTHBTQk9CRWdrVWZBaCtW?=
 =?utf-8?B?VzRGWjZabmEyemVjcUxBZDlad2o2eW12aGo1V3VVSFZWYnY2bUdKRklvRENy?=
 =?utf-8?B?K240UVJjN2RESExxbHRSdmhUaVpSdW1Bby9UWnNnTUMyWmhadkJ1M2tlUU5y?=
 =?utf-8?B?UGxhUEVEWVdKNHZ3b3NiVnRlSmJ3M0NyKzlpSCtQOHZDdWFNZG1qVTNiNjR1?=
 =?utf-8?B?MDVWMllGaUpud1NnQ3o1MFBzeHhDRGowckZlS2kvNnFQUG0rSjFOcWU3Ym9a?=
 =?utf-8?B?KzB1bUR3WEhjRGxTcVBPSXVIYUhEUW05SnFWOTIrUjBGakFEWkZubnFFZkZS?=
 =?utf-8?B?NHVHOFVtaHNHRWJKSnI5WnJJVW51b0dldXdWTitMOHNlcXRTeEtXeWdUUGJD?=
 =?utf-8?B?UjZ2VWp5dVd5R3I4Yk1qeU9MN0NiR0hTOVA5ci9YMlpjVW5ObnJDam5qa3ho?=
 =?utf-8?B?Z2w1M3RXcVVzT3lDeEVzVnBEV0ZHL2dZUjI2V0MrNWJXakcweGNGTUFlRGlj?=
 =?utf-8?B?OVIvTHcyOUc4YlhkYnBkcm1NQTVNVm1DbVM0SkFnVlV3UzkyM2JldGl1RVdJ?=
 =?utf-8?B?ZWxHL3BTVDFkcCt4YnZ5RGZKKzhLN052VnVkZXlkRWphbkxIdUxrblM1N1JT?=
 =?utf-8?B?N1IxbnBhOUxFQ1hKSm5SaUZlZzVybWhuRkJZRmFTNnV2ZUNwV0luZVRUdTNa?=
 =?utf-8?B?cWptejF3bVpEbWVvUGZwVlhrVGVHM1VIWWpDSEwzNVVKTnJCOUZZbCt0eVNI?=
 =?utf-8?B?QW9Ra2FGWVFxbDBHVUtWNjVGSll3S05SckljbnZTZGFVRFY5cm1BQTRmZjNW?=
 =?utf-8?B?K1lBMUxnbitkbnF3TXB5bkgwSUZpV3BUaFc0RzZLaVJKRzRReFIrbGsrcU5W?=
 =?utf-8?B?d2NyWnhUTk9KRG5TVXlXNFN4d3liTFBMK1d0RHd1TkJGekxZWnFyYnQ0cUdF?=
 =?utf-8?Q?ZVvZZW7H6ZIP0JR2SuF44f8oHjxOmrIiS2Y0j5Njzhmav?=
X-MS-Exchange-AntiSpam-MessageData-1: S6nJzJVcEtxSQw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ec620e-8fd6-45ce-cbf8-08deee49daab
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 14:50:10.3549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ql8A/fCA8Z9wi/U7k4dfoo2+WMznvJibX3xpr2h8yIlyj0S1oPYD66iUtqi3QM+Q0x/1xKzI40IWFxVBIBwkXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144

On Wed Jul 29, 2026 at 4:12 AM JST, John Hubbard wrote:
> On 7/27/26 1:14 AM, Alexandre Courbot wrote:
>> On Mon Jul 27, 2026 at 2:27 PM JST, Eliot Courtney wrote:
>>> On Fri Jul 24, 2026 at 10:22 PM JST, Gary Guo wrote:
>>>> On Fri Jul 24, 2026 at 7:38 AM BST, Alexandre Courbot wrote:
> ...>> It also feels natural to me to specify
>>> the space that a register is in (Region), and you can decide what metho=
d
>>> you access that region (Mmio, other, etc). The cost seems to be that yo=
u
>>> need to specify some region on every register, but afaict you could mak=
e
>>> that a Region the size of the entire BAR0 space, or a non-sized Region
>>> and just have all your accesses fallible. So it's a bit noisy but otoh
>>> it's nice to think about what space each of your registers exist in.
>>=20
>> In the case of Nova that's something we might actually want to do: as
>> their name suggest, registers are split in large blocks (PBUS, PFB,
>> etc). And we are currently trying to move every register out of the
>
> Yes. The HW ref manuals have already set up an extensive taxonomy, and
> it's probably a "feature-not-a-bug" to specify which region each access
> is in, actually.
>
> For NVIDIA GPUs and other HW, that is.

Note that if we switch to this model, the register offsets declared in
Nova will be relative to their parent block - i.e. they won't match the
offsets declared in OpenRM anymore. But that's probably not a problem
since we can always look up the registers by name.
