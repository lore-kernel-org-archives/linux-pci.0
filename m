Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792596006;
	b=lx7MJj783vF559QCBzVjWBMx9XMSOyjcV9CTKNIu0i2vzrb4DPkthyI2MoFXn+2iruoT
	 CZA7cfGZ83RSJP0apv2GjlxvLVZRoMJ/DJj+Q4xaq5bKwYs1Mxh24da81Gw0ZcnxCxtEM
	 NA9jMZ0JKqaTcJ8gyHYn+x87trieyIgoUIoN7ebqHwbUmRauYGBW7baR+4sbtx8A21pgO
	 Rskm8dejWM8SHodk+VBX2NYHP5AsqPKGJCr9u8g2tSxEB0tDe4SQcuLWzgt1n9XABeNLL
	 8ZdZldJZqxmRnKouZ/3yf3LHMbpDSLspiWerDkPb2bLE0eMFRTW8hxG9eDn4sh/wznw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596006;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3GTHjxQgMJoZd4NcGfkeDzxgyX2dn7eNJktDio3dAqQ=;
	b=KEGtCPdSSIJI5l2RnfXKtLyPKLpNLiXrWUFuL5UQ4ykrzwhgguTQpxwEMXsZo/GGMqoP
	 oVu+dF6850uhappqzRhlqKFFbyy87X73Z5sowKW+aY24QWQigZ6RFnb17kYO0VRoeE3OO
	 RwIqAnuG1PcDs6Y7jVvwcFxfoE+iuqdq58QY7Xag0eZiPbC0UFgFMEKjLImMqnMNuZ6cP
	 3GCSnlGCIqTjhgntqUtdpf3EvQu7ZorcIMYyZwuMQEK5iHLFVsKUHHEdTk70cHwUUaoQ9
	 vUN5S+Tu1TNSvGzTK7E3hoNpJ5/NMOFOxV5JPsm40gMn3S1qXizE6DkHDKSui9bXTaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QxXLIVHQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.63
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25127606A319;
	Wed, 21 Oct 2026 15:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25127606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QxXLIVHQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvp1Zz070hV/vximQ9gUpXivn7i0acuQ9FsJwzsNX2RZAgQxuM2U2V/g/Xad6D/DFmYoWYkN01mfbHzIo1RvPRp+YBBxrTygHURTlXBePlsGHqcXcr8JDU9TAN9fw3khT0X9dIu06SZFSQEo8Hv50MR3oissAqD14+lvxbsnoD8PhDgWJ7WxjDF+GhazirjxizBUsvp1rh5vLvvFoR1JC2nxtpSN19V/qK3umuUO1gig6YUDJ8DJ67+ULamw7oXF+Xyoh2AVQHvmgrqfxroHvlpUdLgL7cPtF+QQa1Bn1uNmB92uyupSqovzdf7g0/3IuY7Zm8XYd6Pu6qti5oHcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GTHjxQgMJoZd4NcGfkeDzxgyX2dn7eNJktDio3dAqQ=;
 b=qsTzYzsGzcEo1kwHSC4n2UE5dTcbTG1YMx1k2C0Jk4R4+zt20o0gkw/9xKWr1Y5NjBBJlidw7eZGu5jFrmaErDY4leOzJW0C9gmimV8w2y/sqam8GSJvR3tCcYzMwfikXh4adHro8kBKOkFyIa8YHTpnMZzm5i10MuDhjKf7HgSpH8qHVYT+F9/gsO0cZkfXhsC4PyrFQZsUh+WacHTeMRdpAZZ2Osh+WQ4hOJEG0U9ulnPXgFVjkBeNtxUqhrUi4j0bGVtd5MASSBBOOO52qvZnTTQfKdCWV3GIkHe2/HX4IDogYkBawS6FfZRAGXepJl4maSTMQW+1KdfTUPR9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GTHjxQgMJoZd4NcGfkeDzxgyX2dn7eNJktDio3dAqQ=;
 b=QxXLIVHQ6bN8APgKjcWnCwedKGCukSCkupyy7I1mEQ48f82MQFegY/HUVBn7Ore53Wj+wvO/elYptrpNkv8xuR59QrKh3KwPXG/Mp27aF9l2FLYnleVOswNLh+EZsZop4x77y/hiPLgXkDe9wLjyw0hC76j+4D6RzlVwmlmHURZQZ59vl310PfJHdGEUVt5PvZ2bJGiE3VgbeDQYzOv2U7AMQ1Kqbx5K8XSWGPAEYB75GEK7W5l9uv1RWqQRmtTdrKr3iE7VZ8C2vfre4RwRhLeebR16KsBX78/l9eOvdxW43VlaO4rFR1Aj7u9W6YOVTY8kseKpXhImHzyGEbGibw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB12081.eurprd04.prod.outlook.com (2603:10a6:10:641::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:20:03 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:20:02 +0000
Date: Wed, 21 Oct 2026 10:19:53 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, kishon@kernel.org,
	Frank.Li@kernel.org, vidyas@nvidia.com, cassel@kernel.org,
	den@valinux.co.jp, marco.crivellari@suse.com,
	andriy.shevchenko@linux.intel.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] PCI: tegra194: Fix Endpoint PERST# IRQ suspend
 race
Message-ID: <atjYGe1IKvAU-UF5@SMW015318>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
 <20261021061349.1265704-4-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021061349.1265704-4-mmaddireddy@nvidia.com>
X-ClientProxiedBy: DS7P220CA0120.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25f::14) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB12081:EE_
X-MS-Office365-Filtering-Correlation-Id: 86902180-9592-4cb6-bf0a-08df2f86c74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|19092799006|366016|23010399003|10067099003|56012099006|4143699003|11063799006|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kXXN+/lIN34PP0bw2k+OiaI6DOxUd9NeSTuJVdm4WM+IAz6+KsiF9ENKq+XvZyevieIXF59atiCzFPcWJf6ptTYG93Yu98npppLZSJs5JW3cKrWsuHQtfvZyJodplKfykQkyfj4qnmEz+ukKB/89qHNJ3RK7AgHBCj18bAVYNMfwJpQu0muH9Fn1tYFOvP6xycSOxA14nKewmtW4NQBy1DnhJFZHKUDCvB0yIA9c6pNiLCkM0bMekVmho8eW3XRrPTF3ofTEOftyWVppiU09KUFnzM20JMZcmZiEEC6uGEGrh1TaZ2ZlV5wvNQK6nREr/sPauG8sTf++8xogUe7WSzzuoofAsXvysI7S7oRAsPi7TJ4wsoMSo9ea20DwgA0rA6xl5uaiWBDpuUbryK/C6/LuY0OykpqhlC6NkgVGXIA7Nq2xtcyS04Rv2rcyXPnd4PJ7fPy9ZhVMPymwCtkUGFHq9EgqSXmsLx6vJpmi7Dvx/POpHOTRHp6tu1NdeXccG6QK9Tr2ljFc0dMIPiN+tbxDE9ijtsD/l7z8ETNyDTxQnk9AK9e508VvEO17hZcdqcFzvb4IGFHAKBkfl/IkIQQz5oUOd1/oIepY5mZ9Pa8WNWVKvgwRh42Xzh76s7FV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(19092799006)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/0Vxm9gdOYNhykjYK/pEcasCpWE6HP8zT5AY/9EMM6hrSCV40/zV0gQxCS58?=
 =?us-ascii?Q?ETF/DVLcTlrVI9gQEWUBGmq0W6RFNaqc5nYaEsObPX8T8PwqxfOh+5BLd7Lx?=
 =?us-ascii?Q?5YmWUZQPvwjY4k6UXkscIrGTQBUAPRMo6kKcxTSsgfyB3ScOVsPLmeX15f4f?=
 =?us-ascii?Q?zTuEVbzWrqbR5N5mT2LXUSMJ3gmtft984pQJ1Fqne9zZiYMXGYa65x3mYdjA?=
 =?us-ascii?Q?4NMoSELmG2Jn+zUBrbkb5WA7Jhd3uFjSMZICayMdNPnGCgaVzwGxyBgEK/63?=
 =?us-ascii?Q?vQZND1xcvkA4hlsdXixS25BPAXSMbGc7nxsq06WwMY5JNtfn8AmhoqV7tHw0?=
 =?us-ascii?Q?x9JE5EP3VwjWrDkWQbc3kRdksl6pXKlDEWREsby56BYwNadAe6Q8ksheGBsm?=
 =?us-ascii?Q?o90nWSs1/flCaeTXb9NmP1foY/+9BO1qZjVfNsYxT4b/Rk1AWV8yMcccOifC?=
 =?us-ascii?Q?6uXFx1ruVImqixxYjfCJR3HvTXK96Ai19xMaAHUpANFtpDmocIacx1kR+TFW?=
 =?us-ascii?Q?uNAItJfC8Xadb8OzJaxZrfc4WYBMUMDiKcfGdnhRrHA3RHF6ROiy6IHsdkDt?=
 =?us-ascii?Q?vkJU7xVBKNRVR4+TI/VmtRX2NEMu5SmGenKxzPG8+tpQiv7g+GApxIEHPrvg?=
 =?us-ascii?Q?BvqMRWx4Dq9l5lMFjRyCp/anL8XMPimaE5u/TgkuAfsmNTnGMq5rz4Fu3IVB?=
 =?us-ascii?Q?hh9iIDVJQE6OMY5xi6eGXrCUdFBXJM4zZM66soutWA0Qh0uw4iemwEvl87xv?=
 =?us-ascii?Q?tJWP6hge5kYbWgKd6nDbrs/gwoar6mhMOdjJ0WEM4D9xsQx1oXj9cTttxGIO?=
 =?us-ascii?Q?MN83uhMLxWmJZKRjBdkL8pyU//AtSuTxpWwAjL/aentUf16684cT3vnPlAWb?=
 =?us-ascii?Q?/Re+uCGdBSc9BhP/g6qKl3j2LJtRRwfIJDeo/iPc8YR6cdI7WrVWAq9I3nGJ?=
 =?us-ascii?Q?6jpDNypmScj/rngprIy4VYlL0rNxckSiR8V+jOesJLYDb4agp4ZszyCiqLk5?=
 =?us-ascii?Q?BaqMLS3QsZwsLJLTUm+9MTX5uC/4p0ey6VpLICpLltWR55hTPvqZf7fviwn9?=
 =?us-ascii?Q?85XezbD1VsystdCVAJU7zsLJeTwz2ZBmvL/JRLNPIGUy2IDzCUTsOrX966F9?=
 =?us-ascii?Q?NdmsfFY0I+BByOdSjMEbrz8vjbRyKiNUdU9u0V7x1vMuoTfR2YGw+m4C9nI4?=
 =?us-ascii?Q?eWcsA3IkofrMQPLvvc+xbWn/IFwLyAAmn26udDe5suHy0Jzrax+YFIra8KVK?=
 =?us-ascii?Q?Ted2oq+eRPhP9Nx8T0vBwyFY8R9BOPOAXzDHops2IlIYdZL5i5XgAbBY5E81?=
 =?us-ascii?Q?Uti7bof5PcJazMfm95DdGvwEtV8lz7hPfb0qsjwi3l00RWL3FNqd04LRxj86?=
 =?us-ascii?Q?9FIKVjHamHtCprUSapeQG8tlO9S2e1wt9xB2R5Cq6CxwYC8jzV1/oXZmRar3?=
 =?us-ascii?Q?O5AhzlPe2npuoAUKEYy9nSUQrLKBqiI0HoZ+0jQmFkekX0+p135zL/QzasZh?=
 =?us-ascii?Q?SOI77PyJh0XamhAXMNWfIL+CV8cAbz/kYcJAbGK6uQmorMb/mWli8/oVZNyI?=
 =?us-ascii?Q?joIl0QS1ay0ut4Je7oh09VF4o+Ug1CoKaqSfn/Ow4NyO8ngJq6UHnNH4OoQa?=
 =?us-ascii?Q?UqlPs6+mbdvAJj8d/SVTlp7CWFKu9u6y29Wfzwh7MZ/UITTR1kF1sf+E65Nn?=
 =?us-ascii?Q?CVnj2MwRtq/luk0oWUBGf+rVSO8VKLyukCtwnlRxiIwn0hN5vQtWqtPpun7T?=
 =?us-ascii?Q?lUrMIQb2jXF5xHW725XVuSK8Pab5EmzXVPH3DNs9LFjcIPWYS86u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86902180-9592-4cb6-bf0a-08df2f86c74f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:20:02.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqRf47uFeL6NH+TJVH8PIxIJC5av6Orh/YyyvWTF1VLEBaB4ymv6L621KBvi6FJaOJpxngedd1btcDePcD7oH5sD9OAsKv+QW1fD3nsUwg+FfL/B78jyuta36bDjgJmu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12081

On Wed, Oct 21, 2026 at 11:43:42AM +0530, Manikanta Maddireddy wrote:
> Endpoint system suspend is allowed only while the endpoint is disabled.
> Checking ep_state before disabling the PERST# IRQ leaves a window in which
> PERST# deassertion starts the threaded handler after the check. The
> handler can enable the controller, clocks and PHYs before disable_irq()
> returns, but suspend still succeeds based on the earlier disabled state.
> The system then proceeds into suspend with an active endpoint that should
> have caused the suspend callback to reject the transition.
>
> Disable the PERST# IRQ before checking ep_state. disable_irq() waits for
> an already-running threaded handler to finish, so the state check sees
> its completed transition and no new handler can enable the endpoint.
> Re-enable the IRQ immediately if the endpoint is enabled and reject
> suspend. Otherwise, keep it disabled until the normal resume callback.
> This also balances the IRQ disable when another device aborts suspend
> and PM rolls back through .resume without calling .resume_early.
>
> This preserves the existing policy that PERST# is not serviced while the
> endpoint is suspended. It serializes the software state check with the
> IRQ thread; it does not make PERST# a wakeup source or guarantee delivery
> of transitions during suspension.
>
> Wrap the PM ops pointer with pm_sleep_ptr() so the callbacks are used
> only when system sleep is enabled.
>
> Fixes: c76f8eae7d46 ("PCI: tegra194: Allow system suspend when the Endpoint link is not up")
> Link: https://lore.kernel.org/r/20260324190755.1094879-10-mmaddireddy@nvidia.com
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes V1 -> V2:
> - Expand the commit message to explain the active-endpoint suspend race,
>   IRQ-thread synchronization and suspend rollback handling.
> - Clarify that PERST# is not serviced while the endpoint is suspended.
> - Add a comment explaining why the IRQ thread is drained before checking
>   endpoint state.
>
>  drivers/pci/controller/dwc/pcie-tegra194.c | 34 ++++++++++++++--------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 89dbef83dd9e..0f895c766a71 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2374,19 +2374,30 @@ static int tegra_pcie_dw_suspend(struct device *dev)
>  {
>  	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
>
> -	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
> -		if (pcie->ep_state == EP_STATE_ENABLED) {
> -			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
> -			return -EPERM;
> -		}
> -
> -		disable_irq(pcie->pex_rst_irq);
> +	if (pcie->of_data->mode != DW_PCIE_EP_TYPE)
>  		return 0;
> +
> +	/* Drain the PERST# thread before checking whether the endpoint is idle. */
> +	disable_irq(pcie->pex_rst_irq);
> +	if (pcie->ep_state == EP_STATE_ENABLED) {
> +		enable_irq(pcie->pex_rst_irq);
> +		dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
> +		return -EPERM;
>  	}
>
>  	return 0;
>  }
>
> +static int tegra_pcie_dw_resume(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +
> +	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
> +		enable_irq(pcie->pex_rst_irq);
> +
> +	return 0;
> +}
> +
>  static int tegra_pcie_dw_suspend_late(struct device *dev)
>  {
>  	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> @@ -2462,10 +2473,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
>  	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
>  	u32 val;
>
> -	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
> -		enable_irq(pcie->pex_rst_irq);
> +	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
>  		return 0;
> -	}
>
>  	if (!pcie->link_state)
>  		return 0;
> @@ -2569,10 +2578,11 @@ static const struct of_device_id tegra_pcie_dw_of_match[] = {
>
>  static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
>  	.suspend = tegra_pcie_dw_suspend,
> +	.resume = tegra_pcie_dw_resume,
>  	.suspend_late = tegra_pcie_dw_suspend_late,
> +	.resume_early = tegra_pcie_dw_resume_early,
>  	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
>  	.resume_noirq = tegra_pcie_dw_resume_noirq,
> -	.resume_early = tegra_pcie_dw_resume_early,
>  };
>
>  static struct platform_driver tegra_pcie_dw_driver = {
> @@ -2581,7 +2591,7 @@ static struct platform_driver tegra_pcie_dw_driver = {
>  	.shutdown = tegra_pcie_dw_shutdown,
>  	.driver = {
>  		.name	= "tegra194-pcie",
> -		.pm = &tegra_pcie_dw_pm_ops,
> +		.pm = pm_sleep_ptr(&tegra_pcie_dw_pm_ops),
>  		.of_match_table = tegra_pcie_dw_of_match,
>  	},
>  };
> --
> 2.34.1
>
