Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49884 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbcFKADc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 20:03:32 -0400
Date: Fri, 10 Jun 2016 19:03:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: trivial@kernel.org, bhelgaas@google.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0289/1529] Fix typo
Message-ID: <20160611000327.GD16462@localhost>
References: <20160521121539.15485-1-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160521121539.15485-1-andrea.gelmini@gelma.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 21, 2016 at 02:15:39PM +0200, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>

Applied to pci/misc for v4.8, thanks, Andrea.

> ---
>  arch/x86/pci/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 8196054..7b6a9d1 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -133,7 +133,7 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev)
>  	if (pci_probe & PCI_NOASSIGN_BARS) {
>  		/*
>  		* If the BIOS did not assign the BAR, zero out the
> -		* resource so the kernel doesn't attmept to assign
> +		* resource so the kernel doesn't attempt to assign
>  		* it later on in pci_assign_unassigned_resources
>  		*/
>  		for (bar = 0; bar <= PCI_STD_RESOURCE_END; bar++) {
> -- 
> 2.8.2.534.g1f66975
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
