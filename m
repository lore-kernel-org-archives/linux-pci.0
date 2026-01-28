Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D20255F2C;
	Wed, 28 Jan 2026 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600241; cv=fail; b=kMKf67Q8mqeTLF1KpfQLniuTfohenw+96QQyxiShkP14NjeZFZsorKF8gd1pPxJnVgiMliAIYdEvXWP62GOntwQc/I8W8PGb8P6lp49JLkEoPmXeUMTZUEAleLsh4TSAShrE5LwYUEZSDKFhSHM6fR0fuyQIu94l0Gtiz6O0jeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600241; c=relaxed/simple;
	bh=FGVaBJ6h+gdXMNidBQvFGrPdKMD8zHf8r/zTKihgYrM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqpLE60dZqWQ6+QxAzc0Oi3NMhauZABcuvXvpi+bcFwG3SbdqyahCNhZqGPLMsu4Hd4uXEEAjOsOluuNFutaZIP53/EvnbegZ+VOWKRw48LEXMACB6y2HUpaj+wKk0yC2YNLJyQeiMDPP+IQ4DcjE+vxXCe8EkSM/TLYDQBkwRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iz58Q624; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iz58Q624"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7cbwfU9FUq2aMjIxSE0ye6ujI3pppq9fAV+pwCtxxM6sNGEdfy8kkXPQXrZTCm1qGaqf+YHBzN1pWeUe0tyvvHOzgXHNR6RZmFiUeytrDykf4/A/TJx5vqRq261Y75Xy+vH5ZxC+pWDuqwD+Ghv6LprbMc0XQNuADiugm3uad3lF3bUl3tUPHBa8HcqEEYNLY52mMUdQplWfM3949/ebJFNmF/McDgCzkrzp/HLd1TsdAr2FPwvE3bK/Zer2tfpwrj8/kpa+hEUPeP8w9X5MKAqN/j1z+UYXkFWC8n3RzoytL8DnWLzyUZ06+xLD5/6p1R8j8IMOoUrYrni1F9Pkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM/xc/2NCMgptm2ioJMQZtReW+/tgWRTtRf2H3tN+tk=;
 b=CHODlShZ1CloXM1wzoSeyOb7bhj6KAY6+yJ/fLsuOrQ8z/xBL4lZe2FTdykkAiMXractiJtWMn0X0fF1mdD0Tcrh+9qCstlJQvp45z+TFKsdY0oMDfjSpeX2URzvAu/EpEUZLHVvZKQojrROQFHdqW7YKVnC3vpkin2aFx0coklXhWarPXhSygnD/JqmUo/udFfvpwtKmASSbu7QwrFX6E6PGOvGa0e4tMEi4FvDoBl7PtLOhAZocFL40m9yX5mo3NJv/yiJHcAqomsF2szy4H/Q1AL8haH1kgTpbruJbdHMT8BMWrMEEtOd+3HSC6HDWngUi9r5iEwGvGNit18fRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM/xc/2NCMgptm2ioJMQZtReW+/tgWRTtRf2H3tN+tk=;
 b=Iz58Q624y22772R3+jfHuIBA8PUtJtjdXQyJl+yx1ZPixx/ok+SnyTFg9g//WsN4XB5dWbm1cZG4R4Da8biSsIqp03hVatBcObf8vuOLq2n/UGUuze39LgaGst9qDL1WJS2jWgqwgBG5ih7pJojBwi4EcrEJwrtLnz0N2xTfTAvlUf0Ids8eDGICTBJshP9ZRsVFXe64qgslpH4EnUBoJ6OLim1QBA8rQw0WPdgBBdgd57/Izl0qPkUOrFKlj0cnD18oOBE0j0mkO9y8WhCg2YDZzlNXp+pAeSATc+ATEr7tnhjqdIsBdgVr0JBMr2Sg4FRRjplQgA3AYWm6YvBW5w==
Received: from SJ0PR13CA0197.namprd13.prod.outlook.com (2603:10b6:a03:2c3::22)
 by CH1PPF93AB4E694.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 11:37:12 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::ce) by SJ0PR13CA0197.outlook.office365.com
 (2603:10b6:a03:2c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.2 via Frontend Transport; Wed,
 28 Jan 2026 11:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:37:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:37:00 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:36:59 -0800
Received: from inno-thin-client (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 28 Jan 2026 03:36:52 -0800
Date: Wed, 28 Jan 2026 13:36:51 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, <rust-for-linux@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctl
Message-ID: <20260128133651.365d876a.zhiw@nvidia.com>
In-Reply-To: <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
References: <20260122204232.15988-1-zhiw@nvidia.com>
	<20260122204232.15988-2-zhiw@nvidia.com>
	<20260126181912.GA2131321@nvidia.com>
	<20260127215744.332380fe.zhiw@nvidia.com>
	<DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CH1PPF93AB4E694:EE_
X-MS-Office365-Filtering-Correlation-Id: 01757ddf-6945-4c61-91b4-08de5e619464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g9gKKXHIBfJy1q8coylLZZsblf3+eQNVWuJrRg6vHyra7gtC8ZhKwmcBaPI+?=
 =?us-ascii?Q?1Z+j6+SsGD+SFLZeLFoeB7WsWr03fyg/phHZWosYLiCSjxxfwvQScuLd7sEc?=
 =?us-ascii?Q?YDwsTXT10NyVseK01RuEuo7KvIGD02BtnYTlWwP/+QrMKGqwokDGpdRCOKNg?=
 =?us-ascii?Q?+gBiiGzSgmFD/8HxIYmTUFUK59VEKcv0DMfqwB+wP7C3KiXk2ZaVqxGKXYqh?=
 =?us-ascii?Q?P7b5R34U9eYxoxI32zXLV8nOZHI4l6PsS4b7q3PK9kSyW/8Trq/b3MDBXyyb?=
 =?us-ascii?Q?5QGzCK9E8M0UZszgUbpJYuHsVmpdLPDi7zU6RcyYfL0uNqfE7SEsxCiotrTB?=
 =?us-ascii?Q?i+cdBcVsA+WpEmxPuB6AJjCKYZKBotXKhFVTYdZmI65PMYrvCXMx3bXHY0Iz?=
 =?us-ascii?Q?Wkgbuz7EOJ4cOzZ112lAHCH2BmyTIVOexi+GG78EaAn5+Cmp6oe/rh2TQaWK?=
 =?us-ascii?Q?bIostDzTLSjJUteRe/YTaLeEwqUGYCQ1O1qdmSZtDBXLWja/N37Xt2aLHF/t?=
 =?us-ascii?Q?c9uaiOpGC+fiOsZNCCp3Y1NhHvuvQ6X+S4PHpMmoSuOLBJ/L90ffJGsDk62w?=
 =?us-ascii?Q?eni76TWo22LWpng1Eq7y8LwX2eHrPnmiiYOfpDOyRLnyI2OsLtieNuLVm4YX?=
 =?us-ascii?Q?Ga7rzxhx4DuWFCyq2phDbmDSbSmKSY3IffP/cunAur+NEBDKRfuFISzGksj2?=
 =?us-ascii?Q?PxtRnzrbB5A7rwpFgiWwJwa/5TmeNn6PFuAA1bdT5BbkOofXj0/k2Wa6uVkM?=
 =?us-ascii?Q?Mr+i2o/zu5HF57p4c3Tqr87mclUG2A6PfTgmqolcGy7vbVnNXCvenkq31PzW?=
 =?us-ascii?Q?D3znUeCpEfpISwiWMm/hP3tHzXT3CHgIDBvFT1a0sgMcF0PZKL0aG/2b1TUf?=
 =?us-ascii?Q?wBTliaSossGfmO2ZCpabC9SNnCckKqZkPal40baEE17ZTrqdtwHa9cBAdvQC?=
 =?us-ascii?Q?gLc7krkh4+gAzfawtn7jpGclvtYUhCtfaCy156pgFTCFxoq+ih+vuvmzmrAF?=
 =?us-ascii?Q?ZjF4PKmPq/dh9LjRKmf/JWhx0Z+dvLNhr8qDFksZohseegNJRK1MM4fDBEMA?=
 =?us-ascii?Q?mNbMfJ5PUuaWB6PAMj23smv3v3A3zU6ddSgwh9itvjZ1T8o5mv0ge6HCiovh?=
 =?us-ascii?Q?grSN4Zc6ZW+67NIdVY/kRb/pZL9jJOoc2Pwm++uIyC+l0SFnMFr1GNUGr1tg?=
 =?us-ascii?Q?t5ipoJ7F/tPRcoptDZz6fUZh91K4ikVVQ9x5OFg/ZA2zl+0s0zMm0X2DJRWy?=
 =?us-ascii?Q?mzka7atk4PDVZ4ZEn5ZkNAwpZMYc+r4E3EzQQ0+Mv4ZzhDy8W1ABNedd9KKr?=
 =?us-ascii?Q?XhHdbdhDUF5fiOSyrTziRbf6qdRyK2G/bHyqlUUBVSm6CIZkD57+h8luds4c?=
 =?us-ascii?Q?nn4FX/yJKx4M0KOBvSGIpirmiegYLIGJAgEx2yJ0gEE3UCBtMWu0VbojA/Cu?=
 =?us-ascii?Q?MQmHk6+VeQwLObx7/4FW+dgEzJdvcyPZTsqhJJDa1D5buARkQmuRK2SVVYB6?=
 =?us-ascii?Q?yFYXWXmoNm+9vbPuG8P/NsikdShgj/8BXoDDvajhXIONyLdRdiDEHM5JWi6s?=
 =?us-ascii?Q?bhY8Cdqx4gXSVMQTgXFbB8x4R/+oQ98iRbohBke75PKgs1xa6bmAaJTgfbJd?=
 =?us-ascii?Q?UtnoxleZD13sBrATdbCFqR9DzKfmLEzc6BuF3+A13VGtsJOSxuwxHTtJsoke?=
 =?us-ascii?Q?7Sntsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:37:12.7323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01757ddf-6945-4c61-91b4-08de5e619464
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF93AB4E694

On Tue, 27 Jan 2026 21:07:37 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Tue Jan 27, 2026 at 8:57 PM CET, Zhi Wang wrote:
> > The fwctl_alloc_device() helper allocates a raw struct fwctl_device
> > without private driver data here. The Rust driver object should be
> > already allocated and initialized separately before reaching this
> > point.
> >
> > We rely on the standard dev->parent chain to access the rust driver
> > object from the fwctl callbacks.
> 
> (I will go for a thorough review soon, but for now a quick drive-by
> comment.)
> 
> IIUC, you are saying that the user is supposed to use the private data
> of the parent device in fwctl callbacks. Let's not make this a design
> choice please. Instead, allow the user pass in separate private data for
> the fwctl device as well.
> 
> This serves the purpose of clear ownership and lifetime of the data.
> E.g. the fwctl device does not necessarily exist as long as the parent
> device is bound.
> 
> It is a good thing if driver authors are forced to take a decision about
> which object owns the data and what's the scope of the data.

I wrote a version like this before. My initial concern of mixing Rust
objects together with C objecs within C-allocated memory was about
potential memory alignment issues when rust side doing CAST on the memory.

I agree that providing a way to attach private data directly to the
fwctl_device also has quite some benetifs.

IMO, if we go this way, the private data from rust side needs to have
#[repr(C)] to address the above issue all the time?

Z.
