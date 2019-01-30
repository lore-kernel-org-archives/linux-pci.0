Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BDFC282D8
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 17:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B154020869
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 17:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfA3RZX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:25:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:42080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfA3RZW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 12:25:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D773ABD0;
        Wed, 30 Jan 2019 17:25:21 +0000 (UTC)
Date:   Wed, 30 Jan 2019 18:25:20 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 6/7] MIPS: SGI-IP27: use generic PCI driver
Message-Id: <20190130182520.2864ad962605b43f1635e4fd@suse.de>
In-Reply-To: <20190130091706.GA3617@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
        <20190124174728.28812-7-tbogendoerfer@suse.de>
        <20190128133215.GC744@infradead.org>
        <20190129162445.8584b58862068c0a7693718c@suse.de>
        <20190130091706.GA3617@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 30 Jan 2019 01:17:06 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jan 29, 2019 at 04:24:45PM +0100, Thomas Bogendoerfer wrote:
> > > From an abstraction point of view this doesn't really belong into
> > > a bridge driver as it is a global exported function.  I guess we can
> > > keep it here with a fixme comment, but we should probably move this
> > > into a method call instead.
> > 
> > or put the nodeid into the bus struct ?
> 
> Doesn't sound to bad to me, you'll just have to update a fair
> amount of arch implementations.

and it's already there:-) Each struct device has a field numa_node and pci_bus has
contains a struct device. arm64 is already using it only not so nice part is the
usage of pcibios_root_bridge_prepare() to set the numa_node for the root bus.

> > I'm all for it. I looked at the examples for using dma_pfn_offset and the
> > only one coming close to usefull for me is arch/sh/drivers/pci/pcie-sh7786.c
> > It overloads pcibios_bus_add_device() to set dma_pfn_offset, which doesn't
> > look much nicer. What about having a dma_pfn_offset in struct pci_bus
> > which all device inherit from ?
> 
> Or add a add_dev callback, similar to what I did for a previous series
> that we didn't end up needing after all:
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/06d9b4fc7deed336edc1292fe2e661729e98ec39

that's exactly what I'm looking for. Should I add the patch for my patchset or
are you going to submit it after having a use case ?

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
