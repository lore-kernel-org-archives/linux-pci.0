Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19286C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 07:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D3020838
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 07:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfBUHTt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:19:49 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:59349 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfBUHTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 02:19:48 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 845DF100DA1B1;
        Thu, 21 Feb 2019 08:19:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3896BCC6BB; Thu, 21 Feb 2019 08:19:46 +0100 (CET)
Date:   Thu, 21 Feb 2019 08:19:46 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/4] PCI: hotplug: Add support for disabling
 in-band presence
Message-ID: <20190221071946.poqwdilfijpafhvb@wunner.de>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
 <20190220012031.10741-2-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220012031.10741-2-mr.nuke.me@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 19, 2019 at 07:20:27PM -0600, Alexandru Gagniuc wrote:
> @@ -846,6 +846,9 @@ struct controller *pcie_init(struct pcie_device *dev)
>  	if (pdev->is_thunderbolt)
>  		slot_cap |= PCI_EXP_SLTCAP_NCCS;
>  
> +	if (pdev->no_in_band_presence)
> +		ctrl->inband_presence_disabled = 1;
> +
>  	ctrl->slot_cap = slot_cap;
>  	mutex_init(&ctrl->ctrl_lock);
>  	mutex_init(&ctrl->state_lock);

The above hunk belongs in patch 4.


> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -413,6 +413,7 @@ struct pci_dev {
>  	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
>  	unsigned int	is_probed:1;		/* Device probing in progress */
>  	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
> +	unsigned int	no_in_band_presence:1;	/* Device does not report in-band presence */
>  	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */

Same here.

Thanks,

Lukas
