Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793343505;
	b=ndKNLv0IUB9ZjwAs1+zkTdec1lKfIB8jlAoeq+ZfZLTdhBoolwZ3/2cSfazZI60Q2AoK
	 Q34hj8ctoAN8gdPYkW1NGMTwj3qc8qgd0Bm5Dtt8WO0aIQJDy8mGmid/ed1ASo0xv7IMn
	 2b/gKAZYEqLjOpKDtGNdiDas/aZwW6YnX8+S+i07QaDl+EtaCOxTkcUrw/0Vn/7exUsty
	 qImWemCtQEQCin0eb0J1MsY/v/0q/tPUU61Aj9XqKIXV+p6Mapc0l2jrHJEEqhVChYgnb
	 8/WZjR8N3nblnSqvXZJLEX+CWGJL9RckZUTImQKHFnsrJMGAUNB9kVAtG8cMM9sxxqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343505;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/gdf08rPPWl9jQgRDHgYqgi2n1ejGnceitnQivFKKXU=;
	b=N8o3ewH4UGmkXgAQWWItFclR+z/JX8KIj2B7+q5imq709dh/zUmXr4tV4h9SlNWJIjCz
	 1G3R5qSMvLHRk/wllsQAFD8RUXMx/9dDcrWlZa3uRWVia+b8iU9dJ43GHbS2l09hkeg6O
	 rabVo45tK94YYWoXvygsdPhDWY7GOnr4RnuxREpH8OxCN1QYqZEI/BXdX9jQ9PHKyDjGg
	 wXNxuHKV/WExkRB123To7oPTmA1l2gP1SoOl4QdTlkvsP0kJoBEE05iOMN6/TgzMgQ/6D
	 7TUtAPq/9eUyhe8p2dGUGZuxMICqQEDQPyWQDwm9djH3QFSl8FblAtY2Zmqg7/VoyeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RhPAvSIM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.56
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73C606A31A;
	Fri, 30 Oct 2026 06:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C73C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RhPAvSIM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwMiFcFUUg0XdeCt8ro0sRV8de+2xAXfawUXkNJe/Js6QzkiQOchbfyOgILR1OCYtzlamjVyEo/FH+89HntUF3dJiavvo2S7pRzoRv8Og4w3rCiwgNZtGmoLfpgj3ggZXK7zIeDduz2AZ2GoObHhvdbooqDOYW0VsRO0F40uqA+yZDmo25eN5P0TH7NJTaHNMiyqDSlzLSgOYv74C8mesnG5WCxDHlWk02rsm8N2PO7rali5LUnA/nPtMFyFJnsTPbZALKivEV6j7S/ECiiUXcdLPrENrv3HkRlp7X9tVy4VFOHmIJgCF81RHklQ054GIUWGaFsuv5z6ZSANBhp+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gdf08rPPWl9jQgRDHgYqgi2n1ejGnceitnQivFKKXU=;
 b=XUh/RVnGrDHI7KvB/SsMteeA3ElNUWE6JxMNcKMBqTAU4KqlDFwdMmAeU2VCfXAHzh+F1tIpzrkdc2HrSNvKOSjxzCdEqru02VNQ/F8Q6HzM62ygTPynOPUuTQ4p9WS15zj1FVW0754dySSUbIScQjBHedBTSZ8hngzehA9foYciZrnN3eoLBF6dsxp1/Y7pCCh30MgwSITEG1WV9TZUPHkxSG/Fd1sK6DfCDjNRXqgsqb7Rps+UICnBW07WwBp41NJQUUEI+EEsvOfHuUTcsgfsZp0PCcNvgI5POvoNKVGbEgx6M+doj/Wifz5ct7xD7NTba22yc/0uJ7JOwJzEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gdf08rPPWl9jQgRDHgYqgi2n1ejGnceitnQivFKKXU=;
 b=RhPAvSIMG2+qfhU7JJvDI3d1K6ocUlpLEi1LUQ8wV25JFSLGV8L07OGKefWWYn0OVKCPwTa5yw7oBP17JCXK1AeMq3Ft9hjqmoQ0Cb7nOPERYSVSmt55N2EOVbeaGPJ+TdyrF73vsJa2Cgwk+I32BPNwY0aFzWboK89C+uPbyph5x2cIa6ztmHfu+mMlIEL+aZLfgYvBwV7zYdjpX11Fgeugj1Db7GU3DlzCh9J1DUfTr2B70CY/fIqhZVcA8LvgpYDqI/D65WFihsI3Mu0SnVnZS44uMaw1vVFFXzdVx2rnJTe5mba+46/Fdm/GA1M3rLv+3eL0it+6A7oip0j0CA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 06:58:21 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 06:58:20 +0000
Date: Fri, 30 Oct 2026 14:58:13 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Li Ming <ming.li@zohomail.com>, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v16 09/18] cxl: Refresh cached PCI HDM decoder settings
Message-ID: <auQ_8rkmJanX-ghE@MWDK4CY14F>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-10-smadhavan@nvidia.com>
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8bfb26-3480-4662-55ad-08df36532ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DysaEiolVRuHEeoTVIhTk/pS2XPuIvgvcRww2Os5OaXW2JpMNOenzLEMUeV3nQQafivnWG1rEiYmHIHIl4AYa0imzmpCXgTTSQGterzjhT4SOnifpt9ieXgGygKbVvMwg61TewGBWG1rHHCNeCPhWdJTE8dDyrN+bRuYdcgI34Mh3JcnkzM7MEiHJ8XzAGIM4QuD0JxswB2RV3lmbLJXLehwBB/Ba8lxdgtKj6KoNJWnpMTaRrMsd5ECNi1tT7gqxYCQasngAFuMDBj7NNm6FJ5iOIrlOWjcyOf8wJ8CXohOR4Oqfk5W7IJ14KpWUkQ5pKEtOW5+XO6pNtzpvLZ/n6sOaW+XRwb4JT3GdhueY2xmpA6xDNjVMvl/BHEVbjGkhRB8rvHz5yOy8h7Z4cSfRzPtyqPumkAsmhk+pB++B5gk7fPxbGemhiiFThAqVDvN56uiAIs/1RADasxOjvmBN1kXyJJgF5NsjqpzeVmZGCnH5+U9x+jdavXu0kmZJK0VCBsRUbB/6y1TC8QPzxDp2kouiW1gOk3iCzzxU7iUvC5VD9yxBI9hhNW2Ne1Z3SJ1RLSNeabNryzgxgcDGdYrOj/KuelFejUdL+BY2ArvKqSpujU/qGMZ/wZPa6kEhhD+BWl9wCpzNWIoT/oFWnV/w34ehdnUDhtkaJFb2dm0dMQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SyBJOQCjjvr9dEFAuJejBnpiGoIlb2l2pmIisQGrLMk9zvjwbOSBJ7SDfS0k?=
 =?us-ascii?Q?OhRbESDH9yHhvlP6lorQnAk15KKhFQUrINYKEXp5543lrhJ790Z3A7KlVkfs?=
 =?us-ascii?Q?RAAaBvvZdzq/sS2HPW5lJjewP9GKQj/aIjV2/DehOw1ksDg0sWoJF0CyC4Io?=
 =?us-ascii?Q?DdOnd5/TCa53FEDuWKBhUSDJwVJ33S9m80XL0P4Xhf86ZQ1fPABZwMXSnoDA?=
 =?us-ascii?Q?M+Rqa1gbIP7VJWlp0BNX00H3mKCsp9AbmyyIIpyNqvmbW+c4mGqy2ZL6FUpJ?=
 =?us-ascii?Q?7qHc1uW5LkgwYytffHvFWSTwxNiOgjz1H2T443l3uR6KbVzitF9FA6K34FES?=
 =?us-ascii?Q?W1a8SarXaZ8/b+MjCGSCmRporh9OxnmZTMDMeMCo6xw+ZNLfU++tlTSRil6R?=
 =?us-ascii?Q?QRmQJQ0ESWSg0VfqBPSjK2VZSYuBb1mq5eaFrV6PE0G1TQlGhxcEjVd2mDO7?=
 =?us-ascii?Q?URtPHCW78GazCUmMNhuK/XbEwtyN/lO/7dp8hYBnDJpvd+46YoE5vMf4MieO?=
 =?us-ascii?Q?YWSz2K0FcNqwFUFdHRS+xLtnREUmh5z8bTONSmBoxcQ83Ym1k6NJkEu6Fik5?=
 =?us-ascii?Q?wAlgju0a0FcsYZ2q6JaRJacqBcBNgFiB8a9ntkTFSZfOReaH0j8O7dJgC3VC?=
 =?us-ascii?Q?2/j8L8h1GcNu8uLL+/wPQD/wiO7njZL3L1h91laP156TYEv1vRexkwchSN1X?=
 =?us-ascii?Q?+pZxIuBk8vOHGUJ2MqDoRgjMhIukUSaFx9SboJ5suwa+JZ/HCz5wUFx4khnI?=
 =?us-ascii?Q?E1OPI36aI52KNgcnhCHVu7QDji+uBhQIRUcB+V3qMTVZiciFPi0g+bth3zqa?=
 =?us-ascii?Q?OzSWN7Q3XNqo1SVZxPuy3UgtVLQw67t8Pr94RFG9gCFYTz9khhVvZ1u3l5sU?=
 =?us-ascii?Q?kEibif3WJeCtJ+lmf/Lsan1ICtoNhOkMpK/wzAkqNZTf1ziWJvvInodesvyx?=
 =?us-ascii?Q?oJ4dheObqtl1GdkhGGeK9z+puw32BRktIsRPNa7/6MqHu7DKmtAXOuTmskgh?=
 =?us-ascii?Q?WwKPWx2tOI3Ok+jcNG3ZnT/Y6CRzgsVfQEIBRPgDLpncCwBQjOvEoy3isvrR?=
 =?us-ascii?Q?w3BiXomegirAtcZ2U3HlF34nCzPELYuAufgDNxYFdr+y7740E0MmfVhqqwDP?=
 =?us-ascii?Q?FiHopAzaqMc5/oWiH16Oz7cC4q+peAgz7C3zFQpLmHnR0LXYnuGaNKyTHMlX?=
 =?us-ascii?Q?7vr36MqHpBty9oQOQmoatBWQrl3R3ZpuMFe5RMiMrp+PHYoKM+JyDmgT06Tw?=
 =?us-ascii?Q?n/X/1QhfYEMxctTQ/EbqITxQvZVutedGArYLxTQMe+AUz9N42Ch1Q1q8AaBU?=
 =?us-ascii?Q?hFB4bTzW9hdnyV8ydgsOsZzrfEHWCDj7Z/d4cv6+IcC5RnaqJS46UIWqiZyo?=
 =?us-ascii?Q?PsuNbKB+Z0VQUTwb9IyxE1ydC1F2s6g7LGcmnazm3WzyNywR7+IX1MmtkzXP?=
 =?us-ascii?Q?mnV0iOrT7UG59MXO+MlMJhIoSiSJjzfEEic8susNWsa1s1iad9eys51kHAae?=
 =?us-ascii?Q?BbuQZfPYaLXE+wwggHHuZU0+IEPGiDjIwpXTqOnvqZTfvf67WfejeDdLiPDL?=
 =?us-ascii?Q?YPlpgXxVKp5Q30R5KqZACsuS7NFxqSZfM/mKIQFdZ9Y7ekiPhosjzKJieQyP?=
 =?us-ascii?Q?St8h+EEGQtb/mFAW64w/QXa7rItVw351L6ILOGQKOTRinm6UfEXzbK5p8KeN?=
 =?us-ascii?Q?wDeoUwzjkGBFflE2EzVeZJLV+BDh7duS/mwIKSnA/6CrUKx3tcnr62s5IdZD?=
 =?us-ascii?Q?89/OD6tXcQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8bfb26-3480-4662-55ad-08df36532ea9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:58:20.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIZPbWRp2TCq8oQfnbuDHxZpIyuaveAeGEvtPC0ZCRs+uBN/4wD2CfqT94wcg4TafNw/HL4x+UnpY5toQcgG9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854

On Thu, Oct 29, 2026 at 02:56:54PM +0800, Srirangan Madhavan wrote:
> Early PCI discovery creates the HDM cache, while later CXL enumeration and
> decoder operations provide updated programming state.
> 
> Refresh the PCI snapshot when decoders are enumerated, committed, or reset
> so reset recovery need not walk the CXL topology. Keep cache access and
> locking in the built-in HDM state helpers. Ignore updates when no cache
> exists and reject decoder-count mismatches.
> 
> Use CXL_RESET for the PCI HDM cache. Shared HDM register helpers do not
> require it.
> 
> Skip cache checks and updates for DVSEC-emulated decoders, which do not
> use HDM registers. Keep cached global control when MMIO reads return all
> ones.
> 
> Non-PCI mock ports have no upstream PCI device, so the cache helpers
> ignore them. This avoids test wrappers and a circular dependency between
> cxl_core and cxl_mock.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
> 

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=50a88f5194e5df38590d413f925d8d5afa8a8488
> ---
>  drivers/cxl/Kconfig          |  5 ++++
>  drivers/cxl/core/core.h      |  1 +
>  drivers/cxl/core/hdm.c       | 34 +++++++++++++++++++--
>  drivers/cxl/core/hdm_state.c | 57 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c       | 24 +++++++++++++++
>  include/cxl/cxl.h            |  1 +
>  include/cxl/hdm.h            | 32 ++++++++++++++++++++
>  include/linux/pci.h          |  6 ++++
>  8 files changed, 158 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 80aeb0d556bd..8b08bfdc4982 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -6,6 +6,7 @@ menuconfig CXL_BUS
>  	select FW_UPLOAD
>  	select PCI_DOE
>  	select FIRMWARE_TABLE
> +	select CXL_RESET
>  	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
>  	select FWCTL if CXL_FEATURES
>  	help
> @@ -244,3 +245,7 @@ config CXL_ATL
>  	depends on ACPI_PRMT && AMD_NB
>  
>  endif
> +
> +# CXL_BUS requires the PCI HDM cache and built-in state helpers, even when modular.
> +config CXL_RESET
> +	bool
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index ea539f00e55d..e34d574f6594 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -224,6 +224,7 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>  
>  struct cxl_hdm;
> +int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm);
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
>  int cxl_port_get_possible_dports(struct cxl_port *port);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 85f9abf58a42..ec387070d7ad 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -725,6 +725,24 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
>  }
>  
> +static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
> +				    struct cxl_decoder *cxld)
> +{
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +
> +	if (!hdm)
> +		return;
> +	if (!is_endpoint_decoder(&cxld->dev))
> +		return;
> +
> +	pdev = cxl_port_get_uport_pci_dev(cxlhdm->port);
> +	if (!pdev)
> +		return;
> +	cxl_hdm_cache_refresh_decoder(pdev, hdm,
> +				      to_cxl_endpoint_decoder(&cxld->dev));
> +}
> +
>  static void
>  cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
>  			      struct cxl_endpoint_decoder_settings *settings)
> @@ -805,6 +823,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	}
>  	port->commit_end++;
>  	cxld->config.flags |= CXL_DECODER_F_ENABLE;
> +	cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  
>  	return 0;
>  }
> @@ -877,6 +896,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>  
>  	cxld->config.flags &= ~CXL_DECODER_F_ENABLE;
> +	cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  
>  	/* Userspace is now responsible for reconfiguring this decoder */
>  	if (is_endpoint_decoder(&cxld->dev)) {
> @@ -1079,13 +1099,21 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	struct cxl_port *port = cxlhdm->port;
> -	int i;
> +	/* DVSEC-emulated decoders do not describe the cached HDM registers. */
> +	bool emulated = should_emulate_decoders(info);
>  	u64 dpa_base = 0;
> +	int i, rc;
> +
> +	if (is_cxl_endpoint(port) && hdm && !emulated) {
> +		rc = cxl_hdm_check_decoder_count(cxlhdm);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	cxl_settle_decoders(cxlhdm);
>  
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		int rc, target_count = cxlhdm->target_count;
> +		int target_count = cxlhdm->target_count;
>  		struct cxl_decoder *cxld;
>  
>  		if (is_cxl_endpoint(port)) {
> @@ -1120,6 +1148,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  			put_device(&cxld->dev);
>  			return rc;
>  		}
> +		if (!emulated)
> +			cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  		rc = add_hdm_decoder(port, cxld);
>  		if (rc) {
>  			dev_warn(&port->dev,
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index c9cc019902ef..d4c2be1ef833 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/pci.h>
>  #include <linux/rwsem.h>
>  
>  #include <cxl/hdm.h>
> @@ -13,3 +15,58 @@ struct cxl_rwsem cxl_rwsem = {
>  	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
>  };
>  EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
> +
> +void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
> +				   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_endpoint_decoder_settings *settings;
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct cxl_hdm_info *info;
> +	u32 global_ctrl;
> +	int id;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	id = cxld->config.id;
> +	info = pdev->hdm;
> +	if (!info)
> +		return;
> +	if (id < 0 || id >= info->decoder_count) {
> +		pci_warn(pdev, "CXL HDM decoder %d exceeds cached count %d\n",
> +			 id, info->decoder_count);
> +		return;
> +	}
> +
> +	/* Preserve the last good value when the device does not respond. */
> +	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	if (global_ctrl != U32_MAX)
> +		info->global_ctrl = global_ctrl;
> +	settings = &info->settings[id];
> +
> +	/*
> +	 * A disabled decoder's software object may retain its old range and
> +	 * skip state. Leave only the decoder id in the cached settings so stale
> +	 * state is not restored as an enabled decode.
> +	 */
> +	*settings = (struct cxl_endpoint_decoder_settings) {
> +		.config.id = id,
> +	};
> +	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
> +		settings->config = cxld->config;
> +		settings->skip = cxled->skip;
> +	}
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_refresh_decoder, "cxl_core");
> +
> +int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count)
> +{
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	if (pdev->hdm && pdev->hdm->decoder_count != count) {
> +		pci_warn(pdev,
> +			 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
> +			 pdev->hdm->decoder_count, count);
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_check_decoder_count, "cxl_core");
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 33b21c8dcb21..e2034a2179b4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -6,6 +6,7 @@
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> +#include <cxl/hdm.h>
>  #include <cxl/pci.h>
>  #include <linux/aer.h>
>  #include <cxlpci.h>
> @@ -180,6 +181,29 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
>  
> +/**
> + * cxl_hdm_check_decoder_count() - check enumeration against the PCI HDM cache
> + * @cxlhdm: HDM capability containing the decoder count to check
> + *
> + * Take cxl_rwsem.dpa for read while comparing the cached count. Call only
> + * for hardware HDM decoders, since DVSEC-emulated ranges do not describe
> + * the HDM registers represented by the cache.
> + *
> + * Return: 0 if the counts match or no upstream PCI device or cache exists,
> + * or -ENXIO if the cached and enumerated decoder counts differ.
> + */
> +int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(cxlhdm->port);
> +
> +	if (!pdev)
> +		return 0;
> +
> +	return cxl_hdm_cache_check_decoder_count(pdev, cxlhdm->decoder_count);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_hdm_check_decoder_count, "CXL");
> +
>  static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 6d6e564be27a..341a7c52894a 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -26,6 +26,7 @@ enum cxl_devtype {
>  };
>  
>  struct cxl_region;
> +struct cxl_hdm_info;
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index 219b9bb67440..06e9aa4479c2 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -6,6 +6,9 @@
>  #include <linux/types.h>
>  #include <cxl/cxl.h>
>  
> +struct pci_dev;
> +struct cxl_endpoint_decoder;
> +
>  /**
>   * struct cxl_endpoint_decoder_settings - endpoint HDM decoder programming
>   * @config: common decoder configuration
> @@ -16,4 +19,33 @@ struct cxl_endpoint_decoder_settings {
>  	u64 skip;
>  };
>  
> +/**
> + * struct cxl_hdm_info - cached CXL HDM state for a PCI device
> + * @decoder_count: number of entries in @settings
> + * @hdm_bar: PCI BAR containing the HDM decoder capability
> + * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
> + * @hdm_size: size of the HDM decoder register block
> + * @global_ctrl: HDM decoder global control register
> + * @dvsec_ctrl: CXL DVSEC control register
> + * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
> + * @settings: per-endpoint-decoder programming state
> + *
> + * Publication through pci_dev.hdm and all mutable fields are protected by
> + * cxl_rwsem.dpa.
> + */
> +struct cxl_hdm_info {
> +	int decoder_count;
> +	int hdm_bar;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	u32 global_ctrl;
> +	u16 dvsec_ctrl;
> +	bool dvsec_ctrl_valid;
> +	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
> +};
> +
> +void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
> +				   struct cxl_endpoint_decoder *cxled);
> +int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
> +
>  #endif /* __CXL_HDM_H__ */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1e..7bb37fcb556d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -339,6 +339,9 @@ struct pcie_link_state;
>  struct pci_sriov;
>  struct pci_p2pdma;
>  struct rcec_ea;
> +#ifdef CONFIG_CXL_RESET
> +struct cxl_hdm_info;
> +#endif
>  
>  /* struct pci_dev - describes a PCI device
>   *
> @@ -566,6 +569,9 @@ struct pci_dev {
>  #ifdef CONFIG_PCI_DOE
>  	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
>  #endif
> +#ifdef CONFIG_CXL_RESET
> +	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
> +#endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */
>  #endif
> -- 
> 2.43.0
> 
