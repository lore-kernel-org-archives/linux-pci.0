Return-Path: <benh@au1.ibm.com>
Return-Path: <benh@au1.ibm.com>
Subject: Re: [PATCH] PCI: Add parameter @mmio_force_on to
 pci_update_resource()
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Bjorn Helgaas <helgaas@kernel.org>,
        Gavin Shan
 <gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, clsoto@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Date: Wed, 28 Sep 2016 07:45:32 +1000
In-Reply-To: <20160927192003.GA14642@localhost>
References: <1474242810-11530-1-git-send-email-gwshan@linux.vnet.ibm.com>
	 <20160927192003.GA14642@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1475012732.2857.293.camel@au1.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-09-27 at 14:20 -0500, Bjorn Helgaas wrote:
> On Mon, Sep 19, 2016 at 09:53:30AM +1000, Gavin Shan wrote:
> > In pci_update_resource(), the PCI device's memory decoding (0x2 in
> > PCI_COMMAND) is disabled when 64-bits memory BAR is updated if the
> > PCI device's memory space wasn't asked to be always on by @pdev->
> > mmio_always_on. The PF's memory decoding might be disabled when
> > updating its IOV BARs in the following path. Actually, the PF's
> > memory decoding shouldn't be disabled in this scenario as the PF
> > has been started to provide services:
> 
> The reason we disable memory decoding while updating a 64-bit BAR is
> because we can't do the update atomically, and a half-updated BAR might
> conflict with other devices.
> 
> You need to explain what is special about these SR-IOV BARs that makes it
> safe to update them non-atomically while decoding is enabled.

The IOV BAR won't decode until SR-IOV is enabled right ? Gavin, I don't
think we update it "live", so it should be safe...

Cheers,
Ben.
