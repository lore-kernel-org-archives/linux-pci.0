Return-Path: <SRS0=Jbu+=RI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED68EC43381
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 11:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA5320684
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 11:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfCELBh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:01:37 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:60953 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfCELBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Mar 2019 06:01:36 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id D4B87100D9408;
        Tue,  5 Mar 2019 12:01:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8C7402E789; Tue,  5 Mar 2019 12:01:34 +0100 (CET)
Date:   Tue, 5 Mar 2019 12:01:34 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linux@yadro.com
Subject: Re: [PATCH] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
Message-ID: <20190305110134.drw4hb7h2eruewkp@wunner.de>
References: <20190301161251.26774-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301161251.26774-1-s.miroshnichenko@yadro.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 01, 2019 at 07:12:51PM +0300, Sergey Miroshnichenko wrote:
> During the safe removal procedure, a Data Link Layer State Changed event
> may occur after pciehp_power_off_slot(), and it is handled when the slot is
> already set to OFF_STATE. This results in re-enabling the device and makes
> it impossible to actually safely remove it.
> 
> Add a check for a Presence Detect Changed bit to filter out this interrupt.
> 
> It is still possible to re-enable the device if it remains in the slot
> after pressing the Attention Button by pressing it again.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 3f3df4c29f6e..941f77b71df4 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -251,6 +251,14 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  		return;
>  	}
>  
> +	/* Handle the DLLSC from the slot which just has been turned off */
> +	if ((events & PCI_EXP_SLTSTA_DLLSC) &&
> +	    !(events & PCI_EXP_SLTSTA_PDC) &&
> +	    present && !link_active) {
> +		mutex_unlock(&ctrl->state_lock);
> +		return;
> +	}
> +
>  	switch (ctrl->state) {
>  	case BLINKINGON_STATE:
>  		cancel_delayed_work(&ctrl->button_work);

Hm, I'd instead prefer amending remove_board() like this:

 	if (POWER_CTRL(ctrl)) {
 		pciehp_power_off_slot(ctrl);
 
 		/*
 		 * After turning power off, we must wait for at least 1 second
 		 * before taking any action that relies on power having been
 		 * removed from the slot/adapter.
 		 */
 		msleep(1000);
 
+		/* ignore link or presence changes caused by power off */
+		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
+			   &ctrl->pending_events);
 	}

Would this work for you?

Thanks,

Lukas
