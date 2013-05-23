Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65173 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758442Ab3EWRZB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2013 13:25:01 -0400
Date: Thu, 23 May 2013 13:24:37 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Maen Suleiman <maen@marvell.com>
Subject: Re: [PATCH v2 0/3] Marvell PCIe driver improvements
Message-ID: <20130523172437.GR31290@titan.lakedaemon.net>
References: <1369319573-19927-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo6ytq9Tzq_=KucZA+1=90t57QP5-Fw_dus2dXiXL5YKtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6ytq9Tzq_=KucZA+1=90t57QP5-Fw_dus2dXiXL5YKtg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 23, 2013 at 11:01:10AM -0600, Bjorn Helgaas wrote:
> On Thu, May 23, 2013 at 8:32 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > Bjorn, Jason, Andrew, Gregory,
> >
> > Here is an updated version of the PCIe improvements.
> >
> > Changes since v1:
> >
> >  * Fix some typos in the comments of PATCH 2, noticed by Bjorn
> >    Helgaas.
> >
> >  * Rework the two last patches (first one was fixing the capability
> >    list, the other one the emulation of the devsel bits in the status
> >    register), after the comments of Bjorn. In fact, it turns out that
> >    the status register is composed of read-only bits for which we want
> >    to emulate a value of zero, and the other bits are write-1-to-clear
> >    bits that expose error conditions that we do not handle in the
> >    emulated bridge. So, in summary, emulating a 0 status register on
> >    reads, and ignoring writes to the status register is the simplest
> >    solution. If we later on implement a capability list, we can use a
> >    more clever emulation of the status register, but for the moment,
> >    this simple solution is enough. Therefore, the two last patches are
> >    now one single, simpler patch.
> >
> > I'd like those improvements to be kept separated from the original
> > PCIe driver itself: while the PCIe driver has been around and reviewed
> > for a long time, those improvements are newer. And I clearly do not
> > want the PCIe driver to miss 3.11 because of any problem that could be
> > found in those additional improvements.
> >
> > The main improvement being brought here is that the PCI-to-PCI bridge
> > logic is fixed/extended to properly support physical PCIe bridges that
> > are connected on a PCIe interface of a Marvell board. Without this
> > improvement, only the devices connected directly to the PCIe
> > interfaces of the board are properly enumerated. Any device that would
> > sit beyond a physical bridge is not visible.
> >
> > Bjorn, with your Acked-by, could the Marvell maintainers include those
> > patches in their branch, merged through arm-soc? They already have the
> > Marvell PCIe driver itself, so I believe it makes sense to merge those
> > improvements through the same path.
> >
> > Jason, those patches have been prepared on top of my marvell-pcie-v10
> > branch, I hope that's ok for you. If you want me to rebase them on
> > some other branch in which you have integrated the PCIe driver, don't
> > hesitate to tell me to do so. That said, since those patches are only
> > touching the driver itself and no other file, they should not cause
> > any conflict with other changes.
> >
> > Thanks,
> >
> > Thomas
> >
> > Thomas Petazzoni (3):
> >   pci: mvebu: no longer fake the slot location of downstream devices
> >   pci: mvebu: allow the enumeration of devices beyond physical bridges
> >   pci: mvebu: fix the emulation of the status register
> >
> >  drivers/pci/host/pci-mvebu.c |   55 +++++++++++++++++++++++++++++++++---------
> >  1 file changed, 44 insertions(+), 11 deletions(-)
> 
> For all three:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Feel free to merge these through the arm-soc tree or whatever makes
> sense for you.  Nobody else is working on this file, so there
> shouldn't be any conflicts.

Thanks, Bjorn!

Jason.
