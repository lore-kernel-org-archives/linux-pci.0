Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E09C224AF2;
	Mon, 17 Aug 2026 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944663; cv=fail; b=dL+Rm1u9EuQ4RFkBHDWxnzSnjpKYczPSOsEVQEkj/HxM8VOr9xdpKjkEvV4/UjGG7bNYoatmmgJzMCIBIuZf0LuJbJaWiRopyFKFyG359XSibA9NpGMSPrMcCFie/Bhrs/IpgPs1dEPrRiG5ualfIHtoYR0u1DkxkhHcFUsX4Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944663; c=relaxed/simple;
	bh=EXFRQTT0Ud2+6SU137N7A9mOCiJ63FN79VXsai9Npwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o8OaETn3tQ2i1Y9fdXABDsIuPfYPusmerF5bgDIN8NRhuaX3ZN81NAjjyl6sV0VMttpSphc1hWpFX/qe1tj1Y2m1Qg6qyhP6iQgWs4+6lOaqhlaiKPwVTfl5Tb9lg/olAuZgeM73K5m8496sygOQr5eEIGsDCXDHU4X5wc3vgvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VsuM0pJt; arc=fail smtp.client-ip=52.101.61.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VsuM0pJt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVlkDy2lGR9jg/XBgEdchAL95YAxWdupGz7ZKA3LVzY5UoojrQYhSJ0Tjak5wM4fOrkp1tKnid2tL2H9m7mJ76yYpb0s7JlRNTkqoRsCvp/nW8s2pDYhiLN3xk3vIE6APeQIeX3t3pE6zohsobG89HARs+r9R5Mn9VtVhvWa/Ka53tkJ+qwvUbntcaXs4L3B2PrDwVLOQ2edie2yRBiMRjEMr8p+X/EUloPDpk83I0rdv41OkVOZr08nHP2kMY/3oXkDld/wMVVns3yI8C78RlFze5Cavd3e6zait6qB/0/V4JJTNXoZK4FFsWl8iycYYbFDer+DX90zkqKv2fGpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sNqBZhFHZJ09riZ0/YLmzPOju5g2nk+g9FrMOM+Nrs=;
 b=N0mR2KBFuvG7Ky4sPPmw8Atrf2+6C/9ptBqytrKDX87xjrgjiVqBDxgEPO1DIZu3iLc5mMw0FwFI0TALLuMS0bHHq2TUnKIHeG7UJGt77b4Tr7HN2fN9HthnW30whRtT8GheXnXZyh9f6JuAIARin/WrC4BO2H8HmM/Rqzmj8I9HHojuLO6EBb0pr4C9K/u4K5cKmMLwKfbbtdxKOgMxAvHfDS1Mj70d93VKKyNydzCCImv2gGPQoEKa+UezuCUIWt4/H3PkZrc1THr0c4oiMKIdXHg71T50MsjSAqeaYKy1924Q1xiO9LUqxLG0+6FYVg44nAdQrFZMvrOjVtdDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sNqBZhFHZJ09riZ0/YLmzPOju5g2nk+g9FrMOM+Nrs=;
 b=VsuM0pJthWd8uxS2HWWHgH6UEwSOs4Y8I/PqwR6nynQe3DGQvBebWYaLuX/l36jBJzs6mUZ4Lc9iLJ8TAuQThtY4NzCVyru4CBjfm93cc6SxbRN5tGpn1tLXqlp+S7d3idPNxN3n7tYL+8HYUIluaqDQxLhSif1NJrTQEvPe05I0MgRoCMA4YAesTS3by4DSgRkzFnUvB8ECzWURaskaXIWAm4bQlGNLzBCAXUTmZgn+VHY5K4JxgzUUaWs+gnirybftevVu44jjsP3Jrsd8V+EitFlvNG2hlYVYogBCfi6WnyZ9e0GTSO4KN3RMwe0xOK8kPCPz4xABiswzn3qV6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:30:56 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 05:30:56 +0000
Date: Mon, 17 Aug 2026 13:30:49 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, 
	Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v10 05/12] cxl: Cache endpoint decoder settings during
 PCI enumeration
Message-ID: <aoKa7RILK51ZkpHs@MWDK4CY14F>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804192958.1823952-6-smadhavan@nvidia.com>
X-ClientProxiedBy: JH0PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b92306e-cca1-4584-7fed-08defc20b626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|6133799003|10067099003|56012099006|4143699003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ahYP0++VPlWvPA5RO7A4A4Jrr4VXhFn4Qk/kd+a0ilDjxpZ6TuXdN4x3Ii/VZaULnqKS2b2VNCsCZxLNJmIcltiZYYFJRrlVvJT+Wa8SD1ibVA3ZsfV6iGa8nlE5zvyaNGE3tL1KubsCx+7FzrTZpcjkhp10g1lZAiJ8QJGVbiTHIvmGF/tKmf8G4wHbpA3M/Q+seyGOHXurUfYAPi/8gz5csxdPDrjTvi9Hv+TAY9mfZS4RbR6TFrAX1oSFGvwxZ2Y22o18LHnKa17OTKSObijXxojw+NpaaMSBrD/vOdOkq72agQ6pGYRZ+cj2FIwJK4CqICYNPTXn1zDXb1bNy4Qc+ICthRChMV2AJCEIMb8fyHlNy7lhCSlTYchCf8VG4sIxorvHdssOVmunNLj+gaNqNbvzpEDylyfo6EVFfxDVL05mBl6rUa79untiiRhQv4dyiHTb6CuagHNdxuoU0Yws7F7sn/akijDj2eVUUXCrwjqHZnjgCbevIH43RQ28NXVLN8R0lg2+7buXR0SeL3GdQf3Bga6/F22h9ZOnBwaJHIPxE3G7A37YC2csRNTnlegM5HY7r1wcguTerQcsuiRXCZxqVr1yfCBpLgrA94i5dOo/umwHpnJMqynoG1v6qWBIX8JaVezRHJMF7zPky7GsEqO4cf3umh/iRsTGyUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(6133799003)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1RGR2xtc3FSNmhPZXhCSnFJa0J0cnNMa0VpZkxlQlNxSlA5LzA1VFlHUkRy?=
 =?utf-8?B?SSt6eUwzVzNKZUhBQlJZclpCWXY2OXE0Q1dwTFo5ckhQaDd4dWxJYmRINHE1?=
 =?utf-8?B?c2d5a0lKL0MwUG83bzJSTEVDU3dISUdKT2NNYUhZeTZpNVFMWU9FeXh2Z1NX?=
 =?utf-8?B?MmU5d0t6T0MvbTZtL3hZOEs4eVYxVi9melFwa2pldmc4MXBaRExIcHBFalVs?=
 =?utf-8?B?UlgxK1R1Zng0VU1NYTNWRk9aS2tmZk1wTE54bllXc2FLMU51dE9FRUc2K1Qw?=
 =?utf-8?B?cGNHMmJTempBaUNTbk1UcmpGU0FDMjlmdjFhK0FvckM1MXVicUNHeXdQdnhE?=
 =?utf-8?B?Z0d0VjM0WDNLeXVnTGZiQ2g1MjJpQkl0SWthZklmTmhOK2pzTUpnUUp5b3Zz?=
 =?utf-8?B?ZHJEYWtiRUIvTk9PNEtZb2xMREdHMmNvNVlPYUxld0g5aFVkWHJEem5uUGh4?=
 =?utf-8?B?STBIZFdJajhCODkvdUh1QXlTQW53Rko0N0JYYWV5ZUkwMi80MjFFTk5EVENU?=
 =?utf-8?B?RlphNzRVQ1hEODJRVTczWGZGL1ZQQVlPRnFNcXNsMmhVdFUxdmExdW5CMGxY?=
 =?utf-8?B?MWNJcGREM0YwZk92b3Rpc1h4TGVZUGlORkRiQjFoZEoxTWVPbWhVdkcxd0Fz?=
 =?utf-8?B?YkQwcVMzaUxDQ2hWVXVSNTZnaUZBazJjdWowUEFCMHE5czFoRUhpRXhWdXhW?=
 =?utf-8?B?TmkrWmMwL1hOVEhHV1B0YWY0WTZkMTROOHhTS0xwL0UzUTNMcHRBUjdxUGRu?=
 =?utf-8?B?SlB0bjY0Ykp0ZnMxSjJCU3YzcjJQY3I1V0g4elN2eGgxMWFhOGx3Zys0YVpk?=
 =?utf-8?B?L0I2QkhBQllNN21jSS9Wc3hWWmxwL09qOG9lUTZDRFVVOG1XOC9PUlVMNXY5?=
 =?utf-8?B?L1FXK0F0cUhJWDBjU3pYSU5ZUXpjZlVMc0IwL0p0MGRTR1RjdWc3Wm4yQmsx?=
 =?utf-8?B?cmZNNXQxODFtejlTT211aFlnOWk4RWl2VEJjNHBkQ3VQSkFrWUNvc29adHZK?=
 =?utf-8?B?T2VSaW80QTJuZmpVYzkwbGxkWWhLOSs2M0lYaCttS25aVVZ6ejBTd3FvU0J5?=
 =?utf-8?B?eExGSFhUWHZqanBHTXV6Ry84b2ZlZ0xiYVNVc3dsakt5YVdnMjJwOFZsSzZL?=
 =?utf-8?B?MFB1Y1VNRVVLMUdkY2ozL1hsZ2U1NDB5aXJNb2hSNGt3eWNTTERLc2VWRGZU?=
 =?utf-8?B?VHBuWlNqLzdwVUpQMEhDbjZJSGpUalNsMmVQNDJtMHp2RG5IZ3JiZG1nOTVx?=
 =?utf-8?B?RlMydkRSVm44aWNWOG9FVFVjWUhrejVhckg4bURKZGN1YThjTWNFTmNOQzZv?=
 =?utf-8?B?OUdYTXZrVXgyYkxBcjA0cUNJTzZzamRCTTVUaU9ON2VLVUJ2dXN1K1E2U3Y1?=
 =?utf-8?B?TkFJREVrRXhxUFhQUUZZSTROOVR6UkIwTm1NMTllNDYzV096cm4yQUxrRVZk?=
 =?utf-8?B?dStxdTlKaE40bllXSm5vTmtXM3A3OExWN2Z0bjc1aU5uMlI3MlpmN2FzbEZp?=
 =?utf-8?B?MzhzZnB1NEFaOVNVYnBrQUVJUGRGWjQ2SHZHMXhSSEdBVkQyenJsSUdtMmhp?=
 =?utf-8?B?K0tDeFYyWmhYK0t0WFBtMzJnZTlBZk5rZWdBZ3Fscm1pTjNucWpTVmkyOFJY?=
 =?utf-8?B?Q2tHMXZIZ21Ga004SDVVekI0VTlVbHh6TWZSM1hEMXd0c1duK1l1NHpwNGJn?=
 =?utf-8?B?UWs2dWhMOUdURVFBT2ZONk1CQis1MXdNVTFNemEwbW5wMThpOEZXMzNFVXc4?=
 =?utf-8?B?V01pUU1RMi85OTYzdzhhYjFXK1RyVXpZRXZVN05oVGtnRUtYWVRoS3M4ek5S?=
 =?utf-8?B?cU0zNzhsbW8vd1grNHFJMUJhYWxQTTlldW1UVmROelE2WVVLVEFIcjJadnZ5?=
 =?utf-8?B?TU5NeGlWWDUycDJDbDhSWERVMk43dGZNeU9UQWh4akNqY1UxZ1A5RnNJK2hU?=
 =?utf-8?B?a2FvVTVZSzVPYWgrTy9IUjZJRzZQUVZteUkyTCtiTk5TU2ZJcGE4RWo2aGRL?=
 =?utf-8?B?Q01WSG1sL1ZsQVRNQkhQRTRuYVBvY01qckhINXVUbzB2UE1rNmhnU1lqZGJB?=
 =?utf-8?B?MHBqamdJR0hmZGt1cWJZZmdKNUQ4ZFJ3dXBhWEhxU1d5c3JDQTVKUkJKWTFr?=
 =?utf-8?B?OFFzSFpIZklQNkU1NE1BRlBIMzNweDR1SVhaVzdrUUVzSjNNWURKQ3Y3UmNU?=
 =?utf-8?B?WWFjTTNxYWhSNXBLeXBnbkp3UjJGQVhrMGdIUWlESDFtak8wT3ZNV0FJdTMv?=
 =?utf-8?B?T2g2ZmxkaS9PYVNuTHoyajBQZ3FDOVpUdUtXbTB6NDhoaVI5c1dMR0pCZ2xS?=
 =?utf-8?Q?aILwMvjQdfvR5PJ/A6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b92306e-cca1-4584-7fed-08defc20b626
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 05:30:56.1587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEse/f15YRNFvIUFPkyCcKSFDjTKRtKI/PmjBYtuto1/2ySZkpxNj2QUdayS+jHNn8LVHBac9pOjKEH9QUTpvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007

On Tue, Aug 04, 2026 at 07:29:51PM +0800, Srirangan Madhavan wrote:
> Populate pci_dev->hdm for CXL.mem functions from pci_bus_add_device(),
> after final PCI fixups and state save but before driver binding. This
> gives driver-free reset paths an early HDM snapshot while avoiding the
> pre-resource-assignment window in PCI capability initialization.
> 
> Use the CXL Register Locator BAR Indicator to find the component register
> BAR, reject unassigned, disabled, or zero memory BAR resources before
> temporarily enabling Memory Space, and restore the original PCI_COMMAND
> value before returning.
> 
> CXL core reuses and refreshes the same cache as decoders are committed or
> reset, and retries cache setup during CXL HDM enumeration if the PCI
> bus-add attempt did not publish a cache. Move the register helpers into
> the built-in CONFIG_CXL_HDM set so the early cache path is available
> without cxl_core, and keep the cxl-test mock core from building a
> duplicate regs.o.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/Makefile   |   3 +-
>  drivers/cxl/core/hdm.c      |  13 +-
>  drivers/cxl/core/regs.c     |   4 +
>  drivers/cxl/core/resource.c | 313 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/probe.c         |   2 +
>  include/cxl/cxl.h           |  26 +++
>  tools/testing/cxl/Kbuild    |   1 -
>  8 files changed, 360 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 0df4178bbbaa..e22f05d83c39 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(CONFIG_CXL_HDM) += resource.o
> +obj-$(CONFIG_CXL_HDM) += regs.o resource.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>  
>  cxl_core-y := port.o
>  cxl_core-y += pmem.o
> -cxl_core-y += regs.o
>  cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index ec988e7b7c0c..b47701fc5315 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -112,10 +112,17 @@ static int cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
>  	struct pci_dev *pdev __free(pci_dev_put) =
>  		cxl_port_get_uport_pci_dev(cxlhdm->port);
>  	bool present;
> +	int rc;
>  
>  	if (!pdev)
>  		return 0;
>  
> +	rc = cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
> +	if (rc || present)
> +		return rc;
> +
> +	pci_cxl_hdm_init(pdev);
> +
>  	return cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
>  }
>  
> @@ -180,6 +187,10 @@ static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
>  	if (!info || cxld->id >= info->decoder_count)
>  		return;
>  
> +	if (cxlhdm->regs.hdm_decoder)
> +		info->global_ctrl = readl(cxlhdm->regs.hdm_decoder +
> +					  CXL_HDM_DECODER_CTRL_OFFSET);
> +
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		cxl_decoder_snapshot(cxld, &info->settings[cxld->id]);
>  	else
> @@ -1002,11 +1013,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 size, base, skip, dpa_size, lo, hi;
> +	struct cxl_decoder_settings settings;
>  	bool committed;
>  	u32 remainder;
>  	int i, rc;
>  	u32 ctrl, tl_low, tl_high;
> -	struct cxl_decoder_settings settings;
>  
>  	if (should_emulate_decoders(info))
>  		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 93710cf4f0a6..040b0304f63c 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>  
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
> @@ -517,6 +518,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  
>  	return offset;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>  
>  static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>  {
> @@ -633,6 +635,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  
>  	return component_reg_phys;
>  }
> +EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport)
> @@ -641,3 +644,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  		return CXL_RESOURCE_NONE;
>  	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 97cb136cb2ae..7f5946d3f2c4 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -2,9 +2,16 @@
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/delay.h>
>  #include <linux/bug.h>
> +#include <linux/bitfield.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxlpci.h>
>  
>  #include "cxl.h"
>  #include "core.h"
> @@ -170,3 +177,309 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
>  				  &settings->interleave_granularity);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
> +
> +struct cxl_hdm_decoder_state {
> +	u32 ctrl;
> +	u32 base_low;
> +	u32 base_high;
> +	u32 size_low;
> +	u32 size_high;
> +	u32 target_low;
> +	u32 target_high;
> +};
> +
> +static void cxl_pci_hdm_info_free(struct cxl_hdm_info *info)
> +{
> +	if (!info)
> +		return;
> +
> +	kfree(info->decoder_state);
> +	kfree(info);
> +}
> +
> +void pci_cxl_hdm_release(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		info = pdev->hdm;
> +		pdev->hdm = NULL;
> +	}
> +
> +	cxl_pci_hdm_info_free(info);
> +}
> +
> +static bool cxl_pci_bar_usable(struct pci_dev *pdev, int bar)
> +{
> +	struct resource *res = &pdev->resource[bar];
> +
> +	if (!pci_resource_len(pdev, bar))
> +		return false;
> +	if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
> +		return false;
> +	if (resource_type(res) != IORESOURCE_MEM)
> +		return false;
> +	if (!res->start || !res->end)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int cxl_pci_hdm_find_bar(struct pci_dev *pdev, resource_size_t hdm_start,
> +				resource_size_t hdm_size, int *bar,
> +				resource_size_t *offset)
> +{
> +	resource_size_t hdm_end;
> +
> +	if (!hdm_size)
> +		return -EINVAL;
> +
> +	hdm_end = hdm_start + hdm_size - 1;
> +	if (hdm_end < hdm_start)
> +		return -EINVAL;
> +
> +	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		struct resource *res = &pdev->resource[i];
> +
> +		if (!cxl_pci_bar_usable(pdev, i))
> +			continue;
> +		if (hdm_start < res->start || hdm_end > res->end)
> +			continue;
> +
> +		if (bar)
> +			*bar = i;
> +		if (offset)
> +			*offset = hdm_start - res->start;
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
> +				     struct cxl_register_map *map,
> +				     struct cxl_hdm_info *info)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	resource_size_t hdm_start;
> +	void __iomem *hdm;
> +	int rc;
> +
> +	hdm_start = map->resource + hdm_map->offset;
> +	info->hdm_size = hdm_map->size;
> +
> +	rc = cxl_pci_hdm_find_bar(pdev, hdm_start, info->hdm_size,
> +				  &info->hdm_bar, &info->hdm_offset);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	hdm = ioremap(hdm_start, info->hdm_size);
> +	if (!hdm) {
> +		pci_err(pdev, "failed to map CXL HDM decoder registers\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return hdm;
> +}
> +
> +static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
> +					   void __iomem *hdm, int id)
> +{
> +	state->ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	state->base_low = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	state->base_high = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	state->size_low = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	state->size_high = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	state->target_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +}
> +
> +static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
> +				    struct cxl_hdm_decoder_state *state,
> +				    struct cxl_decoder_settings *settings,
> +				    void __iomem *hdm, int id)
> +{
> +	u64 target_or_skip, base, size;
> +	int rc;
> +
> +	cxl_pci_hdm_read_decoder_state(state, hdm, id);
> +
> +	base = ((u64)state->base_high << 32) | state->base_low;
> +	size = ((u64)state->size_high << 32) | state->size_low;
> +	target_or_skip = ((u64)state->target_high << 32) | state->target_low;
> +
> +	rc = cxl_hdm_decode_decoder(settings, id, state->ctrl, base, size,
> +				    target_or_skip, NULL);
> +	if (rc) {
> +		pci_err(pdev, "CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +	return 0;
> +}
> +
> +static int cxl_pci_hdm_capable(struct pci_dev *pdev)
> +{
> +	u16 cap;
> +	int dvsec;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> +		return -ENOTTY;
> +
> +	return 0;
> +}
> +
> +static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +				 struct cxl_register_map *map,
> +				 struct cxl_hdm_info *info)
> +{
> +	struct cxl_decoder_settings *settings;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	int rc;
> +
> +	rc = cxl_setup_regs(map);
> +	if (rc)
> +		return rc;
> +
> +	if (!map->component_map.hdm_decoder.valid)
> +		return -ENODEV;
> +
> +	hdm = cxl_pci_hdm_map(pdev, map, info);
> +	if (IS_ERR(hdm))
> +		return PTR_ERR(hdm);
> +
> +	decoder_count = cxl_hdm_decoder_count(readl(hdm +
> +						    CXL_HDM_DECODER_CAP_OFFSET));
> +	if (decoder_count < 0) {
> +		rc = decoder_count;
> +		goto out_unmap;
> +	}
> +
> +	if (decoder_count > CXL_HDM_DECODER_MAX_COUNT) {
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	info->decoder_state = kcalloc(decoder_count,
> +				      sizeof(*info->decoder_state),
> +				      GFP_KERNEL);
> +	if (!info->decoder_state) {
> +		rc = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	settings = info->settings;
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
> +					      &settings[i], hdm, i);
> +		if (rc)
> +			goto out_unmap;
> +	}
> +
> +	rc = 0;
> +out_unmap:
> +	iounmap(hdm);
> +	return rc;
> +}
> +
> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	struct cxl_register_map map = { 0 };
> +	struct cxl_hdm_info *info;
> +	bool restore_command;
> +	u16 command;
> +	int rc;
> +
> +	down_read(&cxl_rwsem.dpa);
> +	if (pdev->hdm) {
> +		up_read(&cxl_rwsem.dpa);
> +		return 0;
> +	}
> +	up_read(&cxl_rwsem.dpa);
> +
> +	rc = cxl_pci_hdm_capable(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);

Hi Srirangan,

I can't compile successfully after your patch series applied, I think the
issue is here.

With CONFIG_CXL_BUS=y or CONFIG_CXL_BUS=m alone with
"""
$ make -j $(nproc) vmlinux modules
"""

The build fails with:

"""
    drivers/cxl/core/resource.c:501:38: error:
      ‘CXL_REGLOC_RBI_COMPONENT’ undeclared
    drivers/cxl/core/resource.c:501:38: error:
      type of formal parameter 2 is incomplete
"""

drivers/cxl/cxl.h only forward-declares enum cxl_regloc_type.
CXL_REFLOC_RBI_COMPONENT and the complete enum def are provided
by include/cxl/pci.h

I add the following header so we can include drivers/cxl/core/resource.c
to fix the failure.

"""
#include <cxl/pci.h>
"""

Best regards,
Richard Cheng.


> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_hdm_find_bar(pdev, map.resource, map.max_size, NULL, NULL);
> +	if (rc)
> +		return rc;
> +
> +	info = kzalloc_obj(*info, GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		goto out_free_info;
> +	}
> +
> +	restore_command = !(command & PCI_COMMAND_MEMORY);
> +	if (restore_command) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc) {
> +			rc = pcibios_err_to_errno(rc);
> +			goto out_free_info;
> +		}
> +	}
> +
> +	rc = cxl_pci_hdm_read_info(pdev, &map, info);
> +
> +	if (restore_command) {
> +		int rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
> +
> +		if (rc2) {
> +			rc2 = pcibios_err_to_errno(rc2);
> +			pci_err(pdev,
> +				"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +				rc2);
> +			if (!rc)
> +				rc = rc2;
> +		}
> +	}
> +
> +	if (rc)
> +		goto out_free_info;
> +
> +	down_write(&cxl_rwsem.dpa);
> +	if (!pdev->hdm) {
> +		pdev->hdm = info;
> +		info = NULL;
> +	}
> +	up_write(&cxl_rwsem.dpa);
> +
> +	cxl_pci_hdm_info_free(info);
> +	return 0;
> +
> +out_free_info:
> +	cxl_pci_hdm_info_free(info);
> +	return rc;
> +}
> +
> +void pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_init(pdev);
> +	if (rc && rc != -ENOTTY && rc != -ENODEV)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> +}
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 655ed53436d3..5fd7bae8e786 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
> +#include <cxl/cxl.h>
>  
>  #include "pci.h"
>  
> @@ -359,6 +360,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	/* Save config space for error recoverability */
>  	pci_save_state(dev);
> +	pci_cxl_hdm_init(dev);
>  
>  	/*
>  	 * Enable runtime PM, which potentially allows the device to
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18..0bed5638d6da 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -24,6 +24,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/bitfield.h>
>  #include <trace/events/pci.h>
> +#include <cxl/cxl.h>
>  #include "pci.h"
>  
>  static struct resource busn_resource = {
> @@ -2484,6 +2485,7 @@ static void pci_release_dev(struct device *dev)
>  	struct pci_dev *pci_dev;
>  
>  	pci_dev = to_pci_dev(dev);
> +	pci_cxl_hdm_release(pci_dev);
>  	pci_release_capabilities(pci_dev);
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 703285966946..a1fe8949f3f7 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -26,6 +26,7 @@ enum cxl_devtype {
>  };
>  
>  struct cxl_region;
> +struct pci_dev;
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> @@ -135,16 +136,41 @@ struct cxl_regs {
>  
>  #define CXL_HDM_DECODER_MAX_COUNT 32
>  
> +struct cxl_hdm_decoder_state;
> +
>  /**
>   * struct cxl_hdm_info - PCI device HDM decoder programming cache
>   * @decoder_count: number of decoder settings entries
> + * @hdm_bar: BAR containing the HDM decoder registers
> + * @hdm_offset: HDM decoder register offset relative to @hdm_bar
> + * @hdm_size: HDM decoder register resource size
> + * @global_ctrl: cached HDM decoder global control register
> + * @decoder_state: cached raw per-decoder register state
>   * @settings: cached per-decoder programming state
>   */
>  struct cxl_hdm_info {
>  	int decoder_count;
> +	int hdm_bar;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	u32 global_ctrl;
> +	struct cxl_hdm_decoder_state *decoder_state;
>  	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
>  };
>  
> +#ifdef CONFIG_CXL_HDM
> +void pci_cxl_hdm_init(struct pci_dev *pdev);
> +void pci_cxl_hdm_release(struct pci_dev *pdev);
> +#else
> +static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +}
> +
> +static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
> +{
> +}
> +#endif
> +
>  struct cxl_reg_map {
>  	bool valid;
>  	int id;
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 6c09932587ce..2eb61812a8e7 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -55,7 +55,6 @@ obj-m += cxl_core.o
>  
>  cxl_core-y := $(CXL_CORE_SRC)/port.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmem.o
> -cxl_core-y += $(CXL_CORE_SRC)/regs.o
>  cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>  cxl_core-y += $(CXL_CORE_SRC)/pci.o
> -- 
> 2.43.0
> 
