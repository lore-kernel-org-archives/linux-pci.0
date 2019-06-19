Return-Path: <SRS0=+EjW=US=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A7C31E5E
	for <linux-pci@archiver.kernel.org>; Wed, 19 Jun 2019 09:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883412084A
	for <linux-pci@archiver.kernel.org>; Wed, 19 Jun 2019 09:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfFSJlF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:41:05 -0400
Received: from verein.lst.de ([213.95.11.211]:52238 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfFSJlF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 05:41:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5F43068B05; Wed, 19 Jun 2019 11:40:33 +0200 (CEST)
Date:   Wed, 19 Jun 2019 11:40:32 +0200
From:   Christoph Hellwig <hch@lst.de>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dev_pagemap related cleanups v2
Message-ID: <20190619094032.GA8928@lst.de>
References: <20190617122733.22432-1-hch@lst.de> <CAPcyv4hBUJB2RxkDqHkfEGCupDdXfQSrEJmAdhLFwnDOwt8Lig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hBUJB2RxkDqHkfEGCupDdXfQSrEJmAdhLFwnDOwt8Lig@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 12:47:10PM -0700, Dan Williams wrote:
> > Git tree:
> >
> >     git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup.2
> >
> > Gitweb:
> >
> >     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-devmem-cleanup.2

> 
> Attached is my incremental fixups on top of this series, with those
> integrated you can add:

I've folded your incremental bits in and pushed out a new
hmm-devmem-cleanup.3 to the repo above.  Let me know if I didn't mess
up anything else.  I'll wait for a few more comments and Jason's
planned rebase of the hmm branch before reposting.
