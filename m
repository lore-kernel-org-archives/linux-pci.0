Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56262 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932341AbeFUNzT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jun 2018 09:55:19 -0400
Date: Thu, 21 Jun 2018 07:58:32 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH 2/7] PCI/DPC: Defer event handling to work queue
Message-ID: <20180621135831.GA26623@localhost.localdomain>
References: <20180620213833.25072-1-keith.busch@intel.com>
 <20180620213833.25072-2-keith.busch@intel.com>
 <20180621072727.GA18738@infradead.org>
 <20180621072819.GB18738@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180621072819.GB18738@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2018 at 12:28:19AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 21, 2018 at 12:27:27AM -0700, Christoph Hellwig wrote:
> > On Wed, Jun 20, 2018 at 03:38:28PM -0600, Keith Busch wrote:
> > > This moves all event handling to the existing work queue, which will
> > > make passing event information simpler to the handler.
> > 
> > I wonder if just using a threaded interrupt would be useful for
> > the DPC handler?
> 
> Ok, I should have read until the end of the thread first..

It's still good to know the series was on the right path. :)
