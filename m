Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3973A37F74A;
	Fri,  4 Sep 2026 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788562658; cv=fail; b=kK2QP9FDEQTAonQ06SZbM5Tncx8dpumGUsu7VReI/kbWXvCOzV5rbQcRH6sfA+5ys7nU4EYNtDtKOtHr1r5y+F2DizXrBZ8rb3w7DnfMACZgNqDiqFx3l25Idy+c9VgKIVAlWx6w7cYxbUK5xY+RxmZMz3QQxtGGK28W5IbpmcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788562658; c=relaxed/simple;
	bh=bn1NYcsJrNEQsbnWYjWrnMAvqdRJKdjmfpOGlNswFxM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+GX3ih3QZhQEraiK2LUGtAWLGlNYHXzICMrQw204dGMdzzPPxX23EbyAajR53zrDmx87v7d4ytObUeVtgQHceIInol3wa9BnLLXc8gZ7m6QP+5p7Tbe6lpjnXVy963QyUwGcAgxCQAz0+ZIJnhv+Qa2UkUBirQ4f0WUw3FnIH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=risz1AVu; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="risz1AVu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjmwqpi6o6tA2tbcyxc4fSpc/xWpkNZVD5WR0tIzUWrmJstjgpgO4upjfvdDcUNlOQOgB/LzE+bJEITT32JBJUUI7IQjeYplrMhR4NFLdcpUtmPipKWMC5AiMomMEXgJ8O7M6PmSAAAoem3OyEVwdI2BZeQkoZyIAogl2HdVzMdq5Mowt/H49+1AnvTZLyrSs3edtxx4kjuGQBweLbG3MZ+S3p5wblZAHVDN2c56g3uoxtSlDs+wxY1Ryc2jPvwMtzNptMkVj5udTefF88TxBYglJ/42B2mDTFbGPFExLnLUw+zzh0DyOarqidhW4A1/Bx1gogpvtbGQhJg+B6srcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPbIgqSkBwQ2KDwgvNvCRhxjM6UlbU5yXmSdqDfrGVk=;
 b=Zt6X64tejzUHQBf8GrggV+VP1OD6idXS1ZPo/gldhqAP4r3BLaDFZ6OXXUV9ovFyIPjJK0O2aMX00JZP1hevdVrAd+3SC655u6d/djoRfTWZWC2i4NuDC4zJ7FNOb30XizkjiitRxanMvaZbEHtBLm//gWiLku/jSHzgReLh5RVrTwtXBhZFtlzhn6lZk/HATloNygCb1ewVgJUgmRe7WcyH5hUCRVSV6Mq6HLCGgf2JJ16i+26tF7ZGTpyb2WCrREH3jNr5kf6H3iAsLRnExqb70iOsJzAFczdYKFm8FkoOoRxQ0WzOMVC8aMEUS+o1WOcguuE3NEvxESmX2KWG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPbIgqSkBwQ2KDwgvNvCRhxjM6UlbU5yXmSdqDfrGVk=;
 b=risz1AVu4wOViNhmAHwL6qGYZomz6WUPyaOVkEVCOIQkPntH/6SewMfg6dd9rG1zU10gd2RkolRG9IQPMnN/68qFnIcdSt6RxSCM/AmlWlsleNReKL1DjV8ocpN4XkKBzk4wJANxQg/hoFHvNIiO5ko0kHkjUSss7NC+PONADv+niEvvA49TDwLyF4coMddL4sHFYm7XLuKxBC/EzMS/UtyY/NoPhRDiMiia9uiqMRK8gT3ApvtAxWi8A5ss4C6qsvrxpFBsO9ntuyvLYiqVNweO/3GNzzLg7d8DO+3mmJ9pNPDxhFQxVHspAHXQIhHS1Namp/59MrjPoizD0tzcag==
Received: from BN1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:408:e2::16)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 4 Sep 2026
 22:57:32 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::3f) by BN1PR13CA0011.outlook.office365.com
 (2603:10b6:408:e2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Fri, 4
 Sep 2026 22:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 22:57:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 15:57:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 15:57:17 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 4 Sep 2026 15:57:14 -0700
Date: Fri, 4 Sep 2026 15:57:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <kees@kernel.org>,
	<smostafa@google.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
	<bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Drain in-flight fault events
 on domain detach
Message-ID: <aptMynoQtAf1Jcr5@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <8717f3329313f40308cff20006066283ebbb3a56.1788222485.git.nicolinc@nvidia.com>
 <178846311316.1308030.6266899352044838554.b4-review@b4>
 <20260904140906.GR4157646@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260904140906.GR4157646@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 936f03ee-d457-4fdb-7010-08df0ad7e739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|23010399003|18002099003|22082099003|56012099006|5023799004|6133799003|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	kh0sV+nfDsEZk278y1pEsbhL3fcgrP+e2XkXUaxjSAvx9v7ZsMvWSlSR+bnjTd3vhpH6BoP+ybSMx7sbZD7SdfVexl5Rl0/MCmcVCNlrvGEsn4M/dFGzvnQXkTs9m+Wj+WMytU4J0k7sUQcNj3KrcRMcnrRbS23wLIKLeem4yn3sfL9dNjKY/raK+dIZuGpIOo7/qanTjNAPmSnp41o33wVLGyujG2vKFdrQOrDg/nk1xy/f/J4ivmcJdBwPp3MX9cSInh5jvgkF+dFobNc1vJTdxOCTcFQJQg885PnBjuZzAAmXwc5HbxTz08aanDd+C2+56MGlyFnLEjr4f8aD3drAWBcF4twtjIYLmrSzs7xuS7EN1Na3VxBVCipC3knngIN3MM+qUJBPJqYG2k5L729zeIJu+1INyO6CT2b+6Q0ObdGVZlT6XSJOPBA5WR1i6YDzxQFYcxGdPnD+IFBIqdtLveZAzayFBtU2KjoAWP/QWQref3O4tjlI0bB9iyIW1jtEccDC2Ow3kxRWiHF4SAR0/etssprsYqREuVE+tDmtDEY4/2IJwiX1eM3WWsY/zziOkXh3HEIRQ6LYoCK99btSNDwprQ710mvqQnUgyv882sKSn0Y8AMQvicpBBlxQsvwsUx6VIjLL60NTVst8q2ij7MLvu0FclufRAeQziyGbtm3A9cHnSggqfcG61sJNEo3x+kXRnbmCWOdnsSW40A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(23010399003)(18002099003)(22082099003)(56012099006)(5023799004)(6133799003)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A4i6VApyHeKvpNRbXFW8ctpt2S1llKQCdwsmgdEtvSmIUKCLwC0YUoP4QnS/HP9D9XYLcB4JA0TDT8oRps5iLZaYtUujVKOhqH0IlioyxYFmPmQeoJds37YxKfhv8fDdcia+zANYiFccMN5VQXGbCo32Oi3rl8HB2+GhdCrPwsqpeUuViIKNLkk47TbUlKPKkq8gna1ZXFLSjMdCt4bnutc6mj2M6OKdxkEahp1uG6iVGk+hUKtx5IwAsPyL0t4T9psC/BHsgVjuii74IYEIv/S824NSLDjyvEMM/7KC9Sxji1vaJWppqDcq5dMzldedSan/gHUqfZFv1GIpDBtJMs3PBmBcyIOPDNB8ukCtgNDkXF1a1X+1RoALItiYc+9n3Q6tShM19XRE5Jbrq3eoh7LRM1sIhtC0UzbPRH7XKVA/a6OmH92TO6OsEfxqxsJH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 22:57:32.1600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 936f03ee-d457-4fdb-7010-08df0ad7e739
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685

On Fri, Sep 04, 2026 at 11:09:06AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > Also run the drain for every stall-capable master, even when the departing
> > > attachment did not enable IOPF: such a stall event has to be aborted while
> > > it still resolves to the old attach handle, 
> 
> That isn't the model for fault handling. The fault is delivered
> unpredictably into either old or new domain. It doesn't matter which
> one.
> 
> Domains have to conclude their fault proceessing before they are
> destroyed, and attach to the a non-fault domain has to conclude faults
> before completing the attach.
> 
> But there is no requirement to deliver faults to any particular thing.

Edited:

Also run the drain for every stall-capable master, even when the departing
attachment did not enable IOPF. An attachment has to conclude its in-flight
faults before the attach completes, as the incoming domain might not handle
a fault at all.

> > > could pick it up right after the handle swap, mistakenly resuming it as if
> > > it were a valid page fault against a new domain.
> > 
> > Useful perhaps to call out if this has been seen in real systems or
> > not. I agree with the analysis but would rather hope drivers are
> > well behaved in ensuring all traffic is done, adn this is hardeninging
> > / handling of naught hardware activity (all good if so!)
> 
> There is a firm API contract on the iommu drivers, they cannot
> propogate faults at unexpected times because the consumers cannot deal
> with it.
> 
> We don't reason about well behaved drivers at this level because vfio
> cannot be trusted to be well behaved. So any nonsense vfio can trigger
> has to be handled without crashing the kernel.

Added:

This is an API contract, not hardening against odd hardware: a detach may
arrive at any moment from a userspace driver behind VFIO, which cannot be
trusted to quiesce its device first.

Thanks
Nicolin
