Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB43B7767;
	Wed, 26 Aug 2026 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787744048; cv=fail; b=ER9Y+RZzDxk1GBOQXhcCnaAf8wKCJp8osHA6OaksKASweG+vpb1KWAQ1hhZ0MhBjF4Pec9BNpoBIjJs9Or7FW3NEne1ug9lK5lXIYU0zRx0nBLxL9N0dBp3vIDZJlcDIQINv7bybcvhT8dGK2+FZ/RwfOfkZtABdL0eD8TxASZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787744048; c=relaxed/simple;
	bh=uc9EMoMK7YpoZrxtHK9PlTTFdjuebN24J6SF97g5LDQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJo0HL44XgX5g743MKSl16+6j/6DA9baPzxxYdZRABG+U19Vjqry/wDPWhbIi58fSCllhaeZkRRIcP/Cs6Hu8PwY7cC54fUhL1RtQ3e+RC4F8n7aJcZzrgIe/RZkv6uhEuLDYNRCj/LQS/aMxgaaVxXKQ62CGZLZpseJ3AHemcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LpMOjy6i; arc=fail smtp.client-ip=40.93.196.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LpMOjy6i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY9InpOYlx4jETTOl9f9wzbeDCI1bxRIovMMx2ZBxyiNlNLuO/nEbn6ZZBpEAG+s9eneygV15jeH58OGdER8HRSR4WEG7RFyIAqyWQi1r6PyOwrkBdPS5T1IVPQ199UjhFVz+MDYakb1bCy5MEextYCb3xcRH+J2Di29BZoyEevoOnKByDdqj0Hybogwc2guPi22Wer+ymxc5pviiIKasJIOD2otx89JY7SkFYvbRA3lPCfVbvj+UcqJbspbQY+eB51kJ/Y9H4CCYph6WbS7ZJ1HM+97Tvbu41HF+t8TX7YL0DE88JFzrmK1stZHUs6pLse3vO8XGrk/Uken6MlCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNUTlesRlL/02AAjywClMTqYPKN76UnLYeftXeFtYSA=;
 b=NIrsuhxoF+j0XzUXNuYNr/byrYxds59oBBaJTzNN1CtFwT3HKLWOhERpttcCFmoSC/loTpqA+CRcKeN9xExaNWG9VPbkjP1/h31Ow+enlzWxh3pnOzQE7kIlBhMN6kPPT81Boaw+pkK1zo5trGHsA+pNiUh0pOyMuNMg7oDVaLMnBHMH4RqdO/lW53Se/L6ngcKojW43d1scF8RsiZB748J4p/C/5KDwrhYNtIFdCLLpBhiIhShRLSAJpdWKrPbpO1DqMI9cSXLCpIXhRpf5ve4ga2xB32npjCZbXwJcnvz7zAK6GZxzNPgLVRU18v6odp9S6jpgrPZtltUZNtgTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNUTlesRlL/02AAjywClMTqYPKN76UnLYeftXeFtYSA=;
 b=LpMOjy6i5Je0wUmNvIV+06MtADtEIz9pGQ9bHc5A+Nb5k/DQPZYCVLB+h3A+Y45alKt4k2Sj8k7GAqfTSOlKqUuUhPETfIp1ikjeFX/k5pAPnDz7TVPpapAW7iMKVlVdITstXW+jV0RlvIfvtYTNkYgw2bTSVmLJj0gXzogrtkNxV1ORTPu+kvgeOW35kjycHvX9LTHJ9yyrHzYdDu5N2z95iR2WQXLfoL9/dUQTaEs0C6vrVfGAGUkVh2mfRv83VPDnu68WlPX3sX3c29/frDAdeKrfcqHzxJFxrcyPAzMjeik/6+1cfRfrDJD1i0PKG3adnFOdburTIIvX8FSu9Q==
Received: from BLAPR03CA0074.namprd03.prod.outlook.com (2603:10b6:208:329::19)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 11:34:00 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::21) by BLAPR03CA0074.outlook.office365.com
 (2603:10b6:208:329::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 11:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 11:34:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 26 Aug
 2026 04:33:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 04:33:43 -0700
Received: from inno-dell (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Wed, 26 Aug 2026 04:33:36 -0700
Date: Wed, 26 Aug 2026 14:33:33 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
Message-ID: <20260826143333.5c911b55@inno-dell>
In-Reply-To: <DKYU6ELNN060.154BHE2QG442C@nvidia.com>
References: <20260818084633.1673214-1-zhiw@nvidia.com>
	<20260818084633.1673214-2-zhiw@nvidia.com>
	<DKYU6ELNN060.154BHE2QG442C@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7fb77b-87ee-46ed-88fa-08df0365ec84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|7416014|36860700016|376014|56012099006|10067099003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	KTjvtV6t05vunNVzeWAYrsl+WfU2+E4uirVvtMkLS8Y9oK9WxZOCfjv7aB/azS247kZk5RG4NtDi/ivuxavN6NSVYZYXHaTGAa3rGp0yYWom5llnhgq1l4Db15+F+72YY6/Nqnx1C0ZYWImlfvPF4dWI7O8uU77dcsrDpoMXXk4mPjrReA6Z71JNOCkTVwvaODj+/6eFMYuY3IhP4A+3Hgj1VVaYxrVcm9Alpr+QQsEyJXhCXfrkbKC2r1+x0BxVNvgzlSa0bmZ0VvgHZESA9VeB5BguWTU77p5vKKCmmiqw67e6huKo88CZAVHu+gjk2K6rwuRG9jhBXtYAU8e4y89YvpEwY+AvtNipY27abv+DYMJq7IoXjXNqPx4XqgjG+xFbR3zzlfA/bjdn9yapHyLvQP/uUDYjmSoX2iwpIYIriAk62GQ4J+ssQR2VNwMhKGzpJkZRUw+k9mhSSWcg5T5bAHOXWgUTDDiMdkoP9/5yuwEsfnvPVM4GzwHkYA8KYwSaDh7f4My9xWQjzxSd+SDj0nMlHarXRMrbxBxsK6Gg5q3SajnQ8AY/VoRnuoblHhTks09nb9sVka9ZpvClEgG6biFdYyIEgguiKdUrVuUt6lgUoTnTRoALsUsRGQvugIZAoVYiuLsRK8IMaWw63oLszezTpe45A/sGejk/C1bH2hXHwwgekkODNSkVn2BOXbzhf9VRHWbkB0FHLybKYg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(7416014)(36860700016)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u9no4IyO5lOGG5JUsui3oP9Kg7kLFtT+29R73S0RKVGhP77BeH9DGFtABuNwodjPepfJnC/bEFfsa98cgv9xFWj22N75Itqyjdxj5sWHWAvslmn70hWVCGBobknexWOmOiHTTfZuasDl8i+jBcOJpSt3c8+jNvbSCgqC6Sm0qw9efpsDm+Wr6QLaHBef9TAFHTtJhiJ9zdqM6P7PMrQRuOht1bUU9R8PhMdMTKwIaNy1uJ1BogH7mD2tOp7mVCadnEV9Hm/0RU8G7pqIfbyWfO0D+W6if75gJhiC1zYjJTnekNwS8cGuqb311M+5Si9Y68v1D738SjQzR61i4PoPsWcpV3IyOSRF/o2Q5g7GxYJdNLHfAN/NrcjXD1e3UZy+xGGqnmRbNKUYPas8pFbnrMSyy6tk/11Vp56UDP/H5ta3jPtQnZlGL4qW/GAMsHSg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:34:00.2646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7fb77b-87ee-46ed-88fa-08df0365ec84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491

On Wed, 26 Aug 2026 20:24:52 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

snip

> > +impl ExtCapId {
> > +    /// Single Root I/O Virtualization.
> > +    // CAST: PCI extended capability IDs are 16-bit values defined
> > by the PCIe specification.
> > +    pub const SRIOV: Self = Self(bindings::PCI_EXT_CAP_ID_SRIOV as
> > u16);
> 
> Coming back to comment on the conclusion: we have settled on a
> solution [1] to handle this nicely, but it is likely that your series
> will land before it. So meanwhile, please use the turbofish solution
> that I initially proposed:
> 
>     pub const SRIOV: Self = Self(casts::u32_into_u16::<{
> bindings::PCI_EXT_CAP_ID_SRIOV }>());
> 
> While it's a mouthful, [1] does remove `u32_into_u16`, which means we
> won't miss it and will need to update the code to use `const_as!` when
> applying.
> 

Thanks, I will address all the comments and re-spin it today. 

> [1]
> https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2@nvidia.com/
> 

