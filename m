Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C9290DBB;
	Mon, 25 May 2026 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738423; cv=fail; b=IGnfZ4trWq5OS4/5QVg0NtzPzw4420WRGX+WPJMNKu1FFdnKKZk6E0Cm6qzcfjG5YZKRT5XclCfeYkPmg11Gtq+8zyMPyfA6SdosbLGdFkHW3p9E4cSY7EfDMiJijgB1wK6vEzCF0Bx14aUJaAypkYdpEToped2mzAoAN3ocYz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738423; c=relaxed/simple;
	bh=bgjuzccsbL9uzHBNl0xIPZ65kE3Kv3d09MEgI5fdfik=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP4EmStC+9qVOuHMluUoxEdKBPALsRtmQrVBcbnUTkI7QjD56aGu+Uvur7o/NDQFnFLiMO9UUcJN913nRTXl8ysz79/NUfXHK1mH/uWgt6rodbzO7pfVngiCj3wig0eZLKH5t1fyA25xfsQlQJOdW1pt86LhTgU5ta4hc9rM1dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XkETIIR3; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XkETIIR3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOm7p6kb2rWw8DWPlWjTdM7QA+TcqsJfiRA2Wro5gRhfSspCDH+5ZsI247kIK79I5DhoonuYvqQzZ8IrsUByTRYxNztSxuctbbgwUVKUVQ4yKEat/R1M4CqqiKnZyjbRqrZt/HYjghN8fnewErvioAaDdEHxWxsVD1vY+CLiap173XBPke9kIcEl0LnlQMgrmi2ecUnNu+CHaoufcNRLR2f0Dbjmx4DBpqgqnMbf4wy2b4ki9Q+MsWPleNj1+lP05LUWFRygEsFYOhFswn52wBLGZ5RVeibYwmf1ozfn+HKjo4wrGQOngkjJWdvz6pjmvNk5TwVpI6taipVTIGZ/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UnIgGOT1LSYNrYONi3I1KMllLugz4ZLItU3JkFbBWg=;
 b=fO5/Y5ZZf7q9qknt3Ao3UkvzdaneypToci2Q/O87CSkmaXU/3q4oVVibTynh4bgnc0GAjFB4uFrPCDP43X9J7ysxF5f9x4UiMytJscLLFJIeyUZbJoMrvCeWCGYhyye774TQNLRDDRxciwgp22/lCILieZJLuMdbG3skaFHRGfutjOGQeoTLxZnnJwpu3Yi3JG97zCeXagGvtI4JHCkqDDaTDZIhHArn8ge/MxUTZL4Z4PZ3ZvSaYOIIHlZbHL9Bg97nsI+MoQhfd3HJ6hDHlFGmdNpwj7X4BeNdvgM/8XhU47dhcGbH+fUvaGsKN5PA2Q7KMEj5m4naNSPPMbEGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UnIgGOT1LSYNrYONi3I1KMllLugz4ZLItU3JkFbBWg=;
 b=XkETIIR3qvfoDtNcj8Tcj/5JhmqhPAmvk0yjrDmc1lDrlpPm9x4FOL3RYXZf4sMC6OQMRM1LNjfMGSUuQyVUfwO0B6n5MkDexzuQVkkWKeyKJQghqvA4eJs2RhA34UUp1PCZYKvwIfuOJag8KHa8ns8FEzdl8QMmuDPriAzwFaksbxOcF+yhWdQy2M0DwyHpmrnmyhMXtbehupJvvOWDGUD7Vl1cmTGZQgytlFRZNTDphif6aQs7GpVrvrE96U9YJVF93rxpEqyrirMG/be/VP6u2lAoZoHwv0XAiD3Db6istjyoqXCDZObfDtL2czf9E5i4nVdaq4vRdTVerMTBQg==
Received: from BN0PR04CA0127.namprd04.prod.outlook.com (2603:10b6:408:ed::12)
 by SA1PR12MB9547.namprd12.prod.outlook.com (2603:10b6:806:45a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 19:46:58 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::6c) by BN0PR04CA0127.outlook.office365.com
 (2603:10b6:408:ed::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 19:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 25 May 2026 19:46:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 12:46:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 25 May 2026 12:46:56 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 12:46:55 -0700
Date: Mon, 25 May 2026 12:46:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, Lu
 Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
	"Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, David Matlack <dmatlack@google.com>, Samiullah Khawaja
	<skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/5] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
Message-ID: <ahSnLeKchpPbz1m9@Asurada-Nvidia>
References: <20260525184347.4059549-1-praan@google.com>
 <20260525184347.4059549-3-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260525184347.4059549-3-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|SA1PR12MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: c476e18e-c8ef-4793-8a10-08deba9661bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003|4143699003|6133799003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	xRRYuswypn6mGV0w7jtKGCdfqqpoP40zb3f9+tQ5C0fSxsT8JOw+1dyx6IQ2/yK88rbVoh0egKS5awwH9gbP39w4ms0Vb8Agd0vgAO54IBOBg0ibQhMxhXUKp6UdFqQC29Q24KBAw8EahjmOrX5DQ/+8vlE0QsBTdVDcdWLBNj2ItGaGNLNLbnD/RTc4c4Rvhiub9qkJrtKaYIELubvotJjI8SvrTJmr2Zq3TFAcGVWQjoIswSH3E2j/EEgvK2R+kh8nb/rnQVPRGHeZSuNPPP1wGQ+sIORvvm/EZQSbg9RQ9084yqxCzznML/DO0y71npSKjHP81Me/PmcOh13315s7m34d3+H5gVxk87Pxdl6l5/CIpZAVf0rAgP5VOwyKC9QrSgypzXplr9HKC+UvZMOOKZ/TPiZp9nJeu4fjjBbfR1IWgbozawsp26XPMt4tq+zinytlJPzs6zgyV8j4rCQSG64Kxz82Jpw11SBVf+oZiweVpoom1OT3H/DMSLkDBUfq3AM8IVYFVxtqTHePnZBQNEe+R4ULyvA8drorSn6Mqyhq/1aKTWlfG+mQA8Lz1tkXfBbs0GXmCvNq8Aw0GNDbMNXp9qa0wvpqist8FGC4nZIWG8JJqL18E4e3qbx86yDlSUFkzkBxE7OE/CGglusuq+BDa16r8Cmn9aijuaBin9y2WH1fEQdcH1gZSh2OR7+nJYtwJh5Af6r21su4hylwSGGNtkfw4kM0J2BwesA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003)(4143699003)(6133799003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zy+hf/mmKIWK71O2GndOGd8B8V1kKR83X6veL6B+Zet38capcac1sP1FzWe4RxBW1xAUm37dIYddffD7KgfF/w/puv12DGOSGkrcaT2UbhDIlm9EJQ82JlCpP+8bDUg6wjEzjB/O2dF6IW1wNlUFoqsG8R1hap7wwrLjet9XimQh9OXf6zfU4xAS6RPr8HSeqfWN6Uov7f1QVsWQQfSTls4ZT5H4puJlxlGbCkW7tPB0q70eMoH0FsTbvGnIpoZfoCQ1A0RtOkXn3BOgrf6LhmdTKrENSKPLThStt3OiMAQ27OgNv69vsvbLoKRIH3SMkX0MCVdwqs5j1bA6BhfJuRKROkMZo1cf9lERRLrrJBgoXo/jyqLwOTCEdU+4CXRz8Nhm87fkqe+nhDt2QiDVpibRz7TjQPgKcoOvjUKOzRMc+sS3xRNx7VyU4ws7oMJm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 19:46:57.8816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c476e18e-c8ef-4793-8a10-08deba9661bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9547

On Mon, May 25, 2026 at 06:43:44PM +0000, Pranjal Shrivastava wrote:
> While every PCI Function that implements ATS has an independent ATS
> Extended Capability structure with a Read/Write Smallest Translation
> Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
> driver to configure the STU on the Physical Function (PF) before any
> any Virtual Functions (VFs) are created.
> 
> Currently, pci_prepare_ats() bails out early for VFs, assuming that the
> PF has already been correctly prepared. However, this creates a potential
> mismatch if a VF is subsequently prepared with a different page shift.
> 
> Update pci_prepare_ats() to validate that the requested page shift (ps)
> matches the STU already configured in the associated PF. This ensures
> early detection of incompatible configurations and maintains the kernel's
> policy of consistent STU sizing across all functions associated with a
> given SMMU.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Nit:

> @@ -73,8 +73,13 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
>  	if (ps < PCI_ATS_MIN_STU)
>  		return -EINVAL;
>  
> -	if (dev->is_virtfn)
> +	if (dev->is_virtfn) {
> +		struct pci_dev *pdev = pci_physfn(dev);
> +
> +		if (pdev->ats_stu != ps)
> +			return -EINVAL;
>  		return 0;
> +	}

pdev doesn't seem useful. Dropping it reads better to me:
		if (pci_physfn(dev)->ats_stu != ps)
			return -EINVAL;

Nicolin
