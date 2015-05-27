Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5565E2AA.5030705@redhat.com>
Date: Wed, 27 May 2015 11:28:42 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
CC: bhelgaas@google.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, lenb@kernel.org
Subject: Re: [PATCH v2 0/2] ACPI / PCI: Fix _PRT lookup for ARI enabled devices
References: <20150526210927.7537.55656.stgit@gimli.home>
In-Reply-To: <20150526210927.7537.55656.stgit@gimli.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/26/2015 05:11 PM, Alex Williamson wrote:
> v2: don't modify entry->id.device
>
> In most cases we only use ARI with SR-IOV VFs, which do not support
> INTx and therefore never hit this problem.  However, some non-SR-IOV
> implementations create multiple PFs, extending beyond the standard
> 3-bit function numbers with ARI, and do support INTx for those
> additional functions.  This can happen with Solarflare SFC9120
> adapters.  The host driver typically doesn't use INTx, so we also
> haven't noticed this problem on bare metal, but when we attempt to
> assign the device to a VM using vfio-pci, we fail trying to setup
> default INTx signaling.  Thanks,
>
> Alex
>
> ---
>
> Alex Williamson (2):
>        PCI: Move pci_ari_enabled() to global header
>        ACPI / PCI: Account for ARI in _PRT lookups
>
>
>   drivers/acpi/pci_irq.c |    2 +-
>   drivers/pci/pci.h      |   11 -----------
>   include/linux/pci.h    |   11 +++++++++++
>   3 files changed, 12 insertions(+), 12 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Feel free to add my Reviewed-by / Acked-by

-dd
