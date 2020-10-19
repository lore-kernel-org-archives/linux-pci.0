Return-Path: <SRS0=4e9O=D2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643DFC43457
	for <linux-pci@archiver.kernel.org>; Mon, 19 Oct 2020 13:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A26222E7
	for <linux-pci@archiver.kernel.org>; Mon, 19 Oct 2020 13:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603113331;
	bh=27msb1S4BcbbJu49vog+yRYGPSReChpwq3Hep2AcYw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qS0YknSi3uOUxQAvXFfKTK9RD6VWqO07DP2CZsBRuOUhrjqQ1Dmlu+Rd5/21r9bAM
	 3W0ZyR91a4iOtfmWmVOHdB7tsipjeHVZ+QDLNVKKyZpS0mAkcxN740hpM95MPLOzDm
	 DmrAN/rTDYcy+EVZ8ZUDBSsxFAFi7tMq0Ez0HlOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgJSNPa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Oct 2020 09:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbgJSNPa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Oct 2020 09:15:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D64922203;
        Mon, 19 Oct 2020 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603113328;
        bh=27msb1S4BcbbJu49vog+yRYGPSReChpwq3Hep2AcYw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXKW4mQMNTJ0xMUuPDRSkJqUEfbMVPTN0bVyIy0I7XYSPzvbXOjE8/BOtM+FHI2y1
         yg2+OmJVV05QxMfL6O4i11oqNmGXTYWhPK65NgVUgX8E8FBQ/lVvGHM4Cm8sCztOA1
         Fzc+jLOBUFLIvzzoAEjKgNxlA56UH33jYCy9KLN4=
Date:   Mon, 19 Oct 2020 15:16:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Allen <allen.lkml@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, ast@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Allen Pais <allen.pais@lkml.com>
Subject: Re: [RFC] PCI: allow sysfs file owner to read the config space with
 CAP_SYS_RAWIO
Message-ID: <20201019131613.GA3254417@kroah.com>
References: <20201016055235.440159-1-allen.lkml@gmail.com>
 <20201016062027.GB569795@kroah.com>
 <CAOMdWSJDJ-uXpis1WbG3LnOG7bMiif5Q4Maafv_a=55Y_qypfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSJDJ-uXpis1WbG3LnOG7bMiif5Q4Maafv_a=55Y_qypfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 06:30:16PM +0530, Allen wrote:
> > >
> > >  Access to pci config space is explictly checked with CAP_SYS_ADMIN
> > > in order to read configuration space past the frist 64B.
> > >
> > >  Since the path is only for reading, could we use CAP_SYS_RAWIO?
> >
> > Why?  What needs this reduced capability?
> 
> Thanks for the review.
> 
> We need read access to /sys/bus/pci/devices/,  We need write access to config,
> remove, rescan & enable files under the device directory for each PCIe
> functions & the downstream PCIe port.
> 
> We need r/w access to sysfs to unbind and rebind the root complex.

That didn't answer my question at all.

Why can't you have the process that wants to do all of the above, have
admin rights as well?  Doing all of that is _very_ low-level and can
cause all sorts of horrible things to happen to your machine, and is not
really "raw io" in the traditional sense at all, right?

greg k-h
