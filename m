Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 13 Apr 2017 16:02:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V8 3/5] PCI/ASPM: add init hook to device_add
Message-ID: <20170413210218.GA24910@bhelgaas-glaptop.roam.corp.google.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-4-git-send-email-okaya@codeaurora.org>
 <20170413204800.GB28316@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20170413204800.GB28316@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mayurkumar.patel@intel.com, David Daney <david.daney@cavium.com>,
 linux-pci@vger.kernel.org, timur@codeaurora.org, linux-kernel@vger.kernel.org,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 13, 2017 at 03:48:00PM -0500, Bjorn Helgaas wrote:
> Hi Sinan,
> 
> On Sat, Apr 08, 2017 at 12:55:49AM -0400, Sinan Kaya wrote:
> > For bridges, have pcie_aspm_init_link_state() allocate a link_state,
> > regardless of whether it currently has any children.
> > 
> > pcie_aspm_init_link_state(): Called for bridges (upstream end of
> > link) after all children have been enumerated.  No longer needs to
> > check aspm_support_enabled or pdev->has_secondary_link or the VIA
> > quirk: pci_aspm_init() already checked that stuff, so we only need
> > to check pdev->link_state here.
> > 
> > Now that we are calling alloc_pcie_link_state() from pci_aspm_init()
> > , get rid of pci_function_0 function and detect downstream link in
> > pci_aspm_init_upstream() instead when the function number is 0.
> > 
> > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=194895
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > ---
> >  drivers/pci/pcie/aspm.c | 72 ++++++++++++++++++++++++-------------------------
> >  1 file changed, 36 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a80d64b..e33f84b 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -422,20 +422,6 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> >  	}
> >  }
> >  
> > -/*
> > - * The L1 PM substate capability is only implemented in function 0 in a
> > - * multi function device.
> > - */
> > -static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
> > -{
> > -	struct pci_dev *child;
> > -
> > -	list_for_each_entry(child, &linkbus->devices, bus_list)
> > -		if (PCI_FUNC(child->devfn) == 0)
> > -			return child;
> > -	return NULL;
> > -}
> > -
> >  /* Calculate L1.2 PM substate timing parameters */
> >  static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> >  				struct aspm_register_info *upreg,
> > @@ -798,7 +784,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
> >  	INIT_LIST_HEAD(&link->children);
> >  	INIT_LIST_HEAD(&link->link);
> >  	link->pdev = pdev;
> > -	link->downstream = pci_function_0(pdev->subordinate);
> >  
> >  	/*
> >  	 * Root Ports and PCI/PCI-X to PCIe Bridges are roots of PCIe
> > @@ -828,11 +813,33 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
> >  
> >  static int pci_aspm_init_downstream(struct pci_dev *pdev)
> >  {
> > +	struct pcie_link_state *link;
> > +	struct pci_dev *parent;
> > +
> > +	/*
> > +	 * The L1 PM substate capability is only implemented in function 0 in a
> > +	 * multi function device.
> > +	 */
> > +	if (PCI_FUNC(pdev->devfn) != 0)
> > +		return -EINVAL;
> > +
> > +	parent = pdev->bus->self;
> > +	if (!parent)
> > +		return -EINVAL;
> > +
> > +	link = parent->link_state;
> > +	link->downstream = pdev;
> >  	return 0;
> >  }
> >  
> >  static int pci_aspm_init_upstream(struct pci_dev *pdev)
> >  {
> > +	struct pcie_link_state *link;
> > +
> > +	link = alloc_pcie_link_state(pdev);
> > +	if (!link)
> > +		return -ENOMEM;
> 
> This allocates the link_state when we enumerate a Downstream Port
> instead of when we enumerate a child device.  We want the link_state
> lifetime to match that of the Downstream Port, so this seems good.
> 
> But we shouldn't at the same time change the link_state deallocation
> so it happens when the Downstream Port is removed, not when the child
> device is removed?

I do see that you change the deallocation in patch [5/5], but I think
the deallocation change should be in the same patch as the allocation
change.  Otherwise I think we have a use-after-free problem in this
sequence:

  # initial enumeration
  pci_device_add(downstream_port)
    pci_aspm_init(downstream_port)
      alloc_pcie_link_state
  pci_device_add(endpoint)
    pci_aspm_init(endpoint)

  # hot-remove endpoint
  pci_stop_dev(endpoint)
    pcie_aspm_exit_link_state(endpoint)
      link = parent->link_state
      free_link_state(link)

  # hot-add endpoint
  pci_aspm_init(endpoint)
    link = parent->link_state     <--- use after free

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
