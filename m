Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52033 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab3ARWyR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Jan 2013 17:54:17 -0500
Subject: Re: [PATCH 2/2] PCI: Don't touch ASPM if forcibly disabled
From: Myron Stowe <mstowe@redhat.com>
To: Joe Lawrence <Joe.Lawrence@stratus.com>
Cc: linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	David Bulkow <david.bulkow@stratus.com>
In-Reply-To: <alpine.DEB.2.02.1301181324010.31163@jlaw-desktop.mno.stratus.com>
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
	 <alpine.DEB.2.02.1301181324010.31163@jlaw-desktop.mno.stratus.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Jan 2013 15:54:05 -0700
Message-ID: <1358549645.2393.3.camel@zim.stowe>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-01-18 at 13:24 -0500, Joe Lawrence wrote:
> From 108cca7bee5b04f45d9712507d14b5f3fbc22c29 Mon Sep 17 00:00:00 2001
> From: Joe Lawrence <joe.lawrence@stratus.com>
> Date: Tue, 15 Jan 2013 15:31:28 -0500
> Subject: [PATCH 2/2] PCI: Don't touch ASPM if forcibly disabled
> 
> Don't allocate and track PCIe ASPM state when "pcie_aspm=off" is specified on
> the kernel parameter list.
> 
> Based-on-patch-from: Matthew Garrett <mjg59@srcf.ucam.org>
> Reviewed-by: David Bulkow <david.bulkow@stratus.com>
> Signed-off-by: Joe Lawrence <joe.lawrence@stratus.com>
> ---
>  drivers/pci/pcie/aspm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 6122447..f912a93 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -556,6 +556,9 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  	struct pcie_link_state *link;
>  	int blacklist = !!pcie_aspm_sanity_check(pdev);
>  
> +	if (!aspm_support_enabled)
> +		return;
> +
>  	if (!pci_is_pcie(pdev) || pdev->link_state)
>  		return;
>  	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&

I was considering whether putting in a similar check in the
pcie_aspm_exit_link_state() would be best in order to "short circuit"
all the unnecessary processing that still occurs with ASPM turned off
and also for symmetry.  Bjorn suggested just sticking with the fix in
pcie_aspm_init_link_state() since adding something similar in
pcie_aspm_exit_link_state() may create other issues and does not help
with simplifying ASPM's implementation.

Acked-by: Myron Stowe <myron.stowe@redhat.com>


