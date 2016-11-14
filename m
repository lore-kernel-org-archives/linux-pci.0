Return-Path: <julia.lawall@lip6.fr>
Return-Path: <julia.lawall@lip6.fr>
Date: Mon, 14 Nov 2016 22:52:04 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, kernel-janitors@vger.kernel.org,
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] PCI/ASPM: use permission-specific DEVICE_ATTR
 variants
In-Reply-To: <20161114214037.GE9868@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611142250491.2065@hadrien>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr> <1477769829-22230-14-git-send-email-Julia.Lawall@lip6.fr> <20161114214037.GE9868@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>



On Mon, 14 Nov 2016, Bjorn Helgaas wrote:

> On Sat, Oct 29, 2016 at 09:37:07PM +0200, Julia Lawall wrote:
> > Use DEVICE_ATTR_RW for read-write attributes.  This simplifies the
> > source code, improves readbility, and reduces the chance of
> > inconsistencies.
> >
> > The semantic patch that makes this change is as follows:
> > (http://coccinelle.lip6.fr/)
> >
> > // <smpl>
> > @rw@
> > declarer name DEVICE_ATTR;
> > identifier x,x_show,x_store;
> > @@
> >
> > DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
> >
> > @script:ocaml@
> > x << rw.x;
> > x_show << rw.x_show;
> > x_store << rw.x_store;
> > @@
> >
> > if not (x^"_show" = x_show && x^"_store" = x_store)
> > then Coccilib.include_match false
> >
> > @@
> > declarer name DEVICE_ATTR_RW;
> > identifier rw.x,rw.x_show,rw.x_store;
> > @@
> >
> > - DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
> > + DEVICE_ATTR_RW(x);
> > // </smpl>
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> I applied this to pci/aspm to follow the herd, although it looks
> pretty similar to the ill-fated "Replace numeric parameter like 0444
> with macro" series (http://lwn.net/Articles/696229/).  Maybe this is
> different because everybody except me knows what ATTR_RW means?  To
> me, "0644" contained more information than "_RW" does.
>
> I do certainly like the removal of the "_show" and "_store"
> redundancy.

I think that the point is the latter.  There were also a couple of cases
where the permissions didn't match with the set of provided functions.

julia

>
> > ---
> >  drivers/pci/pcie/aspm.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 0ec649d..3b14d9e 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -886,8 +886,8 @@ static ssize_t clk_ctl_store(struct device *dev,
> >  	return n;
> >  }
> >
> > -static DEVICE_ATTR(link_state, 0644, link_state_show, link_state_store);
> > -static DEVICE_ATTR(clk_ctl, 0644, clk_ctl_show, clk_ctl_store);
> > +static DEVICE_ATTR_RW(link_state);
> > +static DEVICE_ATTR_RW(clk_ctl);
> >
> >  static char power_group[] = "power";
> >  void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
> >
>
