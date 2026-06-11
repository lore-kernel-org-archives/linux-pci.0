Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB45235AC0C;
	Thu, 11 Jun 2026 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210850; cv=fail; b=WNDIwaF+5y19zEq1hNzX12DnA1AGcFewXlqpCkwZNhIIJVYOWfwq9BswTBQsz4l0pR7hnSYP+JMyw2ofBYtYVQKrQPAxeAOriNPfN9LNUjdrmEsXpnuX4JMZ8A0KzCSb9ssPAkna9MT7DAN82Hk1h9y4ara6nGFr1vIHEsfJ01g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210850; c=relaxed/simple;
	bh=r39DvU8bMGYrNOQIRiouhjTcL8W7z4rs75hUPDjtFOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oydzHXjq1rIzSm4Y8U20qYpovuxpqLtaRwIBfILON+ujGj80eydu+P9c9V1HjlyxT1HmFOkalJZbwgu5CDu4cW0XErJfFCtmqQD1S9HZxuNkN2kC27S05JZ4w0cJutQqTDKrt11KUUTY29Q5XorS/00es4rhjygq8GFUFxwkFHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J6ZICj1c; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J6ZICj1c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUM35Pwh36iRIrjxQ6hqzwBUWWYPpmgvefoQOBC7HabOHq2DDmwS3LsgVYuTdyieb2f03HBzznSf5UhiGQgyOLm9xdcbPbpf9cyocGQ1c779g3flS9QwTOJBihnpiG9mUeIFArG4b0jXn/TsEm24iflWj5o0Hjj+Ms/x5xXDmRAWCG8EFXZFKlUv7pG36MbBBOZrpIYXHNINyt7GL4lkPrZNuZs4A043K6FTvX+Ri6BvVMrEeOpNyGGCwq7jUymh/lOvzqkSJmTQUKqEJJCg1h/spLDcOQ30a8VeVMPbIHCrqR0mhxpRlvVKVIa5RZj5U0SoQkuYZ5CtaCG/ClcAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp0V96hQHO0Vi6EebPNh77DUKMaBtTyx0jyQfV8ieCY=;
 b=phRVnClxZlgmVEreYwslKEMOP50dqZ/No5ROIq70+X8LSsC0KE+HlyOXoqBv0DM9E7kujzgbqJgzZd7yG9DcQWAC4VT8XxC3HKB7paZ4VhwQoDFXGP0Dwx8bqZYbrENHrb539RUKfei8OgQBhds4W7tFrqEtLCVBHoKMUBUF2smTxYM+E9JCpN3XwpO/nfpP72IIYsQIZOlD6FvGedqcJ2ilzuE8R/+Il2vSBmZB6oj9lgdhXOpcNEo5RLzoFumUE8aXE8mQwaFTme4F1WdqK99pPqADb0REY1eIKSHY7VI1zqrqKNEh2oLS7LDDwWqB5UI5fW8lbTv9ZVOmFGWiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kp0V96hQHO0Vi6EebPNh77DUKMaBtTyx0jyQfV8ieCY=;
 b=J6ZICj1c+jk6ovcrpBB+bAq3GSCPXAR/a0ise4JfCVX3XIsobtRQVAT7dDYtvlEIMUPm8pIAYJe7kE3UOY4o2qvq+YgAprZeQUuqCjQmX6gvC4a6Bqg8hKpmCFHDyEgpq3mY/k3P+uKMu7kN+jQRIxSiKWhK2eS8feERZCyrdIoK1nncsGcsqZedahJ43NH/EnlGEjcfGwP/WBMMN+EWMvIFyqBCUHTUyefDSu2RtRTmnvmvKEB1Lw8g9Wy9xxaTiM7r6jCk8KX+0ocnJA0BUrQtcvwRCFKVFslXs1/HawA2a0M7TBR/sLqew+BB4U6OkLLvN2yolNcXTp1Lpyav+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB6796.eurprd04.prod.outlook.com (2603:10a6:10:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 20:47:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 20:47:25 +0000
Date: Thu, 11 Jun 2026 16:47:18 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, corbet@lwn.net,
	kishon@kernel.org, skhan@linuxfoundation.org, lukas@wunner.de,
	cassel@kernel.org, alistair@alistair23.me,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v5 0/4] PCI: Add DOE support for endpoint
Message-ID: <aise1tIyTj4WLU89@lizhi-Precision-Tower-5810>
References: <20260610100256.1889111-1-a-garg7@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610100256.1889111-1-a-garg7@ti.com>
X-ClientProxiedBy: SA1P222CA0176.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 237a1f7e-3cf4-461b-d55e-08dec7faa4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|19092799006|6133799003|18002099003|22082099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	G/CR8Zfrn9UJEOR9xkT0sOTJVen0nxxT299+lvbtgnNB0U4BRDsgmQhLbxJ2ftERA1XhLStPpLvpxRBLO2GsPDOqO4UvWG33rkVgvV1rKM4aIR6veTe4kl7dUVWWe7+P+XxQ8QwfMZnIfGJKbEJdSoUGbglRHq6+EdYm2HTxvaIoKkNsOlOp/pe4a7sc1GwvTqTUQg/X4ItoXoqYPH/zzV1DAe7LwsdQVUlZ4fa6kRzz43lc32pVRGoR6yn42oc5b4uyWaec7Eut4wCO4ay+48IH8mBzn90yE2J4JkmPRfFHYd7Vr/XHsZ0wUV94RNryYrM/mzp3Ze0rM5+31umhDI74LC3O8QxNvdanQ6QvuBCZaMLPcTn0xcA3SQVsyL5NwJHv8FcUtN64KhurgEP/CQxbRWnD8QweQ6IQOrmaL0hQWn4kJ/QbK+gKn7b9qTjX3dgqH1zwL4aNFL1G7XrGld/yEjlK49/OnST7+gJPYmos1VTZVEK7GtbVA5FLdMKqk7kGGVu+anhXuVonJTXslRdEQTvw1+lvysc15mswmzafxtSm0zsmqVGkl/7ALdLs7NIWe+zq8329OMyuiSfhyzIjBh5D1l0+ASqfv60JEHvtR1eXgW8y3UlFqABR2pkg19TjhRF/r6ToQddI+Yi/LnJJMcPGKfAi+5BljEoC9QoJbiiJQAUXUQIW0y5rQ2dEOrzeEbekcLwpV8//6Zgmbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(19092799006)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h8SGX/prKXwgyELifkCcbf+WSK1n+yvXBDQ0JZXwTk2nD9d982lXnOMvjDNH?=
 =?us-ascii?Q?+JQ4jvFkpXmsi+KyGglduBdaP1bKAv3mtD7VNR/hcf8j3K4uTa3F7jPCeuNX?=
 =?us-ascii?Q?yOlLysrmIq1OTNZtn1KmYtHv4Ejr4EnWX/w+aVnIc7+YdrCAFaDLz3SkQ447?=
 =?us-ascii?Q?At9k4go3C/jTtilOKUQnB3XaewsNmZmw4cv1KwwE6tbtE6Z6xses3OAjelIf?=
 =?us-ascii?Q?7r8AwcZ5e1WIhqhYO/ecbOnHLal9G5WRlUdK1WpgVNqrYIf6LvFAXz9gsEMn?=
 =?us-ascii?Q?fDmUT4UatM2rrFCPTc8yif6LAPbmpB5e1UdZq1TrlHLU64MKJ9sdHJptrVmp?=
 =?us-ascii?Q?lGr6j59U3x/3wOH5RKtABDUHhlRE2+rVyybu5a1qcgqvoXrqP2GLnNjB5k+F?=
 =?us-ascii?Q?eZOCJUDgc6GiRHkgVYu68dl/DOTicGpndA1fT/exSDXkjcKzX1tDJx9ASH3Y?=
 =?us-ascii?Q?kJVqTIhntunmV71xxi5Z8E7Vwcs0aNl3M8bIM3aV8QyUpRv/4/gDiuYRkOlo?=
 =?us-ascii?Q?bOpP7wEEVajx7iJOkX6uFDnlwEkXb4OpW4+3YxESKx4YKhlHmZURkdCf8EUJ?=
 =?us-ascii?Q?HeCLC74AxCfZJNbkFd2wz06rDUbwdQS54B5FwD92Lp8+R8XSc1Mgp5cZ4AyP?=
 =?us-ascii?Q?Qd3QtAa4i1MJKO+Jelh5WIaRVDzOVHm0wDBNj03Ll0DmGn/HBPH4DLYbgtHq?=
 =?us-ascii?Q?NVnx5RIAsiHo9M9lcdnVq685l9ZJ6vmLyfR0HwZhvHoSanNJT9Iy7nxw4rYu?=
 =?us-ascii?Q?m5r3mzadyYPdSyaA11d5RmnHI91+DR69zdD4VkTi3rdjLNYpEhtPHPB6bDil?=
 =?us-ascii?Q?EuokuOl56P5CclDNxzs46NExYF6Kk8N7Etmf4ccRvta0ss5BEKxj8S7AvY/O?=
 =?us-ascii?Q?Q6Bdyn9VsE6UZIZaNJ2poLvUUOdRI+sQF8m3OHvdx7W1IIiovayyJ0qT+yK5?=
 =?us-ascii?Q?k4ipfiMYbxcLNZDyjpKx2UA6Y7vfKdUvmkZVcVgIW0ihiw2a2D9vGVsdpOX5?=
 =?us-ascii?Q?Z3+xj9YkWTwBXd65OhlBR+u9ukRstjMzvLWQiOqsWOX23zXJetM0rmKmJ9ZB?=
 =?us-ascii?Q?D2f6S8dGyTzAsWXr0GSzIfwwRoqTToW0xzELQwponScJqiIBojjr0PExa5Lz?=
 =?us-ascii?Q?EzT/sutn86xBhz44R5NxmZUa0VXzcLAyyBMhIfyxD+DKISHOOe3r6MEtKOIL?=
 =?us-ascii?Q?we0nFfahTeMYLKpj0HdpldoytNU/xotxEiv+vPfus0fZ7SdfDUcl/+P4d5RM?=
 =?us-ascii?Q?mVP5r9fvH1qMM3NTh4jSTmKQfZwOWlnJHxcl7BfY74G3SGbGODjUvqL/opYU?=
 =?us-ascii?Q?YlzLYkO4vzi0+jQC7y5upw4v/a0HZzl0clH5ljZ6RLPKqrnTMYXbjY0mt/tc?=
 =?us-ascii?Q?mMhWseqvMRTtwYWCUmJyxfd+4u/2hW0QHFYSrAKX9xqq4rphQYFvhRXNit0/?=
 =?us-ascii?Q?IA5Lw5t65VxoU5N7Lwg0EY41Mh4gl7IMvTnc+6bhS6XIM0zjsgIbmPXRWji7?=
 =?us-ascii?Q?OcA/9r4BehxeSwsVWBKyk1x7XtTYUZmoxm6M+WRIobKuIhEYP4WxkAVD8mdn?=
 =?us-ascii?Q?D4BGmoQ6dLNhqpmAuDFxaGjELwEuAgFI/Zm4F16tq7uXKRXqED0LUrGx3oPv?=
 =?us-ascii?Q?0IHjhXAwR1gM+C8+4kCxdE2ehXgJZ0WlQFLH98cf+c1kckBWMm0XF9jJwWri?=
 =?us-ascii?Q?Ba/4E39BYCD84BltjZQy2xZyxYDsvlU2KkLRSc3yvQAZZi2FNOyYoYabO1ag?=
 =?us-ascii?Q?y4NOkljRKQnju0eGinFcgSqLWZIQFO4geenx5yhP1zBWbieWlCw9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237a1f7e-3cf4-461b-d55e-08dec7faa4d3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 20:47:25.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ljzym62vfXqDVm18irSrRhKtuyKUcGQg69mQxBGLZfahT2TiwSuNf0gPXGfr6EHOxm55h+3XZaF3MpCn1XljjRsjZeYCGQsgNm8Zat5q1XXTswoiDRVCkCvW/lz8PBc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6796

On Wed, Jun 10, 2026 at 03:32:52PM +0530, Aksh Garg wrote:
> This patch series introduces the framework for supporting the Data
> Object Exchange (DOE) feature for PCIe endpoint devices. Please refer
> to the documentation added in patch 4 for details on the feature and
> implementation architecture.
>
> The implementation provides a common framework for all PCIe endpoint
> controllers, not specific to any particular SoC vendor.
>

General question, does DOE generate irq when received msg for HOST? I have
not related irq handle code.

Any program to test it? such as pci_endpoint_test, need at least one real
user to use it.

Frank

> The changes since v1 are documented in the respective patch descriptions.
>
> v4: https://lore.kernel.org/all/20260522052434.802034-1-a-garg7@ti.com/
> v3: https://lore.kernel.org/all/20260427051725.223704-1-a-garg7@ti.com/
> v2: https://lore.kernel.org/all/20260401073022.215805-1-a-garg7@ti.com/
> v1 (RFC): https://lore.kernel.org/all/20260213123603.420941-1-a-garg7@ti.com/
>
> Below is a code demonstration showing the integration of DOE-EP APIs with
> EPC drivers.
>
> Note: The provided code is just to show how an EPC driver is expected to
>       utilize the pci_ep_doe_process_request() and pci_ep_doe_abort() APIs,
>       and might not cover all the corner cases. The below implementation
>       also expects the EPC hardware to have some memory buffer to store the
>       data from(for) write_mailbox(read_mailbox) DOE capability registers.
>
> ============================================================================
>
> /* ========== DOE Completion Callback (invoked by DOE-EP core) ========== */
>
> static void doe_completion_cb(struct pci_epc *epc, u8 func_no, u16 cap_offset,
> 			       int status, u16 vendor, u8 type,
> 			       void *response_pl, size_t response_pl_sz)
> {
> 	struct epc_driver *drv = epc_get_drvdata(epc);
> 	u32 *response = (u32 *)response_pl;
> 	u32 header1, header2;
> 	int payload_dw, i;
>
> 	if (readl(drv->base + PF_DOE_CTRL_REG(func_no, cap_offset)) & DOE_CTRL_ABORT) {
> 		/* Aborted: do not send response */
> 		goto free;
> 	}
>
> 	if (status < 0) {
> 		/* Error: set ERROR bit in DOE Status register */
> 		writel(1 << DOE_STATUS_ERROR,
> 		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
> 		goto free;
> 	}
>
> 	/* Success: write DOE headers first, then response to the read memory */
>
> 	/* Header 1: Vendor ID (bits 15:0) | Type (bits 23:16) */
> 	header1 = (type << 16) | vendor;
> 	writel(header1, drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));
>
> 	/* Header 2: Length in DW (including 2 DW of headers + payload) */
> 	payload_dw = DIV_ROUND_UP(response_pl_sz, sizeof(u32));
> 	header2 = 2 + payload_dw;  /* 2 header DWs + payload */
> 	writel(header2, drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));
>
> 	/* Set READY bit to signal response ready */
> 	writel(1 << DOE_STATUS_READY,
> 	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>
> 	/* Write response payload DWORDs to Read memory */
> 	for (i = 0; i < payload_dw; i++)
> 		writel(response[i],
> 		       drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));
>
> 	/* Wait for the memory to empty before clearing the READY bit */
> 	while (!RD_MEMORY_EMPTY()) {/* wait */}
>
> 	writel(0 << DOE_STATUS_READY,
> 	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>
> free:
> 	/* unset BUSY bit */
> 	writel(0 << DOE_STATUS_BUSY,
> 	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>
> 	kfree(response_pl);
> }
>
> /* ========== DOE Interrupt Handler (triggered on GO bit from root complex) ========== */
>
> static irqreturn_t doe_interrupt_handler(int irq, void *priv)
> {
> 	struct epc_driver *drv = priv;
> 	u16 cap_offset = extract_cap_offset_from_irq(irq);
> 	u8 func_no = extract_func_from_irq(irq);
> 	u32 header1, header2, length_dw, *request;
> 	u16 vendor;
> 	u8 type;
> 	int i, ret;
>
> 	/* Read first header DWORD: Vendor ID (bits 15:0) | Type (bits 23:16) */
> 	header1 = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
> 	vendor = header1 & 0xFFFF;
> 	type = (header1 >> 16) & 0xFF;
>
> 	/* Read second header DWORD: Length in DW (includes 2 DW of headers) */
> 	header2 = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
> 	length_dw = header2 & 0x3FFFF;  /* Bits 17:0 */
>
> 	if (!length_dw)
> 		length_dw = PCI_DOE_MAX_LENGTH;
>
> 	length_dw -= 2;  /* Subtract 2 DW of headers to get payload length */
> 	/* Allocate buffer for complete request (headers + payload) */
> 	request = kzalloc(length_dw * sizeof(u32), GFP_ATOMIC);
> 	if (!request) {
> 		writel(1 << DOE_STATUS_ERROR,
> 		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
> 		return IRQ_HANDLED;
> 	}
>
> 	/* Read remaining payload DWORDs from Write memory */
> 	for (i = 0; i < length_dw; i++) {
> 		while (WR_MEMORY_EMPTY()) { /* wait */ }
> 		request[i] = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
> 	}
>
> 	mutex_lock(&lock);
> 	/* Check the ABORT bit, if set then return */
> 	if (readl(drv->base + PF_DOE_CTRL_REG(func_no, cap_offset)) & DOE_CTRL_ABORT) {
> 		kfree(request);
> 		mutex_unlock(&lock);
> 		return IRQ_HANDLED;
> 	}
>
> 	/* Set BUSY bit */
> 	writel(1 << DOE_STATUS_BUSY,
> 	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
> 	mutex_unlock(&lock);
>
> 	/* Hand off to DOE-EP core for asynchronous processing */
> 	ret = pci_ep_doe_process_request(drv->epc, func_no, cap_offset,
> 					 vendor, type, (void *)request,
> 					 length_dw * sizeof(u32),
> 					 doe_completion_cb);
> 	if (ret) {
> 		writel(1 << DOE_STATUS_ERROR,
> 		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
> 		kfree(request);
> 	}
>
> 	return IRQ_HANDLED;
> }
>
> /* ========== Abort Handler (triggered on ABORT bit from root complex) ========== */
>
> static irqreturn_t doe_abort_handler(int irq, void *priv)
> {
> 	struct epc_driver *drv = priv;
> 	u16 cap_offset = extract_cap_offset_from_irq(irq);
> 	u8 func_no = extract_func_from_irq(irq);
>
> 	mutex_lock(&lock);
>
> 	/* call abort API only if BUSY bit set (pci_ep_doe_process_request() called) */
> 	if (readl(drv->base + PF_DOE_STATUS_REG(func_no, cap_offset)) & DOE_STATUS_BUSY)
> 		pci_ep_doe_abort(drv->epc, func_no, cap_offset);
>
> 	mutex_unlock(&lock);
>
> 	/* Discard Write memory contents */
> 	writel(DOE_WR_MEMORY_CTRL_DISCARD,
> 	       drv->base + PF_DOE_WR_MEMORY_CTRL_REG(func_no, cap_offset));
>
> 	/* Clear status bits */
> 	writel((0 << DOE_STATUS_ERROR) | (0 << DOE_STATUS_READY),
> 	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
>
> 	return IRQ_HANDLED;
> }
>
> ====================================================================================
>
> Aksh Garg (4):
>   PCI/DOE: Move common definitions to the header file
>   PCI: endpoint: Add DOE mailbox support for endpoint functions
>   PCI: endpoint: Add support for DOE initialization and setup in EPC
>     core
>   Documentation: PCI: Add documentation for DOE endpoint support
>
>  Documentation/PCI/endpoint/index.rst          |   1 +
>  .../PCI/endpoint/pci-endpoint-doe.rst         | 333 ++++++++++
>  drivers/pci/doe.c                             |  11 -
>  drivers/pci/endpoint/Kconfig                  |  14 +
>  drivers/pci/endpoint/Makefile                 |   1 +
>  drivers/pci/endpoint/pci-ep-doe.c             | 594 ++++++++++++++++++
>  drivers/pci/endpoint/pci-epc-core.c           | 104 +++
>  drivers/pci/pci.h                             |  48 ++
>  include/linux/pci-doe.h                       |   8 +
>  include/linux/pci-epc.h                       |   9 +
>  10 files changed, 1112 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-doe.rst
>  create mode 100644 drivers/pci/endpoint/pci-ep-doe.c
>
> --
> 2.34.1
>
