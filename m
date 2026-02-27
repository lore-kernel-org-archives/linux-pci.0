Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39701332ECB;
	Fri, 27 Feb 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207492; cv=fail; b=Riwczl0W79iYYU/PtU7CqjSiZbcZge/3cGkBwj935HQHeEQ+CNaUaJY0VE/292x5Kwq/JwDFRi0DNaK6vFo5HEv1qKv4kHgXOq6iEiH9ILbJqzlgoVGDLH7g4MSd3+t5DibHezg+aYuxSUC+C3u+uGeRArwbj8Lj9/mAWo0ORgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207492; c=relaxed/simple;
	bh=SKFL08h1A4uxEugURd2ryEh7MOUwXC5WRS/nf+9EkS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B9xhmRPm08/pvwH+taWcCnJzzrygaeWfLIqhccCHC0Z89kHbHn5wFI82joMPYCsfyq4XXpks+JBGbFG1Jlhe1jODMvCIHfK0CDEB+rIA6qQJKqGMdX+RIoQ5XxqeRzpaZV73lmlYO3eJIqgkdBiyofqmh9UwPZFEygORGuBUUKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zh0Mtd4C; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zh0Mtd4C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvRNSUZDrwK14Q4NpVX2lFQ140c/LMJhBPJLt4X3eLZmfeM9Qp3OL4gbKOBXIrhxvK7+G+3tOxKt1vm+yGFHnmlspSYBd3AFcongVj2UfvFqCJEiIIbALbDAdbYHsF37FZMSqQMhm2cgtZuQyIdSxlQotK0UlMe/2w2MNNulk54l+LpHfPXd+m8+scwjNsxtK6XMzcI9aHhLt+eaLRcayrgGBucsSwockEEI1ek763j/ZdGQsa9dk0yI/weBf2F6MIMLM6Oc2ard+/2r6i+ezm1gMUrsv1PDjbD4ETgoEkJZkNOnT/Rbgs5LyXgFtK3pR6P7b0ZzzVZBd+drOQmKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAqr5yH5wlPvGRo1hBiI3KrV4qzUtYEbV5wt1ISKzYc=;
 b=VH+N/AxOFPrPx0EkYHkHw2b06QjDngz6Gd/CeaAi+1TCx0i1/MHtLWd7CnQkE4g7jeMykPfbAzkvTZBUnjj6tJfuu2Hl+DX4GrelATz1LCLjuTOKIdqNP7rv3h5PVNsHQEtBdGheLc0JbAGIWbDYsQWLt87wrHejEAuxttuegyoxDOwuO6hLWXB+ylJnL134LW02OUh0QN9qqMjihtFvV8XAWTzxwEDMHVycVH20GMZwoa5iYyR3p322IofGpSo0/nJJQfD0CbZqBvztTgk3WklswfjJwrQZhnzP7opjDXOaEEeeulQKG2Tb6ezBk67nTB9B+uy+ofjPBSuVoSnmGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAqr5yH5wlPvGRo1hBiI3KrV4qzUtYEbV5wt1ISKzYc=;
 b=Zh0Mtd4Cq3Cc7xxobqDnJSYB6rkw4NRv4h3DNKkXulbXNBub1yGWYS6jBbbtIBke8Drk/lUepwYZZVZHVrF47joNou/e6rgySEK5m65jCextV/lpILpzlWLm0qeFXWh9THpZfitUwK+O+Di3Oq6VhFNQlFDnrFTXjV4I4vB481a1o7nUeWTTIcJjcK6WG0m8R8syuY3VzDyHyZy1eYppdsi3JMgwEa2wviFh7whV5WsS4+0klsmmsoF9KAMJkh6/+seFG1U2fGry0dN8bPB0SSjJGDaQIxthfC5T2rt59oArymD/9KgZ0pkJHQGPHbvS7OZWbXuM8w1TQXBCBxdtxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by VE1PR04MB7214.eurprd04.prod.outlook.com (2603:10a6:800:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 15:51:27 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 15:51:26 +0000
Date: Fri, 27 Feb 2026 10:51:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, kishon@kernel.org, jdmason@kudzu.us,
	mani@kernel.org, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] NTB: epf: Make db_valid_mask cover only real
 doorbell bits
Message-ID: <aaG9dphK19l23tPG@lizhi-Precision-Tower-5810>
References: <20260227084955.3184017-1-den@valinux.co.jp>
 <20260227084955.3184017-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227084955.3184017-8-den@valinux.co.jp>
X-ClientProxiedBy: PH8P221CA0064.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::16) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|VE1PR04MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c02c48-7964-4a01-7284-08de7618105a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	6QUTVUUcDUtSCwfM/6rCNnPJlWRFYTo7NIeo8TQkIpvCH6Hdso++9GZfkMiaGnxIOyJZh1bVWSj1+vpvrsGBNo3JX4gQu/YKbygciGT7yObLzzW0MpzdQ4RLHWvOyxK3Hyfq9VSKzJaD6hFcVsW9LVujSWorzRvptZe828vZc711iUS3gSzFc8GoMGZuUa6pNHsIQyP97d8Rpz0wS8XwmOK2A3ULobHQzm5a1wNQ3lp4mgKyaRxf3hBKH+Hs4vwlPUZ95U4FRjLoxAMPWeeCpbMqwL8353bAzP1TU1LmR8KRsggj2UbmpmJr6AXUjXJPhXqfCzYvGda9wSq1IJANwDlnbQGzh/jn1yAT3iBL5mvAnnG3r9EIKXrcDatPcoDEBxCA78QVD7dkwYGcxsq81mZ1D25mAHgOA4fqCTweVi6lQ982xIxcueVxiRVfeqx6e4C+gVTtx4EZ99UEZ11GZdsbbbVoz+NPvcqacaBSBB+KB2BXL/YvNPlLw+KEF4ila/qEgi1ZT5vvaTNFLwX8gJjYwDVYqdHFVVnNL2rNfvUJB+RHcBqOWDPkZ8mfiuo0KgYhQXQk88pRR3kHSDUOBgOlN5GUqT5Ul9Dgn/ChHSHxoDAh/Vv7lj7iBQ2rJXrLUBa2V7/nwWWoR/mtnu3hLTDszAiKo3qU01+q4ouOMByr8oiywdC94aANMZOiwbC/V2io7HlPvYXK9Wqc6tFyTxAOeTOa9f6MA5+Xl2EfN3rVhHZnYRnHZO9xycyfpjw9upeJfBo2F91AbLkSr5v7RUz4pwev4MyZm9QnssmN2xg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ri/ltPeAG4+ZPHt93jkFFU7eKBsWEoSa3mB7QFuWog68IKBcUzLYc2ShWsXw?=
 =?us-ascii?Q?awL39YJGZ7bpFqRtWfNoXEjGx/M9SNsajy4B6rn196wiXA0nX1/NznnzJriW?=
 =?us-ascii?Q?vJ6C9/bs32OI1PjT19Q3Q9hR0DyMDr9Q6BT0cepr1POmmBxfsf6/vf7Ao43A?=
 =?us-ascii?Q?HqHDaMxhgUzx0nK0TPx6sNQ5oDgSBaOuQBkqTn4PZPwul+RBWJ+Pejnn665s?=
 =?us-ascii?Q?ENecPWoDM9WcvdNsNCBPG68tnzsfM0GUgsOJWjh7EFFYoAv2JYql1kCA67Pn?=
 =?us-ascii?Q?IhJslVApS2BeqBt4MmGsS5RmBrODkO5RMRFWjomTmDhItlBzqcjSrWvh6T/S?=
 =?us-ascii?Q?VFn1kAomLOdF6YsJk0W7WUTxZc98cdtBtIpbHHojACE7o7jddGfLJXY9WOMo?=
 =?us-ascii?Q?SE2ZKEVocoalSk2uWmeg+0ba+sZckt6j1b1qeEgLX/qw/qZBsHWY5/V2cRxt?=
 =?us-ascii?Q?5c3KWge/O47wcX2EPXyIto2s6Qe3s5muS+sFVB3/v5bplDhVdsIA2ROaIES8?=
 =?us-ascii?Q?b8oPCLM0i+cDPCuMRElBAvcyGCWuRKaSEKG0AfcKiBmRrqar1GnYfT41mHmC?=
 =?us-ascii?Q?oT2f2RbmsdYIqWoVLFXYFtS0lWQy8dgEYgl9VH0oJnI/aqqORC9q6adyxDsG?=
 =?us-ascii?Q?W7YNmI4sWAu77mFM0oMNmexO3g3CxOgy9kOdk6Xvtsne/ZhpHB3BfsCBO5iI?=
 =?us-ascii?Q?oLMfbD3vb+U1i14e4MXByNmy2bPtXEhqct7aaz9rAL3MdwMDmO3qYXQd3A/b?=
 =?us-ascii?Q?dXHTffEM7t1Mo8vgECDIOvsPvkw3sZswf7xx3CcpQAC9Q6vSephYjI0dZ5QV?=
 =?us-ascii?Q?WbHwNBavD8gdIR2LpQls12RyCx4hvw+MzG55UwqzRJnu34yh/ZfhkJ1L44BV?=
 =?us-ascii?Q?+QkUYWcDcxl0s2BtyH48mcICuG8w5kLTOg5KLZe5jywSBpue79kcfKQmVJPr?=
 =?us-ascii?Q?iq/sGIXDG1by73gj5NaW4Tc/PO73rsYWYnoZPvL2EjpmHPxAf/O0ze+x9L1P?=
 =?us-ascii?Q?LJu3DvWKjOwJMkzgDite7JAMFL7VFZ5dJxjWlN1lrOmGubJnst+fAZeYisN5?=
 =?us-ascii?Q?8yVkhRNM5E/BHJ8UHqW5nG2JllA4RWbN+5Ej95dh8uVqV88Kh1aXxgmZur2u?=
 =?us-ascii?Q?3okAMTPIH35Wz764BRRbr3/C81cw3pVN4jpw0Ihmz8gFaI1XB+s+obLpGz6o?=
 =?us-ascii?Q?eVZatnaUr8V//tC/I/OtYrboGasmLm0cupVKN2YfvzVNuFp5pLkmGg/TPx3L?=
 =?us-ascii?Q?r+H5oq9XnL3CzUEFqL33RD4wJBvZxLggJ6RDvWli8vklsgmoZU5TrxalxLo8?=
 =?us-ascii?Q?If8nfhuR0Zu3DicMlFt6U60d2GLjarLzitH3jEIALZjYsAdh330xFVuRIlaw?=
 =?us-ascii?Q?bfXDz4B647kA26aABfxcPEadtiJKLHRUhAeb8Ia/KJeS8+vH0CwYu5D9ECtH?=
 =?us-ascii?Q?MT8juA3r3QdxLyJKDHb7ZJ1dt0uToDWkV+IAmvKr/TfcvpDHh2fpmSTUfFYC?=
 =?us-ascii?Q?kOdVcrM+2AkjTq0cB6lGhzOQgqMmkSk523AvocHdDaKb0Ac4DiT20VRTDgNZ?=
 =?us-ascii?Q?5iLSp7/9SPlpE7OZjN0+Gyp97uLR1SasmpXMMpwxXq6lC0nKz3XoRlREqi2Q?=
 =?us-ascii?Q?/pTlRSNkfm5GtmWprWPgtbDZRzGRZ5cAeeJy3wiJJ8Md/mR+nn/ma5t4U275?=
 =?us-ascii?Q?Jc5Bk+iVAj/2DNEZfsSYW7wmoQuRCDPumvSocKGmBfyrLslU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c02c48-7964-4a01-7284-08de7618105a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:51:26.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZEPcNtSYGuJmfhGn92dfRWuGAvYIfKlGWc8xs8swmn2tsQupL6snbiCc7W8dQnjNQFeBEsQw0CVnFYtJ+L0iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7214

On Fri, Feb 27, 2026 at 05:49:52PM +0900, Koichiro Den wrote:
> ndev->db_count includes an unused doorbell slot due to the legacy extra
> offset in the peer doorbell path. db_valid_mask must cover only the real
> doorbell bits and exclude the unused slot.
>
> Set db_valid_mask to BIT_ULL(db_count - 1) - 1.
>
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Changes since v1:
>   - No functional changes.
>   - Addressed review comments (documentation).
>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index bce7130fec39..07dc97d3270b 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -580,7 +580,17 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  		return ret;
>  	}
>
> -	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
> +	if (ndev->db_count < NTB_EPF_MIN_DB_COUNT) {
> +		dev_err(dev, "db_count %u is less than %u\n", ndev->db_count,
> +			NTB_EPF_MIN_DB_COUNT);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * ndev->db_count includes an extra skipped slot due to the legacy
> +	 * doorbell layout, hence -1.
> +	 */
> +	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
>  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
>
> --
> 2.51.0
>
