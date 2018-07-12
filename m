Return-Path: <SRS0=B3Fm=J4=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=B3Fm=J4=intel.com=keith.busch@kernel.org>
Date: Thu, 12 Jul 2018 15:57:01 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
	poza@codeaurora.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2, 0/1] PCI/AER: fix use-after-free in
 pcie_do_fatal_recovery
Message-ID: <20180712215700.GA17092@localhost.localdomain>
References: <1531416823-17841-1-git-send-email-thomas.tai@oracle.com>
 <20180712215151.GD28466@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180712215151.GD28466@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 12, 2018 at 04:51:51PM -0500, Bjorn Helgaas wrote:
> However, I think we're also slightly exposed in dpc_work(), in basically
> the same (possibly harmless) way.
> 
>   dpc_irq
>     schedule_work(&dpc->work)
>   ...
>   dpc_work
>     pdev = dpc->dev->port
>     pcie_do_fatal_recovery(pdev)
> 
> pdev may be removed by pcie_do_fatal_recovery(), but dpc_work() is still
> holding onto a pointer (which it never uses again).
> 
> The DPC driver should be holding a reference to pdev (through some black
> magic I don't understand), but that would be released when pdev is removed,
> and I don't know what ensures that dpc_work() runs before that release.
> 
> Bjorn

Yep, you're right on that point. There's different ways we can fix
that. The most recent one I proposed was to replace the scheduled work
with the threaded irq[1]. That should make it safe since the lifetime of
when bottom half can be executed is tied to the lifetime of the device
that registered it.

 1. https://patchwork.kernel.org/patch/10478755/
