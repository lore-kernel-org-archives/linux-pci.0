Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdBCRcr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 12:32:47 -0500
Date: Fri, 3 Feb 2017 11:32:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan =?iso-8859-1?Q?R=FCth?= <rueth@comsys.rwth-aachen.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/aspm: Fix null pointer dereference during
 re-enumeration of PCI bus in pcie_aspm_init_link_state even though ASPM is
 off
Message-ID: <20170203173243.GB10291@bhelgaas-glaptop.roam.corp.google.com>
References: <8dd91424-b38c-4875-9752-9cc42a6f5701@comsys.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <8dd91424-b38c-4875-9752-9cc42a6f5701@comsys.rwth-aachen.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 03, 2017 at 09:09:49AM +0100, Jan Rüth wrote:
> This patch fixes a null pointer dereference during PCI bus enumeration
> when ASPM is off. On an IBM x3850 8664 this bug causes the kernel to
> halt, this behavior did not appear in 3.10, so this is a regression.
> 
> pcie_aspm_sanity_check should only be called if ASPM is on.
> 
> Signed-off-by: Jan Rueth <rueth@comsys.rwth-aachen.de>

We have https://bugzilla.kernel.org/show_bug.cgi?id=187731 for this issue.

Per the dmesg attached there, you're booting with "pcie_aspm=off".
This patch fixes the NULL pointer dereference in that case, but I'm
concerned that we may still trip over it if you boot without
"pcie_aspm=off".

I want to make sure we fix both cases.  Can you please try a boot
with this patch but without "pcie_aspm=off"?

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
