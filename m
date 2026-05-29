Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109137702C;
	Fri, 29 May 2026 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780091786; cv=fail; b=lz0n/qRcnnJGRAPu3ZNg+qHHg1dDEssdksPiERRflTTnUWwYxlYwuv8vle+mDKsvLd/hVnubnj6EkLSL8TN9hlJjm/Jgl6irptjVZaDvoaYcHzr2rKBayyVQ1KBLZ6OuYtd/NZpUH+GRYiK2d6lzgBmbgPuI4tGu9K6oarUEy1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780091786; c=relaxed/simple;
	bh=/k/4e/i01CIDtzpNZysA4BdQu8IgHvkI4I4XF0gkbyE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjAu403Z5RWZ6ll/B+ho8t82r26mjRp9qZyNs314Dhoq8koOweJGhwpxNZI4D3oamcSBthcz6i7K+FP0XtVBbFp79+ARKNRcLuUwJrfXzgPDQRRrR5gvxcto/EXVjWYblxVMt6nlSH36mlrDbDPWfiq9p44QVjRo5SW9c/6Qpgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=acqUVcmo; arc=fail smtp.client-ip=52.101.48.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="acqUVcmo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cd/XU/5kFi9M4lLnUEM1sgZjVEQ14zOB1RfyG73Mfyr2PjePg5ajsaSffz63Vwbpb5M7QZ0e3Sm8xsH4BQcWVryvLlp8x8qdzMJkm3L1qs4ULbu6bLyNKpMwtYyUM/kDWkBD273OTkflImSoA454w/jgP3ms9VoD1CAw5idAANUgoLeRob3trI4EFqcfBgDT+4UfikCPOjuBDTqkz+8Eup/dtxke3QCQ3oARaV0XlYeU7VOEShun8jjIndWlluL7d42H2RdS1kOuKKrVwkhBafiZuO+f8b8vzzZZmhJGok574qFXO90WKPPxdq2W/WqOTdXB6h/Kr+plva0Wmlchlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LzstVfVFPJF2BStVxIbya/bqmcvPvpGR5WZZMkTaVg=;
 b=P5O21ep4qMek+hUSQiokN28aVm6t3okNFGsoXlfBzsLj3hitEdGQCtnMdJVkqeBpAd9kmSCPbqLsn2UvBNU9QK3WGje90Ta/IY5ey+ieAnV9kVUJ0P+Fp0QK2dFBDICnCeBqL3eNZxNs/YKqO5M+QTeiqx5cIadVXkBUPMsjLhTwtsekZwCIBV1tRDW99fN7QYu2gbyD7NaJzg+tkNy54mA86rSCYHlDBn+pPPOPFjgQQvUnUR38t1XT5NP8PC5auYVWmlh1lmQrpHAwpVlH1ZrVR7z8sQVQRoJyFpaUP/qif8y/UADgZ8Iz5xPg5GX3tbWD4AfDWrmURFj6kEZNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LzstVfVFPJF2BStVxIbya/bqmcvPvpGR5WZZMkTaVg=;
 b=acqUVcmoCaBTMyKQcAnhQUP76nGmvXCYc8s9+yCa0NC83/rX57W6W2KuQ2OVqFfbW78+U0jlWkZLm79EV9SNSXMXLxdyYOTAzdbQDCjrMq3IAqGM2t+q1+y3xgTuGLAwIUpzPho5uoWr0A9RCGwEtBjgpGxvjhLLOUt/DM2wW1v2X2HP30nHcDc1zCchoQL0aQdsfSuLWux6Tb/o3Zc9NVKTdk6KUUdI8dsdx1ObCMt7kYoQ0NRSdcXdgm8vvMu3PkkKLJFitwHblC+qIKz4/coREXjTMDkVpLTefwduFgsjisgTtdjBd38+y/2yyVDAwzROr73QUiDGoD11mFNBdg==
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 29 May
 2026 21:56:20 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::52) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 21:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 21:56:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 14:56:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 14:56:03 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 29 May 2026 14:56:02 -0700
Date: Fri, 29 May 2026 14:56:01 -0700
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
	<pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 3/6] PCI/ATS: Mandate checking pci_ats_supported()
 before pci_prepare_ats()
Message-ID: <ahoLccjQvmoE90sx@Asurada-Nvidia>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-4-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529111208.387412-4-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dfbdc1-590f-4fd6-c38c-08debdcd1e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/dFEskHw6LdU2z7TE3XLMHDf/xOzcaM+h+D2PXl6QLJfyzOxT5yQFrlMojw0hZ+IB4arfXqHCCbLR8OIo2bA/UVU54CnS0FR5pQPKQamKPleZLkG1+GWNT4Rld1Y8osux3yFT3vlhlr684XNmuwEMr9xk6rNiX8ELKxTsY6X3E1rU9bKXVavKUBO84zq49ZAn0rI54oI4uBnl4hJRQHbowwInuvVmg1yz3trAVV70cFcxVmwlSP699clpS4Pv0QI3hSNy1s+EluiM5w5xfrSnOZEyjKWUgVIBvkbRznkJUbAE3ebpoMQw7f6plTq2Nmdps7JUhvuKDbv5KD9aYbJqaKsRJ5J5K1aKVrhgfP3wbP91kXi0BfBV1UaZhxcRtfOJNeVcNtWauGqTnpa2mIZWHujHEoLUVBKAElt921Vw5cpIdGrkCa1r/LUMHT5QVMphohA3Tl3IbcmRoiktN7f4M2le35yCLFN44BkrzAKh/jFJDpdV8iqRMZyaisS4deJr0XriJk7Zi8Xbq3IlMa1pAYz+w5+rFBZzhe46myvbhdC4p4WkJW3WgUh3n6SH/DHb+2NFnEJRHAUAJUzhmeNfeg4sOrxoSwsR8i0IyuESeZAKvIhsOu8fbOYEw7vyA4gV/CCo9oO1GBE9yZ7lKp8+mwxHLrfcOe9yoL1OHP6QpefNgusUJLBiuKG7gQ654mWZas2YVT4TILvaI7W5JHTwXoHmNYnuxt9P5eMdAdaa5E=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FSfUpskq3rncaLWA/ngOCS/C4XAXyBkfzMBPFddhU6jrPiTpC97IDqkMtIR5rJ58zD1+b+XinCNYpdKPF/iSaSez106psNBaL9Yhg/pGPk4HRJY+gUs2cUJ4QfNM6eab8mUizfSoALoL/bj6GK47WdfZip2ZNeeiMuf6P1IWH0+9s68PjTyAxfY+6+i/kuAh01MVV0jSiy6CJDIZNb7H8PcaDBeYPYpHx63lo3rRe5bGYRRJxXt5aHPdf3XvclzL4+u2PWDJZG7CBQY8YbI6w4iulT1jRxkuqizHFEj8TpdMLp38YGtPZCdub7pzRttTX4esZgqAw+DdJ7AQpHRM7LU6xE2srVW3Ze4jHsN4YhkeJAzJxm9yx4GoSRh/1KSOqSUHMX7LHw2icHi87GIJ7vrB8WtZlqHAy1QG7H3Q1k+vppeSTrLeHzzsJCjC9UhX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 21:56:20.2953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dfbdc1-590f-4fd6-c38c-08debdcd1e0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782

On Fri, May 29, 2026 at 11:12:05AM +0000, Pranjal Shrivastava wrote:
> Currently, pci_prepare_ats() internally calls pci_ats_supported() and
> returns -EINVAL if the device does not support ATS. While this provides
> a silent safety check, it conflates support detection with configuration.
> 
> Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
> a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
> the function supports ATS.
> 
> Update the function documentation to mention that callers must verify
> ATS support (via pci_ats_supported()) before calling pci_prepare_ats().
> 
> Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko pointed out a bisect issue. So, you might want to reorder
a bit. The patch itself looks good to me.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
