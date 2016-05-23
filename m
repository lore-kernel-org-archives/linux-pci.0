Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56584 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbcEWVwB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 May 2016 17:52:01 -0400
Date: Mon, 23 May 2016 16:51:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] nvme/pci: Enable SR-IOV capabilities
Message-ID: <20160523215157.GB31479@localhost>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <1463521199-16604-2-git-send-email-keith.busch@intel.com>
 <20160523170652.GA12826@localhost>
 <20160523172144.GD17208@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160523172144.GD17208@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 23, 2016 at 01:21:44PM -0400, Keith Busch wrote:
> On Mon, May 23, 2016 at 12:06:52PM -0500, Bjorn Helgaas wrote:
> > I do not subscribe to the belief that every function should have a
> > single exit.  In this case, I think it makes the function much harder
> > to understand than this:
> 
> No problem with multiple exists. 
>  
> >   if (numvfs == 0)
> >     pci_disable_sriov(pdev);
> >     return 0;
> >   }
> > 
> >   return pci_enable_sriov(pdev, numvfs);
> 
> Slight change to the above: pci_enable_sriov returns 0 on success,
> but a driver's .sriov_configure is supposed to return the number of
> VF's successfully configured, so need to return 'numvfs' on success.

Oops, sorry, excuse me while I wipe the egg off my face :)
