Return-Path: <SRS0=dEyG=UO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1299C46477
	for <linux-pci@archiver.kernel.org>; Sat, 15 Jun 2019 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D0A2184E
	for <linux-pci@archiver.kernel.org>; Sat, 15 Jun 2019 08:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfFOIe0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 15 Jun 2019 04:34:26 -0400
Received: from verein.lst.de ([213.95.11.211]:52416 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFOIe0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Jun 2019 04:34:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 31A9C68AFE; Sat, 15 Jun 2019 10:33:57 +0200 (CEST)
Date:   Sat, 15 Jun 2019 10:33:56 +0200
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: dev_pagemap related cleanups
Message-ID: <20190615083356.GB23406@lst.de>
References: <20190613094326.24093-1-hch@lst.de> <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com> <20190614061333.GC7246@lst.de> <CAPcyv4jmk6OBpXkuwjMn0Ovtv__2LBNMyEOWx9j5LWvWnr8f_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jmk6OBpXkuwjMn0Ovtv__2LBNMyEOWx9j5LWvWnr8f_A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 06:14:45PM -0700, Dan Williams wrote:
> On Thu, Jun 13, 2019 at 11:14 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Jun 13, 2019 at 11:27:39AM -0700, Dan Williams wrote:
> > > It also turns out the nvdimm unit tests crash with this signature on
> > > that branch where base v5.2-rc3 passes:
> >
> > How do you run that test?
> 
> This is the unit test suite that gets kicked off by running "make
> check" from the ndctl source repository. In this case it requires the
> nfit_test set of modules to create a fake nvdimm environment.
> 
> The setup instructions are in the README, but feel free to send me
> branches and I can kick off a test. One of these we'll get around to
> making it automated for patch submissions to the linux-nvdimm mailing
> list.

Oh, now I remember, and that was the bummer as anything requiring modules
just does not fit at all into my normal test flows that just inject
kernel images and use otherwise static images.
