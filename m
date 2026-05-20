Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5112D879E;
	Wed, 20 May 2026 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298213; cv=fail; b=Xd9X8qzI/q+mf9pyfcR1skocJTgMEEGVIRtPvXAG8E4M8ee1sQRWq9/ZHjMq0k/bFNrt2Ta8JaTogDhMyr03YM8PmE93wegNB7gMgfzASAnHUyjqpcehVim50q08nSu+vNZFNrw9J2F6J7ijoCqU6mbVVpVbl/IqdcUtIKn4p+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298213; c=relaxed/simple;
	bh=b2siDePBSc6le5XhWTMvAg8yTxyTMdQayaYUx6dfFLo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aExavKTU6FxFoEXy4JAT0Y7sddgPmNZRNBS6e8WK/dGfEk41ROimZJKu8gNHyQ7D3qwkTLbl1pwGEtBtBXswZx7qQ9w0ryYlAl5yLBB7GYgpAcWvT25kJR8irhMdLxxDi3HleHZK2riwYCBFBOXeCEEsyf25QK9F3wvR+xEjKFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BdZLG40t; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BdZLG40t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3Y1z+TIZvB2EuUjh79hhMvEYg9FH6TH4AcHECjw340Yo7vHgOW+s0XkAxXvxCy0b2ZIDLdw5GARK5axCMpR7aGQB3jQu5H+2c06kLNtiBDAplpmB2TENZTPZWIFkgqigoU4E7KTGo14b/DtQShn8u8Itcsarn9TSynj5x6M07YEeVNrPstytzAR3/wvsIJutV+dEvm4zS59oVSNmpqGNQvPXfqGJVTGO/HAlOQIbJdw4gYt9yy5u9a5xjbYkNnNdRvZ/5dxtCsE6WcvQ2uDEVClmDqRUJJug1c1oGMirCSsbQyTrf6CIdkJWjwVFDhujE19fgdbG49FGsvWUfCRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI8jNCUf9B9U0epExXJu+9SNXg6fk8RxeSeYmC2sWxw=;
 b=P5wrGoBJZP06cUuFJpUgK8Q4Uhm53U4xreno/+1Adi4DGZvcQAmV6zyoeKnWgtwIpGiQ2AVX0PrfEFNIHhFpO0C3qmn+p0nO2VzbfPbY0Vl9wyjTmnpkqH5rSpWGmq37z2R4qgU/TkYQRUahjAtAoKSia5f1IF85AmtDZMvx7lh3pCAT5dsaIomGpH4FDw9s05QXmMtxfbJ4yGfUn+vmQfED4sLIIg/SOooenhnEDWaFPZ92e9Xouta8+BDs8Sb5XZvtt8XkL7l2EIXJBQuIAFHZGLNjnF8iGYiI8jLw9o0jZjbz/x+xZGP76glKNVgLAcjbmPvHfZLSWYJ6pkmlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI8jNCUf9B9U0epExXJu+9SNXg6fk8RxeSeYmC2sWxw=;
 b=BdZLG40t9Iq5S3SVdEDIc9FWL8W26eX5ZbS489Lrzk2Z3/EQjlDbkAxfOC8cm2nkECTG/39KE0E/ZJrCRwcYEZHE202kkMq0ATz5ZunzbHHyR/j3seGhdgU1QOj2JmHsNoepfT3dmC51FaZ1b3Mlq4ZAJY4S8leQvGYpjc1WXwOvyK2pb05ZibWd0Lb89xnqwMulJGgDzJI7/tgYNFPewu6fnSH1lHyMYA/iD7/cjJA0OA84cC9RR58+wWq1LWE8qpiSY1mzda38GF1xqvLQ0esQdbToPy5i4aKmz9lXp6bnrsfjhP7NIiq8Oqj+xOZSJOOKt/c0dv54UXT1epNehw==
Received: from CH2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:4e::18)
 by CH3PR12MB7594.namprd12.prod.outlook.com (2603:10b6:610:140::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 17:29:38 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::ae) by CH2PR02CA0008.outlook.office365.com
 (2603:10b6:610:4e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 17:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 17:29:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 10:29:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 10:29:21 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 10:29:20 -0700
Date: Wed, 20 May 2026 10:29:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>, <joro@8bytes.org>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <ag3vb4SWIfuw++vp@Asurada-Nvidia>
References: <20260519222335.GK3602937@nvidia.com>
 <20260519234801.GA21369@bhelgaas>
 <20260520000504.GQ3602937@nvidia.com>
 <ag0IkpcWvhQUfzf7@Asurada-Nvidia>
 <20260520142043.GT3602937@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520142043.GT3602937@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|CH3PR12MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 7faf40c4-f505-4a70-4eed-08deb6955d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|82310400026|376014|18002099003|22082099003|56012099003|5023799004|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	MYZ6vUAwTVFrNX8Fc/CNBYU2p1EPNX5RW4zTUj710y07xYztCbMZjkP0lFWrqkR4WUHoWYIcTFq8t+Xa17yxeQMdwItv/kZuX7jD/u36pYI8lbb+8gIZF5nMd0lCbm3Q1+5VgCcMBJ1hMg7lxJJ+cliK6vugmc6MBoJOKGV4q/drVi2+F/lRiQWGUVer+W1s2qHroLg9O6Yc5MXlUkYolCvhNHR9FZLLnlJGc9K1nIPfFQmgQmI7cvGeUBW6Abh9xzET0xCwU674tJGv4V29DBbVs+IM1WJ07nemSdfA4lHz9ExItn9iOnZgYK/g5qr3WsWKQErAwC+CQwWXfF94u/1E64hFbODVTPLFDux0DiWqR/Ml0MXNQjsjQqsOQy3ADBQJDA/eC/ylO/jz6fZfmLLEI2NMHDI9MC3rXFLfSC4s0Y3pQDCZNI8YY0I9CU6/SIAGqLvKsFsdHGCMDQVjwl0vSfsP5sv9m/IaZdyykOx5h0oWB+pfpKaR4CeGSxiQCkI5jX3RdAgk+g/gH314fY3Fj0Upd1IqljBnMFjYYsWmhm9jRqjxGYv95Oo27NZkCvNct7aefYNFwKSjLOXGx/SvsiKYQO4jIdd8Iq2opnUSy30edIVb8Omo5EwQbkEh+1SY7wec4h0EPQmrS7negM9z8+5L7ojt8raAc/SlnBbPbKndtYAH+QTcVwDItKbZt9dyf5cvsOMUocV/IbfI6gYnA6jK4OsND5G/sioahmw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(82310400026)(376014)(18002099003)(22082099003)(56012099003)(5023799004)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RiO5myyfoAj4dwRZwjqLKmXPKU5hHER85jdkhnWP0/dl4l8wIUuVsDABDN0xG2mnx2HhhNfcMjBGVDru+lbkoaid1pyqsZltgTtzOWeMRLEdDSnVgvFxGflZ8V6sAoCIbKOBOUHNcBp7gialX6fiBoQkMnTwjwBZf9Wq3OVT3mYW3nDp3MN7qEIGohlen/LrpC4idzmUD9JZp7/m5bLzyWfhEZSd0Z3mdK48duTVlgwNX4jMrq6VuYLbdXHg8OFKQjOlQt3oBvtpOcYSJLROmjapo08mexWDLKNSoseT8PgZ4K/gAmz+/GRFE7s7uu9Lt6CAElcNg1e3prz1atHG/30kIbLo31V5fGcMwQL7v4+rpJDIjiDusC2tWKcLqu7tlVnfLwn6Nb/fKCInLcaBFPEhAR/TYdSl3kdtzwiEylQF2PHF5ar5osjlSOyxSZj6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:29:36.6373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7faf40c4-f505-4a70-4eed-08deb6955d7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7594

On Wed, May 20, 2026 at 11:20:43AM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 06:04:18PM -0700, Nicolin Chen wrote:
> 
> > > Yeah, that's fair, so let's rename it to 
> > > 
> > > pci_translated_required()
> > > 
> > > ie the device requires translated requests to function. This is what
> > > CXL.cache implies (IIRC I was told the spec specifically says this)
> > > 
> > > Requiring translated requests implies you have to enable ATS in the
> > > system.
> > 
> > Perhaps we could let IOMMU drivers check:
> >   pci_cxl_is_cache_capable() || pci_dev_specific_is_pre_cxl()
> > directly?
> 
> I'd rather have a single function.

OK. Can we use pci_ats_required()?

CXL spec explicitly used "ATS" when stating the requirement of
CXL.cache). And it'd fit into the existing pci_ats_ functions.

Nicolin
