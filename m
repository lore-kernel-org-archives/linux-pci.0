Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:49032 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbcGLJNg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jul 2016 05:13:36 -0400
Date: Tue, 12 Jul 2016 11:13:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] pci: Provide sensible irq vector alloc/free
	routines
Message-ID: <20160712091334.GB4845@lst.de>
References: <1468151866-7776-1-git-send-email-hch@lst.de> <1468151866-7776-5-git-send-email-hch@lst.de> <20160711114713.GD21169@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160711114713.GD21169@agordeev.lab.eng.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 11, 2016 at 01:47:14PM +0200, Alexander Gordeev wrote:
> Something like this is also needed here:
> 
> 	if (WARN_ON_ONCE(nr >= msi_desc::nvec_used))
> 		return -EINVAL;

Ok, fixed.
