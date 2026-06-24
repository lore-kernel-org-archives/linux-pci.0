Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1153D6CB0;
	Wed, 24 Jun 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313207; cv=fail; b=MJQaxHYhZ/y7OPYFWHGqTGzr84hVTrUDX54CYEZ6bepRih6b1yQ5eGtobH1IeG51gTmzpiE24h1xFtUJMzU4v37bkIveMDNCTUWQfebdjLkXwFAEFhSnxNtPCUOJhov8Qg0oCCNIeYH/8hoQe09TjY8Y8/jQm1D3rX7ZITc1lnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313207; c=relaxed/simple;
	bh=cEssYQmw9j9l+0j33tOczJU+IGtUhx+ORxMEhcp5Loo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=inEA3/Rv6uOp6NWT2f+s1yzrMrJcXwlaScUCS0rcZRGhzJdyLItSbWudsKIxuxewLFv2aOBWxJuv7TemzE9sF3E11mnyViep/iEf1oUEfgFx7CPo2L6EdosQShOtdYDM3gChixWw5P4s/vSJ+55/Sm2txJD4p91E73MknEzIwHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KzBQ2R6y; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KzBQ2R6y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrf6sK8KNg60Fu6TJbOpLGqSIPahb7kZcroAIL2tHgrKN18KFDtZRdCgFnW1HM0rjuMa2JTcOk3CS3bMyeuXt04wnQK2UZintQcb7misSXNujWkZs4PmkEjQqI0jtoUD5oXWy8iAsJKtb87/Q5baCBI0QA44UDlrQJkGFzJxfwbRUH51JzaBMDkBvfT+7jmHwgWAGikPKNL+hhBc70xiX2lJCfc8cvoXZB/9a9g/kunY5XSqTJJ3dg1eYMrxYraic4QOIP1RNZ2Dq+YXZtOcjieUdwnlly6NGMfj8/a8L7K4b+RCsA/csiQNY7AVEHKRRNxZPciLYnXnSq3cyiIu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hduGgFMQu557gkiXlo9S494yyH198ntLFcawSWMGXkM=;
 b=il1eMZXyv0MVmcjjNYjpYG4IXiCF4e7vg69ZKNjbY6VKv6qUxnnS8N9Jal9PYaRrmMpXN2guONJWB+3/0JPXK9d7SJ+dkU5j6DjhvFgeYjlDQ9KSMSUOqJuwxJk9vXErpMFM4gUf7FIpNNyPJPwfUEMQwoFRpqUzGXouK8/L2SumD1w3ImuTxYo1bBI1id2d008CQQWIMw0QJmWW1Hy5axCEF/WybNJ/tGufHNwTlR2wUD3+CHllkIu0oV+5/XHoQdUB5/r37Vz4AcqxTclyCdcWb6m08PfoIpjxuUUMls7j6Udiz1lJpYf461MSCw/OLnMQcctOVXKogp2kYo6fAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hduGgFMQu557gkiXlo9S494yyH198ntLFcawSWMGXkM=;
 b=KzBQ2R6yGFypf0AcS/d5FDwAyZck8XNiYb7VcoiK0n9rGaxuTY5A/t899hNLPZSV9t9sLPD4LxgWA2l2dMM07Gz9/LOoRmRkEngPJW9ftNHH9AsZwZfSvt0mXkM1hcTuVOaTak68cAwyccKIX+2Qpefpq0LdeYUIRvT9GhdCHkb0o/hzRNILUE9lXaR4NKISBJjaLPW6OlL/GzGwIeBvREPnk/87TLjtvlhN/UsQZ9hyv5pFpjrYkTQtktUb/Vi7nwS8SW+o+Frw6hd7p5Ga4EE3QnwhrJWNom5y+tk5Mv9ki9XHB7bgMzMPxsPp3EWz+I1qci69Tl/o+fAe/OXW+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 15:00:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 15:00:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 23:59:56 +0900
Message-Id: <DJHDAQZ1AASK.14ATT70HTI450@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <dakr@kernel.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <joelagnelf@nvidia.com>, <apopple@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] PCI/IOV: Return u16 from
 pci_sriov_get_totalvfs()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "David Laight" <david.laight.linux@gmail.com>
References: <20260622194353.1308872-1-zhiw@nvidia.com>
 <20260622194353.1308872-2-zhiw@nvidia.com>
 <DJHAC9W05615.19MHKPF67OG2T@nvidia.com> <20260624143937.50499c29@pumpkin>
In-Reply-To: <20260624143937.50499c29@pumpkin>
X-ClientProxiedBy: TY4P286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: cc46ff38-a0bc-4f44-d594-08ded201430b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|23010399003|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/Dnl0DPea8RR3Jw6fUX1CQYHj02eAq1ouSQoBMTU56dtTFuUHIAe2b90DAqtqLZ9WyBV5p0VRzi+hYIC3l+b4YuSvhm5MCWslDp2IpigdXkjApv5bXpsxsfftrxTjv9WjFdlxlB4+SSm2OPzIH3zMwnjVxnwN9Wr2RLCvgcY6Be4+cvTYQ+r9/UHaa8C1+y6aSWVvLC+W7PC4cO9VuB7Epi+0cDSOWHP3mid2e/WyJeDylIQ1cu6kRKB3r1/V+0Cfq9RA2ya3e6nr2h/vdBNysY/wMlrRY2EcI5lgC1ABBQl2m5yeybNISIHj8vKoa5XN6z+t3cZmxspPhfk/s5BCBABfoijoW5iTd7bA+S3DPNg/OgS1ado6keNUGt+xpV4amUJMQXidmb8smXJISt6rXK7cScSWnMHxTbEt1OEpUkNndXQMeRG450508DijXdQz40EPzd1dBO5jGH5c0cyR/YdprWbR9XAC14j/Zca3FrEuXWfzlNd1XCAwjmhIm3MuDAz02AEc7eejLv8NNuPezVLg3RHy4rV0h9jyjPFq+tmz5seDSzp5plTyui0xx0s67Zh7RTCyEty/rUd4PMG0iqNH3l+Lkwnq64BDBZlv1Bj2IeYLnbd/1j7SYS/EgkrUj5R5xTZBCwh5g9X+KAY3c6y57fxuNYX6bq9TKBIBmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk1HMWxUb2FWQzdNdnVFTzdqQ3R2NzN0WmJsZzlXTWNGQ2s4YWZWN3VYZTI0?=
 =?utf-8?B?NFZ0MzZ2TVVDMUpVTjdZMHFyYjE2VnUxNjQ2NWFDWjMxOFRKcHE4QUlwZ2hk?=
 =?utf-8?B?NExTTEFLN3dGZDJzMmVUSHlqUDJTVGUrY3BLZlNFMlNuTkxFUU1MU0lqU2E3?=
 =?utf-8?B?cHdNTVk5UmhXa3JXajVUd05jc2hSVVgzWTlSTXFHWkJRcGV0Vk9hcER5OER5?=
 =?utf-8?B?anVWdGpzUEVkdXF2MzZacnRwSld5Q1NET1VpUUxqS2RDbmRyMkNxYUxmaVh1?=
 =?utf-8?B?K2c4am9SSU1URTF3bDl5NUtuMTV0eGtJc0hKeHVaUVZJM0R2WElUQVBYYTBM?=
 =?utf-8?B?K3V6K2RDT1lyMk5PTVNDOGlEZDd3R25PbDc4N2tvaFZCUGdEUHc0S001SGF5?=
 =?utf-8?B?Tm5PSEJDaHhvTmRRSGhHSUdQZnZFRVlSckwyS1hUOGFoZUxYYnBLdlg4amt3?=
 =?utf-8?B?QVFoYStKVGl4Y294NHRSdkRvVHRUOVAvODJ0My9sbDcrMGlaK2VhZlZxMkE0?=
 =?utf-8?B?QUQyUXpFcmZvdlNGOUVuaGVRTXVnRzEyR1pVVzdFdFZUUjZNL1NaZk9PYnFY?=
 =?utf-8?B?Y2FkanMwUy94Z3N5SE1NUDExaFplVDdST0lzejZ5MXpWQWFlcmt4bmdnVlcx?=
 =?utf-8?B?aFpOSGZtakJKeUJBT29BZ0gwbFc4cEdYanpmeVpMdlkrSW1IRGlDajBNalV6?=
 =?utf-8?B?Sll2ZTNrN3NmWmZIZHBNVlJQeDRjdWs0MWJ1UDBvTDNGMmxaZEJYdTkybm9W?=
 =?utf-8?B?eElZSVRscTJ1WktPRkhNUVdKK1J5d3RuREVQVWlvd0lXY1hjSWtyUUJVOFRN?=
 =?utf-8?B?T2ZPYWVJMjdmNzlXeU1tOGJndW1HSmNaRkFEc08yVkJURCtTcXIrMSs1a1RP?=
 =?utf-8?B?dDJJejBkYm1aRW1XTC9MclBpQTJsR2VVSkhGT1FkVk1EVm9pNWlxVUN0T3Jv?=
 =?utf-8?B?ZVFFL3JEY0U2VDNXYTdYRVRBVG82RU5DcngzWTNzcGVsOGwyOFI3bGdsUXpp?=
 =?utf-8?B?amRqSW9tM040cFFybG5TdTdKUmU5b2RFakYzcHdCNGhPZXVXR0d2RjBBMHFr?=
 =?utf-8?B?YWNPR2ZNSnRyOHB1WTIwNTBpSS9YUTJ0OUl4ZnhzbTNoRnYwb0NlZTFuNnJJ?=
 =?utf-8?B?ZC9PRnRhTHZrbE1zYU5jTEQ5bUlqblU2K0tYdExFcWx5Nk81S2s0OVV5bzQy?=
 =?utf-8?B?UVIrSFA1eUxtbmJwMlU5cU1pbkhmMUM0clJQZmZqYlhDUWRrRzV5QmlocU95?=
 =?utf-8?B?Wm4zb0phNUZKa1hHNGs2ZzFGdm5idzFvVjQ4K3R4K2p5TFJOTGxPTEFRL0ZL?=
 =?utf-8?B?cTVxMXcxTXJ6ZGtVbWl3UEViMHJFeDVsQk5Qb2NEU25WTVBiMjFPZlNtaVdL?=
 =?utf-8?B?SitMUlJ5R3hXelNqbVgrbTJHajI3UU94dmJROENRejhoYXI2TVFGenU2RXAr?=
 =?utf-8?B?K3A5RVFVYWc5ckQxVFZzQVNrbUFnaTBlNklWeExBMzExWGkzVElrNFc4Yi9i?=
 =?utf-8?B?WGdMcFpmQUllbGZZM0ZuV28zaGdLTjIvM3ZFT0pCdmROU2IwUFNUY2tGSWIv?=
 =?utf-8?B?eTAvbWpGWFUwRy9kTDhpK3BYWTRaaTY4VGYrU2xyT1lXT1hzd09zd0dBaTcy?=
 =?utf-8?B?S1FsL3F3bzcremV3bmV0RnFYSFFIM3Q3OWJKL0g3MFVFNXBSU2VRZFdRY0JQ?=
 =?utf-8?B?UFFwSFQyT2V4ckNhZlV0SHBBZVpjNnVqQUNmUnZpeEhBOE82NHBhOUJrMmRM?=
 =?utf-8?B?V3B4UlU0SzZYVnNRTVQ5SlhmcE5vYWdWZXU0TERHWHU0VXRIa3I4VkVqNUc4?=
 =?utf-8?B?MlZXajh5TGtSNzVmTGI2MmZ4SWF4QnhQcmtIRUdtY2x1VXdwNnVYanFGVFR3?=
 =?utf-8?B?U3Y3VlVzdEMxTkdWRVFrV3BFaFRPV2tGbks3SnBBUjBpQnFhaHJqTWgyVTMr?=
 =?utf-8?B?ZEZXVVBPWXdnSFBuMUpGMGs4QWtaQnlrL1pQWVdEZFFOM25yR3F6aStGMW5X?=
 =?utf-8?B?OTFlRkQ5Q1cvbFhQVTdEMjdVTGJXcWJMcmRuS1JIeWR6blZGV2hyVEhKc1M5?=
 =?utf-8?B?cUhFbUlxOEppUkR3N3VPYkdBanIrVGRlVzRzc3BtRHI5R2lIMDZyOGlQRytW?=
 =?utf-8?B?Q2plNk5kQXJjMXhmVngzVThPNXpEYzVacUJiQU1XSTY0dFNVaHEwRVlEQWhs?=
 =?utf-8?B?RG1QWmJoaUZsOHgxbUNXd3hzaGE2NFM0R2lod2pRMmZtR1locTVUOXAza04x?=
 =?utf-8?B?VjI3cGFucWJncmwrdmQ3Q1A5RjJhcmNna3NLdzU5Q1k4dWRHNUc0U09SNjJG?=
 =?utf-8?B?bm9iem5qVWN0RERybmJ1SkN2TzRwc0s2Vkdta0kwTUYvaWFHWWk4M05qM0p3?=
 =?utf-8?Q?tkTo/Bq6NonXjWPxpC9mst8eSpvWn1e0h1DVZQQwy2qKo?=
X-MS-Exchange-AntiSpam-MessageData-1: 1MbUCI9eNz255A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc46ff38-a0bc-4f44-d594-08ded201430b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:59:59.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQyjNwnsa1COVLWTGVxmivCuFVO5cvE0WxsykVI5tlnRXZ74YSZP1WbQhmIhI1uzy7TMTsJzGE92b7YzBBuYCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484

On Wed Jun 24, 2026 at 10:39 PM JST, David Laight wrote:
> On Wed, 24 Jun 2026 21:40:52 +0900
> "Alexandre Courbot" <acourbot@nvidia.com> wrote:
>
>> On Tue Jun 23, 2026 at 4:43 AM JST, Zhi Wang wrote:
>> > pci_sriov_get_totalvfs() reports a VF count, not an errno-style
>> > status. It returns 0 when SR-IOV is unavailable or the device is not a
>> > PF, and otherwise returns the PF's driver_max_VFs value.
>> >
>> > driver_max_VFs is stored as a u16 in struct pci_sriov. It is derived
>> > from the SR-IOV TotalVFs field or from a driver-provided limit, so the
>> > implementation cannot return a negative value.
>> >
>> > Change the declaration, CONFIG_PCI_IOV stub, and implementation to
>> > return u16. Update callers to store the result in u16 variables, remov=
e
>> > obsolete negative-value checks, and use unsigned format specifiers whe=
re
>> > needed.
>> >
>> > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > Cc: linux-pci@vger.kernel.org
>> > Signed-off-by: Zhi Wang <zhiw@nvidia.com> =20
>>=20
>> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
>> Link: https://lore.kernel.org/all/DETDILPA1GFY.27WND0TEC5352@nvidia.com/
>>=20
>> > ---
>> >  drivers/crypto/hisilicon/qm.c                   | 8 +++++---
>> >  drivers/crypto/intel/qat/qat_common/adf_sriov.c | 6 +++---
>> >  drivers/gpu/drm/xe/xe_sriov_pf.c                | 6 ++----
>> >  drivers/misc/genwqe/card_base.c                 | 6 ++----
>> >  drivers/net/ethernet/cavium/thunder/nic_main.c  | 2 +-
>> >  drivers/net/ethernet/emulex/benet/be_main.c     | 3 ++-
>> >  drivers/net/ethernet/mellanox/mlx5/core/sriov.c | 3 ++-
>> >  drivers/net/ethernet/sfc/ef10_sriov.c           | 2 +- =20
>>=20
>> I believe that you can avoid converting all these drivers in this patch.
>> The implicit `u16 -> int` conversion done by C should result in the
>> expected behavior, and it will be fewer Acked-by to collect.
>
> The generated code is also likely to be slightly better if the function
> return value is a 32bit value.
>
> Similarly you don't really want to do any kind of maths on local variable=
s
> that aren't 32bit (or 64bit on 64bit builds).
>
> The fact that the domain of a value fits in 16 bits doesn't mean that
> it is better to use u16 - it is usually worse.
> Pretty much the only place u16 should be used is to reduce the size
> of structures.
>
> So it is probably correct to change the return type to unsigned int and
> remove the error return checks, but nothing else.

For C, I agree that unsigned int is the safest type.

Rust otoh does not do implicit integer promotion, and making it return a
`u16` carries useful range information. I wonder if we could have a
private `__pci_sriov_get_totalvfs` that returns a `u16`, make
`pci_sriov_get_totalvfs` promote it to an `unsigned int` and return it,
while the Rust bindings would invoke `__pci_sriov_get_totalvfs` so they
can expose a `u16`?
