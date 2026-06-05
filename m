Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1DF35BDA4;
	Fri,  5 Jun 2026 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668535; cv=fail; b=PkDUD2YjGhT3wkzZdnXbJlDP4YV4tVVC9PYlGXgC4G1SJ/k9vmNXdi1vcTPBHODt1H9SpeRR4hwtYWsWPprCh8FZwLOd6ppyQQemucYCeLrwAs27MlJmJAHmgWQJudAzoKZxU72r9SyvbdUjPr//vy1uXj6mZIKEN6OuMtTL9yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668535; c=relaxed/simple;
	bh=bteNuNv50+3Ze4cruv9fG7b8OZ8kCYAKP07wo49JXYg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=b4+CF4i2p9Yc579TF7+b1rGuDm6Ag/6Vm8oEUN4SS+ezri9NDwBErQUa2RuBLi2grOkQGROPeXySA/YCUfV9CAZjMnk68vIgTFmBj2j/xuHlTQvYznrmpOsmOyk5bSkhGNJs7D6IpcfQsGerT4smoSZZ/LsJ8lG8OAFwqATp7LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=okWQ4U5A; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="okWQ4U5A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFtxJbJ8B1a3Jq25YjuB11iY1ou2+tp71HC6gsuiytdKSptCxM8PwA+1ZY8x1exRpZ/0UjrdXIaJrSFCSBd+gJfN2tLXDHKySkFIzD2FAw8XadToNS1gIKQK2PGIN4QrV0wvYDdxlmXARRCKGgUT/v8vk6EiXMQI5XSr7m/89QDTYejGjg1i1ENY6M8VUCbXbU6MVmJ/Jjx82ZwDySrVvcdFNyxiRx6SMqvjeFC5zFEDehsfDbuVL54Kx5uyBBv/GkjsiSM+WzmI0+KJ68aytkx3iNu4/3S7YbGUyDKqxtzPP78kKmSSNSP1k4SCZa7GXI8Pq5IK9qKH2D/Qa+oCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=086joSiY7aemdbN5sbKWSv33sBzEiRviG6Uly3Vwrac=;
 b=o+tfdM3xbUcmxsqdlj4+Pg9154XKfeevBfK3ajTKqzdxtqBBH12B8corRNj16MxC6StTtHvOIDTf8WXHM5Bxznyzg446dPtz2TPAs6lV3CQtcaS2dOGviniiElUhGhJjhZX3ZQJCFehXqjVRTNUHYJ5PEK4sS2EA76d48CCcW6q2ms57QCq+uEqxNsR9QVcol/UMvPM3k0a1PxpHZuGktxqVZCb2Aty5rAmK8+JkTaMM6NC7Yo4rvbbbP6xR+Y7cbPfbAIVfgrnTxxqpyl0NoxrymHMr2WikXiXT0ECFyFyB5hAKz/wpL/JHdaT5IMPdFONj1DPun6pQepNQ1k6OAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=086joSiY7aemdbN5sbKWSv33sBzEiRviG6Uly3Vwrac=;
 b=okWQ4U5AMPdx2KT5RjsKigIxiDHAMFs7P7xlONghWl8AWpXdgJwFXOI4d8EOBxvCA3RaxbUVmp4FynwH76Bl1Y3niOA28LMnkYtJqCDE109/xw6/+wPTeVSpJKjiNUr9xOgtI42X6n3iz+s0n0ZN42WGAlsuj2NBRMLKNacTSUFeQphFEXbp6i4R+ZmXw+Ku7Lc61E5I6oaRurrIgdFnPyt3gB+tfBIUnWMYYK+0HHT8HfsIhP2IgvlGPnfLWO7kMLW45SRqJ9RoKdcqJVobbNY7gEOzSRdruiJJk2YLiELhhA0SiBptT+Y4dD4PUctPreHJI48DqlpntX0Xv0pnUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 14:08:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:08:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 23:08:38 +0900
Message-Id: <DJ16B4EDPXO4.1S6ARLURYLTK@nvidia.com>
Cc: <dakr@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>,
 <apopple@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <zhiwang@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/9] rust: pci: expose sriov_get_totalvfs() helper
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260604114339.1565660-1-zhiw@nvidia.com>
 <20260604114339.1565660-2-zhiw@nvidia.com>
In-Reply-To: <20260604114339.1565660-2-zhiw@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:405:372::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bee7db-5e3a-4c63-d366-08dec30bf5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e93heMld0beR4/a3832GAx15i298yecbA3WWKZMpJ2T1tX5BI252J94Hp94Bqn1tTl6GxezVPXVJ/XP3qqZRwUo3n3vatVNtFndMWGIL03wWlAWdBRXw0gTs1mg3tAFAugiPLQCt6erZ3U/1rTcBm4IDe94mnC9sGQ86jN92Vsn1us+VA5YbZyRRgUkQXZVM/MwpTspKJXu76OHOU8SUVjUnVYE7u9B/7MyvHp6cCUyLJix4eQqZxZLOGerm1WMOqCBhV1GinnRD6weM/L5NX0OwPxQkKE/725M3Vl9pPokL9yL+CapDblug7YIAaf2PIdcxQcgAK/k7LbZ0LmCHGZO6TJHonAD2dP0UbTEj5hcaNHCqkTkIv404/k906yj37i1TEOmfHaQJStjmeksu4wDBTSVcGM2CNCWTVDS8EZsQu93XxrnLNoHnpQDeII5SOQvsnQ1Yrw+53k4o2TpxMoOIPwNBFXjfI2a/f2tacqCRMdppW31Xi0rMu5Q+XALkFJFBKqi/RklHpIQGYwcBgCeEiN7IykiCtYQzGX8mhVufaheuuFUSufETwQHFaqfZ5UMy0uDXGZOZHz/0CM1lnh+ximX8wxDT3AZVl+neTUTNRPHUN2GQjR61dzjkYYR3AeCPeYJw+MKGuxdRUZlOnB256VU5tA556fLzq3cyn5+a3S/aXzWArESOEOfWokTofrQhDgZBMrKQkulxM4cJQg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXByd0pDZENYRmsvcmxkbGRkTytQbnJpYW0vL1FkWWRHd1dwK2dkNUlibWRm?=
 =?utf-8?B?Q1gxbitIZkg3QTlWZEtVeTZpblp5Um1GU3ZGQkd5eGU3VGcxVE52VnBXME1H?=
 =?utf-8?B?K3Q1QkZqOFdSemNzM2lhS1grT3YzbXI0S0tXTnJSb25vY3VmbHBxMzFoWnpO?=
 =?utf-8?B?OHVFRkpWN25PYmlmc09pcnBqdHRKUFZud21BTE1WdDNhZDJlQy8xdGlnb1FM?=
 =?utf-8?B?aktiUk9DQnRIdUZQR1Ixeis4UnJ0YVEwRUtJN2Q1aVBWYkZHYXBVSmdsKzVU?=
 =?utf-8?B?Vk5seFh3Q2ZyQzByT3MycFFqeFlmek1nTXM5OUdvdVZuTDdFTWxIZEUwbmQ2?=
 =?utf-8?B?dFhtQnhvd083V1RVQWd5RGV2UjdyMVczSVRTNm0xRDFMeXhPVDNId1lldi9V?=
 =?utf-8?B?Nk43QlR6TVplZzBUcSt1YVpPczE4RktaVmc0KzhFaW4ySUFTU003bE5OUE5U?=
 =?utf-8?B?dlpXTDlvdHZkcXN2V2luN282SzJrT2xPd1ZSNDMrRVl3UnRoVWFwdVVDRDg5?=
 =?utf-8?B?YXZnMEZmM1Nvb0hVRndaUTJUYkRGeVZIS3lQVWZmc2FLRlVIVEVaN21ueWR0?=
 =?utf-8?B?bjJ5K05TQzhUMmNFNFdLQ3ZQcG5rQTZpOUtxNzlka3NGcVpJcTMxWkhVUlZJ?=
 =?utf-8?B?a2RHSXQyeVJqSExEMmZxUlAwNkdLT2E5YTN2LzFrNEtBN1VYbExOZVJiOWxR?=
 =?utf-8?B?U0VJb0RoVS9hcE4yckNZSnduRSs3Y1d2YUloZHh1akFzUkh0WWlBU0lVNSt0?=
 =?utf-8?B?b2JJczNGOFNHcWVONlYvM2R6Tk42ck9FT0FJdHBnUzQxMjVSSm85cnVaNzlw?=
 =?utf-8?B?MFNyN2VUdVZzNURMbDYvb2dNS0FZTjNmd3R5alQwdUNrS1NGWmloVDJNOXVF?=
 =?utf-8?B?b0xGYXZXRytXRUdMd3JjZ2FDb2UzY2ZuOFRsUmNBNHBvNnFWc0hiaEdJejJV?=
 =?utf-8?B?bWF1NkJ5WXdPbmFneDY5VzJPWmYyZ2hFb0ZzczA5Qzg5SWdyaVFHWFBVYWRs?=
 =?utf-8?B?eXlnVzBaaFhydFlOQTZLQk5SV2VyVGV2UjV5ZjlDanYxdlZmOUg1elVuMGY4?=
 =?utf-8?B?VjRvcUh2RFlyaE1EVGRFcUYyS0lNRGRzK1pKTkZ5UzJVdktmUU95U2x1YTJm?=
 =?utf-8?B?MUY2MUpQOUdOQy81bjZKeElJYVJwR1p3dWdBRmVlamRCSEUwR05RSVZtYzlB?=
 =?utf-8?B?aG8xVUdJOWRoNGRtQ1BZQ3Q3LzNUaTZtWVNZOGp5VVd5eTlscnVva1ZITGx5?=
 =?utf-8?B?Rlpud1ovNUFPVUgzMHhjalJJL0hSRVVGZzQ1UHp2SjVtWDRiTUZZQ25nTStj?=
 =?utf-8?B?ZDhiV0pLTHRRSThuaHVLYzF4N3ZrL25TSExXKzd5WGlyRmVEOVNCbjlRTldm?=
 =?utf-8?B?Vm1ZUFlDa245R2xjeHJRMFNnUnpudSs2T1RzRHlvMjZ3Z0I0VzdtcWY5VFdB?=
 =?utf-8?B?c0JoL2hHS0NndGtucVNSV3crU3J5d01oQTE0UzQydnhOYldxRUdDSTROUkRN?=
 =?utf-8?B?d1VnWTB4L3B2cytMWWkrS2VlMG1Wd3hKenJrNG1OZjRjcy9JRWsvVmVTSnFO?=
 =?utf-8?B?S01KTFhnRUJIRzFWWkY2KzI2TmlIRnBXOEd4RmFwQU5BWXpBTlgyWXQ5c0Rx?=
 =?utf-8?B?NVhvRVNSQXVVRDVDRWtzZGpoNnh6NjFTa2FhQ2M0aGFPb2J3UVhBVlRGQ012?=
 =?utf-8?B?Y1lSWHRlcmpGN3pOOXBCaUNrQkFFcldBY0xaMkxZbU1KRHVOYWVNZ3dFdWxG?=
 =?utf-8?B?V3lTTG5VdG1qanJvYmhIaGVZSXhyS2JnNitSMjYwOUU1U3ZabFlZRSs4cmJ4?=
 =?utf-8?B?WGQxM05BWE0yRlNLZWN2d1k5bXl2aitjeVdLTWxWdDFJN1NqNllEd1JoYkZ4?=
 =?utf-8?B?Rm1yYTFYTzFrOFVualBrc1lIZmh6bm8yRUhZQ3RTRVIvYlJ1VWc1NHhGRjJ2?=
 =?utf-8?B?Wkx2Zkp1NUU2a0xNcGp0Nit4L1c0NGU4by95NFhsalRydDNGcmVlcXNDS3la?=
 =?utf-8?B?QUZHaGhVcER2OWZUMzd1UU5yc2doa0poY2dLYVJSSUpkTTRIMlVMc1dkOXdP?=
 =?utf-8?B?REQ3c2t3NjZyZzdYRnVsL0o1QkJEK1JIOUk1RlZQd2tkZS9XQkZoNVhmOFFh?=
 =?utf-8?B?V1M4RVA5S1dsSk41ZXpRNUpmd0VUdGgxczF5dkJOMnl4RmUvOFlwZzU1UWZV?=
 =?utf-8?B?Y1hWMVVGL0VwV3htZ2lray9sajNOa0htaTFLVnRGOGxGS2NIUVBaZ0JIQ3R0?=
 =?utf-8?B?djdONGMyNmxJdlhVdnA0VmhqOVR4WldlOG1YNVQ5a2h1RzZpZTgzMGJSYXpD?=
 =?utf-8?B?OTgzK2R4N2RFallKb1h4QkU5M1pNbXUzSE1RSWEyd2l4dzBVMjVMWlloRmNG?=
 =?utf-8?Q?ygFqF+TjnRfITg/cqDtxGkk4LLYpVKmgqoLSCPV1SgTIJ?=
X-MS-Exchange-AntiSpam-MessageData-1: Q+X9IoePev75nw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bee7db-5e3a-4c63-d366-08dec30bf5af
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:08:47.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJYizIy0z1pBQuTPCiGYSikaW5rKELlNOlTCr28IQgQXTuTArjf2flTdK6XclkT+4OaXZ+EcYx99/cWBEBlSpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616

On Thu Jun 4, 2026 at 8:43 PM JST, Zhi Wang wrote:
> Add a wrapper for the `pci_sriov_get_totalvfs()` helper, allowing drivers
> to query the number of total SR-IOV virtual functions a PCI device
> supports.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 5071cae6543f..d04e5f6841f2 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -450,6 +450,18 @@ pub fn pci_class(&self) -> Class {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          Class::from_raw(unsafe { (*self.as_raw()).class })
>      }
> +
> +    /// Returns total number of VFs, or `Err(ENODEV)` if none available.
> +    pub fn sriov_get_totalvfs(&self) -> Result<i32> {

I mentioned it in a previous review [1], but I think there is an
opportunity to improve the C API (and by transition the Rust one) by
making it return a `u16`, which is the type the number of total VFs is
ultimately stored in anyway.

IIRC there is also no need to even update any caller, just changing the
prototype of `pci_sriov_get_totalvfs` would be enough as callers
ultimately compare the return value against u16s. So if anything it
would make the C API more sound.

[1] https://lore.kernel.org/all/DETDILPA1GFY.27WND0TEC5352@nvidia.com/

> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_d=
ev`.
> +        let vfs =3D unsafe { bindings::pci_sriov_get_totalvfs(self.as_ra=
w()) };
> +
> +        if vfs =3D=3D 0 {
> +            return Err(ENODEV);
> +        }

Having 0 VFs does not necessarily look like an error - it's quite a
valid answer to the question "how many VFs do we have?" which this
method tries to answer. In patch 7 you even do `unwrap_or(0)` on the
result of this method. So unless there is a good reason to treat this as
an error, maybe we can just return a `u16` here.
