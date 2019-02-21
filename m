Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA41EC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 07:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB6C2147A
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 07:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbfBUHgh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:36:37 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:33933 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfBUHgg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 02:36:36 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7625130000CC0;
        Thu, 21 Feb 2019 08:36:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 529EB326AD; Thu, 21 Feb 2019 08:36:34 +0100 (CET)
Date:   Thu, 21 Feb 2019 08:36:34 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/4] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20190221073634.snvazxlzgvjhilaz@wunner.de>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
 <20190220012031.10741-3-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220012031.10741-3-mr.nuke.me@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 19, 2019 at 07:20:28PM -0600, Alexandru Gagniuc wrote:
> @@ -213,6 +213,21 @@ void pciehp_handle_disable_request(struct controller *ctrl)
>  	ctrl->request_result = pciehp_disable_slot(ctrl, SAFE_REMOVAL);
>  }
>  
> +static bool is_delayed_presence_up_event(struct controller *ctrl, u32 events)
> +{
> +	bool present, link_active;
> +
> +	if (!ctrl->inband_presence_disabled)
> +		return false;
> +
> +	present = pciehp_card_present(ctrl);
> +	link_active = pciehp_check_link_active(ctrl);
> +
> +	if (!present || !link_active || events & PCI_EXP_SLTSTA_DLLSC)
> +		return false;
> +
> +	return true;
> +}
>  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)

Newline please after the closing curly brace.


> @@ -220,13 +235,22 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	/*
>  	 * If the slot is on and presence or link has changed, turn it off.
>  	 * Even if it's occupied again, we cannot assume the card is the same.
> +	 * When the card is swapped, we also expect a change in link state,
> +	 * without which, it's likely presence became high after link-active.
>  	 */

Maybe it's just me but I find the code comment difficult to understand.
How about something along the lines of:

 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
 	 * Even if it's occupied again, we cannot assume the card is the same.
+	 *
+	 * An exception is a delayed "Card present" after a "Link Up".
+	 * This can happen on controllers with in-band presence disabled,
+	 * PCIe r5.0 sec X.Y.Z.
 	 */


>  	mutex_lock(&ctrl->state_lock);
> +	present = pciehp_card_present(ctrl);
> +	link_active = pciehp_check_link_active(ctrl);
>  	switch (ctrl->state) {

These two assignments appear to be superfluous as you're also performing
them in pciehp_check_link_active().

Thanks,

Lukas
