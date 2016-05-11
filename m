Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60364 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbcEKQI1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 May 2016 12:08:27 -0400
Date: Wed, 11 May 2016 11:08:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCHv4] pcie: Add driver for Downstream Port Containment
Message-ID: <20160511160817.GA24089@localhost>
References: <1461882288-31506-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461882288-31506-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Thu, Apr 28, 2016 at 04:24:48PM -0600, Keith Busch wrote:
> This adds driver support for root and downstream ports that implement
> the PCI-Express Downstream Port Containment extended capability. DPC is
> an optional capability to contain uncorrectable errors below a port.
> 
> For more information on DPC, please see PCI Express Base Specification
> Revision 4, section 7.31, or view the PCI-SIG DPC ECN here:
> 
>   https://pcisig.com/sites/default/files/specification_documents/ECN_DPC_2012-02-09_finalized.pdf
> 
> When a DPC event is triggered, the h/w disables downstream links, so
> the DPC driver schedules removal for all devices below this port. This
> may happen concurrently with a PCI-e hotplug driver if enabled. When all
> downstream devices are removed and the link state transitions to disabled,
> the DPC driver clears the DPC status and interrupt bits so the link may
> retrain for a newly connected device.
> 
> The pcie device naming is updated to accomodate the additional service
> driver. From Lukas Wunner <lukas@wunner.de>:
> 
> The names of port service devices previously used one nibble to encode
> the port type and another nibble to encode the service type. Since this
> commit introduces a fifth service type, it changes device names to use
> one *byte* to encode the service type. E.g. a hotplug port service on a
> downstream bridge was previously called pcie24 and is now called pcie204.

I know I already merged this, but I just thought of a more
philosophical question.  Why is this a "port service driver" as
opposed to being simply part of the PCI core like ARI, ACS, etc.?

I guess you did make DPC tristate, so from that point of view, it
probably has to use the driver structure to make it convenient to load
after boot.  Does that add value?  Do we expect people to make a
decision about whether to load pcie-dpc?  Or maybe we plan to autoload
it if the DPC capability is present?  Does your patch enable that,
i.e., does it expose something udev can use to autoload it?

I've been wondering whether the portdrv service driver concept was a
mistake.  With the exception of DPC, I think all the portdrv service
drivers are bool, so there's no question of having to load a module.
I think using portdrv means we delay initialization of some things
that we should do earlier.  For example, I think we should setup
pciehp much earlier, when we enumerate the bridge.  And the service
driver registration and capability discovery code adds a fair amount
of complication that I'm not sure is necessary.

So I guess the question is: why did you make DPC a portdrv service
driver, and what bad things would happen if we integrated it into the
PCI core without exposing it as a separate service.

Bjorn
