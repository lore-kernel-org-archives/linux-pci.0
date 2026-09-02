Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7223E51F9;
	Wed,  2 Sep 2026 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382662; cv=fail; b=eaUG8pkXks9dzvu7n/rh896f6GbYzJWYf37Mh6ezIoq43p0wOFa/4q09PXuUBPzuEIgCRFBjtmCOWabSv8CcujAlEGg3Q9k5pV8nwWywv8nOsNZG6VNXrpAakpE3N+vEyX5VZlDCQcQET6bHfpd38bM0jge1mqtmYWkhIJs3W1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382662; c=relaxed/simple;
	bh=oUbdKb1iLdRzin46gWW8vL82A44qGnaKcv6RzwjjA2U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=YSGds5l8zuvBEEICg8l3rJAthJXsqecJzS8G/2YHiUHhpfbo2m6R1R8fbV/LL8ikm9lWufj0HFva1Hsm5WNEGLot8WKQnDKjXl0Pi3Ky/eeQx3oNpzRNCQf2rJ/SGhfVWxqMrVWue2SGP4msIDvcaNG0mTIM/Uesvxdy/eP9L5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2XlWhG8z; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2XlWhG8z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/9ENJfqUGa//uOwIKImzdWd71r84RYdlqEhsOUvgzj2c29VfbXi7xMuDKSWKIM6yIcpG+kmLHQqLTOoB6nDhgoIwtfqEkQDCN8txSzNYahWwu/QxI5pVTdARPB5jhbklKG015yM9e5E/TRHMhZAzPJt91+yK5lyt79Ff821v9FxZwLw/LmyOmh1FdQpWdFWS3L/784/tzG5ubAGpDbR1EcJCJAPZ2fHe39So3PQJp4XHrh6jD+feYMCtKtzQGFg3QC4T5gs1ivqmhXvcsZK7YGRqoTmiA/F48PkljJSXLdzNoKlisFmY1YiTZX7Kwg8lHuLm/jnoWy8/bncfX9lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bh4yIpURf/qT/aH/E1qPe/PysNvsejlQgWUGdJz4BFA=;
 b=cEnaC5mIw72eFkhb6iWuBjY9pjMvMxOY9R1/6xcMkMCwZRlrtHlQX6i59mKReWnOsZZbMyr4dB5TGLvHFMd9uIivkVE/NEstbi9nEFGDG99eaD5TmjZyAC07HId3YsMOm/YsT2F5qt8F9xUEbPkF8z+gvKlRTssWqONAxzSRW1hPByYBXfaJKzN1n6CMHd9j7wrAnz5ZT9Qx2NrzZO0NPHTl6WPDj3YeS9nJY2qqMxHEqiHLw5lXQnMXpzlLiSaH5Pb8j9+8qPnMRzfiV51f3kGxkAghs76rsyqmr+bSkkcOCuHH1MG6Ss3Tf0Am1jJ5rhe0tMCBegKDZPMO9pUMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh4yIpURf/qT/aH/E1qPe/PysNvsejlQgWUGdJz4BFA=;
 b=2XlWhG8zZeOEeX4o9U5FFnTFg+stsNY1JmkOYPSVWUYacszTObJQDWUZ08IUr206x1LZFeEmDdPumslhLWm2/TxZc2Hz0pUGlXCoF0w0qEy/NyhU5nDVyHYMutwBGYAvsWtAUeNJGbnWOZelWVELWauSAxpd8YKYeUg1G5LVFEc=
Received: from CH2PR02CA0010.namprd02.prod.outlook.com (2603:10b6:610:4e::20)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Wed, 2 Sep
 2026 20:57:29 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::f) by CH2PR02CA0010.outlook.office365.com
 (2603:10b6:610:4e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 20:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 20:57:28 +0000
Received: from [10.236.189.59] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 15:57:27 -0500
Message-ID: <7a171b00-43d4-493b-9c22-0912145b1f4a@amd.com>
Date: Wed, 2 Sep 2026 15:57:27 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v20 5/9] cxl: Update CXL Endpoint AER handler
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
 <20260902133933.2992457-6-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20260902133933.2992457-6-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 64136aa3-9663-481b-3dd8-08df0934ccd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|23010399003|4143699003|10067099003|56012099006|11063799006|921020|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NBl3s9p+PprJc0Z6E6BIOlkGT5BvFnpVsyocHgPFZHNaCHEk5yrVi/hbl3shztdkzF/whIf5wPowB+nNRKBjyrlQi3egY7Z8I83qPbFDSSoIDb92gxBOSHwhQashiy/AfnrFRtn8NfBukjNUijM1Hn7Dvl2INNcr4DuowOSNhUGfnM67wx4LfG1jbwwMTRFcBdiNPSt7AflzI2lTyUVFC3KbNzm0dSXGzWbNzjeJUQFYP3JaKk1BHdyySx9S1QqpQuMVg7gd1YC1VByo43/jm56c5D0HlrtojXXR7aITAp241DxrvraPqaHOp50VGnkcvlCuZqzaSVCAmTiB/OUWyJRzIpMDRWSuiR2xDPMRAFLzfIXTwWG08ooXFksumDU3DEAWvsuGmUfdfW0hudCRXOcPNAXkP656R3NxT27y25hhdI3g7nyXS/9+09spmKaCCISDmmADzMUTkYa4rQzQIYdDAwOIxLpGTg5U/OSsCaxvsnutbuAFu0KYyIA9JOYkpz3CMjFksH59KV9ZQMCa9FHcInh6Av03Lu10Ut1w/UbkX2rHXWIT7KBFAH6XTP/7a4XKwFu6RiofyjmqueGB/CV7zM+hxVhwZSjjdwBJ6FOYKdr2WOtdm/6iFcTGxuuNZ6vO4QkvPH/3/THI8aV0xmmcqWAJXTEdVPg6o2tCE+YfBHH5MZGMhnlAI6UbT+NbMJ4rKW81zwtcxRUzq4Lap5j0fICQijeFWK1/8JZ8P2WAcPtkVCD/OcCGNMzh8wgn
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(921020)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MxPp2fPcMwTOLeGAZI8EtvDLXGLROsuyMd26zzm0sJUocwkfRoZ7rLDrQFGUf/3kSDS0CZrahvaaKY3tn1fkIYvrEYJw7ODUNrRMQ3jlAp0LKHWhcyqiGsN9C4u3O0bUQNhJGj1dmjdk5ZAn8ARJer6VwwDfvljWh8YJ5ejMbicR1cEgNlyeh8m2bVvOXe1lt/gVwBf5BO2hUb3PRPTu2YN3TdyQucbtlBg0PpelUjlnS+uR8DNyJBfo9tr3NM3Ips4MpfYX0qpDsGnoKzQxd4rmeuuStG5ftuxbUWnL2zjWRKyv9ZwD1dUFCtP6N6i8wnJfTVR/c+8e1WyK/yk+Fm9guXZYwcF52GTFEOw+swneEFzR52BKwI2UmN4QWXlt8mumS1mE8KueU3nPE3IGkEDIFn1HKl+5D/Je7eXtk03Jdrk+Gpr9PhxMxnjOcFFl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 20:57:28.9019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64136aa3-9663-481b-3dd8-08df0934ccd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680

On 9/2/2026 8:39 AM, Terry Bowman wrote:
> Rename cxl_error_detected() to cxl_pci_error_detected() and rename the
> struct pci_error_handlers instance from cxl_error_handlers to
> cxl_pci_error_handlers for consistency with the cxl_pci_ prefix used by
> the renamed handler and the rest of the PCI-facing entry points.
> 
> Document the unconditional CXL RAS read policy: on a dead link, readl()
> returns 0xFFFFFFFF which is interpreted as UCE bits set and triggers a
> panic. If RAS registers are not mapped the read is skipped and the
> frozen/perm_failure switch cases defer to AER recovery for devices
> without active CXL.mem traffic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> ---
> 
> Changes in v19->v20:
> - Expand the comment block in cxl_pci_error_detected().
> - Clarify commit message's first paragraph. cxl_error_handlers is a variable
> - Clarify AER handling in cxl_pci_error_detected() block comment
> 
> Changes in v18->v19:
> - Add review-by for DaveJ and Jonathan
> - Remove reindent introduced in v18 at cxl_error_handlers definition.
> 
> Changes in v17->v18:
> - Fix cxl_pci_error_detected() to use find_cxl_port_by_uport() and port->uport_dev
> - Read CXL RAS unconditionally; panic on UCE regardless of channel state
> - Document unconditional read policy and 0xFFFFFFFF behavior in comment
> - Drop guard removal paragraph from commit message (not in this diff)
> - Drop Reviewed-by tags pending re-review after message change
> 
> Changes in v16->v17:
> - Rename pci_error_handlers struct instance to cxl_pci_error_handlers for
>   cxl_pci_ naming consistency.
> - Restore scoped_guard(device) and dev->driver check around AER read.
> - NULL-check find_cxl_port_by_dev() before deref of port->uport_dev.
> - Updated commit message. (Terry)
> - Add scope cleanup for port variable in cxl_pci_error_detected() (Terry)
> - Drop cxl_uncor_aer_present(), rely on AER state
> 
> Changes in v15->v16:
> - Update commit message (DaveJ)
> - s/cxl_handle_aer()/cxl_uncor_aer_present()/g (Jonathan)
> - cxl_uncor_aer_present(): Leave original result calculation based on
>   if a UCE is present and the provided state (Terry)
> - Add call to pci_print_aer(). AER fails to log because is upstream
>   link (Terry)
> 
> Changes in v14->v15:
> - Update commit message and title. Added Bjorn's ack.
> - Move CE and UCE handling logic here
> 
> Changes in v13->v14:
> - Add Dave Jiang's review-by
> - Update commit message & headline (Bjorn)
> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>   one line (Jonathan)
> - Remove cxl_walk_port() (Dan)
> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>   sufficient (Dan)
> - Remove device_lock_if()
> - Combined CE and UCE here (Terry)
> 
> Changes in v12->v13:
> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>   patch (Terry)
> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
> - Remove check for dport->dport_dev (Dave)
> - Remove whitespace (Terry)
> 
> Changes in v11->v12:
> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>   pci_to_cxl_dev()
> - Change cxl_error_detected() -> cxl_cor_error_detected()
> - Remove NULL variable assignments
> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>   port searches.
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/ras.c | 25 ++++++++++++++++---------
>  drivers/cxl/cxlpci.h   |  8 ++++----
>  drivers/cxl/pci.c      |  6 +++---
>  3 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index e99dcd028b738..bf479fac08565 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -61,7 +61,7 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
>  
>  	/*
>  	 * ras_cap.header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
> -	 * dwords.  Copy them into the front of a zero-filled
> +	 * dwords. Copy them into the front of a zero-filled

Stray whitespace fix? Doesn't matter much to me, so:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
