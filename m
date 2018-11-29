Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3183C07E85
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 17:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B402146D
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 17:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eosdVTlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B402146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbeK3EmE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:42:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbeK3EmE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 23:42:04 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 715762145D;
        Thu, 29 Nov 2018 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543512955;
        bh=45zONuEEIypRmhWIQjwcM10CFq021tG7aO2mMTvw5jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eosdVTlw8gNwbr7Llcv7GeuA69npxTMQ5PbHCkMUvDcFoyaD189v5XVQumT/zdC8z
         VW59ZUrgnb8Lngyl3UC0uQqV8y4qscsA0PCGvHfnpyGi4TlSIplw1sziL2WL0eL2pI
         C5LLgRq+BEEpCF7PdLnr7Vjne72vbr98KDv01Kxs=
Date:   Thu, 29 Nov 2018 11:35:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Report degraded links via link bandwidth
 notification
Message-ID: <20181129173553.GD178809@google.com>
References: <20181129000829.14751-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129000829.14751-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 28, 2018 at 06:08:24PM -0600, Alexandru Gagniuc wrote:
> A warning is generated when a PCIe device is probed with a degraded
> link, but there was no similar mechanism to warn when the link becomes
> degraded after probing. The Link Bandwidth Notification provides this
> mechanism.
> 
> Use the link bandwidth notification interrupt to detect bandwidth
> changes, and rescan the bandwidth, looking for the weakest point. This
> is the same logic used in probe().

I like the concept of this.  What I don't like is the fact that it's
tied to pciehp, since I don't think the concept of Link Bandwidth
Notification is related to hotplug.  So I think we'll only notice this
for ports that support hotplug.  Maybe it's worth doing it this way
anyway, even if it could be generalized in the future?

> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 35 +++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 7dd443aea5a5..834672000b59 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -515,7 +515,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	struct controller *ctrl = (struct controller *)dev_id;
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	struct device *parent = pdev->dev.parent;
> -	u16 status, events;
> +	struct pci_dev *endpoint;
> +	u16 status, events, link_status;
>  
>  	/*
>  	 * Interrupts only occur in D3hot or shallower and only if enabled
> @@ -525,6 +526,17 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
>  		return IRQ_NONE;
>  
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status);
> +
> +	if (link_status & PCI_EXP_LNKSTA_LBMS) {
> +		if (pdev->subordinate && pdev->subordinate->self)
> +			endpoint = pdev->subordinate->self;
> +		else
> +			endpoint = pdev;
> +		__pcie_print_link_status(endpoint, false);
> +		pcie_capability_write_word(pdev, PCI_EXP_LNKSTA, link_status);
> +	}
> +
>  	/*
>  	 * Keep the port accessible by holding a runtime PM ref on its parent.
>  	 * Defer resume of the parent to the IRQ thread if it's suspended.
> @@ -677,6 +689,24 @@ static int pciehp_poll(void *data)
>  	return 0;
>  }
>  
> +static bool pcie_link_bandwidth_notification_supported(struct controller *ctrl)
> +{
> +	int ret;
> +	u32 cap;
> +
> +	ret = pcie_capability_read_dword(ctrl_dev(ctrl), PCI_EXP_LNKCAP, &cap);
> +	return (ret == PCIBIOS_SUCCESSFUL) && (cap & PCI_EXP_LNKCAP_LBNC);
> +}
> +
> +static void pcie_enable_link_bandwidth_notification(struct controller *ctrl)
> +{
> +	u16 lnk_ctl;
> +
> +	pcie_capability_read_word(ctrl_dev(ctrl), PCI_EXP_LNKCTL, &lnk_ctl);
> +	lnk_ctl |= PCI_EXP_LNKCTL_LBMIE;
> +	pcie_capability_write_word(ctrl_dev(ctrl), PCI_EXP_LNKCTL, lnk_ctl);
> +}
> +
>  static void pcie_enable_notification(struct controller *ctrl)
>  {
>  	u16 cmd, mask;
> @@ -713,6 +743,9 @@ static void pcie_enable_notification(struct controller *ctrl)
>  	pcie_write_cmd_nowait(ctrl, cmd, mask);
>  	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
> +
> +	if (pcie_link_bandwidth_notification_supported(ctrl))
> +		pcie_enable_link_bandwidth_notification(ctrl);
>  }
>  
>  static void pcie_disable_notification(struct controller *ctrl)
> -- 
> 2.17.1
> 
