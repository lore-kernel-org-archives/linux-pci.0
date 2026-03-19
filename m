Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B026B973;
	Thu, 19 Mar 2026 03:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889942; cv=fail; b=WUCWgCX+0U7gx6m/ajklh0zXbAKoaqYL+tCY5HB0Dmb3hoJpdCYu4I2QOk8DdkuXOtbGwUap0esS4BNGIIYbwF3TFPi/ShSAb21cXNeRPXyQDMrSh4zh5eGRfgqw7wwdCX/4NcXbKH5kqQtj3V/FjlOrpwVPVQ22lzzh+UrpQzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889942; c=relaxed/simple;
	bh=alakPnRh4N6gdoxNMKotcyX5ShRwhSaFfs+3gQrwZGQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVj0wUzXInpvLHdeW+Q9Rz+KoMuNx0E2AIg0F/d9VqkP8TXVyBgOPG+cVEIp0hHz1XqnJznal+EmUpE88GwoEI0Aobw4vMipd+F17MYLFSdCr2jLlm4JCTUabGQKc5BJHC+ZiRcR9nCZYakqUt8y+z1Rx89pq6ZxUcGn9Pg5NtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U6aii2Sa; arc=fail smtp.client-ip=52.101.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U6aii2Sa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icWYahC5ryU5rUJd6CzKtD+hE3nP0DipsX1znYKNvMaH6nbnfTL4y8CZg7trWiWA1Pd7x7a8ctP4u99S7fWvPtNDIv3JRMcOiVqz6JPuoSy2XFyHGw2FLSG0NbXPpG+hbzKgUTpTE6pzt4unubguJGwSz+OP3tLKHv/eWzM17Aa28VIWbHq7UUdrf9rcIt4XJ8NXoKvH/xu5IBDFoKMLa4NkFhojKL3L+ZplDEaBrWrG4OzJtLFROUYlGfScTtaBfgcgZnSdQneIyxZDB17Jhg+YDqvCTNihNIUxtcc+wiGWluJzjPzf/BdWIs7W216rb+eu2q6s/MGlof+RtEAITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I13Gd7PEHEqG/Ej+WsF/RHqXY/kYlcQC8tKicR26dbg=;
 b=nvY3132GyAS5RZGf2SgeF1fzDAFUWidGd7MGG2bFMBOPYE3t/rEb95iq/yIPDC0FZYoT1262NTOb3QqKg/J+DuT0lBfp8SJmIUwN1645ggyx4kKb6NmeD21BNZAU4gnwDBAMOlV5GBLv0K5efyPar8L52LayPOX7hDj1620F/RRhtrVslZrBmsUUmogdZVRiMZaU+36XEd2QYqXXa3TAdTMeiCdAXc1lc+MKrQuhVVfGJphZ4GENlMw6Fk01WtgmbVvugNnHPEGxz72is5m2i3UpSmZUtSCNvaeQouX2B2CqrLHwX5peWWrRB9HIiK8WHTAJLSbyKMC786xEMb5ulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I13Gd7PEHEqG/Ej+WsF/RHqXY/kYlcQC8tKicR26dbg=;
 b=U6aii2SaGfwe4sjj+BzfPSkYkCkSzJLEcaM9MpCvcc+O9WntGQ33Ie7FUL73+kycsmaawH4B9BlhOhH6ikK/0+kUNbU+DIkJ/dfjbJDV1jPk7RRSKH0gGC8ZGSL9ZocCyQiS1x2TM1nFU3H6B8GM9oPiKMckvSvjB1kFkuJTavOqTDia2AsQqSNjV9/C3NaLRzlhPFINszmxMFwGAWqBJ3YoLvabhmHPCMNZHCRxAX3T1gqW/iZGriYNu7EY+y9M6g94sFTQ1VI6F016il6l3gmMr8E590yu/ieZOVOPwQyo3hVS71UDGEwCouJmiBMTmzrQlSXOWYHea/my9H5Rmw==
Received: from SN6PR04CA0085.namprd04.prod.outlook.com (2603:10b6:805:f2::26)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 03:12:15 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::ab) by SN6PR04CA0085.outlook.office365.com
 (2603:10b6:805:f2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 03:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 03:12:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 20:12:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 18 Mar 2026 20:12:06 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 20:12:05 -0700
Date: Wed, 18 Mar 2026 20:12:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Samiullah Khawaja <skhawaja@google.com>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "praan@google.com"
	<praan@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Message-ID: <abtphBuLiXxSxmAy@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52763AB181F5213FAAB4F4F08C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abr8aS/MDU9aeKu9@Asurada-Nvidia>
 <absaKimeI_TXXxuu@google.com>
 <BN9PR11MB5276467C1933E19E98277D378C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276467C1933E19E98277D378C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: c6dbc8a8-e36e-4f77-164d-08de85655275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+jtMb3wlPLQ/6FJjUWz4cU7EmIzoqK/j5xXvKKLhCN0wY3VLtvhH79QaRVX/A2WWapTH8S0KGMaYeiILzkvyEapt2XO41NNiygxt1mfFJTYvIZ9EGowgcwcgmB1N8GSbdG8VUTRnnba7k3XmKIj57mkfRSwqmbxW8M0wyBMGAIJmYiNWKaFVGjPFTYhxw3usBWHRiC91/VE5oQ+eZJ97F6crHbRnb+HfruKNup7K+2KS5Dkt579lwo8yJq6Kl12woeWEt7r3/doA9w/NuHd9upPHYJ7Yg8YaeIUnXkQ08OLF9b+ZRmshZm80FtQQyMsKLTzW9jz9eyIueQ8AvWmBDOhcSo+WFvoSgrmaq+rQp19Rb0rJDNTNyPPSIYDQVdZjXXU2MhcNsqr22iPospgjMZPp7owmkRuw98YGtdeToAMBPQwWDdj7LL8+Dc7Xl166cX0mKPpQ4e4VnsRIEJqpz4tcEX7xbnxQdFWMTfq3G/gcKC2MSpiI2Beg7h+4rwPVE9hWqQsti0p2xgnrbu0CZbk0Robfg+UEHk35UmrZ10kgCFzfAUEjJNidyjUe3sbctqwo8bF/eHrNDMnOQHgtwCGYuT5yPfBBYaTGqlM7rqpA5DxBGr946QAuvincpl9E+ZFdmKP0ECPg4RN54bEyp69+EFGKkajrJtpGldlK9/GoIbr/eVsXlXVji5rbeG7P6osJUCBp9KSY1wzED88zEJ71kQ/qFzjU9ASBRRct1g2hyXKB76PZc+dNtBHltOkLHBevV89V9wHwr5vBrW1+oA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L7h2pk0xxAj7g/xdyBKU9DPDQ/SlW47Q82ptw1cNClMJMMqiP1P8mI1hbZ70GDvXdL4e4oSdpaJggCBgzBmke/QrB9B68QYRudTyjvOS1ODxQGzuKSTXxpo4GGv58X7X/tEYBAQ94CtWrRhocND+LAwlPmCoOU6QhOAGEad6WyzfKGaabAbYUDPSPuOaPQScfV3AG9ZpuNULpAAnkgniLsiz9n9/58XnE6HKp2KMrbJ95WRXVsTwzUmQxzkdeME4c/CbKq1WMJuoNx0fw5pM4GnInpp7TpKDheYsw3VTJxSSh68BVkFfw8IEhR1/kNycz5Wgu5ZKJDjcNYq0jgWZRQ5l/PON0thHHmQLhIRa7sLDcqqQWx6RjEoph1NJxcz0V+bUrvrCL4pZPC/0YHX54kwZJJIAhCxF76FnUKs4E0kXGs0ZINFEHjHgOKojvIyL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 03:12:15.3722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dbc8a8-e36e-4f77-164d-08de85655275
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221

On Thu, Mar 19, 2026 at 03:08:05AM +0000, Tian, Kevin wrote:
> > From: Samiullah Khawaja <skhawaja@google.com>
> > Sent: Thursday, March 19, 2026 6:07 AM
> > 
> > Hi Nicolin,
> > 
> > On Wed, Mar 18, 2026 at 12:26:33PM -0700, Nicolin Chen wrote:
> > >On Wed, Mar 18, 2026 at 07:36:20AM +0000, Tian, Kevin wrote:
> > >> > From: Nicolin Chen <nicolinc@nvidia.com>
> > >> > Sent: Wednesday, March 18, 2026 3:16 AM
> > >> >
> > >> > An ATC invalidation timeout is a fatal error. While the SMMUv3
> > hardware is
> > >> > aware of the timeout via a GERROR interrupt, the driver thread issuing
> > the
> > >> > commands lacks a direct mechanism to verify whether its specific batch
> > was
> > >> > the cause or not, as polling the CMD_SYNC status doesn't natively return
> > a
> > >> > failure code, making it very difficult to coordinate per-device recovery.
> > >> >
> > >> > Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge
> > this
> > >> > gap. When the ISR detects an ATC timeout, set the bit corresponding to
> > the
> > >> > physical CMDQ index of the faulting CMD_SYNC command.
> > >> >
> > >>
> > >> It's nice to see the ability of allowing sw to identify the faulting sync
> > command
> > >> upon an ATC timeout! On VT-d it's not feasible when multiple wait
> > descriptors
> > >> (similar to CMD_SYNC) are in-fly... :/
> > >
> > >Actually SMMU doesn't know which device is faulting when CMD_SYNC
> > 
> > VT-d is able to find out the SID of the device for which the device TLB
> > invalidation timed-out occured by using the SID reported in the
> > "Invalidation Queue Error Record Register" (VT-d Specs 11.4.9.9).
> 
> yes. but when there are multiple submissions (each with a wait descriptor)
> fetched/handled by the hw and then an invalidation timeout comes, all
> pending wait descriptors will be aborted (not just the one corresponding
> to the timeout). In this case all affected submitters need to re-try.

This sounds similar to SMMU then.

Nicolin
