Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934158AbeCSTX2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Mar 2018 15:23:28 -0400
Date: Mon, 19 Mar 2018 14:23:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Michael Moese <mmoese@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/2] MCB Update for v4.17
Message-ID: <20180319192325.GH77194@bhelgaas-glaptop.roam.corp.google.com>
References: <20180312094119.5298-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180312094119.5298-1-jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:41:17AM +0100, Johannes Thumshirn wrote:
> Hi Greg or Bjorn,
> 
> here's a small mcb update for the 4.17 window. The first patch makes
> the PCI Vendor ID of Altera generally available in pci_ids.h and
> removes it from the two private implementations before I would have to
> add a 3rd one.
> 
> The 2nd patch adds the Altera's PCI vendor ID to the mcb pci driver
> which enables at least one carrier board. This was reported and tested
> by Ben Turner.
> 
> Bjorn asked me to Cc linux-pci@ in his response, so I'm not sure if he want's
> to merge these two patches. I'm fine either way.

I applied these to pci/misc for v4.17.  I don't really care which tree
they go through, but it looks like there's no other obvious single
place since they touch more than one driver.

> Changes to v2:
> * Collected ACKs
> * Reworded Subject of 1/2 according to Bjorn
> 
> Changes to v1:
> * Removed redundant pci_ids.h include
> 
> 
> Johannes Thumshirn (2):
>   PCI: Add Altera vendor ID
>   mcb: add Altera PCI ID to mcb-pci
> 
>  drivers/char/xillybus/xillybus_pcie.c | 1 -
>  drivers/fpga/altera-cvp.c             | 2 --
>  drivers/mcb/mcb-pci.c                 | 1 +
>  include/linux/pci_ids.h               | 2 ++
>  4 files changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.13.6
> 
