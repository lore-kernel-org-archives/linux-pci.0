Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:46177 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbeDBVSu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Apr 2018 17:18:50 -0400
Received: by mail-qk0-f173.google.com with SMTP id p67so8010735qke.13
        for <linux-pci@vger.kernel.org>; Mon, 02 Apr 2018 14:18:50 -0700 (PDT)
Date: Mon, 2 Apr 2018 14:18:45 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>,
        Sathya Perla <sathya.perla@broadcom.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Donald Dutile <ddutile@redhat.com>, oss-drivers@netronome.com
Subject: Re: [PATCH] PCI: allow drivers to limit the number of VFs to 0
Message-ID: <20180402141845.46e6c280@cakuba.netronome.com>
In-Reply-To: <CAKgT0UfihwxLWf7BqP=Z87S83DPoqaR4MDq8UT8R4D6Puspy6w@mail.gmail.com>
References: <20180329182231.32151-1-jakub.kicinski@netronome.com>
        <20180330114905.GA10246@infradead.org>
        <CAKgT0UfihwxLWf7BqP=Z87S83DPoqaR4MDq8UT8R4D6Puspy6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 30 Mar 2018 09:54:37 -0700, Alexander Duyck wrote:
> On Fri, Mar 30, 2018 at 4:49 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > On Thu, Mar 29, 2018 at 11:22:31AM -0700, Jakub Kicinski wrote:  
> >> Some user space depends on driver allowing sriov_totalvfs to be
> >> enabled.  
> >
> > I can't make sene of this sentence.  Can you explain what user space
> > code depends on what semantics?  The sriov_totalvfs file should show
> > up for any device supporting SR-IOV as far as I can tell.
> >  
> >>
> >> For devices which VF support depends on loaded FW we
> >> have the pci_sriov_{g,s}et_totalvfs() API.  However, this API
> >> uses 0 as a special "unset" value, meaning drivers can't limit
> >> sriov_totalvfs to 0.  Change the special value to be U16_MAX.
> >> Use simple min() to determine actual totalvfs.  
> >
> > Please use a PCI_MAX_VFS or similar define instead of plain U16_MAX or ~0.  
> 
> Actually is there any reason why driver_max_VFs couldn't just be
> initialized to the same value as total_VFs?
> 
> Also looking over the patch I don't see how writing ~0 would be
> accepted unless you also make changes to pci_sriov_set_totalvfs since
> it should fail the "numvfs > dev->sriov->total_VFs" check. You might
> just want to look at adding a new function that would reset the
> driver_max_VFs value instead of trying to write it to an arbitrary
> value from the driver.

Ack, the reset function plus using total_VFs as unset seems a lot
cleaner, thanks!
