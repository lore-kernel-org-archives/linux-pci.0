Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0212FC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 13:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF03A20850
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 13:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfDJNqp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:46:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:59623 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728787AbfDJNqo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 09:46:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 06:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="130180783"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 10 Apr 2019 06:46:40 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hEDYk-0007qG-Ro; Wed, 10 Apr 2019 16:46:38 +0300
Date:   Wed, 10 Apr 2019 16:46:38 +0300
From:   Andriy Shevchenko <andriy.shevchenko@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     bhelgaas@google.com, Mike Marciniszyn <mike.marciniszyn@intel.com>,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>, dledford@redhat.com,
        Kamenee Arumugam <kamenee.arumugam@intel.com>
Subject: Re: [PATCH for-next 1/2] PCI/AER: Helper function for configuring
 AER registers
Message-ID: <20190410134638.GJ9224@smile.fi.intel.com>
References: <20190410123253.26818.37261.stgit@scvm10.sc.intel.com>
 <20190410123440.26818.67664.stgit@scvm10.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410123440.26818.67664.stgit@scvm10.sc.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 10, 2019 at 05:34:50AM -0700, Dennis Dalessandro wrote:
> From: Kamenee Arumugam <kamenee.arumugam@intel.com>
> 
> In some use cases, drivers may need to change the default
> AER settings. Introduce a helper function for setting
> and clearing the AER configuration registers.
> 
> Access to the AER registers is not serialized. If multiple
> access is required, correct locking must be done.
> 

FWIW,
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>

Thanks.

> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Cc: Andriy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Kamenee Arumugam <kamenee.arumugam@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/pci/pcie/aer.c |   33 +++++++++++++++++++++++++++++++++
>  include/linux/aer.h    |   17 +++++++++++++++++
>  2 files changed, 50 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f8fc211..b0435f9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -353,6 +353,39 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>  
> +/**
> + * pcie_aer_clear_and_set_dword - Set or clear AER registers
> + * @dev: pci dev data
> + * @pos: The offset of AER registers
> + * @clear: The bits to clear
> + * @set: The bits to set
> + *
> + * This function must only be used by the driver owning the device.
> + * Return:
> + * * 0 - on success
> + * * Negative error code - on generic failures
> + * * Positive error code - on PCI access errors
> + */
> +int pcie_aer_clear_and_set_dword(struct pci_dev *dev, int pos,
> +				 u32 clear, u32 set)
> +{
> +	u32 data;
> +	int ret;
> +
> +	if (!dev->aer_cap)
> +		return -EIO;
> +
> +	ret = pci_read_config_dword(dev, dev->aer_cap + pos, &data);
> +	if (!ret) {
> +		data &= ~clear;
> +		data |= set;
> +		return pci_write_config_dword(dev, dev->aer_cap + pos, data);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pcie_aer_clear_and_set_dword);
> +
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>  {
>  	if (pcie_aer_get_firmware_first(dev))
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 514bffa..e21d65c 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -46,6 +46,8 @@ struct aer_capability_regs {
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
>  int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
> +int pcie_aer_clear_and_set_dword(struct pci_dev *dev, int pos,
> +				 u32 clear, u32 set);
>  #else
>  static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> @@ -63,6 +65,12 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +
> +static inline int pcie_aer_clear_and_set_dword(struct pci_dev *dev, int pos,
> +					       u32 clear, u32 set)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  void cper_print_aer(struct pci_dev *dev, int aer_severity,
> @@ -70,5 +78,14 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>  int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs);
> +static inline int pcie_aer_set_dword(struct pci_dev *dev, int pos, u32 set)
> +{
> +	return pcie_aer_clear_and_set_dword(dev, pos, 0, set);
> +}
> +
> +static inline int pcie_aer_clear_dword(struct pci_dev *dev, int pos, u32 clear)
> +{
> +	return pcie_aer_clear_and_set_dword(dev, pos, clear, 0);
> +}
>  #endif //_AER_H_
>  
> 

-- 
With Best Regards,
Andy Shevchenko


