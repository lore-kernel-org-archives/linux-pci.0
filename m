Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAF7C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 15:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429BF2085A
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfCRPNk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:13:40 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:43279 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfCRPNk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 11:13:40 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A47E0300002BA;
        Mon, 18 Mar 2019 16:13:37 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 71EFE326A5; Mon, 18 Mar 2019 16:13:37 +0100 (CET)
Date:   Mon, 18 Mar 2019 16:13:37 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linux@yadro.com
Subject: Re: [PATCH] PCI: pciehp: Don't wait for Command Completed if this
 interrupt is disabled
Message-ID: <20190318151337.f53xmhb372bwbhbc@wunner.de>
References: <20190318143129.6640-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318143129.6640-1-s.miroshnichenko@yadro.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 18, 2019 at 05:31:29PM +0300, Sergey Miroshnichenko wrote:
> pcie_init() invokes pcie_disable_notification() for empty slots, which in
> turn disables the Command Complete interrupt (unset PCI_EXP_SLTCTL_CCIE)
> and right after that waits for Command Complete event (PCI_EXP_SLTSTA_CC).
> 
> This results in longer boot time - 4 seconds of delay for each empty slot:
> 
> [    4.200325] pciehp 0042:04:08.0:pcie204: Slot #40 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
> [    4.200607] pciehp 0042:04:08.0:pcie204: pciehp_get_power_status: SLOTCTRL 80 value read 1c0
> [    6.217938] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x01c0 (issued 2020 msec ago)
> [    6.217966] pciehp 0042:04:08.0:pcie204: pcie_disable_notification: SLOTCTRL 80 write cmd 0
> [    6.237938] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x01c0 (issued 2040 msec ago)
> [    8.257939] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x05c0 (issued 2020 msec ago)
> [    8.257974] pciehp 0042:04:08.0:pcie204: pciehp_power_off_slot: SLOTCTRL 80 write cmd 400
> [    8.258034] pci_bus 0042:07: dev 00, created physical slot 40
> [    8.277941] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x05c0 (issued 2040 msec ago)
> [    8.277967] pciehp 0042:04:08.0:pcie204: pcie_enable_notification: SLOTCTRL 80 write cmd 1031

Those "Timeout on hotplug command" messages look suspicious.  The port
claims to support Command Completed Events, but doesn't seem to set the
Command Completed bit in the Slot Status register.  Ultimately that's
the reason for the delays you're seeing.

We already have quirks for various Intel and Qualcomm ports with broken
Command Completed support (see at the bottom of pciehp_hpc.c) and we
know that older Thunderbolt chips erroneously claim to support Command
Completed Events but in reality don't support it (see quirk in pcie_init()).
Maybe the hardware you're dealing with needs such a quirk as well?

Thanks,

Lukas

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 6a2365cd794e..eec5d6107360 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -118,8 +118,10 @@ static void pcie_wait_cmd(struct controller *ctrl)
>  	if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
>  	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
>  		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
> -	else
> +	else if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
>  		rc = pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
> +	else
> +		return;
>  
>  	if (!rc)
>  		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec ago)\n",
> -- 
> 2.20.1
> 
