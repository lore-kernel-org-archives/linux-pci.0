Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419CF2D5C8E;
	Fri,  6 Mar 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819173; cv=fail; b=LlMrPDX1MXul7O3grW6vcvqORrqMFiSwu4uZW2GTsVCATmtefUPcDOVyNv7UqkDG3uQuDiVNk+ajNN9l7rt0zaadHuxAB06aSpdWBeOZiLx/uofsWuzO4V79chdxRio49itO4tF7j/UGiF6ueTunJUbIs9jkkSCVULkf3skNUeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819173; c=relaxed/simple;
	bh=g1LIc/qqNu0j+tKqdjvjxEbkny7PX2hFVh6IppxhhSY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3MIsLjA7f1qCfwrJkC3mrzh/y2DDLv9vNBXRgpUPpE25sPyylZfcL7Wxy2MQNfXodktrsztQeD/ZpehUt7UjS+PeJdaMQV3DNe1CSL8xYM/qXjgGPrrDw2d6RaM+1h5QY5M1F+MhiEAww4Na6P3PBOeDD6XwCLFCm8XZfnpauk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NMFdbtjd; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NMFdbtjd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8vTj7fKuiZGI3lD4yXiraCKsPJ9P0NamIDBVVs6t8hGD62iCebpmj4I7VgLISQvywhpuQ1tC0K7WLta4MC252eJIc5el7XzSW8E+uJQy7FWOKLNZQ32mhHv13Q+a4UkiK6LzX2TxbE1OP/gEkjrOJd5ZzahjPk7hpHsdXRR/CD6MesQ6/DS2EwaVAZXF+A8JF8LEV4BiwBkOkiOMxQGWUg//xBOtTzTOgz7GH1MsVAXce7GRevckukAeOFZWY5xAYde8LfGVdeob+1LCAKr1v7AqydYwMLEzdK9gmLv9w1mqORvOnudXi5gTm2thITTNCFY34CVwB5+rFtdKKnzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfXurEx2xoPVp6XjkktKZ0Vjvguy5zlIln8Fx2IRq0U=;
 b=lWkCQrrZPXx6f4YUSQIBGa7ihyvwWdHpXki2LxjstgwUPI8rLT1gavDqkaGKDn8/zgwv5zqmEzTs8mOg2wQz6JdE3o9BDY/LV9n3CXYJy5azt97VHyu7vKADmEuragMqlSNZbakSkrDtP1kBazxl3WUuPyTqRoU5eQXFKHeLnpv09dsX6aZMUJV3X2zC9iFoMMFk42du5/9ArqYc6pakBA+tVWT0uK3cpgvFME5OGJmwAxJKp4Ygo/B4ELSrPU1ATy1G2zQrU02hvDWqZXcm1t8b06/t406OFWIR3fRb4OW7q28dWny2SrSiyXUWp7FoYbR7v6jz6Rjw5PG7Bhka3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfXurEx2xoPVp6XjkktKZ0Vjvguy5zlIln8Fx2IRq0U=;
 b=NMFdbtjdQMfAcP0chs6cq9KtIfxOw04+lhXp2EBHbasVTTFEJokylimbjf0iB2OZ/ApKSSTi/5qGqF42T1zWQETeerXrgNabZ2cwzgdG9medT1qVpQ0LMhflg0PTobg0FZIbRe5hd/fx470Nq+UdzDjIm0ZelVeZ1vz6IlbvP2EoaHHKNcsPVAhi0lqFQAZhTxu4FIT7ylgx7CttyzsSQsD5OfQ3G5Btl/Ue3fOUl4gfkQQdn1a52oCU7kLKFwhMNAtKgxVr1QHud/HGo40q+apTaSTfBCpedCB50WICyhguMFLJlPoi4y+6EhdDtDwxYf10Bb00t4mZ0Vo/DnsiBg==
Received: from CH0PR04CA0039.namprd04.prod.outlook.com (2603:10b6:610:77::14)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 17:46:07 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::6c) by CH0PR04CA0039.outlook.office365.com
 (2603:10b6:610:77::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 17:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:46:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 09:45:47 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 09:45:45 -0800
Date: Fri, 6 Mar 2026 10:45:31 -0700
From: Alex Williamson <alwilliamson@nvidia.com>
To: <smadhavan@nvidia.com>
CC: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] PCI: Add CXL DVSEC control, lock, and range
 register definitions
Message-ID: <20260306104531.3bb9c16c@nvidia.com>
In-Reply-To: <20260306080026.116789-2-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
	<20260306080026.116789-2-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd972eb-0bfd-4864-dd0e-08de7ba83ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	bAWlwjIl4Z+ugRqu+m+hg6vH5MvPC52DpZM/5TC4tU2oyLz4Lj6+SuPG5MbhV009Nc2ZMOShwpD7cf3PzbfR1d8x5ujUJ3HzaWlNooESQDgk2q1ZY2urnFW8KF/Fnz6Y69YFywtmVbUgc/aTX4oqkaejVBFxaZYd/Nx9mDpJk5MoiNN2GJ6NBicE3VR1uZ1MCo010TSMKOCEOBqnt1T9jeJi9NcNiL9QbqgaBveEQ3dUY9Yo27K0m1Ztw8NOuepbrOvg2VXgIdTRKgSLZ1NJmP4ha8dVaOFHkcR4GpkNydK7zwA0nGA0Wcaz6p2FMhqwX2OCX2xPr55iQxF5aKrCfaD02BKzf8XU3tR5bYelQKy5ZyVLUUmCEcFqJbtl20ijnOUKQFiHN2UtGwr+jvowb57rDoWRFf9KtsY7onibyVan7Oln27WEL7zy2XiTzwPMffqKwVyP+jIANppIIg1LM8G+6QtH/xTHnwH2hY+CUAAAbi8mv0bgqJLR2XSYVWY0u5d7ewtvVq7gfjmoiIPllhwkO4d6paILYadV2MH9UK+4aGH6Efx14LOD6vTlMGwESA/oyfwiP6l0tr3bw7BCy/218wvjVuFtEVnCE6edJm03G34sLtC0W4qPnNzO9aY3X51CIG35XfyyhVuG3yWrvp/O2iJmIUckWiv4Zo/4dxt5fRqx/dMh8jjFaEZzwQq90zOLRU60OrGllh8niwm93UsJYKK7Zwvylf0A/3AK6A9Fg/KWE2lsovooyDcZaJ9e1M9MnbtWZU7kj0ZVV5X7dw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	99ccyHUQ3qUgtiDTngNrDZferrnJGYyPZvM++QA5N/SPi22g2WCmM8GgX7iX9ws2H7LY0wMZoZxhwouF5zQRx223uR2aZOAiqLp5Ucf86CtaPAanM131DcRVAG27ooj2EkJqRS04Qo3TOMfodTvRn5lJ5q8xqhzEGeXp3zSlW6ogwEvjUnqK9YUyV2YkkZ7uWBJCsSrhV2PqYT+AvPGZoCZYJW4TBpm7FTy6Dr84nmDftAtAAXfvTozLNbrWKafxy5IhN4UtWZZwTNi0SGSWSiVIokPCWbjkSn+0p3w3M4icvyQQhQwmoK7DigOa1f3Dy7tVEca0HhcS1nY+QRww0dypiLZ8G0EHacyAs790lB5cBccffpeRz49ADqj0ZaAePejvbNDFcGmfw7H/zbMzcwKLjWl9LMaFPhh7F5l7queA6vY5z3WEwRgtt40+i+hL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:46:07.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd972eb-0bfd-4864-dd0e-08de7ba83ee3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823

On Fri, 6 Mar 2026 08:00:15 +0000
<smadhavan@nvidia.com> wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> PCI: Add CXL DVSEC control, lock, and range register definitions
> 
> Add register offset and field definitions for CXL DVSEC registers needed
> by CXL state save/restore across resets:
> 
>   - CTRL2 (offset 0x10) and LOCK (offset 0x14) registers
>   - CONFIG_LOCK bit in the LOCK register
>   - RWL (read-write-when-locked) field masks for CTRL and range base
>     registers.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  include/uapi/linux/pci_regs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ec1c54b5a310..6fdc20d7f5e6 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1353,14 +1353,20 @@
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
>  #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define   PCI_DVSEC_CXL_CTRL_RWL			0x5FED
> +#define  PCI_DVSEC_CXL_CTRL2				0x10
> +#define  PCI_DVSEC_CXL_LOCK				0x14
> +#define   PCI_DVSEC_CXL_LOCK_CONFIG			_BITUL(0)
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
>  #define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
>  #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
> +#define   PCI_DVSEC_CXL_RANGE_BASE_HI_RWL		0xFFFFFFFF
>  #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_BASE_LOW			__GENMASK(31, 28)
> +#define   PCI_DVSEC_CXL_RANGE_BASE_LO_RWL		0xF0000000
>  
>  #define CXL_DVSEC_RANGE_MAX				2
>  

These RWL defines really seem to be more kernel policy than spec
definitions.  Do they really belong in the uAPI header?  Thanks,

Alex
