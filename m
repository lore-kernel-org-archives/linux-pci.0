Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021099.outbound.protection.outlook.com [52.101.125.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F8364935
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946482; cv=fail; b=VkO5a++cesa25FU7Z5e2Q9+7gpUQQT/0EUpi0kjXYYckJjn8ahfc4Okm8IBRCNzHAn0KWqcN5lCAuiAyi8Fz15L6LdqhHUM8OHlTxYUuQ0p5Dv6+SOT4/VEIx9mb1M+++pQw6m52UTa2baSz1ruJE5i6+9kManzyhteHk5loxj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946482; c=relaxed/simple;
	bh=qz1JV+teV7EjECtysau0wXvnjBxT3cRepG/wDv6EsGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qMVgs8tUTpW5QkufDuAN3V+Zpt5HC4IVbvnCFEpQPZUL801cQMloecHGR3+Yw7H2IEk6whn2yA8D1r03NWQMp6b9UBF6r/bacamFajHxe9UfTRlAQ0z9Keq9ij5A807fJyg6QVe1R4TBOs+CByCusXWU/YdMpqCn/hhXdjSeGmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Uj22Z0zu reason="signature verification failed"; arc=fail smtp.client-ip=52.101.125.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Uj22Z0zu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlaENunjnUygr3w9ZtYyiIP9MKwl0ZLiLwcIczGQK0xUod/UNRBCZpSRawZ1+VPWEum1GUcCPLw9r5LbdK/cd2gU3JyVoqLyQhNjz6x6sEHULoY7AEkbQUJTh8BcmEefhV+4T3aoVoVGeQ8Ryw3iFeeRnHjcONgkQdFlZWOfGxsg/T1ZOu0t8JhYOEiYrc2cLSGDH9RvE4oXne5cHpZZodKCMZNNbAnIrCRQedubDa6/KvMcZACQu3de/viRCEgS0Yt+83YyZVfewS8eEsnZUvmKXhZDYGYPOBQon7++yRkljA1nIEiTUWdChXFjYaSzBr/Vs82rOapryVCspY6+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6tiLsQkifW+BOcYoiODMhYx/nv80DweWGKDPCkLX+g=;
 b=T/sOo7SNnNBY9Lmf43z6cf4TwKnmOoWhCD5JSyWcqcqxeSYTmJwjknJGWJ/j94HcWGLYH+5AEPNkLDnt8CRzwZ2M6GIZ2knhiAaPQo1+vVjdjHqnlJc9JDpwkkjmWTv2o1kv8qAbImWNVei1kfv2+dLZVXDvbLsgvyAnBtG56Fh9Eq2WMO4xDEnQjlAn5Oh5Md37DDGOY9FpnWFEkdOi3PemQk11I0j/P1D40ZIxYij/J2DkIMkjr+WIkUWMf7O+Kq1YkkdMOGEUuatssjROL7OEQUf52bUTUdaxYshzGM4AgUJCdrtpkVHo2btCi8mv79T2TnuiFUVXYGMV+YSvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6tiLsQkifW+BOcYoiODMhYx/nv80DweWGKDPCkLX+g=;
 b=Uj22Z0zuEH967pyiUkG8ikw+4iufj7G7hhZTLz0pbD47iNaYLRxW+SZdzXcLpktQoYkCV+aDGd3GvXaLN4d1419d8kD4E3D/zxZY2RnTEwAr8hvS3NYwmqO7SH9AXQRAk7Hr6OYMMJXbtoL6b5AJb2r4jRV6X2l5Vdmfb+U2RwA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYRP286MB4374.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 02:54:37 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 02:54:36 +0000
Date: Wed, 14 Oct 2026 11:54:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>, 
	Manivannan Sadhasivam <mani@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Message-ID: <usmuhh27lmvsvdxn3ucmpiujsafrt3nr3hfcjd4ok27s3zrm2m@bl7i4laxmpou>
References: <20260904162049.3432464-1-den@valinux.co.jp>
 <20260904163355.165061F00A3D@smtp.kernel.org>
 <mbwka7qsw3gcphdwgl4wdqb3t4dweujrwvoj3rogxhwrpoorfx@3wdhmvi4lgfg>
 <179190161902.12828.6253963189949078339.b4-reply@b4>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179190161902.12828.6253963189949078339.b4-reply@b4>
X-ClientProxiedBy: TY6PR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYRP286MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 580075cc-8cf1-47b7-f30c-08df299e7bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10070799003|6133799003|10067099003|22082099003|18002099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EguSai73UCFJo9WOyh1SeiuLNyoWNLc9dOy4xwTphi2VI6eFgU8aIkqIHy1Z6OrPoPQJPQIXQblDvU8uwn79RrqfFZgni6LZ6bOLIX135CzmF9ogtPTuY810NNQ1Qb7aEQkE4eHudT4pbGe9q145HzLXv8B3TasCuT441C38K2kVyqnYJYk7IrjG2lHFRmiZK947lrpW2/Ub++hY1M36kDgfshnUYte5b+KJMk7Qt5Q5iIzZ4tYl2j6RgfqjgOFSNFy1OCHICCoFRoXuJ2GRe68yTYxSVzlJaCdfk5bVZ07yzVVuYNlZGqFTLxEAkZizAuL09ADcF0TpTr+jin1+rxZGF6WaH6I86Rv/oilqFfQojYeAG4fmePRmlV+SfpgLMWcH+Wvo7UwGmmatp1oUMBeoXqwiRMqZLGggkuu2JHSVW/VHwhCpMchyLbNKQDWjBQodgGD5eA0TMvt+zn8PY50uSx17qN+dKopHhLZx+Y0DyywfjCSBT9Vz9SV0STxUW0bp3cNEHGjR/2Xs0Ah2BHpeg5QV6MMO69lFKS8Ob8QN7T1GGEXoVb8ZjZk6fsMHBJdpWbMhBxXnKzLQe4GEl5+gesSui0fZOQrjK9M1dGs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10070799003)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?yem/vmlKAJvIGpTOFNJQYZtB1RQYd/pj3X/YVYdTDOVocRgCL+XzGhJdXT?=
 =?iso-8859-1?Q?dWr1DHvYPxH+ajWVPeF6TAC1gl5OWfaCdOkANaYuskrbSBAOgE8+EOcik0?=
 =?iso-8859-1?Q?D+fqFODO7YzAaE7Jr5R2Sd2LAgy+agQ68Xf97lDH2f/CqnUlrxCR8qWTW3?=
 =?iso-8859-1?Q?o1XOayypGFHGJsdTYesxGWMxvLpRhPHb0dfrlghF5e2R9n5fa5cNu0HIsb?=
 =?iso-8859-1?Q?NJHh3bRqAvtz8b5IxmwFubWljfR+s4hFzz9JPUHtQZLGJlyNpaymCqv1h0?=
 =?iso-8859-1?Q?omvjbAg7TI+FwQxWxdmdKttCvxw2bHJCbr8DCG9L9nRR/uzv2NYY0SSh6U?=
 =?iso-8859-1?Q?uTST6VYlXRBAzi/eU/xJJShkk3v4xfAGvrBrc5YOo6CkkEUAr4w8MvNs7n?=
 =?iso-8859-1?Q?CtfJ1TXzbiMkL7DWJoNi2XhuwG8QRGOfyNB6OBMNPXSYUpWx3KJln3PbHg?=
 =?iso-8859-1?Q?OEdNU7JMexqmJuLr/6Abj9H12ygWa+qNLBllsrzdUTY6uBSRIM/VLeddUv?=
 =?iso-8859-1?Q?P8ve1Ea7AVGkFYJxxy0ahzim2ZE+dTjQMXb74V+53jmrzRZsBi4ix6KrEd?=
 =?iso-8859-1?Q?HYFo3Gu8oF2rxzGNNQZArkEYDUgI7qlGzTeHYMuy6N2AZ1DrXx+8tBbKiA?=
 =?iso-8859-1?Q?VQMcnLrMmkO/f/IgmnsC/eLzt2DCvAuB+frMINFBe79qYAyiuCVG2rCv/f?=
 =?iso-8859-1?Q?kPlDzUIxu1zIfe9XkpxoH0/B96gDEOyzNuwOSAs3c2K/+sMgg9Th7PUPRA?=
 =?iso-8859-1?Q?dt+mdSe0kZI51zkz78K/lW44Ywq516FjAkegZKT4QJ1sMr90CwX/9xVqcW?=
 =?iso-8859-1?Q?/V1t5iPPkq3KqlDpxw7AaF7q61mf0EOQfy0E9i/u2KdVwqOgUA4CBGV4nB?=
 =?iso-8859-1?Q?p8d3aVPIyt796qC7lfH6b4+WIgrVWpKX0/v1CgkJxcq0oIq9IOCeFsz/v+?=
 =?iso-8859-1?Q?LFAcEwIVamLh4uiPvPMUZ6UcwydIBfrvqhoBpEwTBG5PlHnqd41ry9Lu4L?=
 =?iso-8859-1?Q?a/oVEyUKQbk0+u9up6MObAyzbKEvR3RFtvpguHGjHHqEjtTb9bhulRRhBn?=
 =?iso-8859-1?Q?vVs0JdSWhP/jsLSZeb1PI9ZOuEQcYgI5uzKzsFPSMtp0ok22O1A0oOEw8d?=
 =?iso-8859-1?Q?HThiH7IBYeQzePG02zQioGedIyJ1+fRThbcc7a3Vg45SiK7I9HQNQkVOqn?=
 =?iso-8859-1?Q?6x0Pzb6yZ0A0Bb0shqU/ybXxNSJT/kemn7NhnnLHnCpq0axxN8qb5riWLQ?=
 =?iso-8859-1?Q?lznoHeJ5wxIcPq5P58joT52Vo7yvlNLesfD4WvbgHJ1YDEIXrVJ1s6GevJ?=
 =?iso-8859-1?Q?bIelW7G5t+K+0y66eICEV5ZgaNSTW48QqYSFznHmQL3vCH3keBQRqw4GbC?=
 =?iso-8859-1?Q?lX8XHxqFLHs/GXKatDNq4AvydEethvyO1TS7SGySPBsUInb6DDmwR/Par3?=
 =?iso-8859-1?Q?heH9mpTfehR8PidvhGcBSQ5eG6XE8UNWRWL86/sMgTq5mbK8d4CB3DceAd?=
 =?iso-8859-1?Q?zu4yUS+zD/cTxt1Vpf/Kvxvo2cZlEdPEgLhcHcifdrc9P0sODtqNad2QyP?=
 =?iso-8859-1?Q?wb9UHhozj5s2jp3VvrNlhW2aAZR3o11s5JDyrjgSt3+oSDld6y0c0EbFtF?=
 =?iso-8859-1?Q?l0CtUrh7pILZAmxkIfAH6jnZ18MwCM3mfH5hjTYMlIoDUbhyzkX/BzYMhq?=
 =?iso-8859-1?Q?PzDqzb08XyjfdHkPiPqo6tydGS2wUP7eldf/seLjLldvFnf5rqR/LCasCe?=
 =?iso-8859-1?Q?Klt7SJRy8HMjd/jr2ggedWco+AShkDmcNsxsOE1LKDaTGp9sAJt4qrdID5?=
 =?iso-8859-1?Q?4jSdhLMR/5oxZaRRZLapT64kKIiq56jztepabRtrnhVNcfPwk8PL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 580075cc-8cf1-47b7-f30c-08df299e7bb2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 02:54:36.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkHofEi+UaKs0DWj0i2oodotlaTYMVK9kVBndIVnfp0Yl7ttMOgSKgGXIlldhhc/D5KcpZggtDU82+weWfgaSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4374

On Tue, Oct 13, 2026 at 07:56:59PM +0530, Manivannan Sadhasivam wrote:
> + Frank
> 
> On 2026-09-05 03:18 +0900, Koichiro Den wrote:
> > On Fri, Sep 04, 2026 at 04:33:54PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> > > 
> > > New issues:
> > > - [High] Internal state is not rolled back if the link notification fails.
> > > 
> > > Pre-existing issues:
> > > - [High] Missing ntb_unregister_device() causes NTB device leak and subsequent Use-After-Free.
> > > - [High] Virtual PCI root bus allocated in vpci_scan_bus() is never removed.
> > > - [High] Missing dma_rmb() between reading `command` and `argument` from the shared DMA memory.
> > > --
> > > 
> > > commit 31e5bb87c3524261d2384c7e27a492debb83840b
> > > Author: Koichiro Den <den@valinux.co.jp>
> > > 
> > >     PCI: endpoint: pci-epf-vntb: Track link state from both sides
> > > 
> > >     The control-region link status is currently updated only by
> > >     COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
> > >     NTB link callbacks are empty. Consequently, the HOST can see the link as
> > >     up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
> > >     leaves LINK_STATUS_UP set without notifying either NTB client.
> > > 
> > > Link: https://lore.kernel.org/r/20260904065335.3059625-1-den@valinux.co.jp/
> > > 
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > index fba65abfb6b21..f921c7c7019aa 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > [ ... ]
> > > > @@ -178,24 +182,57 @@ static struct pci_epf_header epf_ntb_header = {
> > > [ ... ]
> > > >  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> > > >  {
> > > > -	if (link_up)
> > > > -		ntb->reg->link_status |= LINK_STATUS_UP;
> > > > -	else
> > > > -		ntb->reg->link_status &= ~LINK_STATUS_UP;
> > > > +	bool notify;
> > > > +
> > > > +	scoped_guard(mutex, &ntb->link_lock) {
> > > > +		notify = ntb->host_linkup != link_up && ntb->vhost_linkup;
> > > > +		ntb->host_linkup = link_up;
> > > > +		epf_ntb_update_link(ntb);
> > > > +	}
> > > > +
> > > > +	if (notify) {
> > > > +		/* Publish link status before completing the HOST command. */
> > > > +		dma_wmb();
> > > > +		return epf_ntb_notify_link(ntb);
> > > > +	}
> > > 
> > > [Severity: High]
> > > If epf_ntb_notify_link() fails (e.g. failing to raise the MSI IRQ), does the
> > > internal state machine become permanently desynchronized? The effective link
> > > state (host_linkup) is updated in the locked section, but there is no
> > > rollback on failure.
> > > 
> > > When the host retries the command, would notify evaluate to false, skipping
> > > the notification entirely and leaving the event swallowed?
> > 
> > Hm, the concern seems valid to some extent, but I don't think simply rolling
> > back the link state is the right fix. The VHOST client has already received
> > ntb_link_event() by the time raising the MSI IRQ fails.
> > 
> > pci-epf-ntb also keeps the updated state when raising an IRQ fails, but it
> > allows the notification to be retried. This v2 implementation does not, because
> > the local 'notify' variable evaluates to false on the retry. If the first 'echo
> > N > link' fails because the MSI IRQ could not be raised, repeating it succeeds
> > without retrying the notification, unlike pci-epf-ntb.
> > 
> > I think I should make such a retry possible, in line with pci-epf-ntb.
> > If anyone has a better idea, any comments would be appreciated.
> > 
> 
> I'll let Frank comment on it.

Mani, thanks for the mention.

Frank, I thought Sashiko's concern was worth addresing, but I took another look
at the assumption behind her claim:

  > If epf_ntb_notify_link() fails (e.g. failing to raise the MSI IRQ)

AFAICT, in the R-Car/DWC MSI path, the relevant errors appear to be related to
iATU setup, and simply retrying the notification would not necessarily help.
What's worse, the simple retry change [1] can attempt to raise MSI even before
the HOST (ntb_hw_epf) is ready. Turns out avoiding that while supporting retries
would add complexity, and I suspect there would be little to gain.

So I'm planning to send v3 with just the small change I mentioned here:
https://lore.kernel.org/r/y5pfpuk7z6kv42jofihbpluwzadk4iy5hhcd4zhyw7rl5x3t6c@4ie5kekew7dd/

[1]
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -222,7 +222,8 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
        bool notify;

        scoped_guard(mutex, &ntb->link_lock) {
-               notify = ntb->host_linkup != link_up && ntb->vhost_linkup;
+               /* Let a repeated request retry a failed HOST notification. */
+               notify = !link_up || ntb->vhost_linkup;
                ntb->host_linkup = link_up;
                epf_ntb_update_link(ntb);
        }
@@ -1496,7 +1497,8 @@ static int vntb_epf_set_link(struct epf_ntb *ntb, bool link_up)
        bool notify;

        scoped_guard(mutex, &ntb->link_lock) {
-               notify = ntb->vhost_linkup != link_up && ntb->host_linkup;
+               /* Let a repeated request retry a failed HOST notification. */
+               notify = !link_up || ntb->host_linkup;
                ntb->vhost_linkup = link_up;
                epf_ntb_update_link(ntb);
        }


Best regards,
Koichiro Den

> 
> - Mani
> 
> > Best regards,
> > Koichiro
> > 
> > > 
> > > [ ... ]
> > > 
> > > drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_cmd_handler() {
> > >     ...
> > > 	ctrl = ntb->reg;
> > > 	command = ctrl->command;
> > > 	if (!command)
> > > 		goto reset_handler;
> > > 	argument = ctrl->argument;
> > >     ...
> > > }
> > > 
> > > [Severity: High]
> > > This is a pre-existing issue, but does missing a dma_rmb() between reading
> > > the command and the argument allow the CPU to fetch a stale argument for a
> > > newly issued command?
> > > 
> > > Since the CPU can reorder reads, can it fetch a stale argument from the
> > > shared DMA memory? Because the argument is used without bounds checking in
> > > operations like COMMAND_CONFIGURE_MW, could reading a stale (and potentially
> > > large) argument cause an out-of-bounds array access (ntb->vpci_mw_phy[argument])
> > > leading to a kernel panic?
> > > 
> > > 
> > > drivers/pci/endpoint/functions/pci-epf-vntb.c:pci_vntb_probe() {
> > >     ...
> > > 	ret = ntb_register_device(&ndev->ntb);
> > > 	if (ret) {
> > >     ...
> > > }
> > > 
> > > static struct pci_driver vntb_pci_driver = {
> > > 	.name           = "pci-vntb",
> > > 	.id_table       = pci_vntb_table,
> > > 	.probe          = pci_vntb_probe,
> > > };
> > > 
> > > [Severity: High]
> > > This is a pre-existing issue, but does vntb_pci_driver lack a .remove callback
> > > to unregister the NTB device?
> > > 
> > > Is the NTB device never unregistered from the NTB core during device teardown?
> > > If the parent EPF device is unbound and devm-allocated memory is freed, could
> > > this lead to a use-after-free because ntb_unregister_device() is skipped?
> > > 
> > > 
> > > drivers/pci/endpoint/functions/pci-epf-vntb.c:vpci_scan_bus() {
> > >     ...
> > > 	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> > > 	if (!vpci_bus) {
> > > 		pr_err("create pci bus failed\n");
> > > 		return -EINVAL;
> > > 	}
> > >     ...
> > > }
> > > 
> > > [Severity: High]
> > > This is a pre-existing issue, but is the virtual PCI root bus allocated in
> > > vpci_scan_bus() ever removed?
> > > 
> > > Does this lead to a resource leak and use-after-free? When the EPF is unbound,
> > > it appears pci_remove_root_bus() is never called, which would leave the virtual
> > > PCI root bus registered with a dangling sysdata pointer.
> > > 
> > > -- 
> > > Sashiko AI review · https://sashiko.dev/#/patchset/20260904162049.3432464-1-den@valinux.co.jp?part=1
> > 
> > 
> 
> 
