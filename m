Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011011.outbound.protection.outlook.com [40.107.130.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2E3AEF55;
	Tue, 28 Jul 2026 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269539; cv=fail; b=Zhuzyxfj2aE+xWy32jM2ndmc0wK3vqevlY4d5b+KMvsnpn3TJvTGvHCbRlWSuM3Im0NuLrlpBMLgFmH5g4vWwCb4Zudoj9tRSaj7d2YalPGDaOZTh1OBIqDgGSH7HgKjjfKG8S3hnD93dkLWWsz4+lqT3Uz0OGE7GD373kCjldU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269539; c=relaxed/simple;
	bh=BzDSzzEReDT/keD/uOZDJSzBXKTFhUQGRTvvAAOPVJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u7rkXqFBf7Ssot7xdSMzoaRt5hRQ1WFL7AQEMEsyieoYxG1jIwkSksO3d0AgyIPueqSSH/ENFooitytokhy7qIROSbrB1nkGyRAqfWRrGkRgGhaAHfWagC8et9swrtc7GPynBHogYafGcCHDKPI380Fn9VvzDZ5c7ORQV25T/vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XjGuwNay; arc=fail smtp.client-ip=40.107.130.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XjGuwNay"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkZrBgVoD2XSAZnnc+ziQWSUxsplPA7xYhq6qHyzMzA0twgQgjCr/L3QLDWTrnjnp+m55UlRffBSHKM2MxWUWJz2vPJ/T9S/XZhk8jNrgrzDp6oDFZ2wMyDgJtbUEi+KZVwTaaNWKL0Mwq+RAOOTzzM+GijTKn+obp0kVKsDdrzY3onAsStoP4IuHGWLgHqRx7fYgdmxfgRpS/ogHrtD9sCRzQC2Snvyk9oM/t3zLajBt4DewEPkJUCSBpuPVGjI0bHwV/N5YpAoqTtzULelMjyWM4HNfUIfuD+M438fIcs45hoVEfeU5i4sJf77lADHf8SGW1x5SIITESk28qAA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5FGkzxiNPG3CdnPwwIXHDkWX41HNiw+qqrtkEWFwhA=;
 b=OAeqsxdLx38SwbEPFOx3CAeVe6BKSCWIq4jBmFSVXAEBAbHmQz9EE7i6698Qla0ntjtLaMoPR2KBchrXbX0Bjuc++M1OiIgFdavQ5J2DOoPeLNhpmgDrcMXWdH6D1+ex9Y1dldKHFNNOCj9YCaS5tx6Iws14cidaExc59/kPcDq0II4tNvIt5ojctw+DJ/Wye+GI5zOktIt662pou6RFAhx7XtX+ZVD9JRQPfFGL8f9QKjiDLpv+Z7wbDFlH6KEnFsX/WN6+B6rBHYVvv1Fivw9RvdictmRKRaR1Or9O0lpxr6RSUCaRtJMiBlW/Pye/4AajffNxEwWHrfzPrhExeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5FGkzxiNPG3CdnPwwIXHDkWX41HNiw+qqrtkEWFwhA=;
 b=XjGuwNayaGzevDEFOEaCdY5vl+JRnuIb4Fn3m9RTWRBu+JY+QHSJHaomzgIfN+a4LZmsYB/Vye1LtBnoXD6Pd8pjArGpS3MpNg9oEk3boZgqCh5dhI7uPQ8DJWlvFPXFLOfyG6EqenAKxdQdXmhb8tePloOqq2lEiFT8As92JLddbYRps6F4o9okEmb0aHaXHQQJoldQgurSzK2H51iT0uugNhqxPThSiXlaO3keR+5elbXFR5kFD/4vOmmGLi6Sr1ZZygv0sioFpfw32363VJSGhDa6/jhyQB6DLMcNUUVlGjr3NomLoZROvP2cxqXKMF3GcpwA7+l1dKWx+k34PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 20:12:14 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 20:12:13 +0000
Date: Tue, 28 Jul 2026 16:12:07 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 8/8] i3c: mipi-i3c-hci: Advertise IBI wakeup capability
Message-ID: <amkNF47xyCd4pJEE@lizhi-Precision-Tower-5810>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-9-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728155308.142713-9-adrian.hunter@intel.com>
X-ClientProxiedBy: SN6PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:805:106::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fe4dd8-aa0f-4570-f64f-08deece48387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|1800799024|5023799004|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MKAg0rHAJoEBqH56cnwc9qAewpFyBpS686WImySd4PHX9n5OqQQpB+6sOOaZ9AznE+tSsH5dOBQo9P7zveJxhtBAqR9yAz4zfigE7wka2/Gy4rjFV3ChvT7c3B+DDMv6EaBGNO5pRjNMo2znFf4frRUESLtNrjV/smE5xRsBFnPTMMlvYoY43p9KlxqDAyPhKTqH0/SIq/P919Blrw9bo/GnXhYBu7yFHPIrOlaV0UJs1gBxOrwtFueHMTDR5uFguap7RcfJ8wJkarz6WCgrCG2/l6PSEUaqqw1KoT9tFTJV/Yw5Tsy2ytUx4yhdlJQe2dxrlWvocZ8fx+W45yjDTiCk7D/EVSL6EUHUFpRbdFeGVOtlbV8CBiO4l71LVh6Ng4/mrQTillJPsCozACvcrA5jZlGbSSs5xcBWtmoPaZOLRh5b2bF1NdqvEVGIsGIPj3Tssv5wc6w1Ox3QNZCosROm/1NQjfZX5EOBjwQ7NyFgPt0oeQQK31rP6MW8zTbp5OsRLXlmgr4d2A/gzmTr7q6n3+xOvLGI930NHxy9xbt3qX5AA5qHGfi67Hegnh1Uzevq50sdPvkHX8UUHohRYf3nmTP3WETbojbVrqYLFaKadHPTQ9qzoOyJJ+dzzweCWiuqSO4h6LaRNgKwiFPCPqe4hrcXjQrtd/kAKlYzR44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/kcqzaHfsLBDcu/LRKhZnGnN5QlR5Y5rvNSjxG9f4DuiDoBT7WSEVcs3A4qP?=
 =?us-ascii?Q?ltSZJ+lEJY4K7oAR0TCq6h2c+u433uvYDMKFgq3XYZ2eJ2/OEfjo9wvjm1t8?=
 =?us-ascii?Q?YexgvaD/lnz666ZXRu7BGb84OkfpG8Otg3TCIjpsfeQgsGyQAMvuuKs+nT/u?=
 =?us-ascii?Q?QnDMOYWK8b6JnU4m3dKpM9cr0aNkJc9RsWYtBQaIckMktmmfZT+BDkCFjYK5?=
 =?us-ascii?Q?lTPGfPuS9goJb/LVD88efVimIvU6OLOqYEo5B5LdgAg/cBPZAatAuSmv3xtO?=
 =?us-ascii?Q?Om2JxO8XQZF0ZG+bYWods2XPoaCPcnNXGg1VlrNBKRKXnPAww45XLoFRQJ98?=
 =?us-ascii?Q?gZ0TlUN9JXqh/MILxMqFXubnbgx1rkQgrIJlVxkS0Z0lod7LnmlcHrcvtiSw?=
 =?us-ascii?Q?zHXG6w2GXeiX1s1aHsTWbJmr6pyW6i85XZkXXP9DTT3QDGlNz9TuzRc8s0ox?=
 =?us-ascii?Q?r/ZjrkzM5dFT0Ge3hVTIBrZpTWr5XdT5rtquq7fjQljQExf7mgOEvTCFQN0M?=
 =?us-ascii?Q?YU9kSR01CpiDaB24TA231PJ88T75g3qNCOeWl29I5YWejuH6fSa1uJS/n4CF?=
 =?us-ascii?Q?k131vwHZ1K6hag0r+9OknAsBYADQQrRloU9kVKyrwFYuNsoy990t0hydAVV9?=
 =?us-ascii?Q?b5/7EC+wTo+B8uEHVecwc1p9coWMeHQpiailAEJMfA8ZElsEDW3H+aaHvHMl?=
 =?us-ascii?Q?85ofhVvTHY9ql/YDj4d6PU405PUrRIQiTwnqfdfJV6zRg8PPRieTvKXoKXis?=
 =?us-ascii?Q?zQYPyeOfWIOg15EtmgsTnLonzzE7krfRGQNw9mdE/3vjtrxkQOzff28Vm5l4?=
 =?us-ascii?Q?lgnTGapgzK5js7mKivo4ovf6FOKD1FXlEnC+vvwS0Vg3+zWSFq0kovodN6Gd?=
 =?us-ascii?Q?YWlHb1VH7ZPD5m0hNTSfl+WUG+LJ0N5YmVxmGe+Sw4/T5gVOQ31kFKwKKiYv?=
 =?us-ascii?Q?5Nk5bEdTN7xgS/+uQ/JsItJHQsCJjDkJMQ8uBavXkjcj16zUYePPzxvznVcQ?=
 =?us-ascii?Q?jD9RFvIg8/V9hHltWaNJ257yJYgxMrv7lfhYi2JG37ZaYEdmw1X9AFKuMojz?=
 =?us-ascii?Q?40Xpwm10mJV0JwQgKKhdVyff1pnqa5iKARAd2p2UJ8mMv8CXVXzjO3wL0P0M?=
 =?us-ascii?Q?BJPQ6VCVgu4vb0fRVb0qcDb+94u4uVTOUepVwQZvnbuCxsXHHh6DZRY1vSSr?=
 =?us-ascii?Q?EcSUOl5v1BAKkywT8KtHE6LCvE05MMvPla/HydcqTmge+zXWNjAqJphkacH7?=
 =?us-ascii?Q?IpwuwYkESJ2nsLinMLQMlN5pnAAgAZDt7LDwPTKFmYwmYFOD24GGR7r5iM5D?=
 =?us-ascii?Q?tNsNX463OnjPuewrt2dkq7yaoZaNNxbv36qlDC/5SeaxwE2JkZYGq+he84Jw?=
 =?us-ascii?Q?OA0jr17lHd924CSzzb+wbB7FSqEs3FaePEI/R6WzMmYDxwKzyoAihQmA7anW?=
 =?us-ascii?Q?5JZHESIX5q1dBlPZk7ICKFBtIPWzczzGO95hvT2gLq61E7hhDS66PJVbrHMI?=
 =?us-ascii?Q?LzBvS0p5462mj2rWTx0ZgWyqQy45EowQyW/RAAVYIyTqenTYPdxssAo3Jwe8?=
 =?us-ascii?Q?4FyeJn62pKxYia0CD+gfQfbDFPE5zMkhtGHQtpXqiuwgZtbtAnOFZg9rUvRx?=
 =?us-ascii?Q?O1nx8RyHf9B4xAvPqqtK64PqnUzNyu5mexxoknSa7vGY2pEfU2PviHh0yFoR?=
 =?us-ascii?Q?HE0BcQo2Wd/RtpBUlrRJ45Q5B/tuCSnhZK7XPmGxRWwr5IE9Kc/Kra6nHgKO?=
 =?us-ascii?Q?DV+hPVCkGmwEmWnWV2coGO0iv/EfmohtWPQqlx2mUZJo4/2zJi/+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fe4dd8-aa0f-4570-f64f-08deece48387
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 20:12:13.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fryoJYLO9Oh03WWeQ6mggBnFoxO5bWETjFV0vhimnkc7N+TywuH8YVWZ7Y46JLJvtVslvK8s3UWiGxxW5IHyKRMEcdwUG9Kw91b4FfXLybMlvQ5HKsDbS36++m5wIRHZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890

On Tue, Jul 28, 2026 at 06:53:08PM +0300, Adrian Hunter wrote:
> Set master->ibi_wakeup during probe when the associated system device
> advertises wakeup capability, allowing the I3C core to mark IBI-capable
> I3C devices as wakeup capable.
>
> Tweak the comment for i3c_hci_sysdev() to mention the new usage.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>
> Changes in V2:
>
> 	None
>
>
>  drivers/i3c/master/mipi-i3c-hci/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index 0212c9e984cf..5d92cf0645ef 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -120,9 +120,9 @@ static inline struct i3c_hci *to_i3c_hci(struct i3c_master_controller *m)
>
>  /*
>   * Determine the device that does PM / DMA and has IOMMU setup done for it in
> - * case of enabled IOMMU (for use with the DMA API).
> - * Such device is either "mipi-i3c-hci" platform device (OF/ACPI enumeration)
> - * parent or grandparent (PCI enumeration).
> + * case of enabled IOMMU (for use with the DMA API). It is also used to check
> + * for wakeup capability. Such device is either "mipi-i3c-hci" platform device
> + * (OF/ACPI enumeration) parent or grandparent (PCI enumeration).
>   */
>  struct device *i3c_hci_sysdev(struct device *dev)
>  {
> @@ -1176,6 +1176,9 @@ static int i3c_hci_probe(struct platform_device *pdev)
>  	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
>  		hci->master.rpm_ibi_allowed = true;
>
> +	if (device_can_wakeup(i3c_hci_sysdev(&pdev->dev)))
> +		hci->master.ibi_wakeup = true;
> +
>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
>  }
>
> --
> 2.53.0
>
