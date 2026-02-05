Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A056B3ACA71;
	Thu,  5 Feb 2026 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292666; cv=fail; b=tKhFyYjuXqdWit9ln91nuu9c5y+VqqLsbizM0ZWsy6ifJdhbdbENR43e84JtsomdoCdNOROL1vDI+x1Xm9rHrk0hM074dyR3mqKeamp+3LTQjTwtiKnZ7OCuGcDphoxiYQmOFY46NOixC+fJfSuX2FiNzuN7vqmWEtlZt6sd1bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292666; c=relaxed/simple;
	bh=EO+rWNlKje0a32amTTmpDk5HHZvuTIJyIT/kjaPyfxk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cxh3o7CJY/ZkNssvURhDImzk2WmeAFbmNoewznDqMudj3XSZY5Plonem+Lxmv9/8k3DaRMWuLpiVMg7Vw8KF3T2QTCmcfEpsN2Szksi7ZB7N5ClNNqCBQJvHolgka6YeKvGLUSKMBQA7+TPBN0DUk8tJcoyb2qPKhB0P8qKxkBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OgOpx+Sg; arc=fail smtp.client-ip=40.107.208.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OgOpx+Sg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlT8kLuztbVRuFt8ALLEpOFR55K1VGt8YI6ht7uNuVkuaEZY7EYnYMfknBqTEHxuAbMsGAQRwDMzuHIoWqZI4qABPn6ZBL3G9H3ZrXPRW4r+XQ+Kp7mGZbhAyL2kX/aV0a7twe8rs6DY9LPAefwX1Hih20J1hbYfhYH7wWOcBP7pA9x8Trbj8MMupQi2toFvd/QDDzqulBYLQeo4kTFCIIcATB4lrhgoWqZB6LCL/vKHfYVE8fq1/aYRmlcH71pSlKz8iHlWzVYvKV4tR93ye88XMUQ45m3J2aHCiTkTOxA88+aFbsN72HG3tvO5PE/Gh/BXlkIYEf6c6m0Os3sLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX29Pc+cVVr86hKuFyNzfmvus6o4UTbiLAxn8LpuEr4=;
 b=pAVWsuRnhclRcEoN5kof8GNKVRCe1tFdiigZ8cMYG3ENVNSoyXFeRYc3s/qF1Gs6VwSlULiEmKlIi/GbYxKg1dJXJD0C6Ebo8pZJEd8NiIFiQ7ZJO2cybBTgEGMz/2Qz6TtOZmPstvZTY/3fNsxA6+QThwh1oambnRxl8eO5HwSsEOcpv+/QhB+ikLzP5L9eitmOwEwgO4Pcowzmkkue/aJkVuNRTwU5sYVb6+z6G7pjYdpHaubfScBsEHTmJMO9H7TnYSoRvrU6L1tgYafX+kuKYabio2jWOgK+aBj5OQmD4blnQA2Q2I0LQUDZ0ITlk5dZUggSPOIsvePC7KPG6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=garyguo.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX29Pc+cVVr86hKuFyNzfmvus6o4UTbiLAxn8LpuEr4=;
 b=OgOpx+Sg4ykulexc/Pq+VeuDjihR2GTr1sM1pb815vbXndfrWS4z8GajFA2XNc4yQTFRipAKDW32Htc+a9NzshhGeiJTGJYG6OAMMNJPKieDDZuRgdW5YMpROFjQ8rGXScq4/9KYUF9a1G2s2RAY1gjChZmv0/qCPyuXbS68940loxW9LDzWWQN1fUYBLW3eqIVzyknYRUelIPCL74u63zznXnW1G5rdKLxkO1Bs9osuAjsazvaPWDHwrazCUKj5+OFvB9bNgjWc+hdGk+muwMYgG6z/xYSge2Cur8pmiNPPrrVjkezQEEfqnXW0NCb4S4x+ArzcyiyY5MagxjQc9A==
Received: from BN0PR04CA0131.namprd04.prod.outlook.com (2603:10b6:408:ed::16)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 11:57:37 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::27) by BN0PR04CA0131.outlook.office365.com
 (2603:10b6:408:ed::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 11:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 11:57:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 03:57:22 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 03:57:21 -0800
Received: from inno-thin-ubuntu (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 03:57:15 -0800
Date: Thu, 5 Feb 2026 13:57:14 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Gary Guo <gary@garyguo.net>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>
Subject: Re: [RFC 2/2] pci: Add PCI capability infrastructure and SR-IOV
 capability support
Message-ID: <20260205135547.2ffc0df4@inno-thin-ubuntu>
In-Reply-To: <DFZHE3PGMQHS.3F108QF6VQEQ7@garyguo.net>
References: <20260126215957.541180-1-zhiw@nvidia.com>
 <20260126215957.541180-3-zhiw@nvidia.com>
 <DFZHE3PGMQHS.3F108QF6VQEQ7@garyguo.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: cddbfa01-0614-4bdb-a467-08de64adc17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CmFwOkCCzdLob/Cot6Rl8fep8f4HfYiIjFhypEgpQKbgASay1gArvsn4zrlw?=
 =?us-ascii?Q?aVsIjQLoVJFliMuVjbJ8tkQjESK7O5RQeV17Lb0hPZ8tuQSsIIxrZA94mE/g?=
 =?us-ascii?Q?ZbDoOA7NSQM7/rYsPL3gMtWt7XCSe9o48gKAbgCZNIBkD2VBjqpJwJl2A6eQ?=
 =?us-ascii?Q?t24cJX8hrmwR+HpX/EO1eOJyGaz+b6JJ2rVZDmAF+kpKBYqgVB9E4Uypuc/i?=
 =?us-ascii?Q?qHj4cpDzBzorxRHww1yFfnhUL2o5imVVAGALODfYcOISj0aijs0vRflQZCAx?=
 =?us-ascii?Q?QpN3kigNWRFGd4krZJiMzurKDYSjVgVs5ig9RNntcyVJR3ZsWB3bEcWFGJe2?=
 =?us-ascii?Q?b0wHf4LADIGwiOYDNWFBM3eGApxyuOypNXgzH3kNhAeezZwNzGASFElyPzSp?=
 =?us-ascii?Q?0mlj0z1RP+xCBkqzorN3mttLDW+LYZBUx2IeGBVO3IHLusFXsgtIFrAHpzCo?=
 =?us-ascii?Q?dnzMPbqTojiQgzo0OztN1GiVSSQ12kSrXABkcS6witQo+qrm9FnSObpSyxhO?=
 =?us-ascii?Q?4UdgCpviVGKsSRq7Iq9bIZn+rPOX/4eCscQeRnjP7WkwRIDClQ9ykvTBT6Yo?=
 =?us-ascii?Q?n5Mqxi5ArS0bIpaMxMhR/JvvL26zZD9aIWGS19WrRJ+Y//t4yL/2yJN6ZYSC?=
 =?us-ascii?Q?991fB2b5jh5Jiu3/nVOylIpdxW3SDsPTAMonEyaykKWkLs4TFa/tXM1d82/3?=
 =?us-ascii?Q?tZUGJnqqVxRkOI/pIB06HPXbif7SKCfZj4x119Ob04BJZTU2o/fWzb7UFqQZ?=
 =?us-ascii?Q?kuH4smZYBVRdZt1Uhv2gqmnNd8GdQDXZr0/ytOW4IHHO+Zc8jPKEo+Iqnbjw?=
 =?us-ascii?Q?RGkCCLpWUKWyOrctfHYalmtIwIWp4S1DCLVUkjd45ewLAQxznyTPIW9ZsydA?=
 =?us-ascii?Q?engyesRT0FdbwKxP9JLMrkTKtVlHLFWljP3foVJRxDzll51OqCt9K9/SGZ1u?=
 =?us-ascii?Q?EdwnhLlS49vFlbLii7tmn6vibC9mP6419O94R7xz1RtO+qZKlcM3foQmQECN?=
 =?us-ascii?Q?ndeQBVs1IXlmN+YRKqlgeGxXeodKmgdBYPD2jBS9ULBiv2up9m1YlUeHDlMR?=
 =?us-ascii?Q?7E+G+jYlqjA3Fql7Io6gK76MbcV97NXJS5dMe9amcf8Hf1c2c/bt1/3F32Re?=
 =?us-ascii?Q?qznm01nWAQgkd1+G0MugU50/I/QHZUtujme4dXFUaRmBnO7rN0OmwPjAjJoP?=
 =?us-ascii?Q?0XUdk357MSkWEY3Weztq7ClNtt+xnSzsx5a3qJVOl9nL46TT1ieXK4hfdI63?=
 =?us-ascii?Q?4rQlAYYHbL6eCJF9K+CqkrOiQ/S3a2LGGqoagpUl0Ul5nJBmM0tSGhJqXgHp?=
 =?us-ascii?Q?woax71XjwU+exAXHCaFf+wgPSQRcS2bXKNmmp28ufs/HCM7bWuoJ4MOhwbDf?=
 =?us-ascii?Q?uEmx3B81mSS3U4oW8WHY/zDwmlcCcbJX93Z7YGWoKYqgldgvqR3b22ZoUQuU?=
 =?us-ascii?Q?9fQXUacSYwXjXBNyLiB9iGGQnkb+QGzu9pm62e2TVt89KUpQ/YqJtpSz5IzO?=
 =?us-ascii?Q?/n2ZlvEI76mGU1l2ZRhP62gjpOAu+QOGdr+d3jlgUt2dY7kZsIPglbm4YXWY?=
 =?us-ascii?Q?PU2Suc7yiKKGykOfkhJKMS0thiyFG9HwMkGlbHOjvMNUkl1lWVrEEf7/ZLoE?=
 =?us-ascii?Q?AZ0G9X3QaOplMEf4K/qL4uKiRlgiESfIfdqctDpdJQmWc0NRk/rnD1zxaCsZ?=
 =?us-ascii?Q?zVbuig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JJ6M1l04QZfmn/oMpfQYuuCGuNb7i19tvv+HO0pgIapCFNZHdEVX5++PwZ1UZa5hpChkSiOAppuaemtQ58FGTiVvVp1oMpmzuRwLccmpYB8KcrrSj+eZCRPVWarnPDc7SRPDIVEpN6WzGhqPmtUga00jYgiFSDlPTTJtZLmKHPsHiy1RANePTeFaXBMtKgI6IRsiqGf1+OBi7fj/5qjvlkQqN/sc4Qc3zVmQ57QHgTHiGHysuen9zm0pzXX+AjUC76ZfZZepuEbDYkFqdwZr5vsik5rQtaCD94c5T0o+jOTHG4SW4D/XGVIF3ZCHbLFnXNNTba+5VntuakZIby9X5VunHzu8c6/qW4qzxANmd9KNAgRd0JA3KPcTha3J+yw/jPOYg4mT5EnjpgOqIt5geXQn9ihJa0rmkt7URrnftTZ58EGoiyGil44w0YRrq7ae
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 11:57:36.9827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cddbfa01-0614-4bdb-a467-08de64adc17e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729

On Tue, 27 Jan 2026 15:36:29 +0000
"Gary Guo" <gary@garyguo.net> wrote:

snip

> > +/// Marker for normal (legacy) PCI capabilities.
> > +impl CapabilityKind for Normal {
> > +    type IdType = u8;
> > +    const START_OFFSET: usize = bindings::PCI_CAPABILITY_LIST as
> > usize; +}
> > +
> > +/// Marker for extended PCI capabilities.
> > +impl CapabilityKind for Extended {
> > +    type IdType = u16;
> > +    const START_OFFSET: usize = bindings::PCI_CFG_SPACE_SIZE as
> > usize; +}
> > +
> > +/// A PCI capability.
> > +///
> > +/// This type represents a discovered PCI capability and provides
> > safe access +/// to its registers. All I/O operations are relative
> > to the capability's +/// base offset in configuration space.
> > +pub struct Capability<'a, S: ConfigSpaceKind, K: CapabilityKind> {
> > +    config_space: &'a ConfigSpace<'a, S>,
> > +    offset: usize,
> > +    id: K::IdType,
> > +    size: usize,
> > +}
> 
> Some thoughts about this: given that the IDs are different for PCI
> capability and PCI extended capabilities, it feels that we shouldn't
> overlap them into the same type.
> 

Make sense. Sorry for the late reply as I was evaluating what would be
the impact of IoCapable trait refinement to this patch.

> The `offset` and `size` feels like it can be something more generic,
> something like
> 
>     /// A subview into I/O.
>     pub struct IoView<T> {
>         io: T,
>         offset: usize,
>         size: usize,
>     }
> 
>     impl<T: IO> IoView<T> {
>         // ....
>     }
> 
> This is just like a slice, but act on arbitrary IO.
> 
> The capability enumeration can just be something like
> 
>     fn capabilities(&self) -> impl Iterator<Item = (CapabilityId,
> IoView<&Self>)>
> 
> and another method for capabilities_ext.
> 

I actually had a version of that, but dropped it. The C side already
handles finding capabilities by ID, so a Rust iterator seemed redundant
for the common case. Unless we need to handle multiple capabilities
with the same ID (which is rare). IMO, it might be better we add it when
a rust driver really need this.

> If you want to add typed capabilities, an option is to have
> 
>     enum Capability<'a> {
>         SpecificParsedCapability,
>         Other(CapabilityId, IoView<&ConfigSpace<...>>),
>     }
> 

But given that the kernel's C API favors looking up by ID, usage of an
enum might be slightly awkward here (e.g., calling find_capability(ID)
and still having to unwrap an enum)?

> Thoughts?
> 
> Best,
> Gary
> 
> 
> > +
> > +impl<'a, S: ConfigSpaceKind, K: CapabilityKind> Capability<'a, S,
> > K> {
> > +    /// Creates a new capability handle.
> > +    fn new(
> > +        config_space: &'a ConfigSpace<'a, S>,
> > +        offset: usize,
> > +        id: K::IdType,
> > +        size: usize,
> > +    ) -> Self {
> > +        Self {
> > +            config_space,
> > +            offset,
> > +            id,
> > +            size,
> > +        }
> > +    }
> > +
> > +    /// Returns the offset of this capability in configuration
> > space.
> > +    pub fn offset(&self) -> usize {
> > +        self.offset
> > +    }
> > +
> > +    /// Returns the capability ID.
> > +    pub fn id(&self) -> K::IdType {
> > +        self.id
> > +    }
> > +
> > +    /// Returns the size of this capability in bytes.
> > +    pub fn size(&self) -> usize {
> > +        self.size
> > +    }
> > +}
> > +
> > +// Implement IoCapable for Capability
> > +impl<'a, S: ConfigSpaceKind, K: CapabilityKind> IoCapable<u8> for
> > Capability<'a, S, K> {} +impl<'a, S: ConfigSpaceKind, K:
> > CapabilityKind> IoCapable<u16> for Capability<'a, S, K> {}
> > CapabilityKind> +impl<'a, S: ConfigSpaceKind, K: CapabilityKind>
> > CapabilityKind> IoCapable<u32> for Capability<'a, S, K> {}
> > +
> > +// Implement Io trait for Capability using fallible methods
> > (runtime checks) +impl<'a, S: ConfigSpaceKind, K: CapabilityKind>
> > Io for Capability<'a, S, K> {
> > +    const MIN_SIZE: usize = S::SIZE; // Use config space size for
> > fallible bounds checking +
> > +    #[inline]
> > +    fn addr(&self) -> usize {
> > +        0  // Offsets are relative to capability base, not absolute
> > +    }
> > +
> > +    #[inline]
> > +    fn maxsize(&self) -> usize {
> > +        self.size()
> > +    }
> > +
> > +    // Only implement fallible methods (no IoKnownSize, so
> > infallible methods not available)
> > +    define_read!(fallible, try_read8, call_cap_read(try_read8) ->
> > u8);
> > +    define_read!(fallible, try_read16, call_cap_read(try_read16)
> > -> u16);
> > +    define_read!(fallible, try_read32, call_cap_read(try_read32)
> > -> u32); +
> > +    define_write!(fallible, try_write8, call_cap_write(try_write8)
> > <- u8);
> > +    define_write!(fallible, try_write16,
> > call_cap_write(try_write16) <- u16);
> > +    define_write!(fallible, try_write32,
> > call_cap_write(try_write32) <- u32); +}
> > +
> > +impl<'a> ConfigSpace<'a, Extended> {
> > +    /// Finds a specific extended capability by ID using the
> > kernel's `pci_find_ext_capability`.
> > +    pub fn find_ext_capability(&self, id: u16) ->
> > Option<Capability<'_, Extended, Extended>> {
> > +        // SAFETY: pdev is valid by ConfigSpace invariants
> > +        let offset = unsafe {
> > bindings::pci_find_ext_capability(self.pdev.as_raw(), id as i32) };
> > +
> > +        if offset == 0 {
> > +            return None;
> > +        }
> > +
> > +        let size = self.calculate_ext_cap_size(offset as usize);
> > +        Some(Capability::new(self, offset as usize, id, size))
> > +    }
> > +
> > +    fn calculate_ext_cap_size(&self, offset: usize) -> usize {
> > +        // Extended capability header: [31:20] = next capability
> > offset
> > +        // Use 0xffc mask (not 0xfff) to match kernel's
> > PCI_EXT_CAP_NEXT macro
> > +        let header = self.try_read32(offset).unwrap_or(0);
> > +        let next_ptr = ((header >> 20) & 0xffc) as usize;
> > +
> > +        if next_ptr == 0 {
> > +            // Last capability, size goes to end of config space
> > +            self.pdev.cfg_size().into_raw() - offset
> > +        } else {
> > +            // Size is distance to next capability
> > +            next_ptr - offset
> > +        }
> > +    }
> > +
> > +    /// Finds the next occurrence of a specific extended
> > capability starting from a given position.
> > +    pub fn find_next_ext_capability(
> > +        &self,
> > +        start_pos: u16,
> > +        id: u16,
> > +    ) -> Option<Capability<'_, Extended, Extended>> {
> > +        // SAFETY: pdev is valid by ConfigSpace invariants
> > +        let offset = unsafe {
> > +
> > bindings::pci_find_next_ext_capability(self.pdev.as_raw(),
> > start_pos, id as i32)
> > +        };
> > +
> > +        if offset == 0 {
> > +            return None;
> > +        }
> > +
> > +        // Calculate real capability size
> > +        let size = self.calculate_ext_cap_size(offset as usize);
> > +        Some(Capability::new(self, offset as usize, id, size))
> > +    }
> > +}
> > +
> > +/// SR-IOV register offsets (relative to the capability base).
> > +mod sriov_offsets {
> > +    use crate::bindings;
> > +
> > +    /// First VF Offset register offset
> > +    pub(super) const VF_OFFSET: usize =
> > bindings::PCI_SRIOV_VF_OFFSET as usize;
> > +    /// VF BAR0 register offset (first of 6 VF BARs)
> > +    pub(super) const VF_BAR0: usize = bindings::PCI_SRIOV_BAR as
> > usize; +}
> > +
> > +/// SR-IOV capability structure.
> > +///
> > +/// This structure provides typed access to the SR-IOV extended
> > capability +/// registers using the PCI configuration space backend.
> > +pub struct SriovCapability<'a> {
> > +    cap: Capability<'a, Extended, Extended>,
> > +}
> > +
> > +impl<'a> SriovCapability<'a> {
> > +    /// Creates a new SR-IOV capability from an extended
> > capability.
> > +    pub fn new(cap: Capability<'a, Extended, Extended>) ->
> > Result<Self> {
> > +        if cap.id() != ExtCapabilityId::SRIOV as u16 {
> > +            return Err(EINVAL);
> > +        }
> > +        Ok(Self { cap })
> > +    }
> > +
> > +    /// Tries to find and create an SR-IOV capability from a
> > config space.
> > +    pub fn from_config_space(config_space: &'a ConfigSpace<'a,
> > Extended>) -> Result<Self> {
> > +        let cap = config_space
> > +            .find_ext_capability(ExtCapabilityId::SRIOV as u16)
> > +            .ok_or(ENODEV)?;
> > +        Self::new(cap)
> > +    }
> > +
> > +    /// Returns the offset of this capability in configuration
> > space.
> > +    pub fn offset(&self) -> usize {
> > +        self.cap.offset()
> > +    }
> > +
> > +    /// Reads the First VF Offset register.
> > +    pub fn read_vf_offset(&self) -> Result<u16> {
> > +        self.cap.try_read16(sriov_offsets::VF_OFFSET)
> > +    }
> > +
> > +    /// Reads a VF BAR register (32-bit).
> > +    /// Returns the 32-bit value of the specified VF BAR register.
> > +    pub fn read_vf_bar(&self, bar_index: usize) -> Result<u32> {
> > +        if bar_index >= 6 {
> > +            return Err(EINVAL);
> > +        }
> > +        self.cap.try_read32(sriov_offsets::VF_BAR0 + bar_index * 4)
> > +    }
> > +
> > +    /// Reads a 64-bit VF BAR register.
> > +    /// Returns the 64-bit address combining BAR[n] (low) and
> > BAR[n+1] (high).
> > +    pub fn read_vf_bar64(&self, bar_index: usize) -> Result<u64> {
> > +        if bar_index >= 5 {
> > +            return Err(EINVAL);
> > +        }
> > +        let low = self.read_vf_bar(bar_index)?;
> > +        let high = self.read_vf_bar(bar_index + 1)?;
> > +        Ok((u64::from(high) << 32) | u64::from(low))
> > +    }
> > +}
> 

