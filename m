Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530D1D63F3;
	Tue, 27 Jan 2026 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769543892; cv=fail; b=V82kYtbkWQAgs9Fv4Wq13SgeEms7F8iWjCuPHpHWi/ll6jIDL4W81gC0i48aojdL1CSN1vDuXZO6DmR1Y1gHGSiwFlgDmIWSaX+O6+nx/DAICXF4l65K568zXUfST0QPqrVLVWDogRCmndnQJ2QaxwC7osykPzFPMgp/BHmBrls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769543892; c=relaxed/simple;
	bh=t+sKN8YvmkOKUfmJjLLH2G6QX/q6fDo6XfYSmCrLwmo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjB9Ko1yokz9MXITVnMrACVHCS1jT1OIX5Mbq/POclG5v4EJLQwhHguDxuM6e9DyzP9hF0xkOP10RP+0L2T3GO6DA8Xup/BGSQT2mZOnX1iH3FCz8EElvqywuBIdGBTyXV2+kzHQtI4svGLHJDIT0SbW/dVBsErFam5gpISB/Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fh3x1OvT; arc=fail smtp.client-ip=52.101.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fh3x1OvT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOBlUKqIoQbKKuhgt0BnD9DfoCQLF6svMJ06civuZ09eiC2enf2FC71oBoYJY9vc3iMizJ+uiVxBzNPEcxtvXI7aGEwMvcyuJ+vu4pnFvyaSLVZf4dTOB5Plg7FblPjtfJ12FKQxfxsb6bw1bBi5aoatpVnOFn3pKM5X6WPloNXFUSlwRzxiHmncKET2VG016FLnPpDYSUXb9QgqyW/uC3XaJ+PCStp1PE+wfCzWup3B4iGiGXVB5psv9JHoRwX0IgE3DFSLaSA+5+fT79qLrO8NugVlxSRHxVzUeg6AubR0avJWSXwxwYDi8okFXNvAdpOrUlK40rRKwhYkDk/VzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfYiKBOVM3XOjhKH6Fy3CjrBoqGNVrGnTC+ApGvY6gY=;
 b=EjQKa1JdTKhPPD1IhbLzRBWuDyCx0Vycdf75kBecDK8Fd/oYR6bjgpP87ikkpcCfDzs6HUo5qS0YWcCmuu1lZxN/0+u+9C9wC7qRvXKmHGml3qkd/v6rlrEPr3kqLT0af5SR+0BoeuRKiXasyMqFzTrBZEKboY9srsXa7plDEZnMDzjmUEWvq3eQ5310g7z02spIzYP3h0VBjbtTwmBnFl9bHdP2Fqu1HNtHXFbokOH0+5cVCY5Q0R/WhoimPnIuMlwQgkIBWYAB2XG0IUpnBhAEefgtt+6tlsl73oF1u7uDUQSCz8wQ/186zOfdM2A0niLpEzG6Hm5yyzpntspVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfYiKBOVM3XOjhKH6Fy3CjrBoqGNVrGnTC+ApGvY6gY=;
 b=Fh3x1OvTwo+Vpb8mNBSl8TMdYVO2HBOdcprr5vn/QkIkKgl6kb3MG2ddGLcfWsgToGPvsfqdAA44WzMtARPwv3vatXE+fvcQWfWoriGqeGtqUzY4TinBDVXPWJcMBSi4JyJzgdZfzM5i/pHWKNTweUzgBkHxpp5rZieJbQsvbtnghhkIYknRE1BLr3nLZuVMd2sMRvQGDXHFkTZGBpg7k0ZaGtr21mheGYEsFz/g0xtumkiKKIWtd3Z++9IwtfSKNk/ghhXg3pMgMjEFvn4YbiHBxnxzmm7LFGYBTcxj5V7lS6vs1MmHCrDSdKoD2lLQ1mzIrOV25MGkq68KGUBd5A==
Received: from BY5PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:180::43)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 19:58:05 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::a6) by BY5PR13CA0030.outlook.office365.com
 (2603:10b6:a03:180::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 19:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 19:58:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 11:57:52 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 27 Jan 2026 11:57:51 -0800
Received: from inno-thin-client (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 11:57:45 -0800
Date: Tue, 27 Jan 2026 21:57:44 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctl
Message-ID: <20260127215744.332380fe.zhiw@nvidia.com>
In-Reply-To: <20260126181912.GA2131321@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
	<20260122204232.15988-2-zhiw@nvidia.com>
	<20260126181912.GA2131321@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|MN0PR12MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 634cfdc4-1dce-4be1-6b03-08de5dde622c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iTdHoR2D0cb55e/THxbqFGyQEqge03BXM7lPfuNucUaU64NQryEdP71bhy08?=
 =?us-ascii?Q?QGxTWIcHLgD29zHbw0gGX7tslry7BJvJxVZxKhwH2k9vnIgCnubIAsynf/lW?=
 =?us-ascii?Q?3n4BdonkSIN+/yr2+CivfNHLgRT+26Ov9qa1jeovIQbw9cAazrgMFuaGm+Ju?=
 =?us-ascii?Q?vpiXYd9wZ3CVisMqenuc1MxAi+lCrcRUGWB7tfI9JnHAT97u5biB5A+4xqQ0?=
 =?us-ascii?Q?sQLRBXvwE/blvGSvnaJjct+puC34vbae7cNaGmEw6iPcd9FD8c8BIZjCB+y9?=
 =?us-ascii?Q?v1SKZUQak7wpU8gz0oUzF7F22MwX+na7EKjQHHoqEYxBltLvPIwbC81ZA0YR?=
 =?us-ascii?Q?jKeAUk+ePTK5hqTDRO1OD/xx3zwfdbSzaMZag1OIWV5e0WVOCanbq/I0i0qN?=
 =?us-ascii?Q?e3uBTMteMajZo1w3odh+eGiXBHtOR0X0eCfWBwGtkCtJln+GLoFcqG9LCDF8?=
 =?us-ascii?Q?h1rczsm//hhSXtT8iT9pd+H1l2v+Fx6R7acntnv8ETGlvKHKejNKIvzF5kzK?=
 =?us-ascii?Q?mBuIOZHr5Caqmlo+wwEAB6olruakoairK2f5CThiG6iC95QemvK6s6Ap3wYW?=
 =?us-ascii?Q?JI1GC8usWVcAJUGqVKfuhi37AyKob3JFS8B1Ji8403sEP+rLwCf9WoO/yK8g?=
 =?us-ascii?Q?NGf/N94R4c5qcUkCyLY4weXgdE2ZjIiRFbWSjlbNdMV1cc7zUQHuHVCtS2Xx?=
 =?us-ascii?Q?EIzPRVurKPaD6kxMrtMF3i+1Nd9ahzMuBstgg4acABmODaKTXxSxxRjYisYU?=
 =?us-ascii?Q?rkPKnEdQzTL8paSOC+Te7R8qRjNWCxDV+G4B1oYt4gIdzjM/KdyI2wk4PONb?=
 =?us-ascii?Q?mEVK8Xrufz+pq9KUT3EdgyuO24CB+PM7sZMLJC7v6Bw/vtctjc6/wXJ50o+R?=
 =?us-ascii?Q?qDw/u3v8R5+xTsVG4Zes2qL6VHK74U2sI3hP9R8x60cZHfgvML1nwWpY9ByQ?=
 =?us-ascii?Q?KpMeF9xJ/47/pd1K6CUEBcQsXn7AeLuHWnoZHyGnbU2h7mZJz0cccbwfon0N?=
 =?us-ascii?Q?pJTXNw2rUpU6uUGbqzssdQVmG61f9kOVQqVYt+3V2mFtq7Pzp1wX6g0irfZX?=
 =?us-ascii?Q?4nrLwyGQPipT2OyM4njlZOX8dIlOivA4WopQzGtTWKZDL4ZkE2sN6qanGN+H?=
 =?us-ascii?Q?LTpavUCU2NVl+2g9UsKoL93WgdgT7SuVn3Rm2xuzKi9u83Qa0NuvWjvAI4fe?=
 =?us-ascii?Q?ZUHCvdIxeJjTOH9SoqwULXAut1Zj/eezqeI8eJ//QOO2VBHltmkiMEOx8ick?=
 =?us-ascii?Q?S+a+q3R0mGa8ApNbnwAY3aj08aN3McwgOHXeuil1QvWhcILVcf0mkYTkx3XL?=
 =?us-ascii?Q?DrRhZjCtO0vcsWwp+rewkmvXOrpQiuP9cg5l0Ddq0bpL+x/U07wZktK9K7vH?=
 =?us-ascii?Q?AH+oFidWkJxe84izA28eGkz51SO19fcYhJtCqkczR510F3rt1765M5JKblnJ?=
 =?us-ascii?Q?zVkUiUti3SNYx+TWBFr9XbLq9EP1F1Brk3mS46fAzSO34IupQw+8v7VvpTM3?=
 =?us-ascii?Q?cogaDEJg/zyUtoNP/yqVscxSBLRF+BA/NcyO2FO5o4wJNjMq25qB8xhYGxWq?=
 =?us-ascii?Q?Nb9iBOUDgpsfJcZuNoISeANjNeYaXpyP+ddybvLjTFUxx1Pnip9pilRPC2ba?=
 =?us-ascii?Q?eRh3jRDk4H/HycDH1FJgAWyu8SqEi5dBUJnRrCz7J3YQ9usAe/lPuKf3hiRE?=
 =?us-ascii?Q?9C/5DA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:58:04.4027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 634cfdc4-1dce-4be1-6b03-08de5dde622c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030

On Mon, 26 Jan 2026 14:19:12 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Jan 22, 2026 at 10:42:30PM +0200, Zhi Wang wrote:
> > --- a/drivers/fwctl/Kconfig
> > +++ b/drivers/fwctl/Kconfig
> > @@ -8,6 +8,18 @@ menuconfig FWCTL
> >  	  manipulating device FLASH, debugging, and other activities
> > that don't fit neatly into an existing subsystem.
> >  

snip

> > +/// Represents a fwctl device type.
> > +///
> > +/// This enum corresponds to the C `enum fwctl_device_type` and is
> > used to identify +/// the specific firmware control interface
> > implemented by a device. +#[repr(u32)]
> > +#[derive(Copy, Clone, Debug, Eq, PartialEq)]
> > +pub enum DeviceType {
> > +    /// Error/invalid device type.
> > +    Error = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_ERROR,
> > +    /// MLX5 device type.
> > +    Mlx5 = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_MLX5,
> > +    /// CXL device type.
> > +    Cxl = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_CXL,
> > +    /// PDS device type.
> > +    Pds = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_PDS,
> > +    /// Rust fwctl test device type.
> > +    RustFwctlTest =
> > bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_RUST_FWCTL_TEST, +}
> 
> Do we really need these contentless comments?
> 

I will try to remove them if the compiler allows me to do that in the next
re-spin.

> > +impl Device {
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must be a valid pointer to a `struct fwctl_device`.
> > +    unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_device) -> &'a
> > Self {
> > +        // CAST: `Self` is a transparent wrapper around
> > `bindings::fwctl_device`.
> > +        // SAFETY: By the safety requirement, `ptr` is valid.
> > +        unsafe { &*ptr.cast() }
> > +    }

snip

> > +            // ensuring it remains valid during allocation.
> > +            let dev = unsafe {
> > +                bindings::_fwctl_alloc_device(
> > +                    parent.as_raw(),
> > +                    ops,
> > +                    core::mem::size_of::<bindings::fwctl_device>(),
> > +                )
> > +            };
> > +
> > +            if dev.is_null() {
> > +                return Err(ENOMEM);
> > +            }
> > +
> > +            // SAFETY: dev is guaranteed to be a valid pointer from
> > `_fwctl_alloc_device()`.
> > +            let ret = unsafe { bindings::fwctl_register(dev) };
> > +            if ret != 0 {
> > +                // SAFETY: dev is guaranteed to be a valid pointer
> > from `_fwctl_alloc_device()`.
> > +                unsafe {
> > +                    bindings::fwctl_put(dev);
> > +                }
> > +                return Err(Error::from_errno(ret));
> > +            }
> 
> This looks weirdly sequenced, the driver's object has to be fully
> initialized before you can call register, so it is quite strange to
> see a wrapper that does both alloc and register in one function.
> 

The fwctl_alloc_device() helper allocates a raw struct fwctl_device
without private driver data here. The Rust driver object should be
already allocated and initialized separately before reaching this
point.

We rely on the standard dev->parent chain to access the rust driver
object from the fwctl callbacks.

> > +                bindings::_fwctl_alloc_device(
> > +                    parent.as_raw(),
> > +                    ops,
> > +                    core::mem::size_of::<bindings::fwctl_device>(),
> > +// SAFETY: `Registration` can be sent to other threads because:
> > +// - It only contains a `NonNull<fwctl_device>` pointer and a
> > PhantomData marker +// - The underlying C fwctl_device is thread-safe
> > with internal locking +// - `Drop` calls
> > `fwctl_unregister()/fwctl_put()` which are safe from any sleepable
> > context
> 
> fwctl_unregister is not safe from any context, it must be called
> while the Device is still bound.
> 

The registration is wrapped in Devres<> in the sample driver, which
guarantees that drop is called while the Device is still bound.

I agree that the current abstraction itself does not strictly enforce this
(e.g., if the object is moved out of Devres). I will investigate an
approach to enforce this requirement in the next re-spin.

Z.

> Jason
> 

