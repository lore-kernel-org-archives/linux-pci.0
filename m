Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58503 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933505AbcKIPLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2016 10:11:38 -0500
Date: Wed, 9 Nov 2016 16:09:00 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: support for partial irq affinity assignment V3
In-Reply-To: <20161109151027.GA25267@infradead.org>
Message-ID: <alpine.DEB.2.20.1611091608220.3501@nanos>
References: <1478654107-7384-1-git-send-email-hch@lst.de> <f5270fd9-488f-a954-ba3c-1f7800820731@kernel.dk> <alpine.DEB.2.20.1611090849450.3501@nanos> <20161109151027.GA25267@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 9 Nov 2016, Christoph Hellwig wrote:
> On Wed, Nov 09, 2016 at 08:51:35AM +0100, Thomas Gleixner wrote:
> > It's available from
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-block
> > 
> > for you to pull into the block tree so you can apply the block changes.
> 
> I don't actually need them in the block tree, but in the SCSI tree..
> So the block tree is a bad place for this, that's why I initially
> wanted you to pick it up.  But thinking about it the SCSI tree might
> a better idea as we could avoid a non-bisectability with that.

Right.
 
> I'll coordinate it with Jens and Martin and we'll leave you off the
> hook.  Thanks for all the help!

You're welcome!

       tglx
 
