Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1FF539772;
	Wed, 14 Oct 2026 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988038; cv=fail; b=IJzNAWEL4ic5cmbyAepCP1UYRzSi9QJ6VhOjyxgiCDvTN/be9o+om7pk1jNwQOoeeNP8+2ShtiEScCiLCuaWI2C2rKy4HZgsjO4X1EldWfdOhSbP+H9297Rsr6+tUSmOlo8rvTWPYBCs6bfta7qzskZygylxNQxhXBxhXlFpsis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988038; c=relaxed/simple;
	bh=QH4LwFezc2AgNGMa5Cw+kLEM68Ua6ogIWTP8xttPvQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJjnAeEoz1fN6+FB75+3z3Nx87XWrxMpWFNIlYq4Ixi2/DN/mcPwoqZ2MXcTGfeoQUwJiZ3iB7JrgM0sE6ZHAjAVy1cz1U35oZ3RgMChmbaiJwate4UAj32yqU42WlbQmIAp6fbcLviTGGVNEvJqw83hyNZCEZxb+LT8I46lLDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZqpSqW86; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZqpSqW86"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKfTw9sVUmvjcfIYWpbSBSejrLoKAH9LaDs988Lr8QWrkRR6u+qMwWth8LqfpU0n2pS3X4cyMCQ5Oig85Xev79TyNrwl1NI0pWVhqE5xz1RRsbBpziHEv45M5LrnoGmoIVndpWUl5IxGQIwbgmD05cifqKmvMcoxPKkpV775Q3z28fW0sTG3XxXbVU/vUlrtZrRnnrrH2n0/1ftBO2b+pqwLbNqsYgCYuapRh89CLG3RaBbY5mX7CLlSSheCMbWYloVZIDzht6GGwNUEHOnJR3zuGkQO+HNby4tLcRv7rkhIjBmL4llVmpaYHsSLytsUPvdBoD+WHMZIrfKMQTd2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fx8gxYEAV0+hk1kKnfNQk26tlxRTgs+PqOgDbCIYPBU=;
 b=BIhW3JKfnFRruX3aTYnfxuDIUBBgkbrYJm1qe6ZY0fai1yQg++kPT4I2epNv//pJX9W9EB9evdSU/Cl7gojfb8UMEce6XnJ/FImA/Sw7naUzigu9arcPBx7srohfcdyCgJyCr0z2YRp9qgTeoVXTxmy+F8VXke6nHV5YLzXN+60zivvar6vDdjZmETun21i2zrNJT4E8P2uU0JEMEjptDEqoDsUbMWfhTIi83UzTq9lSepL35HIVNrEyvJOcM8UKs4tdPyoNIrhSnilmdtqGRj56iwF8P5KBJayLw7CMXoHMY4ZHg5pT649qgKhvJZ7x6ZJGH73m/LO0ZtNrp9D0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx8gxYEAV0+hk1kKnfNQk26tlxRTgs+PqOgDbCIYPBU=;
 b=ZqpSqW86yzt2amfILCTxJKaU6NssddBEz7QjLn5xv1HZFHRRkeqJd+Bdlg3dHqlZYqpQUVvWzhucqZkohJ/NuamL7yqMEIoHtwnotlIvpKAhIp8uUG2um2ff8Xgewziv3mTH/ZuY8XDUPRPj5tffuxQf8HbjsGiEaTHpPT1h+CEzpD9AhuRoc8aOqgUYgq5gWqVgz1jPE9ARdNdkN+0NcPduZDk5IXspZRZxoL6mQlvTQfQyJkiywwro04D0pZ227CBBPqNbjj0UP0DZhPYNzXVsrUG1Rgf6ZvzfOl6v+jIeErfwpbNmP7x0Dpl2ZAerrudvycAXs+Zk5Lzc+1Ls4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8646.eurprd04.prod.outlook.com (2603:10a6:10:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:27:14 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 14:27:14 +0000
Date: Wed, 14 Oct 2026 09:27:03 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Message-ID: <as-RN94Fsf7nFGss@SMW015318>
References: <20261014071448.2473208-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014071448.2473208-1-den@valinux.co.jp>
X-ClientProxiedBy: CYXPR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:930:d1::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: 71201ff8-bd8a-47a8-45d2-08df29ff3d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|19092799006|56012099006|11063799006|5023799004|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Pd0pTSXshU4M1UtfAB3TwtV7eYSPVlXNh2Y3urldqord4lf3ZrMhaAM1S4tgr2Py0pVCf/PvTv2vukqP8q1TDsgMsVouWa6v9kscnGgMJs5swYm1UN0Uj8GGBSIr9xFnshysOtuBq8z07+aMLx8gE5igxuu9arISN7CNEeJikA2SP2YVpVzAVrlElccrU+ZXXkhGTAN7/FLaueD/XuwZgJEc5np//lADvZIok651OY+t2ajmprViQMcyvP90k7I/3IxYCnFKGyqEZxf2EIRVG0c5c7kd9JQGS+lTWHabiDwHXinxysWTvteJkLDMl74Ei/klTKe1J36eKm6VPep/ogyZGl+6m8BVvdnfqGwM/RxrKntA0MdJP5+aihyNW5YJ3yaK724f2VsCqwyOjPP9CZK2GHMDX8k43tsKRzRHSuEe4V7BDxLzH7He0ZfHNebNQGEmFeGgD6dGpmx6egLCm9vnhmw+OEk3qQJ3BhD8FZwVJn54sdcOGaSaALQyf4xtiKQszedYcCT7QJgjxpuPnV+U2BAckMpLhgNf6f7ISw+n0fXEdtLHJ4u2m4gI88Bt/pBoSSYiwxWgapEmC6jiXUWoSzdXNta/S4Mk7d6spySlipycnXC338pgW4hKG3kK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(19092799006)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?60jkbfPiWjnVPpPktDmXYcmMUF5YXXg4m5Ss24Y/9vBWpq+Qaduv//4bDHTZ?=
 =?us-ascii?Q?Knm4ees19skByWjgwuK9mVagO2LvWbMROgeeJT4Wq7w2+3QB7JAi4Jjsk+Fv?=
 =?us-ascii?Q?Ry38hFy1PxtqQ8ZoODKRnQjroR1Hv0eh8CTa0d5uBmo8tIcGD8elj8aTdhRH?=
 =?us-ascii?Q?wAXrMlK9AUwWVxBdVRzBjo6gOWO50uWfuqQVrcwhKdT4yymmMcttSIIpsSCV?=
 =?us-ascii?Q?qyJ36Dmwrb56U5jtZ3GlLawUmn6LgfgPDezg2XrLO8i+bbci9mDZNux9IVAL?=
 =?us-ascii?Q?elmz2PmsaRTMBCNXeFbeQdiwVya4jTuGZG3Vfe5sOwTuKbD0vlwZvCL9TqmT?=
 =?us-ascii?Q?+sg4mH4hrmdD3t2XRqE64R1PuU4JnpU7ebO1BYcOgsdiLfEulXCvcvxa4Cz6?=
 =?us-ascii?Q?hCX3gHJ5suYd7GemiKKHWY1yoIX8OsGbDV5HWJK/scuQISe80EFMQ1oMoiHM?=
 =?us-ascii?Q?3CJ4svVbbDq0oTGLPtBVR7kRY/TxRfr4lAqzAI93KP4EIrAB4I1t2TSHTSOl?=
 =?us-ascii?Q?A4DhPLXvPL4Gz9G7F1KqETVGJvweNDZMn5Yebr9UI99IaX01dbnZtDKQmXWW?=
 =?us-ascii?Q?7BkbI2eXzw67LhACZV7QCMk0Z1fR1hH/QGzdvK+hQ1lJqsvjRwf6/FNxiqDB?=
 =?us-ascii?Q?KQMhvLVXsul4tthU7KNlOtrXbRUmYubrw/aib4txPkGfMUQSEQptBkiSNmPO?=
 =?us-ascii?Q?YcNpQiZpElsNQbBkRVnSsON9C8GibFtCSurrS0VbVDWRO4DZ59m6jtyDnN0H?=
 =?us-ascii?Q?4nzTE57o5+0qcWILJn+InjOZ7YO36uK5q/jZrdqrJZsG5pKJB65wRleMlLcS?=
 =?us-ascii?Q?XDVG7xw3UkE38KFo0FrR5SEkaMQ6mvJWCKZnE0noZAk4rkfTSnm1CLCEompZ?=
 =?us-ascii?Q?EQNxZ/P07UilZY7qkN0TMJkI1wgongUcfobmRg8GH6cEtfScvoUQCvUcVWHq?=
 =?us-ascii?Q?L2BL6C0oOHehAu7K7YyebCE8qWcu7AMC2sNnzwNuhTwQvFcJaqNs2Yw2q2wU?=
 =?us-ascii?Q?jfApfxRPv7NmR9/q98MgKFxm6wZF6ktRaMJhfqJM8CCeTjmE8uUCP+O5JUjH?=
 =?us-ascii?Q?ZepuFGA+R87fpVd0iA4pkz/xsDZai0fkxbPDqVhtSYr5aWd6es3cf/OnXl8Y?=
 =?us-ascii?Q?zn8Yu1wD4YmQGJIH1SFZPv1F94m9/163bSi3AW0sMSqPvjDa2yhro1TQ1lM2?=
 =?us-ascii?Q?bL2HcgZiDdDBpkKir3u+Lwie1Emf6GxxQlAdX8c7r1ZldgGO1tFEuvRlMZOD?=
 =?us-ascii?Q?2Xv1bmIawLid/FNq0jmHl2nogQn/Pt3attuUdZ5icpgoOYPEPreGh0JZRBl4?=
 =?us-ascii?Q?eaLp7K2o5zZmczqfLLVx0X05+2D3Bu4gsWhRtZE+2Z7seP/g0bm47Pl5gdM4?=
 =?us-ascii?Q?XPa7Rwh/2M4dIqfLE9jdHi20j/6ccQ5MM7Ifdkmk5ZJ0i1WbzPG7AAA8s+Gu?=
 =?us-ascii?Q?NM1jCDjc0wHivrYEL079rW686AyHHildasWP0kNTNP5NHEQ896DoKQLxaouS?=
 =?us-ascii?Q?JnznBtqcI+JJji9C9xYSJrxmKcKiSVf8SNNMMck8zXVmHhj+eSv0pVmOnuV7?=
 =?us-ascii?Q?eXut6C22ym97JG9OIwVoiV9ydZZu3f6q1rTnXW9sIfbcEzvOk115D6hCxmrQ?=
 =?us-ascii?Q?8vU4wMd+w67lnwQYPdd9KkWCsUlYhEhszoCd7Z6rWfY6+KmMrELaKubdqdb3?=
 =?us-ascii?Q?231/HZrAcYLp/mC8rFIGrcBZRcZNFK7h5N/dp/AKt+gNMmuj3DLUquZEAyjj?=
 =?us-ascii?Q?YID426WFFOYXO0X816t+1oru7xyOjmGt5FrPsAHrbultJrhmKX63?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71201ff8-bd8a-47a8-45d2-08df29ff3d90
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:27:14.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IY5hHVWLA79Bm1mAjYlm1SJiGjFIAKnaXw6Rc8JeJiOJ3beZKR1NWfEngbI86f8rYRTkhyyPAfd6V4QIQ2NSw1RWaq25iBjzNOXbaB8baB+7Q6PgGA0Z4fNuY5wiEQfh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8646

On Wed, Oct 14, 2026 at 04:14:48PM +0900, Koichiro Den wrote:
> The control-region link status is currently updated only by
> COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
> NTB link callbacks are empty. Consequently, the HOST can see the link as
> up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
> leaves LINK_STATUS_UP set without notifying either NTB client.
>
> ntb_netdev can hide this device-level state bug because ntb_transport uses
> a separate per-QP LINK_DOWN_FLAG message. Use ntb_tool to observe the
> device link state directly:
>
> After bringing both sides up, start one waiter on each side:
>
>   HOST# echo N > /sys/kernel/debug/ntb_tool/<H-device>/peer0/link_event
>   VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/peer0/link_event
>
> While both waiters are blocked, disable the link on the VHOST:
>
>   VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/link
>
> Without this patch, the link-disable command succeeds, but peer0/link
> remains Y on both sides and neither waiter returns.
>
> Track HOST and VHOST enablement separately and report the effective link
> as up only when both sides have enabled it, as pci-epf-ntb does for its
> two physical hosts. Both NTB clients observe this effective state, so
> notify both sides only when it changes, including the side whose request
> completes the transition. Serialize the two paths because HOST commands
> run from delayed work while the VHOST callbacks may run concurrently.
>
> With this patch, peer0/link changes to N on both sides and both waiters
> return.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v3:
>   - Rebase onto the latest pci/endpoint.
>   - Drop redundant dma_wmb(). (Frank)
>   - Retest using ntb_tool.
>   - Link to v2: https://lore.kernel.org/r/20260904162049.3432464-1-den@valinux.co.jp/
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 90 +++++++++++++++----
>  1 file changed, 73 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 07ba338732d4..a11f9260ee86 100644
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
> @@ -183,24 +187,54 @@ static struct pci_epf_header epf_ntb_header = {
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
> +static int epf_ntb_notify_link(struct ntb_dev *ndev)
> +{
> +	struct pci_epf *epf = ntb_ndev(ndev)->epf;
> +	int ret;
> +
> +	ntb_link_event(ndev);
> +
> +	ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
> +				PCI_IRQ_MSI, EPF_IRQ_LINK + 1);
> +	if (ret)
> +		dev_err(&epf->dev, "Failed to raise link event IRQ: %d\n", ret);
> +
> +	return ret;
> +}
> +
>  /**
> - * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
> + * epf_ntb_link_up() - Update the HOST link state
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
> - * @link_up: true or false indicating Link is UP or Down
> - *
> - * Once NTB function in HOST invoke ntb_link_enable(),
> - * this NTB function driver will trigger a link event to VHOST.
> + * @link_up: true when the HOST has enabled the link
>   *
>   * Returns: Zero for success, or an error code in case of failure
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
> +	if (notify)
> +		return epf_ntb_notify_link(ntb->ntb);
>
> -	ntb_link_event(ntb->ntb);
>  	return 0;
>  }
>
> @@ -325,7 +359,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  		ctrl->command_status = COMMAND_STATUS_OK;
>  		break;
>  	case COMMAND_LINK_UP:
> -		ntb->linkup = true;
>  		ret = epf_ntb_link_up(ntb, true);
>  		if (ret < 0)
>  			ctrl->command_status = COMMAND_STATUS_ERROR;
> @@ -333,7 +366,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  			ctrl->command_status = COMMAND_STATUS_OK;
>  		goto reset_handler;
>  	case COMMAND_LINK_DOWN:
> -		ntb->linkup = false;
>  		ret = epf_ntb_link_up(ntb, false);
>  		if (ret < 0)
>  			ctrl->command_status = COMMAND_STATUS_ERROR;
> @@ -1472,11 +1504,28 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
>  	return 0;
>  }
>
> +static int vntb_epf_set_link(struct ntb_dev *ndev, bool link_up)
> +{
> +	struct epf_ntb *ntb = ntb_ndev(ndev);
> +	bool notify;
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
> +	return epf_ntb_notify_link(ndev);
> +}
> +
>  static int vntb_epf_link_enable(struct ntb_dev *ntb,
>  			enum ntb_speed max_speed,
>  			enum ntb_width max_width)
>  {
> -	return 0;
> +	return vntb_epf_set_link(ntb, true);
>  }
>
>  static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
> @@ -1636,7 +1685,7 @@ static u64 vntb_epf_link_is_up(struct ntb_dev *ndev,
>  {
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>
> -	return ntb->reg->link_status;
> +	return READ_ONCE(ntb->reg->link_status);
>  }
>
>  static int vntb_epf_db_clear_mask(struct ntb_dev *ndev, u64 db_bits)
> @@ -1654,7 +1703,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
>
>  static int vntb_epf_link_disable(struct ntb_dev *ntb)
>  {
> -	return 0;
> +	return vntb_epf_set_link(ntb, false);
>  }
>
>  static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
> @@ -1797,6 +1846,10 @@ static int epf_ntb_bind(struct pci_epf *epf)
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
> @@ -1882,7 +1935,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
>  {
>  	struct epf_ntb *ntb;
>  	struct device *dev;
> -	int i;
> +	int ret, i;
>
>  	dev = &epf->dev;
>
> @@ -1893,6 +1946,9 @@ static int epf_ntb_probe(struct pci_epf *epf,
>  	epf->header = &epf_ntb_header;
>  	ntb->epf = epf;
>  	ntb->vbus_number = 0xff;
> +	ret = devm_mutex_init(dev, &ntb->link_lock);
> +	if (ret)
> +		return ret;
>
>  	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
>  	disable_work(&ntb->peer_db_work);
>
> base-commit: 5cdbd6d3a3a147fa9975e35f2602cbec9a72a932
> --
> 2.54.0
>
