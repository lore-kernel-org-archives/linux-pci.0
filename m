Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AC7C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 16:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0BE21550
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 16:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0BE21550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390529AbeIUVzD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:55:03 -0400
Received: from verein.lst.de ([213.95.11.211]:38913 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbeIUVzC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 17:55:02 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AB0BC68CF4; Fri, 21 Sep 2018 18:05:33 +0200 (CEST)
Date:   Fri, 21 Sep 2018 18:05:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v6 01/13] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180921160533.GA26601@lst.de>
References: <20180913001156.4115-1-logang@deltatee.com> <20180913001156.4115-2-logang@deltatee.com> <20180920223829.GD224714@bhelgaas-glaptop.roam.corp.google.com> <ab733346-9518-ed68-492d-e52929586293@deltatee.com> <20180921130010.GE224714@bhelgaas-glaptop.roam.corp.google.com> <a7e2b2cb-ea35-0a97-498b-1f5753e406aa@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e2b2cb-ea35-0a97-498b-1f5753e406aa@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 21, 2018 at 09:37:33AM -0600, Logan Gunthorpe wrote:
> On 2018-09-21 7:00 AM, Bjorn Helgaas wrote:
> > On Thu, Sep 20, 2018 at 04:47:49PM -0600, Logan Gunthorpe wrote:
> >> On 2018-09-20 4:38 PM, Bjorn Helgaas wrote:
> >>>> +#define pr_fmt(fmt) "pci-p2pdma: " fmt
> >>>
> >>> Is pr_fmt() actually used anywhere?
> >>
> >> It's used in a Patch 4 to print errors in the configfs helpers.
> > 
> > Ideally pr_fmt() would be added in the same patch that uses it, but
> > obviously pretty trivial.
> 
> Hmm, well Christoph asked me to do it this way. ;)

Sorry.  I somehow was under the impression we already had a printk
in the earlier patch, but it looks like I was confused.
