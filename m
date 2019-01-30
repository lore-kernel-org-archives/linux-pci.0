Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA01C282D8
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 22:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C84E20857
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 22:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbfA3W66 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:58:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbfA3W64 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 17:58:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80C3086671;
        Wed, 30 Jan 2019 22:58:55 +0000 (UTC)
Received: from redhat.com (ovpn-126-0.rdu2.redhat.com [10.10.126.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EACAF608E5;
        Wed, 30 Jan 2019 22:58:51 +0000 (UTC)
Date:   Wed, 30 Jan 2019 17:58:50 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device
 vma
Message-ID: <20190130225849.GJ5061@redhat.com>
References: <db873687-ff80-4758-0b9f-973f27db5335@deltatee.com>
 <20190130201114.GB17915@mellanox.com>
 <20190130204332.GF5061@redhat.com>
 <20190130204954.GI17080@mellanox.com>
 <20190130214525.GG5061@redhat.com>
 <20190130215600.GM17080@mellanox.com>
 <20190130223027.GH5061@redhat.com>
 <20190130223258.GB25486@mellanox.com>
 <20190130224705.GI5061@redhat.com>
 <20190130225148.GC25486@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130225148.GC25486@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 30 Jan 2019 22:58:55 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 10:51:55PM +0000, Jason Gunthorpe wrote:
> On Wed, Jan 30, 2019 at 05:47:05PM -0500, Jerome Glisse wrote:
> > On Wed, Jan 30, 2019 at 10:33:04PM +0000, Jason Gunthorpe wrote:
> > > On Wed, Jan 30, 2019 at 05:30:27PM -0500, Jerome Glisse wrote:
> > > 
> > > > > What is the problem in the HMM mirror that it needs this restriction?
> > > > 
> > > > No restriction at all here. I think i just wasn't understood.
> > > 
> > > Are you are talking about from the exporting side - where the thing
> > > creating the VMA can really only put one distinct object into it?
> > 
> > The message i was trying to get accross is that HMM mirror will
> > always succeed for everything* except for special vma ie mmap of
> > device file. For those it can only succeed if a p2p_map() call
> > succeed.
> > 
> > So any user of HMM mirror might to know why the mirroring fail ie
> > was it because something exceptional is happening ? Or is it because
> > i was trying to map a special vma which can be forbiden.
> > 
> > Hence why i assume that you might want to know about such p2p_map
> > failure at the time you create the umem odp object as it might be
> > some failure you might want to report differently and handle
> > differently. If you do not care about differentiating OOM or
> > exceptional failure from p2p_map failure than you have nothing to
> > worry about you will get the same error from HMM for both.
> 
> I think my hope here was that we could have some kind of 'trial'
> interface where very eary users can call
> 'hmm_mirror_is_maybe_supported(dev, user_ptr, len)' and get a failure
> indication.
> 
> We probably wouldn't call this on the full address space though

Yes we can do special wrapper around the general case that allow
caller to differentiate failure. So at creation you call the
special flavor and get proper distinction between error. Afterward
during normal operation any failure is just treated in a same way
no matter what is the reasons (munmap, mremap, mprotect, ...).


> Beyond that it is just inevitable there can be problems faulting if
> the memory map is messed with after MR is created.
> 
> And here again, I don't want to worry about any particular VMA
> boundaries..

You do not have to worry about boundaries HMM will return -EFAULT
if there is no valid vma behind the address you are trying to map
(or if the vma prot does not allow you to access it). So then you
can handle that failure just like you do now and as my ODP HMM
patch preserve.

Cheers,
Jérôme
