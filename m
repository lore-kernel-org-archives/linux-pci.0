Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4BF347BD9;
	Wed, 21 Jan 2026 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021636; cv=fail; b=i9CLctIPkQHVx04nkmrNr/NppWwOXgzw3S04KrG3v+RuSlvvecdSyTM/vki77Qp4vtLjbBAD84nm+8XCj3kG+2qSNRHp2Msa2mLpqkBtAnfgYCUZV2JWj+XCP8MugV9btJdhIRRCIpAA2Q6L9pHkD942yD0GUwMu/yLgxlRJ5Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021636; c=relaxed/simple;
	bh=FesCAl0S8S0I9muw2G6joQkeOf0ZR8R2jF0rvT923MI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cF+Qhi/d2uro7wKJ7lg4DzNHSgwL7NlKa8HDAJNfHFDlilcJwtXhheg6JdQgaYrsX3SlxwsS/NgpJtEvph+3yjBcF/LPsj8wlN+9GGAxScYi9pAPOL9cqSc0ixJSfXz6N0v7iXkveB7q5fXxaOcVjJNFi0lIAnfSodESKDi0KdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eM+f2qcR; arc=fail smtp.client-ip=40.93.194.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eM+f2qcR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7FyHBHlMUJHZJMmPOh05V0sqMWDH+gcjxnQzrX2Y5KUJ+KRGdoKK6ExfVX/vhMLZflLqR1BIe85HRzul/xhemHuiobLBe7fo/JsmeEQM1gdJunLMnIsVYVUQq9zjtwLndLAzRiNqa5l8zjbRCrFcmR5VbinHruibZU7y/Fv37LpBFDriCvqjgrwOoWr3jW5p5ZDn97bvXhlicQlqhKvI5giJ81LPYPGAUVpf8Uty/EBbGJ/sHR6prSP07RU2PstT25ANMvpkAaIoAV2nBGpZXy/Mh80LL+s+6TI6jl0PxwiS+EqI7y/OMKZcJqY05GLdKw4wazYN8FEAIuCAQJVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGaDc6gK+/9z50iuAEOTy+men1BP3J7o+Cm3y5785aU=;
 b=IdfQi9Un6ESRxsZClhAOwLaM2aPogz/zED9JS9ZHPXKHRaEbSsiNmO6SN5izoxn34e62BQnsAhkGTt0I9BPAD7eY7i4J+NFHtUMiBr0xqfc/Tp4qtZg9LclN4IVcFwA88t4E0S+p+u7H3CYNvEKYGMMYsWAk2YORd4CNd3AHaop8fneYtdTWyvJZmL0KDuJ9VAmiDvE2djpSwELCXz55Ok+n2Md7FS0DIH5V/sE8No4fOjX/VYnd2ciYZZMup3xXt8QDpRAFKn5ES0JMHmuPwyOcdg5Ytx3foiOMJcVXomd8B5ODaVmdobcZ2ox3R97QjvZTW0r1eIYsQHBF4sYw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=garyguo.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGaDc6gK+/9z50iuAEOTy+men1BP3J7o+Cm3y5785aU=;
 b=eM+f2qcREXIUuihY3Dz/jmn2qNXaMyrqoOh5VGBdlP2oTzTln7KsjtSGeuwc7GZzhLENmDhoBEMcGmuAvLHFknPhyEZJq7/qm9Y0sjqD+DkB1whnm6g6ZvBhpBSjt0/VoNqcJZl/tpZetKu30RsLPv/xRGCViOKTHPuOpH6wb73Y5QGm8ApRNExLRbre99b/iGYEBjKygBJ0KtjXs6Bk/1yRjufmkj5hQKxJHB43fbbiJ60w99qP2uzEOY9rjJWOGas5NYzfLTECj13/VX91dvtTRln72C8zluQAAN6nLh7qiWVtuGkHHsrfDmeyDGxYXgk4zbAsa4uIi3b8KNd2/A==
Received: from SJ0PR13CA0054.namprd13.prod.outlook.com (2603:10b6:a03:2c2::29)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 18:53:48 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::1) by SJ0PR13CA0054.outlook.office365.com
 (2603:10b6:a03:2c2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 18:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 18:53:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 10:53:24 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 10:53:23 -0800
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 10:53:16 -0800
Date: Wed, 21 Jan 2026 20:53:15 +0200
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
	<daniel.almeida@collabora.com>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v11 1/5] rust: devres: style for imports
Message-ID: <20260121205315.60318486.zhiw@nvidia.com>
In-Reply-To: <DFUCQIIRNEZ5.178Y62YSLB9RC@garyguo.net>
References: <20260121142355.4761-1-zhiw@nvidia.com>
	<20260121142355.4761-2-zhiw@nvidia.com>
	<DFUCQIIRNEZ5.178Y62YSLB9RC@garyguo.net>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 4035c1de-0c84-4dc0-8ec0-08de591e6765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mST3LegT6/U/5Q1wB3vfhcoOXNixmG0HyBmiVp+/X9lArrJQXsLwzgAgKei3?=
 =?us-ascii?Q?J7t3UHuwc9U8j3Q3ncG1L6XXgKEBYngPzgByY/TVqTh49G480LF7fJ6mdNEv?=
 =?us-ascii?Q?0nhV9zv9iWi4bH8L5jvZ73qchhJ9eXAcUA2Cd3gEKr/HwH/95EUCWQzpm92/?=
 =?us-ascii?Q?QDJ0zTBXf3BnCEiUtffVrGgN9IbJ9QoA1dD5zLz4Z1NDk2hxboPDM0z/acTT?=
 =?us-ascii?Q?iPxPnXr8zj4VDkfxH5jeuZRvELZUqrwr7o1z/G5Rj5A8P9683/82hwx6hxXp?=
 =?us-ascii?Q?fBk44lSvFrzp4xMPHSmIH52gm4pXo6VeKYoXgNzlURMCXx9GKI18wC6OEwR9?=
 =?us-ascii?Q?O5z0pSP6QA8foook38sXc2oqbftd8GfAOLMmqtyZMB6DbSGyelxOOv7XwEUP?=
 =?us-ascii?Q?+FQD1c6K+pZNkOw0ODcEuY93T8m3lxs5+SSboBnWqF6bp4sTdxhA1XnEuLhW?=
 =?us-ascii?Q?NEbnQMUAVBGpAvsTD060CrakvUE7WWQGJ7ZLazPs/fnmxcIDJ8ozjCQhKHf7?=
 =?us-ascii?Q?gN0RZJYOvWCuTxrz/IqTAypQ3p7Bb0dQXOTYdLf3DjTrZtTtk5QJa7SdBmgQ?=
 =?us-ascii?Q?V/ckhwXdNe/G3rSSKSn7vr6xP5CxFevI6hpMUpAPsDleq02x51FbrDoEqVRI?=
 =?us-ascii?Q?0mW1K2+Dl0S4EmtI+dFpt1M/DUqViVBkjljxjoiv+HpVT5Zf2dg68FEgN+EB?=
 =?us-ascii?Q?FGXKeOhiGF/kZ2IJGpLKb4gFJ8RLrNLIYllRWLSiySB5QJKj4Fb248UE4ZVt?=
 =?us-ascii?Q?Em5UhzBBAI9RZO7j3l6qt9M3QVs9bCKKhmeHN3KEYul+W2HnZmkIaB/8yhqG?=
 =?us-ascii?Q?eeE6v9zXlRCohhgnHeIVLaGtmmZBHgGnUv2lcXTKBlAtpfp1waM4tbiKlPp8?=
 =?us-ascii?Q?DdtDFQhpWqnEBcZ/rpzo4R+2fBijZOKkXNVUvP+vW4JIMrPDpJtMToXpU5An?=
 =?us-ascii?Q?41VS0RHl4bxgO/V8qKksr419+kT1Dc76utxqaaMRUMQThC+nmubDTJHxs0GN?=
 =?us-ascii?Q?ijZYpQBz223zoWs/O4WRnxfsemA6OUe/yygbNB9oMlh/sOzkdiezZwGP5FtK?=
 =?us-ascii?Q?/NNqnzSLGzQVT6M2z6XZ+O/YZ1n2+U4kw5BuHbwy2Of0/jovxFkyfhCui90I?=
 =?us-ascii?Q?vnHMBo01d4gPK2ILFp4It0YCXLTWkG0RrXrhA1hMWwAYE4sqbFVk1zEyFiTL?=
 =?us-ascii?Q?CACRjI/lrhO6w7ujC3rXsY7LrSMCM97FhabfU/Mpa1A/FAGkwcbDsPTWVKT1?=
 =?us-ascii?Q?twYHu9q9mA8fSYWk8vzz8mKGno4HHEeVdSh7f6+8a/1Zrb0D7G6lyRPasKYm?=
 =?us-ascii?Q?ZScJh2WJ6DdOrTc8GW0fPoTeJ7jYe5oOWdsiRMk3PHFKPnjovQckSqmwtVO/?=
 =?us-ascii?Q?Egis7p3LJd2bsbiT+I84y9SuSjLPGyPVXdEjK4vbeZ5O1Y6cBubWwwJFEgnO?=
 =?us-ascii?Q?WgCdvZrrTOyX+9P0ah3mE+qFByxxGV7K6MBKPtX4Hcq/MJ93Jonlgwa8c+t6?=
 =?us-ascii?Q?fOtvumdjzTej/ZrwgsDpOZIdoaHSyDp8SfnBQmxtFQ5kMoYwVfQkMUIOgKt/?=
 =?us-ascii?Q?9tSk55dniztD32YmsQWXu0aK9WG8srN/wnGsaNfAJWfJu9bxDlPyoAp2af1f?=
 =?us-ascii?Q?8rcdvwJhLya5KjDIqZ9tORFEJQlcFhAmLsPdiEu3l+U0oviwcvCnoE/s7Lft?=
 =?us-ascii?Q?A9f4Aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 18:53:45.0413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4035c1de-0c84-4dc0-8ec0-08de591e6765
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521

On Wed, 21 Jan 2026 14:54:16 +0000
"Gary Guo" <gary@garyguo.net> wrote:

> On Wed Jan 21, 2026 at 2:23 PM GMT, Zhi Wang wrote:
> > Convert all imports in the devres to use "kernel vertical" style.
> >
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> 
> It does not look like this patch has been changed but yet you didn't
> pick up my R-b tag.
> 
> Also this is still using the wrong email address for Miguel without using
> the .mailmap.
> 

Oh, this piece must be missed during the rebasing. Will fix it in the next
re-spin.

> Best,
> Gary
> 
> > ---
> >  rust/kernel/devres.rs | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> > index db02f8b1788d..43089511bf76 100644
> > --- a/rust/kernel/devres.rs
> > +++ b/rust/kernel/devres.rs
> > @@ -254,8 +254,12 @@ pub fn device(&self) -> &Device {
> >      /// # Examples
> >      ///
> >      /// ```no_run
> > -    /// # #![cfg(CONFIG_PCI)]
> > -    /// # use kernel::{device::Core, devres::Devres, pci};
> > +    /// #![cfg(CONFIG_PCI)]
> > +    /// use kernel::{
> > +    ///     device::Core,
> > +    ///     devres::Devres,
> > +    ///     pci, //
> > +    /// };
> >      ///
> >      /// fn from_core(dev: &pci::Device<Core>, devres:
> > Devres<pci::Bar<0x4>>) -> Result { ///     let bar =
> > devres.access(dev.as_ref())?; @@ -358,7 +362,13 @@ fn
> > register_foreign<P>(dev: &Device<Bound>, data: P) -> Result /// #
> > Examples ///
> >  /// ```no_run
> > -/// use kernel::{device::{Bound, Device}, devres};
> > +/// use kernel::{
> > +///     device::{
> > +///         Bound,
> > +///         Device, //
> > +///     },
> > +///     devres, //
> > +/// };
> >  ///
> >  /// /// Registration of e.g. a class device, IRQ, etc.
> >  /// struct Registration;
> 

