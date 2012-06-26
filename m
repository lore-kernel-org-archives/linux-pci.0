Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:57105 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788Ab2FZB0N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2012 21:26:13 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A77AC3EE0BB
	for <linux-pci@vger.kernel.org>; Tue, 26 Jun 2012 10:26:11 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8944B45DE56
	for <linux-pci@vger.kernel.org>; Tue, 26 Jun 2012 10:26:11 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6EE1A45DE50
	for <linux-pci@vger.kernel.org>; Tue, 26 Jun 2012 10:26:11 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 135B7E78002
	for <linux-pci@vger.kernel.org>; Tue, 26 Jun 2012 10:26:11 +0900 (JST)
Received: from g01jpexchyt01.g01.fujitsu.local (g01jpexchyt01.g01.fujitsu.local [10.128.194.40])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id B2F3E1DB803E
	for <linux-pci@vger.kernel.org>; Tue, 26 Jun 2012 10:26:10 +0900 (JST)
From: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
Date: Tue, 26 Jun 2012 01:26:10 +0000
Message-ID: <4A338DB2991D2A44B9A44B8718AECF650A41F453@G01JPEXMBYT03>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
 <1340437325-29282-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1340437325-29282-3-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org
> [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of Yinghai Lu
> Sent: Saturday, June 23, 2012 4:42 PM
> To: Bjorn Helgaas
> Cc: linux-pci@vger.kernel.org; Yinghai Lu
> Subject: [PATCH 2/5] pciehp: Don't enable presence notification while
> surprise removal is not supported.
> 
> If surprise removal is not supported, that event get dropped later.
> So there is no point to enable that.

Presence changed event is currently just for printing a kernel message when
surprise removal is not supported, and I think the message is not so important.
So I agree this change.

Acked-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

> 
> Also some sick chipset have those bit flip around when the card is not
> present.
> and make log full of useless warning.

Is there any other way to avoid this issue other than disabling presence
changed notification? If we need enabling presence changed event in the
future, this will happen again. I'm worrying about this.

Regards,
Kenji Kaneshige


> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c
> b/drivers/pci/hotplug/pciehp_hpc.c
> index a960fae..d4fa705 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -808,7 +808,7 @@ int pciehp_get_cur_lnk_width(struct slot *slot,
> 
>  int pcie_enable_notification(struct controller *ctrl)
>  {
> -	u16 cmd, mask;
> +	u16 cmd = 0, mask;
> 
>  	/*
>  	 * TBD: Power fault detected software notification support.
> @@ -820,7 +820,8 @@ int pcie_enable_notification(struct controller *ctrl)
>  	 * when it is cleared in the interrupt service routine, and
>  	 * next power fault detected interrupt was notified again.
>  	 */
> -	cmd = PCI_EXP_SLTCTL_PDCE;
> +	if (HP_SUPR_RM(ctrl))
> +		cmd |= PCI_EXP_SLTCTL_PDCE;
>  	if (ATTN_BUTTN(ctrl))
>  		cmd |= PCI_EXP_SLTCTL_ABPE;
>  	if (MRL_SENS(ctrl))
> --
> 1.7.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
