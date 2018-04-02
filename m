Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:45544 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754505AbeDBVRe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Apr 2018 17:17:34 -0400
Received: by mail-qt0-f177.google.com with SMTP id f8so17023855qtg.12
        for <linux-pci@vger.kernel.org>; Mon, 02 Apr 2018 14:17:34 -0700 (PDT)
Date: Mon, 2 Apr 2018 14:17:29 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, Sathya Perla <sathya.perla@broadcom.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        alexander.duyck@gmail.com, john.fastabend@gmail.com,
        Jacob Keller <jacob.e.keller@intel.com>,
        Donald Dutile <ddutile@redhat.com>, oss-drivers@netronome.com
Subject: Re: [PATCH] PCI: allow drivers to limit the number of VFs to 0
Message-ID: <20180402141729.4576365d@cakuba.netronome.com>
In-Reply-To: <20180330114905.GA10246@infradead.org>
References: <20180329182231.32151-1-jakub.kicinski@netronome.com>
        <20180330114905.GA10246@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 30 Mar 2018 04:49:05 -0700, Christoph Hellwig wrote:
> On Thu, Mar 29, 2018 at 11:22:31AM -0700, Jakub Kicinski wrote:
> > Some user space depends on driver allowing sriov_totalvfs to be
> > enabled.  
> 
> I can't make sene of this sentence.  Can you explain what user space
> code depends on what semantics?  The sriov_totalvfs file should show
> up for any device supporting SR-IOV as far as I can tell.

Ugh, I took me a while to understand what I meant myself...  So what I
meant is that this should generally work:

# cat .../sriov_totalvfs > .../sriov_numvfs

I.e. one should be able to "enable" the number of VFs advertised in
sriov_totalvfs.  I will rephrase!

> > For devices which VF support depends on loaded FW we
> > have the pci_sriov_{g,s}et_totalvfs() API.  However, this API
> > uses 0 as a special "unset" value, meaning drivers can't limit
> > sriov_totalvfs to 0.  Change the special value to be U16_MAX.
> > Use simple min() to determine actual totalvfs.  
> 
> Please use a PCI_MAX_VFS or similar define instead of plain U16_MAX or ~0.

I think I may just go with what I think Alex is suggesting and "unset"
the value to total_VFs.
