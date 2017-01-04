Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759833AbdADAGC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Jan 2017 19:06:02 -0500
Date: Tue, 3 Jan 2017 18:05:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Wu <peter@lekensteyn.nl>, Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kilian Singer <kilian.singer@quantumtechnology.info>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170104000557.GA13950@bhelgaas-glaptop.roam.corp.google.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <3913750.OA6IItgEjC@aspire.rjw.lan>
 <20170103222509.GA4499@bhelgaas-glaptop.roam.corp.google.com>
 <16155135.jUckSz7QPL@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16155135.jUckSz7QPL@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 04, 2017 at 12:13:18AM +0100, Rafael J. Wysocki wrote:
> On Tuesday, January 03, 2017 04:25:09 PM Bjorn Helgaas wrote:
> > On Tue, Jan 03, 2017 at 10:38:24PM +0100, Rafael J. Wysocki wrote:
> > > On Tuesday, January 03, 2017 12:12:21 PM Bjorn Helgaas wrote:
> > > > On Tue, Jan 03, 2017 at 05:31:30PM +0100, Peter Wu wrote:
> > > > > On Tue, Jan 03, 2017 at 05:11:23PM +0100, Lukas Wunner wrote:
> > > > > > [cc += Dave Airlie:
> > > > > > 
> > > > > > Dave, we're about to lose support for newer Optimus laptops which use
> > > > > > _PR3 to cut power to the discrete GPU because Bjorn Helgaas has queued
> > > > > > a commit on his for-linus branch to remove runtime PM for PCIe ports.
> > > > > > This fixes a regression on Kilian Singer's laptop on which locking the
> > > > > > screen breaks USB and PS/2 input devices:  Mouse movements are still
> > > > > > visible, but button or key presses no longer have any effect.  The GPU
> > > > > > is powered down upon locking the screen and the current theory is that
> > > > > > this causes the issues.]
> > > > > 
> > > > > (+cc Alex: this might affect amdgpu/radeon too.]
> > > > > 
> > > > > Bjorn, please reconsider the rpm patch. Reverting support would
> > > > > introduce other regressions (see issues below) and make future
> > > > > Thunderbolt work harder (according to Lukas). If Kilian's laptop has
> > > > > issues, what about a "temporary" quirk?
> > > > 
> > > > As I mentioned at the beginning, the outcome I'm hoping for is a patch
> > > > that fixes Kilian's laptop while preserving the runtime PM support.
> > > > 
> > > > As I also mentioned at the beginning, preserving the runtime PM
> > > > support at the expense of breaking Kilian's laptop is not one of the
> > > > options.
> > > 
> > > But the revert doesn't really help.
> > > 
> > > It doesn't fix system suspend/resume on that laptop, which also breaks when
> > > PCIe ports PM is enabled on it.
> > > 
> > > If you really want to use a sledgehammer approach here (which I don't recommend,
> > > but that's your call), you can change the initial value of pci_bridge_d3_disable to
> > > "true" (and update the pcie_ports_pm= command line to take "on" in case
> > > someone wants to enable the feature).  That at least will take care of the
> > > regression entirely and not just partly.
> > 
> > What the heck is the problem here?  I'm not trying to be difficult,
> > but I didn't write this code and I'm not really interested in figuring
> > out how to fix it, so my only real option is to solicit fixes and, if
> > none appear, revert changes that break things.
> > 
> > As I've said more than once, I hope and expect that there is a better
> > solution than reverting the patch.  But *I* am not going to write it.
> > As soon as somebody proposes a better patch, I'll use it instead of
> > the revert.
> > 
> > If you want to fix the regression by changing the
> > pci_bridge_d3_disable value, all you have to do is post a patch doing
> > that.
> 
> OK, please find appended.
> 
> > I really don't understand why people are so wrapped around the axle
> > about this.  This is just the way Linux works -- we try really hard
> > not to cause regressions on platforms that used to work.
> 
> I haven't seen anyone in this thread questioning that.
> 
> IMO the point people are trying to make is that reverting stuff may not really be
> the way to go.
> 
> > I *SAID* in the very first posting of the revert that I assume Mika will have a
> > better solution soon.
> 
> In which case I wouldn't have queued up a revert had I been you.
> 
> > When a better patch appears, I'll take that and drop the revert.
> > What's the problem with that?
> 
> There are people for whom the commit in question fixed serious issues and the
> revert would just take that away from them without any option to make their
> systems work.

I don't *want* to apply the revert.  It's on my for-linus branch as a
worst-case scenario change if we can't figure out a better fix.

The patch below is preferable, but I'd rather not take even it,
because it takes away functionality and forces people to use a boot
parameter to restore it.  I expect that somebody will figure out how
to fix the regression Kilian found and also keep the new functionality
(without requiring boot parameters) before v4.10.

Of course, if a better fix is far off and the patch below is much
better in the interim (avoids memory corruption, fixes problems for
more people, etc.), I will replace the revert with it.  I just
haven't seen the argument for doing that.

My main point is that Kilian found a pretty serious regression and
spent a lot of time bisecting it and testing things, and we need to
address it in some way before v4.10.

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] PCI / PM: Disable power management of PCIe ports by default
> 
> Due to regressions introduced by enabling power management of
> PCIe ports by default, disable it for the time being, but still
> allow it to be enabled via a kernel command line option.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=190861
> Tentatively-signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This particular patch hasn't been tested, but the result of it should be the
> same as passing pcie_port_pm=off in the kernel command line, which has
> been tested in the BZ entry above.
> 
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    3 --
>  drivers/pci/pci.c                               |   26 +++++-------------------
>  2 files changed, 7 insertions(+), 22 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -108,17 +108,14 @@ unsigned int pcibios_max_latency = 255;
>  /* If set, the PCIe ARI capability will not be used. */
>  static bool pcie_ari_disabled;
>  
> -/* Disable bridge_d3 for all PCIe ports */
> -static bool pci_bridge_d3_disable;
> -/* Force bridge_d3 for all PCIe ports */
> -static bool pci_bridge_d3_force;
> +/* Enable bridge_d3 for all PCIe ports */
> +static bool pci_bridge_d3_enable;
>  
>  static int __init pcie_port_pm_setup(char *str)
>  {
> -	if (!strcmp(str, "off"))
> -		pci_bridge_d3_disable = true;
> -	else if (!strcmp(str, "force"))
> -		pci_bridge_d3_force = true;
> +	if (!strcmp(str, "on"))
> +		pci_bridge_d3_enable = true;
> +
>  	return 1;
>  }
>  __setup("pcie_port_pm=", pcie_port_pm_setup);
> @@ -2237,7 +2234,7 @@ bool pci_bridge_d3_possible(struct pci_d
>  	case PCI_EXP_TYPE_ROOT_PORT:
>  	case PCI_EXP_TYPE_UPSTREAM:
>  	case PCI_EXP_TYPE_DOWNSTREAM:
> -		if (pci_bridge_d3_disable)
> +		if (!pci_bridge_d3_enable)
>  			return false;
>  
>  		/*
> @@ -2247,17 +2244,6 @@ bool pci_bridge_d3_possible(struct pci_d
>  		if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
>  			return false;
>  
> -		if (pci_bridge_d3_force)
> -			return true;
> -
> -		/*
> -		 * It should be safe to put PCIe ports from 2015 or newer
> -		 * to D3.
> -		 */
> -		if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
> -		    year >= 2015) {
> -			return true;
> -		}
>  		break;
>  	}
>  
> Index: linux-pm/Documentation/admin-guide/kernel-parameters.txt
> ===================================================================
> --- linux-pm.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-pm/Documentation/admin-guide/kernel-parameters.txt
> @@ -2984,8 +2984,7 @@
>  			ports driver.
>  
>  	pcie_port_pm=	[PCIE] PCIe port power management handling:
> -		off	Disable power management of all PCIe ports
> -		force	Forcibly enable power management of all PCIe ports
> +		on	Enable power management of PCIe ports
>  
>  	pcie_pme=	[PCIE,PM] Native PCIe PME signaling options:
>  		nomsi	Do not use MSI for native PCIe PME signaling (this makes
> 
