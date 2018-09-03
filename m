Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53925 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbeICE4L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Sep 2018 00:56:11 -0400
Message-ID: <0065b46df3c9c6fc535a747b05a02eaac50bbb56.camel@kernel.crashing.org>
Subject: Re: [PATCH 16/16] PCI: Unify device inaccessible
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lukas Wunner <lukas@wunner.de>, Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Date: Mon, 03 Sep 2018 10:38:08 +1000
In-Reply-To: <20180902143937.utebcv4cqw6zbb4q@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
         <20180831212639.10196-17-keith.busch@intel.com>
         <20180902143937.utebcv4cqw6zbb4q@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2018-09-02 at 16:39 +0200, Lukas Wunner wrote:
> On Fri, Aug 31, 2018 at 03:26:39PM -0600, Keith Busch wrote:
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -294,21 +294,20 @@ struct pci_sriov {
> >  static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> >  {
> > -	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
> > +	dev->error_state = pci_channel_io_perm_failure;
> >  	return 0;
> >  }
> 
> Back in 2016 when I floated the idea of using error_state to store
> that the device has been removed, you responded:

Wow, lots of activity while I wasn't looking :-) Unfortunately I'll be
away for a few weeks...

A quick note:

>    "I'd be happy if we can reuse that, but concerned about overloading
>     error_state's intended purpose for AER. The conditions under which an
>     'is_removed' may be set can also create AER events, and the aer driver
>     overrides the error_state."
>     https://spinics.net/lists/linux-pci/msg55417.html
> 
> Is it guaranteed that AER refrains from writing a different value to
> error_state once it has been set to pci_channel_io_perm_failure due
> to removal?  If so I'm happy with this patch.

My suggestion to avoid that problem (we have a similar one in theory
with EEH which can set error_state from interrupts) is to make
error_state an atomic by having the "set" function use cmpxchg to
enforce that there is no valid transition from perm_failure.

I was hoping to cookup some patches along the line of the RFC I already
sent factoring the above, but a number of things here got in the way
and I'm about to head out of the country for 3 weeks.

Cheers,
Ben.
