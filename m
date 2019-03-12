Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17916C43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 12:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C3120883
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 12:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCLMUR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:20:17 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:56897 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLMUR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2019 08:20:17 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D7A232800B3C8;
        Tue, 12 Mar 2019 13:20:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9206F2CBBDF; Tue, 12 Mar 2019 13:20:14 +0100 (CET)
Date:   Tue, 12 Mar 2019 13:20:14 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linux@yadro.com
Subject: Re: [PATCH v2] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
Message-ID: <20190312122014.jrwgnqpuiywb7xsd@wunner.de>
References: <20190312120548.31875-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312120548.31875-1-s.miroshnichenko@yadro.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 12, 2019 at 03:05:48PM +0300, Sergey Miroshnichenko wrote:
> During the safe removal procedure, a Data Link Layer State Changed event
> may occur after pciehp_power_off_slot(), and it is handled when the slot is
> already set to OFF_STATE. This results in re-enabling the device and makes
> it impossible to actually safely remove it.
> 
> Clear out the Presence Detect Changed and Data Link Layer State Changed
> events when the disabled slot has settled down.
> 
> It is still possible to re-enable the device if it remains in the slot
> after pressing the Attention Button by pressing it again.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Did this work correctly before v4.19 or is it a regression caused by
d331710ea78f ("PCI: pciehp: Become resilient to missed events")?
Either way, it seems reasonable to backport it to stable and
v4.19 is the earliest that it should apply cleanly to, so:

Cc: stable@vger.kernel.org # v4.19+

Thanks a lot for catching this, I wasn't able to test the code paths
which are only exercised if a power controller is present (because
Thunderbolt doesn't have one).

Lukas

> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 3f3df4c29f6e..905282a8ddaa 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -115,6 +115,10 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
>  		 * removed from the slot/adapter.
>  		 */
>  		msleep(1000);
> +
> +		/* Ignore link or presence changes caused by power off */
> +		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
> +			   &ctrl->pending_events);
>  	}
>  
>  	/* turn off Green LED */
> -- 
> 2.20.1
