Return-Path: <SRS0=6jqy=VA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24E0C06513
	for <linux-pci@archiver.kernel.org>; Wed,  3 Jul 2019 18:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7314218B8
	for <linux-pci@archiver.kernel.org>; Wed,  3 Jul 2019 18:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfGCSDL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:03:11 -0400
Received: from verein.lst.de ([213.95.11.211]:53922 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfGCSDL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 14:03:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5C41168B05; Wed,  3 Jul 2019 20:03:08 +0200 (CEST)
Date:   Wed, 3 Jul 2019 20:03:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/22] mm: remove the legacy hmm_pfn_* APIs
Message-ID: <20190703180308.GA13656@lst.de>
References: <20190701062020.19239-1-hch@lst.de> <20190701062020.19239-23-hch@lst.de> <20190703180125.GA18673@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703180125.GA18673@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 03, 2019 at 03:01:25PM -0300, Jason Gunthorpe wrote:
> Christoph, I guess you didn't mean to send this branch to the mailing
> list?
> 
> In any event some of these, like this one, look obvious and I could
> still grab a few for hmm.git.
> 
> Let me know what you'd like please
> 
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks.  I was going to send this series out as soon as you had
applied the previous one.  Now that it leaked I'm happy to collect
reviews.  But while I've got your attention:  the rdma.git hmm
branch is still at the -rc7 merge and doen't have my series, is that
intentional?
