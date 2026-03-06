Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607FFB640;
	Fri,  6 Mar 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819173; cv=fail; b=dPwN2jdPxgz9eWtNantUcKs3Af9JEhPg62Zvyw4l75zd8pzkGxiPvT/UBe8DWaHvAo+mcO823UvJynVijXRNUIgVqheQE0WbY7VKS/cBXst6l1Nxn4Vj1pX818WPnqgJ4tWJkmBeg1+ji+iBoILfxLBflb3COHZQVQ5BL8Eraho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819173; c=relaxed/simple;
	bh=dXL2qqPQzU9AMAd9ErrlmXHp42YkxFhgLAb8wEz/5XA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3HkbIL8BClkoWFQGXE/P3bS7Z5vWCHiOSYHuC+U/+42iwUrh7mbhiqE+PRoslpjY8LTN8mHJKvJuy4GnJMhjNs5UZAg+ShmqGmx/MlfWU2GbwJO/C1wNVhw30wP+hPEWJI6enAGv+aUiqWpS5Y92BA4xG3OCcHTBHSqfCfko5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ehcrx3dP; arc=fail smtp.client-ip=52.101.57.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ehcrx3dP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uo0s02jPidvMG/SslZIeveNqs8QlZZz7X16I8s4EF5d6c9abAzNgEdINv8fgHnIENdWgLUERUISjK31vm56K/Xz4SdnTMDqs9h3cZpqts8Ozb+s1UC7yx+XR1Xpr01ZbHeqiP1em77bhuZXExyZ5XSan5YEhbK7MBGyV5IWU+K23e9kRoNd4dpZDydwUm2JDVlwwAAKPQpCbjM5QnvIgzXcOIsmbqUgapxgPkULxBqg4XCXP8bhIB1bDUgQxFf/ME4zDlDQw87d7bcLt/+RY25ypVl8oxfuLcxtk3k3Zt1YlBMEh4/td11TpxZeDQvnwG7rOkQpqmWbvq2caQBiXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQBMHGYEjxfTIY1OSwigygVOtdSf+JK0XO33WgGh4JY=;
 b=f5tet6ngLMSG/MkaJn5fDJwUObSqhm6wT+QPW8wrMgRthMIYZV2ojxaK07mvCIbartzNUux9stTqhzJO9rZkCsim3B85hzqKN7XIPceM+n/dQlz1Ev10VkcUUTMpRxcm+rYZt8PeIOp0ESL1xQACmxJBIo7ZwUKBsLwBu7V6QZB96w4EeykAu+2x5O0k2krOje9uFX3aB/9iLqyJwgVXTuM5C047qkQ5SMxmJL8e4eS0+maNzIxL5hlYshQdT4OfukWt7lm7AEsxZtNwbLgbBPprlOrm841uO5mJQ1Wr61MPlx8x/5yh6vDqgYWnhD+OGGa93aRC3E0PZSNzYUxx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQBMHGYEjxfTIY1OSwigygVOtdSf+JK0XO33WgGh4JY=;
 b=Ehcrx3dPbhOii+/SUlIVbyGhEJURnlHfU5SZrlmkqSQZjl2saDzuqHSddFgIa771tg/TCFzq3pDTVpu9N3CHsU7/yYMT+Z/nahIoc9TiUnptSVkrwKwF2NC5/i5IgsxxzqAZcrQQYD7bav8+/dwlsNSU+jyWRXjhFdqzPT00EaGu2tbd3EDeRFww4Hep6lSMEVuPMK2NEArpPP9HB8VfFIfeTIQ7e/GOVJjs/p3kCnkmyFBJE2vtLleCMNNUfaBD8I9XzwucyRSA9mMMyYPRiC27VlFc8M1xTu2FTDY2Qi8ri/7NqGOsgypEWXVXHjOmT0cJmkmDjSFJnrHaVZhDfw==
Received: from CH0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:610:77::21)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 17:46:05 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::82) by CH0PR04CA0046.outlook.office365.com
 (2603:10b6:610:77::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 17:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:46:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 09:45:45 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 09:45:42 -0800
Date: Fri, 6 Mar 2026 10:45:11 -0700
From: Alex Williamson <alwilliamson@nvidia.com>
To: <smadhavan@nvidia.com>
CC: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] PCI: Add cxl DVSEC state save/restore across resets
Message-ID: <20260306104511.1ee758f4@nvidia.com>
In-Reply-To: <20260306080026.116789-5-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
	<20260306080026.116789-5-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 903949b3-6ed6-4375-1e50-08de7ba83d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	OtUXhQFYDw8Eq2ZrVJpzHeEWhd4HTa9tcHk2OBM3MRgZnTo1+RpComi697DcrjHDvhjUbWOekXKdGnmNIbydKp9X1J4VP4CYcbCyD985cdYjB7uPJ4+q/znl8eYjU4PFlVszbXG+rY8WQciTDujDvkCSWaEukA/RlkD2hgCCzULE0LnYqeC9NbrNhfhsUo0sWgDKIdQ6d4x0xBM/Sqb2hWwFKikJZgIgFfJtRhOSdsahkUsrJXWwjSuk7I0VdxgwSZ6mGyaSg1F5bcz1Gb7wZ6T9qLg/bWREuM9Mye9gEfNohvbrJCdOabz0rIx7CQXRxwOa4d6C7/tYgB68PLc/Agjlde6S1uokbkoJx128aXOSkknRWoPE+3/Uu1w3zgXgTCSy+DC+OG5goTL7wxgVg7dktAXAIeuL+QD2nsJuZQF+dJyn4iAf9Lv40UPmEqy08LJtQECZteQWJSvUjbSAsYkBCBGKZwxoxLjx5UGkzMa0ZJqUc9H2orHoZlxbnIj31aQrG2C1/TuHsO8W7xJ9VAEdnyXc4xR/BjDdbDfF0DHfC3xLj4ZYCuxQY6zooHU8kzz8EuzMcyBhnnHsMcGZoe3b1Emc7T/I/USAdHDNaKy1HmyxBGzWtTOT1JZTRX87QDFfur/t2v+0zq25HtdFkC4/UhFT44eap+y6UiIpCefRtnfHLK9eZnAFC4o6LLHMFKhzShgVFXkmvl7sah8ebZ+lvdHZ0zinjG6S5WOhttxFyrUQOP10SBPmdakuPmFsihtYjdql/RE1SsmfzXM6rA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eWCBP1QNcsVzEOCZA3245lhMvIB2NmwKa61a+ZbsA4ow4/9sjJ8oSGqTnalQORl2Q5to94TVLlxbog9TKVKBuIskd9VUPdC6JhWObz+UqZqwHhguw63Ji0xpiD2PGwRHL95HVFlCJa3mJupniHAjSSLnLqvhAnw0a3O9H16lTCfu6bPDrWYS24WZc+H7loGktmyiJSPPJQ5Klai03FX1bmjdoOaf3sYbF7mOfxm1ED/MQEu8AjUzy1gTzoLr5J01F86fBBWqcke1k3BuE52Uavyjdm43TpqMuFcET6BBagl5OuJF3vATIxoqja+AuGNnr6Zlw4ytoE5aQzcepLoX6l5VNPz41kPThs9SQ+yEyi86PngSg0MJi0E4YOIdYiO/X4inEJkCkQs5G/V5JsmxRGzM0V54fl/0vymxF+qKoOqbj/zGhaH+oRX40HM4FyIE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:46:04.9924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903949b3-6ed6-4375-1e50-08de7ba83d9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992

On Fri, 6 Mar 2026 08:00:18 +0000
<smadhavan@nvidia.com> wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Save and restore CXL DVSEC control registers (CTRL, CTRL2), range
> base registers, and lock state across PCI resets.
> 
> When the DVSEC CONFIG_LOCK bit is set, certain DVSEC fields
> become read-only and hardware may have updated them. Blindly
> restoring saved values would be silently ignored or conflict
> with hardware state. Instead, a read-merge-write approach is
> used: current hardware values are read for the RWL
> (read-write-when-locked) fields and merged with saved state,
> so only writable bits are restored while locked bits retain
> their hardware values.
> 
> Hooked into pci_save_state()/pci_restore_state() so all PCI reset
> paths automatically preserve CXL DVSEC configuration.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/pci/Kconfig  |   4 +
>  drivers/pci/Makefile |   1 +
>  drivers/pci/cxl.c    | 177 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c    |   3 +
>  4 files changed, 185 insertions(+)
>  create mode 100644 drivers/pci/cxl.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index e3f848ffb52a..6b96650b3f31 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -119,6 +119,10 @@ config XEN_PCIDEV_FRONTEND
>  	  The PCI device frontend driver allows the kernel to import arbitrary
>  	  PCI devices from a PCI backend to support PCI driver domains.
> 
> +config PCI_CXL
> +	bool
> +	default y if CXL_BUS
> +
>  config PCI_ATS
>  	bool
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 41ebc3b9a518..a6168ecef9c1 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_PCI_TSM)		+= tsm.o
>  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>  obj-$(CONFIG_PCI_NPEM)		+= npem.o
>  obj-$(CONFIG_PCIE_TPH)		+= tph.o
> +obj-$(CONFIG_PCI_CXL)		+= cxl.o
>  obj-$(CONFIG_CARDBUS)		+= setup-cardbus.o
> 
>  # Endpoint library must be initialized before its users
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> new file mode 100644
> index 000000000000..abcf70de9171
> --- /dev/null
> +++ b/drivers/pci/cxl.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CXL PCI state save/restore support.
> + *
> + * Saves and restores CXL DVSEC registers across PCI resets and link
> + * disable/enable transitions. Hooked into pci_save_state() /
> + * pci_restore_state() via the PCI capability save chain.
> + */
> +#include <linux/pci.h>
> +#include <cxl/pci.h>
> +#include "pci.h"
> +
> +struct cxl_pci_state {
> +	u16 dvsec;
> +	u16 dvsec_ctrl;
> +	u16 dvsec_ctrl2;
> +	u32 range_base_hi[CXL_DVSEC_RANGE_MAX];
> +	u32 range_base_lo[CXL_DVSEC_RANGE_MAX];
> +	u16 dvsec_lock;
> +	bool dvsec_valid;
> +};
> +
> +static void cxl_save_dvsec(struct pci_dev *pdev, struct cxl_pci_state *state)
> +{
> +	int rc_ctrl, rc_ctrl2;
> +	u16 dvsec;
> +	int i;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return;
> +
> +	state->dvsec = dvsec;
> +	rc_ctrl = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
> +				       &state->dvsec_ctrl);
> +	rc_ctrl2 = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +					&state->dvsec_ctrl2);
> +	if (rc_ctrl || rc_ctrl2) {
> +		pci_warn(pdev,
> +			 "CXL: DVSEC read failed (ctrl rc=%d, ctrl2 rc=%d)\n",
> +			 rc_ctrl, rc_ctrl2);
> +		return;
> +	}
> +
> +	for (i = 0; i < CXL_DVSEC_RANGE_MAX; i++) {
> +		pci_read_config_dword(pdev,
> +			dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i),
> +			&state->range_base_hi[i]);
> +		pci_read_config_dword(pdev,
> +			dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(i),
> +			&state->range_base_lo[i]);
> +	}

Shouldn't we also be handling the array of RANGE_SIZE registers here?
NB. the low bits indicating active/valid need special handling.  Thanks,

Alex

> +
> +	pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_LOCK,
> +			     &state->dvsec_lock);
> +
> +	state->dvsec_valid = true;
> +}
> +
> +static u32 cxl_merge_rwl(u32 saved, u32 current_hw, u32 rwl_mask)
> +{
> +	return (current_hw & rwl_mask) | (saved & ~rwl_mask);
> +}
> +
> +static void cxl_restore_dvsec(struct pci_dev *pdev,
> +			      const struct cxl_pci_state *state)
> +{
> +	u16 lock_reg = 0;
> +	int i;
> +
> +	if (!state->dvsec_valid)
> +		return;
> +
> +	pci_read_config_word(pdev, state->dvsec + PCI_DVSEC_CXL_LOCK,
> +			     &lock_reg);
> +
> +	if (lock_reg & PCI_DVSEC_CXL_LOCK_CONFIG) {
> +		u16 hw_ctrl;
> +		u32 hw_range_hi, hw_range_lo;
> +
> +		pci_read_config_word(pdev,
> +				     state->dvsec + PCI_DVSEC_CXL_CTRL,
> +				     &hw_ctrl);
> +		pci_write_config_word(pdev,
> +			state->dvsec + PCI_DVSEC_CXL_CTRL,
> +			cxl_merge_rwl(state->dvsec_ctrl, hw_ctrl,
> +				      PCI_DVSEC_CXL_CTRL_RWL));
> +
> +		pci_write_config_word(pdev,
> +			state->dvsec + PCI_DVSEC_CXL_CTRL2,
> +			state->dvsec_ctrl2);
> +
> +		for (i = 0; i < CXL_DVSEC_RANGE_MAX; i++) {
> +			pci_read_config_dword(pdev,
> +				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i),
> +				&hw_range_hi);
> +			pci_write_config_dword(pdev,
> +				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i),
> +				cxl_merge_rwl(state->range_base_hi[i],
> +					      hw_range_hi,
> +					      PCI_DVSEC_CXL_RANGE_BASE_HI_RWL));
> +
> +			pci_read_config_dword(pdev,
> +				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(i),
> +				&hw_range_lo);
> +			pci_write_config_dword(pdev,
> +				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(i),
> +				cxl_merge_rwl(state->range_base_lo[i],
> +					      hw_range_lo,
> +					      PCI_DVSEC_CXL_RANGE_BASE_LO_RWL));
> +		}
> +	} else {
> +		pci_write_config_word(pdev,
> +				      state->dvsec + PCI_DVSEC_CXL_CTRL,
> +				      state->dvsec_ctrl);
> +		pci_write_config_word(pdev,
> +				      state->dvsec + PCI_DVSEC_CXL_CTRL2,
> +				      state->dvsec_ctrl2);
> +		for (i = 0; i < CXL_DVSEC_RANGE_MAX; i++) {
> +			pci_write_config_dword(pdev,
> +				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i),
> +				state->range_base_hi[i]);
> +			pci_write_config_dword(pdev,
> +				state->dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(i),
> +				state->range_base_lo[i]);
> +		}
> +
> +		pci_write_config_word(pdev,
> +			state->dvsec + PCI_DVSEC_CXL_LOCK,
> +			state->dvsec_lock);
> +	}
> +}
> +
> +void pci_allocate_cxl_save_buffer(struct pci_dev *dev)
> +{
> +	if (!pcie_is_cxl(dev))
> +		return;
> +
> +	if (pci_add_virtual_ext_cap_save_buffer(dev,
> +			PCI_EXT_CAP_ID_CXL_DVSEC_VIRTUAL,
> +			sizeof(struct cxl_pci_state)))
> +		pci_err(dev, "unable to allocate CXL save buffer\n");
> +}
> +
> +void pci_save_cxl_state(struct pci_dev *pdev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	struct cxl_pci_state *state;
> +
> +	save_state = pci_find_saved_ext_cap(pdev,
> +					    PCI_EXT_CAP_ID_CXL_DVSEC_VIRTUAL);
> +	if (!save_state)
> +		return;
> +
> +	state = (struct cxl_pci_state *)save_state->cap.data;
> +	state->dvsec_valid = false;
> +
> +	cxl_save_dvsec(pdev, state);
> +}
> +
> +void pci_restore_cxl_state(struct pci_dev *pdev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	struct cxl_pci_state *state;
> +
> +	save_state = pci_find_saved_ext_cap(pdev,
> +					    PCI_EXT_CAP_ID_CXL_DVSEC_VIRTUAL);
> +	if (!save_state)
> +		return;
> +
> +	state = (struct cxl_pci_state *)save_state->cap.data;
> +	if (!state->dvsec_valid)
> +		return;
> +
> +	cxl_restore_dvsec(pdev, state);
> +}
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index dc8181f13864..497720c64d6d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1759,6 +1759,7 @@ int pci_save_state(struct pci_dev *dev)
>  	pci_save_aer_state(dev);
>  	pci_save_ptm_state(dev);
>  	pci_save_tph_state(dev);
> +	pci_save_cxl_state(dev);
>  	return pci_save_vc_state(dev);
>  }
>  EXPORT_SYMBOL(pci_save_state);
> @@ -1841,6 +1842,7 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_restore_aer_state(dev);
> 
>  	pci_restore_config_space(dev);
> +	pci_restore_cxl_state(dev);
> 
>  	pci_restore_pcix_state(dev);
>  	pci_restore_msi_state(dev);
> @@ -3489,6 +3491,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>  		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
> 
>  	pci_allocate_vc_save_buffers(dev);
> +	pci_allocate_cxl_save_buffer(dev);
>  }
> 
>  void pci_free_cap_save_buffers(struct pci_dev *dev)
> --
> 2.43.0
> 

