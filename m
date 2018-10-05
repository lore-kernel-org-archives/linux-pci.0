Return-Path: <SRS0=s+SA=MR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC624C65BA7
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 07:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF872084D
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 07:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF872084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeJEOEp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:04:45 -0400
Received: from verein.lst.de ([213.95.11.211]:59168 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeJEOEn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Oct 2018 10:04:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2F99B67357; Fri,  5 Oct 2018 09:07:20 +0200 (CEST)
Date:   Fri, 5 Oct 2018 09:07:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH v9 13/13] nvmet: Optionally use PCI P2P memory
Message-ID: <20181005070720.GA23725@lst.de>
References: <20181004212747.6301-1-logang@deltatee.com> <20181004212747.6301-14-logang@deltatee.com> <a3af4bda-0b73-c964-c7d6-5d59f0710768@grimberg.me> <2bcc0927-83ab-1bf2-d584-aebd5274cefa@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bcc0927-83ab-1bf2-d584-aebd5274cefa@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 04, 2018 at 04:29:19PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2018-10-04 4:20 p.m., Sagi Grimberg wrote:
> >> +static inline struct device *nvmet_ns_dev(struct nvmet_ns *ns)
> >> +{
> >> +	return disk_to_dev(ns->bdev->bd_disk);
> >> +}
> > 
> > This needs to handle non bdev namespaces.
> 
> As it's coded now the helper never gets called unless ns->bdev is not
> null. But in general, yes you are right, we should probably return NULL
> if ns->bdev is NULL.

I'd rather skip that for now.

> > index ef286b72d958..3d12f5f4568d 100644
> > --- a/drivers/nvme/target/fc.c
> > +++ b/drivers/nvme/target/fc.c
> > @@ -2280,6 +2280,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport 
> > *tgtport,
> >          fod->req.cmd = &fod->cmdiubuf.sqe;
> >          fod->req.rsp = &fod->rspiubuf.cqe;
> >          fod->req.port = tgtport->pe->port;
> > +       fod->req.p2p_client = tgtport->dev;
> > 
> >          /* clear any response payload */
> >          memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
> > --
> 
> Sure, I guess that makes sense. I've never tried it with fc hardware but
> I assume there's no reason it wouldn't work.
> 
> I'll queue these changes up for a v10.

And I'd wait until someone has actually tested this case.
