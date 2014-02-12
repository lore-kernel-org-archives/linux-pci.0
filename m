Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 12 Feb 2014 12:14:25 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Fix cut-and-paste errors in documentation
Message-ID: <20140212191425.GA5554@google.com>
References: <1392201325-11173-1-git-send-email-agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392201325-11173-1-git-send-email-agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 12, 2014 at 11:35:25AM +0100, Alexander Gordeev wrote:
> Function pci_enable_msi_range() is used in examples where
> pci_enable_msix_range() should have been used instead.
> 
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Applied to pci/misc for v3.15, thanks!

Bjorn

> ---
>  Documentation/PCI/MSI-HOWTO.txt |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
> index a8d0100..43c5a5f 100644
> --- a/Documentation/PCI/MSI-HOWTO.txt
> +++ b/Documentation/PCI/MSI-HOWTO.txt
> @@ -257,8 +257,8 @@ possible, likely up to the limit returned by pci_msix_vec_count() function:
>  
>  static int foo_driver_enable_msix(struct foo_adapter *adapter, int nvec)
>  {
> -	return pci_enable_msi_range(adapter->pdev, adapter->msix_entries,
> -				    1, nvec);
> +	return pci_enable_msix_range(adapter->pdev, adapter->msix_entries,
> +				     1, nvec);
>  }
>  
>  Note the value of 'minvec' parameter is 1.  As 'minvec' is inclusive,
> @@ -269,8 +269,8 @@ In this case the function could look like this:
>  
>  static int foo_driver_enable_msix(struct foo_adapter *adapter, int nvec)
>  {
> -	return pci_enable_msi_range(adapter->pdev, adapter->msix_entries,
> -				    FOO_DRIVER_MINIMUM_NVEC, nvec);
> +	return pci_enable_msix_range(adapter->pdev, adapter->msix_entries,
> +				     FOO_DRIVER_MINIMUM_NVEC, nvec);
>  }
>  
>  4.3.1.2 Exact number of MSI-X interrupts
> @@ -282,8 +282,8 @@ parameters:
>  
>  static int foo_driver_enable_msix(struct foo_adapter *adapter, int nvec)
>  {
> -	return pci_enable_msi_range(adapter->pdev, adapter->msix_entries,
> -				    nvec, nvec);
> +	return pci_enable_msix_range(adapter->pdev, adapter->msix_entries,
> +				     nvec, nvec);
>  }
>  
>  4.3.1.3 Specific requirements to the number of MSI-X interrupts
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
