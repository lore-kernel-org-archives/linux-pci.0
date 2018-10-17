Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94241ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 13:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB3C21526
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 13:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaSyN4EP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB3C21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeJQVSf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeJQVSf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 17:18:35 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B764204EC;
        Wed, 17 Oct 2018 13:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539782573;
        bh=Mzar2STDh7Dj2s7a5xRnWB51uqP2UztLqUQcrCZWAmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaSyN4EPYI/CnACEveuBloWOva4VQYAVX/n2V6/cQdE+vTt11agtcLXWGvOUZEW8Y
         yvhv61iv2KMBcps4Wo7xyahvt9slCXiBzHiCAeY47uBEZ1PiCwvQ10CZoiJsriSRJP
         E8pIq2g0eY3JV3/0DcIy602gYk7x2o2OHKzh/CQY=
Date:   Wed, 17 Oct 2018 08:22:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     honghui.zhang@mediatek.com, youlin.pei@mediatek.com,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        ryder.lee@mediatek.com, marc.zyngier@arm.com,
        linux-pci@vger.kernel.org, jianjun.wang@mediatek.com,
        linux-kernel@vger.kernel.org, yt.shen@mediatek.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        bhelgaas@google.com, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 2/9] PCI: Using PCI configuration space header type
 instead of class type to assign resource
Message-ID: <20181017132251.GG5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
 <1539686690-24068-3-git-send-email-honghui.zhang@mediatek.com>
 <20181016145355.GB16390@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016145355.GB16390@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 16, 2018 at 03:53:55PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Oct 16, 2018 at 06:44:43PM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > The PCI configuration space header type defines the layout of the rest
> > of the header (PCI r3.0 sec 6.1, PCIe r4.0 sec 7.5.1.1.9) while the
> > resource assignment is based on the configuration space layout instead
> > of its class type. Using configuration space header type instead of
> > class type for the resource assignment.
> > 
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/pci.c       |  3 +--
> >  drivers/pci/probe.c     |  3 ---
> >  drivers/pci/setup-bus.c | 20 ++++++++++----------
> >  3 files changed, 11 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 29ff961..7d379ca 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5908,8 +5908,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
> >  	 * to enable the kernel to reassign new resource
> >  	 * window later on.
> >  	 */
> > -	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
> > -	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
> > +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> >  		for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
> >  			r = &dev->resource[i];
> >  			if (!(r->flags & IORESOURCE_MEM))
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index ec78400..29a35c1 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1695,9 +1695,6 @@ int pci_setup_device(struct pci_dev *dev)
> >  		break;
> >  
> >  	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
> > -		if (class != PCI_CLASS_BRIDGE_PCI)
> > -			goto bad;
> > -
> >  		/*
> >  		 * The PCI-to-PCI bridge spec requires that subtractive
> >  		 * decoding (i.e. transparent) bridge must have programming
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 79b1824..69f90f4 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -182,7 +182,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
> >  	u16 class = dev->class >> 8;
> >  
> >  	/* Don't touch classless devices or host bridges or ioapics.  */
> > -	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
> > +	if (class == PCI_CLASS_NOT_DEFINED)
> 
> I think this check has been there since the first initial git commit,
> whether that's _really_ needed or not in the current kernel it is very
> hard to say.
> 
> I am not that sure it is safe to remove it, especially given that we are at
> -rc8 and close to a release, it would be good if this patch could sit in
> next to give it some exposure to testing before merging it upstream.

Yes, you're right; I think I think this is a little too risky at this
point.  I'll pull this patch out and queue it up for the next cycle
(v4.21).

For v4.20, I think you should resurrect the class code patch [1].  That
should be enough to make things work in v4.20, even without this hdr_type
patch.  It will also improve the lspci output, because I think it uses the
class code to look up the generic description, e.g., in this output:

  00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port (rev f1)

I think the "PCI bridge" part is based on the class code.

Bjorn

[1] https://lore.kernel.org/linux-pci/1539590940-13355-3-git-send-email-honghui.zhang@mediatek.com

> >  		return;
> >  
> >  	/* Don't touch ioapic devices already enabled by firmware */
> > @@ -1221,12 +1221,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
> >  		if (!b)
> >  			continue;
> >  
> > -		switch (dev->class >> 8) {
> > -		case PCI_CLASS_BRIDGE_CARDBUS:
> > +		switch (dev->hdr_type) {
> > +		case PCI_HEADER_TYPE_CARDBUS:
> >  			pci_bus_size_cardbus(b, realloc_head);
> >  			break;
> >  
> > -		case PCI_CLASS_BRIDGE_PCI:
> > +		case PCI_HEADER_TYPE_BRIDGE:
> >  		default:
> >  			__pci_bus_size_bridges(b, realloc_head);
> >  			break;
> > @@ -1237,12 +1237,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
> >  	if (pci_is_root_bus(bus))
> >  		return;
> >  
> > -	switch (bus->self->class >> 8) {
> > -	case PCI_CLASS_BRIDGE_CARDBUS:
> > +	switch (bus->self->hdr_type) {
> > +	case PCI_HEADER_TYPE_CARDBUS:
> >  		/* don't size cardbuses yet. */
> >  		break;
> >  
> > -	case PCI_CLASS_BRIDGE_PCI:
> > +	case PCI_HEADER_TYPE_BRIDGE:
> >  		pci_bridge_check_ranges(bus);
> >  		if (bus->self->is_hotplug_bridge) {
> >  			additional_io_size  = pci_hotplug_io_size;
> > @@ -1391,13 +1391,13 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
> >  
> >  		__pci_bus_assign_resources(b, realloc_head, fail_head);
> >  
> > -		switch (dev->class >> 8) {
> > -		case PCI_CLASS_BRIDGE_PCI:
> > +		switch (dev->hdr_type) {
> > +		case PCI_HEADER_TYPE_BRIDGE:
> >  			if (!pci_is_enabled(dev))
> >  				pci_setup_bridge(b);
> >  			break;
> >  
> > -		case PCI_CLASS_BRIDGE_CARDBUS:
> > +		case PCI_HEADER_TYPE_CARDBUS:
> >  			pci_setup_cardbus(b);
> >  			break;
> >  
> > -- 
> > 2.6.4
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
