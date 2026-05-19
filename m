Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339933F5B1;
	Tue, 19 May 2026 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169273; cv=fail; b=M3k82X4KlUuNUuQ4S1NgylpWGGwADpXtCcKH0jbyI7bhqM9sgMkkVpsYLhpNxhdt5pYGueQ/tBki9KHNwIajc1YhmpjPGa+VQMwbiQyb1v9G6608mc82+Xf177+Y+AgPl3AOgOMKP+9ZPwLxwtW8RcMNXQCFfSzcK+mvPkcvymk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169273; c=relaxed/simple;
	bh=IxDDBi8WLWboC23ieuaGgP+MyQrPqbmvIjq3Qg25364=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TCDLu65mFocJQE2LQdxgYAT+Dg2d+teJOI29X9GIaKlqqhOBzpdwpWyU7P8P5GMpaZ9qH4LHZ1D1O/zwUcwlWm8tYtX9gWDxISno+zQdRFFlI0vzTUY7aI3I/AGWQwUL+lWqZDmiJ5DRUCnFd3KAZURJiby0RKSz3Wi/W0txmlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A7MZzp7H; arc=fail smtp.client-ip=40.93.194.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A7MZzp7H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nl3Yz0iGiDzDzDiUM2GNpcjGJ+DX6W0fZCWkFMu/yEv4nwgaKTPghjzohsh3ExTeMoX7k8JDXWKWQXbr3jVwpGZngWSoBW8Tpa3x6Vk+Ri0Hci131agRiqy4+4AAaYQWzIVHJp6NgksXASgnAB30QHOvvfRONWjr0iPY6YCc6thfIOhM50DkMyCdaIwSZLzuZ62/EoXwxAGcpzMuLPjA5Cnck0YXO6N5i/1kB5ewSDgczEBUr573eMFZ+hGKY0Gj4RWDDNLhsfP/LE1OjV1E8Ql1VkdaMcSmtPDczKLtjxL/rBQ5sJRdDi4ZkJBTJPCZnr3W2PuQ1rE1rmjG7QxquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH5karuIHzDSSbUkyG+sQm3LxjGK03c9vXeQ1/XNMZc=;
 b=QKRm2fQodk8eddH77AHllTppTm9bu7INDA7te7cqCv7V0lIvBpdoe9cq7ZR3rg2RYxGbXtIYvhIhqV4G6lWzCg8Ud6itxTiIeGOUy1BKBd/5rSG5ZSXvYz7pwE8mk0o9LkKarpwDo0lE9ei5+rRmC/vq+GmchTBOCqnTi9PAB6Hiqm8KmTuljNUg+TaYBf9TQS06gFdvZ53ZAS0l1eCnTxkgV/24UrkJEyLUAQns451NcLWhGlb1tt/2XyxSzQqHslEz9ylkihUCfdRDVPK8PshCmBQIfY4MuIhefoCAZPPFyIDcJWjyxpmDqBc0OStjOfWeLbAASA6V1YVfRG2tvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH5karuIHzDSSbUkyG+sQm3LxjGK03c9vXeQ1/XNMZc=;
 b=A7MZzp7HZM3ReONU6L5TAIQGL/ghVn2ELTcm4um9h9IGnaur3PuEyA+MpT0v4aU54HHWsWYoHzKz4Oy8KmGfbqDQV3acchxpUkGsvr5MyMGEQ4eHOeKMyzYtnA8LlhrGIOjdlxz0/ZotPM9o/iLpUDC3mINoY3nTKmjbTcZ57Lc=
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by IA4PR10MB8517.namprd10.prod.outlook.com (2603:10b6:208:56e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Tue, 19 May
 2026 05:41:09 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::77) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 05:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 05:41:08 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 00:41:05 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 00:41:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 00:41:05 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64J5f2nE2855571;
	Tue, 19 May 2026 00:41:02 -0500
Message-ID: <1bd033f4-a695-4266-aca3-1e034a161c3e@ti.com>
Date: Tue, 19 May 2026 11:11:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM status
To: Hans Zhang <18255117159@163.com>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<hans.zhang@cixtech.com>
CC: <robh@kernel.org>, <mpillai@cadence.com>, <s-vadapalli@ti.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260515145747.129635-1-18255117159@163.com>
 <20260515145747.129635-4-18255117159@163.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260515145747.129635-4-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|IA4PR10MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: f67fc9fd-ac64-4561-bc12-08deb5693a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	scQJ2blTzHU4xyd25r6xokpDdkd53K63OO54tFzWOlGGFiYmXQ19h4v/IZ4WuSCQxRxlc3ISHuW/RK17OSNh0henV1Qu6tt3O7+HALkFryvqCfS2fYw8st1D9jUcEFnv/DLKo9w6RdZ6IWojUQoeQSfG0aCgYR9A92vx04npfxn2jalpWfEFoTjfBjYvwOv0/1TUnbTBmx21beFE4Brz/iQtuugesQ0t0o5NxnP9ob/vsPiZaosp6gB1SrwZOLNMc7uZ6Y7uinCIYUmfBMFSkvAYdzRcecuBjvz7MxCUucCRmyVNRmkFXKYGwgu7vC2iBY8CW2AiIgd6IfCIm0ZW/cwsejEqY8YAO+el2NeypPtQ3TK2Fr9ke4GDjUgRmNTg7SuzH683ES8TviGaQ6D6Zy9UWNwgStyIrgHWTCnqRK8S7bWHMToKqUQqZLpuuQcYBon+hA62HkZ14g/9fvnHsZZG4fLtXEINkVfNFM5cH2OLBBd5srG9Ygp7Tx/tIa0m4aVDA3nn2SvthEwfkEANlM4eBKV/Xpcq8BFhaXJFnHrPeULTuO8PzbGVmbzDQ36HvaRHZQOrSB7XmtVuFjOPkGiGiSrYhUCfpurXy5DVEE8eAdWW7spkfOsYyKxw1pdv0nTDU7OqmHsr0UQoroBX/ABpi86+Xx1U0Tb0kzAubuSEpeylOIM/0i39bclDnUEb9gCjsJim5DvsU89iNkW5i92SEd4NMNSzym99oeagETk=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4TI9jq0wzRdRLBx8yPPJ/bG/uP5/EJdERzt64ngp4ZinXsceTNM2i53AFKK8ziJRWwu7oP3ZwYIoDUsz9kz2Oqei/4wNG3UiuTv1AynGsmOZCTMO0vK3kCVnPmHybyIb7Sxp/O4WHUxNUer7J29zYzYaM4/GRD1klkOpaaySugy0mrJVydp8Z5BLU5W4s9wE+kr5m7iBxlnflPrp//MfKc76VrOqJRbeg5bWB7mJch+HbFg+lRwofNbWp6Hy3bUTXNmuZloMvJ5eEsgCS6i/D42kq3benFATzq2QKL0SKKTfRXXbS+nnRnklojB2gp9DolC6yhLJCUBERRyEcIWfoJQ2Ku4z12iREGP6lvroM0kTDZNjjT2uQwoCGQXQ4Et2m0s4+XiT6OQ3KF3rmQo1DJUma8ubAbGAEau78bevcFyUon2WPX8hhwy+9Cv/bXpv
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 05:41:08.5437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f67fc9fd-ac64-4561-bc12-08deb5693a41
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8517



On 15/05/26 20:27, Hans Zhang wrote:
> Extend debugfs support to LGA-based Cadence PCIe controllers. The
> 'ltssm_status' file now works for both HPA and LGA IP by selecting the
> appropriate register access based on the 'is_hpa' flag.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Hi Aksh
> 
> Could you please assist in checking whether the ltssm_status of LGA is
> correct? If there are any inaccuracies, please point them out.
> ---
>   .../controller/cadence/pcie-cadence-debugfs.c | 61 ++++++++++++++++++-
>   .../pci/controller/cadence/pcie-cadence-ep.c  |  3 +
>   .../controller/cadence/pcie-cadence-host.c    |  9 ++-
>   drivers/pci/controller/cadence/pcie-cadence.h | 43 +++++++++++++
>   4 files changed, 112 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> index 97c5deef2b1a..ac985699b974 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> @@ -13,6 +13,58 @@
>   
>   #define CDNS_DEBUGFS_BUF_MAX		128
>   
> +static const char *cdns_pcie_lga_ltssm_status_string(enum cdns_pcie_lga_ltssm ltssm)
> +{
> +	const char *str;
> +
> +	switch (ltssm) {
> +#define CDNS_PCIE_LGA_LTSSM_NAME(n) case n: str = #n; break
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_DETECT_QUIET);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_DETECT_ACTIVE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_POLLING_ACTIVE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_POLLING_COMPLIANCE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_POLLING_CONFIGURATION);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LINKWIDTH_START);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LINKWIDTH_ACCEPT);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LANENUM_ACCEPT);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LANENUM_WAIT);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_COMPLETE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_IDLE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_RCVRLOCK);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_SPEED);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_RCVRCFG);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_IDLE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L0);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RX_L0S_ENTRY);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RX_L0S_IDLE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RX_L0S_FTS);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_TX_L0S_ENTRY);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_TX_L0S_IDLE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_TX_L0S_FTS);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L1_ENTRY);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L1_IDLE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L2_IDLE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L2_TRANSMITWAKE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_DISABLED);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ENTRY_MASTER);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ACTIVE_MASTER);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_EXIT_MASTER);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ENTRY_SLAVE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ACTIVE_SLAVE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_EXIT_SLAVE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_HOT_RESET);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_0);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_1);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_2);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_3);

Hi Hans,

You might need to rename the states as CDNS_PCIE_LGA_LTSSM_* as
suggested by Sashiko to print the state names correctly, and also to
complement the naming used for HPA LTSSM states.

> +	default:
> +		str = "CDNS_PCIE_LGA_LTSSM_UNKNOWN";
> +		break;
> +	}
> +
> +	return str + strlen("CDNS_PCIE_LGA_LTSSM_");

I have tested for LGA IP by updating this to strlen("CDNS_PCIE_LGA_").
The state encodings looks good to me.

Regards,
Aksh Garg

