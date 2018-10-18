Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1DFECDE3D
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 01:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD02204FD
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 01:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD02204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeJRJYD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:24:03 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:42897 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726673AbeJRJYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Oct 2018 05:24:02 -0400
X-UUID: e53af6b4d2774edd9642ab5af7340b6c-20181018
X-UUID: e53af6b4d2774edd9642ab5af7340b6c-20181018
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 883320070; Thu, 18 Oct 2018 09:25:14 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 18 Oct
 2018 09:25:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Oct 2018 09:25:12 +0800
Message-ID: <1539825912.11281.8.camel@mhfsdcap03>
Subject: Re: [PATCH v9 2/9] PCI: Using PCI configuration space header type
 instead of class type to assign resource
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <youlin.pei@mediatek.com>, <devicetree@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <ryder.lee@mediatek.com>,
        <marc.zyngier@arm.com>, <linux-pci@vger.kernel.org>,
        <jianjun.wang@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <yt.shen@mediatek.com>, <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <bhelgaas@google.com>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 18 Oct 2018 09:25:12 +0800
In-Reply-To: <20181017132251.GG5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
         <1539686690-24068-3-git-send-email-honghui.zhang@mediatek.com>
         <20181016145355.GB16390@e107981-ln.cambridge.arm.com>
         <20181017132251.GG5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2018-10-17 at 08:22 -0500, Bjorn Helgaas wrote:
> On Tue, Oct 16, 2018 at 03:53:55PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Oct 16, 2018 at 06:44:43PM +0800, honghui.zhang@mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > The PCI configuration space header type defines the layout of the rest
> > > of the header (PCI r3.0 sec 6.1, PCIe r4.0 sec 7.5.1.1.9) while the
> > > resource assignment is based on the configuration space layout instead
> > > of its class type. Using configuration space header type instead of
> > > class type for the resource assignment.
> > > 
> > > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > > ---
> > >  drivers/pci/pci.c       |  3 +--
> > >  drivers/pci/probe.c     |  3 ---
> > >  drivers/pci/setup-bus.c | 20 ++++++++++----------
> > >  3 files changed, 11 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 29ff961..7d379ca 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5908,8 +5908,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
> > >  	 * to enable the kernel to reassign new resource
> > >  	 * window later on.
> > >  	 */
> > > -	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
> > > -	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
> > > +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> > >  		for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
> > >  			r = &dev->resource[i];
> > >  			if (!(r->flags & IORESOURCE_MEM))
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index ec78400..29a35c1 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -1695,9 +1695,6 @@ int pci_setup_device(struct pci_dev *dev)
> > >  		break;
> > >  
> > >  	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
> > > -		if (class != PCI_CLASS_BRIDGE_PCI)
> > > -			goto bad;
> > > -
> > >  		/*
> > >  		 * The PCI-to-PCI bridge spec requires that subtractive
> > >  		 * decoding (i.e. transparent) bridge must have programming
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 79b1824..69f90f4 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -182,7 +182,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
> > >  	u16 class = dev->class >> 8;
> > >  
> > >  	/* Don't touch classless devices or host bridges or ioapics.  */
> > > -	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
> > > +	if (class == PCI_CLASS_NOT_DEFINED)
> > 
> > I think this check has been there since the first initial git commit,
> > whether that's _really_ needed or not in the current kernel it is very
> > hard to say.
> > 
> > I am not that sure it is safe to remove it, especially given that we are at
> > -rc8 and close to a release, it would be good if this patch could sit in
> > next to give it some exposure to testing before merging it upstream.
> 

I'm not sure why the first version has take care of
PCI_CLASS_BRIDGE_HOST separately, I have no idea whether there's some
host bridge device that has their resource fixed.

I agree that this patch should be hold for the moment since I have it
tested only in Mediatek's platform.

Thanks

> Yes, you're right; I think I think this is a little too risky at this
> point.  I'll pull this patch out and queue it up for the next cycle
> (v4.21).

Thanks, I will follow up this patch.

> 
> For v4.20, I think you should resurrect the class code patch [1].  That
> should be enough to make things work in v4.20, even without this hdr_type
> patch.  It will also improve the lspci output, because I think it uses the
> class code to look up the generic description, e.g., in this output:
> 
>   00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port (rev f1)
> 
> I think the "PCI bridge" part is based on the class code.
> 
> Bjorn
> 
> [1] https://lore.kernel.org/linux-pci/1539590940-13355-3-git-send-email-honghui.zhang@mediatek.com
> 
> > >  		return;
> > >  
> > >  	/* Don't touch ioapic devices already enabled by firmware */
> > > @@ -1221,12 +1221,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
> > >  		if (!b)
> > >  			continue;
> > >  
> > > -		switch (dev->class >> 8) {
> > > -		case PCI_CLASS_BRIDGE_CARDBUS:
> > > +		switch (dev->hdr_type) {
> > > +		case PCI_HEADER_TYPE_CARDBUS:
> > >  			pci_bus_size_cardbus(b, realloc_head);
> > >  			break;
> > >  
> > > -		case PCI_CLASS_BRIDGE_PCI:
> > > +		case PCI_HEADER_TYPE_BRIDGE:
> > >  		default:
> > >  			__pci_bus_size_bridges(b, realloc_head);
> > >  			break;
> > > @@ -1237,12 +1237,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
> > >  	if (pci_is_root_bus(bus))
> > >  		return;
> > >  
> > > -	switch (bus->self->class >> 8) {
> > > -	case PCI_CLASS_BRIDGE_CARDBUS:
> > > +	switch (bus->self->hdr_type) {
> > > +	case PCI_HEADER_TYPE_CARDBUS:
> > >  		/* don't size cardbuses yet. */
> > >  		break;
> > >  
> > > -	case PCI_CLASS_BRIDGE_PCI:
> > > +	case PCI_HEADER_TYPE_BRIDGE:
> > >  		pci_bridge_check_ranges(bus);
> > >  		if (bus->self->is_hotplug_bridge) {
> > >  			additional_io_size  = pci_hotplug_io_size;
> > > @@ -1391,13 +1391,13 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
> > >  
> > >  		__pci_bus_assign_resources(b, realloc_head, fail_head);
> > >  
> > > -		switch (dev->class >> 8) {
> > > -		case PCI_CLASS_BRIDGE_PCI:
> > > +		switch (dev->hdr_type) {
> > > +		case PCI_HEADER_TYPE_BRIDGE:
> > >  			if (!pci_is_enabled(dev))
> > >  				pci_setup_bridge(b);
> > >  			break;
> > >  
> > > -		case PCI_CLASS_BRIDGE_CARDBUS:
> > > +		case PCI_HEADER_TYPE_CARDBUS:
> > >  			pci_setup_cardbus(b);
> > >  			break;
> > >  
> > > -- 
> > > 2.6.4
> > > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


