Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935978AbdACVEP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Jan 2017 16:04:15 -0500
Date: Tue, 3 Jan 2017 14:53:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan =?iso-8859-1?Q?R=FCth?= <rueth@comsys.rwth-aachen.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/aspm: Fix null pointer dereference during
 re-enumeration of PCI bus in pcie_aspm_init_link_state even though ASPM is
 off
Message-ID: <20170103205350.GC25398@bhelgaas-glaptop.roam.corp.google.com>
References: <4cec62c2-218a-672b-8c12-d44e8df56aae@comsys.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4cec62c2-218a-672b-8c12-d44e8df56aae@comsys.rwth-aachen.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 03, 2017 at 09:04:36AM +0100, Jan Rüth wrote:
> This patch fixes a null pointer dereference during PCI bus enumeration
> when ASPM is off. On an IBM x3850 8664 this bug causes the kernel to
> halt, this behavior did not appear in 3.10, so this is a regression.
> 
> pcie_aspm_sanity_check should only be called if ASPM is on.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=187731

> Signed-off-by: Jan Rueth <rueth@comsys.rwth-aachen.de>
> ---
>  drivers/pci/pcie/aspm.c | +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index f981129..e758b56 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -552,11 +552,12 @@ static struct pcie_link_state
> *alloc_pcie_link_state(struct pci_dev *pdev)
>  void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  {
>         struct pcie_link_state *link;
> -       int blacklist = !!pcie_aspm_sanity_check(pdev);
> -
> +       int blacklist;
>         if (!aspm_support_enabled)
>                 return;
> 
> +       blacklist = !!pcie_aspm_sanity_check(pdev);
> +
>         if (pdev->link_state)
>                 return;

For some reason this doesn't apply for me (complains about a malformed
patch), but I can apply it by hand easily enough.

However, this path is a little obtuse, and I'd like to understand
what's going on better.  We currently have:

  pci_scan_slot
    if (bus->self && nr)
      pcie_aspm_init_link_state(bus->self)
        pcie_aspm_sanity_check
	  list_for_each_entry(child, &pdev->subordinate->devices, ...)

I assume the null pointer is pdev->subordinate, so maybe we're calling
pcie_aspm_init_link_state() for a bridge where we weren't able to
create a child bus ("pdev->subordinate")?

I think it's legal to have a bridge device where we haven't set
pdev->subordinate, but it does seem unusual.

I don't see a log with the actual null pointer dereference in the
bugzilla.  Do you have any more details about which device blows up
here and why it's unusual?

Part of the reason I'm curious is that I'd like to identify the commit
that introduced the problem so we can figure out where the fix might
need to be backported.  I suspected b7206cbf024d ("PCI ASPM: support
partial aspm enablement") because it moved the
pcie_aspm_sanity_check() call before the checks for aspm_disabled, but
that's been around since 2.6 days, and the problem you're seeing
didn't happen until after 3.10.

Bjorn
