Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4192635677E;
	Wed, 19 Aug 2026 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128551; cv=fail; b=XjC4ylhY/AfRRPJDsnHU4cnQPMIKeff95gOvBBJGdb+Bx7KcpJbG5f9G9Z/SlBrEVDiil7HVdsEQyS8m4tWq96xytCDZdFHJp4u0ltP3AaoQJG9OR2ET7L4StLD0No/NGHqfqTqxZVPiLgu1s/fCdAJHADZgwJV5u5bQz+n06DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128551; c=relaxed/simple;
	bh=HR/7UCtMoy7oIFROjIQQySj9R/piLZyAM7RvIYQzisQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfOQKbnz47ChLXWqna7CIHbs8ZpScRxbXU0qqOSOF+TQis/D1tSigHSyRIjZuS6D26xqEnq3eSsP8TSXccj3/I6HDyHQk05eqwjOWGz2T/7wqGz3j80+C1myULBDWrkHlvhL02kKDmfVNYQxxNuD1/tkdQ3Z4sojuRRisyHO+qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VyUM9Moo; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VyUM9Moo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvTqyulxfPo4xaRLFyaBk9macpniXHrbCbmKmvOHTcfhcStbF7UR0sTStV6zzo6sQkba9dt+A86eN2cMS8I1OYafmO9ddWx6nsCunvkry1KRIXy6rlrhHy9dbDAvaO3b14m2VC1gazRYCvq1FC3P9pBHD2HHNJPpSyzO4aha5JsYWt7jL2UqQilZGTBgey0EFDpicPBQgLmXBHB5x1ciPzGkp8F1FrbfwxHnjrqgON0cCwOPOP25QeCWaCFj2XoDm0TcI6kAtx00rOVgBRfmAAgHLFPtNiAyPR6Lo8hNgSvE2Kejo3sFKYICxCrf0KvG6cF0Qxz6DFt4EIOmXuZvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaqFVYiQCiZZnN9dM/UKUzVsuNXzar6+gS+evgh/cbs=;
 b=qgmHk+rmogCmo4hdJStKG1ySUzXT4TZe4WhJedIUC0RlFwHIj7DOoR7uKIz1NoYeOj+wr+wg0bHrvIgdloYF7tQj87h1GqKyCxhlgu2K9nBFHoxLdoULBFN2n1r84P5DBLfsv13WE3aVRDoEpf52L4+IavmIi9tvN2l8NRFjHaC9/EErjWqIZGYTgCKMj61x0/beGFkk3KR9oUtUqC7DF/DvrozbEiMgOnp/OraZQpe3QOmDOp/pQROO/LIyYDH5xYVoYn7q0EROcKS13tvdR9lw2EAWttTxtKv2oWYELIa1vLmUAGxPVvHpqWylI9gp8ZgFSd4ApIvu2wHZ93RQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=garyguo.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaqFVYiQCiZZnN9dM/UKUzVsuNXzar6+gS+evgh/cbs=;
 b=VyUM9MoohjW9FojhCbsL7/2Hy3x9GbfMjgEDexlgUoLFjqp4QSLyCFHpiQdrXzJjBMLGKRssxcWWfd7Cw2JA2bNuu1TDlLSJINpOx0+6hIcHYj+525vGVRlNWn7CKSPcphKGlGRX9eSiwkY8TL64vUfSWC7F0uVm9tJ3c06hJ+4Ucfvzrrn2BPgV7GVI40HAwotZTfTIc6xbpWbhNYK0xVsWO1i7SVNb5pZSC+ahR4ITGL2CuVESleZwKhPGRd8XOA15NpqbEPiG33doEfgKRSTPwI4R4R5ZwcZYL1bktpKqsYfZFxCiIRex71ihs5XW5goFW2+jOuNT1mKGHiSMRA==
Received: from BN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:408:ee::24)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 19 Aug
 2026 08:35:40 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::ab) by BN0PR04CA0019.outlook.office365.com
 (2603:10b6:408:ee::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 08:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 08:35:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 19 Aug
 2026 01:35:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 19 Aug 2026 01:35:24 -0700
Received: from inno-dell (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Wed, 19 Aug 2026 01:35:17 -0700
Date: Wed, 19 Aug 2026 11:35:15 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Gary Guo <gary@garyguo.net>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
Subject: Re: [PATCH v7 1/1] rust: pci: add extended capability and SR-IOV
 support
Message-ID: <20260819113515.55bc1132@inno-dell>
In-Reply-To: <DKNU588R9B98.2UEHK3YLII989@garyguo.net>
References: <20260804161612.776752-1-zhiw@nvidia.com>
	<20260804161612.776752-2-zhiw@nvidia.com>
	<DKNU588R9B98.2UEHK3YLII989@garyguo.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: f618c520-1939-4fa3-0352-08defdccd9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|23010399003|82310400026|56012099006|11063799006|10067099003|6133799003|4143699003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	tMZtdlJRg/iw5NuOlvIh+LN0HkReHCwTI2my1Xsb8zi6L41PglZwAExBhsXJmEK+r3O+YZi25wInBRL9sIu9yWy7bwGUlXMuK9KVxir0AXvowD/mHKCaXFGu2kZMRIDq3LO3Ge8fORs1dzwYNvOTR+5Jq4XTFk55aW5wxbTJ8OKWPQOuCtPuMeQdp0IYJLewt/lAsHfQPX/IoSEToTV5q8kSI3+cU+U6QOPBrahkjp6n1k3RjwNvUb6zYrLGQq8kzLOxqsYOJnJFELq63YXCmRgS6O87Gha0cR2w3wpb0rCUqNt437+ZqJT6ejmQmsMzM9nyGRrGFQIdkLN/+2Tc9pfytHNhYmpCDXY5ex3BP4fsQ1wu8zxI4CrLPlSI+1nZI5xAvv4x6X55rtI/KJYEJo6C6pDfya2/470VVSFqcZNkakoxlDCOcDwFqjfhGK74VwEZEC7OnRqCn/7DdK42GOsK5j75l01+1nHUM8TlXqoZImVSsGJ9Zq+0BfO9FCqXgQ26gV8FWIVttmUp/+Wbv5FCM5AMwzTWBIyQvYXVf9QJ27ypSeDgmcNtGYmFBysRg/hMdap+NJZtfAgFyunhWp4duiDhatVHbOWPc1LSUCxb/GLIEvG6h/+6W0G60VaTQhg6+EaZLgQSvvODY5AE9gzsUbQ6MKkTrAFMU+4b6xQGgUrYUb8nwaXp2A5LUlsi80F7cXPIcAFUvBQI9p7PgA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(6133799003)(4143699003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UEI1JurU9JtlEbn0HxPl7/lEKOW0ULMFKemi15P2v4xuD7R+RSEkrpx/nHD+hH6B8Owxd1c2DMqWu9vEEN2M+2oZnTkszRghiTsJfHvnJSnFPu2IW0vAxhl6j48pG9CK+LFl+T8RQU3P4jiyG/UUKl5CQtki+KAeVHGd38JrknkpMWDPyfXw3EQtQMFtJMEg5BcRTf4kpRFOYVk+Hlq87K0LqNiY02k0HZAE4gi1nTT0eTnItJGc+UPb/1U/7Di5Sluy7eG6wQG4snhOomWEqrlfQ8jeD3h6v0HzkC2lbHrgmhz1JHOp5dE4SKRhpSpibNFZlobQDF2bWUrViqJJqaPV6FpETv7NQdmjC0vn2ZPalDCB79XNvSNPA5B/kBshR99J9dYPtUxFHm7DMnuwXiI5Jqbzus2WDKwJMEjKiVgv8LixY0RHB3KYjE7HxJgt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 08:35:39.7583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f618c520-1939-4fa3-0352-08defdccd9a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870

On Thu, 13 Aug 2026 14:04:00 +0100
"Gary Guo" <gary@garyguo.net> wrote:

Hi Gary:

Thanks for the review. I have already addressed all of them in v8.

Z.

> On Tue Aug 4, 2026 at 5:16 PM BST, Zhi Wang wrote:
> > Rust PCI drivers have no typed interface for locating and accessing
> > PCIe extended capabilities.
> >
> > The SR-IOV extended capability describes VF topology and VF BARs.
> > Expose this information through the Rust PCI abstraction so drivers
> > can use the existing typed configuration-space accessors instead of
> > raw bindings.
> >
> > Define ExtCapability to associate a capability ID with a register
> > layout, and add ConfigSpace::find_ext_capability() to locate and
> > project that layout. Bound the view at the next capability or the
> > end of extended configuration space. Add ExtSriovRegs and a decoded
> > VF BAR iterator that reads and validates all six VF BAR register
> > slots up front, yields decoded BAR addresses and widths in logical
> > order, and keeps the raw configuration-space slot advancement
> > internal. Since PCI_EXT_CAP_NEXT() is a function-like macro, expose
> > it through a Rust helper.
> >
> > Link:
> > https://lore.kernel.org/rust-for-linux/20260730182954.783568-1-zhiw@nvi=
dia.com/
> > Cc: Alexandre Courbot <acourbot@nvidia.com> Cc: Gary Guo
> > <gary@garyguo.net> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > ---
> >  rust/helpers/pci.c     |   5 +
> >  rust/kernel/pci.rs     |   8 ++
> >  rust/kernel/pci/cap.rs | 317
> > +++++++++++++++++++++++++++++++++++++++++ 3 files changed, 330
> > insertions(+) create mode 100644 rust/kernel/pci/cap.rs
> >
> > diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> > index 4ebf256dff23..b946b14d79e4 100644
> > --- a/rust/helpers/pci.c
> > +++ b/rust/helpers/pci.c
> > @@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const
> > struct device *dev) return dev_is_pci(dev);
> >  }
> > =20
> > +__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
> > +{
> > +	return PCI_EXT_CAP_NEXT(header);
> > +}
> > +
> >  #ifndef CONFIG_PCI_IOV
> >  __rust_helper unsigned int
> >  rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 9f19ccd5905c..008c2770a3f3 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -32,10 +32,18 @@
> >      },
> >  };
> > =20
> > +mod cap;
> >  mod id;
> >  mod io;
> >  mod irq;
> > =20
> > +pub use self::cap::{
> > +    ExtCapId,
> > +    ExtCapability,
> > +    ExtSriovCapability,
> > +    ExtSriovRegs,
> > +    ExtSriovVfBar, //
> > +};
> >  pub use self::id::{
> >      Class,
> >      ClassMask,
> > diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> > new file mode 100644
> > index 000000000000..c49de8682f6d
> > --- /dev/null
> > +++ b/rust/kernel/pci/cap.rs
> > @@ -0,0 +1,317 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! PCI extended capability support.
> > +
> > +use super::{
> > +    io::ConfigSpaceBackend,
> > +    ConfigSpace,
> > +    Extended, //
> > +};
> > +use crate::{
> > +    bindings,
> > +    io::{
> > +        Io,
> > +        IoBackend,
> > +        Region, //
> > +    },
> > +    num::Bounded,
> > +    prelude::*,
> > +};
> > +
> > +/// Number of VF BAR register slots in an SR-IOV capability.
> > +// CAST: `PCI_SRIOV_NUM_BARS` is 6, which fits in `usize`.
> > +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
> > +
> > +/// PCI extended capability IDs.
> > +#[repr(u16)]
> > +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> > +pub enum ExtCapId {
> > +    /// Single Root I/O Virtualization.
> > +    // CAST: `PCI_EXT_CAP_ID_SRIOV` is `0x10`, which fits in `u16`.
> > +    Sriov =3D bindings::PCI_EXT_CAP_ID_SRIOV as u16,
> > +}
>=20
> This might also make sense as a `struct` with assoc constants, so it
> can accept unknown values.
>=20
>     #[repr(transparent)]
>     #[derive(...)]
>     pub struct ExtCapId(u16);
>=20
>     impl ExtCapId {
>         pub const SRIOV: Self =3D Self(bindings::PCI_EXT_CAP_ID_SRIOV
> as u16); }
>=20
> > +
> > +impl ExtCapId {
> > +    #[inline]
> > +    fn as_raw(self) -> u16 {
> > +        self as u16
> > +    }
> > +}
> > +
> > +/// A typed PCI extended capability register layout.
> > +///
> > +/// Implementors describe the register layout of one extended
> > capability. The layout must start at +/// the extended capability
> > header, and [`Self::ID`] must identify that layout. +pub trait
> > ExtCapability: FromBytes + IntoBytes {
> > +    /// PCI extended capability ID for this register layout.
> > +    const ID: ExtCapId;
> > +}
> > +
> > +impl<'a> ConfigSpace<'a, Extended> {
> > +    /// Finds and projects an extended capability into its typed
> > register layout.
> > +    ///
> > +    /// Returns [`None`] if the device does not implement the
> > capability.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```no_run
> > +    /// use kernel::pci;
> > +    ///
> > +    /// fn probe_sriov(
> > +    ///     pdev: &pci::Device<kernel::device::Bound>,
> > +    /// ) -> Result<(), kernel::error::Error> {
> > +    ///     let Some(sriov) =3D pdev
> > +    ///         .config_space_extended()?
> > +    ///         .find_ext_capability::<pci::ExtSriovRegs>()?
> > +    ///     else {
> > +    ///         return Ok(());
> > +    ///     };
> > +    ///
> > +    ///     let total_vfs =3D kernel::io_read!(sriov, .total_vfs);
> > +    ///     let vf_offset =3D kernel::io_read!(sriov, .vf_offset);
> > +    ///     let mut vf_bars =3D sriov.vf_bars()?;
> > +    ///     let bar0 =3D
> > vf_bars.next().ok_or(kernel::error::code::EINVAL)?;
>=20
> Error codes are in the prelude.
>=20
> > +    ///     let bar1 =3D
> > vf_bars.next().ok_or(kernel::error::code::EINVAL)?;
> > +    ///     let bar2 =3D
> > vf_bars.next().ok_or(kernel::error::code::EINVAL)?;
> > +    ///
> > +    ///     Ok(())
> > +    /// }
> > +    /// ```
> > +    pub fn find_ext_capability<C: ExtCapability>(&self) ->
> > Result<Option<ConfigSpace<'a, C>>> {
> > +        let offset =3D usize::from(
> > +            // SAFETY: `self.pdev` is valid by the type invariant
> > of `ConfigSpace`.
> > +            unsafe {
> > +
> > bindings::pci_find_ext_capability(self.pdev.as_raw(),
> > i32::from(C::ID.as_raw()))
> > +            },
> > +        );
> > +
> > +        if offset =3D=3D 0 {
> > +            return Ok(None);
> > +        }
> > +
> > +        let size =3D self.calculate_ext_cap_size(offset)?;
> > +
> > +        let base =3D ConfigSpaceBackend::as_ptr(*self)
> > +            .cast::<u8>()
> > +            .wrapping_add(offset);
> > +        let ptr =3D Region::<0>::ptr_try_from_raw_parts_mut(base,
> > size)?; +
> > +        // SAFETY: `offset` was returned by
> > `pci_find_ext_capability`, and
> > +        // `calculate_ext_cap_size` bounds `ptr` at the next
> > capability or the end of the extended
> > +        // configuration space. `ptr_try_from_raw_parts_mut`
> > verified the region layout.
> > +        let capability =3D unsafe {
> > ConfigSpaceBackend::project_view(*self, ptr) }; +
> > +        capability.try_cast::<C>().map(Some)
>=20
> Is this cast failure is supposed to be error condition?
>=20
> > +    }
> > +
> > +    /// Calculates the size of the extended capability at `offset`.
> > +    ///
> > +    /// The capability extends to the next extended capability, or
> > to the end of the extended
> > +    /// configuration space if it is the last one. `offset` must
> > be a DWORD-aligned offset within
> > +    /// the extended configuration space returned by
> > `pci_find_ext_capability`. Returns an error if
> > +    /// the capability header is outside the extended
> > configuration space.
> > +    fn calculate_ext_cap_size(&self, offset: usize) ->
> > Result<usize> {
> > +        let header =3D self.try_read32(offset)?;
> > +        // SAFETY: Pure bit manipulation, no preconditions.
> > +        // CAST: The next-cap pointer is a 12-bit field (max
> > 0xFFC), always fits in `usize`.
> > +        let next =3D unsafe { bindings::pci_ext_cap_next(header) }
> > as usize; +
> > +        Ok(if next > offset {
> > +            next - offset
> > +        } else {
> > +            self.size() - offset
> > +        })
> > +    }
> > +}
> > +
> > +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap
> > offset). +#[repr(C)]
> > +#[derive(FromBytes, IntoBytes)]
> > +pub struct ExtSriovRegs {
> > +    /// Extended capability header.
> > +    pub header: u32,
>=20
> I think this shouldn't be public.
>=20
> > +    /// SR-IOV capabilities.
> > +    pub cap: u32,
> > +    /// SR-IOV control.
> > +    pub ctrl: u16,
> > +    /// SR-IOV status.
> > +    pub status: u16,
> > +    /// Initial VFs.
> > +    pub initial_vfs: u16,
> > +    /// Total VFs.
> > +    pub total_vfs: u16,
> > +    /// Number of VFs.
> > +    pub num_vfs: u16,
> > +    /// Function dependency link.
> > +    pub func_dep_link: u8,
> > +    _reserved_0: u8,
> > +    /// First VF offset.
> > +    pub vf_offset: u16,
> > +    /// VF stride.
> > +    pub vf_stride: u16,
> > +    _reserved_1: u16,
> > +    /// VF device ID.
> > +    pub vf_device_id: u16,
> > +    /// Supported page sizes.
> > +    pub supported_page_sizes: u32,
> > +    /// System page size.
> > +    pub system_page_size: u32,
> > +    /// VF BARs (BAR0=E2=80=93BAR5).
> > +    pub vf_bar: [u32; NUM_VF_BARS],
> > +    /// VF migration state array offset.
> > +    pub migration_state: u32,
> > +}
> > +
> > +impl ExtCapability for ExtSriovRegs {
> > +    const ID: ExtCapId =3D ExtCapId::Sriov;
> > +}
> > +
> > +/// A typed view of an SR-IOV extended capability.
> > +pub type ExtSriovCapability<'a> =3D ConfigSpace<'a, ExtSriovRegs>;
> > +
> > +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> > +enum VfBarMemoryType {
> > +    Bits32,
> > +    Bits64,
> > +}
> > +
> > +impl TryFrom<Bounded<u32, 2>> for VfBarMemoryType {
> > +    type Error =3D Error;
> > +
> > +    fn try_from(value: Bounded<u32, 2>) -> Result<Self> {
> > +        match value.get() {
> > +            0b00 =3D> Ok(Self::Bits32),
> > +            0b10 =3D> Ok(Self::Bits64),
> > +            _ =3D> Err(EINVAL),
> > +        }
> > +    }
> > +}
> > +
> > +impl From<VfBarMemoryType> for Bounded<u32, 2> {
> > +    fn from(value: VfBarMemoryType) -> Self {
> > +        match value {
> > +            VfBarMemoryType::Bits32 =3D> Self::new::<0b00>(),
> > +            VfBarMemoryType::Bits64 =3D> Self::new::<0b10>(),
> > +        }
> > +    }
> > +}
> > +
> > +crate::bitfield! {
> > +    /// Low DWORD of an SR-IOV VF BAR.
> > +    struct VfBarLow(u32) {
> > +        /// Base address bits 31:4.
> > +        31:4 address;
> > +        /// Whether the address range is prefetchable.
> > +        3:3 prefetchable =3D> bool;
> > +        /// Memory BAR type.
> > +        2:1 memory_type ?=3D> VfBarMemoryType;
> > +        /// Whether this is an I/O-space BAR.
> > +        0:0 io_space =3D> bool;
> > +    }
> > +}
> > +
> > +/// A decoded VF BAR register encoding.
> > +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> > +pub struct ExtSriovVfBar {
> > +    /// The BAR address without PCI attribute bits.
> > +    pub address: u64,
> > +
> > +    /// Whether the BAR is 64-bit.
> > +    pub is_64bit: bool,
> > +}
> > +
> > +/// Iterator over decoded VF BAR register encodings.
> > +///
> > +/// `slots` contains the six consecutive 32-bit registers VF BAR0
> > through VF BAR5. A 32-bit +/// memory BAR encoding uses one
> > register. A 64-bit memory BAR encoding uses that register for +///
> > bits 31:0 and the immediately following register for bits 63:32.
> > +/// +/// # Invariants
> > +///
> > +/// - `config_slot <=3D NUM_VF_BARS`.
> > +/// - If `config_slot < NUM_VF_BARS`, it identifies the next
> > register to interpret as a BAR low +///   DWORD. Its address-space
> > encoding is memory and its type encoding is either 32-bit or
> > 64-bit. +/// - If that low DWORD encodes a 64-bit BAR, `config_slot
> > + 1 < NUM_VF_BARS`, and the register at +///   `config_slot + 1` is
> > its upper DWORD. +struct ExtSriovVfBars {
> > +    slots: [u32; NUM_VF_BARS],
> > +    config_slot: usize,
> > +}
> > +
> > +impl ExtSriovVfBars {
> > +    fn new(slots: [u32; NUM_VF_BARS]) -> Result<Self> {
> > +        let mut config_slot =3D 0;
> > +
> > +        while config_slot < NUM_VF_BARS {
> > +            let low =3D VfBarLow::from(slots[config_slot]);
> > +
> > +            if low.io_space() {
> > +                return Err(EINVAL);
> > +            }
> > +
> > +            let is_64bit =3D low.memory_type()? =3D=3D
> > VfBarMemoryType::Bits64; +
> > +            if is_64bit {
> > +                if config_slot + 1 >=3D NUM_VF_BARS {
> > +                    return Err(EINVAL);
> > +                }
> > +
> > +                config_slot +=3D 2;
> > +            } else {
> > +                config_slot +=3D 1;
> > +            }
>=20
> So you're already decoding the vf bars here, but the `next` does an
> additional decoding. I think you should just decode them in one place.
>=20
> Best,
> Gary
>=20
> > +        }
> > +
> > +        Ok(Self {
> > +            slots,
> > +            config_slot: 0,
> > +        })
> > +    }
> > +}
> > +
> > +impl Iterator for ExtSriovVfBars {
> > +    type Item =3D ExtSriovVfBar;
> > +
> > +    fn next(&mut self) -> Option<Self::Item> {
> > +        if self.config_slot >=3D NUM_VF_BARS {
> > +            return None;
> > +        }
> > +
> > +        let config_slot =3D self.config_slot;
> > +        let low =3D VfBarLow::from(self.slots[config_slot]);
> > +        let is_64bit =3D matches!(low.memory_type(),
> > Ok(VfBarMemoryType::Bits64));
> > +        let low_address =3D u64::from(low.address()) <<
> > VfBarLow::ADDRESS_SHIFT; +
> > +        let address =3D if is_64bit {
> > +            let high =3D self.slots[config_slot + 1];
> > +            self.config_slot +=3D 2;
> > +            (u64::from(high) << 32) | low_address
> > +        } else {
> > +            self.config_slot +=3D 1;
> > +            low_address
> > +        };
> > +
> > +        Some(ExtSriovVfBar { address, is_64bit })
> > +    }
> > +}
> > +
> > +impl ExtSriovCapability<'_> {
> > +    /// Returns an iterator over decoded VF BAR register encodings.
> > +    ///
> > +    /// The iterator tracks the six raw VF BAR register slots
> > internally. A 32-bit encoding yields
> > +    /// one entry and advances by one slot; a 64-bit encoding
> > combines two slots into one entry.
> > +    ///
> > +    /// A zero-valued low DWORD is yielded as a 32-bit BAR at
> > address zero; this method does not
> > +    /// probe whether a BAR is implemented.
> > +    ///
> > +    /// Returns [`EINVAL`] and logs an error if a BAR low DWORD
> > does not encode a 32-bit or 64-bit
> > +    /// memory BAR, or if a 64-bit encoding has no upper DWORD.
> > +    pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D
> > ExtSriovVfBar>> {
> > +        let slots: [u32; NUM_VF_BARS] =3D
> > +            core::array::from_fn(|slot| crate::io_read!(*self,
> > .vf_bar[panic: slot])); +
> > +        ExtSriovVfBars::new(slots).inspect_err(|_| {
> > +            dev_err!(self.pdev, "invalid VF BAR encoding in SR-IOV
> > capability\n");
> > +        })
> > +    }
> > +}
>=20
>=20

