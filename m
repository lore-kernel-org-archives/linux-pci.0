Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BD1DE8BE;
	Mon, 26 Jan 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451731; cv=fail; b=Wx2PnETeXwo7z1Yp3wZbxw7qSly4AyX7LoPi16vI91gcgANW5BPQ6danGdeXE6OiL8REOkXsP9P4nr/PSk4aTlZZ99NgwTs6QshOqjZI4VN0cmgXBseTimD1eeGJnOV0buLOQERvaCAPnchhTESlsjwkCvS3Mh6/0/uZq1ZBAEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451731; c=relaxed/simple;
	bh=CSN3LUy0r0Ut7F3NaeDWTAoEDH64O9h5QXyIm6vxk/w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot7EeBvIjY3VS97V+nsrGCW8RgsDDNHCVimwPSKGvwhorFTNYvXO9MGullIywb+j9ryU2Y/J3MWPHJJmWz33tLHHFxNqcMEF8lo2duERAqYcT1YPvqEsfVCHx+Lq5l9Sga2Jw6fKskFjTAYH9HZTE2MFy9vKLEikbp/Jkx+VZw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y/5m7Q/U; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y/5m7Q/U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr0M9DgII7JPFBwsxNwU7ocgXcz6q/i9Hkuh1SlM/slV+awdzj0I3CpkP521sw3CRBv9P9hWo7Q9KXOWITUB4EngTAo32MBKdc8jI3BtJ/tyOPzOrUTi77DQopR88d9zB2HFM2Rbl4Q7oIu3Y7XBpIxfldonwJ+zaH4rAgLh1NWKCPoMJtxilT9eaHbKvLSh0WAV9KiwhX+vIBB4NsDOvtIGtDzgKFmxBu6WPiixbybOKAnrzMnZ67+HUl6T8R4iaGBC+0Tysu+Il7Qio1qk8w3QRJGjv/wysJ2XIFptQ7LyisGp1sEML8fm/wBw3jNxcqXduXNkTiyr/MHTwpLkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptwgaIQvzipYZQV+lQpJ6WlEyaDu+fpIbY2a832Jmd8=;
 b=FdMnsvl9hBxGbjUQ8oVDIU5hkXuIzvrBl+bCqoGN+4M1FsO4BA2saXBMjsAiDMM8R8Is0K8kEdEf3hRkhGqwHamuN28EawuvXmSml/JLF14psGz7ozayD+/sthtjd4lSv4OBo+uXCZ2bCFDrSK64ILQru5R4Dwi1TBSdH8QKgSgUxYi8bP6hvLnu2685QaYOAT+WvGyaU95PHRQPTdyjZBaLrolghQne4RCOZ+73aoNR0WL0+8f6bdvWPcfqUgyNQHq/REZaSUw9TvsLI/GWPwzflYQsn7FlVr/gSsnwBSCcD2SFD4ot5J3uOWNjIE9kJ/MeMS7IuaekcoaATt9PVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptwgaIQvzipYZQV+lQpJ6WlEyaDu+fpIbY2a832Jmd8=;
 b=Y/5m7Q/Uw1u+xUS9fLlvIy6h9XNQjTzxu+jPeR7yXFYeD91PbWSJMSkDkRS6rjU6CLLqau5lb5c0ofkRwGDLnAPTDZmQWmdD8LaQwHk20F7Llwf2yRYGrJx8pQmX7muJ5uI/5N9sE4CeDTO4VZede3YtCuP3Bw3B0ysSxPX8VlkYoO/XQcGxMjoRLQ/dTHNDwk0TgramzSqNboyGNOijnP+pABcJyrDUokJcKqjZoEc4R6le+GeIGPAY64WIQIsj3Zq1BdN2GjYW1DnvWHx8ESKQKW2YfsZT4HlYorHWdrjB1SaIsNzWiBH8RebpMbkrUIMQpD78iSxqUvc5sj0sPw==
Received: from SJ0PR05CA0130.namprd05.prod.outlook.com (2603:10b6:a03:33d::15)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 18:22:05 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::33) by SJ0PR05CA0130.outlook.office365.com
 (2603:10b6:a03:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 18:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 18:21:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 10:21:28 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 10:21:28 -0800
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 10:21:27 -0800
Date: Mon, 26 Jan 2026 10:21:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <jgg@nvidia.com>, <robin.murphy@arm.com>, <bhelgaas@google.com>,
	<joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFCv1 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <aXewprV/zHKQ+ra+@Asurada-Nvidia>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <09cb6be1f8f7472a2f1ccab72154cc6e22cf570b.1768624181.git.nicolinc@nvidia.com>
 <aXdgljWHHPVMTmya@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXdgljWHHPVMTmya@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: ce96487a-878d-42c9-cd85-08de5d07ca2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgIfcVYkR1ODDX3xeeRl4al0cMr/9uoHNqxGYGPQMqtrSjRhCINONs4NR4YZ?=
 =?us-ascii?Q?N1PJHU8aWEMVP7pzMwJzKJcZr+M3r4xw+mHvjz5jhZEi1l6/IrRN1axeiIsG?=
 =?us-ascii?Q?HJjgR3IAoaKqkDj7J307FG14lgxCPR1N+6dRCIPNlZu4Bidc5G7fyEXWNm15?=
 =?us-ascii?Q?HBgvMwY2vKDSMEgZ5qR/C/IOm37aL4DXOI8oY1YchCO3IjiVolHYPflZFMjh?=
 =?us-ascii?Q?McBlnZ0Gf9R0X/4kt1eRZaQWSeyjGVqRh9QgUnVEcb2zmlN4aeO9kRmwJbmz?=
 =?us-ascii?Q?w9v/gfNBFyCHeGBPI4sEChmXo6mgm7KzIaMZcdCZZKg+ImqVePoE0DXtM+fB?=
 =?us-ascii?Q?paNaP1MIcJJ1zqzlFHZ/Ua3QqZ3P3TM/h5sgRY0tpGUdhs6OKqwaZXPSz/oD?=
 =?us-ascii?Q?WPUCqFLKNEWjFJSrXgWLlPtJtL3SPGwYomuVhuAFXiaFbKCeoBteGAvV+lIA?=
 =?us-ascii?Q?g13hgACtEXeoZKeArxBMiZAFwDRZ5EeeXTWzxJPDUQGPPbqb+T/BbMPbBHem?=
 =?us-ascii?Q?Xq0RxQhskLzXZdePrJsGyudXsOJMyLROqcq//YHeq+pANyRK9k7RYcqXug/X?=
 =?us-ascii?Q?gNX+LitGnLAxTz1JfLbBO9l/bieN1lXi3jwqY0QBBZ538oNxZ+G5igTNWRSj?=
 =?us-ascii?Q?zC5m5oKZXupe68PkwsJg4RFq8SfbmgNF+IT6NO+HMzhoiLBXDh2HbZy3MwzT?=
 =?us-ascii?Q?q6XjEUsR9VKtSuWztg9JA9edyLicmosjw4rA8pgAIFgKMeOF1+5qF6zSqsO2?=
 =?us-ascii?Q?xII95u/GKdPHQEWLLXRXRe/0jhkOs2z5PqWYMaV29RbAL6p0bsszrQUk0Tu4?=
 =?us-ascii?Q?GnVP9jraaNRAG3mmfr0g4J0dr47wZP8s3nFHW/LrM/D6svKzViNyTvwb6mU2?=
 =?us-ascii?Q?n1UpQh/IuC9ACvBqJymJjyZB5APKUeOHrt7s0ZcolwzjsgkYqusAmcMMmXQ4?=
 =?us-ascii?Q?VQxJom7+/3uQ21hD7hB/ibYsWQWd+6uo5oGCSNURxGOpCryGoDkWj21OAaP1?=
 =?us-ascii?Q?OKZA28BEmi/VpSQa22AJZf0WbQcUIjBzscxdPipOCpQvy8PindPKnL9M7KaJ?=
 =?us-ascii?Q?An5BlbSGX/Rcmlw0kFpdrfCgry4lXZuFV6CK2qS+2gXAVIZre93cvqiLstSO?=
 =?us-ascii?Q?6o/QTyIHvSpQoZGa0ZiNxqwFmdLfwhCP6ZkriQnA0VSAAjwtpxMCk7UAhFpS?=
 =?us-ascii?Q?qUwfBJY1Osol4+S2deU5vsHL4TaD2LbrktySOWa6KPArvij0vTLRQxSIgsXS?=
 =?us-ascii?Q?KL1t0JxIi0IbBNEPHGRoQKw+D6J9ewaTBu+Unn6KP1Ty822xTIo1ZuLMDxUZ?=
 =?us-ascii?Q?q657hj/yI4O8dzyWF8JXRT9bq45XX1V2dvLbY0RYzlm3xZHSMpzgRUQBRlsZ?=
 =?us-ascii?Q?FEjdLpoCQ8gbEmKLYvQYzK/dsZdlu1o5h60t7p9fZcg9Y3ib0uR8w8c+0l7f?=
 =?us-ascii?Q?zKysPhyx907duqlaWUVi+mBpbjMBlgbOu8nE+YZMMovIwByzCjW2sPPrXv6b?=
 =?us-ascii?Q?Emi5dEDUzFttt8IcqQLTT02InGQFeNB0fIYJB6L4oSEqzyYMVS0kgqBaY/0l?=
 =?us-ascii?Q?VSSHnk3AK24YhjdysCx5N22hboTpeq5UBFRWE6P29XnC9upOIgpUfMXVjAR2?=
 =?us-ascii?Q?qWWCbXt7lHJb0/Q5CGiFYXs9UtLuzsZP0FzHg/Bm9aFKh6J+r1ICyvCIaqxU?=
 =?us-ascii?Q?GRqSFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 18:21:57.0389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce96487a-878d-42c9-cd85-08de5d07ca2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915

On Mon, Jan 26, 2026 at 12:39:50PM +0000, Will Deacon wrote:
> On Fri, Jan 16, 2026 at 08:56:42PM -0800, Nicolin Chen wrote:
> > @@ -1422,7 +1422,7 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
> >  	if (!arm_smmu_cdtab_allocated(&master->cd_table))
> >  		return;
> >  	cdptr = arm_smmu_get_cd_ptr(master, ssid);
> > -	if (WARN_ON(!cdptr))
> > +	if (!cdptr)
> >  		return;
> 
> Should we still warn if !master->ats_always_on?

Hmm, yes. I'll fix this.

> > @@ -3205,7 +3222,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
> >  				    struct iommu_domain *old_domain,
> >  				    struct device *dev,
> >  				    struct arm_smmu_ste *ste,
> > -				    unsigned int s1dss)
> > +				    unsigned int s1dss, bool ats_always_on)
> >  {
> >  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> 
> Can we avoid the 'bool' parameter if possible, please? They tend to make the
> callsites pretty horrible to read and you're already passing the 'struct
> device *' so you should have the master in hand?

Trying to set ats_always_on=false for blocked domain here:

@@ -3260,7 +3277,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
	arm_smmu_attach_dev_ste(domain, old_domain, dev, &ste,
				STRTAB_STE_1_S1DSS_BYPASS,
				master->ats_always_on);
@@ -3283,7 +3301,7 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
	arm_smmu_attach_dev_ste(domain, old_domain, dev, &ste,
				STRTAB_STE_1_S1DSS_TERMINATE, false);

But I think we could do that by combining master->ats_always_on
with the s1dss. I will drop the "bool".

Thanks
Nicolin
