Return-Path: <SRS0=CTFa=KR=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=CTFa=KR=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 02 Aug 2018 12:04:16 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rajat Jain
 <rajatja@google.com>
Subject: Re: [PATCH] PCI/AER: Remove duplicate PCI_EXP_AER_FLAGS definition
In-Reply-To: <153307741056.12895.16173953885240310937.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153307741056.12895.16173953885240310937.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <b26226ae6c1d0a78f2ab1fac9894df7a@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-01 04:20, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> PCI_EXP_AER_FLAGS was defined twice (with identical definitions), once
> under #ifdef CONFIG_ACPI_APEI, and again at the top level.  This looks 
> like
> my merge error from these commits:
> 
>   fd3362cb73de ("PCI/AER: Squash aerdrv_core.c into aerdrv.c")
>   41cbc9eb1a82 ("PCI/AER: Squash ecrc.c into aerdrv.c")
> 
> Remove the duplicate PCI_EXP_AER_FLAGS definition.
> 
> Fixes: 41cbc9eb1a82 ("PCI/AER: Squash ecrc.c into aerdrv.c")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2b344c9e2d46..c6cc855bfa22 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -329,8 +329,6 @@ int pcie_aer_get_firmware_first(struct pci_dev 
> *dev)
>  		aer_set_firmware_first(dev);
>  	return dev->__aer_firmware_first;
>  }
> -#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE 
> | \
> -				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
> 
>  static bool aer_firmware_first;


Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
