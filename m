Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 17 Mar 2017 16:27:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Manish Jaggi <mjaggi@caviumnetworks.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Daney, David" <David.Daney@cavium.com>, bhelgaas@google.com
Subject: Re: [PATCH] pci: quirk cavium: Add device ID range check
Message-ID: <20170317162755.60423972@t450s.home>
In-Reply-To: <43ff1f3f-b098-f25d-b9dc-9e8ef2278110@caviumnetworks.com>
References: <43ff1f3f-b098-f25d-b9dc-9e8ef2278110@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 17 Mar 2017 12:46:29 +0530
Manish Jaggi <mjaggi@caviumnetworks.com> wrote:

>   ACS quirk applies to devices with ID in the range a000-a0XX.
>   The patch adds a check.This matches on-chip pci devices for
>   CN81xx/CN83xx/CN88xx
> 
>   This patch adds check to
>   b404bcfbf0 : PCI: Add ACS quirk for all Cavium devices
> 
> Signed-off-by: Manish Jaggi <mjaggi@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

Fixes: b404bcfbf035 ("PCI: Add ACS quirk for all Cavium devices")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>

Thanks

> ---
>   drivers/pci/quirks.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f754453..178242d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4094,6 +4094,9 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
>   	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
>   		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
>   
> +	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
> +		return -ENOTTY;
> +
>   	return acs_flags ? 0 : 1;
>   }
>   
