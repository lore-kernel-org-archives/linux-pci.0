Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140C730B52A;
	Mon,  2 Feb 2026 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062252; cv=fail; b=pubKonN2iTiqGnMj3yZLspVMuhFx4abT9fhBT/8G7VCUDIrt9aRjRN56S6aVpN/ic6RTi0deNEQH1PIUa5JiGYqsQLPcCN+QyrPYZsp/mt7+6WUaIoFqDTHZl6Ch/wrhq63JwN24qnY00ov5E7iYcFfq6HNPCIAwrDyCbyekR/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062252; c=relaxed/simple;
	bh=9XqDf9h536darH0npEgiQBqM2uQACkqM3HEQxyN2bls=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcaR92Rgx4qZQvjpAEAOU4MQkr+V9EHJFMfJPXH9DYW0K+svSBB/leOeFbzAOXCz/3TwBkqP5Z24B4/cDJqZ0pWd0YRZqlr9GdHz1X+iBgrX+POiH4cfXNe1f/z+dz80MJus61hmf5M/vj8VSPUn3y9ZWs33WkNjqrE2JMbgTJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VDx3LfXg; arc=fail smtp.client-ip=40.93.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VDx3LfXg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwtz47GT1wEVfrMVGfAj5J9fPi6G8/jwYKMDkQZj3/vtvfOMA9qip41Cevcue+BOnWRXN5YTEsDFDF7pJ9peMnXLrlopdCO6EOAhl/OtBS0f6hB8z6D+UQMTk3PXAOCszerf5OZKcj1IMHueRZ7EKiZvRerESY9FyOxA1pROsEZggtEO9iXijz+sNNWefJ/O7qb9Xj6LRpPpLvV36PV5GcqFQwN1vqkm7KaQx1dyVVVvYCy6CDVGv3ZTB9NqH45YSdpE2dGNFyG/9rVbOzNtZIQcrlrWO7AHZKJFHwHcl6BiH+rd0VfmPunp4N0pLurrAB7nZVBjagG6wjGauELawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OmqGg3khQmLwGMKcm7kuEy7AZHMSCC9qER6XlniUDw=;
 b=MYhTWLL/aM7MMLmyQrFSEDihVd8p5elSNXwi2ctZ/5S7f/xwpTpZCLBW7rKSu+y+ndtQq7lJKexg+0lRpuMWIjwFaYRfynQWFr5K55/NHQZCT4F6B1nw73ZqLgB1+sGHDk1LP/uV6srl99lfplCnRD2Ptpr/UdxIpWa250wx3rynB+4n+Ls/dwEstqIRAo/NU8WW9kxdIIqZ/IChfaGo//0IhO4TnTJoH3zsuXoOFDnQYDn8uQrBItsRN2zNDu9Em7mY8OiwGaAIYzAH479cCXNMLc8lpwwZTq8acP+vkZ4Msoj3sMuRLLSyGn35gK7gE5M3Xk7Tdw4sQqlwlHhICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ry.rs smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OmqGg3khQmLwGMKcm7kuEy7AZHMSCC9qER6XlniUDw=;
 b=VDx3LfXgBdkN5Gr3Jg/Zm6AhHxOQawuQwPW2XpLgO3gb/mSi5GsM03lXRH9kq/Vg5hmbf253snrm+5WLhTNSAheWIGM+ZFgQ062Y7pCBgg0xsSNUt8KlG0I1nzVSLpRU/cXiIH8mPBMJBKBbruZlaSYgPLceeLrjod50hniFrztUAaBtLtRZriBZ0QeLTA+sJtFnxEathB2mAggfEkKGfrsK/I9SEY8mhGF5IvBMNBglqoVIHbx0BVTN86D6hlyMKxaxd7j2MWliPRrHv15ylCs8hXNHu3Bd0YnaQqTgzmTFu8djAs9ecEPziCfbX1oL2Gt8Au7yGcF8FrrILDx2WA==
Received: from DM6PR06CA0088.namprd06.prod.outlook.com (2603:10b6:5:336::21)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 19:57:25 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::a0) by DM6PR06CA0088.outlook.office365.com
 (2603:10b6:5:336::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend
 Transport; Mon, 2 Feb 2026 19:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 19:57:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 11:57:19 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 11:57:18 -0800
Received: from inno-thin-client (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 11:57:16 -0800
Date: Mon, 2 Feb 2026 21:57:15 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Zijing Zhang <zijing.zhang@ry.rs>
CC: Gary Guo <gary@garyguo.net>, <dakr@kernel.org>,
	<linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<dirk.behme@gmail.com>, <lianux.mm@gmail.com>
Subject: Re: [PATCH v5 0/2] rust: pci: add capability lookup helpers
Message-ID: <20260202215715.1000e2eb.zhiw@nvidia.com>
In-Reply-To: <2f385010-0a47-4d0f-8554-b841f6026561@ry.rs>
References: <20260201074248.1629393-1-zijing.zhang@ry.rs>
	<DG4KFDZNRSYS.28570B2QPH28E@garyguo.net>
	<2f385010-0a47-4d0f-8554-b841f6026561@ry.rs>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 84069bce-b753-410e-97c8-08de629548b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F4kTjaBQfcUAXrHUQ6pgqVFmiqcX19xpNgzfvBWXGrddYhdzqr3fZzWS6+5A?=
 =?us-ascii?Q?3W16b5L8uyJdEvPtZSvTN9fazKbyVD8J3x/kUu6GyyKv2mA8vrbC5ypu2cqv?=
 =?us-ascii?Q?w3+AQX6fk/lf3rnIioyL99duelhzDQnqoT6Bz1wtr4lK9b00HwuD62Rr7EE0?=
 =?us-ascii?Q?nGFJflZt7D8AmO+lXXEGD3/Cn9TMNH9BrN/bp/1RAV5MrUIftmLI5rzlijFL?=
 =?us-ascii?Q?9YB1JLee8umtwu2uXhKmVco1t2qfzbiJrkLv6q+XwFnlvROmF1qwWivztOlZ?=
 =?us-ascii?Q?9g3K/5vksFHTnHsNahUNZSHwMUMt1KIqzNioByhGu3A/luoHylL8AJW8ckce?=
 =?us-ascii?Q?Itkt7yg0dJMamYg/6RiDW3XIT1A21TJxfKMF3/Ke4NHUvAxUbcnXHP3nsVzv?=
 =?us-ascii?Q?KIzjpwrw/ljyj1M6o/nbV/w9DCQCHLyJ2dw0Jp6OereoFEWokst6gvOYrS/h?=
 =?us-ascii?Q?2J9Xx6HWIwUH3G8f6BTR8wgHXPqKR4RIdFrLM9bzpdzVdnu8RuXpOrfGReqY?=
 =?us-ascii?Q?KU1HkdPglkMXOu4H3hc71B0sNw5RyrIvVQQP6RP8fXY9Ix5pYCs3ng+dU2uG?=
 =?us-ascii?Q?FCjgJmQtuhSCX4BNPxBJzcZVoSvUlAAeqvH5H7NogiKtIkIV1+xPbplyeTg0?=
 =?us-ascii?Q?iRaJ2UGPk03J/K7TFc2I/bS7oFU3FfrXNzga9hQMlC4TCMzMJoc2/5x4Mbhi?=
 =?us-ascii?Q?KRNi1hOxIo2cQhQeRucYQH+AYyoOWgMtEQwHw26UV66A8pIB7a3YnvfIBVZp?=
 =?us-ascii?Q?IC9ZJ3xZBtCTrF1KL/eYfVS4oZxkcXA1SJfkamaenAWc9hJUNiSvKF1AoX/B?=
 =?us-ascii?Q?3MwExXtFczWWwFOxhks1rlBgfCRkpUoYQoubIENiVvZOJpYEleZgK1ROh3iv?=
 =?us-ascii?Q?Xptv/aT28ZQvCKwtKyLERa+Vwu9vrbWw8RPZTtUeQv0+uIhrpBqfZQ/XKCse?=
 =?us-ascii?Q?4Uw6Cwt2Wzm33s6UphMIkJmrEysSZOQuXpv/PodAa8NmWhUhv2PjgfeIbCcB?=
 =?us-ascii?Q?jFH4rO9jCVuLvStt6g6xTSpvlCrfEutWI4hZ5fftv8hdtJZ+BrHcImlUgzhS?=
 =?us-ascii?Q?UfU+SkxiXKo6lpF2sKa05JW5LBrcSMg0UI2YfUOXah7Sm/zuNECo7OnnRx4R?=
 =?us-ascii?Q?Sy/JDBY/TaWxuirQ+kXP8/784yokGpezCat+SOz2lgY6RaV+uyF9kP2h6Q3o?=
 =?us-ascii?Q?vsn/CkrViNEAvBbO9KH+klgci1mN9Zjwtk/JhJOuzXGxfZbHTUy4jiILm1dg?=
 =?us-ascii?Q?Nc9aAH3/1fZGaiBdb40IZACf0r78YoftW1G0q+CrU1LVcHwoZNwuEwZQ6sLf?=
 =?us-ascii?Q?ua8lJmVV4Owt5oyGX6ZkgxmDq3EuT2PUyi5EMGJP4bK7sY14oKsFa7dLAsGG?=
 =?us-ascii?Q?oWXbi6Cv95PW+fXzK78gash39fH4k473T9g5gH4i3Yjd2RWxTJBf3vLXU8Uy?=
 =?us-ascii?Q?UK+dEBWzlpVRr4YRzJWMrnqzn9EnoxleB9sbAUfL6AZ0jASkDu0YaX/Q7omM?=
 =?us-ascii?Q?eZALEAun5piiq/peWk0yaxs8fpRjmshhoX6spXyhrM3cGOJ1QMtR5TILbN5D?=
 =?us-ascii?Q?Bnju9mekyS94tEopswGbhA5fZCUuxpdxy0lnMQF9/av2R/qzMMHEkRWQ5x/W?=
 =?us-ascii?Q?XOUjNpfBmTN/qwcMbLQo2tZLWR8Pu3M78ih0TpULLxylQJgUICvKlM37g1/i?=
 =?us-ascii?Q?l4xCmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oY5tezDWnMRp9zpEt3E+CHzoKJ7tUiZVjrBarjiO+uxsBH1cw4bb2axt/aHmDtGk2zf28n0Ba1Hel+4vtLdVNur1jbs1BUvq/KypasJxN/2M9dwQn7ll5I5D+SClWU0UBvvBIvWak6iJ+91XUf3Kc9HoGNG7fgKsZWPnZnGeIIvjaimXS5FwkdNn2ws40/YNkwRrr7IRW+T05ZqVDPP4Vco44VUKWO8hwWxc5cdhWUFgagSaYSa80Er/6cah9Rw4NBUeWlJnzQMSrK6kkuZcSJi7hMqMj2jncKsyS0iVtR+dzC0Lw6ZpsTzy7fDZeUdwhlVNW7XeApUz8e8MojX+gHSywu+r94EfPpIRc6W8gZ6RRoSFq1G3bZmapPh//6Hg99XGck5lvIms4mkns6kEJTpbcpkmgkq6dEN69XACs8LKr5GXZ+1PyLDc+Jj8nKSZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 19:57:24.1778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84069bce-b753-410e-97c8-08de629548b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075

On Mon, 2 Feb 2026 23:41:42 +0800
Zijing Zhang <zijing.zhang@ry.rs> wrote:

> 
> 

Hi Zijing,

Good to see you working on this too! Welcome to join the party!

I think "thin wrappers" were indeed the initial thought for many of us.
However, after several rounds of discussions with maintainers at the
summits, the requirement has shifted towards a stricter, OO-style Rust
abstraction rather than direct wrappers.

The key takeaways for the current direction are:
- Enforcing boundary checks via the Io trait backend.
- Using register! macros for definitions.
- Implementing proper Rust iterators for Cap discovery.

Since nova-core relies on these specific safety features, I'm pushing
forward with this high-level abstraction. For nova-core, our immediate
need is accessing and reading registers in the SR-IOV capability.

That said, there is plenty of room for collaboration to achieve a complete
framework! For example, support for normal configuration space
capabilities, the iterator implementation itself, and capabilities other
than SR-IOV are all areas that need work.

Currently, I am waiting for Alex's Io trait cleanup and refactor to settle
before deciding what should be included or changed in my next re-spin.
Also, any input on how to best organize the traits between normal
configuration space caps and extended caps would be much appreciated!

You are also welcome to reach out via Zulip for a quick discussion or
catch-up.

Z.

> On 2/2/2026 11:02 PM, Gary Guo wrote:
> > On Sun Feb 1, 2026 at 7:42 AM GMT, Zijing Zhang wrote:
> >> It introduces `pci::Device::{find_capability, find_ext_capability}`,
> >> thin wrappers around the PCI core helpers (`pci_find_capability()` and
> >> `pci_find_ext_capability()`), returning the config-space offset when
> >> present.
> >>
> >> In `pci::CapabilityId` and  `pci::ExtendedCapabilityId`, Capability
> >> IDs are wrapped as newtypes with `from_raw()` plus a set of common
> >> constants.
> >>
> >> An in-tree user is added to Rust PCI driver sample to exercise the
> >> new API.
> >>
> >> Previous versions (v4)
> >> https://lore.kernel.org/rust-for-linux/20260201071450.1614172-1-zijing.zhang@ry.rs/
> > 
> > Also I'd like to mention that Zhi Wang already have a version adding
> > the same feature on the list, sent before your v1:
> > 
> > https://lore.kernel.org/rust-for-linux/20260126215957.541180-3-zhiw@nvidia.com/
> > 
> > I'd recommend to work together for the feature rather than creating
> > competing series.
> > 
> > Thanks,
> > Gary
> > 
> >>
> >> Testing
> >> ---
> >>
> >> Build
> >> - x86_64 defconfig-based kernel with Rust enabled (out-of-tree build)
> >> - `CONFIG_SAMPLES_RUST=y`
> >> - `CONFIG_SAMPLE_RUST_DRIVER_PCI=y`
> >>
> >> Runtime
> >> - QEMU x86_64 (i440FX) with `-device pci-testdev`
> >> - QEMU x86_64 (q35) with an NVMe device
> >>
> >> Changelog
> >> ---
> >>
> >> v2
> >> - Run rustfmt on samples/rust/rust_driver_pci.rs to fix rustfmtcheck.
> >>
> >> v3
> >> - Base on pci/next.
> >> - Add `CapabilityId`/`ExtendedCapabilityId`, switch
> >> `find_*capability()` to use them.
> >> - Document the common ID constants.
> >> - Update the sample to use typed IDs and exercise the new helpers.
> >>
> >> v4
> >> - Minor doc/style nits.
> >> - Use early-return style in `find_*capability()`.
> >>
> >>
> >> v5 (current)
> >> - Fix sample build by using `pdev.as_ref()` for `dev_info!`.
> >> - Use `as _` in constant definitions.
> >>
> >> Zijing Zhang (2):
> >>    rust: pci: add capability lookup helpers
> >>    samples: rust: pci: exercise capability lookup
> >>
> >>   rust/kernel/pci.rs              | 150
> >> ++++++++++++++++++++++++++++++++ samples/rust/rust_driver_pci.rs |
> >> 31 +++++++ 2 files changed, 181 insertions(+)
> >>
> >>
> >> base-commit: ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba
> > 
> 
> 
> On 2/2/2026 11:02 PM, Gary Guo wrote:
>  > On Sun Feb 1, 2026 at 7:42 AM GMT, Zijing Zhang wrote:
>  >> It introduces `pci::Device::{find_capability, find_ext_capability}`, 
> thin
>  >> wrappers around the PCI core helpers (`pci_find_capability()` and
>  >> `pci_find_ext_capability()`), returning the config-space offset when 
> present.
>  >>
>  >> In `pci::CapabilityId` and  `pci::ExtendedCapabilityId`, Capability 
> IDs are
>  >> wrapped as newtypes with `from_raw()` plus a set of common constants.
>  >>
>  >> An in-tree user is added to Rust PCI driver sample to exercise the 
> new API.
>  >>
>  >> Previous versions (v4)
>  >> 
> https://lore.kernel.org/rust-for-linux/20260201071450.1614172-1-zijing.zhang@ry.rs/
>  >
>  > Also I'd like to mention that Zhi Wang already have a version adding 
> the same
>  > feature on the list, sent before your v1:
>  >
>  > 
> https://lore.kernel.org/rust-for-linux/20260126215957.541180-3-zhiw@nvidia.com/
>  >
>  > I'd recommend to work together for the feature rather than creating 
> competing
>  > series.
>  >
>  > Thanks,
>  > Gary
>  >
>  >>
>  >> Testing
>  >> ---
>  >>
>  >> Build
>  >> - x86_64 defconfig-based kernel with Rust enabled (out-of-tree build)
>  >> - `CONFIG_SAMPLES_RUST=y`
>  >> - `CONFIG_SAMPLE_RUST_DRIVER_PCI=y`
>  >>
>  >> Runtime
>  >> - QEMU x86_64 (i440FX) with `-device pci-testdev`
>  >> - QEMU x86_64 (q35) with an NVMe device
>  >>
>  >> Changelog
>  >> ---
>  >>
>  >> v2
>  >> - Run rustfmt on samples/rust/rust_driver_pci.rs to fix rustfmtcheck.
>  >>
>  >> v3
>  >> - Base on pci/next.
>  >> - Add `CapabilityId`/`ExtendedCapabilityId`, switch
>  >> `find_*capability()` to use them.
>  >> - Document the common ID constants.
>  >> - Update the sample to use typed IDs and exercise the new helpers.
>  >>
>  >> v4
>  >> - Minor doc/style nits.
>  >> - Use early-return style in `find_*capability()`.
>  >>
>  >>
>  >> v5 (current)
>  >> - Fix sample build by using `pdev.as_ref()` for `dev_info!`.
>  >> - Use `as _` in constant definitions.
>  >>
>  >> Zijing Zhang (2):
>  >>    rust: pci: add capability lookup helpers
>  >>    samples: rust: pci: exercise capability lookup
>  >>
>  >>   rust/kernel/pci.rs              | 150
>  >> ++++++++++++++++++++++++++++++++ samples/rust/rust_driver_pci.rs |
>  >> 31 +++++++ 2 files changed, 181 insertions(+)
>  >>
>  >>
>  >> base-commit: ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba
>  >
> 
> Hi Gary and all,
> 
> Thanks for the feedback.
> 
> Zhi's work on SR-IOV is excellent and provides a higher-level 
> abstraction. My series focuses on providing the fundamental lookup 
> infrastructure and typed IDs, which are intended to serve as a 
> general-purpose foundation for any PCI capability interaction.
> 
> These two series appear to be complementary. I am open to any 
> integration path the maintainers prefer and would welcome Zhi's thoughts 
> on how we might best align these efforts.
> 
> As a newcomer to the community, I am passionate about Rust PCI driver 
> development and appreciate Gary's diligence in maintaining the 
> subsystem's quality. I've taken note of the feedback regarding the patch 
> frequency and will ensure to allow more time for review in future 
> iterations.
> 
> Thanks,
> Zijing
> 

