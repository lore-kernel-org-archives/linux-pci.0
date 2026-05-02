Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61C1D432D;
	Sat,  2 May 2026 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777698964; cv=fail; b=cz3AWwFNtttrhj8RvSG2BGBbJMDldebRJ0hpn1/uVRoevplOtnerlodV/uJYUtVeQfOhTpJhG4oZTJAfDcj/9vnSCCefGfjZH1hvmB77VOk2Zao3uVUdDiFrCleSGBxZf11fUdvyGDexxfsxFAjGeUAxe/27moWSGpqBKjdpg+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777698964; c=relaxed/simple;
	bh=W5uppfKMHHrDhA+IlRZIgYRn80xRLx3+1AliStp6Af0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xv1D/hD35XU83Gm4WhfrhAI/aaw5keOjNUzdiEOoRow6fVybRMCJgADHw6SFup16UNIbjZgQ5rgGBTNPdRYYfjoCiXhJU2vqdJ4ODPznlmWNncSpF2Jr5olQLVNi7OiYNckiumLiRg0MtrTRNkTm5FdUunD5N6eLEJQhC02vEJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X8y78tbE; arc=fail smtp.client-ip=52.101.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X8y78tbE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/7U9jdNNTd4Yob8JBFpzVB8HVuHCrpoV3JLuyXugaGsjyB/i/X+q+X/ViaF1/jIX7M/ZTCN6Y1xc+ElqjNgvggHlMMnHRNpN+YMOoeEclWqNjdibzJC/t4Xso+OZn5KXMA4umO42mwAouZxzDoSRwFBo+JREZl5FhQz2ZMmRRlTsV+WLL5cXDomWpL8G7736Dif3G7bGjPtUKsEylZahHQKmokdq7iBX+skCRNSN7ys/72gvGy7HbvzVI10ZwO9zWSazK2UxqR4aQT4I81ncqyQqsZFBDI5EQkAQyv//kAxQj7O4EygpTpnUroVTZmuN2gqiN/ctCRNXroLCG79Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tCjWgN/NAiNjLOCW6TU9gRGPxO1pY9ShiqBx2CDATA=;
 b=MMlisvP2WcQNPmEUUiBwsrM8Z3MMqDMcmiQqYv/EtMP0tSvBA8PHVr9W/20jND2z+skdmRmhuldvc2KLGpOwG0a2tOufJh7R/pi8+45dcxe3/puummsI1rYJABXyk/JNhoFXaiy+VrLQrBtLxlihsEfN1ZjiZ9xBggm78jZwpRy9BwTTJZNWBTfricXhTaJg1HrRI1t2FhX7GzxwV0XHbtkPF8qYozU9QQGGWPIbvW37fRj1Tlaotg3JjV3jHjtLxfSoWgUbcdhViZJyNEVQC8xz2fZj9q9arqK+fy8e2pX9syeXRRg7cBvwB/FcVlO9UTMUIxc5unf1S2rwkkXxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tCjWgN/NAiNjLOCW6TU9gRGPxO1pY9ShiqBx2CDATA=;
 b=X8y78tbEZ3CvH1c+2aAsOBN1AJ75bPCy6k07Q2tLFmXfXHC/llElaNsuVXyu5eKEjmbRJ5ji1i86Nfe62p83LR/DUz9IxaR7/8uqX/egzfyJYNwgsMgZTXZrxowh0Bgbesl9vJGlMYwNl6sblVxDD0Mf9XGEnQn8QAecsJFtym8=
Received: from DS0PR17CA0012.namprd17.prod.outlook.com (2603:10b6:8:191::20)
 by CY8PR10MB7220.namprd10.prod.outlook.com (2603:10b6:930:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 05:15:59 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:8:191:cafe::51) by DS0PR17CA0012.outlook.office365.com
 (2603:10b6:8:191::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Sat,
 2 May 2026 05:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Sat, 2 May 2026 05:15:58 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 2 May
 2026 00:15:57 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 2 May
 2026 00:15:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 2 May 2026 00:15:56 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6425Frcn705867;
	Sat, 2 May 2026 00:15:53 -0500
Message-ID: <4ce9f13a-b17f-4149-ade8-57519f4a4752@ti.com>
Date: Sat, 2 May 2026 10:48:14 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <vigneshr@ti.com>, <robh@kernel.org>,
	<linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>
Subject: Re: [PATCH 1/2] PCI: cadence: Ensure that
 cdns_pcie_host_wait_for_link() waits 100 ms after link up
To: Hans Zhang <18255117159@163.com>
References: <20260501153553.66382-1-18255117159@163.com>
 <20260501153553.66382-2-18255117159@163.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260501153553.66382-2-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|CY8PR10MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ec5ca9-7d88-40e6-1720-08dea809e552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1DMlFSZl82TRajtb08J8jsXbOxCF6f+pbHI96YpvPF70D7nEtj4nGwqYOARMtJEFrcdUFRRzumi57aOEWaqHAAdH6W/Q4voLJs+pXugA1RkB7xZhj1pLDv4ERLYfXrUxNiZz23BtUxZplnyn7/ocUqBMaJjbG/pa3OOHGrcXTrPhax0gHUZJWLjCVzp+Og7LLlr8wrvxhlqsyMeCV5ott3Wq3kJTmbWZUgIKgkhtlaen0OD/GmarYuucY/VEN2vnvj60CGdaOapMYYXEFyc/ku806mrot2izXsed+zQO4VpYiLm/Q6yPcvDzRmQxd4JGzobsgnE2EddYHMGnO2az6lvysCOyprPmcaJimA7GEGxbqejj2SjUfP+kGlQqeJgwy5ibFF/Tju45I0m69ki9Xn12auJREYvVHBQI0yLOyIS7csno/XaDGjmLVVHXJDZI2MW6srgs6rkS5lXji9BChEZ8qq4pw2MmU3QMaMcBfJxPZoRIH16Z8V+KVR1QmP4iNRBXDcaxZNp1Q79sETaJeV/ZXxSyXPyPgRMSb9HRTUL0LVeq546kk55yqKfhX+w5kSy3XY41iyB4mjCU5CSpTzwuC6b17Ssw4geKd38mlEmpvD1yU7OEDuc1XnfgvrU2pzSLe6UdZrIKCA74bKsGHLsobCVsXget5tNfb6ES09hGIebdLeNE4jSOcQzUyF2XzGMAxBF/kuZMbFFQR01Gz00aPUNKC7QoZxaUfJEuzbA=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eFltndShEC7JM4E8AezFGMXXL68G+BjbPl38QbWROyryXTGmu6eDDQ9QkXvKy0XkFCHzwtxOZDjFK+EKT2K2AkWRg4JALwmVFJuLpijU2+ftHk+q4erMKwIOjQiJbDq8YUQUVS9z53hSGfvu+fDDW3QyOs4ZQHDMwmHVnaltZYScQYMAru+7DVY7Xyd+LIEk8P4knl94Pg788R9PZX0wM357qMaYElRda8+fq8p5b/PFI2bFORDA/t47GzPA0vmcxGKz5P+irkSZ5JNzFy8KTUCAhaymemCdZlyq484wDvHTZ5Tn0uv/xJl1jBm9Fu4fA0We2k0uj7R6FbJsgGSUeH3yc34zVIVMwQ0uTfBNFrt8IuW10tyfe4i/ptKAyDBNLP4Vv5qXZu7FyJX5Y6y/z+q9V9EQW9Aac4o9cELvcOWHfJLqzItkkDR5DKQkfjJ2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 05:15:58.7816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ec5ca9-7d88-40e6-1720-08dea809e552
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7220

On 01/05/26 21:05, Hans Zhang wrote:
> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> training completes before sending a Configuration Request.
> 
> Add a new 'max_link_speed' field in struct cdns_pcie to record the
> maximum supported (or currently configured) link speed of the controller.
> 
> In cdns_pcie_host_wait_for_link(), after the link is reported as up,
> insert a 100 ms delay if max_link_speed > 2 (i.e., > 5 GT/s). This
> implements the required delay at the common Cadence host layer.
> 
> Currently max_link_speed is zero-initialized, so the delay is not yet
> active. Glue drivers must set max_link_speed appropriately to enable
> the delay. This matches the approach taken for the Synopsys DWC
> controller in commit 80dc18a0cba8d ("PCI: dwc: Ensure that
> dw_pcie_wait_for_link() waits 100 ms after link up").
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   .../pci/controller/cadence/pcie-cadence-host-common.c    | 9 +++++++++
>   drivers/pci/controller/cadence/pcie-cadence.h            | 2 ++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> index 2b0211870f02..d4ae762f423f 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> @@ -14,6 +14,7 @@
>   
>   #include "pcie-cadence.h"
>   #include "pcie-cadence-host-common.h"
> +#include "../../pci.h"
>   
>   #define LINK_RETRAIN_TIMEOUT HZ
>   
> @@ -55,6 +56,14 @@ int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie,
>   	/* Check if the link is up or not */
>   	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>   		if (pcie_link_up(pcie)) {
> +			/*
> +			 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
> +			 * supports Link speeds greater than 5.0 GT/s, software
> +			 * must wait a minimum of 100 ms after Link training
> +			 * completes before sending a Configuration Request.
> +			 */
> +			if (pcie->max_link_speed > 2)
> +				msleep(PCIE_RESET_CONFIG_WAIT_MS);

I think the above could be moved to cdns_pcie_host_start_link() as follows:

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c 
b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
index 2b0211870f02..0f885dcbdb12 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -115,6 +115,15 @@ int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc,
  	if (!ret && rc->quirk_retrain_flag)
  		ret = cdns_pcie_retrain(pcie, pcie_link_up);

+	/*
+	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
+	 * supports Link speeds greater than 5.0 GT/s, software
+	 * must wait a minimum of 100 ms after Link training
+	 * completes before sending a Configuration Request.
+	 */
+	if (!ret && pcie->max_link_speed > 2)
+		msleep(PCIE_RESET_CONFIG_WAIT_MS);
+
  	return ret;
  }
  EXPORT_SYMBOL_GPL(cdns_pcie_host_start_link);

This will avoid an additional and unnecessary delay when 
'cdns_pcie_retrain()' retrains the link.

Instead of checking for the link being up using "pcie_link_up(pcie)", 
checking for 'ret' being zero should also work (ret being zero indicates 
that the link is up).

Since configuration space accesses will not be performed until 
cdns_pcie_host_start_link() completes executing, it should be safe to 
switch to the above implementation.


>   			dev_info(dev, "Link up\n");
>   			return 0;
>   		}

[TRIMMED]

Regards,
Siddharth.
