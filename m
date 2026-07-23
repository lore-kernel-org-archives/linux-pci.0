Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327522D3739
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822047; cv=fail; b=OI/SegEbEj8AVLYiIDPlRW0ojcfXVLA88W9sXKODqJ9SjTLhhWG9jD0XtCGPA5yP+q6Jn6AOCFAuT/DVx+qhtGhLshK3u2H8Agr8EjkrASR/hlSK7dQhNdJ/zcg4VKi1BqX5lym5Ycxf2cG63ihvhJw2XjbZlSBmpigOdwekiQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822047; c=relaxed/simple;
	bh=yuKzIIweMdvONeFud8muNOVzetACHrCxuEuyR6wr4B8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGz2Q/pyJdHU8dVn8yf2ecxsthIwAmNI04qoeG7aivB5S85LzxSkzw7E0yHlA9OV8w/vW6inNScKTSzcz0S+1hEiVZaaRylf5Bt7VWsKi9JCZhKoa341mDVGbp1crgZZTyzmLnUdCYG/Y62dck/qNTFWjxZZka+84sK9zkROioY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OnD9SSr0; arc=fail smtp.client-ip=52.101.61.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OnD9SSr0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSAzHphjRTRqmA8RU843Zxulq5vWu6aM4GDpJgvu0V4c81/YDZN8rGrauNdUi1tYiamj6sn0Bm2DCdVTsDLtVHX5UypyWDm5nQkaCQbOU/zxxzv7OP4wpJ1KvgSkAqV1Usms+D/t3Xy/bE3Z+iy1J5srWSXe7nym81lFMyTvp0po5FaGhiWhRlsI3cv5nyDhktWefqorB2OMIL8PHbr53HfpbHkyO8mQzr2tII9JOWZcVHG7woPPXTBem4lsi0h8Vxr9iOzXIL+hp1MAcAyrnpuTZYhmNK9V5BLM8MiK99f2HL6VswMgyb/Gk7ernCypGgQPwuKkPsC2W/WFIvEOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5hy7VN9zs3FPQk4oJHMVZhSNcs3qckAseIOk18Y66c=;
 b=rV1fcDnbrtp6TqTqFDq2HWfjYVlqdPHGggKbDm0dMLngbyg8qDGe+ejbnr/2h9opHr/5r5fMzqn0WDXKqhplyjzxdIGGwQZ17IxczxcJ9b/V3RZFBzpVSr7SRvqRkL33WcL61EFhsUJLtYPFw/sKqR/qcHg4/Z8/9m3DfgLgaroiEtC6iewl36FxJ42FCXhOJp1Gizwr2qBhiUNsonFUhDAVyVAsVHNLI2JeonU1gloK7kkyEnObbd3NCiBFBIj+zKVuQblqCjSOtpM6fWchHO6tBUfVRE98321mo1y+jWWgARwuvHcU8K1TNjpndVfTAcgvjobWc9tbbWWRnLO3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5hy7VN9zs3FPQk4oJHMVZhSNcs3qckAseIOk18Y66c=;
 b=OnD9SSr04sICc2fl5gNtfQpalG7H3PRAr3Jova6rPw46vLxpk2zFXT5XHAMApAYrQ3Ykjy4cU8EVYzl0Nm0697U6mPtZmD+baEKmMI0emTciFopwIwFUnRm4EIf69MrbviuLlPE4uesZYqkYpIbT8+euxb3FEArYrCHWudgxJyg=
Received: from PH7P220CA0166.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::13)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:54:01 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::23) by PH7P220CA0166.outlook.office365.com
 (2603:10b6:510:33b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 15:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 15:54:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 10:53:59 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 10:53:55 -0500
Date: Thu, 23 Jul 2026 15:53:50 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: <iommu@lists.linux.dev>, <joro@8bytes.org>, <linux-pci@vger.kernel.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>,
	<bhelgaas@google.com>, <alexander.deucher@amd.com>,
	<mario.limonciello@amd.com>, <jgg@ziepe.ca>, Amandeep Kaur Longia
	<AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <e6uoop5wg2ajfn26ot4re3cjz4iz5lhgmoq5epigf6nyerp5br@avxnfnuhh2hn>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723061548.10187-3-vasant.hegde@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 8569c53b-62b9-4159-d862-08dee8d29ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|20046099003|4143699003|11063799006|56012099006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b7croMSYaaBrops02aqpa/a4cUOUNEs8T5xWms+DTNlzYgfPrnq2FyFrTTI9jyzogbaUU2Rf0NqTFNMl8kaNuYhgJtNWtqa2vT2zKt8EjSx1o2i6xAfoys6WGhVxWRLP1O2NzWr9ETl4bhBjE9LMzOYh+w0IBJ0kqm7jlhfumXV/8/3ps+fZoL8rxXIYG7Na1uOGbDEMN3UwiTVazdSAUfZ1rt5azC7yOSkWq88rnayXukM5UhFlyV2bV8WyEQxIXRjkkI7mxxaqlnak1nP4NIGYct8cIcNhfwO+dCgmslGNila9JItEe3b8fRgdzbkl3PRlS9VpLSrgpCQHrDbof7bUCTodGEGSpzbxQkcyqNesT9KVN/rl2++lPmVt4vbvR0ueTkEvH47ZcYGOeHMlg5wJeMjzQFsIIwONb3rsXDtOmo24TW2AbNypXFg8OTa9pXFG3fBzT8t1E6w3B9ESz8tuUEDJsIcqL+j4cQXM0Zr32lcg84B2X2mIoVGw8D5r2EDfdmwt6HfjvPcB5SNg9/LjZzgv1Hypqrm43nACelaYCn3UAVSR1lVR9XuFHNSnvFl+yaFePC0ZXa0H5B/AwL4NlTOgB4KzWVYlpDM2DHLxYPBA9rShtu74yJJR2y9w44VMI3SyIvCZGVjuEPRy4Rf0AaG1KqQVCdEXXvsvozr8/7+y408odjTw/5PedLM1UgPduX71dE43h2GkdRBBMA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(20046099003)(4143699003)(11063799006)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SHrSG62JRyYodSoJTm0uEkgfkKtJF71DUDVsfQVd/NnbULzbHntJcXICCLfzpt53t6L67c+9TZMiEbR8yLqOsJm5ngFKegSkwoJgnHYG3qKwrs0MVLKMN8j1nAjoKw77Mc0AC+yftJNb8XdLAPzUf37T2G1LqWvNR8Ql/WGqPsnM/aKcjtcdGTR48cOXU7Fh85FjdaUW/BSaAfniSc80Csftpqd2S8jPlNIiqH7XmJrr//SC7d7qetdYo1bGSgxu06b+bG0bJbWI3UQO5tAKfnvUGGZnQPwlK1rGSKSUjxeyYM4K+pFrYnO2ZGuoXlGqWM8FTr9YnbDITW/7s1bP1gks1o3mInUzAzQsaKGHXbxzzpirZ+1VLDnTAfwAFqLoa/oYJW+Rjq32XW2tcpuPYJOSN2ZDLISq4xFKEP3Ykgdfk8RRyZ7AHmZOgCho1woR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:54:00.1450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8569c53b-62b9-4159-d862-08dee8d29ca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977

On Thu, Jul 23, 2026 at 06:15:48AM +0000, Vasant Hegde wrote:
> Certain AMD GPU's must always be in identity mode. Currently its enforced
> using PASID check. It worked fine as most GPU's has PASID feature. But
> this means, identity mode enforcement is done for all PASID capable devices.
> 
> Previously it made sense as domain allocation API
> (iommu_ops->domain_alloc()) was just passing domain type. So it couldn't
> check device capability and decide best suited page table type (v1 or
> v2). With recent enhancement to driver code, it uses
> domain_alloc_paging_flags() ops for all paging mode domain allocation.
> This can check device/flags and allocate best suited page table (v1 or v2).
> Hence fix amd_iommu_def_domain_type() to force identity mapping for selected
> GPUs only.
> 
> With this change system booted with DMA translation mode will select:
>  * Guest (v2) page table for PASID capable device
>  * Host (v1) page table for non-PASID capable device
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Tested-by: Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 56 +++++++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 563f9c2672d5..fe642e33c87d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3112,6 +3112,32 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
>  	return dev_data->defer_attach;
>  }
>  
> +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
> +{
> +	struct pci_dev *root_port;
> +	int class = pdev->class >> 8;
> +
> +	/* AMD GPU vendor ID */
> +	if (pdev->vendor != PCI_VENDOR_ID_ATI)
> +		return false;
> +
> +	/* GPU class */
> +	if (class != PCI_CLASS_DISPLAY_VGA &&
> +	    class != PCI_CLASS_DISPLAY_OTHER)
> +		return false;
> +
> +	root_port = pcie_find_root_port(pdev);
> +	if (!root_port)
> +		return false;
> +
> +	/* If bridge vendor is not ATI then its APU and force IDENTITY mode */
> +	if (root_port->vendor != PCI_VENDOR_ID_ATI)
> +		return true;

Hi Vasant,

For a discrete GPU, pcie_find_root_port() may walk up to the system root port. 
On an AMD platform that root port is vendored PCI_VENDOR_ID_AMD, which is not ATI. 
so this device will be forced to identity.
Is that a valid scenario?

-Ankit

> +
> +	/* Rest all are dGPUs and works fine with DMA mode */
> +	return false;
> +}
> +
>  static int amd_iommu_def_domain_type(struct device *dev)
>  {
>  	struct iommu_dev_data *dev_data;
> @@ -3120,20 +3146,28 @@ static int amd_iommu_def_domain_type(struct device *dev)
>  	if (!dev_data)
>  		return 0;
>  
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
>  	/* Always use DMA domain for untrusted device */
> -	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> +	if (to_pci_dev(dev)->untrusted)
>  		return IOMMU_DOMAIN_DMA;
>  
> -	/*
> -	 * Do not identity map IOMMUv2 capable devices when:
> -	 *  - memory encryption is active, because some of those devices
> -	 *    (AMD GPUs) don't have the encryption bit in their DMA-mask
> -	 *    and require remapping.
> -	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
> -	 */
> -	if (pdev_pasid_supported(dev_data) &&
> -	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> -	    !amd_iommu_snp_en) {
> +	/* Apply device specific quirks */
> +	if (quirks_force_identity_mapping(to_pci_dev(dev))) {
> +
> +		/*
> +		 * When memory encryption is active, some of these devices
> +		 * don't have the encryption bit in their DMA-mask and
> +		 * require remapping.
> +		 */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			return 0;
> +
> +		/* DTE[Mode]=0 is prohibited when SNP is enabled */
> +		if (amd_iommu_snp_en)
> +			return 0;
> +
>  		return IOMMU_DOMAIN_IDENTITY;
>  	}
>  
> -- 
> 2.31.1
> 
