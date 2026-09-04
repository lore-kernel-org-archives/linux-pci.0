Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020108.outbound.protection.outlook.com [52.101.229.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D8F365A14
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545931; cv=fail; b=fuzCpARlo4ACX0u/2liRAn1Siu6xC+bjU2D1Vv7w85FK796BUmAqphbup526B50DhKFU7EW9zpDG605nv8gqP5husoy/+VGk2c3oc7ZMN6xMXfk1iXDYizGUy29nxI9hIwAaTELu283zDITh2VFbzy8l/QOQvL3bVfi2p2tIOP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545931; c=relaxed/simple;
	bh=Ly9xyhRtxzwrB+HFG7lqs8V10uqJc6IntxCYiSK8cLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r2UyBIKKH/O199/2o3B8m3jOfnW8nkTHpG/C6nsR4fA3XIdRclibLjTaSCGx6j8d0n9ag6AxlLb9wp3cpjr2saUcmrzI7csGEKeBAaIx0BQEY3rhiJtYcAaThZpQ+hW6rzPwqrbOc45eRVkzDZtl7uPCnblHh9/kbZt+QpYaXFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tvRdrkgK reason="signature verification failed"; arc=fail smtp.client-ip=52.101.229.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tvRdrkgK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCx5yYraVEftczbRz30iJ4M/QdwMicdCvELxukt//FlWCddYvMybPduH+/qraKZ98rowV+cm3x4saFwKnlmpOZDfP+qR9hDUjCsODGAv3x4fvS9lDNCqmMvoZiZJEfKkRVK+q/ZgpSA6h7bnuVnZ7dGQ+5bdNKuMq4TaUbM5cZ18cC7seIKXTcU0E9CUvXqkuAKEqJE76gD+xPxqAfIN59iJurS7vfhpWwSeU9Ui5e4YvoQyO8j8rSXPzLr2mr0GVMEq+3BUfwbacHLLIxwQ24ogagOmKftHdM7L4PVhnhF0HDVHXJaYmk0f/vbDQb2pXn3eA7+BQmDhChlwVxf19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoEKK1oZ8MCMB7Rmphd3oON+aScQS50fmZFhSkYK2t0=;
 b=Pi/d7ZPDJWRYSr5qip6WmeU1ELI8ODkavU59qSAxOPIFr8I8enGsrjlZ/4NKH3uPE+x2AUsZ9SjlOqbRtMIUQ5gMDz2wYN7t1XHqqAdZ56BSVDJ9rZmxiSn/K+1XJoHcPKClMYowsl9/qZvbzyEo4e6nI2ezfQJa67zeX4qcIsZFXn9WoBA6JGn/4LDJNrUvsYL/6H+yQYuAiogonfurprrCBiRy0mnigzCB1gLfBP8T8wNo4k58ua7zdVWEi0UZd8sgRztyXGmFQnirlgHgmqEa74mSpKGfhHVPFacprDpIy18cYREwaKxfe+rzYrulOZVxcvg3T0gpHZdgc6ae/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoEKK1oZ8MCMB7Rmphd3oON+aScQS50fmZFhSkYK2t0=;
 b=tvRdrkgKORWAl0DKYWDf/YLuHjkvuTAafFvnV4XEf75gxF0lpOgYZo/R8vwiakNlewU/19ZFz80/7ejUx7cxFr2VwfjSHJC+rKWEs0oCgmXxx4gbtj/7rcD7vSRtjUomrqcc03btnzfgW2IA86IPWPlAzJYEAXKK/z6pG99Hkrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4781.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 18:18:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 18:18:46 +0000
Date: Sat, 5 Sep 2026 03:18:45 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Message-ID: <mbwka7qsw3gcphdwgl4wdqb3t4dweujrwvoj3rogxhwrpoorfx@3wdhmvi4lgfg>
References: <20260904162049.3432464-1-den@valinux.co.jp>
 <20260904163355.165061F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904163355.165061F00A3D@smtp.kernel.org>
X-ClientProxiedBy: TY4P301CA0063.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c7586e-1e00-42cb-33ed-08df0ab0f5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qbVs3s/PKRyY4Pl5u7PWY9akcrScPU5IeXIZsblAKME9fqXm6Q9ocRdJ2lA31e2M5CQutORLLks9eUf/Tu1wbNW3nNlABCBviTfL1xRHCxnqabWlwGofJgPe+jyUxNM5rvX/jf8/wnSdoIptPppNTi/xUnCcl6MVIPsJVce+P2pJo7ZARKdXY5vkzGgk3wPvYfg6uuvwcapZhx0n/28qor8e8IZqnCArBIRpqrDPbii2qDJpxjXpizLuAD59uxWJnpd7H4nz7p7Z6HbrC9JRvKT2DqGrXuJnjjrdhM9eUrBLYrr8lt4ge/h5tHmzkFPk2ZqvK8a2dFOUIZM3eq4bl6wP2qLfu+9wfC1FEAiFMwkP4Ift/GOB9AZF0+085kXPR91cYVPlgxLStQ2k9hNXoNfGdI9+zIlSVumSgnwIIWWLovdKA63GZ025c8sHR67744eKJ7OB2BbMA973n/EDaPFq5j6aHisuiRPuePYtMz2ONPQG25We89fdX78TW2Xk3Ly06Jf3otqVPj6iYGt8WIRWLqbsK8joQA2hVekjUWrvkap/Ng7YYYRUVSxUJ1k+Dz+v4EAMBH9rp0pqZAmtQBAIIZMVQ+fSerI82cvkOao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?+o9UsoOwh+U/ZrQ0jIVjNVCYnWkOALQvsdqMD320DnNl/a0LZMiqbnce4U?=
 =?iso-8859-1?Q?6VIL1Jik87d+iBJDhV3MX0jqGbuMsMDalRBC6jGrNO1EXlZtZKnG+rQq+/?=
 =?iso-8859-1?Q?WsFeTmzP9Nj/0jAfSn3gUSCJo0PiICMTE9Fqd9QSJ7tFysM3NWnIiqAKus?=
 =?iso-8859-1?Q?d/IDwJV1KnJyhewk+Es50f2SYiakjKKMVBxiMCNtgEmqJgkEAVv9mEKBDi?=
 =?iso-8859-1?Q?CFh2ianlryUWZaNWuX3qUGNnO4owCRStNmi4zpkpfslFCbfXgJEiF6zfT7?=
 =?iso-8859-1?Q?jiMxmrpBlDLu1PSIDC7BoqOau6fUcG4rIftLGVyaFs4mGQPYVB16G/PHkD?=
 =?iso-8859-1?Q?vWFnIAUAGJN1NaTlTCAjtY1udgMJdVwdsZU+lAFUMbq4o9psIRGf630eeq?=
 =?iso-8859-1?Q?WDyRxnLfv4OE7s34+GtlXbbnnMwOUlbxVb+5kykV3DKXlFXlMkzarLbTIn?=
 =?iso-8859-1?Q?tnp6Iem4z5IpYRfp7hpRrLv9NGdEzT1VtXiIaEtpSFVrAgIaklgI1/rXhA?=
 =?iso-8859-1?Q?fws1OYRavO9/hP7OSpCwlnTkVLicGl7Erz7Fx5SvGPf9xxAXX18rog3tFv?=
 =?iso-8859-1?Q?7upxf3JQ5ZXFBayxrsmTxhj5FP/RxtkCsPtMeG5YmxfSSacJy4vCaVukTO?=
 =?iso-8859-1?Q?c6dkzsbCvMqlr808wUbSruCFmNcHmofMBzov8j52bThP/09zRxbm++4LDz?=
 =?iso-8859-1?Q?7PRp6WpvlH5+DnDfNL+1cxy6dKz3lA1V7Peq8yk1rwOsNVejM9MhTgA6Dw?=
 =?iso-8859-1?Q?DNdfI8lXy/uSupD17DXpw3/nzlGWbzuPhj1B2P/ve+RoaivTHtIj/kuat9?=
 =?iso-8859-1?Q?6tqUWECoHE55lAzqtL6SgyfiTGyXWgGLh0FyLKyZJZB0jJi9IX4CxGOWFY?=
 =?iso-8859-1?Q?8BlA2eUVsNz7Na6MT85THd5b6URu1lIEyK6o0O9Uh5LQWUxUbGuBu5eAD7?=
 =?iso-8859-1?Q?quTpH4oaPqIxJjyMxuLij0jaBhRVTMA5EBdNDPLShZnfNhxC1myYJssL3W?=
 =?iso-8859-1?Q?hHLCk6U2HKCF9Exe9ZZ4O8IC5regV1tQqg6wMfKMVnAzIW9/CdHWdV5x/8?=
 =?iso-8859-1?Q?nCHHK1J4RDZIhKxZN5PX5b2UBB42T9ZGvT7Yf7i/GokEo3dvZi6VHTGTSC?=
 =?iso-8859-1?Q?BzqpCXI6rrXdQ7m7O6ELvN5EytviZBxhDJ91Dcpg0aUXywpcoyfxpUyjLw?=
 =?iso-8859-1?Q?+mpQniUqWrt6KykMGSpQyoTMaULB0fD2NIure4/CZZGAnIinbsWO54PehU?=
 =?iso-8859-1?Q?DEjptIGYSDAg+eOUZ0/gZ2gz4s9Snhz9CLXUV7iHfZh1rhPGFEvAqEr8jX?=
 =?iso-8859-1?Q?kttoUdRgCGS/SvywG+RMQqFRzncrcIkxI4gCo7UAm4R6O6l5rYoiyrHUCK?=
 =?iso-8859-1?Q?HkE9HwUillz//zt1MIFIRosG2is5bq0YOCbFk/Xbsg6jpC55v7ejsObJ+1?=
 =?iso-8859-1?Q?Nm2jwKRKJpaiM1jD6PnRmwAIxye64maZGwdwwtvp0O6Bdyfp6fjoWgVYKC?=
 =?iso-8859-1?Q?m/C1goVVT6n1PAE+jZ5/dsH7wMSVbHZBKVkjiYAl8ip3LXD9DT77RtdTsn?=
 =?iso-8859-1?Q?YLnn8Ld1xn7QrMs6YJxvofbRTsbeSlrZbqwn4cMw4Cx/FC9/9jkhobKxbf?=
 =?iso-8859-1?Q?23e6RNsUZf4oWutry+9os95EDUA3B88hng2MgUXAUvwojkH1faVF32cjKZ?=
 =?iso-8859-1?Q?yG1MoPVdK/6OxA00QGv/4XfR1W7ngnIWlzzsp/WJTnC8d+IKmBT/qzXtZ5?=
 =?iso-8859-1?Q?oKvrnRvyONJHKKCk4oAH/US0h8K07eI8xxlzbmTARzORoCUWRccZ1V5jUK?=
 =?iso-8859-1?Q?WIl/Oe/Lb04DLFg+W86SwCv4icF8kjLe4xJpDH5R/8cd1LMocfy/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c7586e-1e00-42cb-33ed-08df0ab0f5c9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 18:18:46.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuXocddfksivyY5hTyO67hqVpaoGgy916LiHoLiy8lKEZDiiCgVL2C07aVK/uCzYKibQWVZDcdV8ugNSVFWxBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4781

On Fri, Sep 04, 2026 at 04:33:54PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Internal state is not rolled back if the link notification fails.
> 
> Pre-existing issues:
> - [High] Missing ntb_unregister_device() causes NTB device leak and subsequent Use-After-Free.
> - [High] Virtual PCI root bus allocated in vpci_scan_bus() is never removed.
> - [High] Missing dma_rmb() between reading `command` and `argument` from the shared DMA memory.
> --
> 
> commit 31e5bb87c3524261d2384c7e27a492debb83840b
> Author: Koichiro Den <den@valinux.co.jp>
> 
>     PCI: endpoint: pci-epf-vntb: Track link state from both sides
> 
>     The control-region link status is currently updated only by
>     COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
>     NTB link callbacks are empty. Consequently, the HOST can see the link as
>     up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
>     leaves LINK_STATUS_UP set without notifying either NTB client.
> 
> Link: https://lore.kernel.org/r/20260904065335.3059625-1-den@valinux.co.jp/
> 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index fba65abfb6b21..f921c7c7019aa 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> [ ... ]
> > @@ -178,24 +182,57 @@ static struct pci_epf_header epf_ntb_header = {
> [ ... ]
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
> > +		return epf_ntb_notify_link(ntb);
> > +	}
> 
> [Severity: High]
> If epf_ntb_notify_link() fails (e.g. failing to raise the MSI IRQ), does the
> internal state machine become permanently desynchronized? The effective link
> state (host_linkup) is updated in the locked section, but there is no
> rollback on failure.
> 
> When the host retries the command, would notify evaluate to false, skipping
> the notification entirely and leaving the event swallowed?

Hm, the concern seems valid to some extent, but I don't think simply rolling
back the link state is the right fix. The VHOST client has already received
ntb_link_event() by the time raising the MSI IRQ fails.

pci-epf-ntb also keeps the updated state when raising an IRQ fails, but it
allows the notification to be retried. This v2 implementation does not, because
the local 'notify' variable evaluates to false on the retry. If the first 'echo
N > link' fails because the MSI IRQ could not be raised, repeating it succeeds
without retrying the notification, unlike pci-epf-ntb.

I think I should make such a retry possible, in line with pci-epf-ntb.
If anyone has a better idea, any comments would be appreciated.

Best regards,
Koichiro

> 
> [ ... ]
> 
> drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_cmd_handler() {
>     ...
> 	ctrl = ntb->reg;
> 	command = ctrl->command;
> 	if (!command)
> 		goto reset_handler;
> 	argument = ctrl->argument;
>     ...
> }
> 
> [Severity: High]
> This is a pre-existing issue, but does missing a dma_rmb() between reading
> the command and the argument allow the CPU to fetch a stale argument for a
> newly issued command?
> 
> Since the CPU can reorder reads, can it fetch a stale argument from the
> shared DMA memory? Because the argument is used without bounds checking in
> operations like COMMAND_CONFIGURE_MW, could reading a stale (and potentially
> large) argument cause an out-of-bounds array access (ntb->vpci_mw_phy[argument])
> leading to a kernel panic?
> 
> 
> drivers/pci/endpoint/functions/pci-epf-vntb.c:pci_vntb_probe() {
>     ...
> 	ret = ntb_register_device(&ndev->ntb);
> 	if (ret) {
>     ...
> }
> 
> static struct pci_driver vntb_pci_driver = {
> 	.name           = "pci-vntb",
> 	.id_table       = pci_vntb_table,
> 	.probe          = pci_vntb_probe,
> };
> 
> [Severity: High]
> This is a pre-existing issue, but does vntb_pci_driver lack a .remove callback
> to unregister the NTB device?
> 
> Is the NTB device never unregistered from the NTB core during device teardown?
> If the parent EPF device is unbound and devm-allocated memory is freed, could
> this lead to a use-after-free because ntb_unregister_device() is skipped?
> 
> 
> drivers/pci/endpoint/functions/pci-epf-vntb.c:vpci_scan_bus() {
>     ...
> 	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> 	if (!vpci_bus) {
> 		pr_err("create pci bus failed\n");
> 		return -EINVAL;
> 	}
>     ...
> }
> 
> [Severity: High]
> This is a pre-existing issue, but is the virtual PCI root bus allocated in
> vpci_scan_bus() ever removed?
> 
> Does this lead to a resource leak and use-after-free? When the EPF is unbound,
> it appears pci_remove_root_bus() is never called, which would leave the virtual
> PCI root bus registered with a dangling sysdata pointer.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260904162049.3432464-1-den@valinux.co.jp?part=1
