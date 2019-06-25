Return-Path: <SRS0=yH3J=UY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48600C48BD5
	for <linux-pci@archiver.kernel.org>; Tue, 25 Jun 2019 07:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291A220652
	for <linux-pci@archiver.kernel.org>; Tue, 25 Jun 2019 07:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfFYH3s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:29:48 -0400
Received: from verein.lst.de ([213.95.11.211]:60293 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbfFYH3s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 03:29:48 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0839568B02; Tue, 25 Jun 2019 09:29:16 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:29:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Message-ID: <20190625072915.GD30350@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-19-hch@lst.de> <20190620192648.GI12083@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620192648.GI12083@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 09:26:48PM +0200, Michal Hocko wrote:
> On Thu 13-06-19 11:43:21, Christoph Hellwig wrote:
> > The code hasn't been used since it was added to the tree, and doesn't
> > appear to actually be usable.  Mark it as BROKEN until either a user
> > comes along or we finally give up on it.
> 
> I would go even further and simply remove all the DEVICE_PUBLIC code.

I looked into that as I now got the feedback twice.  It would
create a conflict with another tree cleaning things up around the
is_device_private defintion, but otherwise I'd be glad to just remove
it.

Jason, as this goes through your tree, do you mind the additional
conflict?
