Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755007AbdC3VwH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Mar 2017 17:52:07 -0400
Date: Thu, 30 Mar 2017 16:52:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        darcari@redhat.com, mstowe@redhat.com, bhelgaas@google.com,
        lukas@wunner.de, keith.busch@intel.com,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH] pci: Only disable MSI/X and enable INTx if shutdown
 function has been called
Message-ID: <20170330215203.GC28207@bhelgaas-glaptop.roam.corp.google.com>
References: <1485457667-791-1-git-send-email-prarit@redhat.com>
 <20170309215718.GC19517@bhelgaas-glaptop.roam.corp.google.com>
 <58C29C80.8040904@redhat.com>
 <58DCF310.7000001@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <58DCF310.7000001@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 30, 2017 at 07:59:12AM -0400, Prarit Bhargava wrote:
> On 03/10/2017 07:30 AM, Prarit Bhargava wrote:
> > 
> > 
> > On 03/09/2017 04:57 PM, Bjorn Helgaas wrote:
> >> Hi Prarit,
> >>
> >> My abject apologies for taking so long to deal with this.
> > 
> > np.  It's only two lines but it is also complex code and I know you're busy.
> > 
> 
> <snip>
> 
> >>
> >> What do you think of the following two patches?  Thanks for all the
> >> details in your changelog -- I think they finally helped me gel all
> >> the pieces in my mind, and it all seems obvious now.  I tried to
> >> distill it down to just the critical pieces.
> >>
> > 
> > I'm good with these two patches.
> 
> Bjorn, I just am making sure that these don't get left on the floor (so to speak).

Yep, sorry, they're on my pci/msi branch; I just hadn't merged that
into "next".  I did that now, so you should see it in linux-next
tomorrow.

Bjorn
