Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB84772BA;
	Wed, 23 Sep 2026 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199615; cv=fail; b=ZXmG1N4gghaCYqeeYo53/QnwTid1xfwEpqdL0qWDnj3w/Qnunh2jf8/bmTVL3h5AT8KP3HrE44CiZQNQcFKGt2hbxmKVaUVLeK+Ijga+4PGnXRtclzl8cxJGZx/eWMB0j2nShx/sh4h4oX++4bCmbLCA3cGRlPRYL2ot6oyVJ3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199615; c=relaxed/simple;
	bh=Yvxq3+Z5FifHoobJXxH8DVCsIvaxjLP+6vUPgEf8YGw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NpddPqeOaNsQemvD5KZ5X872PQdzQ5uuSp43qMR9og94KATPJ3rYKhSmwH+mEASfgenQQjc7Z0zMfNB9PgYYeRmg3msqMJ/UWPzeUGDjYTh5+hsS0qqQYvaBodIwxJwXzweqAPxssr7kwTJiZtBTp2XwbwbW1TBk+pQrBlGocGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yK9T7nJP; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yK9T7nJP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3N/2QqAWWQgTIORZdkx6P7f6Nx5ax/gFzhRBLz0a815LcSMaP0NWx4YMA8QitylD7wGmGzVfDlEw31P3l827p4mUGrP9YklExnI1/8Woqrh7VB1Ij455JOfCEFbFJKZLXqELGIxCmg7xWtIX6oUpUFGo2kYE20YtmDG1gibPWYMG0g0ZtpBES1KqoOczg7UB/pjedXP/5ekJTnk4icFPEczIXK3AeQaUNykQhpUHYKtOqeT6nQTK8fNOzePvPAEUl+nWgEHy7Z0mBlaFUEmMwQs1C+F/RItr+6YZA+wtqy70K9LDnU/VLBnOujcRxKmBbgBuIKKsBonk4BGtdRyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYeVjfHLyVpKPkl9Tw5K4SjUIQvSCsWJfKgs55j7a0E=;
 b=kWYVtRP+xu6rHMBUo4771pmJElftafpf8oTUiNMR/Ole/vvnPgIJzEczLz9xJQtNSr2vmGsrH5DISuO4dWbyt08WFlvCBAVCABJrzpoO8X0dk+Ya7Xu/B9crdENXe8lUodK7JPZNx0DUrOnRKECkQ9wGyivsUsWh8eQLye6AspJcsx+vEMvzHHig2m1n3FKbZ3WMMHIUBIKpWC3GA8uYGlZwUhPRrxkkuaiGY+L6htH9bxgTRNXALLexNoAelz4ZVenlB3eN8l2LIZcNVyWvqUia+1tbzEeEUYMNHJ7mbOs8M+BQrFR2s5Q3xxkP5YqMmo/ct7NQPa26vwvdkpYjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYeVjfHLyVpKPkl9Tw5K4SjUIQvSCsWJfKgs55j7a0E=;
 b=yK9T7nJPIZAvvWyaS0ByHXqVGfGgj5N3nVG03cj0Fv1XBKKKim6dykT9biSxx4GA3fp/w/SE7G1zyv6KKJjJnYZwyv2gwttKS7tJzMmcVfoWuBzMmYd7l7lXVfC9wK1te6iF5gmse1nYsSpBbps+M2fXiTxJ2yejwszj6bnXVkM=
Received: from SJ2P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::16)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 21:40:08 +0000
Received: from SJ1PEPF000037AE.namprd03.prod.outlook.com
 (2603:10b6:a03:5da:cafe::23) by SJ2P220CA0013.outlook.office365.com
 (2603:10b6:a03:5da::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 21:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AE.mail.protection.outlook.com (10.167.244.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:40:07 +0000
Received: from [10.236.178.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:40:06 -0500
Message-ID: <6dc03976-faa8-49cb-9b74-680e957f2f9e@amd.com>
Date: Wed, 23 Sep 2026 16:40:05 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v13 06/15] cxl: Make HDM reset helpers available to
 built-in PCI code
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
 <20260922083924.2451158-7-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AE:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b61132-d53d-4ce3-ff21-08df19bb3cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|36860700016|1800799024|376014|10067099003|11063799006|56012099006|6133799003|4143699003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	YRl8GmQDIYF1HClBG91RtM4SPNKYIEazCGpI8pUmJ6DrCqf/VOXCtCKIKGXBLfc9fiBteATM90cJ7gkvkakLnhWwZSZrt6De6EF25WSLFBxpWPolF1oG/inpSKgeDAJs74vXPWVyFPTmj/9XvwuMx63+zThYbg/U/T5MML+HML/E0XxoPg0yylkZpebzxlXYDuheFoINt1MLQ0mEVWE7Bm1xqSUDXj8GXCITmSjX6M/DngHmB3uSU65USsnacE69AZF1mCEShzMloMgA5zbBRDDdYaETXEFZdqV2PhUbF3Nofbk1Tiudn4fOgqAKdG77dMqUtJh+DgrrL11yCK1g2acIfh4HDv5NmHH/f4JbS6TqAMQx57GehIvTqzHWIVI6DIlSb5ksGHnrfgpUWLEI225ZhUrwPilcYqzooZA3sZ1z1ulNgl5FgLFEye0KHNPGoYp0OGFn0vOflSe/kHGOG1AMekwPvWl8v/xe1Ip67PPb5Eait5MUEhx+GFivTVe6FlfPBS/wwwR/Irp7xnabMPhu72bqJ6M5w4PFjwmyIEMmq5pq56I0MLH2aYfPSpyqK4IbLR9iw2Noc4SOzDVqcUqPTtCSZNswgstdnv7HHc2pXf7UscyxLbbDEXgkaO6WEbBruzGerTBcur8jjZrCItphE0b0o9GGpKndyY88gWcOaS9TnctKkCDhFXvKGqihJ3k7MigUCNa5hS1w8K06P5I3/0YVLd/SEmhyRb3q/SJrJDeOJ4rvLngstJ+gt5FI
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(6133799003)(4143699003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IEjoeZUZmvB3XBxLeEMJIP0wPxwHHy0XWpTKQP6H4mKmWpll3gcPujWXagkRl4xBpxNmo1aawKHGurtBr7wrYBAiazSng+YJ5pROsC+vtos5rDMuc/pvgelEBDGj5PNuZqqAJ8tT3fHvKw0FDttzJ30k291F9oy4m7xXvclgaiOPMGKtxbs8yhJcobDOm+e09v+FkeWv8cZ1gaJzB61lt1UMeDkFjSSTU6X+ubs8gDe7BYZQ37FhBGPtbdxuCdL5FM5YVfNxqmVpZv2t4I0d5Vtw+BMNiHEzrREwz9+L3PaAnY/eAPuJEAhF3jioDWmIEjnu2nGLsbA3ScE2cGhNctK9Umg+FtBtHNGgtZ5E6TgSgy3cT/bmFMRs51exVM9jjEET8lii4Y1blnC5EF1y62WNNGYzw8e9Wp9t0Jxgn9JYKM3J2pgcYopXQT8bdLHC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:40:07.9653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b61132-d53d-4ce3-ff21-08df19bb3cd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
> PCI can be built in while CXL_BUS is modular, so PCI reset code cannot
> depend on helpers provided by the cxl_core module.
> 
> Build the HDM resource helpers under CONFIG_CXL_RESET and restrict their
> exports to cxl_core.
> 

I think you should squash this patch into 3/15. Having this earlier does two things:
1) it makes it more clear why you're moving everything earlier in the set, and 2)
bisects across the pass 3 patches will all result in the same configuration.

An alternative option would be to refactor the preceding 3 patches in-place and then
move all of the helpers to this file in this patch, either would work.

> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/Kconfig         | 4 ++++
>  drivers/cxl/core/Makefile   | 2 +-
>  drivers/cxl/core/resource.c | 4 ++++
>  tools/testing/cxl/Kbuild    | 1 -
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 80aeb0d556bd..0cd704670735 100644
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
> @@ -244,3 +245,6 @@ config CXL_ATL
>  	depends on ACPI_PRMT && AMD_NB
>  
>  endif
> +
> +config CXL_RESET
> +	bool
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 57995777af0d..30470799e059 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,12 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> +obj-$(CONFIG_CXL_RESET) += resource.o

This file should probably be called reset.c instead of resource.c to match the
Kconfig functionality.
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
>  CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>  
>  cxl_core-y := port.o
> -cxl_core-y += resource.o
>  cxl_core-y += pmem.o
>  cxl_core-y += regs.o
>  cxl_core-y += memdev.o
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index ea0d855e5549..1b4742622054 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -3,6 +3,7 @@
>  #include <linux/delay.h>
>  #include <linux/bug.h>
>  #include <linux/errno.h>
> +#include <linux/export.h>
>  #include <linux/kernel.h>
>  
>  #include "cxl.h"
> @@ -12,6 +13,7 @@ struct cxl_rwsem cxl_rwsem = {
>  	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
>  	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
>  };
> +EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
>  
>  static void cxld_set_interleave(struct cxl_decoder_config *config, u32 *ctrl)
>  {
> @@ -100,8 +102,10 @@ void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	setup_hw_decoder(hdm, settings);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start, "cxl_core");
>  
>  int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
>  {
>  	return cxld_await_commit(hdm, settings->config.id);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 6c09932587ce..2be1df80fcc9 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -60,7 +60,6 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>  cxl_core-y += $(CXL_CORE_SRC)/pci.o
>  cxl_core-y += $(CXL_CORE_SRC)/hdm.o
> -cxl_core-y += $(CXL_CORE_SRC)/resource.o

If you squash this patch you also don't need to bother adding/removing this.

>  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o

