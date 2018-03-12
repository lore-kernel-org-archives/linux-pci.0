Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbeCLORI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Mar 2018 10:17:08 -0400
Date: Mon, 12 Mar 2018 09:17:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 06/13] PCI/portdrv: Remove pcie_port_bus_type link
 order dependency
Message-ID: <20180312141706.GC194000@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062202196.77693.13201322126291517429.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180312080147.GC10358@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180312080147.GC10358@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 12, 2018 at 01:01:47AM -0700, Christoph Hellwig wrote:
> > +	if ((driver->port_type != PCIE_ANY_PORT) &&
> > +	    (driver->port_type != pci_pcie_type(pciedev->port)))
> 
> No need for the inner braces here.

Thanks, I removed them.
