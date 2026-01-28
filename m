Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572B350A21;
	Wed, 28 Jan 2026 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621222; cv=fail; b=Fnz9qmZ0m2/TOWaze5e2Z+kcRwse0AFZGAWm2TLXCJARvwAhGDvnaD9VyV/1a2FeB3F7y0R0GNlYqEDmn+8cp6sK7KAjXekZUXeP+n/Zs3ms3/Cbx3iHHy7PXs5Wy118EaO3h1RAFm6DvioOxS6wW0yVWxKRaHFLk+pI3dC0jrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621222; c=relaxed/simple;
	bh=cJb71+5MTnLOfPGKrE3R3ojK7FHJ7Df8wPrGudEGV1o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3mC4QhhSO3FamSkjVB373ZcwT+W/lEiVBYrvwP0OB4jFdqpctRc6e4WjwkizRzdeoAPwhgfj4eOG8j2/XNJJJ92dA6qmYHtiaO54v/BV45ajQWg90SsLYZRXlvpfbJmm8C/ndlLcglfREYR3U/GK6WPaNqB5we4EQeH2vYvGkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AxvSTs+T; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AxvSTs+T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP8BZwIGBU8eilIfvvu0ikqfZYr2MG+NAAnXqOFE+qbIVM090FrhPOXAyuNjqKfSKjfydz0tWghy1DaWDzWfwjkXI3ViKpPWcAuy7Sgfxx+VdmJNPmfSUKD1ff3T3zVihDpfDIAv7WQ6P4EhZRqOvLz4Oh3sjJIeH8OKovVDRfx5846M3k4Y7QzmXH7/XBCg/Oz2sR/BErLt0sWEzxPBA73yFtK6S9OOZLnuL0po0wAWWOohrgwXg3/K3A/WlHLEnBj6RvcORK0uKX0X1jAOXEapcyTm5MqMgPvhvhXk7SOqP7m4ggv+nSoiFJnEnulDG3CEs413DSLlSltyVV6q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuTG8rshGe/+lzlOlchmQ4vAiEJxNbaFN9zAYaRRcpY=;
 b=Tppqf5qXwaaT7t+m3mzO6/gM4Um0e/et6YKmdZA8slkoVDAz3egULwrswdTxBm1rQTlqVppXbkKiNSCNBkhCjw80U2X9C9IKs0nUHDLkNK/YKD9f0TQ4Qxmj7Fnklqefgt5y9v1KnwlReMQyGeglDTGAqyoRzubabvHJ9UT3CJrM9sIXFOjOeknhmKN0s6T6wa2avr24l+8ohs0qQcmf8/rs1WwOx0BhhjfBu3pHXHM6umuU3h9krCVrllhX5GrvgCsSNiBKara0w6edegblQwEtllvM4jJRHyMYikvctDXMqbmJNMncp5GGDJwzoN0Z+arRWRR5C/peIciGosXoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuTG8rshGe/+lzlOlchmQ4vAiEJxNbaFN9zAYaRRcpY=;
 b=AxvSTs+TvdSN/qy5JCmPywMs13tv0haiR1+4c5dLe1Va+WSHaz+ac2CbmiBf50+lzsVPUo8cEkd8T1IfNdj1iDDU0yTna5UtjMFuYMrz0KkrsbXFldUSUmFr8+igyM4ubepLrbpQWV8ZpvQaxYO5fIHbnpFwE4jVw8NhPG5MugSHKTz/MkrqnJMoQTzPu/+QXnYT7CsOKT+WdS/hRYoDrI3jyS8c3zRrfk6iHXgcqTvmfizakrbSdCPRFjk9CgZi7xu1Uh4hpS/jT2/jG8GHqS07G0diqXpr+ciWQgzmmBmLMT2bONfrQ7W0yT6pSe1FsPlH+lTWJCqwMfoaiGlekw==
Received: from PH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:5::24)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 17:26:51 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::af) by PH0PR07CA0019.outlook.office365.com
 (2603:10b6:510:5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 17:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 17:26:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 09:26:24 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 09:26:23 -0800
Received: from inno-thin-client (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 09:26:15 -0800
Date: Wed, 28 Jan 2026 19:26:14 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Danilo Krummrich <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctlg
Message-ID: <20260128192614.6bce6eab.zhiw@nvidia.com>
In-Reply-To: <20260128163927.GD1134360@nvidia.com>
References: <20260127215744.332380fe.zhiw@nvidia.com>
	<DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
	<20260128000410.GT1134360@nvidia.com>
	<DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
	<20260128132029.GX1134360@nvidia.com>
	<DG09ZUY530SW.K62KDIT4LIXN@kernel.org>
	<20260128145906.GZ1134360@nvidia.com>
	<DG0CABK2DQE8.1TDN35GOJ0DYI@kernel.org>
	<20260128155646.GB1134360@nvidia.com>
	<DG0D9I9P5BO9.6Q9H2BQN5AWU@kernel.org>
	<20260128163927.GD1134360@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: 886735aa-28c4-4ca1-7409-08de5e926c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q0UmzLZCRWwzbiPQQUtL5pv6pj3szea4V/1nRJ6tZN8ZzoWZcu5rQNuajOUe?=
 =?us-ascii?Q?0TGhFpFoV+RiAkJUTek7HQ6yLT08neNQjDBoYL9UCYmpKEAchXFHE8FfmBq/?=
 =?us-ascii?Q?Ett0bp+MYwnGeVh494LfpIlCqKVnGDr1dVFJMxnoadi9xT3lJVU1l0+WIGUF?=
 =?us-ascii?Q?EETrWHni0lORR65BHV3wg4L3fxy4bydMmgsmpDJWQ4DR2p/RxzWymQBvZDGG?=
 =?us-ascii?Q?fBZJ2JtAAdfpdwJa0dMQayoN9cYk0pMl2uAXESQVoCyee+s1+svmFi7iIljI?=
 =?us-ascii?Q?pz5NxFL1Czu48SDSOtHP92zQeGCP/zhp653cU75lYOXDKMzeThNijmddWktc?=
 =?us-ascii?Q?s1yD/LxjIe+1Ac3i310hEUll4+by10sYl+4Y0tADtNaHG1/22R9RBxsvn6d2?=
 =?us-ascii?Q?07XZFuJ/fVSDOHy5O3f2teNRMFjHO41IUHROg5fzTDrbZpvL3eObuY3jJ/z4?=
 =?us-ascii?Q?gKok835/aa4s1rIvR9DqWe6cqDUM+5FuN6p0OoTVGWoD0IuQB3JXMpDPvFr5?=
 =?us-ascii?Q?vPxqiHCdZtMEYiMrWDt93vQSmxPKAjNYDkXtIDrgDEUfd8YVnwNTGhZ+pdMj?=
 =?us-ascii?Q?MoIa73j3yKw+63vBLUmS8xbBSGB2khcHkAbogzH8A5mjAgCrsk+u5+vEwWJr?=
 =?us-ascii?Q?JckKhvXGkYiCLzhHUhClcWJhYTaLeKCm5b8HXtk4xSJ2NEEheMCpKYCTZqp/?=
 =?us-ascii?Q?vcQ0j0XjKgarLkqSl2dQveDbdMudrabKt0/hEqbEqUyhNHCqbcyaC6LEJv4g?=
 =?us-ascii?Q?XeO2M2pE4dauqA1ttHFmN1w4tPocvR8IiItfFDwk5GtT5pqJj3CyyQrSIEdF?=
 =?us-ascii?Q?T6pTfwbNImLvg1+T1FeOMTn4yAjAZe5oyYpfFt9sgzwqpqjmj3QsSE5Fzo+g?=
 =?us-ascii?Q?RysbzBnFLx6Bk8X7Cr8kUpKAtTK0MCfkcR52/39MrAV0MUoAmSg09qihPnJh?=
 =?us-ascii?Q?Ei+nurQGNbGY0XlKg3WZIhor1HkP5fMNkFOw3B7i8Mckzr0bg8fQ0g8f82Xb?=
 =?us-ascii?Q?vpfQ5plIMwzgzUid+MaSj/x9bpYA8IvkFjHWARq37hyt1r9t+wG+wY6Wc7W9?=
 =?us-ascii?Q?mbonadO5Jn0RngQA4FJw5okVX95uFGEV0NFDw2u8V4/ZhaZnTgpCEL0UqARl?=
 =?us-ascii?Q?CcYtxGt/OX87jqsJCPQbZAzfnhriEjLdUHOTMrJac6AbC7Xou6KSpZEUYsxc?=
 =?us-ascii?Q?wwpk/0eUXwx55f7UGNsTbdmtw0mgj2Dqhnr71WKisy+tdXV+tufiBMHSR0Xy?=
 =?us-ascii?Q?gz5XTyBSxVIJNjuRf3GJH0K9mx7evnmv0FgqF9ojAMOZwNr8gEXapxtfngUd?=
 =?us-ascii?Q?dvJcYZdky6ih2YLu4xyP6OKhV5+Y3EKpcMsWeVCmwHdtk+CreP6go3q1gu52?=
 =?us-ascii?Q?Yg39I1O/0tP1dgyBA9Wm2LOcIpHjBYOCPJiS4hzoy8wtGU/awCfblXywg4a1?=
 =?us-ascii?Q?k9zyp7osTekfmmg4GmG4qQ9VJpB0Ml/YkwSh2dCBfr3KQesP6MS9D8XtQqoU?=
 =?us-ascii?Q?tKzjsMT9qxNFvcH/N8NMN9G7T0Ska8TvT/mkfPTEe7HLIqOYU2OQ0ksGAkvk?=
 =?us-ascii?Q?Z8mzr2nBEfwRCYCjtCRjI4oTSiYFqysUl1YFKsErrCb3XE473cd6M7WtSiiQ?=
 =?us-ascii?Q?WNTYqUOFQsgeJNGWUows4Ybh8m3KOY//vk/AbvGfKy5NfdzSVUCmV1IxlAPG?=
 =?us-ascii?Q?TTzMxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 17:26:50.9162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 886735aa-28c4-4ca1-7409-08de5e926c69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644

On Wed, 28 Jan 2026 12:39:27 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jan 28, 2026 at 05:35:04PM +0100, Danilo Krummrich wrote:
> > On Wed Jan 28, 2026 at 4:56 PM CET, Jason Gunthorpe wrote:
> > > On Wed, Jan 28, 2026 at 04:49:07PM +0100, Danilo Krummrich wrote:
> > >
> > >> 	        // Initialize the `data` initializer within the
> > >> memory pointed // to by `raw_data`.
> > >> 	        unsafe { data.__pinned_init(raw_data)
> > >> }.inspect_err(|_| {
> > >
> > >> So, essentially the driver passes an initializer of its private
> > >> data and we "write" this initializer into the extra memory
> > >> allocated with _fwctl_alloc_device().
> > >
> > > This all seems like the right way to do it!
> > >
> > > My only remark it that it still doesn't give an opportunity to call a
> > > function between init and register.
> > 
> > You would, from a driver side it would look like this:
> > 
> > 	#[pin_data]
> > 	struct MyDriver {
> > 	    #[pin]
> > 	    _reg: Devres<fwctl::Registration>,
> > 	    fwctl: ARef<fwctl::Device>,
> > 	}
> > 
> > 	#[pin_data]
> > 	struct FwctlData {
> > 	    #[pin]
> > 	    foo: Mutex<Foo>,
> > 	    ...,
> > 	}
> > 
> > 	impl pci::Driver for MyDriver {
> > 	    fn probe(
> > 	        pdev: &pci::Device<Core>,
> > 	        _info: &Self::IdInfo,
> > 	    ) -> impl PinInit<Self, Error> {
> > 	        let fwctl = fwctl::Device::new(
> > 	            pdev.as_ref(),
> > 	            try_pin_init!(FwctlData {
> > 	                foo <- mutex_new!(Foo::new()),
> > 	                ...,
> > 	            }),
> > 	        )?;
> > 
> > 	        // Let's do something with the `fwctl::Device` before
> > we // register it.
> > 	        fwctl.do_stuff();
> > 
> > 	        try_pin_init!(Self {
> > 	            // We could omit this and instead provide
> > 	            // `fwctl::Registration::register()`, which does
> > only return // a `Result` and keeps the `fwct::Device` registered until
> > 	            // driver unbind.
> > 	            _reg <- fwctl::Registration::new(pdev.as_ref(),
> > fwctl); fwctl,
> > 	        })
> > 	    }
> > 	}
> 
> Okay it is fine by me, Zi did you get all this?
> 

Yes. These will be addressed in the next re-spin.

> Jason

