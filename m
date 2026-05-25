Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963D315A864;
	Mon, 25 May 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741637; cv=fail; b=alYckliisDjUg6Jnshn9+AddS/HlC1J07sj1F2/cZMY238IfZ9jQrH/RfwyebGET7xRxzDZNXyKtvDSXqHydYJII0CGsWrdHaQxWswxq33A2glXLx2uPvL48jiqiwUun+CEILz9tKP6/tBeUeFfC/KtB1UC4Pm3iahEvSXiZw1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741637; c=relaxed/simple;
	bh=t8G3f/qvdDQUaCv9iBqMONQ/EwtzPE3CNpjTVKUUGXA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhzNQjCbXNvWZZMX7NTmRt7BVWPDtIdJ6Pk+nD77NxHAlD+JFKuycqy8RD+dAhkxnHENM47qmq3UNcDW+dfJL4vKH5FPwOEUNX19RIppL9Oycys6RjvXMnHupJw+wdbt9EZIsLEFrHo4+x6zAMiC29FV6TGS+eB/e/4sg7WvS1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fk76d8oU; arc=fail smtp.client-ip=52.101.57.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fk76d8oU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhsXx1XV0HC0kZd0jo4U0Aa5zNXMk+u0a6fXaYC5/OtG6eiFBgoZiH3yBkxroFwFO6P78h/HUbYp1I5MnUQMT/5tbJCOZLiZLpqUrORjTBZ7PjujuakKLJqhOWUmTv29X8VAAmNhNIU2j9oeOj2+gJeePf9yVxdOx5MXsNQTfbp2L4vxRG7QwDZsn44hKY2YoN5N0U7pmiqDWkEX+DYikcAEgC42miBQFBFe1JQehjYztLtOJGvXOVV6KOlT3KNSqX89hCYJXbCtIEkXEhTppVFwZdHw+3Rg4TBkk+UWCrSiwQPbuy582VC89lDVCzWOxAN5tYMzUgT+VvA/HGUJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBJsUqMsmY6sO8fKyJ76sXPhRp2+pyP3YbMNyyk3aGg=;
 b=iGT75zsF6TnqKUhAKDjthQ5O9UH5GeCGhXLNZQyPMhO9JE2mJdUy24z6f4eVk4glwjoGvHJxleFZ2lIVVnXi8uevkH1vhnagB+epWSDSHksaVsCaPtvtLoIYDgEfXsAeoQORFiHcRUkuOdu+FOEPCBRopXUoN8mJeGjTBgU3YlKWMcMv/QzcJwpzKyxNTu6fGaZv1BdA0j7GHa55rrcUadyVPA2kIMJMjOyPKAO8NeGkuqtbYZXATfaDhmujRePHOoroArDl0KTZK6CeUEvu2Y53RnqEEt6cM1HvxjxEQQy2FahtThvFiaTNmN8dREgkpffqrVPUqpxLD9I6vEYwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBJsUqMsmY6sO8fKyJ76sXPhRp2+pyP3YbMNyyk3aGg=;
 b=Fk76d8oURu/q7l6x/D/SttgeTShyB1G9K3QY0vInAICuGSj/YhAeU1v/OAQUcOBtHSn+Nxqs4HwcXk2ottEkr4tocN4XqjTd81fyfUGdVKhruu988rXJQ2qX9ygUmzoNt+dhVbgWFU1APvaAFL/l0T6yamGz9Im4MhkMyWuLmwrCVDmcIohvV6JmJzw1DlqLmJcvT/5QdHjdSqje2gD/BC05BeH0q9UglIA0xCYjFOwWvM84Jg/wu3WHuw1LazLvJf61CJn/pYvEElFJyYd+Ny7AjQCT+XsdLPkRmrihbVO14aCDI1Yw2ao3Vhe0Qstg/Bsa33nav/kcyR3zZ8ajhQ==
Received: from CY5PR19CA0103.namprd19.prod.outlook.com (2603:10b6:930:83::17)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 20:40:30 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:930:83:cafe::ac) by CY5PR19CA0103.outlook.office365.com
 (2603:10b6:930:83::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 20:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 20:40:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 13:40:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 13:40:12 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 13:40:11 -0700
Date: Mon, 25 May 2026 13:40:09 -0700
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
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu-v3: Fix ATS state tracking
Message-ID: <ahSzqdoDb8SjIJo9@Asurada-Nvidia>
References: <20260525184347.4059549-1-praan@google.com>
 <20260525184347.4059549-4-praan@google.com>
 <ahSrkOv+4QZWrcJq@Asurada-Nvidia>
 <ahSxWoWd5hFvKE_R@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ahSxWoWd5hFvKE_R@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a96079-01a9-416d-e422-08deba9ddc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|22082099003|56012099003|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HWAqvtqQKxljJO9TLSeeWnDTstKrSJwyas9lOuHyuCIKt75EqCi+jnCovG9RFeI5qypiLJ4vHwUSqzGPSXnppvmUlMCGF0XnxGLhKLoiMSDJfGfLouKnrqHx4ZhJYaFAPZs6js3A78jpPdXRV4wYAWPGbmLUFvroc+aaCuxxRiOCh+TsmaG6dDalrTWEBqE9zNSmmmLHbw+Rl1dblW37lTHWCaYrLYdrvJwYN0I66Izw3KquQVKPFiXX+OyWgvsi8Ov05HDeVLeXAh1jSp6cQuS/+ZVQV8p5qyofQHiHB3E6+Tp/vOYKeXDcSMnaVtVtF4/2PJFSV0AZh8lpaXNDey52e3YRk7BKcwD0hz7mF2qkdv8UhSNFFHo4ToeZ9v8+0UZyJd2JRwOZ9LHTPO9jGYDdH8DsnrX5v4uP+zRcwZn7BTXXibkyOFzB5Dfou/YBtRWpQRD+LraNNNTMm6DEHMBrSgepD6BgKIANrIWXUDEOaBil5wgLwPTa49f/r3ZAafUOyvYEAP9K4V8RICqwHZdWl9zJDQHMkLnUDAQOMwqXqVtaL44ICJsnzUTsM2RONu2OYqlfd170paO7c/mI6/rLY9TAzMJWIwQB2PakP/ZwogvQhef5dFw1UO+QlAqB1I9lnpeDLTkhi1hQlpe9TMpUO8zYKhCgcZ6qoNpAjShN217uibR9KmFw/VCIxujgofS9J/byEshQw7ENECJDcdWQt2lf5J6CYEImNnzzD0o=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(56012099003)(11063799006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6P3rMGuZAfD7qfEJ/5taIsfNb5TJFFYC6PVwetkSQQydyolPJGINcK0P3mcIkVbrIZETTmpIa2P6lew6Z0C13qlx/2VW+aCQ7YQvo06USkXQp6bH5d8itz57mzDYWMIjfqJ3fl8FUsE87SUyhIErRzVX2FIn73vE0aCUZPB9E+ulN0vzaJKiPiD4KuZbpF7T20SbJ4xOxGFFgMYwqIuXK9o5bpiblBic/Z4J5kTATbULqkZ1nWIZPoXz786DimKiqDddPxsJS54TYJPhYtdYi90cjZA/MwbrkT/T19CunFbNy7lHbNVwy4S3N3m/94yCSLtogE/7O7xTs2hvp1MI45mOIhFmsRQG70txP2uONWdRcoChFetvYwWWOcLX8UnyZ71lCZbn2Nv+bu+wIgziL05PnjZqE5ZwCjss/hJWTxotvAMOWi8SmR2u8vtbx3HY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 20:40:30.4302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a96079-01a9-416d-e422-08deba9ddc8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

On Mon, May 25, 2026 at 08:30:18PM +0000, Pranjal Shrivastava wrote:
> On Mon, May 25, 2026 at 01:05:36PM -0700, Nicolin Chen wrote:
> > On Mon, May 25, 2026 at 06:43:45PM +0000, Pranjal Shrivastava wrote:
> >  - pci_prepare_ats() covers pci_ats_supported().
> 
> the idea was to call prepare only if ATS was
> supported [1] i.e. not penalise non-ATS callers of pci_prepare_ats. But

Yea. I realized that it is slightly different after I replied.

Nicolin
