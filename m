Return-Path: <SRS0=4r0Q=UN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E079C31E4C
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jun 2019 06:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502B62133D
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jun 2019 06:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbfFNGjz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:39:55 -0400
Received: from verein.lst.de ([213.95.11.211]:44467 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfFNGjz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 02:39:55 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D92E768B02; Fri, 14 Jun 2019 08:39:26 +0200 (CEST)
Date:   Fri, 14 Jun 2019 08:39:26 +0200
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
Subject: Re: [PATCH 17/22] mm: remove hmm_devmem_add
Message-ID: <20190614063926.GL7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-18-hch@lst.de> <20190613194239.GX22062@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613194239.GX22062@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 07:42:43PM +0000, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2019 at 11:43:20AM +0200, Christoph Hellwig wrote:
> > There isn't really much value add in the hmm_devmem_add wrapper.  Just
> > factor out a little helper to find the resource, and otherwise let the
> > driver implement the dev_pagemap_ops directly.
> 
> Was this commit message written when other patches were squashed in
> here? I think the helper this mentions was from an earlier patch

Yes, it was written before a lot of bits were split out.  I've updated
it for the next version.
