Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7C5C433DB
	for <linux-pci@archiver.kernel.org>; Fri, 26 Mar 2021 09:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6977161A36
	for <linux-pci@archiver.kernel.org>; Fri, 26 Mar 2021 09:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCZJTB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Mar 2021 05:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhCZJSh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 05:18:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8575861A1A;
        Fri, 26 Mar 2021 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616750317;
        bh=zJKAr/g2rUrR71fZVEi3E4ZExCWuRXs7g4DYUbFszT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tbpdaYyBqjvg1TeYt8KSMcxHqarfLy5uC5HZHAl6UGtbLcCi7k4/mbGRRhlsyWy0d
         milfODmey6IlkxV8qJSC6/QZRtBd8Ixyxqc1iyJyONbwpxuHouBglRFcenmcfpIB1T
         70pm20XQM0gI9plTHdYHb8jNVStU+lXtxrnqWTIY=
Date:   Fri, 26 Mar 2021 10:18:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Allow drivers to claim exclusive access to config
 regions
Message-ID: <YF2m6pjDNGILB4vu@kroah.com>
References: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YFwzw3VK0okr+taA@kroah.com>
 <20210325082904.GA2988566@infradead.org>
 <CAPcyv4jfq7pqvdKinYJ2wSLSNEa0fmOgCGWjTCpwhgTTpGyY=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jfq7pqvdKinYJ2wSLSNEa0fmOgCGWjTCpwhgTTpGyY=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 10:55:01AM -0700, Dan Williams wrote:
> On Thu, Mar 25, 2021 at 1:29 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Mar 25, 2021 at 07:54:59AM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Mar 24, 2021 at 06:23:54PM -0700, Dan Williams wrote:
> > > > The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> > > > configuration cycles. It assumes one initiator at a time is
> > > > reading/writing the data registers.
> > >
> > > That sounds like a horrible protocol for a multi-processor system.
> > > Where is it described and who can we go complain to for creating such a
> > > mess?
> >
> > Indeed.  Dan, is there a way to stilk kill this protocol off before it
> > leaks into the wild?
> 
> Unfortunately I think that opportunity was more than a year ago, and
> there's been a proliferation of derivative protocols building on it
> since.

Doesn't mean it can't be changed, right?

Are there any actual devices that require this?

thanks,

greg k-h
