Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33934 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422967AbcFMNpc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 09:45:32 -0400
Date: Mon, 13 Jun 2016 08:45:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH v5] PCI: PTM preliminary implementation
Message-ID: <20160613134528.GB12221@localhost>
References: <1462956446-27361-1-git-send-email-jonathan.yong@intel.com>
 <1462956446-27361-2-git-send-email-jonathan.yong@intel.com>
 <20160612221847.GM16462@localhost>
 <575E2184.6090701@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <575E2184.6090701@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jeff, intel-wired-lan: questions about how PTM might be used]

On Mon, Jun 13, 2016 at 10:59:16AM +0800, Yong, Jonathan wrote:
> On 06/13/2016 06:18, Bjorn Helgaas wrote:
> >
> >I'm still trying to understand what PTM should look like from the
> >driver's perspective.  I know the PCIe spec doesn't define any way to
> >initiate PTM dialogs or read the results.  But I don't know what the
> >intended usage model is and how the device, driver, and PCI core
> >pieces should fit together.
> >
> >- Do we expect endpoints to notice that PTM is enabled and
> >automatically start using it, without the driver doing anything?
> >Would driver changes be needed, e.g., to tell the device to add
> >timestamps to network packet DMAs?
> 
> As far as I understand, it is a flag to tell the device that it may
> begin using PTM to synchronize the on-board clock with PTM. From the
> text in the specification (6.22.3.1 PTM Requester Role):
> 
> PTM Requesters are permitted to request PTM Master Time only when
> PTM is enabled. The mechanism for directing a PTM Requester to issue
> such a request is implementation specific.
> 
> If any, there won't be a generic way to trigger a PTM conversation.
> 
> >- Should there be a pci_enable_ptm() interface for a driver to
> >enable PTM for its device?  If PTM isn't useful without driver
> >changes, e.g., to tell the device to add timestamps, we probably
> >should have such an interface so we don't enable PTM when it won't be
> >useful.

Is there a Windows driver interface for enabling PTM?  I googled
for such a thing, but didn't find anything.

> >- If the PCI core instead enables PTM automatically whenever
> >possible (as in the current patch), what performance impact do we
> >expect?  I know you probably can't measure it yet, but can we at
> >least calculate the worst-case bandwidth usage, based on the message
> >size and frequency?  I previously assumed it would be small, but I
> >hate to give up *any* performance unless there is some benefit.
> 
> If the driver is already utilizing timestamps from the device, it
> would be more precise and compensated for link delays. According to
> the Implementation Note part in the specs, it says it can be used to
> approximate the round trip message transit time and from there,
> measure the link delay times, assuming upstream/downstream delays
> are symmetrical.
> 
> >- The PTM benefit is mostly for endpoints, and not so much for root
> >ports or switches themselves.  If the PCI core enabled PTM
> >automatically only on non-endpoints, would there be any overhead?
> 
> If it has any local clocks (noted with a requester bit, I have not
> seen such a switch), it may start sending synchronization requests,
> but from the specs...
> 
> >Here's my line of thought: If an endpoint never issued a PTM
> >request, obviously there would never be a PTM dialog on the link
> >between the last switch and the endpoint.  What about on links
> >farther upstream? Would the switch ever issue a PTM request itself,
> >without having received a request from the endpoint?  If not, the PCI
> >core could enable PTM on all non-endpoint devices, and there should
> >be no performance effect at all.  This would be nice because a driver
> >call to enable PTM would only need to touch the endpoint; it wouldn't
> >need to touch any upstream devices.
> 
> From the wording (6.22.2 PTM Link Protocol):
> 
> The Upstream Port, on behalf of the PTM Requester, initiates the PTM
> dialog by transmitting a PTM Request message.
> The Downstream Port, on behalf of the PTM Responder, has knowledge
> of or access (directly or indirectly) to the PTM Master Time.
> 
> My naive interpretation tells me switches will only act on behalf of
> requester/responder, never for itself.

That would be my expectation as well.

My own guess is that the driver should be involved somehow.  The clock
granularity exposed in the PTM control register seems like it's
intended for the driver, since it apparently doesn't affect the
hardware at all.  So maybe we should:

  - Enable PTM on all responder devices, i.e., everything except
    endpoints, automatically.  This on the assumption that this would
    not affect performance at all.

  - Provide a driver interface like this:

      int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);

    to enable PTM on an endpoint.  If successful, it returns the
    effective clock granularity.  This only has to touch the endpoint
    itself, not any upstream devices, since the upstream path would be
    already enabled.

Bjorn
