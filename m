Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934058AbdC3XxK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Mar 2017 19:53:10 -0400
Date: Thu, 30 Mar 2017 18:53:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manish Jaggi <mjaggi@caviumnetworks.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        "Daney, David" <David.Daney@cavium.com>, bhelgaas@google.com
Subject: Re: [PATCH] pci: quirk cavium: Add device ID range check
Message-ID: <20170330235306.GD3912@bhelgaas-glaptop.roam.corp.google.com>
References: <43ff1f3f-b098-f25d-b9dc-9e8ef2278110@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43ff1f3f-b098-f25d-b9dc-9e8ef2278110@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 17, 2017 at 12:46:29PM +0530, Manish Jaggi wrote:
>  ACS quirk applies to devices with ID in the range a000-a0XX.
>  The patch adds a check.This matches on-chip pci devices for
>  CN81xx/CN83xx/CN88xx
> 
>  This patch adds check to
>  b404bcfbf0 : PCI: Add ACS quirk for all Cavium devices
> 
> Signed-off-by: Manish Jaggi <mjaggi@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

Applied with Alex's ack to pci/host-thunder for v4.12, thanks!

> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f754453..178242d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4094,6 +4094,9 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
>  	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
>  		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> +	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
> +		return -ENOTTY;
> +
>  	return acs_flags ? 0 : 1;
>  }
> -- 
> 2.7.4
> 
> 
