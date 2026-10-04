Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010052.outbound.protection.outlook.com [52.101.193.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C03F58D6;
	Sun,  4 Oct 2026 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094947; cv=fail; b=rXQEgstzEpPjq4SJixXWHK1a5kz8xtF1yukUYEszjZTfxqgIjBL4fj1WYQREz+0OT79yxkHofIGorO7a1bSySps6ukIC5YPVoARnUW/LJB/6+Bq4QmgtPBDP7SJv9vNpEyR8PyXtPMUANVT88GTgMX7UU1w6NYtN9CqQPfczU7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094947; c=relaxed/simple;
	bh=UR90DD6XaURhNeRCCPHIpnUlIF1MqqITytBxtjiPStg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hfmf+gTkjB30iaWg+xQLZYw3pjIGqNXCcFWxN9iu5W75zQSPreoEUUgF2DtAz1EfArRODRP/0+7ATZYe4m9+bNV60chAruBKTWjg7sBMvioEHQlG1vEbzxKLMx0WNkdf7K9y4vLaJRCt+WHXVYooptvJIk9aXaWnUygIr9vya+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EM5tPhAs; arc=fail smtp.client-ip=52.101.193.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EM5tPhAs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCJFp78zC9+BI8RYM/pqGo/x+c0ycP7XOiimPBtH3Yh9xnubdMz4HaqsYA2aZ1TRHDCsrLXOsjEr60HqBv+JTMaAUBxEueKFs23FUPdZA9WgMdg8o+AlmwwOMAu9eAUDxaO68YS/6Ekco3rVopJxoKEjGncg52f1SneSoHfZu2sJSmyV0D9IbSe/lkEg7w2tXSXc1bC//qnHHXEXneOchi8+VfHSa3r+yIh2E9KJegJXjj2svoIMz1WRGEkfu0/6ipoz/PPLUh4KmzB2bGqmsbD68wSQdYf93ukFRZLIQV50ESzL6f3r0fQ6pdp74ZsnW56sKI4a7axonXKnx/pfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3Fmc8IPPfwHLKYByDD1863ZwO/REPrBet3Da6C5/9Q=;
 b=nSG7fJbWcDr8M+Hb/H1MHQOoTtcLqX618HCyY9S9Rv5O+Gjw8M5GzLXXNGtHKr8oFgM9ay7eZQPJWakTg3p9q+Mn3l+j3I1+ZPKoIYABm3XwkMDKwGbPyxMDRTUtEw66OZU5vFQKl7ALbWR2biMAbuRzWgkE4EnMpRRY4VhN1uSWdNE5DfluXScHcjvnKtHwP53pcQVjKaurqj2E35lxkzsShhGS+p59mlTmpZjH/S7pxEAyIgBGsYGNKiikeYUBFoWLYvSM8UG2gpx1JT6g5xcXwD7XXuwJEOy8sQWOCX//bYRZq8OHjh1yWD/FSN3Vm7WpU5UrQAAev3Y+dtahaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3Fmc8IPPfwHLKYByDD1863ZwO/REPrBet3Da6C5/9Q=;
 b=EM5tPhAsYjQL3KVZr2hrWfmXuv2edW+yBVrQtE4biCxp2J4IKkhKqBrzjEqOg5EuDYgxNVZSuauA+BpwRiFKYz+W0UCfNdxCpHuTDxGNaHYfoo3ZQ7MzQGQTQ+z1EaaU30vcg4bidTrJCbBlfw2CT0YKy3RkBDj5C/f1EAm8zaphdPI67V21Aeb6JZfzGu5QYE6gLZhgENsqGEShGYDReOOsqMlSMOiubPddnQZ6IpohCKp2RanwoP09kdX9fXRPJGkD0x/fPN6nezCQ6tt3bxQdhHo2p+KsobjYh7qsH+uTrwigEQzCqDi4QsYJARca1XzBPljjwyPCBUHZya3DKw==
Received: from BN1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:408:e2::27)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 06:22:13 +0000
Received: from BN3PEPF00022BC3.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::3a) by BN1PR13CA0022.outlook.office365.com
 (2603:10b6:408:e2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Sun, 4
 Oct 2026 06:22:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BC3.mail.protection.outlook.com (10.167.248.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 06:22:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 3 Oct
 2026 23:22:00 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 3 Oct
 2026 23:22:00 -0700
Received: from inno-x280 (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sat, 3 Oct 2026 23:21:53 -0700
Date: Sun, 4 Oct 2026 08:21:50 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
	<acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<jgg@nvidia.com>, <alex@shazbot.org>, Peter Colberg <peter@colberg.org>
Subject: Re: [PATCH v3 10/10] samples: rust: add Rust SR-IOV VF driver
 sample
Message-ID: <20261004082150.74a3961b@inno-x280>
In-Reply-To: <DLSQZO7U8S8U.1DDL9MVEYS7ED@kernel.org>
References: <cover.1790705494.git.zhiw@nvidia.com>
	<a50d3eba8fca1ecf094da263a749fa012a512b7f.1790759932.git.zhiw@nvidia.com>
	<DLSQZO7U8S8U.1DDL9MVEYS7ED@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC3:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: f72968a6-9a25-48e4-39db-08df21dfd442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|36860700016|1800799024|6133799003|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	HxOvT0JXOvcZQlpZHWKSBo0Q86e1LuqVHqhXVAf+p3YluCpHJX9mdEY01TTbZHGkWJRTthPZ3spILd1YKb3JfZrXJUi4Jmvs1CMgeCOCDomjuTeZSHpGl3qaMuJaAgv+o7Zob9zWVK7PTuNshFQLL+n5PQucP2D6rOHMh8jQW0e8fZYPw1h/sPj8iaIQ29C4F38YFCisU0hKAocWf3ld+YgjUmlZNUJEvq6GqJ4G8nWfGuS6J67h5Hbc5Gb0rn4miXWSNzI91ayRVYhP2KUFPpAISMBb57Jz0JQiT5jGiIDf+4A4wor7szq6RzoIIv4BIZv3qaH+uOas6FGdgN9ac7bGK/1jUXNd0AwYZwFoTBc06lncCFtiMIQjKvRUevg4fUNLS+Vx7TWB3m1IKVwEVfbTscef4TEhjGaLSXa1tdFvtnH6lun+LYye6sTdqNJocIZT5371EdnpL+y6M7yosaqhX6cVFfAZXr452aPJOUDY4Zi0WLEEFd8aqkq0WznDaisHoR9LZH5CM+3FEqxMo1E91ZJlg0DuM2YJFpisQe3sfQDltYiPlgiDr7zYv21qJnQUJ2cvtEvjK6+KYX4b4KzaEdOWXOQt6z5aI0XWm0UaRT2iK4RS8wG6zapLKK8ME5DQBfA6tL3YLZYXRCqEef5yyEt+tqll3zv0T2EgaCFmVW1OccfYlUwTK+rLaRtVn0qAUKs/oD35Ua9gnG51tg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/1og9BD+H0wB00FA465TCU9Pwgq93Buzu8OGwUndel2neGG6l/SHSkZ9oAOJd7G1EBzrbjHIArEXJpIbP0OVrVT3iOirVct1fScC02kB2YXraSFJx/cHIyW2w+UEeSbH+Lx3XRuucicvXu0iMut2jMKetZtMZEiHiCyaDIO3ln0OUT8CGSbfDoZvTj4GdYQL44pcjRdV7/soVjruRnqSju7yqwqLCDZ1I3YMJPY8lLAkcYMrCidRMpOl4zMef56oQjC2RWX9LNoWETp9lMRX2NOLRJX3qXShBjs65iWSP4Khx4EbXN46JYWVDUoyFOJIf5YKNS37CUfn6J1k5KIdu0QSblLKXdAAkiYYzwFaWIzvAXbVDZRlWEy3gqGLGVcAbljWXSdu8oFgF3qlyZFANqnpRDK1Q6lsfh9ixwgNYEcDzC4hm+UG+39MEdYfPh9z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 06:22:13.0630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f72968a6-9a25-48e4-39db-08df21dfd442
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159

On Wed, 30 Sep 2026 17:15:00 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Wed Sep 30, 2026 at 12:18 PM CEST, Zhi Wang wrote:

<snip>

> > +kernel::pci_device_table!(
> > +    VF_TABLE,
> > +    <SampleVfDriver as pci::Driver>::IdInfo,
> > +    [(
> > +        // E1000_DEV_ID_82576_VF
> > +        pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10ca),
> > +        ()
> > +    )]
> > +);
> 
> Since this is two drivers in the same module, can we please put
> everythng that belongs to the PF driver first and then everything
> that belongs into the VF driver second please? We could also make it
> two separate files.
> 

I think it is a great idea. I will split them in the next spin.

> > +#[vtable]
> > +impl pci::Driver for SamplePfDriver {
> > +    type IdInfo = ();
> > +    type Data<'bound> = PfDriverData<'bound>;
> > +
> > +    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PF_TABLE;
> > +
> > +    fn probe<'bound>(
> > +        pdev: &'bound pci::Device<Core<'_>>,
> > +        _info: Option<&'bound Self::IdInfo>,
> > +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> > +        pin_init::pin_init_scope(move || {
> > +            dev_info!(
> > +                pdev,
> > +                "Probe Rust SR-IOV PF sample (PCI ID: {},
> > 0x{:x}).\n",
> > +                pdev.vendor_id(),
> > +                pdev.device_id()
> > +            );
> > +
> > +            pdev.enable_device_mem()?;
> > +            pdev.set_master();
> > +
> > +            Ok(try_pin_init!(PfDriverData {
> > +                // SAFETY:
> > +                // - probe has exclusive access to this PF before
> > SR-IOV is enabled;
> > +                // - the registration is pinned in the PF driver
> > data and dropped before `pdev`;
> > +                // - no other registration is created for this PF;
> > and
> > +                // - VFs are enabled only after probe by
> > `sriov_enable`.
> > +                _registration <- unsafe {
> > +                    pci::VfRegistration::new(
> > +                        pdev,
> > +                        try_pin_init!(PfApi {
> > +                            pdev,
> > +                            requests <- new_mutex!(0),
> > +                        }),
> > +                    )
> > +                },
> > +                pdev: pdev.into(),
> > +            }))
> > +        })
> 
> Let's put everything within a single try_pin_init!() block please.
> 
> > +#[vtable]
> > +impl pci::Driver for SampleVfDriver {
> > +    type IdInfo = ();
> > +    type Data<'bound> = VfDriverData;
> > +
> > +    const ID_TABLE: pci::IdTable<Self::IdInfo> = &VF_TABLE;
> > +
> > +    fn probe<'bound>(
> > +        pdev: &'bound pci::Device<Core<'_>>,
> > +        _info: Option<&'bound Self::IdInfo>,
> > +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> > +        pin_init::pin_init_scope(move || {
> > +            dev_info!(
> > +                pdev,
> > +                "Probe Rust SR-IOV VF sample (PCI ID: {},
> > 0x{:x}).\n",
> > +                pdev.vendor_id(),
> > +                pdev.device_id()
> > +            );
> > +
> > +            let pdev_bound: &'bound pci::Device<Bound> = pdev;
> > +            let pf_api =
> > pdev_bound.vf_registration_data::<PfApiForLt>()?; +
> > +            pdev.enable_device_mem()?;
> > +            pdev.set_master();
> > +
> > +            let request = pf_api.submit(pdev)?;
> > +            dev_info!(pdev, "Submitted request {} through PF
> > data.\n", request); +
> > +            Ok(try_pin_init!(VfDriverData { pdev: pdev.into() }))
> > +        })
> 
> Same here. Also no need for pdev_bound, it derefs automatically, you
> can just call pdev.vf_registration_data().
> 
> > +    }
> > +}
> > +
> > +#[pinned_drop]
> > +impl PinnedDrop for PfDriverData<'_> {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        dev_info!(self.pdev, "Remove Rust SR-IOV PF sample.\n");
> > +    }
> > +}
> > +
> > +#[pinned_drop]
> > +impl PinnedDrop for VfDriverData {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        dev_info!(self.pdev, "Remove Rust SR-IOV VF sample.\n");
> > +    }
> > +}
> 
> Let's drop those, we don't really need them.
> 
> Here's the two probe() functions I came up with:
> 
>     fn probe<'bound>(
>         pdev: &'bound pci::Device<Core<'_>>,
>         _info: Option<&'bound Self::IdInfo>,
>     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>         try_pin_init!(PfDriverData {
>             _: {
>                 dev_info!(
>                     pdev,
>                     "Probe Rust SR-IOV PF sample (PCI ID: {},
> 0x{:x}).\n", pdev.vendor_id(),
>                     pdev.device_id()
>                 );
>             },
> 
>             _: {
>                 pdev.enable_device_mem()?;
>                 pdev.set_master();
>             },
> 
>             // SAFETY:
>             // - probe has exclusive access to this PF before SR-IOV
> is enabled; // - the registration is pinned in the PF driver data and
> dropped before `pdev`; // - no other registration is created for this
> PF; and // - VFs are enabled only after probe by `sriov_enable`.
>             _registration <- unsafe {
>                 pci::VfRegistration::new(
>                     pdev,
>                     try_pin_init!(PfApi {
>                         pdev,
>                         requests <- new_mutex!(0),
>                     }),
>                 )
>             },
> 
>             pdev,
>         })
>     }
> 
>     fn probe<'bound>(
>         pdev: &'bound pci::Device<Core<'_>>,
>         _info: Option<&'bound Self::IdInfo>,
>     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>         try_pin_init!(VfDriverData {
>             _: {
>                 dev_info!(
>                     pdev,
>                     "Probe Rust SR-IOV VF sample (PCI ID: {},
> 0x{:x}).\n", pdev.vendor_id(),
>                     pdev.device_id()
>                 );
>             },
> 
>             _: {
>                 pdev.enable_device_mem()?;
>                 pdev.set_master();
>             },
> 
>             pdev,
> 
>             _: {
>                 let pf_api =
> pdev.vf_registration_data::<PfApiForLt>()?;
> 
>                 let request = pf_api.submit(pdev)?;
>                 dev_info!(pdev, "Submitted request {} through PF
> data.\n", request); },
>         })
>     }
> 
> Note that enable_device() and set_master() have their own block as
> they will be replaced with a pci::DeviceEnableGuard soon.

