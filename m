Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD1CC43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9E3213A2
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 16:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9E3213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeK3DMX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:12:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:2359 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbeK3DMX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 22:12:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 08:06:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="94065035"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 29 Nov 2018 08:06:26 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 29 Nov 2018 18:06:26 +0200
Date:   Thu, 29 Nov 2018 18:06:25 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@dell.com, lukas@wunner.de,
        Sinan Kaya <okaya@codeaurora.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Report degraded links via link bandwidth
 notification
Message-ID: <20181129160625.GC3078@lahna.fi.intel.com>
References: <20181129000829.14751-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129000829.14751-1-mr.nuke.me@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alexandru,

On Wed, Nov 28, 2018 at 06:08:24PM -0600, Alexandru Gagniuc wrote:
> A warning is generated when a PCIe device is probed with a degraded
> link, but there was no similar mechanism to warn when the link becomes
> degraded after probing. The Link Bandwidth Notification provides this
> mechanism.
> 
> Use the link bandwidth notification interrupt to detect bandwidth
> changes, and rescan the bandwidth, looking for the weakest point. This
> is the same logic used in probe().
> 
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

Looks better if you write them in opposite order (reverse xmas-tree):

	u16 status, events, link_status;
	struct pci_dev *endpoint;

>  	/*
>  	 * Interrupts only occur in D3hot or shallower and only if enabled
> @@ -525,6 +526,17 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
>  		return IRQ_NONE;
>  
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status);
> +

Unnecessary empty line.

> +	if (link_status & PCI_EXP_LNKSTA_LBMS) {
> +		if (pdev->subordinate && pdev->subordinate->self)
> +			endpoint = pdev->subordinate->self;

Hmm, I thought pdev->subordinate->self == pdev, no?

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

Do we ever need to disable it?

>  }
>  
>  static void pcie_disable_notification(struct controller *ctrl)
> -- 
> 2.17.1
