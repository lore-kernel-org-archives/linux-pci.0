Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752936AbeEVVv2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 17:51:28 -0400
Date: Tue, 22 May 2018 16:51:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Doug Meyer <dmeyer@gigaio.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-ntb <linux-ntb@googlegroups.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
Message-ID: <20180522215126.GA22385@bhelgaas-glaptop.roam.corp.google.com>
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
 <20180517134521.GC19955@bhelgaas-glaptop.roam.corp.google.com>
 <9dd68ac0-5b9e-b257-49d2-20327c2ab282@deltatee.com>
 <CA+GK6en+g+T9H0sOMdVXv-_aD3rRcuzZ1JdfK0moEoTuuJnrqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+GK6en+g+T9H0sOMdVXv-_aD3rRcuzZ1JdfK0moEoTuuJnrqQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex]

On Tue, May 22, 2018 at 02:09:59PM -0700, Doug Meyer wrote:
> Logan answered the questions quite thoroughly. (Thanks, Logan!)

When you repost it, please rework the commit log so it answers the
questions directly.  Otherwise the next reader may have the same
questions again.  E.g., say something about how the proxy IDs are not
programmable and are fixed in the hardware so all we have to do is
read them.

I don't think the question of when the aliases need to be added is
quite closed.  Logan said "it seems pci_add_dma_alias() must be called
before the driver is initialized and therefore in a quirk", but that
doesn't make clear *why* the alias needs to be added before the driver
is initialized.  The alias shouldn't be needed until the device does a
DMA, and it shouldn't do that until after the driver initializes.

I suspect the reason the existing quirks are in drivers/pci/quirks.c
is because the IOMMU driver is in the host OS, but the host may not
have a driver for the device if the device is passed through to a
guest OS.  In that case, the only way to add the alias is by using a
quirk that is always built into the host OS.

We could argue that the driver in the guest should be able to tell the
host's IOMMU driver about these aliases, but I doubt there's an
interface for that.

Bjorn
