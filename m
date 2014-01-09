Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46875 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbaAITUF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Jan 2014 14:20:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1W1L99-00062a-L3
	for linux-pci@vger.kernel.org; Thu, 09 Jan 2014 20:20:03 +0100
Received: from 64.2.3.195.ptr.us.xo.net ([64.2.3.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 09 Jan 2014 20:20:03 +0100
Received: from kdb by 64.2.3.195.ptr.us.xo.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 09 Jan 2014 20:20:03 +0100
To: linux-pci@vger.kernel.org
From: Scott Lurndal <kdb@lurndal.org>
Subject: Re: Query regarding ARI configuration of a on-board PCIe device.
Date: Thu, 9 Jan 2014 19:16:03 +0000 (UTC)
Message-ID: <loom.20140109T201208-15@post.gmane.org>
References: <CA+sq2CfthYc3Eda3GRa-Q-TA9gq+ygBTLrPjvzhRquikm220GA@mail.gmail.com> <CAErSpo6rigeEY7RbpcRrm2N7gKxA+rAwEX7_iD7r706hvM0_MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas <at> google.com> writes:

> 
> On Thu, Jan 9, 2014 at 3:51 AM, Sunil Kovvuri <sunil.kovvuri <at>
gmail.com> wrote:
> > Hi,
> >
> > I have a platform which has a on-board PCIe device attached to PCIe port.
> > This device is an ethernet device with SRIOV capability having morethan
> > 8 virtual functions.
> >
> > I am going through Linux's ARI configuration code and saw that it is
checking
> > if upstream bridge supports ARI or not. In our case its a on-board
device and
> > no bridge is involved.
> >
> > Need some help or ideas on how i can configure ARI on the device so that
> > all VFs gets added.
> >
> > Do i need to change the ARI configuration code or is there a way to fake a
> > PCI bridge for this purpose ?
> 
> I assume you're referring to pci_configure_ari().  A PCIe endpoint
> such as your ethernet device always has an upstream bridge.  In your
> case, the device is on-board and there's no PCIe switch involved, but
> the root port is the upstream device, and it is handled as a bridge.
> 
> It looks like pci_configure_ari() should enable ARI by default when it
> is supported.  But apparently it isn't being enabled on your system?
> Can you collect the "lspci -vv" output for the root port and the NIC?
> 
> Bjorn
> 


Hi Bjorn,

   For the sake of discussion, let's assume that the device in question,
which is intended to appear to software as a pci-express SR-IOV device
with more than 8 functions (i.e. ARI), has a PCI-Express configuration
space which is slotted into an ECAM region for discovery and
configuration.  The device itself is directly attached to the host-bridge
and doesn't have an associated root port.

   In this case, the check for bridge in pci_configure_ari() is
problematic because there is no root port (the host bridge is
transparent to software).

thanks,
scott


