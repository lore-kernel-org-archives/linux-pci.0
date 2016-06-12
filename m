Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46196 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932891AbcFLWSv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 12 Jun 2016 18:18:51 -0400
Date: Sun, 12 Jun 2016 17:18:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v5] PCI: PTM preliminary implementation
Message-ID: <20160612221847.GM16462@localhost>
References: <1462956446-27361-1-git-send-email-jonathan.yong@intel.com>
 <1462956446-27361-2-git-send-email-jonathan.yong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462956446-27361-2-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jonathan,

On Wed, May 11, 2016 at 08:47:26AM +0000, Yong, Jonathan wrote:
> Simplified Precision Time Measurement driver, activates PTM feature
> if a PCIe PTM requester (as per PCI Express 3.1 Base Specification
> section 7.32)is found, but not before checking if the rest of the
> PCI hierarchy can support it.
> 
> The driver does not take part in facilitating PTM conversations,
> neither does it provide any useful services, it is only responsible
> for setting up the required configuration space bits.
> 
> As of writing, there aren't any PTM capable devices on the market
> yet, but it is supported by the Intel Apollo Lake platform.

I'm still trying to understand what PTM should look like from the
driver's perspective.  I know the PCIe spec doesn't define any way to
initiate PTM dialogs or read the results.  But I don't know what the
intended usage model is and how the device, driver, and PCI core
pieces should fit together.

  - Do we expect endpoints to notice that PTM is enabled and
    automatically start using it, without the driver doing anything?
    Would driver changes be needed, e.g., to tell the device to add
    timestamps to network packet DMAs?

  - Should there be a pci_enable_ptm() interface for a driver to
    enable PTM for its device?  If PTM isn't useful without driver
    changes, e.g., to tell the device to add timestamps, we probably
    should have such an interface so we don't enable PTM when it won't
    be useful.

  - If the PCI core instead enables PTM automatically whenever
    possible (as in the current patch), what performance impact do we
    expect?  I know you probably can't measure it yet, but can we at
    least calculate the worst-case bandwidth usage, based on the
    message size and frequency?  I previously assumed it would be
    small, but I hate to give up *any* performance unless there is
    some benefit.

  - The PTM benefit is mostly for endpoints, and not so much for root
    ports or switches themselves.  If the PCI core enabled PTM
    automatically only on non-endpoints, would there be any overhead?

    Here's my line of thought: If an endpoint never issued a PTM
    request, obviously there would never be a PTM dialog on the link
    between the last switch and the endpoint.  What about on links
    farther upstream?  Would the switch ever issue a PTM request
    itself, without having received a request from the endpoint?  If
    not, the PCI core could enable PTM on all non-endpoint devices,
    and there should be no performance effect at all.  This would be
    nice because a driver call to enable PTM would only need to touch
    the endpoint; it wouldn't need to touch any upstream devices.

Bjorn
