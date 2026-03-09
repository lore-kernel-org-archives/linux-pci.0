Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E6258EFF;
	Mon,  9 Mar 2026 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088835; cv=fail; b=iiWX7dc7IPIwAQUPinYNFWB4rift1ajSJiLjI+8RUwxV/SqTmz/W53bI7hdey979s7YYHsWI4HO00wFQb6Sey8LnhVcMw2PXduiQpU4sG7Kay9+xZdHez4PIoWf0nEPyWMyxqdSp6Ly/Djn3s6TLbBRP2b+67ixBAp9WDQyw6co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088835; c=relaxed/simple;
	bh=tluvkzF+o2+ozgMPQ0SIYqrfBw65PVsFe1VQyvL34G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q6MtdKv044wnrW07Ti1w5TcmhqSTS8xru/UVACp/9LJ9Qc5KoBqaPX8IU2WiTcsPkDqyyRrgfpf5kqgZyNySeD0y/nUnNVGZ/nV5CVJfE4eOhirdFF2kvl6VzFfr74BEE6rsua1D5o95HYPYWCxO/Hn2c1SrYTw95O084FRp08w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RqMGqG1k; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RqMGqG1k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsPIHwqpgdPguBwfp1G2NaT0J2cFv2EJnpfE3ER+9MtUPt+/w6qZJsLt+F/gxxpQSXznK1wLHrISjt4j9KO2k3dJ46rypQpur8DmUup+v29u50pUG6S12RAPgKEjKFXX0yLFvmWssCvJaax3ed5e6daL6Zs2Wm0UqQcBTIhGbrFmA5sNzltgNPotlpT5ZxCvP1ZBV3Gq0kXA63A8PJuLYAPEO1ZW+RUx/FRhaaRS5+vdzgpiilLV92zfUGXHT8pOw+w+qzs8Pe5jNKzfkvj4DzfON9kvF0PukPwiUTEaNcWa+gcPWJlv9bH+C9I43xhBGMCftPXkgo7+W609vfGMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j6KGFACi9yq1KfsxU77RYRUzzD6D5WJfRIRjZGWf2I=;
 b=CwlVdbL6qY96dFFgsFz4xUbaISijBng8P9QhEKK/kU2FWmYH2K9IeaPrlokCXtbKERMWB/lnQLzT6x35AZHvpmZDMGqyhTQ/rxm+Om2AlElcsDQK8KF9kL6wJe/pSTrSmhifJhNqG51l/RsYkgtyGXBycuztpgZmBpnGXms8LPeJN064DjTYMXp7sInujGQ9+daTbBZts4q9elLq0T4RTUUpPkN0f7gdA5aAhoZbtIgV2bz+A4+Aka/n5UhNHuFfJkNIeV2g3lAPtEFUtKU775xyNS6lHZ1fP4w5TtGoLWDZ3ikDoajd7y29CkF/4cijFpXykl+YDWiIdI5E/ymj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j6KGFACi9yq1KfsxU77RYRUzzD6D5WJfRIRjZGWf2I=;
 b=RqMGqG1kKfz7d4kwCsMWXwUtaH6zSpPSgwsBYk8M69uAC1vSE1YogFT4PyPmrd4LRBJ0N3ZLFMjnX2l6rsWgsT3QEKl3CyLuXKcX+jKBKYERMaNAhFxTo3FOIPo63x6q2ScsiWmmnjEVCqTN9Dg5PiCn5oz9+4Rx1S/D3Tf2Fxubi45SfgixB0rSSN+ckvFAxkChQphHtNorT5NuBegQ3Z2XXcqno2a/Dc5ZMoUdaSWJOJUWjmY/7T6SzCfnLKbPhoeXK1x60xQ2TK9AKM0Xq3vpG1Z/FztVxMFVKBxuELysPQsEsrLil9RJh26j0mp7HJkhGblSUcYOXhrK0YVt9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 20:40:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Mon, 9 Mar 2026
 20:40:27 +0000
Date: Mon, 9 Mar 2026 17:40:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dan.j.williams@intel.com, Lukas Wunner <lukas@wunner.de>,
	Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <20260309204026.GA4132316@nvidia.com>
References: <20260223171527.000016ef@huawei.com>
 <699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
 <69a903d4511e4_6423c1004d@dwillia2-mobl4.notmuch>
 <20260305124837.GS972761@nvidia.com>
 <69a9de4791667_6423c1006c@dwillia2-mobl4.notmuch>
 <20260309113941.00007258@huawei.com>
 <20260309123148.GC3717316@nvidia.com>
 <20260309153339.00007b29@huawei.com>
 <20260309155909.GG3717316@nvidia.com>
 <20260309180054.00000933@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309180054.00000933@huawei.com>
X-ClientProxiedBy: MN2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:23a::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 61cb6879-dd35-467c-dce2-08de7e1c18d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	RWjaK5jtXwwhDm+kQ2l/Ua2gvGr+BYMYrQ3wOen+bACTw1+blknv5ShaAbQk/7002r+gVVLWWrfLrqDiem2JA3pkLQIU1972QDOW8tP3+OnBg4s3xF2TPQQbhgjQ/9rGEB678q/S++DBHPCOhMU+MQMbY9oL1x1uNYVWQ3La7JjO2n6uW+cQBAic2b5qtKftsfD7hvrUYiADz++Gky7Pb168xC4tZkphRkMY8jbxSmznbINzjH4UPHE++lCSzABZ+Ne7shg4FuPMpetFX+ZnDBzT+UDQUAsQuJ/x8CyKOr5lIIeMdbBEPSfAhpJU0T5/nmvugY+29fVj4LYeoSXSDcAWrJFgULUwX560w//bkI128qTM3WMx33Q7ZQKrch2xMjMuMbPSK2apyoTehjAGzjHEam62odLrg+nOdj1rTDkMCWIpaa3LXmEyHDUbMm7qnoK3BrK0ya35rHHYQCdrPhF9OhJ9DUyPkXjB1l44sV4dx5CZgLErkyKz0JpuILC4ToNgeDsLp0hWoi3VAwlQylLyzKB+ylMuupQtt450ch8ghr27WJjPhIuU7yvl+UoIsoPH9SSZIAbvDRUwY6oo083vHoFFr+4ZMDCQ+go0gBFwRXS6Syz8f7ITjLjpuEBl94+cW3BkpQpeVSZsmXKyBj0nXu4tTTVqIUOqAoQTwGH1+vgjG6K6p5cXwGKSQkKvRrd9mQkDb8EVoB+BWhO9gaIaE3ggPc9IafC27DXSZwM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pj/7jSI7E0tpqmLD7vxUl/iG70snnEljqpSWjy5jTWux3G/hboGvxqemqNYj?=
 =?us-ascii?Q?7dRj6Dks6LwamFvLgOYyVeGUe5LpND2k9wF+fQIf9B7rNcsf7EBfQEdZCWfk?=
 =?us-ascii?Q?5pfkBglRUoKAugaHJurx8FxWJ+71j6hzzih76zP15Q6IJploYnCBGHG33deB?=
 =?us-ascii?Q?0Cppq79IVjk/pXLvkGVw60IByq0bHXFvjQOzyqp3JVyOXh9O96f4hoVi6mDs?=
 =?us-ascii?Q?ZejTmNAqC40Y3LcmPq7+qU0Wqe3+G5Y4gJy5t+6z2EIgViOpJmIfsWWhjbgD?=
 =?us-ascii?Q?ZSwAEQpT56wC/J5v0XEH7adsC77tapsossmF2QMU7H6SjQN5On0VlsVLFcA9?=
 =?us-ascii?Q?NymN97a/SNVqgQpFcct3MA4RjzrEThIwc2rvD7cnMvkWAcaeG2ADAH2AIhZ9?=
 =?us-ascii?Q?uWtg7uBRO2ZQ0XZ1uXB790ajfmiZg1aczbIyBUed04hbw75O+O5rgHSoFryV?=
 =?us-ascii?Q?aHoWANsTXpfxOexkNNYoPtc7Lj42+VxLnWuEGaNf/Ah+cllYdZeaQbCete1H?=
 =?us-ascii?Q?exogx6Y2aIkyPoONF26vC+TW1MfefiTTJY4sWDH80VBsxZjC8TeYpPpUo6zw?=
 =?us-ascii?Q?Nf/1gIehOKmtV5wg+OJaylu9lsePAxHcWjDT8w9mBbsMI4snWFPTjGCpX+7a?=
 =?us-ascii?Q?vmAuh8d6LugauBDaSCD6lGPV5B4hG1qcZqoEGB83iO61OBaGyuk77dWJnbpU?=
 =?us-ascii?Q?PGjG9re9bHDxYU5IRJ92HxB2EwOjjhj3oz2GD8U9JJPT+o2tl0q+etxz7EhE?=
 =?us-ascii?Q?OeVYFO9GffngmXguqci5kXyQAgatlDYCpgiJu8t396M0ACbahfFUHkXSmopx?=
 =?us-ascii?Q?xY2DY4FbJEubP+LKIHQEHFJpR3mRH1v0xQCzZhDsMnwmKoBefm2lpJ3+fkuY?=
 =?us-ascii?Q?zglCrfGGU3/yvWvk818VizyULNmPsPE0h8srV9kGpBt/THbN2soV8l0UowHc?=
 =?us-ascii?Q?xg8v/Hvku+z1pw/K6YH0zOfFc72OrtZaE0wGPQ1Cr5BSys8Ts9YcqzvK/OZP?=
 =?us-ascii?Q?wTv+lj1DdhQkzPjyUONOA2Lv6paqpLN158Wm7IXILA4lFNLey7eJTX5u1pmt?=
 =?us-ascii?Q?s8GJ852CmSMEz7GxWwMNdfRoGziP8kqdfQ/S5W7tj7rpZw6Jk0xKvsChP6Hh?=
 =?us-ascii?Q?OxjBO57CacLawavN0nWa16/qsKHb99Gu1r3/IEUn0Ig0Kg+8Gau19VrLfaSy?=
 =?us-ascii?Q?2ovxqeaFzDPxm4mU91hQBqmileJNewdk6KnUcHw+2ssL9hbUfXID2VHh5lZV?=
 =?us-ascii?Q?vq6p23ugBs6Bdq6NLAdVgEd/gXUPiUyRkCH7dgx7XIyLv3qt5Iv/or+Qp9di?=
 =?us-ascii?Q?56TwhkgvTtoyJynUy002ESjj655K6l8b3DNRTQ6Cfn4Jj/jluWwsXztAIr2X?=
 =?us-ascii?Q?zq77FnkFZf2U7AlcZjlXsM3B7T7uCkGpUy5evN7c979y0WgzdXEEqh1Xyx92?=
 =?us-ascii?Q?thXARTGR964fDGTUadHK4tdHChUWtHsu2UOyC7Xb9xi+LzdfvjbA5S5Xg08S?=
 =?us-ascii?Q?yLvOKVroZOFOE9Xb5ORE+E0hbV/ygb3zN1QJr7WrzBjFVX/YAe1fnv2o08Hg?=
 =?us-ascii?Q?SxLGKcpP1hLaA8Tm+s20VmP6cViw1EQOaaPQygKMwyh/oqbyPL/Z4CTwwHlN?=
 =?us-ascii?Q?9pRk2NRsQMbYMeAFupXvoVRP30mkJktiojJ2hB6H/NIOctVMkrvUAhaPac0T?=
 =?us-ascii?Q?IB4KO+CGyOXZFb+lv/aHzwMWjRVZmDuW7JSwWp/pxDoHOHs1RpT8bukigSJB?=
 =?us-ascii?Q?ySq3nmqFMQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cb6879-dd35-467c-dce2-08de7e1c18d9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:40:27.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5KBqZf3J3/1ipPfLgQmu0Wi9Zuyn8xIcBMV+M63sJuVASxlBTZ25bbcrJGUVnOd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847

On Mon, Mar 09, 2026 at 06:00:54PM +0000, Jonathan Cameron wrote:
> On Mon, 9 Mar 2026 12:59:09 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, Mar 09, 2026 at 03:33:39PM +0000, Jonathan Cameron wrote:
> > 
> > > I'm not sure exactly what our security model is in the native CMA case,
> > > so what software we can trust on the host. I.e. does the DH session actually
> > > need to be between the kernel and the peer?  
> > 
> > Yes, absolutely a DH session is required in all cases, it is the only
> > way to generate a PCI encryption shared secret and exclude a MIM.
> 
> Ah. I was missing what you wanted with the DH part. For some reason wasn't
> thinking about IDE (maybe because this patch set doesn't get you there for
> native). Though as I understand it some of the native usecases for CMA aren't
> using link encryption (different security model from CoCo).

Yeah, there are models where you could collect evidence and not have
any IDE setup where you have greater trust in physical security.

> Yes, if you want to avoid MIM you need to bring up IDE etc - the basic fact
> that both ends can still talk to each other after enabling it given they have
> to have the same keys and those went over the secure channel, is part of the
> security around that. 

No.. With DH systems something can sit in the middle and
encrypt/decrypt and you can't detect that unless you sign something
derived from the DH the other side can validate.

> Whether anyone actually implements root ports via standard DOE flows or
> everyone does this a custom way at the host is an open question.

I'm expecting Linux will be able to setup Link IDE, either through a
platform TSM as you say, or through someone plugging in the IDE
registers into some Linux drivers.. I certainly don't want to close
that door by bad uAPI design.

> The secure channel establishment and key exchange comes later in the SPDM
> flow than this patch set currently covers. This bit just gets you to the
> point where you know you are ultimately talking to right device - you don't
> know there isn't a MIM at this point.

Hmm, like I said I don't really know the flow, but something has to
bind the DH into the evidence for it to be useful, if that comes after
(seems backwards, but OK) then as long as the evidence reporting and
controlling uAPI is happy with all these different flows OK..

Jason
