Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B66E377A8A;
	Thu, 27 Aug 2026 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863778; cv=fail; b=IJItQFTvTm12rHBDi125Yq55CoRZC6/3K2KsmawJs70D8RdSxLHWxvL/TQQUwfAzty6Xj4WVrWf3+PSwc5cnQNo1cHeBr107QIHGvMUjXJwhQOD8fMfwJQbjb1vnVUr3MiSKNOmKEJV2VxEqqCHGP23jL4mnsFi0wgsXxYTKMFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863778; c=relaxed/simple;
	bh=soz/nUirTM4pDt3Ozw+jJpeAE82UVjqcPw2qslallrE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpGYiI3e/Yu0aXZSG/c5HQZB0DyNDn6Ch5CEFyIIgzGWvMk3PgiCdZLeH3jYrv78FLhLsPPgkUjgxk6ZeFYLkKNSqzemuZ2BwJUFB+Sv1DvpmTBbPx2oIhJF4smU0MotDCTzzG5fnTN3kdwmG4FPnxoHCwyB6ZT2qnzs4sv1Ud8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pktFjnFN; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pktFjnFN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iInqwWVkttW7s92U4l+Ig27TZJHjppVhK2aR61s+/VEMI3VOIAE9RVH3pyEC4RNBjYGqNJ7I8Q6R0Gps5VkhD038xU9jWX22XkiefR4DXfC7M07sW3klELFzXbLkP42DQ61Dk6ma61Ypz56am+JAcJBxwGjG2rwq/KF+RZPKq1ljdqfrb9QJABxL+sk/8M4/oG7vwx0wNQ8rkq1wguaCWgDhWWhyewlcqyncNab1Lgjw+xxxHugBZe4oEmOoBVjpEQdIBwH6sPYQu+DqBep4YmsuNAq4y2rbJX7WhWlxxQMjxA1AAgAdyWgsl+w/yxwmdJdvNGYCEWJsba9dr9SQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm87bwjoQJmiQL3zpX4l4Rrv8NU/DtLDPPC5nexWbZ0=;
 b=ciAJ4+q0iFULy36hZ8QsWWgbhaG0PN1z4x3M3g+Ktr2wz5NApyKpjbsjTtKvwyauUrVnKTEqyUpwNqXv14nwc/3KJzDGU3NPzf1ax8k6cjV1iVu0Hm6bDHUTDUD/MTXImMY2st2k0aBZWU5OoMDCi9f6wUXZ2vtjT+HxkSA88ZfbhMsZD2MJpGtxI+hRE5iO1a6RzeoO7vc5xawvKnif0NV+uno9OKyAHbN/lTMuceUJvjhD6pKqZPn1PRgsg3ZOJ8tj5HuDVRoDifNS7SrNjGs2XAHL8JKFkkoOJA0dmhFQ09I1QcI2UxVlAqFi6zEOhbV+YxrwZk8/gk+0UM7esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm87bwjoQJmiQL3zpX4l4Rrv8NU/DtLDPPC5nexWbZ0=;
 b=pktFjnFNXiXeToGanlsIu+TLDLz9szP8qrwTMnOyj7lj1rZ+5h6qOUwuP4RqLEADpEIax/I0WEtYyIEsK7WpQWnvZCh7XHrLryybnhPfKndP0xlVrd/YUnUQBXgUAEpgvwYA6/2P8ozLQ3H+cxwIrUGcsLOU4TTWoLSEl3cYJYwpwABxWrrf7CLu5NYrb+vT9JyqvVv1XHv/gsMvCNJL3jJ9GG3lMVdtrhpAo0UMAk8QiKBEPghSM8t6GgF3uIZRanlP0qBjpQr4N2jNZkJhocXiamKLNKWnqHiaP/HLZ6hiBidh5aGkJLZe3YYpPSptNGhFWbgJ3eaFP0ZzEAh72Q==
Received: from SJ0PR03CA0390.namprd03.prod.outlook.com (2603:10b6:a03:3a1::35)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:49:31 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::6) by SJ0PR03CA0390.outlook.office365.com
 (2603:10b6:a03:3a1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:49:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 13:49:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 13:49:07 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Thu, 27 Aug 2026 13:49:06 -0700
Date: Thu, 27 Aug 2026 13:49:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 02/18] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
Message-ID: <apCiweYENYZcBYiV@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <eb77bc0422c77158f48f370c3f7c1b937c319894.1783044582.git.nicolinc@nvidia.com>
 <178786269177.3808739.5968833634148757858.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178786269177.3808739.5968833634148757858.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a4c646-7155-45aa-e99b-08df047cb15c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RKECW/E49PtTNM1W3EAG6EPOh+9b6vg6AAGJcyxwtrI6AzvLLvwrJSxlVbMWfAfU4jtak1iuvRmczOSfr8706KhLN0p3T7cYrwSpIfR/iJ7zvcIoccNTrn39vsGcZ+zba5OaIvgH1ddsLMBwUmzk4QdcXi9z5CcvDAdWoGjfz7WOcd5mRRYcgaYW9B8l8+FZjUGAQCqx9bXh6unVhGjG4KFf+uSefO3wmaNMHaJXx/QSqyAkNkcIXY5TZ0GxTo5PIEQ0rHLnMbzoB2Pd1yF9r/8z0wgmBdv2snc0G6yY9h7ic2OedQq6yPZeJ5qA1IZN2HLrZicCS0voSpvQxoQP5DGU9YTMtW82+4eLdzEnYjbARtSbUMyzTrNUU4XDqQztadQrO1VtC6kEN1zhrqBxVQ5+U/7l3My+Gm9xeQZYUzk45OIcn2K6I96ZD3rXMryvczYO9sN91pe6ZJONve1OoYAUyDK5jhsowh8b5f5LnZ2Aaa4BU4uvdDgmAPZzRndZ3B/afIbwuNGTujs7W+bb8tNvTtqSyuTX/0aE2dZu3QHPMvvkV/4+JExSCIYj9sGqDBN12gx4Qow3VCDC+6e/NVdCz0prwS3GeLwdyckRnWuhoWEGSaqnmiFVkexk/mlocnhRSQBdCJC5+FyzUjpl/SRlQ1Aql6DKPIVko7uePZdqKlIExzq7vCcDspccaVho
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nGpiHyxNuNFHkWbvgQI6j35GlGg//3/DUWSlO1swM17bf2iKKVkHAg2fq/pIT1h+Nkv7QSOTusf46fGZaIeJ4qnUMzFPLYNuk9KoNwfb5NjzWGhwgOBTnzDaCPVxGFQF1q+/V9XtUbuxk1AzUtIEfy0cSLJzSEbgJJJEc36G60jDB0PN6ur/IFCsEy45A8QUE2ZL0Uwu9PhdlyD9ZcBYG7sCiAIP72ksSjSujb8+TdJ9/tSzAp3lb1aYq515lRS6h/Izqd04hDonHNeYD0qdRCmjTYP8xVDJJQYq/W3c2cvRD13H7jb1WUuZlaEmBUBZuAzL19yPVkY6a6GDKZgRDTa5kC6fMQEjxgGOe6qwAmMkCHTBUUSCdIiw5lyo81E1pXPScIt7iVJBrr4vGK2WaP5//+GC13FimhJHg+0r99kLav8sAxdIX70uAdIpp7h1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:49:30.7601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a4c646-7155-45aa-e99b-08df047cb15c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

On Thu, Aug 27, 2026 at 05:31:31PM -0300, Jason Gunthorpe wrote:
> > [ ... 27 lines skipped ... ]
> > @@ -4979,8 +4979,16 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
> >  	if (!dvsec)
> >  		return -ENOTTY;
> >  
> > -	if (probe)
> > -		return 0;
> > +	/*
> > +	 * Do not probe via pci_reset_bus_function(), which would reject a
> > +	 * masked SBR that the do-reset path below unmasks before resetting.
> > +	 */
> > +	if (probe) {
> > +		rc = pci_dev_reset_slot_function(dev, PCI_RESET_PROBE);
> > +		if (rc != -ENOTTY)
> > +			return rc;
> > +		return pci_parent_bus_reset(dev, PCI_RESET_PROBE);
> > +	}
> 
> Why not put this a little lower after the:
> 
> >
> >  	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> >  	if (rc)
> 
> ?

Hmm, the "if (probe)" was checked before pci_read_config_word, so I
kept it there. I don't quite get the reason of putting it behind.

Mind elaborating?

Thanks
Nicolin
