Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECDD303A05;
	Mon, 26 Jan 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418368; cv=fail; b=mfAd7n91U7avNVQMlMpwho5JQuoDrjQucdpO4H+6Ofb2NhR5eSyVS/f6k+nk8W+Cjq807gwFe1jau0FoDFk0bT90xgcAYxQVo08j8syyIocQSrkiqX9OvAZFFHgCH/bBZCEBmxFEcyshf0JJV7lEoVz4N/TayFmqXCrMxdsDg6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418368; c=relaxed/simple;
	bh=qgvc1kyGGxRQbOEx/vNv/7x/LLSoQQbhWRwteyLTfoc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OquMOOsdLQ8Tw9hyAVPgoepaf7n+Ue3xWxfSN42Hv3xx2We3e70I8E0B8rFEnL116qtUColPOTDvXlfTSdzric3RdKmRUAxR9lrvOd6RbEqdaWwyzdu6u/9lhWE/8txSBd5a6W6DsBx7NleQWx9dGY3psj/bgfqL/lJppe6Fgxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hDoxfEqI; arc=fail smtp.client-ip=52.101.48.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hDoxfEqI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXrSAnpmCe4ULm6xgqFShe2D9NVFDeeYQ/ih1yH6vFMiZV31p4/iAofwZ7h4982sbvrbFp5qMvDtTygNirML5cIbABgTjcRQsguEG8MnVQnfDcPR/MmUYe/CqritR8fDUUMAL2cTqAhmcjNIsiyGelCyIhRbwdrT7aaujtYtyzYYW4A9Jbv1zJ1wuvXG6lr1mAN9r1EnIvth4+eLvo41UAyFivDAKWOisuP1f3oMGUQKvVowdn6LA/WmkYRTgwPngxnACpqP0vHlTK2TwL3Rc8xqfhqsHUqOQZjmThC81HLJ4mufo3w+JYv8v9yREg5EpuF57wgtNQwdbCdNSlmcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKFuIWBI5ke0BRWZABXLTq17KuaspN+pjQVE9e5ltOo=;
 b=Rkdvh1dfv9dFmCtSEbP5TXPy8O9rChJbKXr7OAZPPf6C25FQMxzBOv1b3RfJtdBI1mQxxdXvQaXkeBbxpVK09M5f9nUOWYj8cOSe9Symh42ed8GWvsCa8jrK6qXiGNb0+IW09ODijuHXJwxAUudyf0bN+nnPuZDEdwXn/r7a9krN672tJqV7nS5kY43Bxrz1Cz0yVsgI2Jhhg11W4LLc6HQ94cc9Lck3g0QzdBgJC8275UnsfCuLZGEVklnsywkglfQhYxMpcyyNEec/2K7+UoibSMq7wREu9ejnRJvWW4Xf+IWDaZGu7/XAqDjDpGHZYF/fn0kE5qU0FUlu9yLsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKFuIWBI5ke0BRWZABXLTq17KuaspN+pjQVE9e5ltOo=;
 b=hDoxfEqIIUF+fc74LTSbKogFTiPFTo1YGKPDiAz8Gu6uUCfdV+pXbjdPYVAsBfS9QijzTz6f+8Xh+7sV5bQnN/5flV0epM0corSIMuQ4RPo4NNRhwd7K3E1mJ0o1y6whBli8faIW7sELETwm0Ogh7zLdaAh5GDu8LwkgimfOpr8LBKpNFdGamWAzCdYVNPD++EbxAq+PZ6SJc5TA7S/tpOAZqIbiugjpzdQx7XT1r4sGZ/lOT2sTlo+pKlCJhdx7f6DJOh4/6MNbe1hYxjbZejAmNdJolBAsyA0webraDVUP7Hz7p5AevLasy5PnP5M5sXMWpqQynk8D4ujw5ghSBw==
Received: from BN9PR03CA0554.namprd03.prod.outlook.com (2603:10b6:408:138::19)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Mon, 26 Jan
 2026 09:05:59 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:138:cafe::ad) by BN9PR03CA0554.outlook.office365.com
 (2603:10b6:408:138::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 09:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 09:05:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 01:05:40 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 01:05:39 -0800
Received: from inno-ryzen (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 26 Jan
 2026 01:05:32 -0800
Date: Mon, 26 Jan 2026 09:05:31 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 5/5] sample: rust: pci: add tests for config space
 routines
Message-ID: <20260126090531.6ef5986e@inno-ryzen>
In-Reply-To: <DFY9EQP9PKG2.N71XAPSK2MKK@nvidia.com>
References: <20260121202212.4438-1-zhiw@nvidia.com>
	<20260121202212.4438-6-zhiw@nvidia.com>
	<DFUU4ABJQ3PW.15VQSR9ZOSG9F@nvidia.com>
	<DFY9EQP9PKG2.N71XAPSK2MKK@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 26136464-8e63-454c-000e-08de5cba1f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pi9XwkpTVPbogjj0y/KvTFhlk9GPyvxG42eaq68KZEbd7Pf56peENqlmIo4v?=
 =?us-ascii?Q?cf0pfJsIJCmOObzhZzgVfbYrqr6B7lSKJiWNVfpMBfBLEEx/DcNshx5chgqN?=
 =?us-ascii?Q?nHUci5KElD3sjUpmLgK5WB3M41GEo0dMn4jE773IoAVutNPyoV1mcbWnTCPn?=
 =?us-ascii?Q?035SOHrbdCIKjcG4UN8D2EbTQBvdgh+udk26An6R1Hm0f0Xm9JaF3lKzb2Rj?=
 =?us-ascii?Q?DKFCZALRuQfAtkPdqeDNDdT0r6kZ/ReOvVQMYuYuMVYreS8t3nhdlaV2XeKV?=
 =?us-ascii?Q?PuU8cO8VtGk/ZEAUXa/FXdBr++x43DbJ8AIMEgX0eerMFt4ElHCTcfoPIZHW?=
 =?us-ascii?Q?JoRETTBCw2P3UC9Va50PTGuUmUxUno3KKJjYKKEV/v5z7Dqedtx2RaJmpA1D?=
 =?us-ascii?Q?3Ot/h94rWEJA7tpUuRZcEdqIWI7iXMD5F0ekshaoTJqdKUIuKcfkRnKMTAcY?=
 =?us-ascii?Q?i17ZiWngNCi2awNd/uecU7gThd4pmnnxzlha2byYkfi7z/Htgx8R/p+F5qJ9?=
 =?us-ascii?Q?lf4Knys4WkFyNUL4EOGVaGK+6inzZqsQit0DnyY9SGu258V9GyMeKH8e92Zl?=
 =?us-ascii?Q?9uCD2SAb0/RvvJTMwl3KgxSLJ+vSbV86eHK118tFme3seyastzSzxpfKM4hl?=
 =?us-ascii?Q?J40hX3VY2vJzmeJg2KoTSbP8aj2l2BKDzekVOpOJCcvivadoH6cLFOiUHTRV?=
 =?us-ascii?Q?4j7Y9A4a9zpHThyDK0lMUN3Ex5hJOvgyEMNhpFKgTVwhx7u6aXn1YMR3Qyt0?=
 =?us-ascii?Q?9z7G5+wvaVTc5DR2X3J1dT5xLX/Wh4MN0DfrUr13Ram92hK5G8Qt/Fr1l2zU?=
 =?us-ascii?Q?FDsdGQOPij/F4VHd4JyShGL1Rnlq2kPGnpvexrLul71v/lmlLyGWiaiwgKCp?=
 =?us-ascii?Q?VXOkcJ/3WJeGt3D6YPyyQg/Na88wIa9eI9gEF+g4bAupQhg0HaOY7sHR06ks?=
 =?us-ascii?Q?Q8CIGBdgBohn8KRXaSKrbhVwsJPCaXhXQlFKliNu9CHyjsRJCFzwXsDf/snW?=
 =?us-ascii?Q?4ljWdRmAeVLsx3h45KbXcf1X3XMyuYdKNQH/viOroo+uOIt6DwgoRo1WkMzF?=
 =?us-ascii?Q?cBcQAbaT7CHRybpA1n7/xQDyrXx2Tdb23Fbbo3w5VkqVlkvOVjp22Hq5kmOn?=
 =?us-ascii?Q?vORTrbyHGCIwOB4haDX2xElhtfUYj5+Dr+h+Vj8LojnMwHLEPIO4hAD2FdWr?=
 =?us-ascii?Q?lO6fgKui70w3F/yvQU2jERtatFignt7z/eh+LCLmPy6hoTmvhO81fKC28sBi?=
 =?us-ascii?Q?fRZdzioQDGguZqSf07XxYp1jqsxCI+CKkE7YToav/D3BWygEsZ4xeHuwGUfd?=
 =?us-ascii?Q?gMBparoOuAgnWqxKBsdYxFNlvpbCWRPuyN6HudQceJyTce8+8go7xfe1Kmop?=
 =?us-ascii?Q?D8gaeTuskSD7SouPZM4jzoxoC8Z0eRWPi8r8g+gOc92pgJpmN9Jq+d9wadyF?=
 =?us-ascii?Q?VIy08x7TVEAOO4M0FxBVLzb23n4Scw9JI3WrokWWl8LO1XDMM2PdSJwTXbFW?=
 =?us-ascii?Q?tOFidw0+IKBhHq9OgAcUM+BbmPVtihrwjKmcZia37MBic+2xr/2YeGw7+6te?=
 =?us-ascii?Q?fPIQVzd5/v0u1fVYjeT0KhiKmkuKO4FxjfHzga+3zjabGz9dy6+0SuI+Bwxt?=
 =?us-ascii?Q?TUrNpeTzkAnofmVsOUxQZb8eROwzTPeySRks73bESIdkVnvUBz3wT2md5V20?=
 =?us-ascii?Q?YE/t1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 09:05:58.8128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26136464-8e63-454c-000e-08de5cba1f2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774

On Mon, 26 Jan 2026 14:08:30 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

> On Thu Jan 22, 2026 at 1:31 PM JST, Alexandre Courbot wrote:
> > On Thu Jan 22, 2026 at 5:22 AM JST, Zhi Wang wrote:
> >> Add tests exercising the PCI configuration space helpers.
> >>
> >> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> >> ---
> >>  samples/rust/rust_driver_pci.rs | 28 ++++++++++++++++++++++++++++
> >>  1 file changed, 28 insertions(+)
> >>
> >> diff --git a/samples/rust/rust_driver_pci.rs
> >> b/samples/rust/rust_driver_pci.rs index 38c949efce38..1bc5bd1a8df5
> >> 100644 --- a/samples/rust/rust_driver_pci.rs
> >> +++ b/samples/rust/rust_driver_pci.rs
> >> @@ -5,6 +5,7 @@
> >>  //! To make this driver probe, QEMU must be run with `-device
> >> pci-testdev`. 
> >>  use kernel::{
> >> +    device::Bound,
> >>      device::Core,
> >>      devres::Devres,
> >>      io::Io,
> >> @@ -65,6 +66,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) ->
> >> Result<u32> { 
> >>          Ok(bar.read32(Regs::COUNT))
> >>      }
> >> +
> >> +    fn config_space(pdev: &pci::Device<Bound>) -> Result {
> >> +        let config = pdev.config_space()?;
> >> +
> >> +        // TODO: use the register!() macro for defining PCI
> >> configuration space registers once it
> >
> > I'll rebase the `register!` series on top of this and try to address
> > this item.
> 
> Actually... is this expected to work?
> 
> > +        dev_info!(
> > +            pdev.as_ref(),
> > +            "pci-testdev config space read8 rev ID: {:x}\n",
> > +            config.read8(0x8)
> > +        );
> 
> We are performing I/O on `config`, but since this is a sample device
> with no hardware backing, what is providing the data for the
> registers?
> 

We are running the sample driver in the virtual machine. QEMU provides
a emulated PCI test device (-device pci-testdev) for this purpose. E.g.
with the following command line, I am able to run and test this in the
virtual machine.

qemu-system-x86_64 \
        -enable-kvm \
        -cpu host \
        -m 8192 \
        -smp 24 \
        -drive file=/home/inno/vm/xubuntu.img,if=virtio \
        -netdev user,id=net0 \
        -device virtio-net-pci,netdev=net0 \
        -device usb-tablet \
        -device pci-testdev \
        -usb
