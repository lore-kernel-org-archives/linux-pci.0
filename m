Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7501C43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 14:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2EC20859
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 14:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbfAPOWj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:22:39 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:58669 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387494AbfAPOWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jan 2019 09:22:39 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id EA663280074F4;
        Wed, 16 Jan 2019 15:22:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A3F255B1C; Wed, 16 Jan 2019 15:22:35 +0100 (CET)
Date:   Wed, 16 Jan 2019 15:22:35 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        john.garry@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH] PCI: hotplug: Fix surprise removal report card
 present and link failed
Message-ID: <20190116142235.6drd6avwk3e7rtwd@wunner.de>
References: <1547649064-19019-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547649064-19019-1-git-send-email-liudongdong3@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc += Mika]

On Wed, Jan 16, 2019 at 10:31:04PM +0800, Dongdong Liu wrote:
> The lspci -tv topology is as below.
>  +-[0000:80]-+-00.0-[81]----00.0  Huawei Technologies Co., Ltd. Device 3714
>  |           +-02.0-[82]----00.0  Huawei Technologies Co., Ltd. Device 3714
>  |           +-04.0-[83]----00.0  Huawei Technologies Co., Ltd. Device 3714
>  |           +-06.0-[84]----00.0  Huawei Technologies Co., Ltd. Device 3714
>  |           +-10.0-[87]----00.0  Huawei Technologies Co., Ltd. Device 3714
> 
> Then surprise removal 87:00.0 NVME SSD card. The message is as below.
> 
> pciehp 0000:80:10.0:pcie004: Slot(36): Link Down
> iommu: Removing device 0000:87:00.0 from group 12
> pciehp 0000:80:10.0:pcie004: Slot(36): Card present
> pcieport 0000:80:10.0: Data Link Layer Link Active not set in 1000 msec
> pciehp 0000:80:10.0:pcie004: Failed to check link status

What is the problem that you're trying to fix?  That these messages
are logged?  Or is there a bigger issue?  If the only problem are the
messages, then I feel that the current behavior is a feature, not a bug.
We could probably tone down the "Failed to check link status" message's
severity.  (Currently it's KERN_ERR, all the other messages are KERN_INFO.)


> The NVME SSD card is permited to surprise removal with slot power on
> on the D06 board. The hotplug port's POWER_CTRL(ctrl) is false.

I don't quite follow:  Does the hotplug port have a Power Controller but
misrepresents that fact in the Slot Capabilities register?


> Data link layer state changed (link down) event reported prior to presence
> detect changed (card is not present) when surprise removal.

It's normal that PDS and DLLSC events are received in varying order and with
significant delays.  (I've seen 244 msec once with Thunderbolt between
PDS- and DLLSC-.)


> Current code pciehp_handle_presence_or_link_change() handle link down event,
> then check the card present, but at this time presence detect state have
> not updated, so have such issue. If surprise removal and power controller
> present is not implemented, wait for at least 1 second before checking
> card present to fix the issue.

Thunderbolt doesn't have a Power Controller either and this change would
imply that if Thunderbolt devices are quickly swapped, bringing up the
replaced device would take longer than it takes now.  So I'm not really
happy about this change.

Thanks,

Lukas

> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 3f3df4c..ef8952d 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -216,6 +216,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
>  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  {
>  	bool present, link_active;
> +	bool safe_removal = SAFE_REMOVAL;
>  
>  	/*
>  	 * If the slot is on and presence or link has changed, turn it off.
> @@ -236,6 +237,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>  				  slot_name(ctrl));
>  		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
> +		safe_removal = SURPRISE_REMOVAL;
>  		break;
>  	default:
>  		mutex_unlock(&ctrl->state_lock);
> @@ -244,6 +246,15 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  
>  	/* Turn the slot on if it's occupied or link is up */
>  	mutex_lock(&ctrl->state_lock);
> +	/*
> +	 * if surprise removal and power controller present is not implemented,
> +	 * wait for at least 1 second before checking card present as
> +	 * data link layer state changed (link down) event reported
> +	 * prior to presence detect changed (card is not present).
> +	 */
> +	if (!safe_removal && !POWER_CTRL(ctrl))
> +		msleep(1000);
> +
>  	present = pciehp_card_present(ctrl);
>  	link_active = pciehp_check_link_active(ctrl);
>  	if (!present && !link_active) {
> -- 
> 1.9.1
