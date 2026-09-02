Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545683E49C7;
	Wed,  2 Sep 2026 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382661; cv=fail; b=cRyrUuTAOwx9+0J8aCCQWIqpN7nDaNafdihkBYEubd1pCerQDxUoQDaWIB9v6l8QWcaCIZ/AUIVFNZdF7cvvMbp4mL56pt1Jqu6csxw+y0bAJFjm/vlMoeGIThxt4hqp82WeZtW29LPuRhkwynxgTbCzXTcGMQzs7OGHsf9j6dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382661; c=relaxed/simple;
	bh=B3ro1sIspVm1PFrjvCDeePlZiDzy5leCIxFz5Kr+fsE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ibE1FpAKu44sdYxF0O6cww0cgr6RgV0hSmWimwUV4o7/CqhsMcnMpRu8au+mfknMdrJkT/tAAFsrWxxcvjt2I0ckc/UbdUh/WFMpKASKN+guDh1mI/iVuUS3gQ0fg9g4xNBS1FUWizroXsBSRfMRa2Yadb//g1TXXhdPwZurUpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xCQMPP/u; arc=fail smtp.client-ip=40.107.200.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xCQMPP/u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sg3qiQh8/uSE1mUwmntKHi6+Bk4hY6vfQYMh/GTCAN2OX2NLS8g9bMMfCAlEUSVw/JNayB99AByBGli9BKHNAvufizcL0HHjB6XTdk5Tn3cKvateZlIAkLtx3vMgHXJ5ZnuAxSSYi9ubUlAW9ixZFQV6ZPSBPu5ZaDlCGFtclPXL70oHrofFpbPnQaGHWQpES+YiVCKi2XFRX5JKaWun+p2bDPexTWFjzW/XNKZc9rV0CORdz8tyKWuUxUxRBIKX5EgSF6yoeXZWC5COEI/D+F4EHaSvArQf0cHhikHFyhfgs8QyFAy4uFpp66bGVbRMMLfknAxKFTXw+J8rnbXn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhIU+QvqMxJspgzZcWmHMcvMmKbpldHKQXzdxwOSZdQ=;
 b=rihELc9R9QFRBBgEFRJIZt3tNJiBBcjqpjW15ckresEGGr9b6eBr787TFHNDzwwl6IdONWBIJUQXe28VeEDs/rpoCDbh0Li0qE84rBsiKoru0EhNKYpQEch9pohfYNICT5A5KD5tXZriyNtWS3fIAHqO9CGjaLn87jlEHY0xCOct0dNE5trRPqfsoeXVwVR4KDlB2dEp4mKCpzL9fE0iwV6SRO+hyhUL5sGLG5x71K/FT3RevRbZyOqjuX+pEEWGAOaqMFAEj6vxH7gNv7AuA02rFBhHnKKpm9RyOtp1v+OPvJd/1E3Aa3+H8C9u9Q/BBmA3O7GGf6vf71UnHgq6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhIU+QvqMxJspgzZcWmHMcvMmKbpldHKQXzdxwOSZdQ=;
 b=xCQMPP/uIIUrwWWwfwWG0pG4ZqUBq3WG/5CIDFc7qwzPiBDbE3UcTlQwAOm0e+ryRxkWdBhZAT1/IJR0kgSHhIbPD6Jeflc6eqLLwoErISpMPGdHOG5WkCL0X4EMhGWMwAojWESOpD0yh7cHLX1qV8jaAcqGagkSQzlYsv6nn9E=
Received: from CH2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:5a::20)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 20:57:08 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::77) by CH2PR08CA0010.outlook.office365.com
 (2603:10b6:610:5a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 20:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 20:57:07 +0000
Received: from [10.236.189.59] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 15:57:06 -0500
Message-ID: <14f7979c-48ab-4769-b69b-a1bab217d13e@amd.com>
Date: Wed, 2 Sep 2026 15:57:06 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v20 1/9] PCI/AER: Introduce AER-CXL protocol error kfifo
To: Terry Bowman <terry.bowman@amd.com>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
	"Dan Williams" <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Richard Cheng <icheng@nvidia.com>, "Robert
 Richter" <rrichter@amd.com>, Lukas Wunner <lukas@wunner.de>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-2-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20260902133933.2992457-2-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8e60b2-c749-4f56-34d9-08df0934c05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|7416014|921020|6133799003|3023799007|10067099003|11063799006|5023799004|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jOTpfLkux+n0ocmYS4zFpoNioHBK27uXNEqVpIdOzyr0fHp7wMPCFhQYjFoirQTECJYcvQtDYXAndPWdLmOUZp8ghspBwsscjr5Q44SATf0ZppNfx4j9+7+2Og2ZvjwzoLCAHOyhJFYJrSg4y7wJc0H9kQlf9GgWl1jcDnEtKDfh0OieEZCABBcq8IXT0Wbxp2VEIV234/CEsiuwEdkus5iFYtUiVdlI5B2Jnc3yii/Rqly0HVOUu2zII2yuviGXZmkkIsN812IL+T6lvdgPrymCxJmEvmP0LYxEdxTTuU3TIG1GBHsaviCAELyqSW2Sc3nsUtD7Gr9996/NPMAnZqme1sOdn9jG9ebSleiljQRf/3ccSfUQ3h+Wts2PV2G5iiTkRjqfEOFSAOIJNOjcfafSjaIOtp3coOoy5e33NU/Bn4RRrprZZgnnx4BIUnCCIsf9CWL9iSy6bDMAc3ayTmq6qEfdsZzMYSXKR80dLVDRFV7LYU/mNQ2cT6mxYavy3LM7TolpZKW/TY573AOCHx0SOLO4xqXaP1sGz+TNcajmF18e8hp4Se3uRihDUcDCJY2WlnN4yqe2itUUlvmMqLjl34DXHyiQM/smS5mtexJ05E7l4fgoI9VHhM0NOBhToAaAoMOzR3zjGzyj/CCE9RU0520RXCLaEOWyusi/8RmlzisvVQeTV5jHwJEOcjjvGI86SRz3H8u3YSbODcXjkoQ4DzcABqd6huAnTSMEaxtpzPjydqsipjYOUt//OrX5
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(7416014)(921020)(6133799003)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BG0lAc4mwZNX3PjrzEPjL8tM4p/7P2AWPjHH42f87llJILhHffgqBF5CpxU1uwoTVUDpg+ehU9253iH7MDOWBAb+M04YZ1xFTaqv3juJNuNCRhdqkbnbF7O3axKP7keE+uvweet1vmwJUfAE79TsAebnBuMuVZSZdXsnV8NfyVsa/GxQQRS66iCBTr1K7eX+vzRp73auhs6q0o2lgEz5TyouUOMjvUnkn+G75d+6nQhAelDBl8QHu2rks/ZkhdwOEg8Ju/31LZSCybI90bNU0BYHLYv+KFIkqKPe5kIAKsg34hEpQC22LeXqCZW0qswH8cmM5lMzkNwyAStt7Vt9jwGjuhu4XdcP5bnqpmMcQEYGurvKOo0p1IRJ5P0J165PZVFOwz5Vi7kCoJrJUT7dN99rY+gPRGFdvw7LeT9h64yQ2OS1By/ZfFgtsPzPlVEt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 20:57:07.9549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8e60b2-c749-4f56-34d9-08df0934c05c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749

On 9/2/2026 8:39 AM, Terry Bowman wrote:
> CXL VH RAS handling requires the AER driver to hand off CXL protocol
> errors to cxl_core for logging and recovery before PCIe AER recovery
> tears down the device. Introduce pci/pcie/aer_cxl_vh.c to implement
> this handoff via a kfifo-backed work item.
> 
> The producer, cxl_forward_error(), is gated by is_cxl_error() and
> enqueues the error source PCI device and severity. cxl_core registers a
> consumer via cxl_register_proto_err_work(); the consumer drains the
> kfifo with for_each_cxl_proto_err(). For uncorrectable errors,
> cxl_proto_err_wait_for_empty() lets the AER path block until the CXL
> plane has finished so recovery does not race device teardown.
> 
> A rwsem serializes registration, deregistration, enqueue, and dequeue
> against concurrent AER IRQ threads; a spinlock serializes concurrent
> kfifo writers. is_aer_internal_error() moves into this file and now
> evaluates info->status & ~info->mask rather than the raw info->status,
> so a masked internal-error bit is treated as not-set. For the RCH RCEC
> path this is equivalent because cxl_rch_enable_rcec() first calls
> pci_aer_unmask_internal_errors(), which clears those mask bits in
> hardware before the AER status is read back.
> 
> A subsequent patch wires cxl_forward_error() into handle_error_source().
> 
> Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under the CXL
> entry.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---

Just a few nits, but nothing critical so:

Revewied-by: Ben Cheatham <benjamin.cheatham@amd.com>

> 
> Changes in v19->v20:
> - Drop a correctable error on full kfifo instead of panicking
> - Add explicit ATOMIC_INIT(0) for flush_inflight
> - Change is_aer_internal_error() to use mask in evaluation.
> - Condense commit message (Jonathan)
> - Document constraints for_each_cxl_proto_err()
> - Document the @wd and @fn parameters of for_each_cxl_proto_err() (kernel-doc)
> 
> Changes in v18 -> v19:
> - Rename cxl_proto_err_flush() to cxl_proto_err_wait_for_empty() to
>   better reflect that it waits for the kfifo to drain (Jonathan).
> 
> Changes in v17->v18:
> - Remove correctable status clear from cxl_forward_error(); the AER core
>   clears all status bits via pci_aer_handle_error() info->status writeback
> - Schedule consumer on kfifo overflow so existing entries can be drained
> 
> Changes in v16->v17:
> - Reword "kfifo semaphore" to "kfifo spinlock" to match fifo_lock.
> - Defer the handle_error_source() is_cxl_error() switch to the patch that
>   registers the kfifo consumer to keep each commit bisect-safe.
> - Rename rwsema to rwsem
> - Change CPER exports to use EXPORT_SYMBOL_FOR_MODULES.
> - Add work cancel function.
> - Replace kfifo_put() with kfifo_in_spinlocked() for multiple producers
> - Add fifo_lock spinlock for concurrent producer serialisation
> - Initialize the embedded kfifo with INIT_KFIFO() in a subsys_initcall so
>   kfifo->mask, ->esize and ->data are set before first use.
> - Clear PCI_ERR_COR_STATUS in cxl_forward_error() after enqueue so the
>   device is acked for correctable events even when the consumer drops the
>   event. Uncorrectable status is left for cxl_do_recovery() to clear after
>   recovery completes, mirroring the AER core convention.
> - WARN on double-registration in cxl_register_proto_err_work() to make an
>   unintended second consumer visible at runtime.
> - Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
>   in aer_cxl_vh.c
> - Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
> - Update message
> ---
>  MAINTAINERS                   |   2 +
>  drivers/pci/pcie/Makefile     |   1 +
>  drivers/pci/pcie/aer.c        |  10 --
>  drivers/pci/pcie/aer_cxl_vh.c | 243 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h    |   6 +
>  include/linux/aer.h           |  24 ++++
>  6 files changed, 276 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/pci/pcie/aer_cxl_vh.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a19da74d00c9..f6ca37995ff84 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6572,6 +6572,8 @@ S:	Maintained
>  F:	Documentation/driver-api/cxl
>  F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
>  F:	drivers/cxl/
> +F:	drivers/pci/pcie/aer_cxl_rch.c
> +F:	drivers/pci/pcie/aer_cxl_vh.c
>  F:	include/cxl/
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index b0b43a18c304b..62d3d3c69a5df 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>  obj-y				+= aspm.o
>  obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
>  obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o
> +obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o

This can go on the same line as the obj-$(CONFIG_CXL_RAS) above, i.e.:
obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o aer_cxl_vh.o

>  obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d8dcd238fda1f..21dfc9c933d77 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1288,16 +1288,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   */
>  EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>  
> -#ifdef CONFIG_CXL_RAS
> -bool is_aer_internal_error(struct aer_err_info *info)
> -{
> -	if (info->severity == AER_CORRECTABLE)
> -		return info->status & PCI_ERR_COR_INTERNAL;
> -
> -	return info->status & PCI_ERR_UNC_INTN;
> -}
> -#endif
> -
>  /**
>   * pci_aer_handle_error - handle logging error into an event log
>   * @dev: pointer to pci_dev data structure of error source device
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 0000000000000..9fc12d4e644bc
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2026 AMD Corporation. All rights reserved. */
> +
> +#include <linux/aer.h>
> +#include <linux/atomic.h>
> +#include <linux/cleanup.h>
> +#include <linux/init.h>
> +#include <linux/kfifo.h>
> +#include <linux/lockdep.h>
> +#include <linux/rwsem.h>
> +#include <linux/spinlock.h>
> +#include <linux/wait_bit.h>
> +#include <linux/workqueue.h>
> +#include "../pci.h"
> +#include "portdrv.h"
> +
> +#define CXL_ERROR_SOURCES_MAX          128
> +
> +struct cxl_proto_err_kfifo {
> +	struct work_struct *work;
> +	void (*flush)(void);
> +	struct rw_semaphore rwsem;
> +	spinlock_t fifo_lock;           /* Serializes kfifo writers */
> +	atomic_t flush_inflight;
> +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
> +		      CXL_ERROR_SOURCES_MAX);
> +};
> +
> +static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
> +	.rwsem = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rwsem),
> +	.fifo_lock = __SPIN_LOCK_UNLOCKED(cxl_proto_err_kfifo.fifo_lock),
> +	.flush_inflight = ATOMIC_INIT(0),
> +};

I don't know what the style is for pcie, but I think the above can get shortened to:

static struct cxl_proto_err_kfifo {
	...
} cxl_proto_err_kfifo = {
	.rwsem = ...
};

> +
> +static int __init cxl_proto_err_kfifo_init(void)
> +{
> +	INIT_KFIFO(cxl_proto_err_kfifo.fifo);
> +	return 0;
> +}
> +subsys_initcall(cxl_proto_err_kfifo_init);
> +
> +bool is_aer_internal_error(struct aer_err_info *info)
> +{
> +	u32 status = info->status & ~info->mask;
> +
> +	if (info->severity == AER_CORRECTABLE)
> +		return status & PCI_ERR_COR_INTERNAL;
> +
> +	return status & PCI_ERR_UNC_INTN;
> +}
> +
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	if (!info || !info->is_cxl)
> +		return false;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	return is_aer_internal_error(info);
> +}
> +
> +/**
> + * cxl_forward_error - Forward a CXL protocol error to the CXL subsystem via kfifo
> + * @pdev: PCI device that reported the AER error
> + * @info: AER error info containing severity and status
> + *
> + * Producer side of the AER-CXL kfifo. Enqueues a CXL protocol error work
> + * item and schedules the consumer workqueue. Takes a reference on @pdev
> + * that the consumer releases after handling.
> + *
> + * Return: true if the consumer workqueue was scheduled and the caller may
> + * need to drain the kfifo before AER recovery; false if no CXL error
> + * handling was initiated due to an early return on error (e.g. no kfifo
> + * consumer registered). Note that on a full kfifo a correctable error is
> + * dropped but true is still returned; this is harmless because the caller
> + * only drains the kfifo for non-correctable events.
> + */
> +bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	struct cxl_proto_err_work_data wd = {
> +		.severity = info->severity,
> +		.pdev = pdev,
> +	};
> +
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> +
> +	if (!cxl_proto_err_kfifo.work) {
> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered\n");
> +		return false;
> +	}
> +
> +	/*
> +	 * Reference discipline: the AER caller (handle_error_source()) holds
> +	 * a ref on @pdev for the duration of this call and releases it on
> +	 * return. Take a fresh ref here so the pdev stays live while queued
> +	 * in the kfifo; the corresponding consumer is for_each_cxl_proto_err()
> +	 * and will drop that ref after handling. On enqueue failure below,
> +	 * drop the ref we just took to avoid a leak.
> +	 */
> +	pci_dev_get(pdev);
> +
> +	/* Serialize concurrent kfifo writers: multiple AER threaded IRQs */
> +	if (!kfifo_in_spinlocked(&cxl_proto_err_kfifo.fifo, &wd, 1,
> +				 &cxl_proto_err_kfifo.fifo_lock)) {
> +
> +		pci_dev_put(pdev);
> +
> +		/*
> +		 * A correctable error is device-local and recoverable, so a
> +		 * dropped CE is safe to log and discard. Never panic on CE
> +		 * pressure: a CE storm must not fill the fifo and escalate a
> +		 * later event.
> +		 */

I don't think you need this comment when the same info is mentioned in the doc comment
above the function. I'd probably keep the doc comment since it's more visible, but that's
up to you.
