Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF4EC07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 04:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A536020672
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 04:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A536020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeLKELY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 23:11:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbeLKELY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 23:11:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4112458E2E;
        Tue, 11 Dec 2018 04:11:24 +0000 (UTC)
Received: from redhat.com (ovpn-120-187.rdu2.redhat.com [10.10.120.187])
        by smtp.corp.redhat.com (Postfix) with SMTP id DB3F6608F2;
        Tue, 11 Dec 2018 04:11:22 +0000 (UTC)
Date:   Mon, 10 Dec 2018 23:11:22 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     xuyandong <xuyandong2@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] pci: avoid bridge feature re-probing on hotplug
Message-ID: <20181210231038-mutt-send-email-mst@kernel.org>
References: <20181211021617.24072-1-mst@redhat.com>
 <7CECC2DFC21538489F72729DF5EFB4D908AC796C@DGGEMM501-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CECC2DFC21538489F72729DF5EFB4D908AC796C@DGGEMM501-MBX.china.huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 11 Dec 2018 04:11:24 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 11, 2018 at 02:45:44AM +0000, xuyandong wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Tuesday, December 11, 2018 10:19 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: xuyandong <xuyandong2@huawei.com>; stable@vger.kernel.org; Yinghai
> > Lu <yinghai@kernel.org>; Jesse Barnes <jbarnes@virtuousgeek.org>; Bjorn
> > Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org
> > Subject: [PATCH] pci: avoid bridge feature re-probing on hotplug
> > 
> > commit 1f82de10d6 ("PCI/x86: don't assume prefetchable ranges are
> > 64bit") added probing of bridge support for 64 bit memory each time bridge is
> > re-enumerated.
> > 
> > Unfortunately this probing is destructive if any device behind the bridge is in
> > use at this time.
> > 
> > There's no real need to re-probe the bridge features as the regiters in question
> > never change - detect that using the memory flag being set and skip the
> > probing.
> > Avoiding repeated calls to pci_bridge_check_ranges might be even nicer would
> > be a bigger patch and probably not appropriate on stable.
> > 
> > Reported-by: xuyandong <xuyandong2@huawei.com>
> > Cc: stable@vger.kernel.org
> > Cc: Yinghai Lu <yinghai@kernel.org>
> > Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Tested-by: xuyandong <xuyandong2@huawei.com>

Bjorn could you queue this for this release?

> > ---
> > 
> > This issue has been reported on upstream Linux and Centos.
> > 
> >  drivers/pci/setup-bus.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c index
> > ed960436df5e..7ab42f76579e 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -741,6 +741,13 @@ static void pci_bridge_check_ranges(struct pci_bus
> > *bus)
> >  	struct resource *b_res;
> > 
> >  	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
> > +
> > +	/* Don't re-check after this was called once already:
> > +	 * important since bridge might be in use.
> > +	 */
> > +	if (b_res[1].flags & IORESOURCE_MEM)
> > +		return;
> > +
> >  	b_res[1].flags |= IORESOURCE_MEM;
> > 
> >  	pci_read_config_word(bridge, PCI_IO_BASE, &io);
> > --
> > MST
