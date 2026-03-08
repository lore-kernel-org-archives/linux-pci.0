Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938AD2D5924;
	Sun,  8 Mar 2026 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003002; cv=fail; b=sLo54fMXUbsT+7gUJG+Xm9/2cJCYNencHjcWkZ8veznNbehqrAa5UmWq8CEyBo8S+0+yYgAQX/MBel5rqJhWhb3b77/jVYLT56h0S5Jwdzm/8a9mTsjNexCjeeRL8GY1jBAHRPtYf8zBrNEKvPqJvmn3Wj7GyE7QYMuT+EZuahw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003002; c=relaxed/simple;
	bh=7q3sgsM1y2mMJASosCqzAcM7SAUgS51Lb+BBvk+E3ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BYY6qKK78ZX6iFU1CIfzOqLQPggVjom5yd4SR9AiLT2vt8p8uCv4v/OwsxdHUSsgueWrUHmLPOZvvm74AMkfZip0LLxA5s7z/3yMXnSkmoeQAOgtD0Z7JXQsO7szrcEYR6+YlNOWJ+hh9TiVyccu6nUAv6lPmsHpZdnLA+91xkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aRrtTD4g; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aRrtTD4g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlBnDHk/a2UO698ygJwtnNg1XMtQYSMkhKx1HFpcWyd3/Q96wtw6hDh8inPHCptRWRRbtZ/8/zrRM15SV6iskX2EzmTifIw2zZD5r8OQhy6qC1w4GmGjK4l3S2aHJ+tDa44QtGEZjrI2S7T/ybmvGDo0ngAV2rNjK/Pf30K6KJ4rw4Y/XEDdLEg6e1Q9G/OvsVloT+p81pGIO6HBIu12iNpplSw0dNKDd6yO9pg1kklaPjy5t/Hu1zqOMEhKg4L7ih9fNHDi3QPtGJ1kRgccAsdQrCHWPOA7ODhdeiF0AjCLwsNwVvCL8z04LBu5Xq70ilhnlAVMhApfEy6eVCBtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBmXO7yJ+iKLnVJ0VtGaBRmU4fgxOEGjp9LrAn9XmKk=;
 b=bQX6HmHOV/qkxnm9Ywl0iOuuVEaOVQYlOrMXAoaMA8nk0hyclyG2TtsEZBH5uZu8wl40VoE1/cNu4z+rmT9SmfYDmVeRgc1YCBNSvIku4/s1tuQPpbUfhG4TXSNmWtHciittWW9EOb5VxbwJRC80qr8kovdiHOw1s4e8/lWoFj1fAN3lrlFznqnuRw7GChP5q4+oTVxVyOC9+a+Lr+ZcQQ97kSPyvdE4KFMHq24GPK+isf8w8qeJP69krpI6NzzdShbmtVB/76lJ7+BV0yxsP4hhuVNEHY+oQB+4nEw1dtjP9beobroXjYezQNfRVnjXfbgextzczM4bRe3AbulFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBmXO7yJ+iKLnVJ0VtGaBRmU4fgxOEGjp9LrAn9XmKk=;
 b=aRrtTD4gF0qKn04m3E97855KkeOTDtkRYTs5ELvw1RcdQLLXNpVVcO+jeVSL/CZGhQq6MdV2k6NLzTMIoPXUozg4/iL41f4rZh0xAnwZZNt32Ii27moOIGI+pOb6c3VAZeNhg+yv/XVbjqC6TrFT+5b9EK0N4WY7OGipK4jiRcCh0Xt2Zp866/VsSw2cllHK/AjeiFkNvt5p3dRMz9XqA8SaMklJud2AdJBBaP03SOcldJgMG3CZLyJQ6AKz0QLsA36tiKsBsmt7ZqDGnzx5/7DwYACXGVZZ0vbBkx1tyocsjLOYx3NgKKj0ts99JuXM9l9fAG+y/Rk++pl/8Q1nBg==
Received: from PH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:510:5::17)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sun, 8 Mar
 2026 20:49:51 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::38) by PH0PR07CA0012.outlook.office365.com
 (2603:10b6:510:5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Sun,
 8 Mar 2026 20:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 20:49:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 13:49:39 -0700
Received: from [10.221.136.116] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 13:49:35 -0700
Message-ID: <2d523f6d-a4a5-44f5-b588-e6ad520322ff@nvidia.com>
Date: Sun, 8 Mar 2026 21:49:33 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5550d8-211f-4cb2-cc7e-08de7d543d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016;
X-Microsoft-Antispam-Message-Info:
	pIJ4hQKq/AJKyt5YOGgY6VPuWaCihcIR17/k4W6pgsSpiUIa1mGMZUnpz6VNfOatPYaYdUhSUSnFk13p5uZDhYz6Z9/VdfVuTf/UMgE6h4AlRGcEEWNJ/Fw+QfmfdXspJqapdPdJzuIuGrCAP5QTLk/Eoq0toY3lmEp3AC/rNBwdSkryw+LxOxU5lYPHSNklSsQsnw9cph2pPOxDwLVS9ZXGEAW2zTikUyNLRRAJ2pVoOtFaReR7BS8HfLWsTyL9sQRsBWXYDTFaFTTra4QUnS4/HbvUofB9fsx/Wy1sN0c/WODi73btokKBeoNixeOjKShGvewrPDknrNiNIr286Y6Gu3ckqB88EULA2VnKorrPyDbdCIHvIKxWthFVPixMqTNX4rFct1j7MS/UPPaWLl8bTsS9Nq4+LBwM081I7TIWTr+3RRazHecFaco/yg9pvexkZnSRa9moitM66Ez8XrIfp7kq0NBabgSl6t/miiuzYP3LTU95h4FL4cZ8Q7XrRq5Qzgdvh0QEiCwfL33T/ge3ca2Mq4DQnXOtnDdflogVKIIcdJq3ZDA0fTtZithL9hvmAmzVo04a5XBm22CzViZ/Veh8TjSqh7X4nFE3QU+22VHOkzqg2k3LPuFldv/poUY76KHngnLW4K5sA10owj6xM81eUkTB+jEi7AxX7u8/XkYeNTfU/n3i+p619GLESKiUaS83CeVPfbPsXFxrCjX3ZuWZ48pTLvmTHwecK6TKabx0T6zkJIP+ovh8jP7bhZubPUogmXQPPB7/vPNdtA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UNmKjDYNYycEbDTKqHSO3YIxM2IZ3VoDUxB6SuVlRfQki3dwZa+cZus3C12XttRqtbAbKy+R3lCl7V1TWMF5SKGHu8gylbefe93TRTgS8P8pOQMPgsnNSB/4RelZMQV8MzX8b7iZwnpLbv6PJCjWdJLdzgNZE4QnN+RUAiY9KKIwZWZVacduQMVX/rXnxwqGFh1bPcOBELabbKK0elVKnizpLHSk54dzT+qhasDojQRymGboZaNNSgUPatYqHRhojzklAkfqZtxRxyqpqWv8AtGAPWTP3Sd1xWyBlRL4PJQlSWi+vMHBTXoFgnExbw+8UzzyPu0kZlhKLf2p3Xkh15HRz1eONvekQ6xB+DmoD6g0yy40ECPpgL63ubnLQcrJIfchqPF7lGbGquJ8p8rLirb/QspLYeLo9F1zDl3XvO3W7uj8lsLfB1yJa8RfRt3S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 20:49:49.3699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5550d8-211f-4cb2-cc7e-08de7d543d77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813


On 07.03.26 00:41, Nicolin Chen wrote:
> Controlled by the IOMMU driver, ATS is usually enabled "on demand" when a
> device requests a translation service from its associated IOMMU HW running
> on the channel of a given PASID. This is working even when a device has no
> translation on its RID (i.e., the RID is IOMMU bypassed).
>
> However, certain PCIe devices require non-PASID ATS on their RID even when
> the RID is IOMMU bypassed. Call this "always on".
>
> For instance, the CXL spec notes in "3.2.5.13 Memory Type on CXL.cache":
> "To source requests on CXL.cache, devices need to get the Host Physical
> Address (HPA) from the Host by means of an ATS request on CXL.io."
>
> In other words, the CXL.cache capability requires ATS; otherwise, it can't
> access host physical memory.
>
> Introduce a new pci_ats_always_on() helper for the IOMMU driver to scan a
> PCI device and shift ATS policies between "on demand" and "always on".
>
> Add the support for CXL.cache devices first. Pre-CXL devices will be added
> in quirks.c file.
>
> Note that pci_ats_always_on() validates against pci_ats_supported(), so we
> ensure that untrusted devices (e.g. external ports) will not be always on.
> This maintains the existing ATS security policy regarding potential side-
> channel attacks via ATS.
>
> Cc: linux-cxl@vger.kernel.org
> Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Tested the series with a Type 2 CXL device.

Tested-by: Nirmoy Das <nirmoyd@nvidia.com>

Acked-by: Nirmoy Das <nirmoy@nvidia.com>

> ---
>   include/linux/pci-ats.h       |  3 +++
>   include/uapi/linux/pci_regs.h |  1 +
>   drivers/pci/ats.c             | 42 +++++++++++++++++++++++++++++++++++
>   3 files changed, 46 insertions(+)
>
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 75c6c86cf09dc..d14ba727d38b3 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -12,6 +12,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps);
>   void pci_disable_ats(struct pci_dev *dev);
>   int pci_ats_queue_depth(struct pci_dev *dev);
>   int pci_ats_page_aligned(struct pci_dev *dev);
> +bool pci_ats_always_on(struct pci_dev *dev);
>   #else /* CONFIG_PCI_ATS */
>   static inline bool pci_ats_supported(struct pci_dev *d)
>   { return false; }
> @@ -24,6 +25,8 @@ static inline int pci_ats_queue_depth(struct pci_dev *d)
>   { return -ENODEV; }
>   static inline int pci_ats_page_aligned(struct pci_dev *dev)
>   { return 0; }
> +static inline bool pci_ats_always_on(struct pci_dev *dev)
> +{ return false; }
>   #endif /* CONFIG_PCI_ATS */
>   
>   #ifdef CONFIG_PCI_PRI
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350d..6ac45be1008b8 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1349,6 +1349,7 @@
>   /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
>   #define PCI_DVSEC_CXL_DEVICE				0
>   #define  PCI_DVSEC_CXL_CAP				0xA
> +#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>   #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>   #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
>   #define  PCI_DVSEC_CXL_CTRL				0xC
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index ec6c8dbdc5e9c..cf262eb6e6890 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -205,6 +205,48 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
>   	return 0;
>   }
>   
> +/*
> + * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
> + * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
> + * by means of an ATS request on CXL.io.
> + *
> + * In other world, CXL.cache devices cannot access host physical memory without
> + * ATS.
> + */
> +static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
> +{
> +	u16 cap = 0;
> +	int offset;
> +
> +	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					   PCI_DVSEC_CXL_DEVICE);
> +	if (!offset)
> +		return false;
> +
> +	pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap);
> +
> +	return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
> +}
> +
> +/**
> + * pci_ats_always_on - Whether the PCI device requires ATS to be always enabled
> + * @pdev: the PCI device
> + *
> + * Returns true, if the PCI device requires ATS for basic functional operation.
> + */
> +bool pci_ats_always_on(struct pci_dev *pdev)
> +{
> +	if (pci_ats_disabled() || !pci_ats_supported(pdev))
> +		return false;
> +
> +	/* A VF inherits its PF's requirement for ATS function */
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
> +	return pci_cxl_ats_always_on(pdev);
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_always_on);
> +
>   #ifdef CONFIG_PCI_PRI
>   void pci_pri_init(struct pci_dev *pdev)
>   {
