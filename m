Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE83559E0;
	Tue, 27 Jan 2026 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769543982; cv=fail; b=g0Y27GUJQtb03keyw8iX1T1Ov6bmHIxKi2ll3BSYQrd49RFChYYO7FgkVgANmU5cQlJmDgoCFcMdTxplOeR0YRx2SWPKX28cbvWLNYKsuWsfUfVSZSYBvNkArWCw53VyC7rN4Ll2me9B/PQGR96yRubQgzbqT2aMOKMKaqUZeRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769543982; c=relaxed/simple;
	bh=oBVvr55UGFDS8jsQ6mcSUbJQ3pdIOJ6cspS9EgAjJk8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omlm40MgCFwhf60BZcrGm0GixLqs7CkNZS4BnYQU8uZBJV9n7xSz/yfjio7UcuxNG5seoN8V5L6kkWR3rPQmu44uZNGo1L0isEsCEmU6jJaEpbzoWWkhyhilG3O+8MRP3ElRWxLd9Mtzp9+d+MUVpbLU/wKcUB36mvN+GMQWC9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j5rDplbG; arc=fail smtp.client-ip=52.101.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j5rDplbG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+6RRLCk8TdT2SyF0LRscqCzACJmPN73gRzXgdM2TWKZR4V1nPeWRgk4jCyeaygUeKoytoERIsGwhDIzdPpynEsYa4OaKsIUtpLecKOumtK9AQNyruaip6i7pramUXdet02npCIKCjw1Jj/eGW/5LwlwTxQfMXhyJnczdOZoLnnuxdkgZJ0xxqjX7VP83sX4vbUlr+Kbq8NOBrdUsjbb2cOujlCsvGojFt8yhyY9UJPhLYocaeQ0iu4pfGFj1f6Y/vT9qPhgZIluAa2VdjLqhi0TCsiEjqabPMJ2X/LaUALwuKJEygBIjrG/ApCheysTEMshulGCWtCVVHKSydUJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkdhwGERta7hZRPz8Xo0NV3OT45UMuaUyPa8XjOJCLQ=;
 b=pVcOm8hIJJiDXzIBEYio+mbzFkkT6vg6Xq/ZyDbsiv/mZ9X3bnRFMlgtxVxB95TRGMkMF8mcLP/VYvcj/BFVCwzGR+Hl+kD7vFMfQFeQqUm8PnjrcBXMHZt7QlxZ1VC6865vP/ThQk6TqanjzpPv3MiDKLSa1VIqyQDsN+t8Ffu3o0cTXSYjD0OPh4jIH+LBiCccJHHTUbZjvgyHKMvjRRnH1cDl5R4bWijHLt2pPR3NXjdx1AfwsUk0xKJbVnsI3SD1JpPAQHcXaRDfxc0aEbLeMcpU35DALDKAAWLGRz81xCD0zbUiytK3fdiqpeuCPX07mvNYhBqm+0L3HHZI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=garyguo.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkdhwGERta7hZRPz8Xo0NV3OT45UMuaUyPa8XjOJCLQ=;
 b=j5rDplbG4ylHr4NBRMy9hHM0dBn3xTH06A55bLtB1JVzh59PXbbQNUbLuYJ3bOJN6dr2epbCC3IMT45TP1x4IDf7ezqffPq/WxNbs6QYkNqsK59rqz02O/LBfsKEehh7W68Pw2nGVzjJMY2/fEOlGStdlF4FJe251fArLaqpUFycqmlPrgnCmAA/cWknOjWgZh094kVv+THGC5+Y/mFbDJPmQkPFvdNReNWunwTcRCUAQys0NkkedPKP+COP4xrQdNPJY4CtKx3eNm0SmDFdDbLG6xggWAo2ZIxa46ekmsc6RRGlz7ygj85rMdBXgE0miJzxieVamFQpbxff6HtITA==
Received: from SJ0PR03CA0150.namprd03.prod.outlook.com (2603:10b6:a03:33c::35)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 19:59:29 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::7) by SJ0PR03CA0150.outlook.office365.com
 (2603:10b6:a03:33c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 19:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 19:59:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 11:59:12 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 27 Jan 2026 11:59:12 -0800
Received: from inno-thin-client (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 11:59:06 -0800
Date: Tue, 27 Jan 2026 21:59:05 +0200
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
	<daniel.almeida@collabora.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctl
Message-ID: <20260127215905.1b2563dd.zhiw@nvidia.com>
In-Reply-To: <DFYPKDARUMSH.21DBL43XL21S2@garyguo.net>
References: <20260122204232.15988-1-zhiw@nvidia.com>
	<20260122204232.15988-2-zhiw@nvidia.com>
	<DFYPKDARUMSH.21DBL43XL21S2@garyguo.net>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 63647e8a-6a06-4cfd-c133-08de5dde942a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?78ozDJNbRrT0vLA46lfalqRsCODkngVE01mNvZ3Z/PAM7cO+o/zCK/M2AakQ?=
 =?us-ascii?Q?WYtxw20hcVWlnr9EcyWqQ5uQSoZMXsQ64pBFUIR38IIbZEzjyTfpG2OMRYHh?=
 =?us-ascii?Q?ZxzRjFXoonVB7ZR8YI7AyocznODZknKHtpTf+xUq2FkWqZnFCFZedqgMjfEG?=
 =?us-ascii?Q?aUY35zUdjJa2e1Y4MHU+nReVubi4ksNuc907VS+zdd+o/31EhS9/r3Qhamn+?=
 =?us-ascii?Q?Y3BQafpr3ZOQ5qr47q9LEzcIlFWnUiHIkZlrsqj1ZIutmqfsl4nbSdtypOQa?=
 =?us-ascii?Q?JbyRhpZiF3giJeTqskOA8TDL+gw7OVqHBlhGMWvdk98P5jCOTZc7kPVH9sxY?=
 =?us-ascii?Q?y+BSEgth+xmuKDEetFBxo7C8C8YToKJI34qvfyvFToYS53AVFw2IZCJ/Ubj7?=
 =?us-ascii?Q?di8NuhIFaaVW8XftqCjKWYuAljo/4HzPCpLKiMa6wbxDs+nthUtnPjLr/Ewj?=
 =?us-ascii?Q?R9wHDoEy+VbfyKj/oEtIIIAxB4yQZ0SO4NVAzj94YulRcTPAo/RcYld2IWPU?=
 =?us-ascii?Q?UyiagIzkxrnUxo5FDZtLmvpM0t4UdiiFIwF2gIxn9HZBkKUuvfI5ZjvsRu2z?=
 =?us-ascii?Q?iGnso67IvlruS7HmpnJ8s+t2zoM9T7AqvFIm3/LvJ6DUyDQqzvBU3O6sLQ+u?=
 =?us-ascii?Q?1IcfqAxBldpYe75jclpRLWBu0SmCtUXJmR9pQA88lOibhqfK7cJkU4OoVmOR?=
 =?us-ascii?Q?Q8vr6FgC4FSO1ul1IqwujoS234d/odsf6RMvcfd7UQ5OCkQdR47QdHy4o50v?=
 =?us-ascii?Q?/HEaa0/376HtColDwFJvYEKLmf65MvynXLPJlPgRLYEpIUEKvvQ6BFujs6lp?=
 =?us-ascii?Q?9g5vIxqW/eVlKifYP+4R5SLFHq6/RShadrIpFnuSD4kuJQcVdFKWshqKygLz?=
 =?us-ascii?Q?hxci+cBm9dTb7I3dGsAGErITjuNg88A9udvr8EARVQe6lgAjiSBMioZuL4Qy?=
 =?us-ascii?Q?bEWOrKp+n0yZ1Vv+w5NmASTzAtesE/PGS2CiVtP8ASCiConQf7pfQ80YSIbY?=
 =?us-ascii?Q?y34TChwwBYiHZIBmBTwTaYEmA4VSPIR6DFPW5UFENK99VuUEKLqOGAmGOuCo?=
 =?us-ascii?Q?zAW+UNT811bq8U/Jax0g6q/I3WI587/Xie0r7Sm42WkmL/Bs5kzH/las7dzi?=
 =?us-ascii?Q?YP20obEJWoxOA66A+0QD9iNaNnVvWQOSF3sMyHt05bduoiWjqE95joqz/2aP?=
 =?us-ascii?Q?e0IoRcAu8DsNnT0GZpY71T6PyNFZb2lSdz6d1V+YuHeyB852Cr/ZQNcpbm+M?=
 =?us-ascii?Q?adBGrCCm84tdL5x85HhB7upkE60waWgjCboTvUzJjid0os8LfCQXqbIT1zoA?=
 =?us-ascii?Q?yQ2dm7vW4bHnvIZ6INeGfXy448KGQUyIQ3Le2lBCFBwMis+obDHxUdCR5zup?=
 =?us-ascii?Q?dMkx8CHJyaAPhE8QMoSid8Ya0IGOmrF/3mvV62AdLn9euLUv3yflffmINKNg?=
 =?us-ascii?Q?U6KwSWFJ9GeP27iUJel3qGRpBcoi9cLPTl4SOrafIQh7JYy7jICyMp/SomJ1?=
 =?us-ascii?Q?nVZFeSLpaft+kyKsBqmm515c6QVZFUh0M4bn0KCcpK4S6l2l8RljsgE9OHBA?=
 =?us-ascii?Q?+mFLMp/uDfOSlF6QEpO6rgMo7U/Gv5mKET9Zlnp7QM6/WVMhMDfK+qzZBfqb?=
 =?us-ascii?Q?u3Gh33CDIH16zj0lX20VdAJ/7l9RFnEfmS4aO35up/z3UWjtw6y4oh6IgSUA?=
 =?us-ascii?Q?LpSsDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:59:28.2965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63647e8a-6a06-4cfd-c133-08de5dde942a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110

On Mon, 26 Jan 2026 17:48:09 +0000
"Gary Guo" <gary@garyguo.net> wrote:

> On Thu Jan 22, 2026 at 8:42 PM GMT, Zhi Wang wrote:

Many thanks for the comments. Will integrate them in the next re-spin.

Z.

> > Introduce safe wrappers around `struct fwctl_device` and
> > `struct fwctl_uctx`, allowing rust drivers to register fwctl devices
> > and implement their control and RPC logic in safe rust.
> >
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > ---
> >  drivers/fwctl/Kconfig           |  12 +
> >  include/uapi/fwctl/fwctl.h      |   1 +
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/helpers/fwctl.c            |  17 ++
> >  rust/helpers/helpers.c          |   3 +-
> >  rust/kernel/fwctl.rs            | 456 ++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs              |   2 +
> >  7 files changed, 491 insertions(+), 1 deletion(-)
> >  create mode 100644 rust/helpers/fwctl.c
> >  create mode 100644 rust/kernel/fwctl.rs
> >
> > diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> > index b5583b12a011..d8538249f3ae 100644
> > --- a/drivers/fwctl/Kconfig
> > +++ b/drivers/fwctl/Kconfig
> > @@ -8,6 +8,18 @@ menuconfig FWCTL
> >  	  manipulating device FLASH, debugging, and other activities
> > that don't fit neatly into an existing subsystem.
> >  
> > +config RUST_FWCTL_ABSTRACTIONS
> > +	bool "Rust fwctl abstractions"
> > +	depends on RUST
> > +	select FWCTL
> > +	help
> > +	  This enables the Rust abstractions for the fwctl device
> > firmware
> > +	  access framework. It provides safe wrappers around struct
> > fwctl_device
> > +	  and struct fwctl_uctx, allowing Rust drivers to register
> > fwctl devices
> > +	  and implement their control and RPC logic in safe Rust.
> > +
> > +	  If unsure, say N.
> > +
> >  if FWCTL
> >  config FWCTL_MLX5
> >  	tristate "mlx5 ConnectX control fwctl driver"
> > diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> > index 716ac0eee42d..eea1020ad180 100644
> > --- a/include/uapi/fwctl/fwctl.h
> > +++ b/include/uapi/fwctl/fwctl.h
> > @@ -45,6 +45,7 @@ enum fwctl_device_type {
> >  	FWCTL_DEVICE_TYPE_MLX5 = 1,
> >  	FWCTL_DEVICE_TYPE_CXL = 2,
> >  	FWCTL_DEVICE_TYPE_PDS = 4,
> > +	FWCTL_DEVICE_TYPE_RUST_FWCTL_TEST = 8,  
> 
> This is UAPI, adding new device type just for testing is not ideal.
> 
> >  };
> >  
> >  /**
> > diff --git a/rust/bindings/bindings_helper.h
> > b/rust/bindings/bindings_helper.h index 9fdf76ca630e..2c50d5bab0cf
> > 100644 --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -56,6 +56,7 @@
> >  #include <linux/fdtable.h>
> >  #include <linux/file.h>
> >  #include <linux/firmware.h>
> > +#include <linux/fwctl.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/fs.h>
> >  #include <linux/i2c.h>
> > diff --git a/rust/helpers/fwctl.c b/rust/helpers/fwctl.c
> > new file mode 100644
> > index 000000000000..bb4a028e7afb
> > --- /dev/null
> > +++ b/rust/helpers/fwctl.c
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/fwctl.h>
> > +
> > +#if IS_ENABLED(CONFIG_RUST_FWCTL_ABSTRACTIONS)
> > +
> > +struct fwctl_device *rust_helper_fwctl_get(struct fwctl_device
> > *fwctl)  
> 
> Helpers need to have __rust_helper.
> 
> > +{
> > +	return fwctl_get(fwctl);
> > +}
> > +
> > +void rust_helper_fwctl_put(struct fwctl_device *fwctl)
> > +{
> > +	fwctl_put(fwctl);
> > +}
> > +
> > +#endif
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 79c72762ad9c..19a505473bef 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -27,8 +27,9 @@
> >  #include "dma.c"
> >  #include "drm.c"
> >  #include "err.c"
> > -#include "irq.c"
> >  #include "fs.c"
> > +#include "fwctl.c"
> > +#include "irq.c"
> >  #include "io.c"
> >  #include "jump_label.c"
> >  #include "kunit.c"
> > diff --git a/rust/kernel/fwctl.rs b/rust/kernel/fwctl.rs
> > new file mode 100644
> > index 000000000000..4065c948784d
> > --- /dev/null
> > +++ b/rust/kernel/fwctl.rs
> > @@ -0,0 +1,456 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +//! Abstractions for the fwctl.
> > +//!
> > +//! This module provides bindings for working with fwctl devices in
> > kernel modules. +//!
> > +//! C header: [`include/linux/fwctl.h`]
> > +
> > +use crate::{
> > +    bindings,
> > +    container_of,
> > +    device,
> > +    devres::Devres,
> > +    prelude::*,
> > +    types::{
> > +        ARef,
> > +        Opaque, //
> > +    }, //
> > +};
> > +use core::{
> > +    marker::PhantomData,
> > +    ptr::NonNull,
> > +    slice, //
> > +};
> > +
> > +/// Represents a fwctl device type.
> > +///
> > +/// This enum corresponds to the C `enum fwctl_device_type` and is
> > used to identify +/// the specific firmware control interface
> > implemented by a device. +#[repr(u32)]
> > +#[derive(Copy, Clone, Debug, Eq, PartialEq)]
> > +pub enum DeviceType {
> > +    /// Error/invalid device type.
> > +    Error = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_ERROR,  
> 
> Does this need to be present? I took a look at the C side, this isn't
> used at all. It'll be a bug if `Operations` impl uses this value as
> their `DEVICE_TYPE`.
> 
> Best,
> Gary
> 
> > +    /// MLX5 device type.
> > +    Mlx5 = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_MLX5,
> > +    /// CXL device type.
> > +    Cxl = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_CXL,
> > +    /// PDS device type.
> > +    Pds = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_PDS,
> > +    /// Rust fwctl test device type.
> > +    RustFwctlTest =
> > bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_RUST_FWCTL_TEST, +}
> > +
> > +impl From<DeviceType> for u32 {
> > +    fn from(device_type: DeviceType) -> Self {
> > +        device_type as u32
> > +    }
> > +}  
> 

