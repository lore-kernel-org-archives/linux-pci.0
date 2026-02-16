Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32DE1F17E8;
	Mon, 16 Feb 2026 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258514; cv=fail; b=uOfCBrnkNZhfA7ugUBKLhFC3aCoE2Hv55/1A2kbZt6Pn7smCW8lu/kW0XsAWcPH/fSY9kGwBofP2fm0oEvEzYisyqUeEMUCXxQnnvBtixVkrJkfYte5BWw/FWL7jKuhIw6BWcBPcDudc5Z8BQICKcBaEgHuXAg4un/A9jl4KheI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258514; c=relaxed/simple;
	bh=CUWnOtyYYbhMbsR1YMhXoxQ1lwl7223rRMkjHqcZZXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aFqBN2Ly+KRnBKy58CbL5GoTz/3wHYcfkaHHtOQnnVscggDLzUgxGy26SxrBZJwMPd3PMhN3cyMDTB1g43ap1stapRZHCqU97nCi+qg8MH4PYpEZzTbHZNMWF8g3poTuDdt/ZWOsY9aL6aUE+B9eurwp1+xZfSsaCnccm4S/jAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fads3mC3; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fads3mC3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSfo0rKFMtr06vY04rIkiqmAwTE2OH9sEJdu/Xeb+WQTXq4Kt1zeyxYeoCdcscx4IfUJpVY7KOZzLixbzr0ctGC21lqsQ1S4RXXCAjUjUbMpEkEbHMSuuswqNdGM0zxjkd+91Ac4ugS1RCVBI4frj9eYJGBaqbT5vIH09GhdnzM2MgbnP5F6vULEyqTPCuiZxBPm0y+qEFLiRMEMfI/jjfwBkGE9rcFcnt6vbBLiPBHML+MQBUYmcLNhQHEEEkpMyvun7BZYjxMUaAvmgCKGYyTXmQ8PXx2v1ZhdZdcN1pHWhQ/JeT/bKe1rZcTIKURODwhd7ix8d6PY7xwHt0vfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2HVPm41NyCcpegpfP2Mu4wQ+A9OLqb50AiL6B999BI=;
 b=khQw03rDlMArWqfDqsNS5vpbwQbjFQFY6Hw63aDUSk0MROMJe5lWSZUjScF9VdycGKG01xBYjUoJPREXWpGAN7AkAT4CWT7jpjE2lTLxyml0IBa/8mvCA1m6kEUJQtyY9cz34rFmh7DUX85zqtKO0sehvh4uYQXopAM0X17mdwHxeNWo4hxfeX41dKyexNZJrl8IbJDXm0O2zGAXp9ESQro4sN2poC6PXvOMy0akN4Z1Sq/vhOSVkzDJN9Z5l1jykgwjKbMeg7YObOSaUiKecfJS9tyiJsS2rflEfjVsPQSiea/l4lB33SVPdxON21qUCSeKDEqlr3AJQkuJiIRcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2HVPm41NyCcpegpfP2Mu4wQ+A9OLqb50AiL6B999BI=;
 b=fads3mC3DhmgpY2SLl8OM/NiLG3F87wdyLI85GuDHiXgSBt8QCCTEhDe6QXfG8SmdJJ72I42nZQHv1cfXiBe4MHEjlvnyqC3wOH4SHyW2f3WFev0vVWeJnfn2Of+lOef7+vwgyS/RHk5sYFqz30HcgNX3uO6XnFeafInyFfYPH5lBBQmaKy6/Jxae/NlshdFKjRTRmGqofYfiVn8czJ/mX+Vvh5Zu96Q60bOVP/lu51RG62lXz5ka3Hn32uyxQ68zKXcHcUEKz5MObQR7gHakODjIRrRJqo0RwnRHWZFpFtuIe2ktZwRiT1TcwXvm5ITfJ54tXdS+dXe0mTT5UgdYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB11486.eurprd04.prod.outlook.com (2603:10a6:150:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 16:15:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 16:15:07 +0000
Date: Mon, 16 Feb 2026 11:14:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org,
	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 7/9] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed
 doorbells and IRQ flags
Message-ID: <aZNCgkddVkDbtO_c@lizhi-Precision-Tower-5810>
References: <20260215163847.3522572-1-den@valinux.co.jp>
 <20260215163847.3522572-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215163847.3522572-8-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0078.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::34) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB11486:EE_
X-MS-Office365-Filtering-Correlation-Id: 83be963b-6a10-46d5-c366-08de6d768cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Y4vouE6g5BT5ZO8yxkBTSpUT74bKuKUEL6NqZRjZLFSdo5nqDhth67o7K/R?=
 =?us-ascii?Q?/oXvtJoweM85nMfMMren3k/daVNUcnDH8TqPtFzmooStNDnhmRR+n4VGBjnY?=
 =?us-ascii?Q?v6J/Mnq4md7y6hPPyj809SfE5AA5BO8F3c+RiSc1GgxAvD7MrJhCjiJae60/?=
 =?us-ascii?Q?vOaKtSOaBE8m5g58pphTzBLBFYH07kEqiXME5wWDPlKH7Azdy/Q36Kjlmg4S?=
 =?us-ascii?Q?Ium8vugsxGmjlQ03J0z+kauRfiKhVgUc1J52m4DHMAEN76tBzL4shmcpd63U?=
 =?us-ascii?Q?AkEkOgiLHYChSD1X1jmlPqFDF/O8TTkXSeikP3E8YxnFDsXQ4hBdAWopaJFQ?=
 =?us-ascii?Q?E6blS43Ndrkg8LUuc6vwG1H1o452cVQribhHChBLVqpzlWWUq5N7C0phiRSQ?=
 =?us-ascii?Q?JV9H+UWYw8uBxnTiQjCzj8xABtacLMeOw6+wgK2q7W1i9KseRWkYTMEMlgmy?=
 =?us-ascii?Q?RVsByJVZrWS86C21kCEe3Il1bd3T9TU425Fc5E1B73ZhxPRBj2G552K8dN9v?=
 =?us-ascii?Q?9bdQ91VT6zok7cZOhY8i7Rc61VRYQLfo3uulqmdX6FdyYFEyWUxz4ZozgOIz?=
 =?us-ascii?Q?uT0S/UzXJJsvusinA6V0aNGFSpq027uJh7bCnOvTRF70AwDcX8c8punJUbLx?=
 =?us-ascii?Q?qEQAOqxn6BRyL3/0JBVQz4L316NaHqF6lVLof+B8QMkErQ1ItvF/vm66Swd+?=
 =?us-ascii?Q?GYcnzTEqiz7E8ViZ8ZexLhcQb2iEru04FHzzLXqxrpZKVd+u64sbuqqBEvtA?=
 =?us-ascii?Q?h/FykgeRExkK5KayQteS1zNWSNhW+oq9QX0Sht8tt3aaj+LLpWc+VOcmuQDx?=
 =?us-ascii?Q?7vRXiP3lqDNiweIsRZxs1LHBZE/hw4Xe5ZADpQ33Z3SskLRgUaL0zwDUPzLJ?=
 =?us-ascii?Q?TEkAbdukzlK2RVjC3ZZParEnAgi4gLPQblwL1kHdyqiAeuVmBj9ImdO5ZU62?=
 =?us-ascii?Q?+cUJSfhcp6MMJF9d1nB4iYZfSMxF1GB4pN9KEuL7s+xllCiLUJko+iP+pK46?=
 =?us-ascii?Q?PKVqBicJcxbDhQKJ810kwDalJD4EMIlfFB1JfHbZ4X4gB1cFSHYOwSq/0VtQ?=
 =?us-ascii?Q?BlqxZg3AUACv/AJkejS21uy/K3j2lMVYQvgbdD7b5u1nyAzuTV7WsBsgxMk9?=
 =?us-ascii?Q?sa7vg5aN8/jvHzVjBO0zVzCxbST/tKY54TNPyaT3fgeFFxwy+RQNyDLmuBgw?=
 =?us-ascii?Q?X1M21njSVnQjbJvN1mhbF2ds2+rxGRqjduQSGGvms9sdC5e9pvABJ5TlRWyI?=
 =?us-ascii?Q?9h5HUtZPwYV96T9wZRhLgSZX4s40tWdsNz/wNc8Z5FnYmyzDRLpOL9CD9GEV?=
 =?us-ascii?Q?M3zJE47hrwqcSbsp7pwst85P6pAwA3fKcL2K1P7KdIEZS12BceeyeMJdVoNT?=
 =?us-ascii?Q?Yjo0rglFQ+PnXy5tSYLXCyrY6um/gEIlW4ORyu781yGPpraKxmbJ1+D3dkCJ?=
 =?us-ascii?Q?VIK5QUmC3QotfhAXnoKa7Z+8JQCAC4Ogf+jS0CEEiavY0iOscuxj4tnoNLqV?=
 =?us-ascii?Q?0JzRhD7dyyPLkTHqfcP30uGGZRFxM91/IT1I3XDw8M61Z0D8+haqdKxbn7Yh?=
 =?us-ascii?Q?1STRs9wh5tqJYsdDKQYO8RumhDc+kNZJ11hbGfaBwEiZ8fUpUqLMRiMBsrC0?=
 =?us-ascii?Q?PLQJloez3RhlOyoGUuYMEhA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J/mj/GBdfyQeTnJpfYSH8wnhUYFmIjtzMdLHFzJgDH3hFjUl1TXTOJtcfiMg?=
 =?us-ascii?Q?jCrJakQb5T4bx88+KGqykrTHHIVWioCM4j8juVLYZjDq28yF5VOSueof/zJn?=
 =?us-ascii?Q?tB48LWV2UfCi0ktz4KjBsxhx6Zn6y3T+VhVxTymxzAp6aFerSX4Q8QDh5KXt?=
 =?us-ascii?Q?xRMgB/h3dHQBZHUaIruDF8am1zbt7Pb2j4eehYc1WxojlKeNeEpgtzxOSYn8?=
 =?us-ascii?Q?UpRb3eMtKi/litojv0eim2DwqEd/r3KdfSZ3ozKe2WXLj4eozSYHcG2vvHc8?=
 =?us-ascii?Q?y/im6n6rCjmjFuY7G6OJaMdp5jywQHlyvi0QEROmPiqFBGdaxI5CbDf+2GT/?=
 =?us-ascii?Q?lGjhN4Ajvpu1VAmh3cekbEPiVbJumwoTPg+xyonwWC+j9l+R1yl/pFIs9Vyc?=
 =?us-ascii?Q?WLFYpl1pBdFFdbw0ei9mwtbYCB/bMJmvXdLxhDV50f0MvF8pkSN0GC4cjI2T?=
 =?us-ascii?Q?LxlbVK9qJa5vDy+kv17tRpBt3bayLwzbn3R2nTADwDNPuDMYCYHIDrm432WK?=
 =?us-ascii?Q?DMy0sj2SWXBGxFTHWlIFPSMmfDJ49xyilBRv/vLkthnm+MOHc6GP7f9Cjm2r?=
 =?us-ascii?Q?bv6uv4EXCtfQwyjQZjivUcGdFYDOSjnuQHff6xBid/Aq8ylYeLRa1/kXIiNv?=
 =?us-ascii?Q?pqwYoGkCwc/yn92AvBEYSTf9ZBx3rgYvwLnV2FdZ5MiteQZEfRH2Y5M3LL9x?=
 =?us-ascii?Q?da8v19eN4o71qiwQJKw6T/NcYdY6+WcGYGWUMkCnz/ojeuOZDmZ6YLQ3Fl6p?=
 =?us-ascii?Q?vGvsq0E0uQEn2Hc+tMR/h+zrG+JMox+wSpCuG4axmaOiYmTguwl3X6iED4Ji?=
 =?us-ascii?Q?QJQ5hg8rAfiCO8BGWoNHcFBm3EC2g7Qxb0CZW/U9IhJ48BBbHi1bPy3dbaFC?=
 =?us-ascii?Q?tzfhGIa+XOw84N0ULkVB22Y0fhlRCfAZgoBUJFJIQeUHm5pgraC37L+lscUc?=
 =?us-ascii?Q?aUn3Qp2YfoRgpyTp4oHJAEmb1NIgH3O2LpvKXENgNK6XK8feAgmKFYd5upWf?=
 =?us-ascii?Q?fMGw9GhfCe0pOHmy7hf+OjnxHqQjT2w9EWFDs25cRzsl/2Suo1GKElA/dsE1?=
 =?us-ascii?Q?SLn4Kd0Ndh4Ar4eli+9UZR4hqmS6CV+2xDtKfRggxiUTVKYDfPwnxW7q/2h9?=
 =?us-ascii?Q?v9EwH8GFxPDIsYVmiRLZ8DTnIIIepphyP495MG/ShKeQgiLkSnc4RlIihj9e?=
 =?us-ascii?Q?UDi7PklE7/pr50yJvPpG9KjxIRFSRdmPoBODBehuwfqixJWSrcF284+52vGk?=
 =?us-ascii?Q?xyLTJdzU29iPqPysbcDYqMFaeJIhH+/rlmsOCyzsJ0SDfxg8XHn+/SCay9o8?=
 =?us-ascii?Q?MAYlXO3BOI/9pJ5RTCxhHWhnf2LciHkgSKR21Iw2ikfayvtaZtBO+vLJ6WJa?=
 =?us-ascii?Q?1z4a6D6tPiP3Ut0HbMUMw1ItxnxaQJlHKdBB8jknfnkr6vWrZ8mntYLFSJg9?=
 =?us-ascii?Q?HK24jfaYEmCqlMFa0sRrX1iRDS1YUQ6OnYnMEGTJfGu2pp+NjSV4Mp7zrA4A?=
 =?us-ascii?Q?8j/MKt/ZzgOBkbSLYshhtIS2Y9WmYcT9rYDKxO59WsfEvv7X0e8wMUg+pEMv?=
 =?us-ascii?Q?bFRyObu00rSj6BjX/v4WDYojulc4NgOpGOXniRni60RcBiOAfEUlpzgrjVsu?=
 =?us-ascii?Q?rXIZ6SsO0TMBSdY3uIlW8ROboojzUW5diCHplPkg/yU2HbcVMYYZs1DyG4hL?=
 =?us-ascii?Q?6rMPIi0CGxwLXEjrKaOWSKqY7NZWlCs4RAogmahZuz1wqZBd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83be963b-6a10-46d5-c366-08de6d768cdd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 16:15:07.3129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6fNn3F8CY3h4ZlU6STSQDs1vA50k85s/iIzrlUzZ20wP3sOGOqX8Djv3jcm49wGxxOcwKoUWtiFK/DY3ME9Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11486

On Mon, Feb 16, 2026 at 01:38:45AM +0900, Koichiro Den wrote:
> Support doorbell backends where the doorbell target is already exposed
> via a platform-owned fixed BAR mapping and/or where the doorbell IRQ
> must be requested with specific flags.
>
> When pci_epf_alloc_doorbell() provides db_msg[].bar/offset, reuse the
> pre-exposed BAR window and skip programming a new inbound mapping. Also
> honor db_msg[].irq_flags when requesting the doorbell IRQ.
>
> For embedded doorbells (e.g. interrupt-emulation), multiple doorbells
> may share a single address/data pair and a single Linux IRQ. Avoid
> requesting duplicate handlers by requesting only one IRQ in that case.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 57 +++++++++++++++++--
>  1 file changed, 52 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 20efa27325f1..39ba4d6b7d8d 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -134,6 +134,11 @@ struct epf_ntb {
>  	u16 vntb_vid;
>
>  	bool linkup;
> +
> +	/*
> +	 * True when doorbells are interrupt-driven (MSI or embedded), false
> +	 * when polled.
> +	 */
>  	bool msi_doorbell;
>  	u32 spad_size;
>
> @@ -523,7 +528,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  					    enum pci_barno barno)
>  {
>  	struct pci_epf *epf = ntb->epf;
> -	unsigned int req;
> +	unsigned int req, cnt;
>  	dma_addr_t low, high;
>  	struct msi_msg *msg;
>  	size_t sz;
> @@ -534,9 +539,29 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  	if (ret)
>  		return ret;
>
> -	for (req = 0; req < ntb->db_count; req++) {
> +	/*
> +	 * The doorbell target may already be exposed by a platform-owned fixed
> +	 * BAR. In that case, we must reuse it and the requested db_bar must
> +	 * match.
> +	 */
> +	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
> +		ret = -EINVAL;
> +		goto err_free_doorbell;
> +	}
> +
> +	/*
> +	 * For PCI_EPF_DOORBELL_EMBEDDED, the backend may provide a single MMIO
> +	 * address/data pair and a single Linux IRQ even if multiple doorbells
> +	 * were requested. Avoid requesting duplicate handlers in that case.
> +	 */
> +	cnt = ntb->db_count;
> +	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_EMBEDDED)
> +		cnt = 1;

Most SoC combine all DMA channel to one irqs. But it should be not
neccessary for SoC design. It is possible each DMA channel have dedicate
irq number. I suggest check irq, instead of type.

Frank
> +
> +	for (req = 0; req < cnt; req++) {
>  		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
> -				  0, "pci_epf_vntb_db", ntb);
> +				  epf->db_msg[req].irq_flags, "pci_epf_vntb_db",
> +				  ntb);
>
>  		if (ret) {
>  			dev_err(&epf->dev,
> @@ -546,6 +571,22 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  		}
>  	}
>
> +	if (epf->db_msg[0].bar != NO_BAR) {
> +		for (i = 0; i < ntb->db_count; i++) {
> +			msg = &epf->db_msg[i].msg;
> +
> +			if (epf->db_msg[i].bar != barno) {
> +				ret = -EINVAL;
> +				goto err_free_irq;
> +			}
> +
> +			ntb->reg->db_data[i] = msg->data;
> +			ntb->reg->db_offset[i] = epf->db_msg[i].offset;
> +		}
> +		goto out;
> +	}
> +
> +	/* Program inbound mapping for the doorbell */
>  	msg = &epf->db_msg[0].msg;
>
>  	high = 0;
> @@ -592,6 +633,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  		ntb->reg->db_offset[i] = offset;
>  	}
>
> +out:
>  	ntb->reg->db_entry_size = 0;
>
>  	ntb->msi_doorbell = true;
> @@ -602,6 +644,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  	while (req)
>  		free_irq(epf->db_msg[--req].virq, ntb);
>
> +err_free_doorbell:
>  	pci_epf_free_doorbell(ntb->epf);
>  	return ret;
>  }
> @@ -665,9 +708,13 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>  	enum pci_barno barno;
>
>  	if (ntb->msi_doorbell) {
> -		int i;
> +		unsigned int cnt = ntb->db_count;
> +		unsigned int i;
>
> -		for (i = 0; i < ntb->db_count; i++)
> +		if (ntb->epf->db_msg[0].type == PCI_EPF_DOORBELL_EMBEDDED)
> +			cnt = 1;
> +
> +		for (i = 0; i < cnt; i++)
>  			free_irq(ntb->epf->db_msg[i].virq, ntb);
>  	}
>
> --
> 2.51.0
>
