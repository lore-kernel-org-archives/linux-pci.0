Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF18311C2F;
	Mon, 16 Feb 2026 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258090; cv=fail; b=MswRk+OB2z4kONl8leV7jIojMKnqpPw8atiBoXRcm4k5uNeWfFf5gZnylmIqee4QrdGTCcjhdtJG7btisjlqOxMV/akEDc39J/YHqToZQrm5rZzUl72Eljaxd0haRS2j4eDmSOdjq2tFWKOOAiaF+msRrSERr86m2oEWsbohAH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258090; c=relaxed/simple;
	bh=3hc0+dqMPTpWGdu3jFZZTP+8wQPgvfG5/CVm1lCY19M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jjvtCsMXHV+t3zale5Uz7pTGJSR/hYwDJ3NbIh+cKKQJjP6aFK2jWlwyxp8HoSM6ph+GqebSnu+KLWdykZJajEN1q449GABW3F7OnEJmV3Hdh9Bzyb3zESKH9c+Pn+XpaCANo4rKQtTP5dAryh6ZltE2uItwWxBAPKi8JWh0LrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TKvPuL3o; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TKvPuL3o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPgX7A40VrrIbxfkJsWzhOWmL1vcRlDcG7eVbCmPtyqP0frmkAZUDBJHXA9ce+g3aymbm24mtDkRNs5pE5wGZmlf6RnIn8mkD7QACqTXI5FEEbV3zeNWlXm1c56UWidtvJlYKhfNgePg9Y+Pzb3a2x2VUfUOlgA5/uq4sUftTlsMZSF6J/O3tY6V3TdW7GB3pBmU5g4K3cMIJ2UAC15ZyCGfkF2gRvIIgC1Mo8IEowg+majsblskgyXy/JmF/Z04Rn02E8W2Y//btyGw7ud7POA1LX8821RhM50Phu/2+iMd+NQ/ydPQeRvZX0qWb6RBZjZG8ZtLo7v8J62jgh18xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZFiChjplxvcs3Bt4zEi4CwUWbr2DrW+B4wA6eCSQJk=;
 b=RJAStptSBb7CbHlwFQ5Gsl+2WuiAbdRV3FLZP5Gd/y9EXMePap7FLLh4bOxpYXNTmmwzeqSwxHIQI2AAoYb3fGqYTCxWRL3asxsRo4QARZwn6mp2m7wUUo374ypNEFtG8xFUYIupJWtJ+jQHct0mxqjY0vc7VpDSGJVc5TS+FTYtaTvlf6Zq+78+PV4fjSQGBjXe7ov8Gz3/7JhV6ZVWOsvwP12ADwpOv/G0JkE3NX2LnX7HdgaP+gnaifyi2AgeQWeL5K7P6hSInTZ4plKvNFgLbUoEBLyJw/ZoMi3eivYfm+TE1D/9ZMxN3OlBDbIjzglIcAP1+b64+V9nHqPPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZFiChjplxvcs3Bt4zEi4CwUWbr2DrW+B4wA6eCSQJk=;
 b=TKvPuL3odiBvkj234RSbv0LiJwZvRNnTsxkjbz3HFSkZrsnNxg5r5rKPmpoA4v1J9iCIEahz5gTo/Qt8cU3+m1Ul8AN3MEWNvS/6rrHrF3ML7YoVSGqjVehzfT4X/JnAifKRbNYof+DkIGlLMl3X7BJznG8StFsdM5gdrfZ7oB4+t+cZ5EckHyoOK3rNuzdXUxZM4W+3e1uD8v2gD91hh1vrZbt5NpTtHmhAKTf67f3o2UyT21rc+8CxH8Smqf8Ae2HezVGn44k/2M2Er2mkkgL4WCL/ma1SB79VG0zYtDahsLNcBPA+ZXYXfBolHpZC5ELPMeKU9DXiZnOthOrxjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PR3PR04MB7210.eurprd04.prod.outlook.com (2603:10a6:102:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 16:08:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 16:08:06 +0000
Date: Mon, 16 Feb 2026 11:07:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org,
	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 6/9] PCI: endpoint: pci-ep-msi: Refactor doorbell
 allocation for new backends
Message-ID: <aZNA3lQCne2laAW6@lizhi-Precision-Tower-5810>
References: <20260215163847.3522572-1-den@valinux.co.jp>
 <20260215163847.3522572-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215163847.3522572-7-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PR3PR04MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 4213a344-a666-47e5-f211-08de6d75925c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|52116014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4AKhXawu/R4J7nsZK08j2b+n8sHYC+Mulrm0WiRiCmLI8NlENmUxXNSzvNo3?=
 =?us-ascii?Q?IctydNcWLY63H817RImb5qb/EP0R36xMVdjrJb9lrcdkf4E6SF1yKyJ/jsOa?=
 =?us-ascii?Q?FUHaoFM3cPAuO+u1U/oT3XCvzq5tNedwUhA1/P0Yk6n2FfJf06VyppbGSHLW?=
 =?us-ascii?Q?eCHkphEyYNBqQM+XIoqAEpQNIR5n+Uik9B3S8sNJwWRpZTFrcoy3ZGSg9vCA?=
 =?us-ascii?Q?PuQbQl6CiiW9MiN41LVtTGH7dAQ8UVSIVks88hIaLoX12/2e6rCZ5YUG8skW?=
 =?us-ascii?Q?3+xV/HP3h5nSbDyTlwWpXw/j/Dovjvsez1XeHKjeQhZwJ2cflzm+V5h0hq5a?=
 =?us-ascii?Q?bFkz5thD7DlY4Qfms1JZRR6ND65LruVXqobh1r9EwfWHmbgTXxMCPH/YW+h2?=
 =?us-ascii?Q?57TLDYP9IgdG+G1JSJa0eFDMU9/VXCo+phsxG5bfo3143YA2BKpLghz387mq?=
 =?us-ascii?Q?ZNnqmZAl7m/VeulH4WYFxVevCA7Bigpr7s/X9ENtBuYd8Pq7CJkzsMhZcwKz?=
 =?us-ascii?Q?2+9YvII+EpSAz48fXleFkb9fRoonvBB6LCCIkwF2GaEtFvuE/oBxmQ7yzqWZ?=
 =?us-ascii?Q?t0GhmTDeqmixdgks34n+6D9QSWeTio5xVVLbgVTrgXYS4kBI5TmVWlOqtjrW?=
 =?us-ascii?Q?yecOT8OGlxk5ehibi+InwDLo+x701b1xR/cDiE9aDJAzT05TbLpSpiOACTB3?=
 =?us-ascii?Q?C5EMvIzq6JjNhfTodkolSYRRgScW76qanjeFPXJjUhU9VyLAHps+GVTE4lmf?=
 =?us-ascii?Q?lW18oHk14CzAQTZdcJTOghKsObMwATqGPqXwkdnnDPeDKYvE8Oweb1XRhS3p?=
 =?us-ascii?Q?mDAD02K9BvGXHrf8GGmVU3pTltEaZbIVwbp2D+9PQx1qtWTdxjWZSeU7blec?=
 =?us-ascii?Q?8bwdbwlTXdGopsjnSgSSZc1AwUPi4O4Eq2LhfcOIbdDrtp68zf3R+Os6w8Vk?=
 =?us-ascii?Q?6NY1rHrzMJVI3KpTq0nYtYz5C8IqRO2z8IL3FTDZKPR0OEYAvUr2HgtXKHK1?=
 =?us-ascii?Q?3dx+P0s5/BQUIpQ4vNSL+WkRSB4pktt3AAMN5rRurMbKDil/HOrmN1VahO/b?=
 =?us-ascii?Q?KoangkjDd1NsViejPg5wJ6GKlqNQcP6l+MWxIF1LTm2o+08+j3jMJIGqL3zQ?=
 =?us-ascii?Q?G9xAkWdu3ZirWheJ8kBFyY9w0BVBs7rJ9UQzw7x2nPDwUTMcakowhnU9jk+l?=
 =?us-ascii?Q?OyZa2lqtM9z2LGTsk0pv9grZxvpKFGZ5i6TOAsWUirrVzmHpOxLBVvEND1xf?=
 =?us-ascii?Q?gBpOUpO/eyZUoRRpCz4QLlkyMiWrIg/Y4CeAxej3iwyCLvfxNHo+4VtvzYId?=
 =?us-ascii?Q?kWGRgalQ3rOqWyX0f3S1F9J5ADTWu0GwHl/yJo0nsSQQSJbHlAdDYCsPnhb2?=
 =?us-ascii?Q?FEEh0xYR4FvK8fT/Q7qtjEA0OFSzYYhXDqM2AGQxXI88LM3Jm5Y2QVpzxf4G?=
 =?us-ascii?Q?9RvPgCNmEbqzQYJMpAAM9lMOWGHAniRQqKFP/83qKIYh3rOcW04Zv35OD4xN?=
 =?us-ascii?Q?8tontIU+mMToxAnjJtunmkjR4xUhmIKaYeyJ1x/BH6DMEHbX+NiRCPccoZnD?=
 =?us-ascii?Q?BmhWg3y8mn801hwYs76tHExq06/kbkJnUuD20wE9Jvzu9B10viyCC/4uhcuD?=
 =?us-ascii?Q?6TacSqFSDyzRFZS9iKos4os=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(52116014)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bhL3g/n1HQcGgwb75UjPIebxKeBrASMH/VzwBdg0XsNQkhx9MgTc3AYN4c0O?=
 =?us-ascii?Q?zyVDhUq76Pa+cT4Ra+8P39Cotog3bbtmomBsK/+fCPIIg9eGrLXkrdWw7xUI?=
 =?us-ascii?Q?ZLn8nEzm7RyP0gv2QGB1w6wI+qnRAcVjSfwGYJRn3/Zau5pOivW+qqs7T4Jt?=
 =?us-ascii?Q?JDmfpk9awfgspjcch95XxvAXIPs8rtrOHSS5m+j9wGs7DRR2LZ/Idst1umlS?=
 =?us-ascii?Q?m7jvRoJDWhQpR08D+7k39ut9ubdoA8vhCUanuHXX+vOiejj0OryHW3AwKXPt?=
 =?us-ascii?Q?S20y/LbfdLw58XsuhhEHpTmBYmKmxFmcVGBlQt3FjW1l61AdmfuAgYZZmsyL?=
 =?us-ascii?Q?Axk8u1vB8s0o2LGZuoahr6B//MT/vXY/SyQdtLN4RSciI5m/geYJo04bHoJC?=
 =?us-ascii?Q?gHo5oMhHOBA6SBrExvTxhKbaKAiSntM9i60bit3bM2xjVULU3YaSecF5E6oG?=
 =?us-ascii?Q?Fg68bTtQtzTpotIDJydBJS5o0/ez1qmTNO3Brggjwyx/uPc4JLNe7AXE7yhy?=
 =?us-ascii?Q?A2LhtJQ77TbrooDePkQLIMCna5YnuD09ErBEdQT4ShFvqGMBb0FEHVlj6vbm?=
 =?us-ascii?Q?UpEanD7uZDX8IiU+wN/+DPUGmPk71trBGTUnmn+pcaxkSRKTAhp48HgoE868?=
 =?us-ascii?Q?QxEEm/Xg0eLoLSR+2GO+GDDlBBIRcvCfWjvvyIByww0U/9d5vUXqTl/ZczM4?=
 =?us-ascii?Q?UjZ1QBHEnB6HYPsp0JXAn3Mhasz6nV9Q/uE7wW31V3yB/ucyMAEIb/kdm1t/?=
 =?us-ascii?Q?pWI8gZ/VFWnRrCt8DqgfVLwNB7VmEojZe3Ii8sL7+frilew68HJT1zfd2Ane?=
 =?us-ascii?Q?sxTQkRiafNJRNQWJSOJ+5IB+jKeDGuMCE3PNvx1Boay9m+eHYeKsdOw1+UOD?=
 =?us-ascii?Q?CnpB3S3OK8fRLPIFrvRh8GbhTkt1XfH1ByG5c09nsXCvkAOLRsNmpQXkgGAF?=
 =?us-ascii?Q?UqdWvM5KVECjsSEaNmXWLa0LeK4bO+Ye3FnNV8AgRI6x+oFjCK0cJKxUeddQ?=
 =?us-ascii?Q?8zTDAUNJUS43wgV58KFYBo59Id4eIDetl8O/cteyQqH2wF8sFPKN2wIwbYBX?=
 =?us-ascii?Q?hE37mbOyvBI3GFqzXTDDdnzKs6sTqn64BLmxlzno0gB9yNBUxautJ8r1vjVR?=
 =?us-ascii?Q?+QDBE0PHm4OVf+yT5MBTdnzvqaBefI/1jwXEcJdYyx3KYcuZpkG0eogLdbL3?=
 =?us-ascii?Q?lQ32605XBSWuvlmACfWQQUckDXdpTdXOT3KglnGzX1rJivlsPNHwLEIl5Ynl?=
 =?us-ascii?Q?EKqwszqvIf1wS5Q3tpYhYVFm5a64LP11ZEknDlFmHKPpWiNIvAix1af3XAxd?=
 =?us-ascii?Q?qcqrWxBc6cggTj3As72eA384rdyms3VuRismmYXodwJ7AF8htjv8a0/wNNq+?=
 =?us-ascii?Q?8weBzPIcEEUzyr6/YRXza/IkJKX4254UN2V1aylEREDEkxyokDA5srW6ANFU?=
 =?us-ascii?Q?wFrIDO/W5ADq5CpYVgkb8UlxQvJf7KBa615S8lrbaEVNUjbZqNkq175XoI+d?=
 =?us-ascii?Q?PP66qyabzUOKQKYVUTWSIP6oStG3CWBN4DH2zBpKw2chGVtcczTEl3ISFPNZ?=
 =?us-ascii?Q?NWNMGJmvlBwYBNdu7/1Th1+htp4kFIh5UcZj1ochzsHkU1v+PTQKSj4nmA2v?=
 =?us-ascii?Q?FUxIU4nVvCn0+YqvEFvIhgZ0NGXQMhGh1gjG8SqmEeL4SeADO2rAxluFT2yH?=
 =?us-ascii?Q?gQU6geFycN6RxGZj33+jCsF0fBcDPu2StShcybQ+85gwW7zW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4213a344-a666-47e5-f211-08de6d75925c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 16:08:06.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKPZbjPOVso2cX+awedz0VtXQRm2XhRk8Hmi/lSyvgS59DxR4MBZywVr5pV5ZgYVLEIg2ImqIGP7YvoRf/c4og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7210

On Mon, Feb 16, 2026 at 01:38:44AM +0900, Koichiro Den wrote:
> Prepare pci-ep-msi for non-MSI doorbell backends.
>
> Factor MSI doorbell allocation into a helper and extend struct
> pci_epf_doorbell_msg with:
>
>   - irq_flags: required IRQ request flags (e.g. IRQF_SHARED for some
>     backends)
>   - type: doorbell backend type
>   - bar/offset: pre-exposed doorbell target location, if any
>
> Initialize these fields for the existing MSI-backed doorbell
> implementation.
>
> Also add PCI_EPF_DOORBELL_EMBEDDED type, which is to be implemented in a
> follow-up patch.
>
> No functional changes.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/pci-ep-msi.c | 55 ++++++++++++++++++++++---------
>  include/linux/pci-epf.h           | 23 +++++++++++--
>  2 files changed, 61 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index ad8a81d6ad77..a42f69ad24ad 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/interrupt.h>
>  #include <linux/irqdomain.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> @@ -35,23 +36,13 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	pci_epc_put(epc);
>  }
>
> -int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> +static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
>  {
> -	struct pci_epc *epc = epf->epc;
> +	struct pci_epf_doorbell_msg *msg;
>  	struct device *dev = &epf->dev;
> +	struct pci_epc *epc = epf->epc;
>  	struct irq_domain *domain;
> -	void *msg;
> -	int ret;
> -	int i;
> -
> -	/* TODO: Multi-EPF support */
> -	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
> -		dev_err(dev, "MSI doorbell doesn't support multiple EPF\n");
> -		return -EINVAL;
> -	}
> -
> -	if (epf->db_msg)
> -		return -EBUSY;
> +	int ret, i;
>
>  	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
>  					      DOMAIN_BUS_PLATFORM_MSI);
> @@ -74,6 +65,13 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  	if (!msg)
>  		return -ENOMEM;
>
> +	for (i = 0; i < num_db; i++) {
> +		msg[i].irq_flags = 0;
> +		msg[i].type = PCI_EPF_DOORBELL_MSI;
> +		msg[i].bar = NO_BAR;
> +		msg[i].offset = 0;
> +	}

user previous patch method to reduce write 0.

	msg[i] = struct pci_epf_doorbell_msg { .type = PCI_EPF_DOORBELL_MSI; .bar = NO_BAR};

Frank
> +
>  	epf->num_db = num_db;
>  	epf->db_msg = msg;
>
> @@ -90,13 +88,40 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  	for (i = 0; i < num_db; i++)
>  		epf->db_msg[i].virq = msi_get_virq(epc->dev.parent, i);
>
> +	return 0;
> +}
> +
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> +{
> +	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	int ret;
> +
> +	/* TODO: Multi-EPF support */
> +	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
> +		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
> +		return -EINVAL;
> +	}
> +
> +	if (epf->db_msg)
> +		return -EBUSY;
> +
> +	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
> +	if (!ret)
> +		return 0;
> +
> +	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
>
>  void pci_epf_free_doorbell(struct pci_epf *epf)
>  {
> -	platform_device_msi_free_irqs_all(epf->epc->dev.parent);
> +	if (!epf->db_msg)
> +		return;
> +
> +	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
> +		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
>
>  	kfree(epf->db_msg);
>  	epf->db_msg = NULL;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 7737a7c03260..cd747447a1ea 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -152,14 +152,33 @@ struct pci_epf_bar {
>  	struct pci_epf_bar_submap	*submap;
>  };
>
> +enum pci_epf_doorbell_type {
> +	PCI_EPF_DOORBELL_MSI = 0,
> +	PCI_EPF_DOORBELL_EMBEDDED,
> +};
> +
>  /**
>   * struct pci_epf_doorbell_msg - represents doorbell message
> - * @msg: MSI message
> - * @virq: IRQ number of this doorbell MSI message
> + * @msg: Doorbell address/data pair to be mapped into BAR space.
> + *       For MSI-backed doorbells this is the MSI message, while for
> + *       "embedded" doorbells this represents an MMIO write that asserts
> + *       an interrupt on the EP side.
> + * @virq: IRQ number of this doorbell message
> + * @irq_flags: Required flags for request_irq()/request_threaded_irq().
> + *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
> + * @type: Doorbell type.
> + * @bar: BAR number where the doorbell target is already exposed to the RC
> + *       (NO_BAR if not)
> + * @offset: offset within @bar for the doorbell target (valid iff
> + *          @bar != NO_BAR)
>   */
>  struct pci_epf_doorbell_msg {
>  	struct msi_msg msg;
>  	int virq;
> +	unsigned long irq_flags;
> +	enum pci_epf_doorbell_type type;
> +	enum pci_barno bar;
> +	resource_size_t offset;
>  };
>
>  /**
> --
> 2.51.0
>
