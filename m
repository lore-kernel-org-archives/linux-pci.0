Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021128.outbound.protection.outlook.com [52.101.125.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6343043CF;
	Wed, 14 Oct 2026 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791942224; cv=fail; b=VMpnDZu3lDJcOpBIoj2Tuuy49OiYO+5OzoJEIZflTnhM8L598UT7t9tMMXWlfgiOSVbJMBqf+F+lJtykXOHSV6wEm6b2b4pLwkVTQGF9TZ1pRPDAMeiDVU/+dPyKOkMY3tJVaqrDZ39c3RTyaL2j4mSt7ZGTubsz5+HXdQ+bFps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791942224; c=relaxed/simple;
	bh=/R+cZ7Oz4lieM8bEdkmkI63JMQqM+Q/H/FDaOzDF7ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c5vVad7XShoWUT43LH9lIFPWs6KLnofLX1ed+vv7LTBa3kj7AuHYHpvt6LN3PbSs+XiguBlXC730KL7UwlDMKZsLBDDuzoBNvPmKu3c3pU4sTCvh7YeTfCzdCRvq68BA3JUJHHz9ZnJqbkdGdi/YOiF0lXMHhwrzq7R9cochVdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pSFHl2NT; arc=fail smtp.client-ip=52.101.125.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pSFHl2NT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnTdWOS8nPSMssVWK1pkgYdFwZjhDSzcKmVnP5A2rQsSREzAEkU5sSV60Li1Mpl7cG00KfxUNt+8anGb9MbgjDR/TXlz+bdeDP2O774A07DmdKXS1IIqOWarHOi6EjP7AqbYAob1skBp/IUT8OxPTjiRRHVsxvidZ2+8PQ44alEbDe2ctIOjNruV7t13ffxu9owMXC/atm4KK3bjNX5vyKNOVbnEhXYuxMS2gfZl9gBFAsKbvUahy08wx37VolpLoGZm6xgQ4RLOOkD/qUgSV9Razmo9NUwqED4+ZeIAVGHZGRy08B/eeJ6mo/qoMVxpdRbiWH2BMSQwLimdCddL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idTx0TOfm956N7WbrCFVflIQtfbb1ak+gjjk0of5b5Y=;
 b=nO4zkFIcykXzJ+j0qJOOCqpCNJSf6rK5Rki9M93ixktiyHbzh7tJzd0AG5L1br41g06pSzZZHR5Kw+kTdrNXZ57PEduzAmUPMktWH3xF//qWOR5FD/SsYnUU8MyP8jYZpU60WWYliBfZe3L3M+xDm4TpjNU+VKSsiT1OvHtUWOLfAEGAdfStHjUsJX/9f7r0b/ptTFgq4txbiHkdCtDuRCAkKY2Qjqz8/OX3Mcl6OeyQhnws7XxOg6BmnFHtTS0USTBBFDOdD8SoWGJfvphExznr0079ukra/8/dKXGSXDzNE2gvOkDj8zWTEkPtwXnAFCmnMQW7StcfkJV2ivSQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idTx0TOfm956N7WbrCFVflIQtfbb1ak+gjjk0of5b5Y=;
 b=pSFHl2NTaTRSfIAIK71LYcYmMsLGK7BHOv7+A+l+uE/O13SMJtyyxzqsY5QQ5Ko5szKoGwotZsXTXhbty1f9iT7z3Pe5DdZAEi4MfZ3ssys/jtji4Fq6cSegsbDwE0SUHcAkMOfPnRIoVVpoS1yKNPMeRMMGvW7noWcUUGrDAJ8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB2981.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:315::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 01:43:37 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 01:43:37 +0000
Date: Wed, 14 Oct 2026 10:43:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Message-ID: <y5pfpuk7z6kv42jofihbpluwzadk4iy5hhcd4zhyw7rl5x3t6c@4ie5kekew7dd>
References: <20260904162049.3432464-1-den@valinux.co.jp>
 <as5ioWuOWCqu7Us0@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as5ioWuOWCqu7Us0@SMW015318>
X-ClientProxiedBy: TY4P286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB2981:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a7263c-d134-4620-32f8-08df29949091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|6133799003|18002099003|22082099003|10067099003|3023799007|5023799004|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CKS4Ht/xS65atN6O5iGLZff67GAc831OiK4W8PRtAhKUC5hB5GmnOkmvmKjzce4DSIiPfixv+8Ky8VzwGOckUdUO+wYkOmQjs2eJC5Xmmp7PuwLUqJ2GpnzIG+MwtWFkO/z8liR4/KQHZpxk9vxoiKZrgyUCOkgbbvBjWFpeoiEbLkJIw8d/XR/2DT2Zul/FzPgrUpw4LvNbFeGCeBvwyo0OiEEDaRWIeXenTI3IhfX35KSmv2etSI8BkF+TvI9heYY8Se1Ol1yowQu+dNbxaA9JaiS/10hNG1QN92voK1imQuiP4c0KmmTQo0Lpj1Bpwks1b6ON8+VswgF2kBMj5bhkOSLXPA5IyP1T3o2oMSFqVlmRpNTauDw52x9lhRu3TaZjcBiHe534X9xR6UE8pHzBIWMbiw7uqYqCy1r/qnP3F4f9bfYhnIT4qfJtC00hnEAmq6wNkh0+G1Lv7od/vuEIj59iTu8yY90EJgdB2Mj8beT7HDOKM/hCy6MfBcrd/17Rq9UVS819nWfk8IVdMfsZwO5/Ely9rQHepriYU56Zydv6ovr+Bp5ogP6wppcJg7/yQeKZZVVpdzU6jJmqmsBZkCLeyiNvxAx2pAVOuAqrZwf0JVCp4jq58w+DhhsgazmZKl4GLRfj4Gk0eLgT4liwFQqlrH3liQE104YAhq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(5023799004)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+fhIX/BZR4x+asGscHwyAkONORGt8Rzq8KNFKKsgb5iZU95bIv2uzfJe07N?=
 =?us-ascii?Q?D+G2i/tavFLgzwWbIHdK1B4WgHT8MbYTxAhH11593QNB1JM/oT4Ix2UsUYsl?=
 =?us-ascii?Q?QoXqg0zfN5xwaPTKDpngyRU97BBDD/3hJlrSVQL5xrm8QUImndm4/EZEpt/c?=
 =?us-ascii?Q?8xJ5HYOJhH+UKENI44qFf4EeicumvPB+daBCDWLe5nmGNaLH+weLoAVmvoOM?=
 =?us-ascii?Q?zM7bDnSpj2FI284PAgfhaLi2ATHX3+dxVK0L5Hlqvj4vDXVldmtFPaOxGPcV?=
 =?us-ascii?Q?tPaeAPq0vlCMnXN6Q0sXftAWMCBzhuyDW3ruKviPJBBANrsw2DNdTOwQmKmI?=
 =?us-ascii?Q?+/wVQM+PuExLs4w5oOObkDezoHRsxw92YYhPR5VxINBP00k7Gu5NazBJGpIR?=
 =?us-ascii?Q?1AWP46qZtyjpZ3D3X74Yck2xUIZctw+mRQt1T/7PydX6zc5J3G29HJHpTd0s?=
 =?us-ascii?Q?dNK5NgVxbx0eQOdE5PSbjsNiATaXCznzJCiAq1V7L0/lLrYTCv0y6DsISb40?=
 =?us-ascii?Q?LD54u5E6pVsO3iu65pBpsqcl590BkS3hduQVL2YZ8TvgJAoQvK+pc89N9qIg?=
 =?us-ascii?Q?XoEGVU7vCoh8+Sxd0Xd9H1i8OLPyryYNewQHFeo0n7KIF+0BQA8S4/kZTyr8?=
 =?us-ascii?Q?1dW0Ax5SO3Q/QWiYYyS/mWZ+dyTL5/9W/dLT6kSIkcLl9bXIrRO7hxm3iS7z?=
 =?us-ascii?Q?+KJ2fXihqnbGSPerJP8YUUN8I4fsOawffwkoJX4d530uDLu8Xa0uOicqPPVK?=
 =?us-ascii?Q?C9f8OOc7szJYoovy1ipMdJjm1uYNSjYrc6nQ7wusJHIlMijW37h3cRnW9Kar?=
 =?us-ascii?Q?HwNJ68GcFfQiNU2b+kIaVQ+apRx4753gF0KwKXNSHPQRxnhZszdR9+/3UGOe?=
 =?us-ascii?Q?v0Hal/So15iMo50EElOs+s74NGS1NTelRjADWkEmN5OAfDrH1XbcsLQpbCMx?=
 =?us-ascii?Q?vZsW0WFQfnFSTVCwI9vIb7aOQLqkHGcUkOxjthdbF40lA9NjweVVkvHtlS48?=
 =?us-ascii?Q?FSkJAegHfdFBSDHvAaCaSMa1odb+WQk5OXONjbtm6y+X7BVnYwgDG675g4y8?=
 =?us-ascii?Q?KluvBceV0I87DoOrYcpCu0B151EGhhS1HRHlzQ0BztlazB8KVkUcRSdmKg6q?=
 =?us-ascii?Q?H+1KfjGxEo8j9IwGOiWAZQYhxJouf9TYWcKGNDl7tM2o/4bzl7XtUXMsHohj?=
 =?us-ascii?Q?K/Cgkpr45NJKySmNriewrQF5kEFZrXwQRyRUivx/+hTdn3HEACN60h01V/wq?=
 =?us-ascii?Q?zWJaZtTUbEHIXJzz1uI1N+0JI+Zar6bf2wX4/AGX89aHjgDvhZpMhRGwQGUP?=
 =?us-ascii?Q?VbAW7+JL0z5p7yfx4jGCHC3qiqjePwQdx1EoQOujSGMOQ+E7YlKhUegexFqP?=
 =?us-ascii?Q?/aHI/2G8YCVMNdbcR161KRBrU/SBgNCyuKhg88LRAGkeaQBmCdobxy73AhoB?=
 =?us-ascii?Q?0FDef3zfLMsNphP/qtHWmuIspNRHpNlFraBqRJTMzZd6X5QpkLNReGt1k8hY?=
 =?us-ascii?Q?PHJx1sH8eD4/GlcWM1u7k8ghDoCI9QuG88oSsQpbgceqdUDOYGTpKk0jy38E?=
 =?us-ascii?Q?3XdCMWUrSunB5V5W2NbChkERvykjneMUz3ZrTl8RvuLNQT8pW25UN9Dy8u1d?=
 =?us-ascii?Q?9V6xXvFKxllaEii4DYP8Nk06fS0n32k2MkayJzPxCPxpqLy7aDWMVScAcAo0?=
 =?us-ascii?Q?PsOjbhdwYxRwkRTTVfDeDWIEX3qU3j6DO1BWxr31uk/3VXsRxxWJZc2T462x?=
 =?us-ascii?Q?UX4QKQBZy2A+bXvYiY+WWh13vS1dnwu8XpQ4VI48Ubk4gHMjszh/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a7263c-d134-4620-32f8-08df29949091
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:43:36.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pV7Wi5rkchD68eCeWq91okEL89a0+Oh6LW0DAaYO9oqK94DUjztutg2l1xgNDL4S0LpKZZ1bgVdvkLQqAmV4cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2981

On Tue, Oct 13, 2026 at 11:56:01AM -0500, Frank Li wrote:
> On Sat, Sep 05, 2026 at 01:20:49AM +0900, Koichiro Den wrote:
> > The control-region link status is currently updated only by
> > COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
> > NTB link callbacks are empty. Consequently, the HOST can see the link as
> > up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
> > leaves LINK_STATUS_UP set without notifying either NTB client.
> >
> > ntb_netdev can hide this device-level state bug because ntb_transport uses
> > a separate per-QP LINK_DOWN_FLAG message. Use ntb_tool to observe the
> > device link state directly:
> >
> > After bringing both sides up, start one waiter on each side:
> >
> >   HOST# echo N > /sys/kernel/debug/ntb_tool/<H-device>/peer0/link_event
> >   VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/peer0/link_event
> >
> > While both waiters are blocked, disable the link on the VHOST:
> >
> >   VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/link
> >
> > Without this patch, the link-disable command succeeds, but peer0/link
> > remains Y on both sides and neither waiter returns.
> >
> > Track HOST and VHOST enablement separately and report the effective link
> > as up only when both sides have enabled it, as pci-epf-ntb does for its
> > two physical hosts. Both NTB clients observe this effective state, so
> > notify both sides only when it changes, including the side whose request
> > completes the transition. Serialize the two paths because HOST commands
> > run from delayed work while the VHOST callbacks may run concurrently.
> >
> > Order a link-status change caused by a HOST command before publishing
> > command completion.
> >
> > With this patch, peer0/link changes to N on both sides and both waiters
> > return.
> >
> > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v2:
> >   - Notify both NTB clients when the effective link state changes. (Sashiko)
> >   - Use devm_mutex_init(). (Frank)
> >   - Update the commit message + reproducer accordingly.
> >
> ...
> >  /**
> > - * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
> > + * epf_ntb_link_up() - Update the HOST link state
> >   * @ntb: NTB device that facilitates communication between HOST and VHOST
> > - * @link_up: true or false indicating Link is UP or Down
> > - *
> > - * Once NTB function in HOST invoke ntb_link_enable(),
> > - * this NTB function driver will trigger a link event to VHOST.
> > + * @link_up: true when the HOST has enabled the link
> >   *
> >   * Returns: Zero for success, or an error code in case of failure
> >   */
> >  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> >  {
> > -	if (link_up)
> > -		ntb->reg->link_status |= LINK_STATUS_UP;
> > -	else
> > -		ntb->reg->link_status &= ~LINK_STATUS_UP;
> > +	bool notify;
> > +
> > +	scoped_guard(mutex, &ntb->link_lock) {
> > +		notify = ntb->host_linkup != link_up && ntb->vhost_linkup;
> > +		ntb->host_linkup = link_up;
> > +		epf_ntb_update_link(ntb);
> > +	}
> > +
> > +	if (notify) {
> > +		/* Publish link status before completing the HOST command. */
> > +		dma_wmb();
> 
> why need dma_wmb() here?

This is my fault.
Thanks for catching this. This is actually left over from v1, where the
HOST-command path did not raise an IRQ back to HOST (from VHOST).
I'll drop this. Let me send v3.

> suppose there are writel() at
> pci_epc_raise_irq(), or barrier should be inside pci_epc_raise_irq().

That sounds reasonable. (Even if some drivers do not use a non-relaxed writel(),
the ordering between the status update and the IRQ should still be handled by
the EPC core or controller drivers, not by consumer like vNTB. In hindsight,
handling it here would unnecessarily spaghettify the code.)

Thanks for the review!
Koichiro Den

> 
> Frank
