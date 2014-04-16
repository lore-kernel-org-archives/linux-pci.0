Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57772 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756038AbaDPMyP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Apr 2014 08:54:15 -0400
Message-ID: <534E7CC7.7050300@intel.com>
Date: Wed, 16 Apr 2014 14:51:19 +0200
From: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
MIME-Version: 1.0
To: Alexander Gordeev <agordeev@redhat.com>,
	linux-kernel@vger.kernel.org
CC: Lukasz Dorau <lukasz.dorau@intel.com>,
	Maciej Patelczyk <maciej.patelczyk@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, intel-linux-scu@intel.com,
	linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 08/23] isci: Use pci_enable_msix_exact() instead
 of pci_enable_msix()
References: <cover.1397461652.git.agordeev@redhat.com> <8a203f9f8b7844e46676d526188965e877751edb.1397461652.git.agordeev@redhat.com>
In-Reply-To: <8a203f9f8b7844e46676d526188965e877751edb.1397461652.git.agordeev@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/14/2014 10:05 AM, Alexander Gordeev wrote:
> As result of deprecation of MSI-X/MSI enablement functions
> pci_enable_msix() and pci_enable_msi_block() all drivers
> using these two interfaces need to be updated to use the
> new pci_enable_msi_range()  or pci_enable_msi_exact()
> and pci_enable_msix_range() or pci_enable_msix_exact()
> interfaces.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Cc: Lukasz Dorau <lukasz.dorau@intel.com>
> Cc: Maciej Patelczyk <maciej.patelczyk@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: intel-linux-scu@intel.com
> Cc: linux-scsi@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/scsi/isci/init.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
> index 695b34e..4198e45 100644
> --- a/drivers/scsi/isci/init.c
> +++ b/drivers/scsi/isci/init.c
> @@ -356,7 +356,7 @@ static int isci_setup_interrupts(struct pci_dev *pdev)
>  	for (i = 0; i < num_msix; i++)
>  		pci_info->msix_entries[i].entry = i;
>  
> -	err = pci_enable_msix(pdev, pci_info->msix_entries, num_msix);
> +	err = pci_enable_msix_exact(pdev, pci_info->msix_entries, num_msix);
>  	if (err)
>  		goto intx;
>  
> 

Looks good.

Acked-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>

Thanks,
Artur
