Return-Path: <SRS0=4r0Q=UN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173D6C31E44
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jun 2019 06:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49652133D
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jun 2019 06:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfFNGUP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:20:15 -0400
Received: from verein.lst.de ([213.95.11.211]:44309 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfFNGUP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 02:20:15 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4C76A68B02; Fri, 14 Jun 2019 08:19:46 +0200 (CEST)
Date:   Fri, 14 Jun 2019 08:19:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/22] mm: remove hmm_devmem_add_resource
Message-ID: <20190614061946.GE7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-4-hch@lst.de> <20190613185239.GP22062@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613185239.GP22062@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 06:52:44PM +0000, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 11:43:06AM +0200, Christoph Hellwig wrote:
> > This function has never been used since it was first added to the kernel
> > more than a year and a half ago, and if we ever grow a consumer of the
> > MEMORY_DEVICE_PUBLIC infrastructure it can easily use devm_memremap_pages
> > directly now that we've simplified the API for it.
> 
> nit: Have we simplified the interface for devm_memremap_pages() at
> this point, or are you talking about later patches in this series.

After this series.  I've just droped that part of the sentence to
avoid confusion.

> I checked this and all the called functions are exported symbols, so
> there is no blocker for a future driver to call devm_memremap_pages(),
> maybe even with all this boiler plate, in future.
> 
> If we eventually get many users that need some simplified registration
> then we should add a devm_memremap_pages_simplified() interface and
> factor out that code when we can see the pattern.

After this series devm_memremap_pages already is simpler to use than
hmm_device_add_resource was before, so I'm not worried at all.  The
series actually net removes lines from noveau (if only a few).
