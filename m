Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.185]:64141 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeDIKCP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 06:02:15 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Keith Busch' <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: RE: [PATCHv2 6/7] PCI/AER: API for obtaining AER information
Date: Mon, 9 Apr 2018 10:03:14 +0000
Message-ID: <bc217ceacda04d9884331f5b6bff30d3@AcuMS.aculab.com>
References: <20180402162203.3370-1-keith.busch@intel.com>
 <20180402162203.3370-7-keith.busch@intel.com>
In-Reply-To: <20180402162203.3370-7-keith.busch@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Keith Busch
> Sent: 02 April 2018 17:22
> To: Linux PCI; Bjorn Helgaas
> 
> Since this is making the function externally visible, appending "aer_"
> prefix to the function name.
> 
...
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index a4bfea52e7d4..4fb24003cac3 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -638,7 +638,7 @@ static void aer_recover_work_func(struct work_struct *work)
>  #endif
> 
>  /**
> - * get_device_error_info - read error status from dev and store it to info
> + * aer_get_device_error_info - read error status from dev and store it to info
>   * @dev: pointer to the device expected to have a error record
>   * @info: pointer to structure to store the error record
>   *
> @@ -646,7 +646,7 @@ static void aer_recover_work_func(struct work_struct *work)
>   *
>   * Note that @info is reused among all error devices. Clear fields properly.
>   */
> -static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
> +int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	int pos, temp;
> 
> @@ -705,11 +705,11 @@ static inline void aer_process_err_devices(struct pcie_device *p_device,
> 
>  	/* Report all before handle them, not to lost records by reset etc. */
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -		if (get_device_error_info(e_info->dev[i], e_info))
> +		if (aer_get_device_error_info(e_info->dev[i], e_info))
>  			aer_print_error(e_info->dev[i], e_info);
>  	}
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -		if (get_device_error_info(e_info->dev[i], e_info))
> +		if (aer_get_device_error_info(e_info->dev[i], e_info))
>  			handle_error_source(p_device, e_info->dev[i], e_info);
>  	}
>  }

Should there be an EXPORT_SYMBOL(aer_get_device_error_info) here?
(preferable without _GPL).

	David
