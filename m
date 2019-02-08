Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E329C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 19:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2CE21841
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 19:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549655765;
	bh=DzUAS5wYqs+f4XXki4ZIVTEWsh+uQC9Qun1SFwJ2MoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ofNgVpSvhe5encsJh5Px6wmmaFMgzxeO08nE9cYaTLTO/6WxVeUiX9XWzMFLu7XiS
	 xVDy+ZGt7ILVbryH6TJ1hNokk+aIBvzYNJjvGzOoc7yYcHbzOLmRp+EEqvrpKxeCrU
	 sA2Qz+2iLG5xjRfCYnJ+FXnek6gOr8Jmk7aK5DCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfBHT4E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:56:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBHT4E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 14:56:04 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33B4217D8;
        Fri,  8 Feb 2019 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549655763;
        bh=DzUAS5wYqs+f4XXki4ZIVTEWsh+uQC9Qun1SFwJ2MoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LkrL+xkOdfI/sYS58xGqFv2sJ0pky+c/7DQtZ06TH2Y2dp8VaJv2C8H1r+9ZMzntW
         jw7Gn2JqI1ibZXWKv5bHVDpoM07LGoL7qbQy3TKz7iEOxmhNQibEizQ4B6Bzfl5M0l
         a1Y8bXABMr8WQ3ymCuHwnTGGIqpyOQSjw7QC7RWA=
Date:   Fri, 8 Feb 2019 13:56:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Message-ID: <20190208195601.GX7268@google.com>
References: <20190205210701.25387-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205210701.25387-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 05, 2019 at 03:06:56PM -0600, Alexandru Gagniuc wrote:
> According to PCIe 3.0, the presence detect state is a logical OR of
> in-band and out-of-band presence. With this, we'd expect the presence
> state to always be asserted when the link comes up.

Do you have a PCIe 4.0 spec?  I think 5.0 is about to come out, so
it'd be nice to have at least a 4.0 citation (including section
number), if you have one.

> Not all hardware follows this, and it is possible for the presence to
> come up after the link. In this case, the PCIe device would be
> erroneously disabled and re-probed. It is possible to distinguish
> between a delayed presence and a card swap by looking at the DLL state
> changed bit -- The link has to come down if the card is removed.
> 
> Thus, for a device that is probed, present and has its link active, a
> lack of a link state change event guarantees we have the same device,
> and shutdown of is not needed.

s/of is/is/, I guess?

I'm hoping Lukas will chime in here; thanks for cc'ing him already.

> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
> 
> Following some discussion in
> "PCI: hotplug: Erroneous removal of hotplug PCI devices" [1]
> It became apparent that we can't fully rely presence detect changed
> as an indicator to shutdown a device. And in PCIe 4.0 the "logical OR"
> requirement is going away, so we can use a way to slightly  decouple
> presence detect and link active.
> 
> I think the approach here is the simplest, and least likely to
> interfere with other mis-behaving hardware (in the PCIe 3.0 sense).
> 
> [1] https://www.spinics.net/lists/linux-pci/msg79564.html

Would you mind updating this reference to the
https://lore.kernel.org/linux-pci form that doesn't depend on external
organizations?

https://www.kernel.org/lore.html has some details, but unfortunately
lacks a hint about how to construct the URL.  What I do is look up the
Message-ID and use, e.g.,

  https://lore.kernel.org/linux-pci/<Message-ID>

>  drivers/pci/hotplug/pciehp_ctrl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 3f3df4c29f6e..ea0dd3e956be 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -220,13 +220,23 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	/*
>  	 * If the slot is on and presence or link has changed, turn it off.
>  	 * Even if it's occupied again, we cannot assume the card is the same.
> +	 * When the card is swapped, we also expect a change in link state,
> +	 * without which, it's likely presence became high after link-active.
>  	 */
>  	mutex_lock(&ctrl->state_lock);
> +	present = pciehp_card_present(ctrl);
> +	link_active = pciehp_check_link_active(ctrl);
>  	switch (ctrl->state) {
>  	case BLINKINGOFF_STATE:
>  		cancel_delayed_work(&ctrl->button_work);
>  		/* fall through */
>  	case ON_STATE:
> +		if (present && link_active &&
> +		   !(events & PCI_EXP_SLTSTA_DLLSC)) {
> +			mutex_unlock(&ctrl->state_lock);
> +			ctrl_warn(ctrl, "Hardware bug: Presence state came up after link");

I'm not 100% sure this is worth KERN_WARN unless the user might be
able to do something about it.

> +			return;
> +		}
>  		ctrl->state = POWEROFF_STATE;
>  		mutex_unlock(&ctrl->state_lock);
>  		if (events & PCI_EXP_SLTSTA_DLLSC)
> -- 
> 2.19.2
> 
