Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A7C04EBD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 14:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52917205C9
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 14:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52917205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJPWot (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:44:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37928 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeJPWot (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 18:44:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADAB8341;
        Tue, 16 Oct 2018 07:54:00 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (unknown [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1620D3F71C;
        Tue, 16 Oct 2018 07:53:57 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:53:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     honghui.zhang@mediatek.com
Cc:     bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        ulf.hansson@linaro.org, marc.zyngier@arm.com,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        youlin.pei@mediatek.com, yt.shen@mediatek.com,
        jianjun.wang@mediatek.com
Subject: Re: [PATCH v9 2/9] PCI: Using PCI configuration space header type
 instead of class type to assign resource
Message-ID: <20181016145355.GB16390@e107981-ln.cambridge.arm.com>
References: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
 <1539686690-24068-3-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539686690-24068-3-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 16, 2018 at 06:44:43PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The PCI configuration space header type defines the layout of the rest
> of the header (PCI r3.0 sec 6.1, PCIe r4.0 sec 7.5.1.1.9) while the
> resource assignment is based on the configuration space layout instead
> of its class type. Using configuration space header type instead of
> class type for the resource assignment.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/pci.c       |  3 +--
>  drivers/pci/probe.c     |  3 ---
>  drivers/pci/setup-bus.c | 20 ++++++++++----------
>  3 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 29ff961..7d379ca 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5908,8 +5908,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  	 * to enable the kernel to reassign new resource
>  	 * window later on.
>  	 */
> -	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
> -	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>  		for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
>  			r = &dev->resource[i];
>  			if (!(r->flags & IORESOURCE_MEM))
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ec78400..29a35c1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1695,9 +1695,6 @@ int pci_setup_device(struct pci_dev *dev)
>  		break;
>  
>  	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
> -		if (class != PCI_CLASS_BRIDGE_PCI)
> -			goto bad;
> -
>  		/*
>  		 * The PCI-to-PCI bridge spec requires that subtractive
>  		 * decoding (i.e. transparent) bridge must have programming
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 79b1824..69f90f4 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -182,7 +182,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
>  	u16 class = dev->class >> 8;
>  
>  	/* Don't touch classless devices or host bridges or ioapics.  */
> -	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
> +	if (class == PCI_CLASS_NOT_DEFINED)

I think this check has been there since the first initial git commit,
whether that's _really_ needed or not in the current kernel it is very
hard to say.

I am not that sure it is safe to remove it, especially given that we are at
-rc8 and close to a release, it would be good if this patch could sit in
next to give it some exposure to testing before merging it upstream.

Lorenzo

>  		return;
>  
>  	/* Don't touch ioapic devices already enabled by firmware */
> @@ -1221,12 +1221,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		if (!b)
>  			continue;
>  
> -		switch (dev->class >> 8) {
> -		case PCI_CLASS_BRIDGE_CARDBUS:
> +		switch (dev->hdr_type) {
> +		case PCI_HEADER_TYPE_CARDBUS:
>  			pci_bus_size_cardbus(b, realloc_head);
>  			break;
>  
> -		case PCI_CLASS_BRIDGE_PCI:
> +		case PCI_HEADER_TYPE_BRIDGE:
>  		default:
>  			__pci_bus_size_bridges(b, realloc_head);
>  			break;
> @@ -1237,12 +1237,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  	if (pci_is_root_bus(bus))
>  		return;
>  
> -	switch (bus->self->class >> 8) {
> -	case PCI_CLASS_BRIDGE_CARDBUS:
> +	switch (bus->self->hdr_type) {
> +	case PCI_HEADER_TYPE_CARDBUS:
>  		/* don't size cardbuses yet. */
>  		break;
>  
> -	case PCI_CLASS_BRIDGE_PCI:
> +	case PCI_HEADER_TYPE_BRIDGE:
>  		pci_bridge_check_ranges(bus);
>  		if (bus->self->is_hotplug_bridge) {
>  			additional_io_size  = pci_hotplug_io_size;
> @@ -1391,13 +1391,13 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
>  
>  		__pci_bus_assign_resources(b, realloc_head, fail_head);
>  
> -		switch (dev->class >> 8) {
> -		case PCI_CLASS_BRIDGE_PCI:
> +		switch (dev->hdr_type) {
> +		case PCI_HEADER_TYPE_BRIDGE:
>  			if (!pci_is_enabled(dev))
>  				pci_setup_bridge(b);
>  			break;
>  
> -		case PCI_CLASS_BRIDGE_CARDBUS:
> +		case PCI_HEADER_TYPE_CARDBUS:
>  			pci_setup_cardbus(b);
>  			break;
>  
> -- 
> 2.6.4
> 
