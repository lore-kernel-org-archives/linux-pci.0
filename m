Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52252 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbcFKBOy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 21:14:54 -0400
Date: Fri, 10 Jun 2016 20:14:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, pjw@netapp.com, axboe@fb.com,
	keith.busch@intel.com, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free routines
Message-ID: <20160611011449.GJ16462@localhost>
References: <20160511074527.GA31347@agordeev.lab.eng.brq.redhat.com>
 <20160511085049.GA20279@lst.de>
 <20160511094432.GB31347@agordeev.lab.eng.brq.redhat.com>
 <20160512073552.GA4027@lst.de>
 <20160512094432.GA14671@agordeev.lab.eng.brq.redhat.com>
 <20160512110318.GA9192@lst.de>
 <20160512121155.GB8681@agordeev.lab.eng.brq.redhat.com>
 <20160512121933.GA11084@lst.de>
 <20160512142902.GA14166@lst.de>
 <20160513082947.GB14671@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160513082947.GB14671@agordeev.lab.eng.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 13, 2016 at 10:29:48AM +0200, Alexander Gordeev wrote:
> On Thu, May 12, 2016 at 04:29:02PM +0200, Christoph Hellwig wrote:
> > Alexander, what do you think about the version below?  Survived
> > quick testing with nvme so far.
> 
> Hi Christoph,
> 
> Please find my comments below. Sorry in advance if missed something -
> an incremental patch is bit difficult to review.

...

Hi Christoph,

Where are we at with this?  Did I miss a newer version?

Bjorn
