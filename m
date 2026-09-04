Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661B5477984;
	Fri,  4 Sep 2026 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534343; cv=fail; b=h7POqvvpSQ4IIt3w2bcuhn2T8nOdIILMFz4FoCrQ8VXw9U0MGCUcBGiVzMYlOsDwwhdaKR0m+WPjYWGvZTTMbLiQdDf3P8Oqjlt5LDhCN7jw1kOQ3SYJtHozOIR/U89Wb4gp7/nXCOll5BKPlbhu4qFkpO2zLxzx509+8goRxAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534343; c=relaxed/simple;
	bh=E3inVttYtk4YYnX6bI5N5J0RbeG3/YrkKSxxrVSYRik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKFiFp0nXRJt5ShzmNBxRiIOyIbvXKT32FoYV5y6mfnZDvkHReEVcCh2bH3TJnWOU0wqCS+D6YmDkH3lj4X3lpqP0LC3/WvJQoYM6BWrrYpRFgdgvRnvgwLea3T+V4+oDinG6xzEjjBJ1z7soe4w+20ntKpZT0GTYjA5cXGjl9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WIONVjUL; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WIONVjUL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7nLCotwUlyVNBersrd4pNId0RUrbC/80kvqu3BImH+BnsCXLxcJTaCLrUHDmEYJlX7xUI8/tOrDJzcnzVjM2y4V1otFpMompEp7+BdRPYDaIJkg6j2qjZ2ilcBD5UPOh9wFcSGGgdim33Af21msxNJux048YymskxhmTQSDuD0hqPxNcKIVCn57oFWtmMHhRjp6MdU+Yxf0YuuLP6gaqadajyxIIaXOKy7BRNGEx6Tf+s8UCCvF0t+hIapLVdikqIkzL3BtR21W7Md9HfHzqJAa6sR0L3OWDwqLVV/ZdKi86rIamUhlvrEmJyuLVhG8ykClloT+8p/kiMonFTrDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBiLDq08VuGVSF3zUOrLBuj7t2NJS9h5rnjjzd7dQ50=;
 b=XrMTUY0ptgpnZCEms6vMJcd4MfgGQr5p2wlbV1kbzof5D69TSqU6o3BG5/tAmWUp3VeLSymQMlNFLbwugZo6pu/7uDQB25AyJ3OU62aULfumjaZi68EHoaa93vc2wGj75Aw2vDQ6WyEaPqngpJo1K80975p6PkGP9Zv7I2G+I8C1SX5LaxQG501NbM1CYXrwHfcHadNeqi5QyNvJxFpTa4ra9b3RLzOPwtrm3adu12iAj/gZrtJpe+DTQZZR9KpjpZ+cRJ0J/GP+13TaemQJCGscvmegpsnmzZc1OhcqKIwuZoHhIuuaPg6Tj6Dt2NuFz37HT1rsS8lUhxHRO23n0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBiLDq08VuGVSF3zUOrLBuj7t2NJS9h5rnjjzd7dQ50=;
 b=WIONVjULyeDN49L/kGglYBP4nLpymDoaq6bXH58Y/VLXZ00mYef3r/lf9D6jk+xuIweyG6rnuJSqoaBx/SrrNuvuh8iqxmeO/Zp9CUh8QuCzWIcuzMa2Cu4RGTSyynOivEaKf9QYyhWPysPOuXGywvrZ1dRazh+2rk3zDFzQF9bOaCEEr1iRS7E+VBoP8jqKTzIaFRhRAGFu/uMHWv5v6l5AX8PfVMSXzd9B0jzqDAu4CelyCVKFakUiZgSLJmMzjekPQaSCDWfY/M3lcQfb8INmiy0oPmeU7GtET9zQUgBijYpUWleuAhw4G8QrFVXbAendNocYOrz69QtMpYHTuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by ZR6PR04MB566662.eurprd04.prod.outlook.com (2603:10a6:910:db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:05:29 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 15:05:29 +0000
Date: Fri, 4 Sep 2026 10:05:19 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Track link state from both
 sides
Message-ID: <apreL-yPOQlH3Caa@SMW015318>
References: <20260904065335.3059625-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904065335.3059625-1-den@valinux.co.jp>
X-ClientProxiedBy: CY5PR18CA0044.namprd18.prod.outlook.com
 (2603:10b6:930:13::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|ZR6PR04MB566662:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea4aff0-7ece-4857-cbd9-08df0a95f51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|7416014|366016|6133799003|22082099003|18002099003|3023799007|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	vyGtQSXsKPXMVJuSEb8EFRE3HfT1TY7idt630uVsyXn+QnnkNaRQVRTiP90PNkBjoco9zn7sH4IkcRx1AZCtS3XhMFukHLzYE9jsx5n0l3A6AOLFkMAwSBNWZ8cPbqo642CbeVPxvygt2N1/FQfsLd6xMCGMvCaXIH/wwXNg6kxJ75lHfWJrKevjgHEiBekfznjUdabtP4W7gH3v5ikWRiqmYxoQ6TOelEkGmZZPUNODtaP+jiq0rQgjlnbYpauFtifCHdkoIJPPC1aEgQi7IU7Ei230ddVrKUiI96Yis47OPEr9JeSXwLeXNI9z1na83/85arES9jZ7EN3PGHRkZ3cVlHWYo+1byzm0hgvFeyEhRXv4lekgv4dI/FI5zK/RPWZTD63VdksripWxjO3wbeWjqEeHp5uZkiy484IIdXmAeU/hMlfVrNOSLR4+wOXYJFFRG/bed9A8548/SFe8FwMK1zOigfgotbaDcaAfHCnq/4V/kN0L5XmK/o4EM9HqMlJHltZrK+S2G45SV/QCibOcjBNN3oePGDO5IpUjX+pJNdMNsHQbzxR98kSLQdzyqxZs1bWWms8RkcJSum7SRg0R7SHIOPDZor3vi/t1VkABr0BNo7GggVkCdI7+lNLw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(5023799004)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ml2/2PfyQ0t1k0SiQ+c8fxsYUS0ErwjtgP6pV+XV8cWJz17bOcIbCU1sHvw?=
 =?us-ascii?Q?cwM8QLcSb5gKpcZ0E9ykl3qj+03zG/5yaF6OoSPLm6BuZsC7fd2+ZcNXcaXk?=
 =?us-ascii?Q?snSJ2ndj22xjdnyWACKq/sGZ1bZgjH7AIh3n81AbSRi1s0knUtGkIrm8WKxA?=
 =?us-ascii?Q?sPV6RChqSThDJmdSg54yjdEVr7T/B/ej3ZwDTUTpfdub2Nyl1MktxWxaG8x9?=
 =?us-ascii?Q?le7sf4J929ykfJiaX/E+AlqUZ4PbkSDmEQ8gsSSoqkc4bLG/CJUJ4fwzqhdq?=
 =?us-ascii?Q?ngfYdqGsgDqSqlgD1wmE3J2SLawUKLij4Bcu0eW0xr7yB6x4iXwcGiOAzNjn?=
 =?us-ascii?Q?WfnIO+61qXuyrHXd5XrfVh5fuuNteykRQ1c/ZdC3I4Ys91UsMbSl8L5O7VJT?=
 =?us-ascii?Q?uBNstLkBj+8/LrErRye7qwZ6jyCTn5hULFH1Q59vLOohAQFbSM9xzQsLfAyd?=
 =?us-ascii?Q?LKNz1ky4baXWQaCjTTdZ12sM0clW+6YTzWTBrSBDZictsU6s0FFU4E6QS6R9?=
 =?us-ascii?Q?csWCXrzXAgLI155QUORZmkDdpH4ciRNWaTfu9zRwN3H8x3MQ4cm8ehRl5w6I?=
 =?us-ascii?Q?38H3C2fe24OiMgH/QM9A6pgxRfJfVJZ7eo/pcrGa+EdmiIJD3hc50uaDddqK?=
 =?us-ascii?Q?5Ps3A5O2UIof+RP73OSi4Z5vgInJLHzL7AuMZ3fiy3PfCVKu2vdcTRc7521c?=
 =?us-ascii?Q?D1AgA/y4AVBPrtaxJZMqmY7doWVHXjLRxZHv1wYJVC/kdplGnCA2fUKf/LoE?=
 =?us-ascii?Q?Zu7IGTENt1qtaCe0dNROR14TV8BBva7qe4tM+uuC461bno+QipHoiLDkAK4s?=
 =?us-ascii?Q?uMb267f/sAfq38LDQdhfEPUBY3b3xK0n9NDrACqQYgwH3prBCvpSWjyQ1wAp?=
 =?us-ascii?Q?DZcsbFnq9Sjv14RsaQUSCq4kCNhOJag58AgfWRpqhkNNC8otMH1wx+Cpedbd?=
 =?us-ascii?Q?Sa0BlSboLLTpi5dDYanWw6Shg99+IrEXoOTCsqH+uzNs+VMowo5kQUcy1yhc?=
 =?us-ascii?Q?XU3zBn52JNn1ENdc/zyCJkjTyubQ96UxVRwr5IqqBFnjUdFu/8qOWH3jET7Q?=
 =?us-ascii?Q?QgrC3FC73RmdZlRF0g9kWH578v6Z6CD0LD5dQ8IX2IJ26sdGxBrsaiQ5sa7L?=
 =?us-ascii?Q?BNDESa3adoeCZ1kork6k1c+ZFUj+XPX/DfTekThyfHiZu+OsgLo42YUiUEsd?=
 =?us-ascii?Q?JX/HsGHEcL8KsxQSbJaJaUC0Jyh+nL/GI+CC2czWZdJjCPcQKE2dsmdGs3pu?=
 =?us-ascii?Q?7R1n7pWa47TiTK+FLtiKw7hb7r8YFaJelZhQRQm+JPr57L4MYcedPmj/OTRt?=
 =?us-ascii?Q?Ce/QX6s2maoNN2mbUuael2KRM9vYY3EtlClBbNCVVBy7WmpzUg+JUNuFosYb?=
 =?us-ascii?Q?5FFH93rzO0X3JYGTw5aKN2TG1pNSeoil6cdrdthmpwJeNCOTd1RTCFKblkSB?=
 =?us-ascii?Q?gcr8LP9Yw24DZZGxrCxJtsMR385XEBLcUSeb8h9uApj3ZNhcV665kOWLsX+n?=
 =?us-ascii?Q?6ZqM9MyrPf+GY+xE4gUO6DRqUkld6Izvecvp7oEzji4uljbTZ8YAuBtUiTBa?=
 =?us-ascii?Q?Fm+0FtZUp2yAe/QINbBen3BNdPR0vTjeU949gOHs8VEyp+0lvNTVZrxD3jUP?=
 =?us-ascii?Q?EzHuE0emb8+h+n8BtxjbzuZEezA8I6MJne7fKxSp3UVZJo4dySVnjSNpmEmj?=
 =?us-ascii?Q?tzOVWauQReI/3zKJXs6JGMk9SKxRWAPdM9gHE22Gwy6graEAKyGoP8+yAW7K?=
 =?us-ascii?Q?ukKNOkv9ny9gjr9O4VB3MC9sCnRCXu+/GCE+TCbRJhxf78+F3nTB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea4aff0-7ece-4857-cbd9-08df0a95f51d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:05:29.1649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTYIW94O2wIzNA38d3drs0RSnwuB3sB+gUayyPbAQGqcE2zNRMbNgBTHRLh4G8gEfTS8VHkVo7jNbd0zmCJScDlzpdS53oMPNhNddjAquxoO5A0Q3yOu3aHEf/Fff21q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB566662

On Fri, Sep 04, 2026 at 03:53:35PM +0900, Koichiro Den wrote:
> The control-region link status is currently updated only by
> COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
> NTB link callbacks are empty. Consequently, the HOST can see the link as
> up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
> leaves LINK_STATUS_UP set without notifying the HOST.
>
> ntb_netdev can hide this device-level state bug because ntb_transport uses
> a separate per-QP LINK_DOWN_FLAG message. Use ntb_tool to observe the
> device link state directly:
>
> After bringing both sides up, start this waiter on the HOST:
>
>   echo N > /sys/kernel/debug/ntb_tool/<H-device>/peer0/link_event
>
> While it is blocked, disable the link on the VHOST:
>
>   echo N > /sys/kernel/debug/ntb_tool/<V-device>/link
>
> Without this patch, the second command succeeds, but peer0/link on the
> HOST remains Y and the waiter does not return.
>
> Track HOST and VHOST enablement separately and report the effective link
> as up only when both sides have enabled it, as pci-epf-ntb does for its
> two physical hosts. Notify the other side only when this effective state
> changes. Serialize the two paths because HOST commands run from delayed
> work while the VHOST callbacks may run concurrently.
>
> With this patch, peer0/link on the HOST changes to N and the waiter
> returns.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Note: This is a standalone fix, but it conflicts with the following
> series:
>
>   [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table and PBA
>   https://lore.kernel.org/r/20260830151948.3547577-1-den@valinux.co.jp/
>
> That series still has pending issues and will need more work. I will base
> v3 on this fix and make the new link-event IRQ honor the MSI/MSI-X
> selection made by the HOST.
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 82 +++++++++++++++----
>  1 file changed, 65 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index fba65abfb6b2..51200223f53c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -41,6 +41,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/slab.h>
>
>  #include <linux/pci-ep-msi.h>
> @@ -147,7 +148,10 @@ struct epf_ntb {
>  	u16 vntb_pid;
>  	u16 vntb_vid;
>
> -	bool linkup;
> +	/* Serialize HOST and VHOST link state changes. */
> +	struct mutex link_lock;
> +	bool host_linkup;
> +	bool vhost_linkup;
>
>  	/*
>  	 * True when doorbells are interrupt-driven (MSI or embedded), false
> @@ -178,24 +182,42 @@ static struct pci_epf_header epf_ntb_header = {
>  	.interrupt_pin	= PCI_INTERRUPT_INTA,
>  };
>
> +static void epf_ntb_update_link(struct epf_ntb *ntb)
> +{
> +	u16 link_status = READ_ONCE(ntb->reg->link_status);
> +
> +	/* The link is usable only after both sides have enabled it. */
> +	if (ntb->host_linkup && ntb->vhost_linkup)
> +		link_status |= LINK_STATUS_UP;
> +	else
> +		link_status &= ~LINK_STATUS_UP;
> +
> +	WRITE_ONCE(ntb->reg->link_status, link_status);
> +}
> +
>  /**
> - * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
> + * epf_ntb_link_up() - Update the HOST link state
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
> - * @link_up: true or false indicating Link is UP or Down
> + * @link_up: true when the HOST has enabled the link
>   *
> - * Once NTB function in HOST invoke ntb_link_enable(),
> - * this NTB function driver will trigger a link event to VHOST.
> - *
> - * Returns: Zero for success, or an error code in case of failure
> + * Returns: Zero for success
>   */
>  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  {
> -	if (link_up)
> -		ntb->reg->link_status |= LINK_STATUS_UP;
> -	else
> -		ntb->reg->link_status &= ~LINK_STATUS_UP;
> +	bool notify;
> +
> +	scoped_guard(mutex, &ntb->link_lock) {
> +		notify = ntb->host_linkup != link_up && ntb->vhost_linkup;
> +		ntb->host_linkup = link_up;
> +		epf_ntb_update_link(ntb);
> +	}
> +
> +	if (notify) {
> +		/* Publish link status before completing the HOST command. */
> +		dma_wmb();
> +		ntb_link_event(&ntb->ntb);
> +	}
>
> -	ntb_link_event(&ntb->ntb);
>  	return 0;
>  }
>
> @@ -320,7 +342,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  		ctrl->command_status = COMMAND_STATUS_OK;
>  		break;
>  	case COMMAND_LINK_UP:
> -		ntb->linkup = true;
>  		ret = epf_ntb_link_up(ntb, true);
>  		if (ret < 0)
>  			ctrl->command_status = COMMAND_STATUS_ERROR;
> @@ -328,7 +349,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  			ctrl->command_status = COMMAND_STATUS_OK;
>  		goto reset_handler;
>  	case COMMAND_LINK_DOWN:
> -		ntb->linkup = false;
>  		ret = epf_ntb_link_up(ntb, false);
>  		if (ret < 0)
>  			ctrl->command_status = COMMAND_STATUS_ERROR;
> @@ -1456,11 +1476,34 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
>  	return 0;
>  }
>
> +static int vntb_epf_set_link(struct epf_ntb *ntb, bool link_up)
> +{
> +	struct pci_epf *epf = ntb->epf;
> +	bool notify;
> +	int ret;
> +
> +	scoped_guard(mutex, &ntb->link_lock) {
> +		notify = ntb->vhost_linkup != link_up && ntb->host_linkup;
> +		ntb->vhost_linkup = link_up;
> +		epf_ntb_update_link(ntb);
> +	}
> +
> +	if (!notify)
> +		return 0;
> +
> +	ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
> +				PCI_IRQ_MSI, EPF_IRQ_LINK + 1);
> +	if (ret)
> +		dev_err(&epf->dev, "Failed to raise link event IRQ: %d\n", ret);
> +
> +	return ret;
> +}
> +
>  static int vntb_epf_link_enable(struct ntb_dev *ntb,
>  			enum ntb_speed max_speed,
>  			enum ntb_width max_width)
>  {
> -	return 0;
> +	return vntb_epf_set_link(ntb_ndev(ntb), true);
>  }
>
>  static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
> @@ -1620,7 +1663,7 @@ static u64 vntb_epf_link_is_up(struct ntb_dev *ndev,
>  {
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>
> -	return ntb->reg->link_status;
> +	return READ_ONCE(ntb->reg->link_status);
>  }
>
>  static int vntb_epf_db_clear_mask(struct ntb_dev *ndev, u64 db_bits)
> @@ -1638,7 +1681,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
>
>  static int vntb_epf_link_disable(struct ntb_dev *ntb)
>  {
> -	return 0;
> +	return vntb_epf_set_link(ntb_ndev(ntb), false);
>  }
>
>  static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
> @@ -1750,6 +1793,10 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  		goto err_bar_alloc;
>  	}
>
> +	ntb->host_linkup = false;
> +	ntb->vhost_linkup = false;
> +	ntb->reg->link_status = 0;
> +
>  	ret = epf_ntb_epc_init(ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize EPC\n");
> @@ -1833,6 +1880,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
>  	epf->header = &epf_ntb_header;
>  	ntb->epf = epf;
>  	ntb->vbus_number = 0xff;
> +	mutex_init(&ntb->link_lock);

devm_mutex_init();

others look good.

Frank
>
>  	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
>  	disable_work(&ntb->peer_db_work);
> --
> 2.51.0
>
