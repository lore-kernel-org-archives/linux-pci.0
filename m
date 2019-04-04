Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EBDC4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012AF20882
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554407097;
	bh=GZSurZd+riZ1B6AIq/bj4OzZU1/H+koba2hqmizO6bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZkyZM1UOT/4VUWzITQp3MjYpq7Msy/5p4Acy3aYlVhSMhl/hyann4JuG+ILVfWkZt
	 gCx0KsFmVN73rGmcwP2C8gGiNb1sLyLaa9czo9hCHdkwyGBfoq6ImfJG1dkYlXXhPZ
	 aG/CTOlmJ4d22eM1IGOmOAYxK7t0a1fDzgTKHvk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfDDTo4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfDDTo4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Apr 2019 15:44:56 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E7D2082E;
        Thu,  4 Apr 2019 19:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554407095;
        bh=GZSurZd+riZ1B6AIq/bj4OzZU1/H+koba2hqmizO6bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmbCmQuLkCt1iHBViqm4d+kRIEUGCSF8COAkiHj4PpYpGNla9UIS6tq5OcYALoHI6
         /C/ohCPZ1Wbdk6AtWI0TnhxuMUZ7pbVB7QzpdU6/AGJLJXpIdFDQ1jnaSDqDmpQckU
         Dan7ZLnkHeUAAKNMxXVuifKO2z0qymrckyFjy8bU=
Date:   Thu, 4 Apr 2019 14:44:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linux@yadro.com,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
Message-ID: <20190404194454.GB26522@google.com>
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

Applied to pci/hotplug with Lukas' reviewed-by and stable tag for v5.2,
thanks!

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
> 
