Return-Path: <SRS0=4r0Q=UN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A8EC31E44
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jun 2019 06:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817BB208CA
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jun 2019 06:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfFNGnn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:43:43 -0400
Received: from verein.lst.de ([213.95.11.211]:44484 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNGnn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 02:43:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D916768B02; Fri, 14 Jun 2019 08:43:13 +0200 (CEST)
Date:   Fri, 14 Jun 2019 08:43:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Message-ID: <20190614064313.GM7246@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-19-hch@lst.de> <20190613194430.GY22062@mellanox.com> <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com> <20190613195819.GA22062@mellanox.com> <20190614004314.GD783@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614004314.GD783@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 05:43:15PM -0700, Ira Weiny wrote:
> <sigh>  yes but the earlier patch:
> 
> [PATCH 03/22] mm: remove hmm_devmem_add_resource
> 
> Removes the only place type is set to MEMORY_DEVICE_PUBLIC.
> 
> So I think it is ok.  Frankly I was wondering if we should remove the public
> type altogether but conceptually it seems ok.  But I don't see any users of it
> so...  should we get rid of it in the code rather than turning the config off?

That was my original idea.  But then again Jerome spent a lot of effort
putting hooks for it all over the mm and it would seem a little root
to just rip this out ASAP.  I'll give it some more time, but it it doesn't
get used after a few more kernel releases we should nuke it.
