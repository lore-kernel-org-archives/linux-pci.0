Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3143DDDBC;
	Wed, 19 Aug 2026 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128646; cv=fail; b=QQLkMqdSitodFGttGyiOStWu02ppqf5rCIf9qG2CpJ8kL524vdH55upkTa0SsWxQrnq+3sTCM3bachGYmKJRJbrzi+SIE71Q3ZqngWUUUr0E/2RqHRVL0YU2X0H7nVGE4wOm22TJvLjmixDp8lRvIm5l5EwfMt2D04ACEyi3jx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128646; c=relaxed/simple;
	bh=eHvpqBi8eTiRljzni7U2+jU7mtRRsAWzTuqzV3nB5yg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fe7Z4VEC5k4qLUo2n0a2ake8KjAMsLfICvgRHrLml4wnS2TnmWIxNb6GYsBV0mMext79+8k5jRx/KjXxaJUbLOUpYO0/eI5xZmgrot/L9DLx/ZQ7Ho/LuWjoSv3FPaprZaI06FK/WSDycA+otuRq3OGXZR1IxHLWwnY/ePR1olo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uP9geIRP; arc=fail smtp.client-ip=52.101.48.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uP9geIRP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SonAbRzdh4iza1QOM3+dQOWjSbeXNZk7VySevYzzaVhEnX2Eh5rnA71qSm3K0ExIZaLHhqYIZ+IL4dhxDLyOQcgBrD6yeKzJN5lipuUEmV2tannHhR69SK15dsr5thCDHKR9QnTm/zS9YpNTXH48O1pcSSITDrsfrl3tjxtVlH8x6+nfWXTW7Ker6nsbyWaflXkJYZFUwQBmVTW2qqreNlz7Yqell4BXRkn4pWhaJg2ZQfXjKaE5cCbtk0AiVubh7wBScX+b65ago6N6zwi6GyatE82gC6ZSldCL02ahQAupR2RVnKJ8Wdcw0ZjgkLVU9wZhxppWlOaCMkPEgtWRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOEjQUrYYtmkCg0NG/T4kZor+5rVmv6gqzM424FPSaM=;
 b=afoF168Zd113Flbj4vBJJWw0XT6F/a6Uuvi3RKIm2QMOV2dsAWvmW/D6eoLWuw/PKBgz37I8YSKBmbMTol0n9ikEWP55l8mCc/fxkQfdDYituXk5rmq9OEFLlRWnrARAiXzSAd7DiGmd8LRR9vo74L7hbjSWaV+G84lQFx3JOkLzUN4/1kdhtIdn/GhbZs5zbu2hRxDA1IioPdkh2yiGM+KVRpCd/D/9hO7pscwkK1LM+Aw5USJCm0naJOvwmZ/zv+YQGoEVQAThvZHusUuI41BOSyF/M2QRqhqJtafxTtyR7vtBVtg5q8io/pWd0fuS7hLS1Isblhoq93HsNLggng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOEjQUrYYtmkCg0NG/T4kZor+5rVmv6gqzM424FPSaM=;
 b=uP9geIRP3eZD7qfeAbD+6WvJ8BOT9ODkDab22tAFemW3MBk9Afhk5/0QJnaYGNig56X3GJBCqHHdd/6ma3f4PteIHOsdtUzfHOaK+cWG7ZjweDL0rk2Q3n37SVBR/YeDpuBZDrEwdUSKH5xkYOh7As+YWzgsFnRL/LBlYlte5LxMw3IVVjY6xIJl2zfFdgPqh24yi+MGOmI2pBbzoFobKTkJeDQMYaqlkaIB+nnKOvuN/VFtbIp0qL2OlwN30NN7i7okBSF+hLQ+QZJqcqE5fkzBtx/2l5pJdlv7UUHI0U5RvGfv+jnGZwXFBqHX0RQ8HpS75P7aYiaIsU3CGr+XVQ==
Received: from BN9PR03CA0545.namprd03.prod.outlook.com (2603:10b6:408:138::10)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 08:37:20 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::64) by BN9PR03CA0545.outlook.office365.com
 (2603:10b6:408:138::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Wed,
 19 Aug 2026 08:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 08:37:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 19 Aug
 2026 01:37:07 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 19 Aug 2026 01:37:06 -0700
Received: from inno-dell (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Wed, 19 Aug 2026 01:37:00 -0700
Date: Wed, 19 Aug 2026 11:36:58 +0300
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
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>
Subject: Re: [PATCH v7 1/1] rust: pci: add extended capability and SR-IOV
 support
Message-ID: <20260819113658.4d096da5@inno-dell>
In-Reply-To: <DKNV9K3TXIU5.2F2Q4B3HHRHOZ@kernel.org>
References: <20260804161612.776752-1-zhiw@nvidia.com>
	<20260804161612.776752-2-zhiw@nvidia.com>
	<DKNV9K3TXIU5.2F2Q4B3HHRHOZ@kernel.org>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 41051835-3d66-4448-f67e-08defdcd15b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099006|6133799003|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	7J2LSJ7ntcW19oXYY/NN/NDVFICHt/eYOjgobK69rRXudAm+9fDP35eetsTv01dDJku8Pvi8JYPO3z9a1bGPcxvpp0SKYTg2/JluvV7zkciAoZD9SBq58PMOWAvAG1AiJmIM897Dgi/g1+tUQWhxLTPZj5ABC/yydGKyQ7po+5I7xVlWwhZ9bKJLCKnDNftCnJrzw2IdWhhib86VVYS/4deNrKKMWM0YTluWwvF2HfFPxGyqRCwW2O/ExR/J3nsJYPMAeP9RZaWzh3uaAj0FwefilH5L9pXDWOlc3EgJZRPKiPjiBI78U4p2a48ethrM/uVYaY6jyUD7b6bExkiWLf0DUVB5ulHMO7FXnLWwg719cPVjQ9u9J/x2w5iu/cSA+OUmrdAq67EEPCllZkFUdVt2hFpjJdEzc6n0XQqsSuXO8lGXyANh9PaF3YUONhJZMzmlo8JHlEVKRY5Tkc7OHfd3sNHCFQHUPydFH7wqTShI/pR8I0jsWW6XeWIqlhn8vk9GP8Yh8eeNINIKa/ttiMUAAhJiFvQse5UA/0cbpcbIIkT2yiNxHLO+o3TYRhPbk0ES2ELUc+9cxwi4J8Lr4BC6Bw89YY//DaTLlPETlS46zOau/Ekebbnv+8u9D9jzo9D2ObiwF5B/MG5WhZh8Fprw1KudwAHgzy5ZNfuh7vykIRb2B9LLXbcFdalcvDx636zdNwI3Awcx+5ay7EHfSQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/kFKkgT5ise8f1TuoGS8ezGY2NsNDauWFvP+N6iFykiSoJtYqN8sbozlczsFrPTPQGAkWians3qOQts0BkcGYXYsTqmi/hl+CzNFpwSAqiNDVuY4iVq083SL6BKtMj491uWeeJFkhnFIgtJfqFkOLb6fFZJFiZmKvmKVRoqoIKB/hcTMq6q2p7s7Vr/+HigNUNX2JX022ru9YT5qHjqX8u1fnxSG8pNjumC/2+qRe4URMnaQCqSd1ra1sbeskYnJEff4hxVfWP81hFobPT1pM0zW6HklBoLdIFAkeEKRZPg+lT9K2BgbMhIKv62o+YWfvYivVuZrvenexvk/5oB0nT0KIj88Hu1KnFZrS1tG/9UNkxi/hG2A4kZdN+f7bVKDlHK0IXgwINQgrIkqtS9kbqgIUQJJjIgJbfHzVMS2DTuFujcnbvZV8TgYcIQM4Cao
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 08:37:20.5416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41051835-3d66-4448-f67e-08defdcd15b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362

On Thu, 13 Aug 2026 15:56:41 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

Hi Danilo:

I have updated the v8 to address all the comments except the io
projection part. Regarding to Gary's new Io project patch, I would send
another re-spin after they are on drm-rust-next. Thanks for the review.

Z.


> On Tue Aug 4, 2026 at 6:16 PM CEST, Zhi Wang wrote:
> > +/// Number of VF BAR register slots in an SR-IOV capability.
> > +// CAST: `PCI_SRIOV_NUM_BARS` is 6, which fits in `usize`.
>=20
> I think the more relevant point is that it is a constant coming from
> the PCIe spec. (Plus, more SR-IOV BARs than addressable bytes
> wouldn't make a lot of sense anyway. :)
>=20
> > +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
> > +
> > +/// PCI extended capability IDs.
> > +#[repr(u16)]
> > +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> > +pub enum ExtCapId {
> > +    /// Single Root I/O Virtualization.
> > +    // CAST: `PCI_EXT_CAP_ID_SRIOV` is `0x10`, which fits in `u16`.
>=20
> Same here, I'd mention that it is a constant from the spec.
>=20
> > +    Sriov =3D bindings::PCI_EXT_CAP_ID_SRIOV as u16,
> > +}
>=20
> [...]
>=20
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
>=20
> Just Result; please also import kernel::device::Bound for readability.
>=20
> io_read!() should be imported from kernel::io::.
>=20
> > +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap
> > offset). +#[repr(C)]
> > +#[derive(FromBytes, IntoBytes)]
> > +pub struct ExtSriovRegs {
> > +    /// Extended capability header.
> > +    pub header: u32,
> > +    /// SR-IOV capabilities.
> > +    pub cap: u32,
> > +    /// SR-IOV control.
> > +    pub ctrl: u16,
> > +    /// SR-IOV status.
> > +    pub status: u16,
>=20
> This is not a raw value, but a bitfield and should be represented as
> such (might be true for some other fields as well).
>=20
> I think for this to work it needs Gary's recent I/O series though; I
> can merge both together next cycle and share with drm-rust.
>=20
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

