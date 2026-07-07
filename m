Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A933993;
	Tue,  7 Jul 2026 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783388749; cv=fail; b=SlMQ/MKva6V8t5hIUEtAsq0BHW6n8BJKgJQ+36g35XvlwR+T5X1iJzQZEg/2yfKNaaRnrwlq49dnLy4ENG141oC/Tdku3a5LyEOQ9QQS26QbPB+eF0hzWDTtyZw1i1Mh0+VPQQGxKfxxZuTKqni2nUrj5m92oDg6ITGLiXVOiEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783388749; c=relaxed/simple;
	bh=z0zv48Z7nnBH7DaaK4XIEWrwHc8TtxnnzJuTHV4oWgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G87ZkRiv6KZzUjaMEeabhhwfYOCl21yCP2xNgCkUdkHqvkXhcn0GRSmN2NDj2IyF1lCusYH+CvAUu55ikJrXB11cRO/J7UTjeFn+nQwOfb9+IpZ76j7fSN9SFAUZzWakr40nNw/Hec7aBo+p8wNd1mBvkU/mOUDAEJ3dv30X53o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kub/AAkO; arc=fail smtp.client-ip=40.93.194.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kub/AAkO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHnsKzgfpLTIuoJuBIplckNAiqplwHYGuTYpP801l+EOlsTfId3iJUwofacI260ekbV0WrYSWiKV4sRHHmpbOuz4X8aZ8r/Kq91oDigYbB5uGDLAsz3Hbpw7PP2WKp8wkZqAw9OBqFQshD6jQjxxH/cA/1UEcNibkm3TmG2xvIAuffC9arJONlrwtK9GPRwqff2hs4miUE9C6Q8AKVPhx8jjiM/tcy3jRUtx98rSj/e6kE3FQ7pi/M4eaMdJJhjzelmbqo51bHf3sgYRe+OyGQDKMabKcjtzEHjabEjmGR7unLIuU79eWUsQU0+sZZho6OAD+SUBOhLLY8Rp1efEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euWLbVzvTiI2sS+FZxypiJphXMBvm37znmFKbSZXWGo=;
 b=ykDuprOWnB7cO1vVDGpU/04ugH9QDgS9MIQB3edjX87Hmmr6kZv8gciF3jol8soOwhK/nb6dB8r7uLjd09yK0m/Ot2wmZk93I3xoRrFSQFhJTkSiyw2GAgzmXoJbtizrx7oh2vTWYrjIl8UG3CO5uqK6+05xbPIvQKueS5nvqD+hxJtbJ93iNUIfSkM9Mot0xnzwyyZIM2mGNUaLEmfxon6n8IJ6aj4Pr8xkEZ/KVLj8wMujqa0MVdrh5XPtY/qLX9W1NodY6CqAe0dHyRnzcKPLObSOjWx8JEJAAbMLtMy2nAtnImTrqiMoAtNOQFG/KGSKP4otTa7DTdKL/fhSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euWLbVzvTiI2sS+FZxypiJphXMBvm37znmFKbSZXWGo=;
 b=Kub/AAkOQzSlFjy6RkJf3aMWtrPx98yYwIZwxeT2HDbFIr4urbkuE7/wvPpwemNzF2crTfmVMyi8ywstOuh3YGcyK9g1+MmtA7NiWgeMARczDYhNSBSCSd6oGFTkKRNytBobS/KtkBCz75Kk1i30xJYhs0IO5t55gydG8cRInI6A3DHNtiWVquPnWnb5R9EhbIsW6waAfAT/zkF/8kuswdZqEI+Ct4qBuVOrmJk/qplNvF56uDSbKv+Du3IODb4hAER8+VSsuMtAsF/Wrqjc1MBddd/rtB2elmXw3IzPnY57O3X0/nW5nd9sJs7rFsMW47mhQDWBykiWM4/67PMoCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 01:45:41 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 01:45:40 +0000
Date: Tue, 7 Jul 2026 09:45:33 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Dan Williams <danwilliams@nvidia.com>, 
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, 
	Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 07/10] PCI/CXL: Discover the CXL reset scope
Message-ID: <akxYmEuXX7W1v5DS@MWDK4CY14F>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
 <20260703220508.546528-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703220508.546528-8-smadhavan@nvidia.com>
X-ClientProxiedBy: JH0PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3ceec7-9089-4f4b-9ba4-08dedbc97302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|5023799004|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	mBRzDDOoLbjmh19tEuuYY2e120uEDKVWtmrl73MxvNtgvHEU8sjRJ7waGQhue49OE85Xarc7hUpi51fPA9TDx6Oxo0z1tav7RLRoFFYHaf+PmgUO/A2UqZ0/oq/irBFWcDUwlXoluwSXLsbw/NxewLudMLtq7GUHtaqOwGEt4WoU1naE6s1hoe+FACp2bmW4+9cey/qgi6SyVsw6+6LKmEIFna/6I2BvrQL3+KrSWl1dR58h4BD/QX4sIIGc6Og62LWYbqY9jz904+qxWIzORrk71JqltDX9BjsxDhjp172CuRNbVr9QSFt4QGkmqV/T6MSVBCP9hHsqRzaS77C8ic5WTl/s3R5GPAimJXevaqfYH9lIn9D4HK5qY5bQdNgpaduwnMGIEqgFvGS5xLIryN5evi9wGVyLBnkwAA+ghZTX6Up653GqiW/SJN1c1EC7nt/3gUPqXFXeQD0xKJtWzTQOTRaxjNy29docdcpKTVCWcSg8Rkd3UPa5VABTMxHjf0Tve0TpJPltjc2DFeBfPQJB4JHOGA04DqvJJLPYwhGyW0tCaw6nx26ZhtZA9jwlgnqpXxnAg0KaCEpah39cWkz7KRkEgYRuG0Ju0QQUlNvUpa8xwvq2Gtj9DFfNqNaHvalZtoXX1xObKtgCeECX+Rgqv32qM2lbQfV2VkG6re4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(5023799004)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1L2qbQXUX5FDqMRzVtXX/DQYOG0pcVeGtfL2y0wMJHz0oFKWQHPEg2INGPpF?=
 =?us-ascii?Q?MPviEYq066+nJ/dVxzkgQ+hsPLLQM8J1KniALd89WYEyuoHCbpoQ8I18VITS?=
 =?us-ascii?Q?pn0DvwpMs3FOXwLp2Yl0Y6aBCdViKdxLKtTLhOuPSjyQg/TBJfzRI2Dn1xuT?=
 =?us-ascii?Q?Pd9hKXGJYajXXFAp9xdO4rFlIqSSIOV+50EyO1kR4TT7KVYBtk+I5Hqa/oZ3?=
 =?us-ascii?Q?rTbnqyZVtJm3y+f2PY+HXoig585rNRwYYk7lp44t3ERyob+uQcMEH8H+A0NT?=
 =?us-ascii?Q?DJIqDAp1H5cr899IZdoLFtp0JswPo7fZTBVpkCvSV3JTa29hXbOEoTl6Z0xb?=
 =?us-ascii?Q?HrFkAEOnq7nyABs1GOWsFOFUUWsAy56nto06JV6FsySMpY8cPj7cVqQGLRju?=
 =?us-ascii?Q?J8Ii3vYjOu3hMkscblmN69INw9hmEcDXlTc7gv7Jopz5D4xmjgh2t7pu7H+4?=
 =?us-ascii?Q?ChF354OSavZgK2AZ+K9CWu9Xu9esAPRVMQ7Nipy7I62Ej9JfXJkWO2aD3Jfm?=
 =?us-ascii?Q?HAzG98yy0+jixoFTYzGcSwpuVrkzNZryGl1aw0FuOfXXYolEKdjNi7LR5uGC?=
 =?us-ascii?Q?ytQTpdCrdxHMd7CIiz891HkgiqBilMlZjUaluhw5ANfEAC+1YrsbmCmo9cYb?=
 =?us-ascii?Q?TvkwKQL+oe+NYn1EMSFy2kcCh6ZAdFIX9TPSyHY+DMFgQKf8v46add6TGGzO?=
 =?us-ascii?Q?vFDdBtOL7P3zdLYQsmkejCb6TjScoVj4ahKHYKGjEpaY4WDKpAYFuYWiu3yV?=
 =?us-ascii?Q?8s4jPgn72u1Eg3aWBehO6hkebDIU4do5az2Feu6on/O7hpoWvgaFXxEy0riD?=
 =?us-ascii?Q?UqdkwZawb+kfPN9lYpDZgyi1kCu6gWDpnv78EpFfGPdLBtHb+wvKe4Bjx0nV?=
 =?us-ascii?Q?b9qsZASXOxD/Y1W6ezqEsG1DI/OGldIsA/EbH/Cy2mNEx0eLEPe3/lCD7zuR?=
 =?us-ascii?Q?re6hi9wDXkXI95qLZSWgpmIEU+rsc1m6piu79uqzMI+i5ap1YSAfQVTM8aHA?=
 =?us-ascii?Q?K3IGLYR0E28fg9lODxrMCViWSFkoGEfyCer8Hyz/Qp1Q4veFS+scL1WjY5nR?=
 =?us-ascii?Q?7C7FoQnN0IcC6AnfE46GGd4aq2UIqQ/9+D3jwAHYsPF2b7D02C+cwwb8GOff?=
 =?us-ascii?Q?sXQA5o7/FvnlvLoYHYTCZkRxVCUBFJkcJsetDpHAWF+7uY0SCmlm7Fn1KnS3?=
 =?us-ascii?Q?Apmfx93/RuBfkJVi4bdapWIX9fJTc+c7pXETLGFFxNqs1/mw70ue/AL69U8q?=
 =?us-ascii?Q?2P66wMYYcgShc1Jggkfix5SY2GBhEXx726SRCtYiMhKORKkixVhqAPmllJFv?=
 =?us-ascii?Q?OSgI+chqSnIMdVvy0VGdj5l6YTU8vViOsrwPVgYWbJy+zHs10kbQmMbpxggB?=
 =?us-ascii?Q?AYlUvWRrdbfUptRZJ8ZjKjyEcmGz9mGgg9pW3Rfv1f5tIohzqWXiQo4W5rbY?=
 =?us-ascii?Q?1ayNWnqj9rIkmqsifzcHMC8S0g5dLKgcFofHcCln5tDE1MEy381yTU0ENHOL?=
 =?us-ascii?Q?3/UjECWxYn3OJjVI4CC2fF+lE4Pe1r3S2VDDkliY+22P3XOkVlw9uev9As8W?=
 =?us-ascii?Q?/xmlUSzlImf95V++m86mSl3exuRTutGjXnpWSvvVfk3IVniVCycWUMBVWeJd?=
 =?us-ascii?Q?S1fpl8C+HijOlKIqJtIUjGOL189LDsBBXR6RMlw0Hc3mOMojEHEU3+45n0c2?=
 =?us-ascii?Q?cfpaI71Twx1M+WRcESpbCaE1u68i/g8DhibKxr2Jxd6XYMoFlOUEOLsoRXu9?=
 =?us-ascii?Q?3H00S5Igpg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3ceec7-9089-4f4b-9ba4-08dedbc97302
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 01:45:40.1403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpML9JCTsbkplhIQYCgdAaIacNRpzopOsneVLkKjJRLQpdOBcTXez1te3jhbPOr6Uj9eiPxTGudGxjuoQv1maQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239

On Fri, Jul 03, 2026 at 10:05:05PM +0800, Srirangan Madhavan wrote:
> Add reset context support to validate that CXL Reset is function-scoped
> before advertising it as a PCI reset method. Use the Non-CXL Function
> Map, ARI/devfn rules, and CXL.cache/mem capability bits to reject reset
> when another same-scope function would also be affected.
> 
> If the Function Map cannot be read, warn and conservatively treat all
> candidate same-scope functions as CXL-capable for scope validation.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/reset.c      | 153 +++++++++++++++++++++++++++++++++-
>  include/uapi/linux/pci_regs.h |   1 +
>  2 files changed, 152 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index fb741b66e502..8e80e7588046 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
> +#include <linux/bitmap.h>
>  #include <linux/delay.h>
>  #include <linux/bug.h>
>  #include <linux/bitfield.h>
> @@ -469,6 +470,21 @@ static const u32 cxl_reset_timeout_ms[] = {
>  #define CXL_CACHE_WBI_TIMEOUT_US 100000
>  #define CXL_CACHE_WBI_POLL_US 100
>  
> +/* CXL r4.0 sec 8.1.4 defines 256 bits of Non-CXL Function Map. */
> +#define CXL_RESET_MAX_FUNCTIONS 256
> +#define CXL_RESET_FUNCTION_MAP_REGS (CXL_RESET_MAX_FUNCTIONS / 32)
> +
> +struct cxl_reset_context {
> +	struct pci_dev *target;
> +};
> +
> +struct cxl_reset_walk_context {
> +	struct cxl_reset_context *ctx;
> +	DECLARE_BITMAP(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
> +	bool ari;
> +	int rc;
> +};
> +
>  struct cxl_hdm_range {
>  	struct list_head list;
>  	struct pci_dev *pdev;
> @@ -480,6 +496,137 @@ struct cxl_hdm_range_context {
>  	struct list_head ranges;
>  };
>  
> +static void cxl_reset_context_init(struct cxl_reset_context *ctx,
> +				   struct pci_dev *pdev)
> +{
> +	*ctx = (struct cxl_reset_context) {
> +		.target = pdev,
> +	};
> +}
> +
> +static void cxl_reset_read_non_cxl_func_map(struct pci_dev *pdev,
> +					    unsigned long *map)
> +{
> +	u32 words[CXL_RESET_FUNCTION_MAP_REGS];
> +	int dvsec, reg;
> +
> +	bitmap_zero(map, CXL_RESET_MAX_FUNCTIONS);
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_FUNCTION_MAP);
> +	if (!dvsec)
> +		return;
> +
> +	for (reg = 0; reg < CXL_RESET_FUNCTION_MAP_REGS; reg++) {
> +		int rc;
> +
> +		rc = pci_read_config_dword(pdev,
> +					   dvsec + PCI_DVSEC_CXL_FUNCTION_MAP_REG +
> +					   reg * sizeof(u32), &words[reg]);
> +		if (rc) {
> +			pci_warn(pdev,
> +				 "failed to read Non-CXL Function Map; treating same-scope functions as CXL\n");
> +			bitmap_zero(map, CXL_RESET_MAX_FUNCTIONS);
> +			return;
> +		}
> +	}
> +
> +	bitmap_from_arr32(map, words, CXL_RESET_MAX_FUNCTIONS);
> +}
> +
> +static int cxl_reset_func_map_bit(struct pci_dev *sibling, bool ari)
> +{
> +	if (ari)
> +		return sibling->devfn;
> +
> +	/*
> +	 * Without ARI, the Function Map is organized as 32 device slots per
> +	 * conventional 3-bit function number.
> +	 */
> +	return PCI_FUNC(sibling->devfn) * 32 + PCI_SLOT(sibling->devfn);
> +}
> +
> +static int cxl_reset_read_cxl_cap(struct pci_dev *pdev, u16 *cap)
> +{
> +	int dvsec, rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENODEV;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, cap);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		pci_warn(pdev, "failed to read CXL capability: %d\n", rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_has_cache_or_mem(struct pci_dev *pdev)
> +{
> +	u16 cap;
> +	int rc;
> +
> +	rc = cxl_reset_read_cxl_cap(pdev, &cap);
> +	if (rc == -ENODEV)
> +		return 0;
> +	if (rc)
> +		return rc;
> +
> +	return !!(cap & (PCI_DVSEC_CXL_CACHE_CAPABLE |
> +			 PCI_DVSEC_CXL_MEM_CAPABLE));
> +}
> +
> +static int cxl_reset_validate_function_scope(struct pci_dev *sibling,
> +					     void *data)
> +{
> +	struct cxl_reset_walk_context *wctx = data;
> +	struct cxl_reset_context *ctx = wctx->ctx;
> +	struct pci_dev *pdev = ctx->target;
> +	int fn, rc;
> +
> +	if (sibling == pdev)
> +		return 0;
> +
> +	if (sibling->bus != pdev->bus)
> +		return 0;
> +
> +	if (!wctx->ari && PCI_SLOT(sibling->devfn) != PCI_SLOT(pdev->devfn))
> +		return 0;
> +
> +	fn = cxl_reset_func_map_bit(sibling, wctx->ari);
> +	if (test_bit(fn, wctx->non_cxl_func_map))
> +		return 0;
> +
> +	rc = cxl_reset_has_cache_or_mem(sibling);
> +	if (rc < 0) {
> +		wctx->rc = rc;
> +		return rc;
> +	}
> +	if (!rc)
> +		return 0;
> +

cxl_reset_has_cache_or_mem() treats a sibling with no CXL device DVSEC as non-CXL, but according to
spec, it places the DVSEC only on Function 0, the sibling function can participate under fn0's DVSEC
with no DVSEC of their own. The non-CXL Function Map should be authoritative for classifying siblings
rather than a per-sibling DVSEC read.

What do you think ?

--Richard

> +	wctx->rc = -ENOTTY;
> +	return wctx->rc;
> +}
> +
> +static int cxl_reset_validate_function_scoped(struct cxl_reset_context *ctx)
> +{
> +	struct pci_dev *pdev = ctx->target;
> +	struct cxl_reset_walk_context wctx = {
> +		.ctx = ctx,
> +		.ari = pci_ari_enabled(pdev->bus),
> +	};
> +
> +	cxl_reset_read_non_cxl_func_map(pdev, wctx.non_cxl_func_map);
> +	pci_walk_bus(pdev->bus, cxl_reset_validate_function_scope, &wctx);
> +
> +	return wctx.rc;
> +}
> +
>  static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
>  {
>  	INIT_LIST_HEAD(&ctx->ranges);
> @@ -890,6 +1037,7 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	struct cxl_hdm_range_context range_ctx;
> +	struct cxl_reset_context ctx;
>  	int dvsec;
>  	int rc;
>  
> @@ -897,8 +1045,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (dvsec < 0)
>  		return dvsec;
>  
> +	cxl_reset_context_init(&ctx, pdev);
>  	if (probe)
> -		return 0;
> +		return cxl_reset_validate_function_scoped(&ctx);
> 

This only runs on the PCI_RESET_PROBE path, but pci_init_reset_methods() runs during pci_device_add(),
before sibling functions of a multi-function device are on pdev->bus.
Thus pci_walk_bus() at probe time walks on an incomplete sibling set and passes, the DO_RESET path never
re-validates.
A multi-function Type-2 device would advertise and perform cxl_reset even with a live CXL sibling.
Can the scope be recheck at reset time or gate on siblings actually being present ?

 
>  	cxl_hdm_range_context_init(&range_ctx);
>  
> @@ -907,7 +1056,7 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  		if (!rc)
>  			rc = cxl_reset_execute(pdev, dvsec);
>  	}
> -
> +out:
>  	cxl_hdm_range_context_destroy(&range_ctx);
>  	return rc;
>  }
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 194ae56b4404..7fc1d34fcce7 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1380,6 +1380,7 @@
>  
>  /* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
>  #define PCI_DVSEC_CXL_FUNCTION_MAP			2
> +#define  PCI_DVSEC_CXL_FUNCTION_MAP_REG			0x0C
>  
>  /* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
>  #define PCI_DVSEC_CXL_PORT				3
> -- 
> 2.43.0
> 
