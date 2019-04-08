Return-Path: <SRS0=/7fE=SK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C114C10F13
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 19:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1122148E
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 19:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554753344;
	bh=vrVQMQtDItC7AKO7ZEP7o7Rl5poEAU7Qn0z2olgZoqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N8OrrFDUc+TBukqN63K+Or810RdYy/S68q9Vz7LgIcm0/NnysEAFPfdsCg6YVCSxs
	 ZhioiFOWpMXjIeuLafjcg8rEaiEWgwN2QxeIw4Thva1SGQQsm4LaUeM7Ow0oWcQsGN
	 fhX630qhGlJYWpfKDEYMNY/eF7ajgGKtyuWPkxX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDHTzn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfDHTzm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Apr 2019 15:55:42 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7040720880;
        Mon,  8 Apr 2019 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554753341;
        bh=vrVQMQtDItC7AKO7ZEP7o7Rl5poEAU7Qn0z2olgZoqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INmGqxcve9lPf242NwQ474sMCfOFZ5weEA732HPIN7tWByWlc6yUbmxCIB4GmqLjl
         JbqfSDI8VjnHJCqrOnpQ4DEld6KI3NR+kS0sbpaloDl2ehE6fohtyTH6gHgLuofR+8
         nC6bxEznmFC6sz7VLsBeWz/DSY0e73lbDiQKjp5A=
Date:   Mon, 8 Apr 2019 14:55:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linux@yadro.com,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
Message-ID: <20190408195540.GF159318@google.com>
References: <20190312120548.31875-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312120548.31875-1-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> Cc: Lukas Wunner <lukas@wunner.de>
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

I did apply this and I'm told that it fixes an issue where pressing an
NVMe drive power button does not turn off the drive.

But I wonder if it would be feasible to just turn off reporting of the
events we don't care about, as opposed to figuring out that we should
ignore them if they do occur.  E.g., maybe when we write
PCI_EXP_SLTCTL_PWR_OFF, we should clear PCI_EXP_SLTCTL_DLLSCE and
PCI_EXP_SLTCTL_PDCE at the same time.  Of course, then we'd have to clear
any pending events and re-enable them later.

It's somewhat non-obvious that we ignore these events by clearing out
bits in pending_events that might have been set somewhere else (I
assume by pciehp_isr()) and will be consumed in a third place (maybe
pciehp_ist()?)

Bjorn
