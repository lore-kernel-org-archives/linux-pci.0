Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:34228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbeC3LtK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Mar 2018 07:49:10 -0400
Date: Fri, 30 Mar 2018 04:49:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, Sathya Perla <sathya.perla@broadcom.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        alexander.duyck@gmail.com, john.fastabend@gmail.com,
        Jacob Keller <jacob.e.keller@intel.com>,
        Donald Dutile <ddutile@redhat.com>, oss-drivers@netronome.com
Subject: Re: [PATCH] PCI: allow drivers to limit the number of VFs to 0
Message-ID: <20180330114905.GA10246@infradead.org>
References: <20180329182231.32151-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180329182231.32151-1-jakub.kicinski@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 29, 2018 at 11:22:31AM -0700, Jakub Kicinski wrote:
> Some user space depends on driver allowing sriov_totalvfs to be
> enabled.

I can't make sene of this sentence.  Can you explain what user space
code depends on what semantics?  The sriov_totalvfs file should show
up for any device supporting SR-IOV as far as I can tell.

>
> For devices which VF support depends on loaded FW we
> have the pci_sriov_{g,s}et_totalvfs() API.  However, this API
> uses 0 as a special "unset" value, meaning drivers can't limit
> sriov_totalvfs to 0.  Change the special value to be U16_MAX.
> Use simple min() to determine actual totalvfs.

Please use a PCI_MAX_VFS or similar define instead of plain U16_MAX or ~0.
