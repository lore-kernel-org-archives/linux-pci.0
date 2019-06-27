Return-Path: <SRS0=dlGY=U2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C9BC48BD6
	for <linux-pci@archiver.kernel.org>; Thu, 27 Jun 2019 08:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D41C206E0
	for <linux-pci@archiver.kernel.org>; Thu, 27 Jun 2019 08:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfF0IvU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:51:20 -0400
Received: from verein.lst.de ([213.95.11.211]:50729 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0IvU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 04:51:20 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 742B868B20; Thu, 27 Jun 2019 10:50:47 +0200 (CEST)
Date:   Thu, 27 Jun 2019 10:50:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH 11/25] memremap: lift the devmap_enable manipulation
 into devm_memremap_pages
Message-ID: <20190627085047.GA11420@lst.de>
References: <20190626122724.13313-1-hch@lst.de> <20190626122724.13313-12-hch@lst.de> <20190626190445.GE4605@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626190445.GE4605@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 12:04:46PM -0700, Ira Weiny wrote:
> > +static int devmap_managed_enable_get(struct device *dev, struct dev_pagemap *pgmap)
> > +{
> > +	if (!pgmap->ops->page_free) {
> 
> NIT: later on you add the check for pgmap->ops...  it should probably be here.
> 
> But not sure that bisection will be an issue here.

At this point we do not allow a NULL ops pointer.  That only becomes
a valid option one the internal refcount is added.  Until then a NULL
->ops pointer leads to an error return from devm_memremap_pages.
