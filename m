Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B813CF95E;
	Fri, 12 Jun 2026 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251125; cv=fail; b=uexBiToWGrpBFGR7ZaDPV2JhSUOEFk+Yf8knt1iG6pE3TZvbU8AlKC4ZgmBlexo8V1ELbm1Ew+lRWdU3FOKspDApVMlyHmYczoQYrU15h0GpMTB/rvTg8BYZT3nmf6xmLbt7Xp+7Utu/wIkNor9LhNxAVOtLMbvrmOvruEpQCFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251125; c=relaxed/simple;
	bh=pxlnpyeG0ZWEq8fdJJ1dcEqZJd+VQ4YSFUYV6r3U2dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sSE8dvhOgTTUt5QD0Ogh5yTH3Y3qKYODBukGlNVqPZXmZjq5+wnSuOp7fktqqTAGJQshj8twjhd6r12tgirMlZ8G9HNpllm/Xa/3xvhV8ZhSzHa2TTD/hMisKCmuODXzFa0B/SZVD7E2Ylq0qRnKxtpsN2T6pFN7IemGAZ3NM1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tMvAWKyP; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tMvAWKyP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsTrx5mdrt513e1sf1uCR2DYxJaqc/8FjowsRSuv77pVSying80EwCMELOl5ewWSqfAStsq9vvgstF921egri+7ER3mtLQe/h6WT0b7bYu74R8L6Lvs6mqEQtzftVOCKr7940Tt/nijsX8t9xnr31HGjUdWs/cNVH42y8HMHr4zLZW1b3Qgp0Odbecu68gDAqt2AWtwFXrV8P5F/DjAuB2FvKvYwNRfhEvxYnXq4Jpaol4NZlhuS1UKVOtWMdky0xihMstg9kbv+tz8mrXLfqP+DM+bDYrGLUAbXXjAW6Mp8w/YOsAUGdTQMsYpLF4qMmdrmX6xZBm2U+VGN/KJwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCbgQ8ql4hpJlWkohGyE165C2sc1XuoKidrE/9rlKS8=;
 b=ZAeSda+rpVSeWaBMrdEYMhlNfN8qDT7sjfCtp+64FBn3FJS/clRae7Fgjrqr5kOnY8D9Oly/VzOcjJMWd2EUmFgYO+7cCqUydliiJXFsXlvyvQmFpuB01JwOS40Egby9M9OG8M9vnt6IVLiB+/k2NZdi74qdIk8qnb9jC7201ROOXiraJXs+PlXQ7MpiNh8bMnJ2NoQHanspXg1yrLjI1KlF/ulyQvNZdfZVTAgAis9X3SlNFYj+9CVBKxpsrcUBIFq/xJHw8sAfI1avxV4Ij3MAsSO5WW3/w5vpsJzR81J+QFp+13ss5+/PCku75ODsBlvpaPwMi2hX6Ev4fMsZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCbgQ8ql4hpJlWkohGyE165C2sc1XuoKidrE/9rlKS8=;
 b=tMvAWKyP6hsphTQQGx86sGh0SJYi+EIcO7qkg/QapFoObojYBIDauWrtkRcdxISfFkx9lGoBgF9h9jo2SeIYzQIP0mUZ6KS5kHlQImhTjok1DPIGKcz0m768pS0ForVvcZrbghjoHxbn82JgBGbFdHGhndMIbhrDHs9ebT4ovyQ=
Received: from SJ0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:a03:39e::14)
 by CO1PR10MB4657.namprd10.prod.outlook.com (2603:10b6:303:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 07:58:42 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::70) by SJ0PR03CA0279.outlook.office365.com
 (2603:10b6:a03:39e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 07:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 07:58:41 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 02:58:12 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 02:58:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 12 Jun 2026 02:58:12 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65C7w7lV3061767;
	Fri, 12 Jun 2026 02:58:08 -0500
Message-ID: <e8b28867-07a4-4061-864f-a3d362a041a2@ti.com>
Date: Fri, 12 Jun 2026 13:28:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] PCI: Add DOE support for endpoint
To: Frank Li <Frank.li@oss.nxp.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
	<lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>
References: <20260610100256.1889111-1-a-garg7@ti.com>
 <aise1tIyTj4WLU89@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aise1tIyTj4WLU89@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|CO1PR10MB4657:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0e2ed4-769b-4e7e-2df6-08dec8586b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|7416014|22082099003|18002099003|6133799003|56012099006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	DqHbDaOadvV+II+wu9dGfyRZb0hNMDrYF/Jh8G5m34EPomDhWIn5UvrMRPDRri6NIZDdDciLNftp0R67P8Zr6Xmn2Qeyv7TFHTx2tsB+y6A+um2dTcA00IpDYJfAluCA+G9T3Z6T80uLNAMY+Wz477nkbhEf+BponcgUmcU79b3X6MVwlFOISTrL/Jk65UeZ+tjsIv49DgbMsMPSmwIwgru+xNzyCltFfk5RWJxxFhIA4TutxeWEnfkstw5h8IXBbVe+8bDepWwWM5f6y5yqUNuIrW6+DlZaTkVsACw/XJacoPGZrbryjJEfu5cg1qa5a8/NycoZLt+yPRTYokr0RZPSklCOxkkhSkU0eH/bo6eNvuckKAEbtioQXStpQp0Fvqa7xSK6XtnudXPf8vYbOL9Ercpr3nKPt20KlqLzKjxSQ1yrMj0hQrx/xnGUaBBCHqJoXh4e+zJXVCSdBBSkKph4h116ZFHoccqCdGYrb+7lLZnNdQwEM/Lc3NOyOwv2CcEmF1J580akNIqt8j1ufetO8SfYZCdiFkyTPDwmR87ruH0DX6M6fZ2oQAtXEgD6FIw1t57Ocr02Gjn2nGdg3Brxcr8kVHZnFGbIfYG1gDHOW8nmSP83Bhhe0L9f15EHSHZTiQ6IH6JaXPwJX9wfYo4YvwE0hJfKk4Eec6Kx3dMl2NsuQ4so/u93AMImg9Ikn9At14dHMkgjAwXe4h3AIiOLddqoe3gJuga6DtQI/rU=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(56012099006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+wF2u2NqiHAh2a6wXd+5gBc6xL06pQKx/sUe04YojLlOF/TiFQYJ8bJwclOqinhR/QBzDg//gTZ132NrLmz+7I58c/q3XlOR6BeQVZSwVdnXOZSGdYT8Pz36oeBObz64eyQhEqjDh6kVh81yFBrdWcgM2iQdImW1Llt4/U9bz74vLEUpYOw0LFVY8FxY23w/fjfR48qgE7SMDmD9SQeXmbQmtpt18vSOjoEr9j8rg+KeBqM9z7ohe/ovFZyH/vYi99ZRRi/YYJRt9M4YVHSuFzA4fnLiLMnnFpJGxhrfWIcICZjmpN3L4/S2nUP3gN4+L+moM+ctr4y2sc6NVlCNCOrXRV0ekwMcCCI4Kszv6Hhiv2lMnlbXVmtdec2DNpaP9N1W4YS6ebH50H11cui1prIVrUolelJ/OG8+MNBKYzzHtJAZiEELcMgZ690W2+1p
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 07:58:41.1656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0e2ed4-769b-4e7e-2df6-08dec8586b1e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4657



On 12/06/26 02:17, Frank Li wrote:
> On Wed, Jun 10, 2026 at 03:32:52PM +0530, Aksh Garg wrote:
>> This patch series introduces the framework for supporting the Data
>> Object Exchange (DOE) feature for PCIe endpoint devices. Please refer
>> to the documentation added in patch 4 for details on the feature and
>> implementation architecture.
>>
>> The implementation provides a common framework for all PCIe endpoint
>> controllers, not specific to any particular SoC vendor.
>>

Hi Frank,

> 
> General question, does DOE generate irq when received msg for HOST? I have
> not related irq handle code.
> 

The EPC hardware is expected to raise IRQ when it receives DOE signals
from the host. The example IRQ code handler have been provided below.

When the response DOE is ready for the host, the signal_task_complete()
in pci-ep-doe.c invokes completion callback function, through which the
EPC driver handles to send the response back to the host using the DOE
mailbox.

> Any program to test it? such as pci_endpoint_test, need at least one real
> user to use it.
> 

Currently there is no EPC driver upstream which support DOE yet.
However, you can refer to the conversation at [1] where the plan to add
user for this framework has been discussed.

Regards,
Aksh Garg

> Frank
> 
>> The changes since v1 are documented in the respective patch descriptions.
>>
>> v4: https://lore.kernel.org/all/20260522052434.802034-1-a-garg7@ti.com/
>> v3: https://lore.kernel.org/all/20260427051725.223704-1-a-garg7@ti.com/
>> v2: https://lore.kernel.org/all/20260401073022.215805-1-a-garg7@ti.com/
>> v1 (RFC): https://lore.kernel.org/all/20260213123603.420941-1-a-garg7@ti.com/
>>
>> Below is a code demonstration showing the integration of DOE-EP APIs with
>> EPC drivers.
>>
>> Note: The provided code is just to show how an EPC driver is expected to
>>        utilize the pci_ep_doe_process_request() and pci_ep_doe_abort() APIs,
>>        and might not cover all the corner cases. The below implementation
>>        also expects the EPC hardware to have some memory buffer to store the
>>        data from(for) write_mailbox(read_mailbox) DOE capability registers.
>>
>> ============================================================================
>>
>> /* ========== DOE Completion Callback (invoked by DOE-EP core) ========== */
>>
>> static void doe_completion_cb(struct pci_epc *epc, u8 func_no, u16 cap_offset,
>> 			       int status, u16 vendor, u8 type,
>> 			       void *response_pl, size_t response_pl_sz)
>> {
>> 	struct epc_driver *drv = epc_get_drvdata(epc);
>> 	u32 *response = (u32 *)response_pl;
>> 	u32 header1, header2;
>> 	int payload_dw, i;
>>
>> 	if (readl(drv->base + PF_DOE_CTRL_REG(func_no, cap_offset)) & DOE_CTRL_ABORT) {
>> 		/* Aborted: do not send response */
>> 		goto free;
>> 	}
>>
>> 	if (status < 0) {
>> 		/* Error: set ERROR bit in DOE Status register */
>> 		writel(1 << DOE_STATUS_ERROR,
>> 		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>> 		goto free;
>> 	}
>>
>> 	/* Success: write DOE headers first, then response to the read memory */
>>
>> 	/* Header 1: Vendor ID (bits 15:0) | Type (bits 23:16) */
>> 	header1 = (type << 16) | vendor;
>> 	writel(header1, drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));
>>
>> 	/* Header 2: Length in DW (including 2 DW of headers + payload) */
>> 	payload_dw = DIV_ROUND_UP(response_pl_sz, sizeof(u32));
>> 	header2 = 2 + payload_dw;  /* 2 header DWs + payload */
>> 	writel(header2, drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));
>>
>> 	/* Set READY bit to signal response ready */
>> 	writel(1 << DOE_STATUS_READY,
>> 	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>>
>> 	/* Write response payload DWORDs to Read memory */
>> 	for (i = 0; i < payload_dw; i++)
>> 		writel(response[i],
>> 		       drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));
>>
>> 	/* Wait for the memory to empty before clearing the READY bit */
>> 	while (!RD_MEMORY_EMPTY()) {/* wait */}
>>
>> 	writel(0 << DOE_STATUS_READY,
>> 	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>>
>> free:
>> 	/* unset BUSY bit */
>> 	writel(0 << DOE_STATUS_BUSY,
>> 	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>>
>> 	kfree(response_pl);
>> }
>>
>> /* ========== DOE Interrupt Handler (triggered on GO bit from root complex) ========== */
>>
>> static irqreturn_t doe_interrupt_handler(int irq, void *priv)
>> {
>> 	struct epc_driver *drv = priv;
>> 	u16 cap_offset = extract_cap_offset_from_irq(irq);
>> 	u8 func_no = extract_func_from_irq(irq);
>> 	u32 header1, header2, length_dw, *request;
>> 	u16 vendor;
>> 	u8 type;
>> 	int i, ret;
>>
>> 	/* Read first header DWORD: Vendor ID (bits 15:0) | Type (bits 23:16) */
>> 	header1 = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
>> 	vendor = header1 & 0xFFFF;
>> 	type = (header1 >> 16) & 0xFF;
>>
>> 	/* Read second header DWORD: Length in DW (includes 2 DW of headers) */
>> 	header2 = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
>> 	length_dw = header2 & 0x3FFFF;  /* Bits 17:0 */
>>
>> 	if (!length_dw)
>> 		length_dw = PCI_DOE_MAX_LENGTH;
>>
>> 	length_dw -= 2;  /* Subtract 2 DW of headers to get payload length */
>> 	/* Allocate buffer for complete request (headers + payload) */
>> 	request = kzalloc(length_dw * sizeof(u32), GFP_ATOMIC);
>> 	if (!request) {
>> 		writel(1 << DOE_STATUS_ERROR,
>> 		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>> 		return IRQ_HANDLED;
>> 	}
>>
>> 	/* Read remaining payload DWORDs from Write memory */
>> 	for (i = 0; i < length_dw; i++) {
>> 		while (WR_MEMORY_EMPTY()) { /* wait */ }
>> 		request[i] = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
>> 	}
>>
>> 	mutex_lock(&lock);
>> 	/* Check the ABORT bit, if set then return */
>> 	if (readl(drv->base + PF_DOE_CTRL_REG(func_no, cap_offset)) & DOE_CTRL_ABORT) {
>> 		kfree(request);
>> 		mutex_unlock(&lock);
>> 		return IRQ_HANDLED;
>> 	}
>>
>> 	/* Set BUSY bit */
>> 	writel(1 << DOE_STATUS_BUSY,
>> 	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>> 	mutex_unlock(&lock);
>>
>> 	/* Hand off to DOE-EP core for asynchronous processing */
>> 	ret = pci_ep_doe_process_request(drv->epc, func_no, cap_offset,
>> 					 vendor, type, (void *)request,
>> 					 length_dw * sizeof(u32),
>> 					 doe_completion_cb);
>> 	if (ret) {
>> 		writel(1 << DOE_STATUS_ERROR,
>> 		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>> 		kfree(request);
>> 	}
>>
>> 	return IRQ_HANDLED;
>> }
>>
>> /* ========== Abort Handler (triggered on ABORT bit from root complex) ========== */
>>
>> static irqreturn_t doe_abort_handler(int irq, void *priv)
>> {
>> 	struct epc_driver *drv = priv;
>> 	u16 cap_offset = extract_cap_offset_from_irq(irq);
>> 	u8 func_no = extract_func_from_irq(irq);
>>
>> 	mutex_lock(&lock);
>>
>> 	/* call abort API only if BUSY bit set (pci_ep_doe_process_request() called) */
>> 	if (readl(drv->base + PF_DOE_STATUS_REG(func_no, cap_offset)) & DOE_STATUS_BUSY)
>> 		pci_ep_doe_abort(drv->epc, func_no, cap_offset);
>>
>> 	mutex_unlock(&lock);
>>
>> 	/* Discard Write memory contents */
>> 	writel(DOE_WR_MEMORY_CTRL_DISCARD,
>> 	       drv->base + PF_DOE_WR_MEMORY_CTRL_REG(func_no, cap_offset));
>>
>> 	/* Clear status bits */
>> 	writel((0 << DOE_STATUS_ERROR) | (0 << DOE_STATUS_READY),
>> 	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>>
>> 	return IRQ_HANDLED;
>> }
>>
>> ====================================================================================
>>
>> Aksh Garg (4):
>>    PCI/DOE: Move common definitions to the header file
>>    PCI: endpoint: Add DOE mailbox support for endpoint functions
>>    PCI: endpoint: Add support for DOE initialization and setup in EPC
>>      core
>>    Documentation: PCI: Add documentation for DOE endpoint support
>>
>>   Documentation/PCI/endpoint/index.rst          |   1 +
>>   .../PCI/endpoint/pci-endpoint-doe.rst         | 333 ++++++++++
>>   drivers/pci/doe.c                             |  11 -
>>   drivers/pci/endpoint/Kconfig                  |  14 +
>>   drivers/pci/endpoint/Makefile                 |   1 +
>>   drivers/pci/endpoint/pci-ep-doe.c             | 594 ++++++++++++++++++
>>   drivers/pci/endpoint/pci-epc-core.c           | 104 +++
>>   drivers/pci/pci.h                             |  48 ++
>>   include/linux/pci-doe.h                       |   8 +
>>   include/linux/pci-epc.h                       |   9 +
>>   10 files changed, 1112 insertions(+), 11 deletions(-)
>>   create mode 100644 Documentation/PCI/endpoint/pci-endpoint-doe.rst
>>   create mode 100644 drivers/pci/endpoint/pci-ep-doe.c
>>
>> --
>> 2.34.1
>>

