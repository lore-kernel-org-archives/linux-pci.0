Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932745AbdC2Uyu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Mar 2017 16:54:50 -0400
Date: Wed, 29 Mar 2017 15:54:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Having problems resetting a PCI device
Message-ID: <20170329205446.GB31007@bhelgaas-glaptop.roam.corp.google.com>
References: <DM2PR12MB00780139E84F5B961AD4AB6CFE350@DM2PR12MB0078.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DM2PR12MB00780139E84F5B961AD4AB6CFE350@DM2PR12MB0078.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kelly,

On Wed, Mar 29, 2017 at 08:03:33PM +0000, Zytaruk, Kelly wrote:
> I have a PCI device that is sitting behind a bridge. 
> 
> Under certain reproducible circumstances the PCI device will become
> inactive. Reading the PCI config space returns all 0xFFFFFFFF.
> 
> The bridge appears to still be functional. Reading the status from
> the bridge I see a Fatal Error due to a Surprise Down event.

Just to be specific, is this the "Surprise Down Error" in the AER
uncorrectable error status register?  "lspci -vv" probably decodes all
that for you.

> I am trying to figure out how to bring the device back online.
> 
> I tried toggling the secondary bus reset bit of the Bridge Control
> Register but it doesn't appear to make any difference. I still see
> 0xFFFFFFFF in the device config space.

Are you calling pci_reset_function() or doing this by hand?
pci_reset_function() tries several different strategies, one of which
is toggling the secondary bus reset bit.

> I provided a pci_error_handler but the error_detected() function is
> not getting called.

Do you have CONFIG_PCIEAER turned on?  I would naively expect AER to
log something and call your error_detected() function if this error
occurs (but I haven't looked at the code for a long time).

> Given that these two methods are not helping me out what other
> choices do I have to either reset the PCI device or hot-plug the
> device from a kernel driver. Or some other method of bring the
> device back to life.
> 
> Note that I am running Linux 4.8 in dom0 on Xen (if that makes a
> difference).
> 
> Thanks, Kelly
