Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17C246774;
	Sun,  8 Mar 2026 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003061; cv=fail; b=TkOz1e/w8KmvFEAzzFL/20qtIUvFOJwBQEb9m7DPvG0Fdz8BeVutJb14qulcERsy+fFcmjkcZXD0M5i+WFhW3JKNDmFAJaO2yovUy0msjNqaJmsKsulza2L8RJoXXIunJFlriSfa/gK550NiGZQdav+ytWD5CXNJMxfCC0LglUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003061; c=relaxed/simple;
	bh=xxtgA1FmkgxU68m0Fh1x7Fxbm8mSwe8Fsx8ngOWohms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=loAY1JGpJ/S67+WW+qz/V+oJ3sGhJwL59jodpxsMlPAOFHv7xSL0ZVLqWeH5lAV2KdwIZod2P10A4qaSSSWb/hQpXBGQmmeO2m95/WOU0hsyxgDDPihrrawRoprdRlY7FK/Lt5F9xWzft9xZTovkIzBTwTDVD5uQ1GmtKSQkVDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j9EpfAJr; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j9EpfAJr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nge5+h/BSb0aMjFB1g9Q8BwBtOYWwFK/n1Q4SwAO+h8yb/flijPTW/CcbmXWseXt+Q0DKKRT2YHqB82oM1s/7tJOn1Sop4TWUbvszi37n98PVJ7cfTly8j1xPN2d8LABdH6xZv8JX482pkDJRbxo+7xyXuDSqPOHjdH4tHTLBFHSZhuMnGeY1DyZnisS1v6sWRB/CiY7D8WV6ufjGbZsPCfC62K29i8j9aB2IucqRHIgnmZDjrdS5aY6/8zEVqkNJEnOS12Jpwn2/HDx9+UghKkXTDe0sKm22pjREYneRgYmJ8JW2M50MBBQh6XWUwt7gmouz8wcm8PIv5RXq5oECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQyMnbqfuWYQX9HsHGCv2nFrMKAgYZKUyGmyctiAAqQ=;
 b=uSfOr8gU0aXKprqynYHuvaU9WRVDkcrbqB/xE7Tkyn54c1oZH8bKsMYIO5NjRaykj1J3jTRWwsPSDEpOwTYVbi61vYhups2RrxpaybEjRTN3yrgBZAAx6VyAxBN8n2L6vHvfTmNgXGuK5iCpPT3ImhUjJ2LvrBE9K1TlUFz9Zv39556mToifFTbJTCDqsKpaz0HOaU0KaPyEnIo3GFOfUW0UaX2Ss311uuR6soRa3u9s35uVKQB50d9beHXlnBLjbmnTw9oqby7h/h5jMT9kKSGv2ZNO16hu3+pct0Xt21LZfIiuTQ4OsOrt09o3/UaE08RvlRpHuHxptTGZ3uWq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQyMnbqfuWYQX9HsHGCv2nFrMKAgYZKUyGmyctiAAqQ=;
 b=j9EpfAJryw5SvIzNb3DJ6cB+PeRGnaEq48lsoWSx4QMAY1196YkqIeLu208+StEKL4qAuOT4oxQC6GXYS1KmYgG7gks8XSpeuCowihQEvCS7dk0kuu0xUYUjR3+zyCvJ8eihGVMRZnH+CQoQWSZoPIYybEVSjGlUlajLBhN5XTKBnWEN7eAtU4w4bN+G1v8q2I/tIPNcFRlZhj5U01FCFvJBfNJ1F462Tpi65Tf1Tdrwjdn4ixDrqWRkp9/wAlCw5kF4Zwr05s09QuWfn+JR5I83heL15lihx2g2hArv3laZIZBDfPttq/F2/FH0D2p+erAmKfQXIoZWPX2QQi2UQw==
Received: from PH8PR02CA0010.namprd02.prod.outlook.com (2603:10b6:510:2d0::21)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 20:50:56 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::68) by PH8PR02CA0010.outlook.office365.com
 (2603:10b6:510:2d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Sun,
 8 Mar 2026 20:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 20:50:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 13:50:39 -0700
Received: from [10.221.136.116] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 13:50:35 -0700
Message-ID: <50281260-62e4-427f-bd66-e8be58062a03@nvidia.com>
Date: Sun, 8 Mar 2026 21:50:33 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] PCI: Allow ATS to be always on for pre-CXL devices
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <c715b10b49d50eea5429454108d4221c1a78efaf.1772833963.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <c715b10b49d50eea5429454108d4221c1a78efaf.1772833963.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a27ef65-8724-4506-d3b5-08de7d546470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	FqAQlph1kLTPC3mj6i1zPVpCbsjOQmbKEzgoSXooEMeAK2gcFW9gaj6LZbem6AItbh69May90ac5sKSsvsbVNsH/DHufgmzZB/ULR0Fh4qwuDpYqAaXRrBFBM+gP8fKJ5H8u1i0F7765yg/aYL8vGLhiIrNDXAoidFrlTo95elxm0pJFdMWx3i4ZSuY5EKqAgBHhhXCNPm4mIx2o63kwsYk/rW91BLb/vQuw+uL4OLrI5hZZIG4i7W0eqKj4+Y+f/KI8vxVJDibSlZl3M3kiSc3OqlMZZX9ULFZHE2a26Pw54FPfD1SBtNZSmrAgqgsW2u0jiPtRRiXP85tratOJhaqr1wP3r062f7l1efF9p3XEh0zW7zESeDcRfn+MMx76fcVCyJxe3uST/4wmqzbAMuEAz32QEWNC9IzQ18jgD+HfbIBX6uKMxwdYN0HfF1LUplFSvTjs0lwZU55sPlDGhlTH1fISKCSEhkmTlUtdP8TCHjya0wDPl1vqsGzbLhSxDONPGUOrHOJEUgmQQ4FaTMbGpVzlndwXkAvibkucmj829k/euNdDK9QbWKqyVOAQ7EkHx8u1Dn0fn7vJuk40boNIJMcFb+x6tnsuvyHuNV6hOBICjwNHNEQlzuM+K9wZRu8d5LkCmEUihJ29SWI7O45166Zb/YPBOQAczX2rFlpR0ol3yWEBYgVLoJQII1QCQaTuupvnuBwGY5KuB5u/0Ep9RvCpHp0urMjTddmBYI3xTwCxRg1Ox4dHhcd96VRsz4fM51XAtCJRi3lW/cSffw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eoh4oOXoNd4em/CwtTcIX31qDCfAdcy7QbhJVQJ2jGWRd0VWscY3lnzkbbp+Tmlcf5eKQz4vsl7JgExS1hHm8P7X9uoaMT+fPzl0sN8We9nZJl9oyVkgS88uq4wP2E1mQWhBIf4sZ6+bMsYsbc/qBcptw95gaoF+vj5j2P9tX9PeEN52iVhIzvGFFYQyPmgkdUwyZ6mUAP+iXprmXRLwdcWkSpyId7nYHXoxO7yEh5SHwcOBD/b9ImQMkrInaLVaUqZSKwtH4li14qjFhRA62GFok17621HFDdOTEyf5mGnhjytsePe8Qcd9bXRDfylA1VuLlOGR267eyojnKLKHJ4cdtkDeOIx7i2SQ675HUzXatVs+L6x67MZTbsglG0dqOSy8NKSgyqBElajSaR+oGVMv4Rnct9VT1JfwqhTAIyTTBHL3hXM68ayc6E1ZPhD6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 20:50:54.7490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a27ef65-8724-4506-d3b5-08de7d546470
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828


On 07.03.26 00:41, Nicolin Chen wrote:
> Some NVIDIA GPU/NIC devices, although don't implement the CXL config space,
> they have many CXL-like properties. Call this kind "pre-CXL".
>
> Similar to CXL.cache capaiblity, these pre-CXL devices also require the ATS
> function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
> v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.
>
> Introduce pci_dev_specific_ats_always_on() quirk function to scan a list of
> IDs for these device. Then, include it pci_ats_always_on().
>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Tested-by: Nirmoy Das <nirmoyd@nvidia.com>

Reviewed-by: Nirmoy Das <nirmoy@nvidia.com>

> ---
>   drivers/pci/pci.h    |  9 +++++++++
>   drivers/pci/ats.c    |  3 ++-
>   drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
>   3 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 13d998fbacce6..13fa71f965900 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1150,6 +1150,15 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>   }
>   #endif
>   
> +#if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_PCI_ATS)
> +bool pci_dev_specific_ats_always_on(struct pci_dev *dev);
> +#else
> +static inline bool pci_dev_specific_ats_always_on(struct pci_dev *dev)
> +{
> +	return false;
> +}
> +#endif
> +
>   #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>   int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>   			  struct resource *res);
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index cf262eb6e6890..e6995b536ad4c 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -243,7 +243,8 @@ bool pci_ats_always_on(struct pci_dev *pdev)
>   	if (pdev->is_virtfn)
>   		pdev = pci_physfn(pdev);
>   
> -	return pci_cxl_ats_always_on(pdev);
> +	return pci_cxl_ats_always_on(pdev) ||
> +	       pci_dev_specific_ats_always_on(pdev);
>   }
>   EXPORT_SYMBOL_GPL(pci_ats_always_on);
>   
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 48946cca4be72..21451e62f284e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5714,6 +5714,32 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
> +
> +static const struct pci_dev_ats_always_on {
> +	u16 vendor;
> +	u16 device;
> +} pci_dev_ats_always_on[] = {
> +	/* NVIDIA GPUs */
> +	{ PCI_VENDOR_ID_NVIDIA, 0x2e12, },
> +	{ PCI_VENDOR_ID_NVIDIA, 0x2e2a, },
> +	{ PCI_VENDOR_ID_NVIDIA, 0x2e2b, },
> +	/* NVIDIA CX10 Family NVlink-C2C */
> +	{ PCI_VENDOR_ID_MELLANOX, 0x2101, },
> +	{ 0 }
> +};
> +
> +/* Some pre-CXL devices require ATS on the RID when it is IOMMU-bypassed */
> +bool pci_dev_specific_ats_always_on(struct pci_dev *pdev)
> +{
> +	const struct pci_dev_ats_always_on *i;
> +
> +	for (i = pci_dev_ats_always_on; i->vendor; i++) {
> +		if (i->vendor == pdev->vendor && i->device == pdev->device)
> +			return true;
> +	}
> +
> +	return false;
> +}
>   #endif /* CONFIG_PCI_ATS */
>   
>   /* Freescale PCIe doesn't support MSI in RC mode */
