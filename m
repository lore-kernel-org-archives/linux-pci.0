Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59131 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbbKITPX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Nov 2015 14:15:23 -0500
Date: Mon, 9 Nov 2015 13:15:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: ECRC and Max Read Request Size
Message-ID: <20151109191517.GA4789@localhost>
References: <56310B34.6000102@codeaurora.org>
 <20151106172205.GA1002@localhost>
 <563CE93F.5060209@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <563CE93F.5060209@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 06, 2015 at 12:54:07PM -0500, Sinan Kaya wrote:
> ECRC is an optional PCIe feature. Even ECRC support has some flavors
> 
> - A card can support ECRC checking.
> - A card can support ECRC checking and generation.
> 
> Right now, the code is enabling both without checking if they are
> supported at all.
> 
> I have some legacy PCIe cards that don't support ECRC completely
> even though the host bridge supports it. If ECRC checking and
> generation is enabled under this situation, I have problems
> communicating to the endpoint.
> 
> I would like to be able to turn on this feature all the time and not
> think about if things will break or not.
> 
> Maybe, I can fix the code and enable it only when the entire bus
> supports it instead of adding a new feature if nobody objects.

I don't know whether this is a Linux kernel defect or a hardware
defect in the PCIe card.  The ECRC is in the TLP Digest, and per spec,
if a TLP receiver does not support ECRC, it must ignore the TLP Digest
(PCIe spec r3.0, sec 2.2.3).

If a card doesn't support ECRC checking at all, i.e., the AER "ECRC
Check Capable" bit is zero, I would expect the card to work fine even
if you enable ECRC at the Root Port.  If it doesn't, that sounds like
a hardware issue with the card.

It sounds like you're contemplating enabling ECRC only when the Root
Port and every device in the hierarchy below it supports ECRC
checking.  As I read the spec, that would be overly restrictive.  If I
understand it correctly, it should be safe to enable ECRC generation
on every device that supports it.  Devices where ECRC checking is
supported and enabled should check ECRC, and other devices should just
ignore it.

> >>The other problem I'm seeing is about the maximum read request size.
> >>If I choose the PCI bus performance mode, maximum read request size
> >>is being limited to the maximum payload size.
> >>
> >>I'd like to add a new mode where I can have bigger read request size
> >>than the maximum payload size.
> >
> >I've never been thrilled about the way Linux ties MRRS and MPS
> >together.  I don't think the spec envisioned MRRS being used to
> >control segment size on the link.  My impression is that the purpose
> >of MRRS is to limit the amount of time one device can dominate a link.
> >
> >I am sympathetic to the idea of having MRRS larger than MPS.  The
> >question is how to accomplish that.  I'm not really happy with the
> >current set of "pcie_bus_tune_*" parameters, so I'd hesitate to add
> >yet another one.  They feel like they're basically workarounds for the
> >fact that Linux can't optimize MPS directly itself.
> >
> >Can you give any more specifics of your MRRS/MPS situation?  I guess
> >you hope to improve bandwidth to some device by reducing the number of
> >read requests?  Do you have any quantitative estimate of what you can
> >gain?
> 
> I talked to our performance team. They are saying that max read
> request does not gain you much compared to max payload size single
> direction but it helps tremendously if you are moving data forth and
> back between the card. I don't have real numbers though.

I'm not enough of a hardware or performance person to visualize how
MRRS makes a tremendous difference in this situation.  Sample
timelines comparing small vs. large MRRS would help everybody
understand what's happening here.

Bjorn
