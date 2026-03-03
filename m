Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D0372691;
	Tue,  3 Mar 2026 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568949; cv=fail; b=nppW1Vipsn0lQxGu5WzdGsPX0GFqubPtLYkwRxOzfLpF1vC95NIdkKDAePSY6S6iCp+qN5CV/FDjsKdtR+ZVzsONC6KseYRx6nl9+Dg8T7fmk0NIuqsP+FggrD4Ke/LPVquHMgNXqjaRBhQNpnZ9J51BvWyQu3+87pWMmL4BmS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568949; c=relaxed/simple;
	bh=AQCUrut1hQr9Ih/SpARdX+v+B5HrbDmdK/K+X/B1x78=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQxUQDxorwZQ3s040jLVdHffJdrcE/mWhSbf+9DIW6msKdtQVMLx0Ry1c1/2RGjTWLzNPIfwF1Z25kPDTv7T0i5dNZ8ndYrLzmbG1fl/3bAPqMWAgRN5o+GQjIBC+47C+quatzINMoA67+HD+UAGY5eLLXSnCrHZndu+5anrmzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGN3RUIf; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGN3RUIf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQOoUVBOABPzJ5xlhB0WEBeY2QX2OTq68T3u0ac8fst+DkiEJ3rKDxXOBkjOKRZZomzywW+/yFFe9llSN/Xgz7snKeK0O9+MRT4L68IyOA9i8N+BTClrW6lvEgVpVmhX45j81mCbF25qowmXWAK/cHnJBtM70vDL0UBe2BTZ/WRfK7zsBmYwoefW5vj+oidzWgGi83Dl0qp8M68TquhvYT1M3DhUNSsO9fsbcVLsCd/df19c+hwASzBfOufls5Cm4Oq7tXXzyCYAmwwRXDS4u02KG8/g7YHMRGz1Jb0G3P+Cro68F+NlGAr4dtsBN6fRIrepF3H69FQBWwL8uHRdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKPDBHqrBJPAWM4RO7+t6JK8pCG1h60E7tJiUtLIOYQ=;
 b=SEDXoCDncKTDo/VB/Utsh57ejWpjSlY5bW5elIgC2M1kIvPTamg/K+WL35pNYFhoPMRrJRQiFB7+oGGYNhcbOuMJ3FyxW47kd5RYOkD/kdnmdmO2+ebSZRzXJVY9YitFuX3mWypJb9agLuj7juliHgm0m2Qtn6DEt3PQ+ik+GdPbYzuwAR7G/O7chJpgQg0AARqQsQ5iXVlMG4ycLmjGVGoJb46HkvR6QspSO/QuaPVDj5FzP/pxjQ9xjHX6jAb5MP2nzw9dNsDIqDQO0eW0YhyDa+Tt1fx/6F4cKjpPT/Cw+tK+DktzVb4GFeuTw/joaysTIJeaOOMomV5caL7e7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKPDBHqrBJPAWM4RO7+t6JK8pCG1h60E7tJiUtLIOYQ=;
 b=RGN3RUIfh8M5c7VUfMUcAs6P0GvIi/7tcC4rjs6T7cwN8hfUVaayv+oWjRImWSmhq5eE0wHkPgN9VHESBuG0HLEi9y3mgykquKZdjQ1KUEG1PBlUo05ml0cV02+i60uCZvY0kdiyPGynHQPTXjak/m0BiTQ97gP7DBFPdS6F+ItIoB8/gIOwJ3W4UtjVt9JPH/odAawRkYPB3GIBOp1Frx4Z1gPXmto55A2jZp+VKcwbmAWAthkekL/bCmFUzvlX2fspXJpGzr6nUQqgUY81IyyyQXhTW5PVMEolbgxgaulGqak65mbukYkD43AnzALq/AjGcH4KAMqy9BRdnh0u6w==
Received: from CH2PR14CA0021.namprd14.prod.outlook.com (2603:10b6:610:60::31)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 20:15:38 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::a0) by CH2PR14CA0021.outlook.office365.com
 (2603:10b6:610:60::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 20:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 20:15:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 12:15:22 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Mar 2026 12:15:21 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Mar 2026 12:15:20 -0800
Date: Tue, 3 Mar 2026 12:15:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <aadBVxa6xQrOLXDt@Asurada-Nvidia>
References: <cover.1771886695.git.nicolinc@nvidia.com>
 <ad4efe2f85958ee1ab0673a1ceb0db5141852732.1771886695.git.nicolinc@nvidia.com>
 <102ceb37-c89d-4bb0-a471-42ccffb40c34@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <102ceb37-c89d-4bb0-a471-42ccffb40c34@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: e827a8e8-941c-4568-99d3-08de7961a2e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	TXF9au9XG+EBIhZzcjVz7w6+gL3v923AGuYTc47La3bYFY1RoLUB7AogJ23MzLgX38wVSNoFFar/oujU9bO6BhNL06CMSiy7rOLl4bK6nj3ho/Ql8W0GF0WZ6Pn1rjbYMhVJINvEnlkbfp5r37Fo/YKsUrzguS50IDNf3bXHAZkUQAwl9vG75CAWNNmt7Lz9ZCjbFdUaryPtot3AcwJoMLA4gRQT9yU21cacAEZ31ymgYN1I/+kXmS7bMe1pvlpEnzBRZF7wWobTK/6lD5FxipFnibdCAbbQ5ED1IoVkc60vXiSg5TiDpIOc/xpV+aj1NteleRmhtH8kjqZjXFlHxj4/IaDOcHJN0cFxrYEgIANWby2/IDzsGzw0DgVaBlek+jHO9UjooQiK2HTmi/rGbAgcHx2muR20L97YWKhMydHPnvSdzMqZ++9gYpLf4wVSiqlnAKYKtGDWlzMjrVGjInU30mwj64BRh/XoIs5UATdurK8+lGtI/rmaZmn8cgKiuqt1z9tCvLEGE1thjUR2SDa11V18gkGNjwCzW4VGjZ/2lbLPV9hrPPA//jH8L4JuV039w4n4m+Ar7pyUeWkY6W/q+iUrpyF/RN/SbG/uhob/hnU6B+CWKYsslcyuziFVQFif+yPCMx1JPd7ib4W6W1Uy3NzSt5sMdqylfkRF5B/EjE56Y1LOB8TwR9zWd8KyZCE9GN6P2mrTTfbw8kOJ8VSnDeplrlnMUA+TwhDQLZlG7JEtrJqr8jae4P3zjTJT/KxWwcYPsKnEiyQtM9ugWyIACnklsmELTrI+MgClAHi0mvK/NMhSGNjmNvsnn2EhLpocutTRlIP3yLkt4h/2Cg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wh+bVyVOIv/UMS7fvKSRPpoDORy8KmaD6jS+SVRvJqHAGHj+iVIhry8314OrZe0Ce4n5e+wu+1PIoJ+zQItfXE7C8Jsxbf481kfsW1IOeot7blkBOw34wycHqkxZJ+FYwhH4osyFBKHcK2tHbYjWUbY0tueb0FcrNSRsz2Kl38CU1OrIvIeLWhnGTG3AQDrjpxO4z9behEP7Z7Jv3lYGx1mnSLlYvfZj2uVJqpmjbetrKQIhgPGWzDadHsfSaYAk57obMmbAjb24EmHzCqP0sxn+RbOj4ZJK9oIoEGe95SLe/7tbPryc56HgKkbH9UPhrPKLOKuhy7RmUplT1LUaqaN0pTvr96Vf4JLq2ADPyHrIvob5bLqfEy97H34xvU4CZm8oa/sb70qslBE+0o0loT63M78yIBE8VRWKW1gMwuib72MOfrX0+3sFw5h0uOsr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:15:38.3742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e827a8e8-941c-4568-99d3-08de7961a2e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545

On Tue, Mar 03, 2026 at 11:18:10AM +0800, Baolu Lu wrote:
> On 2/24/26 06:52, Nicolin Chen wrote:
> > +/**
> > + * pci_ats_always_on - Whether the PCI device requires ATS to be always enabled
> > + * @pdev: the PCI device
> > + *
> > + * Returns true, if the PCI device requires non-PASID ATS function on an IOMMU
> > + * bypassed configuration.
> 
> Including iommu-specific policies and configurations here might cause
> confusion. How about making it simply as: "Returns true if the PCI
> device requires ATS to be enabled for functional operation"?

Yea, that sounds good to me. Thanks!

Nicolin
