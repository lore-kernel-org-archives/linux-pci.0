Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:54769 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbaKGRf6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Nov 2014 12:35:58 -0500
Date: Fri, 7 Nov 2014 17:35:54 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] arm: pcibios: move to generic PCI domains
Message-ID: <20141107173554.GB3569@red-moon>
References: <1415287936-31203-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1415287936-31203-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_JsqLCXwZ-xkByThCj99kwN1W7sHVx=8bKfxmBt-vTHZoATA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqLCXwZ-xkByThCj99kwN1W7sHVx=8bKfxmBt-vTHZoATA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 07, 2014 at 04:07:30PM +0000, Rob Herring wrote:
> On Thu, Nov 6, 2014 at 9:32 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > Most if not all ARM PCI host controller device drivers either ignore the
> > domain field in the pci_sys_data structure or just increment it every
> > time a host controller is probed, using it as a domain counter.
> >
> > Therefore, instead of relying on pci_sys_data to stash the domain number
> > in a standard location, ARM pcibios code can be moved to the newly
> > introduced generic PCI domains code, implemented in commits:
> >
> > commit 41e5c0f81d3e676d671d96a0a1fafb27abfbd9
> > ("of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr()")
> >
> > commit 670ba0c8883b576d0aec28bd7a838358a4be1
> > ("PCI: Add generic domain handling")
> >
> > In order to assign a domain number dynamically, the ARM pcibios defines
> > the function, called by core PCI code:
> >
> > void pci_bus_assign_domain_nr(...)
> >
> > that relies on a DT property to define the domain number or falls back to
> > a counter; its usage replaces the current domain assignment code in PCI
> > host controllers present in the kernel.
> 
> I realize you are just copying the arm64 version, but as we've agreed
> the DT domain handling should be common and what the error cases are,
> I've got some comments on the current implementation.

So this means that either I patch arm64 code with your implementation
below and I duplicate the code for arm too, or I have to factor out an
implementation based on your code below and add it somewhere in common
kernel code (drivers/pci/pci.c ? drivers/pci/of.c ?), where, it has to be
seen.

> 
> [...]
> 
> > +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> > +static bool dt_domain_found;
> 
> This can be moved into the function.

Yes, I noticed while putting the patch together, I was more concerned
about the removal of pci_sys_data.domain than the code parsing the domain
value, which I considered agreed upon.

> > +
> > +void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> > +{
> > +       int domain = of_get_pci_domain_nr(parent->of_node);
> > +
> > +       if (domain >= 0) {
> > +               dt_domain_found = true;
> > +       } else if (dt_domain_found == true) {
> > +               dev_err(parent, "Node %s is missing \"linux,pci-domain\" property in DT\n",
> > +                       parent->of_node->full_name);
> > +               return;
> 
> No error other than a printk? Do we want to set domain_nr to an
> illegal value or something?

See above.

> > +       } else {
> > +               domain = pci_get_new_domain_nr();
> > +       }
> > +
> > +       bus->domain_nr = domain;
> > +}
> 
> This doesn't handle the case where the 1st node(s) probed does not
> have a domain prop and a later one does. I think something like this
> should work:

Well, a boolean won't do, your code below looks ok, I can add a trivial enum
to make use_dt_domains usage clearer (but I think a comment to your code will
do):

enum {
	PCI_DOMAIN_INVALID,
	PCI_DOMAIN_DT,
	PCI_DOMAIN_DEFAULT
};

> static int use_dt_domains = -1;
> int domain = of_get_pci_domain_nr(parent->of_node);
> 
> if (domain >= 0 && use_dt_domains) {
>         use_dt_domains = 1;
> } else if (domain < 0 && use_dt_domain != 1) {
>         use_dt_domains = 0;
>         domain = pci_get_new_domain_nr();
> } else {
>         dev_err(parent, "Node %s has inconsistent \"linux,pci-domain\"
> property in DT\n",
>                  parent->of_node->full_name);
>         domain = -1;  // Not sure if -1 would be illegal or not????

I have to check, that's a valid point, we can't certainly leave it as it is.

Thanks,
Lorenzo
