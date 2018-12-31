Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA96C43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 21:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E057218A4
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 21:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546293112;
	bh=lfK3GxwgUiKaWzacXZIra3yuRYiusEdxckeGdrEwxI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=clZFTdzwqd7rgAliloj5Eq3FjKCpvfwd2Emijp5nUG67gY7Z3PI48iP/MhxJXC0mL
	 hq+/+nrqrTmsPoDgK1h9Xt8kCg4y60p/tfkjP9IP4wcwx9RsR4OpFWPbzEJIZK1mwx
	 nt8ga/6S/7/a0hWN9I9BcjK9xRp1J9JeKOEVKIwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeLaVvv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:51:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeLaVvv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 16:51:51 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C11620B1F;
        Mon, 31 Dec 2018 21:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546293110;
        bh=lfK3GxwgUiKaWzacXZIra3yuRYiusEdxckeGdrEwxI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+AfmnbrfZEMvigZu9mMS4iHWbqtAAFzZYEKHIxfM9NHffGC20+e++aOPRwQEcbl4
         ttqTpKGd+WUCT/Kt1JeTGFtKe/3RMAeGT1b4VxmP/o9lGjXwVuwpzHNcpDJ/F2NIlq
         EmxXiZfeW2CYhr2FTBPatacp7F7m44Wwdk+YqbQo=
Date:   Mon, 31 Dec 2018 15:51:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 2/2] nvme pci: try to allocate multiple irq vectors again
 in case of -EINVAL
Message-ID: <20181231215147.GH159477@google.com>
References: <20181226103755.2101-1-ming.lei@redhat.com>
 <20181226103755.2101-3-ming.lei@redhat.com>
 <20181226182027.GA5866@lst.de>
 <20181227082136.GA14423@ming.t460p>
 <20181227130834.GA22967@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227130834.GA22967@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 27, 2018 at 02:08:34PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 27, 2018 at 04:21:38PM +0800, Ming Lei wrote:
> > On Wed, Dec 26, 2018 at 07:20:27PM +0100, Christoph Hellwig wrote:
> > > On Wed, Dec 26, 2018 at 06:37:55PM +0800, Ming Lei wrote:
> > > > It is observed on QEMU that pci_alloc_irq_vectors_affinity() may
> > > > returns -EINVAL when the requested number is too big(such as 64).
> > > 
> > > Which is not how this API is supposed to work and documented to work.
> > > 
> > > We need to fix pci_alloc_irq_vectors_affinity to not return a spurious
> > > error and just return the allocated number of vectors instead of
> > > hacking around that in drivers.
> > 
> > Yeah, you are right.
> > 
> > The issue is that QEMU nvme-pci is MSIX-capable only, and hasn't MSI
> > capability.
> > 
> > __pci_enable_msix_range() actually returns -ENOSPC, but __pci_enable_msi_range()
> > returns -EINVAL because dev->msi_cap is zero.
> > 
> > Maybe we need the following fix?
> 
> Should it matter?  We still get a negative vecs back, and still fall
> back to the next option.  

I'm not sure how it matters either, since
pci_alloc_irq_vectors_affinity() will fail either way.  It *would* be
nice to return the correct error in case the caller uses it to emit a
message.

But if the caller wants to use -ENOSPC to reduce @min_vecs and try
again, that sounds like an incorrect use of the interface -- the
caller should have just used the smaller @min_vecs the first time
around.

> Unless ther are no irqs available at all
> for the selected types pci_alloc_irq_vectors_affinity should never
> return an error.

I don't quite understand this last sentence.  If @min_vecs == 5 and
the device only supports 4 MSI-X and 4 MSI vectors, the function
comment says we should fail with -ENOSPC.

Bjorn
