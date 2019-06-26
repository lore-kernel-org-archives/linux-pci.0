Return-Path: <SRS0=+zKV=UZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D617AC48BD6
	for <linux-pci@archiver.kernel.org>; Wed, 26 Jun 2019 18:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A755920663
	for <linux-pci@archiver.kernel.org>; Wed, 26 Jun 2019 18:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZSty (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:49:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:23583 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZSty (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 14:49:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 11:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="164046367"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2019 11:49:53 -0700
Date:   Wed, 26 Jun 2019 11:49:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 04/25] mm: remove MEMORY_DEVICE_PUBLIC support
Message-ID: <20190626184953.GC4605@iweiny-DESK2.sc.intel.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-5-hch@lst.de>
 <CAPcyv4gTOf+EWzSGrFrh2GrTZt5HVR=e+xicUKEpiy57px8J+w@mail.gmail.com>
 <20190626171445.GA4605@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626171445.GA4605@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 10:14:45AM -0700, 'Ira Weiny' wrote:
> On Wed, Jun 26, 2019 at 09:00:47AM -0700, Dan Williams wrote:
> > [ add Ira ]
> > 
> > On Wed, Jun 26, 2019 at 5:27 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > The code hasn't been used since it was added to the tree, and doesn't
> > > appear to actually be usable.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > [..]
> > > diff --git a/mm/swap.c b/mm/swap.c
> > > index 7ede3eddc12a..83107410d29f 100644
> > > --- a/mm/swap.c
> > > +++ b/mm/swap.c
> > > @@ -740,17 +740,6 @@ void release_pages(struct page **pages, int nr)
> > >                 if (is_huge_zero_page(page))
> > >                         continue;
> > >
> > > -               /* Device public page can not be huge page */
> > > -               if (is_device_public_page(page)) {
> > > -                       if (locked_pgdat) {
> > > -                               spin_unlock_irqrestore(&locked_pgdat->lru_lock,
> > > -                                                      flags);
> > > -                               locked_pgdat = NULL;
> > > -                       }
> > > -                       put_devmap_managed_page(page);
> > > -                       continue;
> > > -               }
> > > -
> > 
> > This collides with Ira's bug fix [1]. The MEMORY_DEVICE_FSDAX case
> > needs this to be converted to be independent of "public" pages.
> > Perhaps it should be pulled out of -mm and incorporated in this
> > series.
> > 
> > [1]: https://lore.kernel.org/lkml/20190605214922.17684-1-ira.weiny@intel.com/
> 
> Agreed and Andrew picked the first 2 versions of it, mmotm commits:
> 
> 3eed114b5b6b mm-swap-fix-release_pages-when-releasing-devmap-pages-v2
> 9b7d8d0f572f mm/swap.c: fix release_pages() when releasing devmap pages
> 
> I don't see v3 but there were no objections...

Ok somehow I can't fetch mmotm right now...

Dan had and updated mmotm tree and it does have my v4 patch.

Does anyone else have issues with git://git.cmpxchg.org/linux-mmotm.git or is
it just me?  FWIW I have checked proxies etc... and can get to linus and other
sites just fine, so it looks like an issue there.  Although the web page is
fine...

Sorry,
Ira

