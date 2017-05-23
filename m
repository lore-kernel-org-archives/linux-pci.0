Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52421 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbdEWFZs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2017 01:25:48 -0400
Date: Mon, 22 May 2017 22:25:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emil Tantilov <emil.s.tantilov@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        oss-drivers@netronome.com
Subject: Re: [PATCH] pci: iov: use device lock to protect IOV sysfs accesses
Message-ID: <20170523052546.GA1408@infradead.org>
References: <20170522225023.14010-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170522225023.14010-1-jakub.kicinski@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 22, 2017 at 03:50:23PM -0700, Jakub Kicinski wrote:
> PCI core sets the driver pointer before calling ->probe() and only
> clears it after ->remove().  This means driver's ->sriov_configure()
> callback will happily race with probe() and remove(), most likely
> leading to BUGs, since drivers don't expect this.
> 
> We could reorder pointer assignments, or try detecting races in all
> drivers, but it seems simpler and cleaner to just hold the device lock
> instead of special SR-IOV lock, since that lock is already supposed
> to synchronize the driver callbacks.
> 
> Remove the iov lock completely, since we remove the last user.

Having just debugged a different method vs ->remove race I violently
agree.

Reviewed-by: Christoph Hellwig <hch@lst.de>
