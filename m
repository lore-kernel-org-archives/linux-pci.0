Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B9C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 15:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D885218AC
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 15:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfA2PYu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:24:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:55602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfA2PYu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 10:24:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E1A3ADBC;
        Tue, 29 Jan 2019 15:24:47 +0000 (UTC)
Date:   Tue, 29 Jan 2019 16:24:45 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 6/7] MIPS: SGI-IP27: use generic PCI driver
Message-Id: <20190129162445.8584b58862068c0a7693718c@suse.de>
In-Reply-To: <20190128133215.GC744@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
        <20190124174728.28812-7-tbogendoerfer@suse.de>
        <20190128133215.GC744@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 28 Jan 2019 05:32:15 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> > +#ifdef CONFIG_NUMA
> > +int pcibus_to_node(struct pci_bus *bus)
> > +{
> > +	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
> > +
> > +	return bc->nasid;
> > +}
> > +EXPORT_SYMBOL(pcibus_to_node);
> > +#endif /* CONFIG_NUMA */
> 
> From an abstraction point of view this doesn't really belong into
> a bridge driver as it is a global exported function.  I guess we can
> keep it here with a fixme comment, but we should probably move this
> into a method call instead.

or put the nodeid into the bus struct ?

> > +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct bridge_controller *bc = BRIDGE_CONTROLLER(pdev->bus);
> > +
> > +	return bc->baddr + paddr;
> > +}
> > +
> > +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
> > +{
> > +	return dma_addr & ~(0xffUL << 56);
> > +}
> 
> Similarly here - these are global platform-wide hooks, so having them
> in a pci bridge driver is not the proper abstraction level.
> 
> Note that we could probably fix these by just switching IP27 and
> other users of the bridge chip to use the dma_pfn_offset field
> in struct device and stop overriding these functions.

I'm all for it. I looked at the examples for using dma_pfn_offset and the
only one coming close to usefull for me is arch/sh/drivers/pci/pcie-sh7786.c
It overloads pcibios_bus_add_device() to set dma_pfn_offset, which doesn't
look much nicer. What about having a dma_pfn_offset in struct pci_bus
which all device inherit from ?

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
