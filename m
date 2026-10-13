Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76E51E433;
	Tue, 13 Oct 2026 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910582; cv=fail; b=bt1q9R3mmmxZj6L+ClN4/f/iGjoIC1E/YMXWqCgttAU7W+/hTxa/CoNd5E96Mp2GvnsWCPDh2xiHVXUfgUvTJxG51Eo0DRV6n/2SSmCk6DCiGFNvvMV6/BS51oG5ORE/MAlmt7Xw3Meh7WyOoMHj9PT/YA109/bBeYYydCdXPKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910582; c=relaxed/simple;
	bh=7xXy9d/jp1vuYmK62lLOU8j3htHcoSBuiJHjTEgoZRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QRU2eam0cK0otCNltWYZC7CFQVJNjxrkVmwvl/xqoYqHeVUX8lHeqEFjpzIljW1lx8H6HYpK2GlUilYgfCY+yro9RFbKOvMdit2eXinmmEGqyGWUQFNUqEvi6K/9cpRdhyNZ2wAmcuJUd94IbXqfy89fXsasS8dd5u/K6FHoLvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=euzf4JKg; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="euzf4JKg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDJnYUbgvvcWQdtPzKH29jW8KT+un8pneoZSQLlwweDmcZ1DZLjftHuuEAFMcNPUzmtfd2i5dNc+KKI42ds2KeltpH6V96PQFhf8tIDu7WfOuXdLn1F9W8SblXtsCZ5JgZEnluCN8c8pHhynGkY+QWZOFUMsODsuauRdXZX4lpcZmeJproq5j6Yj7CCbD4iJXQJFEb3Ee0wISPCJ4/x+rqS9EVxVD6K9E4mx1mhD4s2N6le9n/LOaBmnhVxvMHQ2NqXOURqiD+6Q0Iq7yjoGUHMx7edvUo0QmBHXiUJMVNYlYIR5fm9hcIYQsHurUGsjzUPF5eUeoWe8dFgQdxFXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deytnPeMS9XslEsk8gRjf2fZTVRnfzWjtJAefeskPdM=;
 b=NnYQD2rj115Rv/UndE1lGGim+LeQVQFMuggduUQZbbbUmdHucUfCiKcUh+HpH0UDKn8tWf5GympqJfzZKHNLDHt4QRB2KTaDv2Cb28SG41jZsFWuh2J3H89T6KZco2vDgUJziIE8/XLQbTdfedSnxANhi0aIm0TVIDp3zTj+kLsq4mip/DUyupdnl1NZkKwf6Nof6Tzcq6x77UZGjBQkJ1mtgiwsSEDFlAI70NP5fd1w+5SAhHnbYrrQuFbAbkhTanM+2A3Ru3nec+NYYsBImGXaJe/t87xkTRdzf6DP3r+lUyh2aikkrsdApR0y0xnHDnivisPJjzfjPTTTh56Ymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deytnPeMS9XslEsk8gRjf2fZTVRnfzWjtJAefeskPdM=;
 b=euzf4JKg53a8QL7xQTYHORhiYae0hEnpzGFDfflI8Vg8NG7e9SeuYwmtAcjSo45amT+rQ5o/KYJwjvD/5et9OovOnVX7sMyCnnYoU7l1XN0ZI4has9t1Xmfnm6M3iV1pFCkINYpTCwTZwzLVI3ev5PYXpYBex+IqMK3jHLUz2+M+JbGLEpJwJ1uSDl6bp+fy7FNZANvfLD3KEcOAQKGch9Ff9h0e8Q/rcJ2quPeZPIEvUwFwDB04fw5wb25PsykIDtUZcE5y8aE8SB8QdENquY1VTX/nwI3Sf5+SI73U9TVGc7HUWwUBAd/pBwrkZqPLX6G7OP0c1w7H59CxfPTWDg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MI9PR04MB787466.eurprd04.prod.outlook.com (2603:10a6:290:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 16:56:16 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 16:56:16 +0000
Date: Tue, 13 Oct 2026 11:56:01 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Message-ID: <as5ioWuOWCqu7Us0@SMW015318>
References: <20260904162049.3432464-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904162049.3432464-1-den@valinux.co.jp>
X-ClientProxiedBy: PH8P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MI9PR04MB787466:EE_
X-MS-Office365-Filtering-Correlation-Id: f74ac722-a0dc-495c-fff3-08df294ae547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|18002099003|10067099003|6133799003|3023799007|22082099003|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ibUcgCR2l6c7LZBvWoq8dSvzvr/P6MJ6yeosppKmUCspLGQo5E6Bf6vuWxRRXKls8ZFWqylX0fiOiV5e2ueVOFr9OXLThRg/6MvAcZYAGtmx0m790kxxoJ2GXHZ83edo8k6EbGdUMYi17xVFDI1vhice4RnOI+bXpj4ScKTPzpdqtsRYhoeb5WMlmzEZomTk6Q6modJCCFQCHrsY6p8uwc2e+BXcED+pyxkgdlb6zcuMmEakjlnYAlRC8sFWTBJPJdOHpNB3jXieRq8HKhiR6jzlLnDaiBnebbjG4X2yoVtgv4onpJsYBMiJ03gDztJ4OeMhLyvledBCTddvsxwYpynUP9D2SvVc1+I1KoxPerTeBop+ZnD7pwKkXLsCSKhpTHhG1bof/uO4wMWX2XwuGu2SliRvIqNdi85Q46MXR6MT0Ec3rBRMTWmwkLfroTWvfyP9clM+aU85mT4b0ox5+xO8SbIhzvwMapNlqcFuR1uQoscgpurgwv/UpDrgWUsDrwgU/ml05uxZ6wxLg2vFWIGHPQk1ZDmUwEX7CmeMYTB03lOILbT9xZKk2xgbUJgcGA4Pbub4VpgKHXObmYPNmcQF/UOJpU6IRbap/LS4j9YU7ONhj66nXsUr7SaQcWW2ruptJil/7pnFn+1jgBUVfYwQqu+2wMy7jYg5mMMKZYQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(10067099003)(6133799003)(3023799007)(22082099003)(5023799004)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5YRF3rKTN23gVPY7AmwAhwAEE30YrigyKsVRmdfp2pDusbjbR3D0aBLdBf5j?=
 =?us-ascii?Q?mAPjp8Ofi9R47lQuGmvD6lTA9oyFOKB3vnSYeMN2KIyVpRGV9fhKRnLzquCa?=
 =?us-ascii?Q?S0vyAIQv7ovkKAZ5BrUHp1mk3bHUPerQ2LYNU6F2s/JhhglbKp4rM52hOHHi?=
 =?us-ascii?Q?sZrIsoqOpLkgJCBb0tU+TVZJ3GBd5nIBLMIyTS99oqvt9k6vy2CqLvuTOOuJ?=
 =?us-ascii?Q?rbGKSVbGt5stK9gLcVh4tmKFiuDebh8D9OeKiMAPfV2u8RfxrK5X/4udpGUk?=
 =?us-ascii?Q?BqUGSn9ue3lGHfTyNhy8ShmUawt72L+Xc60n7AVA7PYUoDosRhv8mjFIiBFL?=
 =?us-ascii?Q?iXi1XyDUkY9JQrDjfV7xDl0OPa7G+ecd2rSNbjb9Hu49zRPhWyBWnH6wljB7?=
 =?us-ascii?Q?I21yYmpPVd6G6+FcEzR9qaAYz+2R1VxeCWpViINNTNYeUO5jDXmB5FC3UauM?=
 =?us-ascii?Q?ts0qUzNLALOu9Gj32lVVMG5tyD/oHbkn5P0fr9Dy1Rx/bBirx+Zq6RGWMYc4?=
 =?us-ascii?Q?b0VJGdlfb//hIiB8XPbb+xNFoNPjXCcf7B/9fNoNnJiiOPFvVGWC8cohmCd7?=
 =?us-ascii?Q?i8Wm+5pEjLsEmOPKjesCQWkvD4Aq7K4hVnzP1jPkiohoFOoJQzS4Rn1wbpIT?=
 =?us-ascii?Q?eFmCEk8oeeoCMbyzyJaHpH2hxGDUDWhhYWsowku2DjCl4bzuNVJIanrmiE56?=
 =?us-ascii?Q?hZccZLFozW6JVfWQ8U/s77L1r+f2TzxNJrq3MpPnxajypNOIcGnfWLkboO6r?=
 =?us-ascii?Q?NroopvCukOPv0LKSRW40yxCh8aO1mSaD/VO1KH79l+3Ux/cNg4DtbLP21iU+?=
 =?us-ascii?Q?sqY1BGfM2UlIfqFUbVS8ePaxzS4lqANdJJ8hndeUw4BtCj93lrGVuGnqU+L8?=
 =?us-ascii?Q?AeToYtzJZfGY1SZn7lmfBK5CY6PtVipFo6XpH5duSGNVORnQ9J3I2LGWKG17?=
 =?us-ascii?Q?58mfkPgF4dVBoEnto2XGv3m0bWt25KJqyVEmRcODiKS8Gft3sUQieq2nquxL?=
 =?us-ascii?Q?aS/H02qtSugSksa5OXd5KZSr62rjnX6ocm/8kfWkHnm2yYrbgJBcDD3F3Dsq?=
 =?us-ascii?Q?1Pm89ORm4VjQNNT5UCJ87vtZHHD398Xvh0rpfyYjlRJu8jFdfjAZSG6Se66F?=
 =?us-ascii?Q?MLMuFsgt7e4868HiZFfvSGKh4GF6OkVfSuwivBhzjFZWmxlSss/vULBxnuz/?=
 =?us-ascii?Q?K7bl7dNRWn4+9HVI3GaAnhWPXGCYSVpkRjQvpJVWSfkdMjMh48SOYE8H+T/n?=
 =?us-ascii?Q?HRbNaWjaVgj5OTTQeRC2+SeNU6znyad5SYvEUiHLayeIO8WPdLtNRQgtgXsG?=
 =?us-ascii?Q?dK4c+uPwsiPCqS68X5kmOq/siBXmeCnpdlKCYLxtcagaSFOCet3cIZrD3r2R?=
 =?us-ascii?Q?vmrBuQSFYyX/8qWoQlKs0onpwJhUrGLO1ooMtvY0gsO2ILfveGkJEUucipQQ?=
 =?us-ascii?Q?EyQNSyv55sgZ+fs3ntwoRrgDzJXMu5uBpkzhcrVhkHj7u+yZV0peICEuEU8p?=
 =?us-ascii?Q?oU77E+gF9YhNvV4Sne8ZCGkYoEx3bJSNN+CeahaCi7KDbUAEQgTGMNWBM0ga?=
 =?us-ascii?Q?VX+21ufWTRlUTPKctMdhJRsgCY6Kr64EmcE7p6q8GL12sFJZo9ZongWOzGHy?=
 =?us-ascii?Q?RxDjrBxwkQU9CQSFdjXwmodGV6Oy1wMw9wd3M1nLXoJlj1R+umkGuttP2RTg?=
 =?us-ascii?Q?y+XE4j8p8gc7ZHntogV9cAhJi6IQ3fN1k2zwSvBqaDrLZ3dzW6FS+c509MFK?=
 =?us-ascii?Q?KxGrnS+4pO5RMdnVRCpHoLe3VTvfOO3QyjRd1w5ksqIq3Q6Z0pjM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74ac722-a0dc-495c-fff3-08df294ae547
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:56:16.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCAnJUtNpsePZngPEcVJp3ud87t/NEJ2X3HN1yuwWP7cRb2bd1Gv/kYKoBquPK9Asdm0+4KF26XTRPP3IFTr+t0lX+a9X25m5w92g+EeyCtGgfBXRihDOAAdmamnshBm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB787466

On Sat, Sep 05, 2026 at 01:20:49AM +0900, Koichiro Den wrote:
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
> Order a link-status change caused by a HOST command before publishing
> command completion.
>
> With this patch, peer0/link changes to N on both sides and both waiters
> return.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v2:
>   - Notify both NTB clients when the effective link state changes. (Sashiko)
>   - Use devm_mutex_init(). (Frank)
>   - Update the commit message + reproducer accordingly.
>
...
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
> +	if (notify) {
> +		/* Publish link status before completing the HOST command. */
> +		dma_wmb();

why need dma_wmb() here?  suppose there are writel() at
pci_epc_raise_irq(), or barrier should be inside pci_epc_raise_irq().

Frank
