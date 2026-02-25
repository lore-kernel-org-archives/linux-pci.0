Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013037.outbound.protection.outlook.com [52.101.83.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE024DCF6;
	Wed, 25 Feb 2026 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051655; cv=fail; b=uJ/F9eJzHs5Wb/qLa4tgya7l2UdstXQrK+OsnqlClcEM4/lAjgfIThp54Hk01MVX/G+jp5ntCwUcQ2a+ahAiXbaiqYxQNKsLnKoEdNvpX8+K2QtZ1s0FUzW+oqTyNFOp3BZ2c4YB9PH+IRE/2iSy0jet/UtTd2+SFvqZ2I9Wrys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051655; c=relaxed/simple;
	bh=w4zT4cbTcid5HkavAgCB4LpD9lXNCk2yoGGbTqFXOoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PY8bdGmtr8U0T+HWc+YDz8MWQ1aSM4dmCjZo9j2H6wRf+iRhqRxztIUgUcD3JV1Ok4wBwOj+naq8L58h/cj/lUXZAcu9NcTDwopa22yT8mY8mOcGuu1qeaJkEmxRKD1AnLAR+c2IpXjSJoO7uxsDnF1Fxyw78Pub8LzttikMFo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gJ0xOmLk; arc=fail smtp.client-ip=52.101.83.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gJ0xOmLk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBqkBBUUV0GTGHxbjw6TFmKoFMqydPcoBc5yzdR5nY6T7tQ2jtDSBaRIom+DopwPXjziJy3La8x2/7rr0mSr2gj3o9YfBZ3+gFSeQXZa5rkNNpnQs4FVBTQb55lNd0pbspsri6/DRESZUhvgfuvh8UBkcMkZbPL7qbG+wcX7yAQ1SAaQ1x+MgsqnLuN1q9FmyvWaGXLEQU8MeS9ah1zhldP413qKlanXIjhDiRl9s0dvMok/QJxKc1qAnk7x5Kby0CqdgnMvHTS+WDU7M1kmhP8w0tSfbv0qC6P1zDsb0SAnNqrt/sb3px5f41qhfApce7KCop8Wsi0FWnLzj4OCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX1tvwBv2WChSg+EO+hfqZZrxvyy9ikn6nGFdBj8ilI=;
 b=bmdnM4xpNJ0mpyvn41NQYNhjrFBG7QRYHqWCnkIELZ6m1PBfzsf1OATzNtJiRQhnH0m3tq08q7/Ch5H9UP2i7p4qmStdeg9QAwuwCM4ljil33ZIiq/mBy84cTOpYPfbRTvi8l2iLsh35DzEdfD6IrCTBESYE2lTQy4h4ppadpM4emiVpeJOEY9BLY16lEU7nMzuaI5+g0eCNJxHqCBa0ulBGwSC5DqTgP3pbFYW71ejK0vo1IeeKpJkTBaoH/rG7SH4tZFS5Qyv8uQmGW+ynRQpSkeQ7fRJALrzz5nsLMGNnzr1ETq5ssYvzF1UgYxDgzY+ApAA7xq5jo4fWFXmKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bX1tvwBv2WChSg+EO+hfqZZrxvyy9ikn6nGFdBj8ilI=;
 b=gJ0xOmLkDn9l8h1iX4shHPKzckUc1Nk4LZdvlR3AzldEpMn7fVZGmvd0PGQvyYq/PDrQrBL6iCLd4/iFzEULlub2F3GkQsWZrq5oHO2AkzGILnhjbDJBaRuPJrk6pZ+m/Su3amIUEESvlqOVp3S5fsb5acIEiHvpZsO8kBvTNnswVOiwLXB4WBVLf+WQWyjRhe4ohXdjS7wQgJvGoyQvDD1CAhJZBIwmmBwMCdoxMrZ/yAb2p8DfOMuiey8s8VWstiHsp20tX0AIHLbOzHuxk0xS255CrIP//09F+kw6fSShiwDU1G7Beg06MLlZT/NAPerNUia/7sJWpG21slAD0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6817.eurprd04.prod.outlook.com (2603:10a6:208:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 25 Feb
 2026 20:34:10 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:34:10 +0000
Date: Wed, 25 Feb 2026 15:34:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org,
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] PCI: endpoint: pci-epf-vntb: Document legacy MSI
 doorbell offset
Message-ID: <aZ9cu91A80Yt-cgY@lizhi-Precision-Tower-5810>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133459.1741537-2-den@valinux.co.jp>
X-ClientProxiedBy: PH8P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 6449c919-5ac1-43a2-546e-08de74ad3b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	WSO+c2uzibB9J0zf5L34/f6V0e+tWIqT/Spg2n3Vw3TWaeT3SF5BJHxH0XnGZVepcSFz1FS6q9GZ/JbrG8I56ud37DrBgfj2ZE6jDuX5V5BxIg/WzDT20t73s7bgZYFYiVo4uQ9sp/NaxFzE7TvU4tJRqEUZucUSBhgLjr/A4UMqqn08HK1k3j5i2HTXRuiIr4OFZ8xQYaFA5I0tZfyg2q4+KFpcb+2QjNa8l1MBUBqH0qFgybUG0te7Gd8L5Bfg8Inf65QNfyseK2CcASx8z11kcDk2miyvFkrZdphnO8ZvTTdPiRpC4Pxi/N3J8pUkgasq1SQYh9L9bCPQxvbPtdktFGOr4JxZhultmMR/ftmV3jvU/c8iXiZFVa3SWPaaIotoFbI8W5dD+jNx4vtSfYDO1p8oBPVfwKK/SPqE6sJGMinJEOZFYP1o/oefFdy16zY1oZuC3dFgA5OyDR4VZqJWmeGnTPWDh5yGbKLq/2d3HRbyipy5jjyvYgYbhW8P3s6wVxu6a1/VdX0rK8n16BoX4osBPO7v1M6BNZSKTsZQkmAEMZ1vBTlF90hOeoWc8dCURplMhs9ohKnbRr0NbqKIEIA68sp1d1BIttRgytdaJ7askYa7DfG7+7IS17FhImDOMcGa4tnKKCD07gSM3YbDv9gxP6t4yYHWTLN55xVS8pahlbg0FDvWXxvPOWSs2JE7tlmkUmvqugyLeF2KsCPXQvuSsxsPQTtuTpexkCEyaO/wA94uglTmB/jTRI4qDRy+Xv63zWHZENNvKj/vJvHl10WsT0dzMJN+O5sV4Dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MbRI1CIRo9nI3qhZMvIkUuaoryopyUYXnTYcfBSnORSwYaAzbEyDhWdzZ+qd?=
 =?us-ascii?Q?km2X65htl3xr6+ErdtCT/+oYiLjneHZgr4PCNhQNqYAuL22oZJLZ+4hQJlEP?=
 =?us-ascii?Q?mVtymW2J/CXSBJT1vV6ziHfsUTU16b6t5ZIpJVXrUl1ggVwsHhMwdOxpn5d9?=
 =?us-ascii?Q?tOB2mDVnwzyKDjugE1gNzGILtsiTTG1ujrJ8nL070804ecAXltYEH5OjT/qO?=
 =?us-ascii?Q?nV44nn4zsoF3F7AbCDuIfzfoCq0y9ZTAUBkUo5FWJhwGRK8oHmSBYyLtr7FD?=
 =?us-ascii?Q?prUsClJMWG/MMOPSszzT6YaaJOXWU1VRgcEXJANI32+xb78wGoXlyINccxV3?=
 =?us-ascii?Q?UZ6Tu45L/vhyfQfkmLR5CZirhPyvx5UoPGyYxEEYUmhmn3vfu2MrQfN6tWij?=
 =?us-ascii?Q?/SeLfLFOK35CwgsmpDLArRM0dGlghcKsdsW2BonIArmKirDduGvkBkchKPu5?=
 =?us-ascii?Q?GNAiIL81k11cIlMbfJ/Hqa2ZJEmnLN+71eDcOTb/56qOE/f66jdI62Mp6yri?=
 =?us-ascii?Q?DOb26xFHwgrmYVDVHt3minyqPve/b4WvZZuJTlAlebtJCUmHlb/KStqQ7ubl?=
 =?us-ascii?Q?d+ds7Y9XRAaLmWZ4t8TMln3MKDPGpUJGrmBt4WPFpyVTD6vV3TK6odbi3R/k?=
 =?us-ascii?Q?aZN6akWJwYqQIvjZJLXS01M+Ay3dYVQbRv2cy5yBCJ3vEYiVbGh5QVNzcq+Z?=
 =?us-ascii?Q?NKAc8lHXmS6lFJwBXjeOU3oF/jlZE/EBvAAubLZrSBDgo4N7xoNffmG2yQ5+?=
 =?us-ascii?Q?DZW84Jg2WcVLuSDd+TxRUBWRsddVti+D8JX8DxqYs7BYldprMU4fNjLB81hh?=
 =?us-ascii?Q?meunSyNSP2PAJ+Na4FXIos8ROI0PvGlb2+rgbssPQFCTqpNQvx/n7NRtY3Vk?=
 =?us-ascii?Q?5wTQTrLIz8MZWhmr6zq3RbZIb2SB9y9fLGn0IWG9kuAA42dO211DMX+yOpAz?=
 =?us-ascii?Q?8kWkdeeJX/xKm97FlaucvTjyJMJMSAM2/rTusudAc+tPIFQcmsIU3hGbhaUv?=
 =?us-ascii?Q?PaZe6vr1bEob35UXJCL3vqXLA7sTe8AnX51276VKXz3mgKp/xh9YNPGD5R0c?=
 =?us-ascii?Q?n0Ju1NygOwYwuUJ29x4elxRGLDzpunBrhaGcx2MzYey3GMTGXIbfRtH9umH6?=
 =?us-ascii?Q?bNumZrgaEVD2YjMGTO5JFYXmKddMwFMsX2sJqYuyOob5COAqkSmL6FFWvJ6Z?=
 =?us-ascii?Q?Yc5ZnO0zFJ+ZUOkgxfsTZuaDuhI0HtSCKts7Eb59y566ExXgC0QpL7Wtb9Sf?=
 =?us-ascii?Q?Gp42cbDHHIXj/28Qm1UTzVfi7U0p9g6sS2QiZDDO3tzwWXPkjKKPx36m44jl?=
 =?us-ascii?Q?F8nVX7eXh7MdXApIIJoP7yFc06vtTwEI8wcdNQzMOn6lLfkzjZs1KIW5x/M1?=
 =?us-ascii?Q?Jh8VnuNl1eBqu4e8/0gdMYaZ5jvesjG92QvpQP7VkJWGIOeM7NawmTZEl95P?=
 =?us-ascii?Q?QrsY+8CFa3g+p3YQqtswKJxCSqEyVb15yGoMGR8W9oR+wzoQ7FdZujQUFtM8?=
 =?us-ascii?Q?JSHm30JzqPzHhCQuORsoTp62v5GAnex9tt3XCozcBTK7za7lZreLn+sIbm11?=
 =?us-ascii?Q?WX+GTvXARUXMayBNufUwOxOThXmhRkbJfOyj685fJ+2uYOr8f3MuWsUHtcL5?=
 =?us-ascii?Q?lB9rB7WsLVeJ/hDmcHY4LAbNm5C8ljlhF3VSAcwmnHjm1LXF1c8X4MvmZxOH?=
 =?us-ascii?Q?J3yUgYV9Y7UkVtJEqRiw3iVvstJsmJ5yC0KcXeZ3q3mO7lmnsLHFv4ydQEHh?=
 =?us-ascii?Q?NX4XqVLd5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6449c919-5ac1-43a2-546e-08de74ad3b21
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:34:10.4798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpU+pJAtvSmmsBOqDQ5DGZhvtfz8tH97AhlEVCVpyROH3weQXYonj+eUH0SSWeMQZy+IWqxxGiPHPwlyMU6SIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6817

On Tue, Feb 24, 2026 at 10:34:50PM +0900, Koichiro Den wrote:
> vntb_epf_peer_db_set() raises an MSI interrupt to notify the RC side of
> a doorbell event. pci_epc_raise_irq(..., PCI_IRQ_MSI, interrupt_num)
> takes a 1-based MSI interrupt number.
>
> The ntb_hw_epf driver reserves MSI #1 for link events, so doorbells
> would naturally start at MSI #2 (doorbell bit 0 -> MSI #2). However,
> pci-epf-vntb has historically applied an extra offset and maps doorbell
> bit 0 to MSI #3. This matches the legacy behavior of ntb_hw_epf and has
> been preserved since commit e35f56bb0330 ("PCI: endpoint: Support NTB
> transfer between RC and EP").
>
> This offset has not surfaced as a functional issue because:
> - ntb_hw_epf typically allocates enough MSI vectors, so the off-by-one
>   still hits a valid MSI vector, and
> - ntb_hw_epf does not implement .db_vector_count()/.db_vector_mask(), so
>   client drivers such as ntb_transport effectively ignore the vector
>   number and schedule all QPs.
>
> Correcting the MSI number would break interoperability with peers
> running older kernels.
>
> Document the legacy offset to avoid confusion when enabling
> per-db-vector handling.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Thanks,
Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 20a400e83439..4328f05acfe6 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1375,6 +1375,25 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
>  	func_no = ntb->epf->func_no;
>  	vfunc_no = ntb->epf->vfunc_no;
>
> +	/*
> +	 * pci_epc_raise_irq() for MSI expects a 1-based interrupt number.
> +	 * ffs() returns a 1-based index (bit 0 -> 1). interrupt_num has already
> +	 * been computed as ffs(db_bits) + 1 above. Adding one more +1 when
> +	 * calling pci_epc_raise_irq() therefore results in:
> +	 *
> +	 *   doorbell bit 0 -> MSI #3
> +	 *
> +	 * Legacy mapping (kept for compatibility):
> +	 *
> +	 *   MSI #1 : link event (reserved)
> +	 *   MSI #2 : unused (historical offset)
> +	 *   MSI #3 : doorbell bit 0 (DB#0)
> +	 *   MSI #4 : doorbell bit 1 (DB#1)
> +	 *   ...
> +	 *
> +	 * Do not change this mapping to avoid breaking interoperability with
> +	 * older peers.
> +	 */
>  	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
>  				PCI_IRQ_MSI, interrupt_num + 1);
>  	if (ret)
> --
> 2.51.0
>
