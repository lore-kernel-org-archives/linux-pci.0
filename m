Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157421F3BAC;
	Tue, 25 Aug 2026 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787626677; cv=fail; b=N18rqIS1RCWfAwhCtn31hifCrdT2iaIegH2+p/kXYMFd4Jieec27vIQw6fe+0ikBYJngDRESntHOmcIvkXJWBuS/WPt9HPplV19iUYOTrb2eXGEvTndlNWZT8NHOsvjIjzvCbXtMcoZiZ2FfE+4oGN4xz+raPv4d7a1jJQPA+tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787626677; c=relaxed/simple;
	bh=iPPaL7KM5FC1W6P811FawAJAxYxdj86m9Pvopwqp2GQ=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=VmQfCPI7wsASxtpvDIzQ3TgMG1Os4pnu3Rcrpp48BFWTz7hxeNsy50UiM443C7U+GyzZu809Y465Hi3MLVwuP2CcT5pp0oedyZxkIo+e3ygF7GMKg/uQ9bBn50jo7Uk7lkoddXCETQKcvL6vFcD+VQrmqOooVvwjshKeZoCS644=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hvv8bzrI; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hvv8bzrI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0MCcGoESejVcUAWzM2iaiyO54KugszSMwieY35yBcdm1C9gUe3MQVewk2WLWUMgtwerYYwOj/5/8VbpIZadGMoaLenlk/WbvqMd9sxWRRzfw+a0z5R+hhfdZTZzY15etMDH3C3rIvXQ9sGOX9+EPNUNT+3lt2bSS9HE3K0H6E/BkBFe7zBbOQ/cD+je7HVIzCVMjqYz6PKx8KFHyVX9iR9SKICYZQQ7De1+CPpngP04XvMi5vENKtYkeLzj8hYks0nOpEG0Jv10UBqAq1blqkACO6cVDP+rpkFQu4+mxb5fyjyA4/uoQQqnYD0S6HbGJlwv8nUOPQgZM/iO33iLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYERGyICii4Zz5MucnDrkBuB9wOZcbcXELSegcOiLUI=;
 b=rAgAHA4LJSHd1RXfHMRhwHlDMR+vTNoKbLpxMEfrY9O0mSn2cVqwBdyG6n17lh9Tj36+gUK0AwMSs8mJLJqyq/FZTSXFD8BykFQExTvIIqtkmd1C9vg/d2HEoQ5wJSXMwtOMOUf22FmfYx2ROFaDUggM8kr0Rd0NQY1OwanffFKITAz1EBIQ1IaFIex9m88XB7hVYQdT4meZJaLAXAdNIWLUqkF1rt3ZK8ikw+aql+Nj9hoNLvOlzKXj+s7S57t9/meW3zbUa7nCTxxwwyGzCXw6GtLuWb+yt91ON/e5zJmaGmxnh1cGFs5fOfy1OVnfYVICYhLUJBCsyrDEXLTq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYERGyICii4Zz5MucnDrkBuB9wOZcbcXELSegcOiLUI=;
 b=hvv8bzrIyuh4Vw6HhVjD5ssuUJApxI4UOHnkDPmiS7jHsGqesQ1klbignwTums2P92dg0+dLQ1U8K59iMYzAUew/ORABG+Bq9rrqLUZ0yZfzGQ9MWH+/33vuKdQpihNNSU4Dt1MjR6a6Zlm+Cr9QNZeC3CZyqf0FbusaPiYKm5Jb0h6XOHDwAlTzP+ziyDaPqZWA/esbgcVfu6foEMBwOJa0X20M2uhUZjTzK8M8YZ0x8joQiNvsbXeqpLBCETp/Afh/qh6suZKyi4ZevKFAhBhcBGMKsWtJ9ib2a2/eujp3R2GsABKEkne5GlTmhKkS2MpRaa/d/pZjuA+gj/Uf3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:57:51 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Tue, 25 Aug 2026
 02:57:51 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 11:57:49 +0900
Message-Id: <DKXORMNLC1HB.30E2437W00ZHB@nvidia.com>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>
Content-Transfer-Encoding: quoted-printable
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>
 <DKX45Q1J5M9O.27TM3TUTQH761@garyguo.net>
 <DKX4P05VHT0E.2O8M39SOVBVP2@nvidia.com>
 <DKX5NPH3DNJR.2MADBU37NMZB4@garyguo.net>
 <DKX9YTDJLJMI.1RKDZ3S28MVQ0@nvidia.com>
 <DKXAHMEKAJPI.316SW0ICNRS0A@garyguo.net>
 <DKXBB60UMR11.2K7YBARWX33Y8@garyguo.net>
In-Reply-To: <DKXBB60UMR11.2K7YBARWX33Y8@garyguo.net>
X-ClientProxiedBy: TYCP286CA0274.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbc9ae3-21f8-49bd-8e8c-08df0254a72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|10070799003|376014|7416014|56012099006|10067099003|6133799003|3023799007|5023799004|11063799006|22082099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GS//oTsj7xs13icok2CW37jHeSLnBp84NXpfclJNPR+zCB9em5xLwoZMcSrtaXJR5uS6aMnjIplGJ9EJddusavpvknVeWIpe84kKbzH0I48/UrXUx5OnIWlFfqGXWObYbgm0qWfAIFQtvPyL8+V9HfwZVgc5BdRsqBcoMkxQdj4r1UNpoHr7k6pLo2QwpOgYrKuTKVZY83te9NVKQ21SLjE2JyyaAoi4sQoEwEIF13npNle/UqnwLxlQ+rvIcepQUqek2p0rSeUMugpIJg3dW7iZP1AifP8HI1+f1CeqsexCahjk47acAklzZtVIAr8yqPW34tf3pP2kt4qCEBL0DxWwCxHR9UFIAtFUwfmJgLnqF/1qnjbpucfWqYUpFmXd6gUA/v02kBUkoV7aKGz/RZYYoXrNm4oeiCZNkg7AXjkDBmrA7zmbqHjd5kmYNSCd8T12nuc9n6pg1Of7HNpc5Qlwuiek4t3jN7MP6i2YUBN/bVeqJ2IiMnge8REFGemxrCkjkTA2Lyj+3BKVwJMn8wLxhppDNNzji64UL3hodjZRCQD+ipOMdkPeeJ/xBzC1sWoLG36owRwLJMhzyxQ7kErjWssvLph13WpOWYzMTkLvMK9Mhhyf+6BpB+CKX45R0GapX6jmDuPW2ACNcHgLlJpyd5TFkbJufRILrhgf5IA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(376014)(7416014)(56012099006)(10067099003)(6133799003)(3023799007)(5023799004)(11063799006)(22082099003)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzFmRjQ1OW81NnhUbUQyTVBhbUwyZ0REMmZIY2JUb2VrbDlwTG9pY1Bqd25Y?=
 =?utf-8?B?UTFQVk85MXJGQXlaRHF4eU42cFE3M2FjaUUvOWo1YUhpVTZRVnhPNGNYbDR0?=
 =?utf-8?B?MnBkNmlrTWVnN3paSy8yV20wZy8yTk43RVkvWjBCdkdLN1h6NnVWbjB5dWVh?=
 =?utf-8?B?eEhZSVZ4azliekV0OUhCeG1GaVhlNXdLQ3dDZmFJYXJ5MlBZM0UvVXZUNEtL?=
 =?utf-8?B?MDZPZjlUZGJic2V1MFhmeEw0ekRUQWZqZHBycGpHanJXMFdwZWNhVDBzWHhj?=
 =?utf-8?B?RjI4eERJR3pjQjFXT1Z0aEF1UVNFbmwrdDEvUkdtZTZCSmJQR0phNmVxdThN?=
 =?utf-8?B?Qjl5YVdGcXBvbHdTSE50TDVGSDE3YnJObjE4bnAzVDN5WWlTalFDeFZRWStY?=
 =?utf-8?B?aktpL0RBcHREdmZsNTF4c2x2TlBUQmcxUTZ0b2ZLbzg3SkRqbWVMTG1ubXFa?=
 =?utf-8?B?Vi8yelpFTUprL09IQ2NMb1hseEZ3TWh1UlNYNEM5eXlhajZzMFM3ejB4M1Vh?=
 =?utf-8?B?b3Q3SENpRXJ2TW1ONkVuZzFMWEJGU2d4T2Z5OTFBZEZQQjFZVEVQNFFFY2dl?=
 =?utf-8?B?V0lQK2lJSnVXbTB1bGV6VnM5WSt6dzh6YjRlUnFSeHA4QXNWRmlXZXl6bjBV?=
 =?utf-8?B?ZWxydzd5ekJmeGlvdUpnOWYxQ21GekE0U3NETzVBV291TnhBS1BrS3ZBZzk2?=
 =?utf-8?B?ajhaTDNRTHE5emVKdFZEUitmVWVHTHVwTS9pV0JPSWJoa3RQRENmbjFGeThJ?=
 =?utf-8?B?ZFZJRVpuN3hCT0NMT3ZuaFk3R3BxQkNWdFZ2UGIwbVdxaUFkWnVFQXFNTFpt?=
 =?utf-8?B?ZXU2UzNxU24wY1V5ZGdXSjF3NFZrMzh5NHcrTWdZWkk0UkxmdHE2Q0pjc1h6?=
 =?utf-8?B?V2dNckpwN21aK3Y0ekN4TTU2Mzl1ZGYzdkhQaDkwR2pzcUpXOXFGQ2VQZUl0?=
 =?utf-8?B?aSs0VzNRYzMxb1h6bWFsazlBSDB4V0NOVXIyM0JrQURCMHVnbXc3SmpkODV3?=
 =?utf-8?B?VXkzaW5vRmdiU3RJYUo4UG8wczhMZ3QxZG8yZWVPU2o0ZG11dmJnYWVDTHBx?=
 =?utf-8?B?R09GVWg4Yk1UNld2aUU0NWptREVrUVZqYWJDUE5KNWZaOThuVHZZZnI5OVJh?=
 =?utf-8?B?S2JQOE9Ic0V2MGFUWDBabWR5QVBiZkk5M28wMkVrdXhkaGJpRnNkUkRnQlJl?=
 =?utf-8?B?Uy8zN2N3RHhacUk5MmV1bHZrN1RQeFNQYlZaaVdwL3krZ1lMSjhuVTJKOE1i?=
 =?utf-8?B?RnhRMUszR2lyYUJBOFhLRDd5Ykx3YlhTVGF5Q3QzK2hrNkNhM21TbmVTUnJs?=
 =?utf-8?B?WUdxMHRveFVDNWVoeUNBUXBOblFobTRwOVdhKzZMRWZtcTVPVW1UM0E5LzJj?=
 =?utf-8?B?WVBSR2JiS2Vvd0FkNldENjlzUk1TZTdjcmZnWmhrNlJVMDhpMDJVdElZOWxu?=
 =?utf-8?B?cm5MbXJZa2hvNjVGM3JWN01FU2tSRFJPUG1sYWNXS291bHZyMG9xTlgwMFhS?=
 =?utf-8?B?TzZycW44K094RVd1TjkwbzhQd1Q2OUdSV2pLd0lveXowMEcwL2NtWlh5dGRs?=
 =?utf-8?B?MzgydnE3Y25BVW82ZWdCY0lmanVMUkl5aTlaVjBoWXZERXRid1V6VXFJbDdv?=
 =?utf-8?B?UDB4Z2RlWXJpdWZGU1A1RnQrckxqRnBrMTdkaUxYa3hLRTJFWm85bVM2OW0x?=
 =?utf-8?B?b0J5alkzcGNzcjhwSlVDWWdiLzZSRk9HZ2M3ZUhwbkV6bTIzdmhXN3JuZlVa?=
 =?utf-8?B?eDhtak1vRUtzUEs2NXVmekxPQjU5c2FoVmpZYTZnZ0U2Q0NjUVZVTUF4VTM0?=
 =?utf-8?B?UWVRYmtkajRUTkFod25xTU9Fc25sMnpkRmZCS3hjSExKYkFJWUlFSFBSOGZD?=
 =?utf-8?B?UTdiKytNQ2NvMGdHaXI2bitRSExrRWZWSFl0WXBodE5vRmFMRVV5dlJCL3F2?=
 =?utf-8?B?T2lESHllY1N0WjZPamNOTGhMbkJnMGZUT2t2WldLWm44K25qeHRnek45SWkz?=
 =?utf-8?B?dnQwRkVBTWU2OUovbjBUcm5kMVkzb1ZBckd3WGZaUDBNNEJSQ0lnK1lnWXN3?=
 =?utf-8?B?emxrT3RXaU5kMVNpa1EzV2NNcC90WWR0Y1pHOEdrOGF5bm9nNFU1TkNMc0pO?=
 =?utf-8?B?Wm1hVVdsVXBiY2JZOERNRFJ0Q21LUlgyRTFiaENlMUVUeHlObEVHM0RiV2xp?=
 =?utf-8?B?eThUM3BHLzh4SGJZQjRzWVpTZzdNN09HRnp4MzhTOHNlQUJ5czdsWVRaT3M4?=
 =?utf-8?B?UzE0K3JUZzh2Mkg2VTBvN2VlU0luZS9RUGl2UC9LanZRWjBPK09MNEZGNFhM?=
 =?utf-8?B?TDlGengvVjM3OFQ0M3I4RGE0YlBxWnlkWHVvRG9mQXJJYzZwQklXa0V0OEpl?=
 =?utf-8?Q?JGKFse521KHMQD3bnvbDl3py9adPTZVi16bUKy0V7VTMW?=
X-MS-Exchange-AntiSpam-MessageData-1: 3l//1xzwFe6OtQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbc9ae3-21f8-49bd-8e8c-08df0254a72b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:57:51.6607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nk+Di9+L40dJKnmHaw1tVtsB+SVCv9mdFXHqNmY0gyvdWNaJJQ2oPrmpM6Loi+pdhwFUPKa/s+bdIO7EMB50Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

On Tue Aug 25, 2026 at 1:25 AM JST, Gary Guo wrote:
> On Mon Aug 24, 2026 at 4:46 PM BST, Gary Guo wrote:
>> On Mon Aug 24, 2026 at 4:21 PM BST, Alexandre Courbot wrote:
>>> On Mon Aug 24, 2026 at 8:59 PM JST, Gary Guo wrote:
>>>>
>>>> Aesthetic and ergnomics is a big part of code, and is what make people=
 like
>>>> Rust. In a world where less code is produced by human, I think it's es=
pecially
>>>> important that code remains easily human readable.
>>>>
>>>> You can probably already tell that I have very strong opinion about th=
is.
>>>
>>> So do I, and the fact we both have opinions on the matter is irrelevant=
.
>>> "It looks horrible" is not an argument.
>>
>> Ergnomics is a perfectly valid argument and often a key factor in design
>> decisions. Otherwise we'd make all functions carry extra argument indica=
ting the
>> context they're in and would require sleeping functions to carry such to=
ken
>> types. We rejected that approach because it'll infect all functions and =
make
>> Rust code look horrible.
>>
>> Everything is a trade-off. Whether to perform extra validation vs better
>> ergnomics is a genuine thing that needs deliberation. A outright dismiss=
al of
>> the argument is itself a non-constructive argument.
>>
>>>
>>> Safety and correctness are the very reason for using Rust, not that it
>>> looks better or is more ergonomic. It often does, it sometimes doesn't
>>> (see the hoops we have to jump through to cast a pointer for instance),
>>> and when it does, that is usually to improve correctness, not to
>>> compromise it. The reason we go through these lengths is to remove
>>> issues and footguns at build-time, and this is exactly what these
>>> helpers do because `as` is one of the footguns.
>>
>> There's nothing unsafe or incorrect in using `as`. Your suggested code i=
s no
>> more correct than Zhi's current version. You just added some extra check=
 to some
>> constant that will never change, and we know will not produce error. My =
argument
>> is that that makes the syntax horrible and it's not a trade-off worth ma=
king.
>>
>> When we create new abstractions, we try to make thing has minimal overhe=
ad.
>> Otherwise we'd be using a GC language and that'd solve memory safety iss=
ues.
>> Your abstraction is not zero-cost -- it sacrifices compilation-time, bin=
ary size
>> (for debug info) and it adds a significant cognitive overhead for writin=
g code.
>
> The code here is const eval, so debug info doesn't apply. And for the spe=
cific
> cases of functions containing only a single cast, as all instructions are=
 going
> to be optimized out debug info should (hopefully) not be left too. Howeve=
r,
> metadata sizes would still be larger because rustc record all inlined fun=
ctions
> within its MIR.
>
> Anyway, this is really more an auxiliary point, my main focus is on the
> cognitive complexity.

As it happens I share that concern - about reviewer cognitive load
particularly. Every time one encounters these `CAST` comments, they need
to re-compute the proof that the conversion is indeed lossless in their
head. I want to move that unneeded labor to the compiler. Whether the
constant ever changes or not, the `CAST` comment is still there, adding
burden to the reader. And many of these are generated bindings from the
C side, which *can* change without us noticing.

Now as I mentioned earlier we can turn these into a macro that emits a
const block checking that the conversion is lossless. The SRIOV constant
would then become:

    pub const SRIOV: Self =3D Self(casts::const_as!(bindings::PCI_EXT_CAP_I=
D_SRIOV =3D> u16));

No turbofish, a single macro instead of a multitude of functions, and
the name conveys what it is better: an `as` checked at const time. I've
sent a series [1]; hopefully it addresses your concern about ergonomics.

[1] https://lore.kernel.org/rust-for-linux/20260825-const_as-v1-0-1ce712225=
fe2@nvidia.com/
