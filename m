Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78A36D516;
	Fri, 23 Jan 2026 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163836; cv=fail; b=j/pj4S1BPzqSUijdp9st36YSVyBl/xSLjgaQzQhALq9a0+S56BS9GCjt1Z/NF62hRPDV5JtKMtOSJGza3nvQyT33EYDfwUMVhx+RVZL9IyRR3YrrGU7ScjDnaksl5b0G2DmZaKU5f4GWhWewKj938APPdQ9MSYiBArzfEGtMFvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163836; c=relaxed/simple;
	bh=M6tqZB6RBELa8ErgcQNMTelZbgV3Fi5ht1WVKyhkIo4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaiU1OSpFegN2A4PIVruDOO4j6o5FfY+4Yyu/ShvJcEN8gSaec18woQuBobdMmktOAEpVqkqZ6z0z5hnwKEN/00g3FQihJ10H3l74QygfTXmzPOkYMi3A7uahvG9P45Vd8D/I50QrRZlrRBo6fWEeyLEM8tybu3uo9PiyHyaAGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RwGptO61; arc=fail smtp.client-ip=40.93.198.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RwGptO61"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYX3hMMZWzkhINEbkpwaBBP5SlLPc6+fh9oJ2HsLiml43fCBnWuzuGSFbC1t4NSw1YRjis9rDoi6AG2QjErDNNEG8+ZIXo+9my9t5wEjcq0xUsFj1WiiMyheVSBIQAY0pnou/iUt7yD/OXKcuyCv1J/DGr9zxOQDL1hbjmvbarwdQf/wjxdq88+mdTMYEAy+r75J63u6rnZuxE/7OjUckPEDssJ/st8fvIGa9puRohQClDbsjsSUanJzxDbT0wkx1toia6o4WKlacEBZAqoUfouopLOr8UYHFrcU8L0O+K3YSEscLsMAYP+sF9Q4VAaMrYJM9kS5fWdmhtOgp/KIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGRkXt8ZQg0KbFtpnP5Vopg1oSSEdVG+uljiXYTtdf4=;
 b=M3N9UwbXrK61P0vLG5YpQ5dNw+Z88wrYSEB5pshUI5Mi+TBt8lyWKst4Bi84X0FurCsmGGxDwDwFCuO/+JP/wciSQKDR1oqAw8l05BzdjRF06OeQWpmdGLdtCdctOeMdCh7NZaiUTooIlU7GtTYhjibrlcmFgaz3O3A1Qzdqk2nJ8783cgsUJJRJ2CUzYzzE+Y8DOHP8VWOJSigWpvxUItoPwcNMZ67BZ3DVqVxzF/OJGKRoEtSvOAQ2CvYb0Tx3T6Dn3oLxTbJAoYAhFVjN2/wgScRH3YsLpZb95otm4q70JGA9MKl1Tq8v+72VcJz3wd1kq1d9mvkI92UQQ71xIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGRkXt8ZQg0KbFtpnP5Vopg1oSSEdVG+uljiXYTtdf4=;
 b=RwGptO61xuakBujjZxxZov9rG+tlyRagJ91TjG1wNI5EStfE5hMZ/qe3XYLVGWSBAvGcInuvPGfABYapx5l93qfDZ2Vy+2A8hXT4CWowy5Aw6b2WReiI/LysASPwCFQrtNu2srLTEhXwxfLODRzYRE1iFCh6dNa2wdOywztcHU5C8fPjUAoINbiYz6Nr51DJWHpExerLw9xdJUUV9cyhgeh/ROZW/5BLrlZ72Uklp7U+J8ec/V/Q4Qvhhu1Vgn14A/WWsZZnl/BOw7pw5bDow7jCP/twmSpyIpZicXQFpEdji93DlLzEXuqXfB+ZmkmSri67z97humqZA+UiKHflfw==
Received: from DM5PR07CA0102.namprd07.prod.outlook.com (2603:10b6:4:ae::31) by
 SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Fri, 23 Jan 2026 10:23:48 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::5) by DM5PR07CA0102.outlook.office365.com
 (2603:10b6:4:ae::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 10:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:23:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 02:23:32 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 02:23:32 -0800
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 23
 Jan 2026 02:23:25 -0800
Date: Fri, 23 Jan 2026 12:23:24 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
CC: Danilo Krummrich <dakr@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 2/2] samples: rust: fwctl: add sample code for fwctl
Message-ID: <20260123122324.28fe6d38.zhiw@nvidia.com>
In-Reply-To: <e1dcd6ab-ab5b-4974-bcb7-2af59ccd2920@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
	<20260122204232.15988-3-zhiw@nvidia.com>
	<20260122205806.GU1134360@nvidia.com>
	<DFVF9XC0S46O.V7YN7L3QWB3M@kernel.org>
	<e1dcd6ab-ab5b-4974-bcb7-2af59ccd2920@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f66bfc-0367-4cda-e50d-08de5a697ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qwyu/SEM6RCWjcJnNgCPXC3iAFD8wrSei0RPGDuNFDscwXOp87mGPnzHjOfg?=
 =?us-ascii?Q?iDYE/T2nBUV/D/qVIMl7XT8bni9tXEHRCI5HJ96a1ufi5KvLRv0Ge6SEUY0F?=
 =?us-ascii?Q?qdTUQANmww3vtwgLVrVBAvoHud41uLsR8YcQnqmC4m9MRPiQFZJROUh8T1tq?=
 =?us-ascii?Q?eFRFi9IxodH1j8VeTzK6tb+f+DTehAayJ0FtX0qgGsbbzK8gA5VQStXxfdpg?=
 =?us-ascii?Q?m18kcEqj4pM/0XHXJPz4JalhJr3zqRrp4ok7HN2yThexw9jtKpS+38g4A0jk?=
 =?us-ascii?Q?JfHPihrDlGkbOqGK9fdgUJKDqSntiU6i5Nkql6mmef+5M1XSkctSgtQLnTGC?=
 =?us-ascii?Q?gv61z/R8pyrmp3UKAT9PDzJ8XJFCLizUT0MSwMgcRVVhc0zRt2t2BuclkAQT?=
 =?us-ascii?Q?X5wkOhyGnzfjMZT/BNWMSM2NzDy37Gz0Evz2NmKBSfeFBPbHT/vU6Zu15/Hk?=
 =?us-ascii?Q?jKLSkqDb+D6dBPfZ2g6FD1dj793q7dn1V/ZdXbSlwhrpeBHMvo0cYfdRZ+vL?=
 =?us-ascii?Q?NkIqUA7nRmiNqE89MByko6ySVMHgLgjnp541MZ6adym8dlMYox/6dLVWrkTT?=
 =?us-ascii?Q?nF9nw0x9uN/ZzhCAQ9Qjk/Ja+UHQ4ZIC2IP5JzT1LmAX+vwFwPIPF5s14lBy?=
 =?us-ascii?Q?YH0nzD/Xpi38lWE2WGeWYQhM01IPcJnwZHUX63onMSUX6WX/mGCfuYCTOUgq?=
 =?us-ascii?Q?wiDAyAtWF17e9AyDB7Ims0FzzocELPZ/g3BQay4JFtYedtAoRgLUa5y0eZwO?=
 =?us-ascii?Q?WtTrhn2ysDrQ/7siJDqiha6amzqWz5RLHZA5fCEkr6u+ozI/8d5MP/H4jqk7?=
 =?us-ascii?Q?0ZXJaDyYXLIeyn1Kg0MDfBbfC0FSIRkLhvauM9v+M7hIyxQ3b/4gUsAx69WZ?=
 =?us-ascii?Q?ueujmQa1d28WqQj84fb7M0k99bJhbw3ZeZc7jxciYQ2GHF1J4Vh3DX9Z3iih?=
 =?us-ascii?Q?aM0+fY4c1daiCYOvN4HSMgH0nf6jEFBGbD9ES3gs2yi/6M7RBLs6ZOhJd36R?=
 =?us-ascii?Q?Mmdm3ARbyADkgmVk0Jt6TKTR4R4rTeoIeEtuQfMjQ9C1FPxWcKF+7D6hRDJr?=
 =?us-ascii?Q?BystIF2YATlDLILNHWcja2LI/rE8itOCZjYJRBYr59HqyaQrtPoqP6y2m/8C?=
 =?us-ascii?Q?L5xQy4++LE+0eM6MGhHEyafgnIA4/2wy+4wmfUX6d3rRbnDa1nM7kNCsNX1z?=
 =?us-ascii?Q?1wRx2nidszBeFTjebWgK+INm9LrO/4cpKBOk5XasAwoB5Uxupny5sNCuEHDx?=
 =?us-ascii?Q?X+5sPgSbXMNoWzwoKK5JpKm0n1S0rjJLX2GHwTRF/Q13yYbYp/C6OtKVa3x9?=
 =?us-ascii?Q?9lkfVfT9eLVRG/0m4Qj1Q5oWVsU5QSSZPDe6U4WMyREu8itNA4vQCEwH+BVR?=
 =?us-ascii?Q?ufW5u4qAihYIGrPh9OwvLa4Y4yZoh/eBgWgvs0fN526Q0sNtmV4r7tk9pdV+?=
 =?us-ascii?Q?87EHkeQ0qFlMc994a8VUFXW19bXWPtOYA7FJjc0TQfG6dfb6GHc6U6JgdAct?=
 =?us-ascii?Q?AA078GkpYx+N84Qa0zOz0ZZ4oysfHsX+jGca196VwQKzkRwHnVGzradqvho2?=
 =?us-ascii?Q?MMElvY1BgVHWubrWYSjZOrFMwn4hUJ8k9itvNA2UaQ3sextJR0RL2A9drQx/?=
 =?us-ascii?Q?UqVLPqg6eg/MEl+dc7P2VhMjX2pfNw+/KpOfeHOQHuvdwEjd/bjQOZ3PpKUV?=
 =?us-ascii?Q?URKWng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:23:47.7195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f66bfc-0367-4cda-e50d-08de5a697ec8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

On Thu, 22 Jan 2026 13:16:29 -0800
John Hubbard <jhubbard@nvidia.com> wrote:

> On 1/22/26 1:06 PM, Danilo Krummrich wrote:
> > On Thu Jan 22, 2026 at 9:58 PM CET, Jason Gunthorpe wrote:
> >> On Thu, Jan 22, 2026 at 10:42:31PM +0200, Zhi Wang wrote:
> >>> This patch adds a sample Rust driver demonstrating the usage of the
> >>> fwctl Rust abstractions. Add sample code for creating a FwCtl
> >>> device, getting device info and issuing an RPC.
> >>>
> >>> Cc: Danilo Krummrich <dakr@kernel.org>
> >>> Cc: Jason Gunthorpe <jgg@nvidia.com>
> >>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> >>> ---
> >>>  samples/rust/Kconfig              |  11 +++
> >>>  samples/rust/Makefile             |   1 +
> >>>  samples/rust/rust_driver_fwctl.rs | 136
> >>> ++++++++++++++++++++++++++++++ 3 files changed, 148 insertions(+)
> >>>  create mode 100644 samples/rust/rust_driver_fwctl.rs
> >>
> >> Is this normal for Rust? Can we delete it when a real driver is
> >> merged?
> >>
> >> I'm not so keen on sample drivers, I've spent far too much time lately
> >> touching sample drivers that nobody ever uses :(
> > 
> > I think it is pretty useful for review purposes (at least as long as
> > the first real user is not yet ready) to see how it turns out from a
> > user perspective.
> > 
> > It may also be pretty useful for people starting out with Rust in the
> > kernel, as the samples have a very limited scope compared to real
> > drivers.
> > 
> > But there is no policy or anything, i.e. no need to keep it. There's
> > also no need to even land it if you prefer not to do so.
> 
> Zhi, the real code that uses this for vGPU is going to be posted
> soon-ish, right? So we could use this patch as a review assist, like
> Danilo mentions, but not merge it, because the real code will suffice to
> exercise the new fwctl functionality.
> 

I am OK with any solutions. My motivation of updating this one is because
of many changes and improvements in this re-spin comparing to the RFC. As
Jason/Danilo gave quite some feedback on RFC (Thanks for the review
efforts!), I would like to start the review before the vGPU patches.

Z.

> thanks,

