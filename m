Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60871 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbbIKIoz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2015 04:44:55 -0400
Message-ID: <1441961093.3126.8.camel@pengutronix.de>
Subject: Re: Multiple MSIs on ARM imx6q
From: Lucas Stach <l.stach@pengutronix.de>
To: Frank Jenner <faj6816@rit.edu>
Cc: linux-pci@vger.kernel.org
Date: Fri, 11 Sep 2015 10:44:53 +0200
In-Reply-To: <CABFJKVLW3MsnxybhDjZ02ghUV2mKfPgj7kmMdiuJ+oK94OYFxQ@mail.gmail.com>
References: <loom.20150910T144529-230@post.gmane.org>
	 <1441893436.7900.10.camel@pengutronix.de>
	 <CABFJKVLW3MsnxybhDjZ02ghUV2mKfPgj7kmMdiuJ+oK94OYFxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Frank,

Am Donnerstag, den 10.09.2015, 13:37 -0400 schrieb Frank Jenner:
> Hi Lucas,
> 
> Thanks for the quick response. See inline:
> 
> On Thu, Sep 10, 2015 at 9:57 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

[...]

> >
> > An implementation for the i.MX6 is already sitting in Bjorns PCI
> > maintainer tree and is expected to be merged in kernel 4.4.
> >
> 
> I took a look at Bjorn's pci-4.4/host-designware branch and saw your
> commits. It looks like the patches I'm using apply most of the same
> changes. While they do enable me to get multiple MSIs back from
> pci_enable_msi_range() and I get the correct IRQs back to my ISR, I
> still run into the issue below when attempting to get the full 32
> vectors.
> 
> >> Unfortunately, even if I work around the arch_setup_msi_irqs() limitation
> >> (which I've done by trying out patches 448141 and 448142 from
> >> http://patchwork.ozlabs.org/project/linux-pci/list/) and break through to
> >> the assign_irq() function in drivers/pci/host/pcie-designware.c, I still
> >> cannot allocate all 32 MSIs that my device reports.
> >>
> >> It appears that one of the bits in the msi_irq_in_use bitmap is already set
> >> prior to my driver requesting any MSIs, meaning there aren't enough free
> >> slots for the 32 MSIs I am requesting, and causing the function to fail with
> >> -ENOSPC. Based on the output from /proc/interrupts, I believe that the PCIe
> >> PME service driver is consuming one of the 32 available MSI slots. Thus, my
> >> second question is:
> >>
> >> 2.) Is it possible to leverage all 32 MSIs while still using PCIe PME?
> >>
> >> I tried using the kernel command line argument pcie_pme=nomsi, but that
> >> appeared to disable all MSIs for the device rather than just making the PME
> >> service driver use some other mechanism.
> >>
> > It should be possible to make PME use a legacy INT, but I would have to
> > look this up in the code.
> 
> Could you please elaborate on this? I'm a little confused why PME
> occupies one of the MSI slots in the first place. Also, as I thought a
> device could only use either MSIs or legacy INTs (but not both), is it
> even possible for PME to use legacy INTs while my driver uses MSIs?
> >

Sorry, I'm not sure about this myself.

> > Another alternative is to extend the i.MX6 driver. It should be able to
> > provide up to 256 MSI interrupt vectors. But I have no way to test that,
> > so if you could help with testing I can certainly come up with a patch
> > for that.
> 
> Where does the 256 come from?
> 
It's the size of the register space available for MSI IRQs in the i.MX6
implementation.

> I appreciate the help, and I would be happy to test out a patch for
> you with the caveat that I'm using a custom board so I can only test
> any changes against our specific device.
> 
That's totally fine. I can test that I don't break the currently working
cases myself, so I only need you to test if the extension works as I
have no EP with such a large number of MSI IRQs.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

