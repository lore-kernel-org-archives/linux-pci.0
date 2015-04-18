Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33596 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbbDRAD2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2015 20:03:28 -0400
Received: by igbpi8 with SMTP id pi8so34570851igb.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2015 17:03:27 -0700 (PDT)
Date: Fri, 17 Apr 2015 19:03:23 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Robert White <rwhite@pobox.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Matthew Garrett <mjg59@coreos.com>
Subject: Re: NULL Pointer in 3.x during PCI bus enumeration
Message-ID: <20150418000323.GC20701@google.com>
References: <54EB81B2.4050904@pobox.com>
 <54F10D0F.9080309@pobox.com>
 <CAErSpo7NB25yNaHu8VOujUN1NUTyr4FM+jUA8gsbVSx0ZC1USg@mail.gmail.com>
 <54F9107D.4000000@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54F9107D.4000000@pobox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yijing, Matthew]

On Thu, Mar 05, 2015 at 06:27:09PM -0800, Robert White wrote:
> It took me a while to get back into the lab and scrape together a
> working subsystem to collect the data you wanted.
> 
> Link to bug...
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=94361

Thanks!  Yijing added useful analysis to the bugzilla, but I'm going to
continue the email thread because there's interesting stuff here that
shouldn't be buried off in bugzilla.

Yijing noticed that you have an interesting system topology:

  pci 0000:00:1c.0: PCI bridge to [bus 02-0a]   Root Port (Slot+)
  pci 0000:02:00.0: PCI bridge to [bus 03-0a]   Downstream Port (Slot-)
  pci 0000:03:00.0: PCI bridge to [bus 04]      Upstream Port
  pci 0000:03:01.0: PCI bridge to [bus 05]      Downstream Port (Slot+)
  pci 0000:03:02.0: PCI bridge to [bus 06]      Downstream Port (Slot+)
  ...
  pci 0000:03:0a.0: PCI bridge to [bus 0a]      Downstream Port (Slot+)

It would be more typical for the Root Port to connect to an Upstream
Port of a switch, and Downstream Ports of the switch would connect to
endpoint devices.  But your system has the Root Port connected to a
Downstream Port.

This might be a legal topology, but I'm confused about how we should
interpret it.  ASPM configuration involves both ends of a link, and the
code allocates pcie_link_state structures for the device at the upstream
end of the link.  Normally the upstream end is a Root Port or a Downstream
Port.  Then it configures the other end by iterating over the list of
devices on the secondary bus ("pci_dev.subordinate" in the code).

In your system, there's a link from 00:1c.0 to 02:00.0, but if we're
looking at 02:00.0, the link is on the *upstream* side, not the downstream
side where we expect it.  So Linux allocates a pcie_link_state for 02:00.0,
but it thinks the other end of that link is at 03:00.0, but I think that's
wrong.

It might be possible for us to figure out where the other end of the link
is in a different way, without relying on the assumption that a Downstream
Port's link goes to its secondary bus.  But that would definitely require
some changes.

(I know your FADT told us not to touch ASPM anyway; that's another issue
that we also need to sort out.)

You said:

> Yes. It is part of the Advanced Telecommunication Computing
> Architecture (ATCA)
> http://en.wikipedia.org/wiki/Advanced_Telecommunications_Computing_Architecture

> The deal is that the "Field Replaceable Units" (FRUs) fit each fit
> into a carrier card that is little than a power control matrix and a
> PCIe bus. The CPU module itself is just another FRU just like the
> targets. So the computing module doesn't own the top level bus. The
> data trip to the final target devices, if they aren't co-resident on
> the CPU module, is up to the backplane and then back down to the
> target controller.

> So in this setup the CPU is a peer of all the other adapters.

Where do the devices listed above physically live?  Is the switch (devices
02:00.0, 03:00.0, 03:01.0, etc.) physically on the backplane, and the FRUs
(including the CPU) in slots connected to Downstream Ports of the switch?

Who assigns bus numbers to this fabric?  Would anything break if Linux
reassigned them?

Bjorn
