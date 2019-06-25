Return-Path: <SRS0=yH3J=UY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56C9C48BD4
	for <linux-pci@archiver.kernel.org>; Tue, 25 Jun 2019 11:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AB6215EA
	for <linux-pci@archiver.kernel.org>; Tue, 25 Jun 2019 11:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfFYL7y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:59:54 -0400
Received: from verein.lst.de ([213.95.11.211]:34177 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfFYL7y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 07:59:54 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D3FF468B05; Tue, 25 Jun 2019 13:59:21 +0200 (CEST)
Date:   Tue, 25 Jun 2019 13:59:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Message-ID: <20190625115921.GA3874@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-19-hch@lst.de> <20190620192648.GI12083@dhcp22.suse.cz> <20190625072915.GD30350@lst.de> <20190625114422.GA3118@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625114422.GA3118@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 11:44:28AM +0000, Jason Gunthorpe wrote:
> Which tree and what does the resolution look like?

Looks like in -mm.  The current commit in linux-next is:

commit 0d23b042f26955fb35721817beb98ba7f1d9ed9f
Author: Robin Murphy <robin.murphy@arm.com>
Date:   Fri Jun 14 10:42:14 2019 +1000

    mm: clean up is_device_*_page() definitions


> Also, I don't want to be making the decision if we should keep/remove
> DEVICE_PUBLIC, so let's get an Ack from Andrew/etc?
> 
> My main reluctance is that I know there is HW out there that can do
> coherent, and I want to believe they are coming with patches, just
> too slowly. But I'd also rather those people defend themselves :P

Lets keep everything as-is for now.  I'm pretty certain nothing
will show up, but letting this linger another release or two
shouldn't be much of a problem.  And if we urgently feel like removing
it we can do it after -rc1.
