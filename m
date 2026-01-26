Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400C329E47;
	Mon, 26 Jan 2026 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422899; cv=fail; b=hRbeoIOkWTbQ8l6oU2akZay+jsUZykkM+90opJ21L7jKSJlCnVhrjyHeBFlzMtklsgGJ4C4nwjOL8nMKFbVg4y2OulrgNOKBcrnnbslc2hlWTQf5pPIg2PIXeczvHGj4FOpdYPaxVj72JH1rmB0xreDQQr/Pftk0xD0tnBOW8W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422899; c=relaxed/simple;
	bh=uK3EqsA0srz9JkPcfPp2Bkhy7GG0vy3RiqdvSw76774=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L33/diw0SlhXJ+LHY3vAin3bn5HyDtVO6w3PAVUtb6u6w6l5w1Y6lZeqfskDNUCVbJhdirm7X/t/7RDoPoUf5jTmywV70BqREq2oA7ymT+oH2bsxnu1X0qPQ/e81Yg7DtPdyZWwMt6jHsSfHuWaF9j9WZJ+Y5LPgVHohHUD2ZfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JFwgYxw5; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JFwgYxw5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi8YnyVhRzBTamrJJvNbZ9wTTMzJjl/pljyXLxg0tSsEpDcndFCTHAfgDoLglLz/grtA6w7U58Is6aWcjhFfyTqOxwfVR27N0CEbjdZe/KtkQWNks45HqgoPS7Ig+l/E7M/eg/i2CZOpYRhB0//3TMFs7k3MkfZABS3KFhTfYOWB1JOqfEgBs312q0+oXMta+0r5kq01VhVStjKf0qdZGek1yPg/mbPXo2XZtOPTS/BAwrC1A6E/Li/rgVsjVjLxjJ/SvZokZtMvTs0sweAobGUU51y0vqJMAZVGB3L+LJs8vOF8hdTbkvAzFtAroyAwq/uyzbOTAa6VTlUCDGnekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnu/XjRypbAkbdM5rFqx76cK98W9oxUSZ2+ofj2Eruc=;
 b=Pn1+kwPTb1J9Wn6mrngKzKyQ8oE3MV0gzxCLgsGgzDffwQd3yL04p/jjx1YxPLo1Lra8wKFPRPXCG0KZDqqwu3cd20rq2HmaH6VArtg+dJ5ck723Z7ebOjMXcpTsi6ip8TfvadnvAPYLVifxBC6byk57rBbyiQlTbocrBVUBpD1S0UcI2vUbEffO0LDJmHFJQSq9okfiElJhhGXTpiW2Ye2NcG4Cz9TKsZCLmX0Y5MoafGdlgyFdN45oJ49FnUT5J45BIQEhLyVyDmCVrvWtjHZLTKlNFoD7hWLhRx0WxyKB2UupOA4Sqw2aG8APO3SVGBD3jZ+HEmUTGz5QjrWZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnu/XjRypbAkbdM5rFqx76cK98W9oxUSZ2+ofj2Eruc=;
 b=JFwgYxw5OWWvmhQnfOW57vGnbS06rtrTxQb437yc+Pv+XzLXI+Esmetct7URcRBoC5LttBQkxk4aI3COmdxHQEdIPBCikpirR7yS3sevBRhZebEBQWKRAAzK+EsdsWvDmB+QrkX2wAoUm6p98ErM4iIiT96LM7+Fsnuz51w/9/kIBGce48sAFDByosJcP8vq6FtMM8aFtegS+bbwq+OK120604/9z+hUECHUTvUMgmHUGiLUozW30a5/yo7GuHSLukm9L1tAvizrCOvr6woWtF0NZ6t4hNDdlIi1tPRvnx0xuD6Ic+hBFOTa54aCXW0yX0MZkRO4CR18ldLiVNtHew==
Received: from SJ0PR13CA0045.namprd13.prod.outlook.com (2603:10b6:a03:2c2::20)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:21:32 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::25) by SJ0PR13CA0045.outlook.office365.com
 (2603:10b6:a03:2c2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 10:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:21:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:21:22 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:21:21 -0800
Received: from inno-thin-client (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 26
 Jan 2026 02:21:14 -0800
Date: Mon, 26 Jan 2026 12:21:13 +0200
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
Message-ID: <20260126122021.1c617ea2.zhiw@nvidia.com>
In-Reply-To: <20260126090531.6ef5986e@inno-ryzen>
References: <20260121202212.4438-1-zhiw@nvidia.com>
	<20260121202212.4438-6-zhiw@nvidia.com>
	<DFUU4ABJQ3PW.15VQSR9ZOSG9F@nvidia.com>
	<DFY9EQP9PKG2.N71XAPSK2MKK@nvidia.com>
	<20260126090531.6ef5986e@inno-ryzen>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 626a3685-a72c-4695-39e0-08de5cc4acf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+VVSGQLT7XUJ7cB1TZ1Ql9VdYrxAV34TyJ5KsXkB4r/0UcDKoqBQeRv+BrSO?=
 =?us-ascii?Q?XM/9BeSQZkIOkwBYm4qpNyrEPeCCJfCRFwDV48ZaDfrC36H1tXIpP+hX/D8z?=
 =?us-ascii?Q?rjMHTWGZYhJ0RDCoAV6J13W76lO49ck8qEqGm3wwPUGqI0XZtjtmyirVjh3z?=
 =?us-ascii?Q?MY2S7MZwsj1dCdYE3RIgZGpGMmB0+ExlqNbXHkqXoVyG9bT+S1c+bbHfu7Xd?=
 =?us-ascii?Q?ndDn8W9+PHrKJVceRO3yoROKiBBjtXD37g6FSfcX3yR9Tpbt0b690ZGeIcYj?=
 =?us-ascii?Q?fuqf2xbXvMXwGyXhNhht/zhb3YIP17HV/H4jo9BGILz0LyI9fVarYeFJ5JJM?=
 =?us-ascii?Q?9nTnEtXtBT2MeDKx2zaAW8LexS4aDSfO3jz8rf0aLrorQs4IN4aUcopY3DOP?=
 =?us-ascii?Q?JUZ4HhyDJ+vRJ0MjSbCTWlH7giFVk3kHf5QwFmF1zOziOo+2QN4Bndll44Xw?=
 =?us-ascii?Q?7hN58ShSX/p+0MsGwYCYuzXJdLygJG8ObywnMGD4+91EAYKlcUnr/ARV8b9n?=
 =?us-ascii?Q?GzqeU/mtD/uPFue28K7m9fDn8XiEMSZh/aCLB+JjxNbGoLrjSb/M6CBLHtIO?=
 =?us-ascii?Q?cwD0EXIXmcX6BLXzXdDatNt7TGmrNrBBfYFJl1X91YdQdDdnNSvwM5m5goLf?=
 =?us-ascii?Q?NSUK7JPQK3bmKdivB3l/vFt/7GRRoIPq75Mv8hCuY47l22osSWs7/qySWtj4?=
 =?us-ascii?Q?Bo02fW6GosjSjdazJaAgtAPA/1CBqDo7t12MOPm+3x+6r9oUOyPAn1cjnlgO?=
 =?us-ascii?Q?NVFzRXOwce5uUz9KxS4TSxtmoxvqXFW68yM4U2TQIeNMphGEuJ04jEwVNQSs?=
 =?us-ascii?Q?rDiA43yFVbnMm+Rf0S0t2A3BQrP5+KELo6oo65kwXzBtANdsPqZ0W6VFv0Uu?=
 =?us-ascii?Q?/BF/+j3X4wmWHCfnoZCc5KQ0QTwk1OhQ0RLj7Re0ydFfP/8sTW4bIX3sHqK5?=
 =?us-ascii?Q?Qr3dw3Iq53aR4SFVMC/C0dPSShvJ2NAGmTYN/ZOzNxwIxaR1a+bNJyHZE3NK?=
 =?us-ascii?Q?2n5A5Qrf9Y2xYt7G6JLVIphtTIJPjknSz5lGGawInCnzuftcUz1JY8Kjae8E?=
 =?us-ascii?Q?pBw5IfhezGEOvV0JOmxZB8ob/pTj2lBfQkezVUb2Pnntt7EEnG6meTPCGwMI?=
 =?us-ascii?Q?2yxhWvh7v4DWn56YnBIIZcRQDLDdL+J6T7zXUDfA0J0NhUp542yBMMPjf4YM?=
 =?us-ascii?Q?ZdusdS9SmCRZUL3bD/BLmW6FuNKe9tfkrHG3zOWOcrz4dP5djnRaiWpM5cpm?=
 =?us-ascii?Q?+xI/XCOg8UpVFYKclZT86IY49zuJFKD7C90J2EuidBKesxB+oOTG4Y80htvF?=
 =?us-ascii?Q?QkTmEHc8MZfnIPaI+bN4PI6nHthirKwgDuJmEbqcEY8eFbS5qUL/rPsjrDGv?=
 =?us-ascii?Q?IN8Rsfc5HB6K9eBbXVuTltQ7vtHSpcHQ+By0llVMHD8OcB7tylclgvwCNWjM?=
 =?us-ascii?Q?Sz00aMYcNqYVmXLP0/oWCALaBcMwPSrJRus2lCGLeACYYJHNZuIkMJzDGHEl?=
 =?us-ascii?Q?xAFxIGcAdsyCyno7CWq52KhITAtT81sC8n+I8nsgMdDVrbL1yDcln7mT56zc?=
 =?us-ascii?Q?F9XzglmQApl6j6xSMS8E+fir3p9QlYGW2rhWQgytgC704QiOomLKraxDqUfi?=
 =?us-ascii?Q?hgJO7vE2kmlY2FTYugaq0UB0UgcxFQvCpz8ar53x/wHk8cuLcCMaGM7ZH4i8?=
 =?us-ascii?Q?pfE4MQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:21:31.8067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 626a3685-a72c-4695-39e0-08de5cc4acf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641

On Mon, 26 Jan 2026 09:05:31 +0000
Zhi Wang <zhiw@nvidia.com> wrote:

> On Mon, 26 Jan 2026 14:08:30 +0900
> "Alexandre Courbot" <acourbot@nvidia.com> wrote:
> 
> > On Thu Jan 22, 2026 at 1:31 PM JST, Alexandre Courbot wrote:
> > > On Thu Jan 22, 2026 at 5:22 AM JST, Zhi Wang wrote:
> > >> Add tests exercising the PCI configuration space helpers.
> > >>
> > >> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> > >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > >> ---
> > >>  samples/rust/rust_driver_pci.rs | 28 ++++++++++++++++++++++++++++
> > >>  1 file changed, 28 insertions(+)
> > >>
> > >> diff --git a/samples/rust/rust_driver_pci.rs
> > >> b/samples/rust/rust_driver_pci.rs index 38c949efce38..1bc5bd1a8df5
> > >> 100644 --- a/samples/rust/rust_driver_pci.rs
> > >> +++ b/samples/rust/rust_driver_pci.rs
> > >> @@ -5,6 +5,7 @@
> > >>  //! To make this driver probe, QEMU must be run with `-device
> > >> pci-testdev`. 
> > >>  use kernel::{
> > >> +    device::Bound,
> > >>      device::Core,
> > >>      devres::Devres,
> > >>      io::Io,
> > >> @@ -65,6 +66,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) ->
> > >> Result<u32> { 
> > >>          Ok(bar.read32(Regs::COUNT))
> > >>      }
> > >> +
> > >> +    fn config_space(pdev: &pci::Device<Bound>) -> Result {
> > >> +        let config = pdev.config_space()?;
> > >> +
> > >> +        // TODO: use the register!() macro for defining PCI
> > >> configuration space registers once it
> > >
> > > I'll rebase the `register!` series on top of this and try to address
> > > this item.
> > 
> > Actually... is this expected to work?
> > 
> > > +        dev_info!(
> > > +            pdev.as_ref(),
> > > +            "pci-testdev config space read8 rev ID: {:x}\n",
> > > +            config.read8(0x8)
> > > +        );
> > 
> > We are performing I/O on `config`, but since this is a sample device
> > with no hardware backing, what is providing the data for the
> > registers?
> > 
> 
> We are running the sample driver in the virtual machine. QEMU provides
> a emulated PCI test device (-device pci-testdev) for this purpose. E.g.
> with the following command line, I am able to run and test this in the
> virtual machine.
> 
> qemu-system-x86_64 \
>         -enable-kvm \
>         -cpu host \
>         -m 8192 \
>         -smp 24 \
>         -drive file=/home/inno/vm/xubuntu.img,if=virtio \
>         -netdev user,id=net0 \
>         -device virtio-net-pci,netdev=net0 \
>         -device usb-tablet \
>         -device pci-testdev \
>         -usb

The dmesg in the VM:

[    2.762517] rust_driver_pci 0000:00:04.0: pci-testdev data-match count:1 
[    2.764368] rust_driver_pci 0000:00:04.0: pci-testdev config space
read8 rev ID: 0 
[    2.766478] rust_driver_pci 0000:00:04.0: pci-testdev
config space read16 vendor ID: 1b36
[    2.770523] rust_driver_pci
0000:00:04.0: pci-testdev config space read32 BAR 0: febd2000

Z.
