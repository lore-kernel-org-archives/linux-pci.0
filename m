Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752320AbdBJRwL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Feb 2017 12:52:11 -0500
Date: Fri, 10 Feb 2017 11:42:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/8] PCI: Recognize Thunderbolt devices
Message-ID: <20170210174250.GD29169@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1484486499.git.lukas@wunner.de>
 <bfabf33fc63abbeb84e11e544456098dff0e4604.1484486499.git.lukas@wunner.de>
 <20170128215208.GM20550@bhelgaas-glaptop.roam.corp.google.com>
 <20170129002616.GA28225@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170129002616.GA28225@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 29, 2017 at 01:26:16AM +0100, Lukas Wunner wrote:
> On Sat, Jan 28, 2017 at 03:52:08PM -0600, Bjorn Helgaas wrote:
> > On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:

> > > +static void set_pcie_vendor_specific(struct pci_dev *dev)
> > 
> > This is very specific to Thunderbolt, so let's name it something that
> > conveys that information.  The fact that we use a vendor-specific
> > capability to figure it out isn't really relevant in the caller.
> 
> I thought that we may have the necessity in the future to parse other
> VSECs on device probe, so I gave the function this generic name.
> 
> Think about it, every VSEC that needs to be parsed needs the while loop
> below.  It's more efficient to have only a single while loop that handles
> *all* VSECs at once.
> 
> If someone needs to parse another VSEC, they just add it to this function.
> So IMO the way I've solved it is preferable to just adding a Thunderbolt-
> specific function.
> 
> Are you sure you want this renamed? (y/n)

Sorry for the delay; I missed this question.  If this has already been
merged somewhere as-is, that's fine.  If you repost it for any reason,
I would prefer to rename it so it reflects the functionality rather
than the source of the information.  This isn't a performance path, so
readability is more important than optimization.

Bjorn
