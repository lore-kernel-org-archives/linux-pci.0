Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8222541C;
	Wed, 28 Jan 2026 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606445; cv=fail; b=au80Bc9Y0/VAoaT94RVa0tM+j9oi6Ek5zD5bEKG0vA0gnV5EsAuBqAYNYjijrz05dttRvUdQbU09pJMxoQDvmZQDaORXnOTcvwwbVPxksiBq+xsfCiZ0bajLjLnl/Bolztp84/td06EeqrDnXppggMAf0hfs42OOnf2A3whHGoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606445; c=relaxed/simple;
	bh=Ig+5HVkyL3o83KuqHSaCBIyNSHObx8pNy2Gkdjg1BRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m2CINIywpbmp088eQSxdv0E/Ftx28m+RJAmokOuPMsMOCsKHzlKUk20jH1NDlmDGZciQM1IKLZPvMdHeBfSkfM1Twhcr4FN2GF+fay5UV2eh6e3dswFJmWLqrXRLG43GDmoVfV1VnBwdND7f3rcRnWYnw+kaImpC89L9BgkhJE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UPLT6NiU; arc=fail smtp.client-ip=52.101.85.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UPLT6NiU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxJxUM3gscpWxdi6p0WluN8UXC4txABfEodVDp/M8kBinuYX2coS9r29FgVv7qFVWHgyK6QUNdgI5y2MuFKlTyCvFvmdUDSzOdO4TAy7zqu1n7TmbtI1dIkHJixOPWBSqa6p2rBAWnpVD3fMxwl/iK4Q39YWQyqI8ziY7QgX6V49PfII1tUMF8wMaxR5UTpuTeEWwufl481dFWKhwHphd9uiL7giSrunI3Ho0jZ+Q/boGpOm7gYRBGfQ70yVpR8D+BMx+PLlXCwKAV7cJ8fzUFEixh7K8dD7UHBdQHPSbCbXni0hmOall8andKI3SgQ4QHu65oDxarchEsQQn1vLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eQMQ8IYC1SDRE5YYRTvzdC8FXvNg70p18UHCxQuHkA=;
 b=GL2lWNFf1FUshmkwPPU8sBMb0vJOjPcQ/C9tozLGfYmHQ4+kFiW1u2M1TaGAV/szGiIk0IBG3R1tmwh6Qa+86qyrpu8gpW1oiVs+wWHhZ3XRpJq8aC6NRgorNGTZfetWxEkPFxzNUiSC65WTxlfMvAwKdNuqm167mqjKhS568BSzvPhO3MIM/zHyCRyKZhgW9LA7qdlkpqMA3NLXtb5gMtpKoBLuj7JLrgnrvafGsLDc/Kp6oAfeKC3kLPRWMgg15K+3nIJ5QG/Z68w9CeWvh4NE6r3uLWOBXOMmRZpec63axfddZhPiohJxuhdQpxCwBSyUx2Qw9YTNB20XvNY1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eQMQ8IYC1SDRE5YYRTvzdC8FXvNg70p18UHCxQuHkA=;
 b=UPLT6NiUuYLJJyPjA4MrL2qeJxr9hstpdn7qv7yDB9urMKgFzmeOnRBDvjZ745zcZ5qZfQQSSAmgHN+C2Wa6Tzyf1OMs7/0eXuf2TWns4EylciV/BWItJDsQe/IIQi5zf+kX6ThCVP7n9zW2jG4PdS0nvUAghMp0fDnuRKEvdYEoP8axllW38SqLs+xIRlHFONt5U2saXAsbwdq6cTVtSu5Ml3FqXvicEZpBQimkf7YOSXmMF7Ae+tq8rAd59JYJR+z4kB5b+CQsvzUNR2t/Yty6L+zUeh4HgFkWRpfeqfEU70KY7EC8BfJ6lylAogaoHVaAsWlqHTAIvUxA2jdFpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 13:20:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 13:20:31 +0000
Date: Wed, 28 Jan 2026 09:20:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aliceryhl@google.com, bhelgaas@google.com, kwilczynski@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, markus.probst@posteo.de,
	helgaas@kernel.org, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, acourbot@nvidia.com, joelagnelf@nvidia.com,
	jhubbard@nvidia.com, zhiwang@kernel.org,
	daniel.almeida@collabora.com
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctlg
Message-ID: <20260128132029.GX1134360@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-2-zhiw@nvidia.com>
 <20260126181912.GA2131321@nvidia.com>
 <20260127215744.332380fe.zhiw@nvidia.com>
 <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
 <20260128000410.GT1134360@nvidia.com>
 <DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
X-ClientProxiedBy: IA1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV9PR12MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c4337f-53ec-4791-f1b4-08de5e7002bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EvbVN2DwMOtHDhihXyjwrjojakNz929oUGd1WDU0C0txOuIH3V0WlDvYD9oQ?=
 =?us-ascii?Q?vBJbNZmu9n1wp/XExJcdMb6xSYhmldkT2HkqtVD6aXEUVbiT+5yR0a5aysV4?=
 =?us-ascii?Q?spSaFWsa0Swtlx51/7lBhxnbtRHE1oNXbLM1Auj6nPrqPU/cAlQpZ8Cx7YA1?=
 =?us-ascii?Q?grK9YWdocqkRs+aE23Q8mjcJ907A6sAzlEjBBGSdZNxKj3yp9txaYvXHKJDY?=
 =?us-ascii?Q?v+DHrLou4Hrsb6bxtMNUh22vOeGbB4lZNtrXkHrInPoXmTaTrawO2avSeNOD?=
 =?us-ascii?Q?wOwJRQkM0tGxy79uaKvPymfUqh8IdKwNxNe5iT1LS8mJhoteANz32k875roD?=
 =?us-ascii?Q?Wp/u8ghcX0/nNGCfCjuf+HRcAHN7Nz3RyluPm0DlevKw9eleyzhpab9ay4EZ?=
 =?us-ascii?Q?8SuoRryr6oeBfPQmuWTf7mvCHNOjrgZBSMJmQCHjSfnRsG7PtwRNVCE1GInx?=
 =?us-ascii?Q?yvf64vUFmpLrmLNdIe8USgCT2MaUoc4A9GmCgEc5kVpXlghuekOa6SyFYcex?=
 =?us-ascii?Q?FstpVH0qjuldUy7sH7HPs84UDvuj4c3w5bNBbvXQqa/N0a3cC262xlsTGKCh?=
 =?us-ascii?Q?LSlT2Z1wUsxF4iKpzCbPiHwwapVZqj5Ex38Da3lVim5cwabASXGzMe5akdBQ?=
 =?us-ascii?Q?JdfSliBWoSnU+XwyY+FDRBjWwJD3VHtHF+e0l3Gvi5aTkIE99ETgsiH/K9Id?=
 =?us-ascii?Q?J6zSZP9uCN2utf32WnEyE86H0ke7C77cx4DidxvD5uX/d5s0g6zfaohzwK1p?=
 =?us-ascii?Q?16v8geE94rigU7we1z/2HEriSwS4NOWGrCfpj8L8oVdo6QNfO70ORJ29rHK7?=
 =?us-ascii?Q?QLdCg1v4pqBzadcMKkSB1h6zpXzE9WVDu3GQYm8Jls951ECKRutIoxw8Hk5M?=
 =?us-ascii?Q?yHtgOWtNr+o9WBxia/ayVBAz+mDR6+6OMdhvb0Nv17i+Xk5XChREZV8Q6dEq?=
 =?us-ascii?Q?XyOhdn8yfZ6Q6bxq1WCsX0vXAsjslyhqmzWgGkTJVy6s4D21GAhV1vft8/dz?=
 =?us-ascii?Q?0/HxugZXQ16Fvj32mJMtNClpgfVmoJ50UhiOv8R3J8ukt5/NWc57WSE3d5o9?=
 =?us-ascii?Q?KaZW3FjKDEMqZhXLYtcaRDVUiKK2iol29gsVTErcpUbKZ9zn+Ma1ySrMa37H?=
 =?us-ascii?Q?+UbRkVBQqTl57xvdDMPXbnhxqruTQe7UE/enl1o0fLEXqCXFt0c+qTLWa2TE?=
 =?us-ascii?Q?lGIjDbJl3Mo8qtYxyNKXmch3/tzi28Hs95qn8c3x7vX7rIkeQKGMZY+6M0v7?=
 =?us-ascii?Q?BTZrXtHn0A61e1rChBjj/511abl0qtC3UNQryCw463LVyUMFE3Cbf0/NAYfJ?=
 =?us-ascii?Q?2A+o/r/8Q6sczOdqJVh3bi8ZWHkoczceY6AtO/51oJcA0I+2IlC5fW5TeaFM?=
 =?us-ascii?Q?jrGy01hUJyKJdBf1Cy5l1oun/Vmjq4Iwcmehjg0rD652VQftnZUkrfuJWXwJ?=
 =?us-ascii?Q?FaBMba21ym+rab3LIAciMx1o6JoW7Y1ZE+8ObtjuBjENLW7M3wHk7TpmzkVB?=
 =?us-ascii?Q?0xjTbehiG6npnlM6pOZt5jcYE+oAuT37Oo5CGuFuQ11q3ucfHuOajumltHlV?=
 =?us-ascii?Q?verEfBDS4zEx42t6954=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EjkLptol0kPXspoH5DgbjAUG24zK+XAvjWpANGUo0N09B1z1PksIzwjyfepi?=
 =?us-ascii?Q?GgBM/aLPrukumesVA+mW0vO02vDWYTkZD3cSTXywIfcinUNtiCDDzQ92e787?=
 =?us-ascii?Q?PNqLUuSniZJ3PSxN1AOtBFMGpyJiMFdx4XFt6Ek8nSg2o4KcuuihdmN2xkXS?=
 =?us-ascii?Q?8QGGdn/MNCJmE3xNC/cqyPfUINUPdZZiZo0r1Ij2sqE/duj16tTVWcXW5l8M?=
 =?us-ascii?Q?IkIRd1G81WGlNC9/g0CR93z2SHpY3+XZRM8ewHI99iQso6QQV1Fzsy3r41ZN?=
 =?us-ascii?Q?ae4rsOByyNRc0tIT3HmA4oXaETzJJYNuNHYDoF+Bs2U02Tgob5rSHqFuuzfC?=
 =?us-ascii?Q?zglQdtpB7Ab9MtIoPITNGSf9g22r07JZ5hThkdbNEse4tmQ8by4WBKyD9MFG?=
 =?us-ascii?Q?5nuZG/549t/NOqfixWoKMXqAw+KlgVED/jY2vDkjwnizXsGeaxphz8zeST+G?=
 =?us-ascii?Q?cqc5UyHd5vcaAwMwc8Pcrw9Dav4E0DDrIFybhYvvzE5mEm08DkKVRgXsQKSn?=
 =?us-ascii?Q?JIPKmf159AIDBUuaNDYAP519xUBLKxA+GBnExGi+LK0rWkk1DYz1tqWaI+k9?=
 =?us-ascii?Q?Eb7YthBxCnvyxmZrfe6hxj4I3mHvwhYP6jHgBapHwwtG+RoOdGH0X2TI/uiY?=
 =?us-ascii?Q?YV351S6DsfqHRX3GA/rRNbJ2Y5k3avtS97bc3L680KFs+2SgH1f9r+PNd9Xy?=
 =?us-ascii?Q?ZR1pFr+Cbo9SySfsyh0Gh+nPnsMLMo9wS/I0oX1ms4ywKZqogvqGIvCfeorZ?=
 =?us-ascii?Q?Zf/UZ22eTN3UWxRTXkxeYsh9GD5Lh6HPH2N+U1Yxat1ytID3pvWlQCvYmcUR?=
 =?us-ascii?Q?+nV7v+jcF98A8PEdnh1GD5e09MdWEmpr5Y1PsWaBJVFLBL0V9ZdRumKYI7Ko?=
 =?us-ascii?Q?sV8l5+diPXS4V0MAN7DK3rsQXh501oDdWxkMfmF/usES9bmzRnDrhtrbsPgv?=
 =?us-ascii?Q?+MrPs3xp4Ya2OpLjwlljtFxzsS4Hwx8hsylcz/Dz2UrWVvd/OTwq6k/FiCFe?=
 =?us-ascii?Q?Hfmi+bslZZqPeCPbI9X1Wv0mCpFSwFhz2pFplsZMAck9F2z42B4SvUyDDx2R?=
 =?us-ascii?Q?zuuP/pyXm9WupNO4Tdeph+m/TTsCkx2m73wksXhMMxUc5Ncffco0dfFgzqON?=
 =?us-ascii?Q?mFMeFcNjn1HmzneCTGcnO1EaxDY6YRV3xrP95Fk1zpn4GHl9I+AkVGC2eioF?=
 =?us-ascii?Q?Vy5VJmDuNDTHbLcbLEla/Qz/kB+JoUd+hdm+sFPB9rSFVL2LO7ZxalnMIytk?=
 =?us-ascii?Q?FZsjWomoAP1u3S8G6NV76T85BjG6ldGPQ/wJf2J/dG1VnVaF2bNVKGDucNc5?=
 =?us-ascii?Q?coHP/gDD3doZc6pVg0tJ8nZyv8zqymq5MkljLAZBPt6OYuXmlp8cDjeqAlZT?=
 =?us-ascii?Q?PVaNxaS8N67Iv7REL4V/5m0xhR7YrQD5UOseeznUuzAxc2y0JpZ8SzjYdMzY?=
 =?us-ascii?Q?IvuKwa367rX7LlF0vROciC81JbTXykSW0L4yYMudyEHBO9zIDRA4JyvseJMn?=
 =?us-ascii?Q?FetG0Lgen94FF4bnpzJqjd8hHVDneo7Pi6jQex8rHscq0NdBWD0pQTrve32E?=
 =?us-ascii?Q?sIeM0UZA1xspl6sWgZYTPlzpTnlzbE3D34FDObYSADEd8pSZ8kEFIYqXakm8?=
 =?us-ascii?Q?uV00yw+rjh3wqZqN8NV52hY9al1cw6+jZJdnc6sc8n64/RCt5c8MM+1p2U5S?=
 =?us-ascii?Q?0O/R3hfWY0oZfIZlHmq20SWUGJrUQSku2mjQi3+JtWEdi29ttc5X/HB6aTyW?=
 =?us-ascii?Q?NPXbB26cSw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c4337f-53ec-4791-f1b4-08de5e7002bd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:20:31.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hup/oVWYnftTuXOOiyNUKMhllyh+c0pONy7bQJZWlyThAclOEt4CHBJf2X4w84sM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759

On Wed, Jan 28, 2026 at 02:21:38AM +0100, Danilo Krummrich wrote:
> On Wed Jan 28, 2026 at 1:04 AM CET, Jason Gunthorpe wrote:
> > On Tue, Jan 27, 2026 at 09:07:37PM +0100, Danilo Krummrich wrote:
> >> On Tue Jan 27, 2026 at 8:57 PM CET, Zhi Wang wrote:
> >> > The fwctl_alloc_device() helper allocates a raw struct fwctl_device
> >> > without private driver data here. The Rust driver object should be
> >> > already allocated and initialized separately before reaching this
> >> > point.
> >> >
> >> > We rely on the standard dev->parent chain to access the rust driver
> >> > object from the fwctl callbacks.
> >> 
> >> (I will go for a thorough review soon, but for now a quick drive-by comment.)
> >> 
> >> IIUC, you are saying that the user is supposed to use the private data of the
> >> parent device in fwctl callbacks. Let's not make this a design choice please.
> >> Instead, allow the user pass in separate private data for the fwctl device as
> >> well.
> >> 
> >> This serves the purpose of clear ownership and lifetime of the data. E.g. the
> >> fwctl device does not necessarily exist as long as the parent device is bound.
> >> 
> >> It is a good thing if driver authors are forced to take a decision about which
> >> object owns the data and what's the scope of the data.
> 
> I think we were talking about different things. :)

Well, I've always been talking about this :)

> In this case Registration::new() returns an initializer, but also allocates the
> C struct fwctl_device within the initializer.

In a normal C implementation this would allocate both the core and
driver struct using one memory and a container_of() relationship.

> AFAICS, _fwctl_alloc_device() already initializes the structure properly, so it
> seems there is nothing to be done. 

It does the first part of a three step sequence

1) Allocate memory and initialize core code
2) Steup driver related data
3) "register" to make the device live and begin concurrent access

I don't think 1 and 3 can be in the same function. The driver must have
the opportunity to do its #2 step in this sequence.

> Though, sometimes there are cases where we have to defer some initialization.
> This is where we usually use separate types or type states. Let's assume
> something in the device only ever gets initialized after registration for some
> reason. In this case you could have a fwctl::Device<Unregistred> and a
> fwctl::Device<Registered> and correspondingly treat the inner data as partially
> uninitialized (which requires unsafe code).

Maybe this is what is needed here then.

> Either way, I think it would be cleaner if fwctl::Device has a constructor
> 
> 	impl Device<T> {
> 	    fn new(
> 	        parent: &Device<Bound>,
> 	        data: impl PinInit<T, Error>
> 	    ) -> Result<ARef<Self>>;
> 	}
> 
> where T is the driver's private data for the struct fwctl_device.
> 
> And Registration::new() can take a &fwctl::Device<T> and the parent
> &Device<Bound> of course. This would also be in line with what we do in other
> class device abstractions.

If it goes like this is there some way rust can retain the
container_of layout and avoid a second memory allocation?

Jason
