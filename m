Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB8366DBF;
	Wed, 21 Jan 2026 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987812; cv=fail; b=eNfw2xctZOFLf1KP1jSKFw7GomKO3l2vL0hQ7nctip5qhOAJ3Jq2WV/acbDOaN+vClxKwquXJT4qNGObQOVImUipv3F4OYXJZsBMajpIgRsavcKvBX/Ib81nhZAQFFUBYGQoEse5eFcjSkZTdEH0kWXOsCLE3A5LbIKegifvrYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987812; c=relaxed/simple;
	bh=3mG8zT2Pc1yKh4ldYeG21ZGCfITo9ORASIVBotOEoEk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfPmlxSieT2oBpsG+fOYL6AxAm8VxN0dwcPvemCJxyRbhTnM9EsdLNUorb9I7Ha2LnCpeNHyztFjrtd69JIdNFSYDHtGtYgIDOBE6Lpug90y4I10nrmWyQI9FZjdaS3uqG3DqwbjFLDUMd9P1+qW139hwJYO224s7bHa218aCj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hDa2zlUc; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hDa2zlUc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mci39L8/drVOAVddbUJZtgHph1gqiFBzgBY1+3aqZjRgkGl5I4+F8hXgz4igez6e9Bz/YlW47S1DEeHl+5Wttz9d7VZSF9exNCYUd2UWmHBcKoL1XbphnxzU3fbtvUBKPKw5cV4d85JiqoNUKW5r661hW9gDBnvr0cf+nsnRiob2fbtMCRnEUl+f0P1jEpHyXpCBYoXRyUczMLAixMpbuBlsNKOhP4x7L4ELNXUgH0jxqcY6wQ3SE48MtY9v9ulHPtbZcNsMJI1ey5nEtT1G60SOcYUhbykAkqJbX22nTT/HxhuSm/1EH9cbXij9WUWUf5SkuEmptJZTVBVvS89Zqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mG8zT2Pc1yKh4ldYeG21ZGCfITo9ORASIVBotOEoEk=;
 b=zTGUQiS4uxwtz3N5mxvaZzhrJBsKctRQu4mAF5sJVGyYD7+cjssym/8bekQuEqnrxqoCZekOOzWc00qslYHVXBquSPv6J4UtPNfL+C7DlNdMO6+QUpTpQq/3mmHIKoNmcGRRw1vgXsu9492rHHStzsj7jlsXo4zNGO8pZmzzfhWVZsJXVvdE9pKKg5P3LEJ8WZ2VvezaM740je9Uj83dsNC4n5vYmjZgiFkjBeuexlI3yTp/ezlfyksnmuttAezApmpR7QmhpRk4c1jXtKKolkJgJvhaKuFlbqn9wWgUqAV1avDpWe9aZ1i2csAbpD3LQb9HWtCivac4OOt/nvmfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mG8zT2Pc1yKh4ldYeG21ZGCfITo9ORASIVBotOEoEk=;
 b=hDa2zlUcJRx50TWcf2eQ1basOKykJ9uktZxHXvosnExmGlaDTX3EDAzUx+zcup6l7k+5NvCQ10vcryihpI20eCzUzbOrXK4VmRRdqriGhoTpCGSonLMZu+Ef8WgkQDjhJ1nQjQXn1Iej2dDo+DJTaLVSiTgNd3usFVen2gWWOiUk5ukpDGUAPKRs9ftervXEuoLl7ZuEtNQLnPcABUF0yBsFgDbX+wDoUmiwvBU54/Cwoug4Gj1CrIsGIxG3+OQZYPngol9YDbzkUSM77l17HzTEcbkSMkfKSLeZ15dM8I2hIdnZpSLWu04rXMnX1Qq0K/rNPHes/79jGVLhnNDNXQ==
Received: from BL1P221CA0031.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::10)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:30:06 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::6f) by BL1P221CA0031.outlook.office365.com
 (2603:10b6:208:5b5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 09:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 09:30:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 01:29:51 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 01:29:50 -0800
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 01:29:44 -0800
Date: Wed, 21 Jan 2026 11:29:43 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v10 1/5] rust: devres: style for imports
Message-ID: <20260121112929.5497b997.zhiw@nvidia.com>
In-Reply-To: <CANiq72kL9xwT-wdyGNpekmnXioUhwLjcayE_pkmKEEw+RDCyrg@mail.gmail.com>
References: <20260119202250.870588-1-zhiw@nvidia.com>
	<20260119202250.870588-2-zhiw@nvidia.com>
	<CANiq72kL9xwT-wdyGNpekmnXioUhwLjcayE_pkmKEEw+RDCyrg@mail.gmail.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: c20f19ff-35ac-4bc7-9a92-08de58cfaa06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2RSd3orWmRCUFJNQ1U5T2FHNGRIK2tIOGlpaHZ0dkVzN0NhSVJ3VUhhYUtG?=
 =?utf-8?B?TXlRb0l1Mk5xbmtrbUJDRm8yNUFnZTkyTTVnS2hOOC9kandINit5VjBiZHlF?=
 =?utf-8?B?S0FMZ3hVd0JIYzBVeHdvT1Z3OGY0OEg4TFdQZ1FaQW5hSVlNc3V1SlVuMHAx?=
 =?utf-8?B?VmRMN0R5ajY3VXBHQUgxMlY4SnlUcHpETURKcFZSZGpxOTVsbUFxKzZsYmoz?=
 =?utf-8?B?Q09iV2Ivbko1VDh1LzV3bk9VUXcrWmFBUElibzYvTk1sdkhjeThjUnYxZXky?=
 =?utf-8?B?Vmx6TGEvVDUzaHBESnBHTERHWk1ScVhaK3YwMktCQUI5WXEvYTEwcDExNXQ5?=
 =?utf-8?B?WUlxdEVBRjhEQW8yZXNsTHBtZXZPSFBWWG1tUnZqUEVWRTZJVFhuenhFQ1Ry?=
 =?utf-8?B?eG8vQjFNUStDT2hHQkVHR0hvZFluRmx3S0QzU0Yxb21ydW5Mc1k5RVFBdk0r?=
 =?utf-8?B?a0FtN1ViNkhacngxOUZNSlRtRHN5SERiaGttSlNkeUFuMTdwang0a0tYTzgw?=
 =?utf-8?B?b1JBNjZhaFpMMWI1UEtuajlaMVZDUDJXWUZqeFZOaGxFcDVMbUN1S1J3S0gv?=
 =?utf-8?B?K1ZjOHl0WTJub1U2M3lUUDRyUGFXYk9zdkJLVml1OUFRSE83d1ZGVThZeDZl?=
 =?utf-8?B?Z2RHZFpWdjloT3JPSkRTbWo0ZG1Hc1FvUDhhZGNuVnNHYXdsL01xKzQ1djB5?=
 =?utf-8?B?VWdNcmo5Um9GNVZsR0xCT3dUbUdmVmpEVTVMZmR3MklqUjRTb0RJTkIyeHBz?=
 =?utf-8?B?RW9xeDdjY2IyNER1TG85amxOS3Roa2RwcEp0SEVpMUl2bFZ6NVYrWm56MCty?=
 =?utf-8?B?SHIzZzMvUU9EZVZ5ZHpEbnNYQmM2M2dXWFBvbklZdlkyK2trZFFPekVjb0NB?=
 =?utf-8?B?YWszOUwrRDlsek1IWVlvOXlkM3pTcXpmUENuVVpSb0VHQ3dkTGtFdTlKUDk5?=
 =?utf-8?B?RkhidHJBL0lLYjlKREZkbU1kcVdrbHdsZDE4UlBBYXZaa2lhYldrUENoeXAw?=
 =?utf-8?B?UytDUlQvTldzOTZKa1RFOGJRQkJvWk85MkpOdS9MS1NyREwwZ0dBMWpuZ3p5?=
 =?utf-8?B?Z2dqbFpoWFE3VjVaNWx2eThrTUNhNEZOeG1ldzc0cGlWeUtLQ0U3a2FzT2Zz?=
 =?utf-8?B?Ulg0RWVGMFR1T1JBTmxWUDhSS00razgwazVWN0xSN2Zmbit2V0EzZUFZaTI3?=
 =?utf-8?B?VktGSVRmWkJEQmdBVVozM1ljM05QUk1ZMWo1TitqNmJBL0xKeVZIUEZPZnJD?=
 =?utf-8?B?N0dES1FYeFVXd1lEcnh2WU5yOWlRdElXVkRTU3Z6Rm1TaE41RGNoQVlPTWFy?=
 =?utf-8?B?S1lXMG1nVW5wUVFCbDdKZ1BEZU1JcDVEL1FjdGdUdllFcjRFd2F5RmxlQmti?=
 =?utf-8?B?K2pDdHRVMzRPWWswQzJVdDhyMWV1TFY2Um5BV2o3VlgyaG5IbzVBWWprWnR0?=
 =?utf-8?B?UmdGaGZubEZJSVpScDVmSDFHZUFXcFhSTlBEYVNDTytMd3NUUk5JYmhaRzJ0?=
 =?utf-8?B?R0pzS1hZS25aRVk5RzArbHRmM2pSR0xyUS81VnM3N1d5dFRLMWZWL0Y4SUtz?=
 =?utf-8?B?b2JvQmNBVytJQ2RlU0dMWjA4b1ZDdHZrQmYvd3VOT3hZcFdaTHFacFFHdEIx?=
 =?utf-8?B?WE1weHdickJURjFzSXFRalB0cjJLb0FTZ0ZhNEoweTloZnJPNWE3cC94UjFr?=
 =?utf-8?B?bFpMZTJ5Q2NwUnhTODFjNFVtRmlpOFpUWVkvdXd0MGpMZHY0Y01wd1ZZOGxi?=
 =?utf-8?B?dXkxSVc0VTJVRGIvK0RoRGNUVGxpcmo4WmdjbGtTNU5ZZFdNMFE4K1ZzM0V0?=
 =?utf-8?B?aVNhOWdFNllwY01qODJ5U2ZrWko3RjMzRGRHdXppNnpHcUxNUnNGQnR6TTNx?=
 =?utf-8?B?dFZ1czE0ZlhYclBmazNhWVpnU0h4WUJ4bWxXdmJnaVBOSXlnSStSUnR6RHlm?=
 =?utf-8?B?dG15Rkl6WXBEQXdaZ3VyWkRCak1TWFk5bE8wTXJUdzNUdXdPREd0MzdJQlhC?=
 =?utf-8?B?aDM5QlhCakZRcXRRckRuWjVOYjVqSWxuSFdqSFZzeVBEc0FPNE16MnluMW5H?=
 =?utf-8?B?MXNlZThnZHZKcHRKc3ZLTzY0b2hyZ3JkeFlwZTlsUS9UUW9lc0FMdC9LU2dq?=
 =?utf-8?B?Q3VSdERJN256c3hjeGh3amxZZWpLKzgwS0pCVnhMMFF1L3N0MUswNXJTMzEy?=
 =?utf-8?B?SGVUeGZpRFJMZlg1ZmpBSU9FenlMZnh5VGxyaitKMUJUSE1SRGVtckx1WFJ6?=
 =?utf-8?B?ZC9CeVBKeGllSGw4NlVoaFNSbHdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:30:06.5435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c20f19ff-35ac-4bc7-9a92-08de58cfaa06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294

On Tue, 20 Jan 2026 17:11:38 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Mon, Jan 19, 2026 at 9:23=E2=80=AFPM Zhi Wang <zhiw@nvidia.com> wrote:
> >
> > Convert all imports in the devres to use "kernel vertical" style.
> >
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>=20
> This looks fine, thanks!
>=20
> (Not sure why the Cc:s are explicit here but, by the way, perhaps you
> may want to use the `.mailmap` if you have some automation so that you
> use e.g. my ojeda@kernel.org one instead).
>=20

Sure.I am trying to Cc folks who comments in the patch for crediting
their efforts. :)=20

> Cheers,
> Miguel

