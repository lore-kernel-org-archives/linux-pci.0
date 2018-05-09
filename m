Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:47939 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935287AbeEIPZH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 May 2018 11:25:07 -0400
Date: Wed, 9 May 2018 09:26:53 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Bauer, Scott" <scott.bauer@intel.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: Re: [PATCH] PCI/VMD: White list for fast interrupt handlers
Message-ID: <20180509152652.GA823@localhost.localdomain>
References: <20180508160022.30954-1-keith.busch@intel.com>
 <20180509043828.GA9413@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180509043828.GA9413@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 08, 2018 at 09:38:28PM -0700, Christoph Hellwig wrote:
> On Tue, May 08, 2018 at 10:00:22AM -0600, Keith Busch wrote:
> > Devices with slow interrupt handlers are significantly harming performance
> > when their interrupt vector is shared with a fast device. This patch
> > creates a class code white list for devices with known fast interrupt
> > handlers, and all other devices will share a single vector so they don't
> > interfere with performance.
> > 
> > At the moment, only the NVM Express class code is on the list, but more
> > may be added if VMD users desire to use other low-latency devices in
> > these domains.
> 
> I think this is far too much of a hack.   Just don't use VMD if your
> care about performance.

I'm not aware of an easier way you can direct-assign an entire PCIe domain
to a virtual machine. :)
