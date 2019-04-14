Return-Path: <SRS0=uRTt=SQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33D9C10F13
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 19:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDEF2084D
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 19:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfDNTgn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:36:43 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:45815 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfDNTgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 15:36:43 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 75F613000034F;
        Sun, 14 Apr 2019 21:36:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3BEA2305022; Sun, 14 Apr 2019 21:36:41 +0200 (CEST)
Date:   Sun, 14 Apr 2019 21:36:41 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Spencer Lingard <spencer@mellanox.com>
Cc:     linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] PCI: pciehp: Fix false command timeouts on boot
Message-ID: <20190414193641.xo7yf4uqh7ci7lci@wunner.de>
References: <1554919668-24873-1-git-send-email-spencer@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554919668-24873-1-git-send-email-spencer@mellanox.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc += Mika, Sergey, Keith]

On Wed, Apr 10, 2019 at 02:07:48PM -0400, Spencer Lingard wrote:
> During command writes, pcie_poll_cmd() is invoked if
> Command Completed notifications are disabled. When polling,
> if Command Completed is set, the bit is reset and success is returned,
> but ctrl->cmd_busy is not set back to 0. The next command write
> then attempts to wait on a command that has already been completed,
> timing out after 2 seconds. This delay occurs more frequently at
> boot time, since pcie_init() disables notifications when powering
> down empty slots.
> 
> Clear cmd_busy upon successful command completion during
> pcie_poll_cmd().
> 
> Signed-off-by: Spencer Lingard <spencer@mellanox.com>

I suppose this can happen if a write to the Slot Control register is
performed while HPIE and/or CCIE is disabled, the two notifications
are subsequently enabled and another write to the Slot Control is
performed.  That second write will then call wait_event_timeout()
because of the stale ctrl->cmd_busy == 1, but the Command Complete
notification has already happened and was cleared by pcie_poll_cmd(),
hence it times out.

Sounds reasonable, I'm a little suprised though that I've never seen
this myself.  I guess we've been doing this wrong for years, so:

Cc: stable@vger.kernel.org
Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 6a2365c..28c70cf 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -77,6 +77,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  		if (slot_status & PCI_EXP_SLTSTA_CC) {
>  			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
>  						   PCI_EXP_SLTSTA_CC);
> +			ctrl->cmd_busy = 0;
>  			return 1;
>  		}
>  		if (timeout < 0)
> -- 
> 2.1.2
