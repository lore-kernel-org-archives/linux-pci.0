Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbeEaEyf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 May 2018 00:54:35 -0400
Date: Wed, 30 May 2018 23:54:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI/AER: Decode Error Source Requester ID
Message-ID: <20180531045434.GS39853@bhelgaas-glaptop.roam.corp.google.com>
References: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152770285586.80701.6545710900591672975.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180530183241.GA20222@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180530183241.GA20222@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 08:32:41PM +0200, Lukas Wunner wrote:
> On Wed, May 30, 2018 at 12:54:15PM -0500, Bjorn Helgaas wrote:
> >  void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> >  {
> > -	pci_info(dev, "AER: %s%s error received: id=%04x\n",
> > +	u8 bus = info->id >> 8;
> > +	u8 devfn = info->id & 0xff;
> > +
> > +	pci_info(dev, "AER: %s%s error received: %04x:%02x:%02x.%d\n",
> >  		info->multi_error_valid ? "Multiple " : "",
> > -		aer_error_severity_string[info->severity], info->id);
> > +		aer_error_severity_string[info->severity],
> > +		pci_domain_nr(dev->bus), bus, devfn >> 3, devfn & 0x7);
> 
> I think PCI_SLOT(devfn), PCI_FUNC(devfn) is a bit more readable.

I used those originally, but of course those definitions predate PCIe
so they aren't clearly related to a Requester ID.

I searched the PCIe spec for the specifics of the Requester ID
composition.  It was surprisingly hard to find a clear statement.  The
best I found was PCIe r4.0, sec 6.13, which says

    Routing IDs, Requester IDs, and Completer IDs are 16-bit
    identifiers traditionally composed of three fields: an 8-bit Bus
    Number, a 5-bit Device Number, and a 3-bit Function Number.

Even that isn't specific about where the fields are, 

But it's probably not worth obsessing over this and PCI_SLOT() and
PCI_FUNC() are definitely more readable, so I changed them.
