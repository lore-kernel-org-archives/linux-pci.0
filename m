Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854A47884C;
	Wed, 23 Sep 2026 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199678; cv=fail; b=gccxTXM6CwV4FYy7DWcXRRvTDelDad9Z+OdwXNRZ7Bz+AIhWFL4YyjoyiKoNpBpyZqkCoNIrRa5aUYeXFk9+6W152SbfibT7tJoAr4MDRoqS4NPa6OPfmLrcqYmoNOrRzb6UUBpjF+BYs2GmBFDxl52kd7VnZX1YK+JEBrxTjiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199678; c=relaxed/simple;
	bh=uvN8SPNrFrwIaWRuk0jVhKdh4RGp8YNvbqIPbdxxri8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NOnmum8o/0wzr6MTWfACdr40eJ5vokPtO9SXciCbslD+qtK0sIk+f6iZkmrH9h/nsSa/VFUmm71to1riY0ZVgostJzGoouo5qS6rgakJb04v7yaakB3Q6Zp/04AJZy19YKpYHom4dWVLGAlHNYfR8qWkNxzxZ0ngjJUJQ9JVzW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T4/n4T/z; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T4/n4T/z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ/t34fN4QVZrzeFh+jfXnQwWsIYKSTCGUcszthRIFXNHT+7x/JysJpETLirHLYh8Nyq+4N6J5yLtFWRVYi4B9WSjJHuPoUuGvmzs6HjCQK7mf6RN54rxTepB3xNCDGq2q2prNNLijKZ3rPsOtFit2PE+4KjBTlze8mf8ORK6BP7hTk3Xr2OhHqXkbpfFGoSkPPYr5yuxtlahuTJriPfCdxlOMyZk50Qem7sz0P8oRC015PbRPWQSXqPmI2bKR0E3YvSotc05+1SAi6agiCPQ7pgkEWNBYbEBC6FpCe/4gJKUlot/YPC8UP0Q9WgPdvQP3KvD0HkMnkoUuK2/J5XvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIKTyLxKkKDxnZPVcLmSysZm+qRM695BFcuzdjFKpww=;
 b=uhyluD2TRr7lzybUweLDjFUgPvL6fxK4dVF/WQonvJeoSI7CdNG2erKQpaT6/4vpfIJj65TvFrLumcmpQyoGzTZf3D/gzNljtBTHioPmBudC5HOEgKBkmhPXTgOCo3v9HhMx2xVbDJ2rhd0BgUD3VudpEdTMcWew9PaobIMD6PiS2RLWxP9EnvZl6BTidWMFewYIg0QSyTtJTyK9piHd8cw969j6oasktzahEL5BPRZ2VrcAgM+4zsZ5fSROjRdqnYHbBUAq/+fBWff+4QFptu0J2tXMi8CSRdBRf2kdXcadbogJNz7pw77MCiplZdE7vSCV41DZ48g3Vw+1Rht6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIKTyLxKkKDxnZPVcLmSysZm+qRM695BFcuzdjFKpww=;
 b=T4/n4T/znTsn+WLX715grdZS/kmDpywnxTRzxpJBKS9leKe9ZCU1W7dfX+VpTlkl5A7HL+icM2ItO9NnOy3HuNSRvoq6VkTmwBdEkpaiYHOaz52s8FsiMXUx40CfJ6wtfo2bDQU1hAz4DanSPMQXN21Q5XmFH13ZRlDcXTDNHXg=
Received: from MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::19)
 by CH1PR12MB9622.namprd12.prod.outlook.com (2603:10b6:610:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 23 Sep
 2026 21:41:11 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::8a) by MW4P222CA0014.outlook.office365.com
 (2603:10b6:303:114::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 21:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:41:10 +0000
Received: from [10.236.178.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:41:06 -0500
Message-ID: <e63cb7a3-bcd7-4968-a5a6-12ffcd9bad50@amd.com>
Date: Wed, 23 Sep 2026 16:41:06 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v13 12/15] PCI/CXL: Reject reset with unsafe function
 scope
To: Srirangan Madhavan <smadhavan@nvidia.com>, Alison Schofield
	<alison.schofield@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>, <vsethi@nvidia.com>,
	<alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-13-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|CH1PR12MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: b06dfdc5-75ff-4909-00ee-08df19bb6270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|23010399003|13003099007|921020|4143699003|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2G84WVqH75Pw9XXB7QmARvrWlE4M2WIpuw8pa2ABmjVc7DBofH8BS30VyoxSseNaE7yK8BaDMCjrNwH9RDy0evNr1q1/4LF99T6suJYtBumYonEvCNCLZ6SJgU7ktZBRhiHpWwqWxgwDIcZ6+q+oPJeAbOouX5RMr7Tk8tgENdimM8BLIQxMf1cE0rbpJjHdcG5YKMw+JDLyIQYbtstnMUOGuQLhHtxZ4TzM4V2nwR37ehboiqxGEXAIaZMDbv/Pe8+RHFLamfgDQTZt5uLXPq0dW3VtKOVFE+PjXFmpu1ULoFVqhGV9HAo4zSW2PGZFSIoKVi3PWVOmQAh9IKpBkOOYKE2SzZFAPX2PPVWXXP4sDp42LN9Ogp8VdLc8eHBIHhc+YbtM5OXcaF2jhcRYua4ovF/YG47k8mS8SaUvkamG/ZRxY5uBziEjmv+xcdjnuCSSel46oCs83TVYXXPR51vXsOXe86Kaa72DFc8R2SE7ppmFDx0JU4tn7iehXA4uFhm3NTmS2CaZ1Hphr06MaUlw3y0hrtTSY8f21lKB0OGux6d+yoomQJPH0sdj9bdI7b1+ggJKF/+/3+uL+xd8fL728B0n33belFWXztTQRz0bL8GJVKnANhNPchPy8Cj0c6A4yTR8ZyP67C50camyqX5qKTtxX1X18RO77C9PvTxfLQp7WzXTnbLZ5Fp+Eemb
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(23010399003)(13003099007)(921020)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oIDc/oaPvf3u6g8q9C37fL8gUpKw/hidVWYnFfDCaz/2nsR/pGW3mhav/WdqzGfbG87nhb+1Z4qK813MrVANbeJK1WStG9uOXXIjWop/uVb6ps6I4+vMNYNCfO7YKODrXQODrFZB/Qg3vimMvvD84b5CtZliE08F4eoFvhymhmuQGqQaSMGq3YpB2kPxAYx7SzhiznGEQfmr5+dzbylVsDAK/4Ydj6Bwgcar1QYztmkYC0gGfjSZAyq6oPCOc5Gvr1Y0NVOQh9fmAMYmEtN7ZwI1c3b3WonE1vcYCwDd9PWhfXDBSwQ8DptNcpZzyg/kVvK03CUp8QfGqzsymd+UZU4bvW09tS2DjeDLpsDu/7EXcGHVUdZ8vTXk+8wt2Vnvr+9W/7UG/QE/DA1BhYVYQiOdE7AkqzVijmtreFNzgX+EACYj2x+n8cfsia9yGqhU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:41:10.9697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b06dfdc5-75ff-4909-00ee-08df19bb6270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9622

On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
> The per-device PCI reset interface must not reset sibling functions.
> Reject cxl_reset and cxl_bus for multifunction devices and PFs with
> enabled VFs.
> 
> Reported-by: Alex Williamson <alwilliamson@nvidia.com>

I'm not sure Reported-by is the right tag, I would expect a Suggested-by instead. I think Reported-by
is really more for bug fixes, but I could be wrong.

Thanks,
Ben

> Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.com/
> Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-dev.notmuch/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/resource.c | 3 +++
>  drivers/pci/pci.c           | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 85a554b6236c..249b1280f3d3 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -859,6 +859,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>  		return -ENOTTY;
>  
> +	if (pdev->multifunction || pci_num_vf(pdev))
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..fe611340f5ab 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5026,6 +5026,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (!dvsec)
>  		return -ENOTTY;
>  
> +	if (dev->multifunction || pci_num_vf(dev))
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;
>  

