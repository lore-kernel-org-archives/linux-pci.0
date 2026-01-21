Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8C38B7AA;
	Wed, 21 Jan 2026 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021693; cv=fail; b=eLvwyRc6CpEJeBlgTJ8ycEOdDX/iewBQGZ0J0m+KscrerWHp0druPlwdLUIeO6QoWrHsC1yW8wYaFamp0JGYuobpYoC5tbDoLpkPpfbVqUCETR61L71hTrFBv3Qjg4jXrunBMSK9h/3igo3C+deuLW8Nea+F4um4Ut+/lmFHXNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021693; c=relaxed/simple;
	bh=8IXphZ96xPCDmqS3U9NlypCPb/gqcuTnifZ6iK2xrgw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLAgrcH1doSuT3EGIw/8HJu09IHxiYU/wDJg7bdcyELAQJPYmkOFZf0wPFACVd8z5dd0hmXrsHcxvma1kxM8XXM39poKE418xopKvh2cIMsjBpMahswu76IvAdU/ZXWY3lwiWjDMjztCccPdbBNojHpb8YVMG/xOuinvC6sRNOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eBNAQJaj; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eBNAQJaj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgEZPSRIK4ExZNjSrziWn6NgGvPlstY0YpESA0INWHB2xcefiU5YHuFMVW5Sza/0peRNPnGwGEes7pPGbsEi3hkvCyfeOH+QlAe7jJn4PdsMFOliAgGAlp8bw6pfU8vIE4Apb+WhfcmGTtWAkSf9l6DudkjQw0ZGOu7kSffdWdD4Az7d5wywbLF+7wOVtztT6Ytm4+rXDSKEAVCMfV5BEYYouqCpRzz4jhoxPmJFmn9Qvy6v6X9dPTwlgnWkb1smyhPAVjcOsGgMFjkG4owwJraRs37UVjg8trjLF/UgzC7mIMYwaAcGTc5n+xfbxRb/dSxfC0DDilj0A5fSh7z5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osaTWkw2W/VTYOQBvn072KgevXCN3vSTszZ3t+T0rws=;
 b=nPpc900YXypyJ1NfYl7pJEG8P/2RKyULA9sZhDxw190n52FGxSoXSVTaXntUdFtJKgFBbik+gc+9VYyrTxzZph7CfollAWyz0gRFQAJO/oDovvTRK+tRiV1Q0HgEavj9440Em1ut0mJyTbWF6X4nSus+h6JonvgBSk/pF8InY55zkUVicZgaNzjqt+a4YnKqTWck25UtDUEMZ2xJSeVY/WE56gWZ1VpfkxKEW32mB62rcjloFOLFkzd+gZa2pnryI9LyAUwHuxBORKxjGuyrUiIH/xM5CdnPTfJM6WrIc3JPfmQQW2ObbxlFkmCgMXalY14fXtiIXCDSbg/D4jz1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=garyguo.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osaTWkw2W/VTYOQBvn072KgevXCN3vSTszZ3t+T0rws=;
 b=eBNAQJajNO2GedVifhVjY27S7b/hZMUgWvWeJeyiHIbxz4+fHbVfn7BgpZ2EhzjHPcdJtMw95gV13tjJuM+0HvazIYDFvieaYNSM5DCWNShrvQY7hWzVRWXlKwAK2+v52AhuYh3IBkA2YBDb64g+AlyolhTsx3Y26FsRObnqaZje4JOD7irb23mguIq13tLZpIkxM9zg7FL7hpCdY1R1j6+UecUWZxhBpZ8d5ZYiPivhCdcAjU77/7cRiXqKbHxT3i+2MUvM7mS1wt/Zmc6iixITWVYhqoadVJBl2cxrLUe5xg9gTVLmFiJLjj1vDSvycqx5j3ERIZlYytNXBNcRtw==
Received: from SJ0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:33a::30)
 by DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 18:54:38 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::aa) by SJ0PR03CA0025.outlook.office365.com
 (2603:10b6:a03:33a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 18:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 18:54:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 10:54:14 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 10:54:14 -0800
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 10:54:07 -0800
Date: Wed, 21 Jan 2026 20:54:06 +0200
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
Subject: Re: [PATCH v11 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
Message-ID: <20260121205406.2e0c7e44.zhiw@nvidia.com>
In-Reply-To: <DFUD2VQGF43V.3AGDOE8K4ANNX@garyguo.net>
References: <20260121142355.4761-1-zhiw@nvidia.com>
	<20260121142355.4761-3-zhiw@nvidia.com>
	<DFUD2VQGF43V.3AGDOE8K4ANNX@garyguo.net>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|DS4PR12MB999075:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec000e4-eeac-4647-39ea-08de591e8655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EGSLtcesxuIcuWTr1xEhApk3lIsOy4K5GwU3uSGNQ1ydIMytrLj6gg9IxvEY?=
 =?us-ascii?Q?Mhn9h0kOKXrtHaeLwKf2PQwjXrym96SoT7JeWXlQv15A2iZE1rr106rswYI0?=
 =?us-ascii?Q?gC/xZF0L28HeCRC6LUxv7AkGhzDzja4Le36xfR8xfDX7sPTVuB+mobJnOPVc?=
 =?us-ascii?Q?5LLItO2lNW+uUXxenySE6tBCgACpEIYHFfzubef+KuJBxMOY9pG9zwA7b+Tw?=
 =?us-ascii?Q?TEnDXp3aYE2Db5K9I+ft6siK1178kYPZ4HBuGCjzeOKHq06t/gF7NTr9IELb?=
 =?us-ascii?Q?5FawsWlbBLZkJpjrHx01HgV5Tf1jaOhJS6mn2R40+jGnla9CUOFOUmBxXReS?=
 =?us-ascii?Q?KPb0C3bRkeVdIKFKrQj/FRUoApDv5+29AsjwYUJVzVFKjsnWAHrxsS+KHujM?=
 =?us-ascii?Q?yoMth5povGbtxKER0QBM5JhFtC5uiPMfArXDcrALTGiSkRLl8v/s95gm5ptu?=
 =?us-ascii?Q?JCYY6NJQ9stMsu7X4mF9MlhIwlJZK1RTxenyMQLjbxOBLIMq21Geqp9i7o2L?=
 =?us-ascii?Q?aKqQPxHLD4IJsAgAXRRyfjuD19kyzTTzBf56ooepge9hyt04IMcaQ9ClJF8d?=
 =?us-ascii?Q?q9FnRPCl+i4oINEirvuIz0QScbNnJ1DNd5juNz6SLRqPpnuW9E7NWxfMxZsK?=
 =?us-ascii?Q?t+R8yg/OiczNsIP780SmbEI5lO2bKWDVZo9RWf4YMRXX0R9Nhvcf1KoNsPRG?=
 =?us-ascii?Q?5fBp5FFrn8C2pG/DI9IKBoxppVvSjkYJhk04+j3HslLQo7OD43t2yV3hGiwz?=
 =?us-ascii?Q?wJfUfq8i2+2bUG2kILlQPpj2dZMUJSqAP9oUrenJFrk/YrZqtcMOfyNvASvL?=
 =?us-ascii?Q?odNAX+hLpt3ZZuZIcKezTauxvYq558/f6alhaU14/7o+VjEbrcdnCREx+eIl?=
 =?us-ascii?Q?6c+OP6XJYfv7HklP6e1iOqV5K8VLD43cUtIVG2nQO1C9MII5wqAhldDT3ztu?=
 =?us-ascii?Q?ph/fplIFP/euWyhKIbU2n8S4Q1heXsmxQ+qHem1bUSgAjGA+H0LNlPTXscP0?=
 =?us-ascii?Q?TLSYqaT5q0lc34Zs8iKJMOmGQt6vSI9ET7F0H1F5f4WRI31U8Jb1WX0nzv5E?=
 =?us-ascii?Q?Avw1zec5/4k4M6iSu4+bPhTD9zInK/K3J9TUCDI6Il47wezVhgYdFBOpcgnj?=
 =?us-ascii?Q?UKg5Q6YwZSFHMd3y9qiNNCIW51wqf9PVkfTl37xmH0H+UTi1nySVrs+WiTCq?=
 =?us-ascii?Q?V54tgEmfEte/hUqpObQKc1Qmx00RGt4iJ+godJ5dfXgH8+42zhrnyndSsfw+?=
 =?us-ascii?Q?nWZ4QLvDMZZpeN+ABxmKgWzEmPhwM6W6CbxqC/kp+UaWtpSpYndGWB9tGkjS?=
 =?us-ascii?Q?hSOMZKXwqWgahJWjF2S6Z/NKIhuSD5Kf0vunP3Nm14gc3F69OicKjrY6tuKH?=
 =?us-ascii?Q?qPEVpNViNCEURKpXq/cxvL9Oc1NvnUWyET2PMSwiRxfacdhwAHJA7dxvL/3X?=
 =?us-ascii?Q?QPhJdcGReIDqP1RD7o97V0BDrhnYFSUtcDy/uB8FZDss6hl7FqO02wYr2QmP?=
 =?us-ascii?Q?CIL5IV3tNe8608KnpLUXUMvWqXA198cn8LpLDkyDhER30J4oAwHUleg3EngU?=
 =?us-ascii?Q?n9TBsQpYS0T7TR4BFRytmlYGfis8lajnuw0hK2eyKjo8kug+LE6mZhWRcRU0?=
 =?us-ascii?Q?EapuiKFUy9Gjn/6X5PAH1dido4Ee1gTFqYjqrfh3DP2EQfb5x/hRJm44ZzzJ?=
 =?us-ascii?Q?/Fbkyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 18:54:37.0525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec000e4-eeac-4647-39ea-08de591e8655
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999075

On Wed, 21 Jan 2026 15:10:25 +0000
"Gary Guo" <gary@garyguo.net> wrote:

> On Wed Jan 21, 2026 at 2:23 PM GMT, Zhi Wang wrote:
> > The previous Io<SIZE> type combined both the generic I/O access helpers
> > and MMIO implementation details in a single struct. This coupling
> > prevented reusing the I/O helpers for other backends, such as PCI
> > configuration space.
> >
> > Establish a clean separation between the I/O interface and concrete
> > backends by separating generic I/O helpers from MMIO implementation.
> >
> > Introduce a new trait hierarchy to handle different access
> > capabilities:
> >
> > - IoCapable<T>: A marker trait indicating that a backend supports I/O
> >   operations of a certain type (u8, u16, u32, or u64).
> >
> > - Io trait: Defines fallible I/O methods (try_read8, try_write8, etc.)
> > with runtime bounds checking.
> >
> > - IoKnownSize trait: Extends Io to define infallible I/O methods
> > (read8, write8, etc.) with compile-time bounds checking for regions
> > where the size is known at compile time.
> >
> > Move the MMIO-specific logic into a dedicated Mmio<SIZE> type that
> > implements the Io and IoKnownSize traits. Rename IoRaw to MmioRaw and
> > update consumers to use the new types.
> >
> 
> Hi Zhi, thanks for doing the work. It looks much nicer now :)
> 

Hey Gary. Glad to see that. :) Will address them in the next re-spin.

> Still, some comments below.
> 
> Best,
> Gary
> 
> > Cc: Alexandre Courbot <acourbot@nvidia.com>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > ---
> >  drivers/gpu/drm/tyr/regs.rs            |   1 +
> >  drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
> >  drivers/gpu/nova-core/regs/macros.rs   |  90 +++---
> >  drivers/gpu/nova-core/vbios.rs         |   1 +
> >  drivers/pwm/pwm_th1520.rs              |   5 +-
> >  rust/kernel/devres.rs                  |  19 +-
> >  rust/kernel/io.rs                      | 415 +++++++++++++++++++++----
> >  rust/kernel/io/mem.rs                  |  16 +-
> >  rust/kernel/io/poll.rs                 |  16 +-
> >  rust/kernel/pci/io.rs                  |  12 +-
> >  samples/rust/rust_driver_pci.rs        |   4 +
> >  11 files changed, 453 insertions(+), 131 deletions(-)
> >
> > diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> > index a97eb44a9a87..152afdcbaf78 100644
> > --- a/rust/kernel/io.rs
> > +++ b/rust/kernel/io.rs
> > @@ -32,16 +32,16 @@
> >  /// By itself, the existence of an instance of this structure does
> > not provide any guarantees that /// the represented MMIO region does
> > exist or is properly mapped. ///
> > -/// Instead, the bus specific MMIO implementation must convert this
> > raw representation into an `Io` -/// instance providing the actual
> > memory accessors. Only by the conversion into an `Io` structure -///
> > any guarantees are given. -pub struct IoRaw<const SIZE: usize = 0> {
> > +/// Instead, the bus specific MMIO implementation must convert this
> > raw representation into an +/// `Mmio` instance providing the actual
> > memory accessors. Only by the conversion into an `Mmio` +/// structure
> > any guarantees are given. +pub struct MmioRaw<const SIZE: usize = 0> {
> >      addr: usize,
> >      maxsize: usize,
> >  }
> >  
> > -impl<const SIZE: usize> IoRaw<SIZE> {
> > -    /// Returns a new `IoRaw` instance on success, an error otherwise.
> > +impl<const SIZE: usize> MmioRaw<SIZE> {
> > +    /// Returns a new `MmioRaw` instance on success, an error
> > otherwise. pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
> >          if maxsize < SIZE {
> >              return Err(EINVAL);
> > @@ -81,14 +81,16 @@ pub fn maxsize(&self) -> usize {
> >  ///     ffi::c_void,
> >  ///     io::{
> >  ///         Io,
> > -///         IoRaw,
> > +///         IoKnownSize,
> > +///         Mmio,
> > +///         MmioRaw,
> >  ///         PhysAddr,
> >  ///     },
> >  /// };
> >  /// use core::ops::Deref;
> >  ///
> >  /// // See also `pci::Bar` for a real example.
> > -/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
> > +/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
> >  ///
> >  /// impl<const SIZE: usize> IoMem<SIZE> {
> >  ///     /// # Safety
> > @@ -103,7 +105,7 @@ pub fn maxsize(&self) -> usize {
> >  ///             return Err(ENOMEM);
> >  ///         }
> >  ///
> > -///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
> > +///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
> >  ///     }
> >  /// }
> >  ///
> > @@ -115,11 +117,11 @@ pub fn maxsize(&self) -> usize {
> >  /// }
> >  ///
> >  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> > -///    type Target = Io<SIZE>;
> > +///    type Target = Mmio<SIZE>;
> >  ///
> >  ///    fn deref(&self) -> &Self::Target {
> >  ///         // SAFETY: The memory range stored in `self` has been
> > properly mapped in `Self::new`. -///         unsafe {
> > Io::from_raw(&self.0) } +///         unsafe { Mmio::from_raw(&self.0) }
> >  ///    }
> >  /// }
> >  ///
> > @@ -133,29 +135,31 @@ pub fn maxsize(&self) -> usize {
> >  /// # }
> >  /// ```
> >  #[repr(transparent)]
> > -pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);
> > +pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
> >  
> >  macro_rules! define_read {
> > -    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident ->
> > $type_name:ty) => {
> > +    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident
> > -> $type_name:ty) => { /// Read IO data from a given offset known at
> > compile time. ///
> >          /// Bound checks are performed on compile time, hence if the
> > offset is not known at compile /// time, the build will fail.
> >          $(#[$attr])*
> >          #[inline]
> > -        pub fn $name(&self, offset: usize) -> $type_name {
> > +        $vis fn $name(&self, offset: usize) -> $type_name {
> >              let addr = self.io_addr_assert::<$type_name>(offset);
> >  
> >              // SAFETY: By the type invariant `addr` is a valid
> > address for MMIO operations. unsafe { bindings::$c_fn(addr as *const
> > c_void) } }
> > +    };
> >  
> > +    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident,
> > $c_fn:ident -> $type_name:ty) => { /// Read IO data from a given
> > offset. ///
> >          /// Bound checks are performed on runtime, it fails if the
> > offset (plus the type size) is /// out of bounds.
> >          $(#[$attr])*
> > -        pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
> > +        $vis fn $try_name(&self, offset: usize) -> Result<$type_name>
> > { let addr = self.io_addr::<$type_name>(offset)?;
> >  
> >              // SAFETY: By the type invariant `addr` is a valid
> > address for MMIO operations. @@ -163,74 +167,95 @@ pub fn
> > $try_name(&self, offset: usize) -> Result<$type_name> { }
> >      };
> >  }
> > +pub(crate) use define_read;
> >  
> >  macro_rules! define_write {
> > -    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident <-
> > $type_name:ty) => {
> > +    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident
> > <- $type_name:ty) => { /// Write IO data from a given offset known at
> > compile time. ///
> >          /// Bound checks are performed on compile time, hence if the
> > offset is not known at compile /// time, the build will fail.
> >          $(#[$attr])*
> >          #[inline]
> > -        pub fn $name(&self, value: $type_name, offset: usize) {
> > +        $vis fn $name(&self, value: $type_name, offset: usize) {
> >              let addr = self.io_addr_assert::<$type_name>(offset);
> >  
> >              // SAFETY: By the type invariant `addr` is a valid
> > address for MMIO operations. unsafe { bindings::$c_fn(value, addr as
> > *mut c_void) } }
> > +    };
> >  
> > +    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident,
> > $c_fn:ident <- $type_name:ty) => { /// Write IO data from a given
> > offset. ///
> >          /// Bound checks are performed on runtime, it fails if the
> > offset (plus the type size) is /// out of bounds.
> >          $(#[$attr])*
> > -        pub fn $try_name(&self, value: $type_name, offset: usize) ->
> > Result {
> > +        $vis fn $try_name(&self, value: $type_name, offset: usize) ->
> > Result { let addr = self.io_addr::<$type_name>(offset)?;
> >  
> >              // SAFETY: By the type invariant `addr` is a valid
> > address for MMIO operations.
> > -            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
> > +            unsafe { bindings::$c_fn(value, addr as *mut c_void) };
> >              Ok(())
> >          }
> >      };
> >  }
> > -
> > -impl<const SIZE: usize> Io<SIZE> {
> > -    /// Converts an `IoRaw` into an `Io` instance, providing the
> > accessors to the MMIO mapping.
> > -    ///
> > -    /// # Safety
> > -    ///
> > -    /// Callers must ensure that `addr` is the start of a valid I/O
> > mapped memory region of size
> > -    /// `maxsize`.
> > -    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
> > -        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
> > -        unsafe { &*core::ptr::from_ref(raw).cast() }
> > +pub(crate) use define_write;
> > +
> > +/// Checks whether an access of type `U` at the given `offset`
> > +/// is valid within this region.
> > +#[inline]
> > +const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> > +    let type_size = core::mem::size_of::<U>();
> > +    if let Some(end) = offset.checked_add(type_size) {
> > +        end <= size && offset % type_size == 0
> > +    } else {
> > +        false
> >      }
> > +}
> > +
> > +/// Marker trait indicating that an I/O backend supports operations
> > of a certain type. +///
> > +/// Different I/O backends can implement this trait to expose only
> > the operations they support. +///
> > +/// For example, a PCI configuration space may implement
> > `IoCapable<u8>`, `IoCapable<u16>`, +/// and `IoCapable<u32>`, but not
> > `IoCapable<u64>`, while an MMIO region on a 64-bit +/// system might
> > implement all four. +pub trait IoCapable<T> {}
> > +
> > +/// Types implementing this trait (e.g. MMIO BARs or PCI config
> > regions) +/// can perform I/O operations on regions of memory.
> > +///
> > +/// This is an abstract representation to be implemented by arbitrary
> > I/O +/// backends (e.g. MMIO, PCI config space, etc.).
> > +///
> > +/// The [`Io`] trait provides:
> > +/// - Base address and size information
> > +/// - Helper methods for offset validation and address calculation
> > +/// - Fallible (runtime checked) accessors for different data widths
> > +///
> > +/// Which I/O methods are available depends on which [`IoCapable<T>`]
> > traits +/// are implemented for the type.
> > +///
> > +/// # Examples
> > +///
> > +/// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit
> > systems) are typically +/// supported. For PCI configuration space,
> > u8, u16, and u32 are supported but u64 is not. +pub trait Io {
> > +    /// Minimum usable size of this region.
> > +    const MIN_SIZE: usize;
> >  
> >      /// Returns the base address of this mapping.
> > -    #[inline]
> > -    pub fn addr(&self) -> usize {
> > -        self.0.addr()
> > -    }
> > +    fn addr(&self) -> usize;
> >  
> >      /// Returns the maximum size of this mapping.
> > -    #[inline]
> > -    pub fn maxsize(&self) -> usize {
> > -        self.0.maxsize()
> > -    }
> > -
> > -    #[inline]
> > -    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> > -        let type_size = core::mem::size_of::<U>();
> > -        if let Some(end) = offset.checked_add(type_size) {
> > -            end <= size && offset % type_size == 0
> > -        } else {
> > -            false
> > -        }
> > -    }
> > +    fn maxsize(&self) -> usize;
> >  
> > +    /// Returns the absolute I/O address for a given `offset`,
> > +    /// performing runtime bound checks.
> >      #[inline]
> >      fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> > -        if !Self::offset_valid::<U>(offset, self.maxsize()) {
> > +        if !offset_valid::<U>(offset, self.maxsize()) {
> >              return Err(EINVAL);
> >          }
> >  
> > @@ -239,50 +264,302 @@ fn io_addr<U>(&self, offset: usize) ->
> > Result<usize> { self.addr().checked_add(offset).ok_or(EINVAL)
> >      }
> >  
> > +    /// Returns the absolute I/O address for a given `offset`,
> > +    /// performing compile-time bound checks.
> >      #[inline]
> >      fn io_addr_assert<U>(&self, offset: usize) -> usize {
> > -        build_assert!(Self::offset_valid::<U>(offset, SIZE));
> > +        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
> >  
> >          self.addr() + offset
> >      }
> >  
> > -    define_read!(read8, try_read8, readb -> u8);
> > -    define_read!(read16, try_read16, readw -> u16);
> > -    define_read!(read32, try_read32, readl -> u32);
> > +    /// Fallible 8-bit read with runtime bounds check.
> > +    #[inline(always)]
> > +    fn try_read8(&self, _offset: usize) -> Result<u8>
> > +    where
> > +        Self: IoCapable<u8>,
> > +    {
> > +        const { assert!(false, "Backend does not support fallible
> > 8-bit read") };
> > +        unreachable!()
> 
> I think this is actually where `build_error!()` make sense. Similar to
> how we use it for vtable methods that are not defined (and hence will be
> `None`).
> 
> This would eliminate `unreachable!()`.
> 
> > +    }
> > +
> > +    /// Fallible 16-bit read with runtime bounds check.
> > +    #[inline(always)]
> > +    fn try_read16(&self, _offset: usize) -> Result<u16>
> > +    where
> > +        Self: IoCapable<u16>,
> > +    {
> > +        const { assert!(false, "Backend does not support fallible
> > 16-bit read") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Fallible 32-bit read with runtime bounds check.
> > +    #[inline(always)]
> > +    fn try_read32(&self, _offset: usize) -> Result<u32>
> > +    where
> > +        Self: IoCapable<u32>,
> > +    {
> > +        const { assert!(false, "Backend does not support fallible
> > 32-bit read") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Fallible 64-bit read with runtime bounds check.
> > +    #[cfg(CONFIG_64BIT)]
> > +    #[inline(always)]
> > +    fn try_read64(&self, _offset: usize) -> Result<u64>
> > +    where
> > +        Self: IoCapable<u64>,
> > +    {
> > +        const { assert!(false, "Backend does not support fallible
> > 64-bit read") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Fallible 8-bit write with runtime bounds check.
> > +    #[inline(always)]
> > +    fn try_write8(&self, _value: u8, _offset: usize) -> Result
> > +    where
> > +        Self: IoCapable<u8>,
> > +    {
> > +        const { assert!(false, "Backend does not support fallible
> > 8-bit write") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Fallible 16-bit write with runtime bounds check.
> > +    #[inline(always)]
> > +    fn try_write16(&self, _value: u16, _offset: usize) -> Result
> > +    where
> > +        Self: IoCapable<u16>,
> > +    {
> > +        const { assert!(false, "Backend does not support fallible
> > 16-bit write") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Fallible 32-bit write with runtime bounds check.
> > +    #[inline(always)]
> > +    fn try_write32(&self, _value: u32, _offset: usize) -> Result
> > +    where
> > +        Self: IoCapable<u32>,
> > +    {
> > +        const { assert!(false, "Backend does not support fallible
> > 32-bit write") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Fallible 64-bit write with runtime bounds check.
> > +    #[cfg(CONFIG_64BIT)]
> 
> As Alice mentioned previously, the CONFIG_64BIT shouldn't need to exist
> on the trait.
> 
> The cfg on the impl is sufficient (there might be `Io` that provides
> 64-bit access on 32-bit systems anyway).
> 
> > +    #[inline(always)]
> > +    fn try_write64(&self, _value: u64, _offset: usize) -> Result
> > +    where
> > +        Self: IoCapable<u64>,
> > +    {
> > +        const { assert!(false, "Backend does not support fallible
> > 64-bit write") };
> > +        unreachable!()
> > +    }
> > +}
> > +
> > +/// Types with a known size at compile time can provide infallible
> > I/O accessors. +///
> > +/// This trait extends [`Io`] to provide compile-time bounds-checked
> > I/O operations +/// for regions where the size is known at compile
> > time (e.g., `Mmio<SIZE>`). +pub trait IoKnownSize: Io {
> > +    /// Infallible 8-bit read with compile-time bounds check.
> > +    #[inline(always)]
> > +    fn read8(&self, _offset: usize) -> u8
> > +    where
> > +        Self: IoCapable<u8>,
> 
> I think these *can* be also on `Io` with `Self: IoKnownSize` bound,
> although in practice I don't think it would matter.
> 
> > +    {
> > +        const { assert!(false, "Backend does not support infallible
> > 8-bit read") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Infallible 16-bit read with compile-time bounds check.
> > +    #[inline(always)]
> > +    fn read16(&self, _offset: usize) -> u16
> > +    where
> > +        Self: IoCapable<u16>,
> > +    {
> > +        const { assert!(false, "Backend does not support infallible
> > 16-bit read") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Infallible 32-bit read with compile-time bounds check.
> > +    #[inline(always)]
> > +    fn read32(&self, _offset: usize) -> u32
> > +    where
> > +        Self: IoCapable<u32>,
> > +    {
> > +        const { assert!(false, "Backend does not support infallible
> > 32-bit read") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Infallible 64-bit read with compile-time bounds check.
> > +    #[cfg(CONFIG_64BIT)]
> > +    #[inline(always)]
> > +    fn read64(&self, _offset: usize) -> u64
> > +    where
> > +        Self: IoCapable<u64>,
> > +    {
> > +        const { assert!(false, "Backend does not support infallible
> > 64-bit read") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Infallible 8-bit write with compile-time bounds check.
> > +    #[inline(always)]
> > +    fn write8(&self, _value: u8, _offset: usize)
> > +    where
> > +        Self: IoCapable<u8>,
> > +    {
> > +        const { assert!(false, "Backend does not support infallible
> > 8-bit write") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Infallible 16-bit write with compile-time bounds check.
> > +    #[inline(always)]
> > +    fn write16(&self, _value: u16, _offset: usize)
> > +    where
> > +        Self: IoCapable<u16>,
> > +    {
> > +        const { assert!(false, "Backend does not support infallible
> > 16-bit write") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Infallible 32-bit write with compile-time bounds check.
> > +    #[inline(always)]
> > +    fn write32(&self, _value: u32, _offset: usize)
> > +    where
> > +        Self: IoCapable<u32>,
> > +    {
> > +        const { assert!(false, "Backend does not support infallible
> > 32-bit write") };
> > +        unreachable!()
> > +    }
> > +
> > +    /// Infallible 64-bit write with compile-time bounds check.
> > +    #[cfg(CONFIG_64BIT)]
> > +    #[inline(always)]
> > +    fn write64(&self, _value: u64, _offset: usize)
> > +    where
> > +        Self: IoCapable<u64>,
> > +    {
> > +        const { assert!(false, "Backend does not support infallible
> > 64-bit write") };
> > +        unreachable!()
> > +    }
> > +}
> > +
> > +// MMIO regions support 8, 16, and 32-bit accesses.
> > +impl<const SIZE: usize> IoCapable<u8> for Mmio<SIZE> {}
> > +impl<const SIZE: usize> IoCapable<u16> for Mmio<SIZE> {}
> > +impl<const SIZE: usize> IoCapable<u32> for Mmio<SIZE> {}
> > +
> > +// MMIO regions on 64-bit systems also support 64-bit accesses.
> > +#[cfg(CONFIG_64BIT)]
> > +impl<const SIZE: usize> IoCapable<u64> for Mmio<SIZE> {}
> > +
> > +impl<const SIZE: usize> Io for Mmio<SIZE> {
> > +    const MIN_SIZE: usize = SIZE;
> > +
> > +    /// Returns the base address of this mapping.
> > +    #[inline]
> > +    fn addr(&self) -> usize {
> > +        self.0.addr()
> > +    }
> > +
> > +    /// Returns the maximum size of this mapping.
> > +    #[inline]
> > +    fn maxsize(&self) -> usize {
> > +        self.0.maxsize()
> > +    }
> > +
> > +    define_read!(fallible, try_read8, readb -> u8);
> > +    define_read!(fallible, try_read16, readw -> u16);
> > +    define_read!(fallible, try_read32, readl -> u32);
> >      define_read!(
> > +        fallible,
> >          #[cfg(CONFIG_64BIT)]
> > -        read64,
> >          try_read64,
> >          readq -> u64
> >      );
> >  
> > -    define_read!(read8_relaxed, try_read8_relaxed, readb_relaxed ->
> > u8);
> > -    define_read!(read16_relaxed, try_read16_relaxed, readw_relaxed ->
> > u16);
> > -    define_read!(read32_relaxed, try_read32_relaxed, readl_relaxed ->
> > u32);
> > +    define_write!(fallible, try_write8, writeb <- u8);
> > +    define_write!(fallible, try_write16, writew <- u16);
> > +    define_write!(fallible, try_write32, writel <- u32);
> > +    define_write!(
> > +        fallible,
> > +        #[cfg(CONFIG_64BIT)]
> > +        try_write64,
> > +        writeq <- u64
> > +    );
> > +}
> > +
> > +impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
> > +    define_read!(infallible, read8, readb -> u8);
> > +    define_read!(infallible, read16, readw -> u16);
> > +    define_read!(infallible, read32, readl -> u32);
> >      define_read!(
> > +        infallible,
> >          #[cfg(CONFIG_64BIT)]
> > -        read64_relaxed,
> > -        try_read64_relaxed,
> > -        readq_relaxed -> u64
> > +        read64,
> > +        readq -> u64
> >      );
> >  
> > -    define_write!(write8, try_write8, writeb <- u8);
> > -    define_write!(write16, try_write16, writew <- u16);
> > -    define_write!(write32, try_write32, writel <- u32);
> > +    define_write!(infallible, write8, writeb <- u8);
> > +    define_write!(infallible, write16, writew <- u16);
> > +    define_write!(infallible, write32, writel <- u32);
> >      define_write!(
> > +        infallible,
> >          #[cfg(CONFIG_64BIT)]
> >          write64,
> > -        try_write64,
> >          writeq <- u64
> >      );
> > +}
> > +
> > +impl<const SIZE: usize> Mmio<SIZE> {
> > +    /// Converts an `MmioRaw` into an `Mmio` instance, providing the
> > accessors to the MMIO mapping.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `addr` is the start of a valid I/O
> > mapped memory region of size
> > +    /// `maxsize`.
> > +    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
> > +        // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
> > +        unsafe { &*core::ptr::from_ref(raw).cast() }
> > +    }
> > +
> > +    define_read!(infallible, pub read8_relaxed, readb_relaxed -> u8);
> > +    define_read!(infallible, pub read16_relaxed, readw_relaxed ->
> > u16);
> > +    define_read!(infallible, pub read32_relaxed, readl_relaxed ->
> > u32);
> > +    define_read!(
> > +        infallible,
> > +        #[cfg(CONFIG_64BIT)]
> > +        pub read64_relaxed,
> > +        readq_relaxed -> u64
> > +    );
> > +
> > +    define_read!(fallible, pub try_read8_relaxed, readb_relaxed ->
> > u8);
> > +    define_read!(fallible, pub try_read16_relaxed, readw_relaxed ->
> > u16);
> > +    define_read!(fallible, pub try_read32_relaxed, readl_relaxed ->
> > u32);
> > +    define_read!(
> > +        fallible,
> > +        #[cfg(CONFIG_64BIT)]
> > +        pub try_read64_relaxed,
> > +        readq_relaxed -> u64
> > +    );
> > +
> > +    define_write!(infallible, pub write8_relaxed, writeb_relaxed <-
> > u8);
> > +    define_write!(infallible, pub write16_relaxed, writew_relaxed <-
> > u16);
> > +    define_write!(infallible, pub write32_relaxed, writel_relaxed <-
> > u32);
> > +    define_write!(
> > +        infallible,
> > +        #[cfg(CONFIG_64BIT)]
> > +        pub write64_relaxed,
> > +        writeq_relaxed <- u64
> > +    );
> >  
> > -    define_write!(write8_relaxed, try_write8_relaxed, writeb_relaxed
> > <- u8);
> > -    define_write!(write16_relaxed, try_write16_relaxed,
> > writew_relaxed <- u16);
> > -    define_write!(write32_relaxed, try_write32_relaxed,
> > writel_relaxed <- u32);
> > +    define_write!(fallible, pub try_write8_relaxed, writeb_relaxed <-
> > u8);
> > +    define_write!(fallible, pub try_write16_relaxed, writew_relaxed
> > <- u16);
> > +    define_write!(fallible, pub try_write32_relaxed, writel_relaxed
> > <- u32); define_write!(
> > +        fallible,
> >          #[cfg(CONFIG_64BIT)]
> > -        write64_relaxed,
> > -        try_write64_relaxed,
> > +        pub try_write64_relaxed,
> >          writeq_relaxed <- u64
> >      );
> >  }
> > diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> > index e4878c131c6d..620022cff401 100644
> > --- a/rust/kernel/io/mem.rs
> > +++ b/rust/kernel/io/mem.rs
> > @@ -16,8 +16,8 @@
> >              Region,
> >              Resource, //
> >          },
> > -        Io,
> > -        IoRaw, //
> > +        Mmio,
> > +        MmioRaw, //
> >      },
> >      prelude::*,
> >  };
> > @@ -212,7 +212,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl
> > PinInit<Devres<Self>, Error> + }
> >  
> >  impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
> > -    type Target = Io<SIZE>;
> > +    type Target = Mmio<SIZE>;
> >  
> >      fn deref(&self) -> &Self::Target {
> >          &self.iomem
> > @@ -226,10 +226,10 @@ fn deref(&self) -> &Self::Target {
> >  ///
> >  /// # Invariants
> >  ///
> > -/// [`IoMem`] always holds an [`IoRaw`] instance that holds a valid
> > pointer to the +/// [`IoMem`] always holds an [`MmioRaw`] instance
> > that holds a valid pointer to the /// start of the I/O memory mapped
> > region. pub struct IoMem<const SIZE: usize = 0> {
> > -    io: IoRaw<SIZE>,
> > +    io: MmioRaw<SIZE>,
> >  }
> >  
> >  impl<const SIZE: usize> IoMem<SIZE> {
> > @@ -264,7 +264,7 @@ fn ioremap(resource: &Resource) -> Result<Self> {
> >              return Err(ENOMEM);
> >          }
> >  
> > -        let io = IoRaw::new(addr as usize, size)?;
> > +        let io = MmioRaw::new(addr as usize, size)?;
> >          let io = IoMem { io };
> >  
> >          Ok(io)
> > @@ -287,10 +287,10 @@ fn drop(&mut self) {
> >  }
> >  
> >  impl<const SIZE: usize> Deref for IoMem<SIZE> {
> > -    type Target = Io<SIZE>;
> > +    type Target = Mmio<SIZE>;
> >  
> >      fn deref(&self) -> &Self::Target {
> >          // SAFETY: Safe as by the invariant of `IoMem`.
> > -        unsafe { Io::from_raw(&self.io) }
> > +        unsafe { Mmio::from_raw(&self.io) }
> >      }
> >  }
> > diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> > index b1a2570364f4..75d1b3e8596c 100644
> > --- a/rust/kernel/io/poll.rs
> > +++ b/rust/kernel/io/poll.rs
> > @@ -45,12 +45,16 @@
> >  /// # Examples
> >  ///
> >  /// ```no_run
> > -/// use kernel::io::{Io, poll::read_poll_timeout};
> > +/// use kernel::io::{
> > +///     Io,
> > +///     Mmio,
> > +///     poll::read_poll_timeout, //
> > +/// };
> >  /// use kernel::time::Delta;
> >  ///
> >  /// const HW_READY: u16 = 0x01;
> >  ///
> > -/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
> > +/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) ->
> > Result { ///     read_poll_timeout(
> >  ///         // The `op` closure reads the value of a specific status
> > register. ///         || io.try_read16(0x1000),
> > @@ -128,12 +132,16 @@ pub fn read_poll_timeout<Op, Cond, T>(
> >  /// # Examples
> >  ///
> >  /// ```no_run
> > -/// use kernel::io::{poll::read_poll_timeout_atomic, Io};
> > +/// use kernel::io::{
> > +///     Io,
> > +///     Mmio,
> > +///     poll::read_poll_timeout_atomic, //
> > +/// };
> >  /// use kernel::time::Delta;
> >  ///
> >  /// const HW_READY: u16 = 0x01;
> >  ///
> > -/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
> > +/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) ->
> > Result { ///     read_poll_timeout_atomic(
> >  ///         // The `op` closure reads the value of a specific status
> > register. ///         || io.try_read16(0x1000),
> > diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> > index 70e3854e7d8d..e3377397666e 100644
> > --- a/rust/kernel/pci/io.rs
> > +++ b/rust/kernel/pci/io.rs
> > @@ -8,8 +8,8 @@
> >      device,
> >      devres::Devres,
> >      io::{
> > -        Io,
> > -        IoRaw, //
> > +        Mmio,
> > +        MmioRaw, //
> >      },
> >      prelude::*,
> >      sync::aref::ARef, //
> > @@ -27,7 +27,7 @@
> >  /// memory mapped PCI BAR and its size.
> >  pub struct Bar<const SIZE: usize = 0> {
> >      pdev: ARef<Device>,
> > -    io: IoRaw<SIZE>,
> > +    io: MmioRaw<SIZE>,
> >      num: i32,
> >  }
> >  
> > @@ -63,7 +63,7 @@ pub(super) fn new(pdev: &Device, num: u32, name:
> > &CStr) -> Result<Self> { return Err(ENOMEM);
> >          }
> >  
> > -        let io = match IoRaw::new(ioptr, len as usize) {
> > +        let io = match MmioRaw::new(ioptr, len as usize) {
> >              Ok(io) => io,
> >              Err(err) => {
> >                  // SAFETY:
> > @@ -117,11 +117,11 @@ fn drop(&mut self) {
> >  }
> >  
> >  impl<const SIZE: usize> Deref for Bar<SIZE> {
> > -    type Target = Io<SIZE>;
> > +    type Target = Mmio<SIZE>;
> >  
> >      fn deref(&self) -> &Self::Target {
> >          // SAFETY: By the type invariant of `Self`, the MMIO range in
> > `self.io` is properly mapped.
> > -        unsafe { Io::from_raw(&self.io) }
> > +        unsafe { Mmio::from_raw(&self.io) }
> >      }
> >  }
> >  
> > diff --git a/samples/rust/rust_driver_pci.rs
> > b/samples/rust/rust_driver_pci.rs index ef04c6401e6a..bfb053059667
> > 100644 --- a/samples/rust/rust_driver_pci.rs
> > +++ b/samples/rust/rust_driver_pci.rs
> > @@ -7,6 +7,10 @@
> >  use kernel::{
> >      device::Core,
> >      devres::Devres,
> > +    io::{
> > +        Io,
> > +        IoKnownSize, //
> > +    },
> >      pci,
> >      prelude::*,
> >      sync::aref::ARef, //
> 

