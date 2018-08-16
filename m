Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeHPXbq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 19:31:46 -0400
Date: Thu, 16 Aug 2018 15:31:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc: "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
Message-ID: <20180816203111.GB10316@bhelgaas-glaptop.roam.corp.google.com>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
 <20180816154940.GD5762@bombadil.infradead.org>
 <1534434641.17819.27.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534434641.17819.27.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 03:50:47PM +0000, Derrick, Jonathan wrote:
> On Thu, 2018-08-16 at 08:49 -0700, Matthew Wilcox wrote:
> > On Wed, Aug 15, 2018 at 03:26:39PM -0600, Jon Derrick wrote:
> > > Some users may want to disable downstream port containment (DPC),
> > > so
> > > give them this option
> > 
> > Is it possible they might only want to disable DPC on a subset of the
> > hierarchy rather than globally?
> 
> Absolutely. I was hoping Logan's pci dev_str would land because I have
> a few others I want to convert to that api for granular tuning

What's the use case here?  I acknowledge there are cases where we need
them, but I'm not a fan of kernel parameters in general because
they're a real hassle for users.

Is there something wrong with DPC?  Is there some way we can make it
smarter so it does the right thing automatically?

I'm more OK with a blanket "nodpc" switch intended for debugging.
If we add the complexity of subsets of the hierarchy it starts
sounding like an administrative thing that makes me more hesitant. 

Could this be done via a sysfs switch instead?  That potentially could
work for hot-added things where a kernel parameter doesn't work so
well.

Please squash the doc patch and the code change so it's easier to keep
them together.

Bjorn
