Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16623 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265AbbIBRuj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Sep 2015 13:50:39 -0400
Date: Wed, 2 Sep 2015 10:46:12 -0700
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	"gong.chen@linux.intel.com" <gong.chen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Add support for Enhanced Allocation devices
Message-ID: <20150902174612.GA2700@sean.stalley.intel.com>
References: <1440089947-2839-1-git-send-email-sean.stalley@intel.com>
 <1440089947-2839-3-git-send-email-sean.stalley@intel.com>
 <CAE9FiQUQacSJXPqv9GQJ4AF0TN7uxcBiAYHVbHwvFhEfWgWKHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUQacSJXPqv9GQJ4AF0TN7uxcBiAYHVbHwvFhEfWgWKHg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for taking a look Yinghai.

On Tue, Sep 01, 2015 at 04:14:08PM -0700, Yinghai Lu wrote:
> On Thu, Aug 20, 2015 at 9:59 AM, Sean O. Stalley <sean.stalley@intel.com> wrote:
> > Add support for devices using Enhanced Allocation entries instead of BARs.
> > This patch allows the kernel to parse the EA Extended Capability structure
> > in PCI configspace and claim the BAR-equivalent resources.
> >
> > Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
> > ---
> >  drivers/pci/pci.c   | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h   |   1 +
> >  drivers/pci/probe.c |   3 +
> >  3 files changed, 223 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 0008c95..c8217a8 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> ...
> > +
> > +/* Read an Enhanced Allocation (EA) entry */
> > +static int pci_ea_read(struct pci_dev *dev, int offset)
> > +{
> ...
> > +       res->name = pci_name(dev);
> > +       res->start = start;
> > +       res->end = end;
> > +       res->flags = flags;
> > +
> > +       pci_ea_claim_resource(dev, res);
> > +
> > +out:
> > +       return offset + ent_size;
> > +}
> > +
> > +/* Enhanced Allocation Initalization */
> > +void pci_ea_init(struct pci_dev *dev)
> > +{
> ...
> > +
> > +       for (i = 0; i < num_ent; ++i) {
> > +               /* parse each EA entry */
> > +               dev_dbg(&dev->dev, "%s: parsing entry %i...\n", __func__, i);
> > +               offset = pci_ea_read(dev, offset);
> > +       }
> > +}
> > +
> >  static void pci_add_saved_cap(struct pci_dev *pci_dev,
> >         struct pci_cap_saved_state *new_cap)
> >  {
> 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index cefd636..4cadf35 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1522,6 +1522,9 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
> >
> >  static void pci_init_capabilities(struct pci_dev *dev)
> >  {
> > +       /* Enhanced Allocation */
> > +       pci_ea_init(dev);
> > +
> >         /* MSI/MSI-X list */
> >         pci_msi_init_pci_dev(dev);
> >
> 
> Should not call pci_ea_claim_resource() that early.

Out of curiosity, why shouldn't resources be claimed that early?
EA resources are fixed by hardware. They are always there & will never move.

> 
> For x86 and other arches, we call
> pcibios_resource_survey/pcibios_allocate_bus_resouce/pcibios_allocate_resources
> quite late.

Would it be better to modify pci_claim_resource() to support EA instead of adding pci_ea_claim_resource()?
That way, EA entries would be claimed at the same time as traditional BARs.

-Sean
