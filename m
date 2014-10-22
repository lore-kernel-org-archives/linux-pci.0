Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33554 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650AbaJVXSh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Oct 2014 19:18:37 -0400
Received: by mail-ig0-f180.google.com with SMTP id uq10so419678igb.7
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2014 16:18:37 -0700 (PDT)
Date: Wed, 22 Oct 2014 17:18:30 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/3] PCI: move PCI_FIND_CAP_TTL to pci.h and use it in
 quirks
Message-ID: <20141022231830.GC4795@google.com>
References: <1413269253-8990-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1413269253-8990-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413269253-8990-2-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Tue, Oct 14, 2014 at 02:47:30PM +0800, Wei Yang wrote:
> In some quirks, it tries to search a pci cap and use a ttl value to avoid
> infinite loop. While the value is hard coded to 48, which is the same as marco
> PCI_FIND_CAP_TTL.
> 
> This patch moves the definition of PCI_FIND_CAP_TTL to pci.h and replace the
> hard coded value with it.

This seems reasonable (though I added Yinghai in case he knows of any
reason why HT capabilities should be different from plain PCI capabilities
in this respect).

But I'd prefer to have the definition in drivers/pci/pci.h rather than in
include/linux/pci.h, because both users already include drivers/pci/pci.h,
and it is less visible.

Bjorn

> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  drivers/pci/pci.c    |    1 -
>  drivers/pci/quirks.c |    8 ++++----
>  include/linux/pci.h  |    2 ++
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2c9ac70..76b002b1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -137,7 +137,6 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
>  EXPORT_SYMBOL_GPL(pci_ioremap_bar);
>  #endif
>  
> -#define PCI_FIND_CAP_TTL	48
>  
>  static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
>  				   u8 pos, int cap, int *ttl)
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 80c2d01..a5f46b8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2176,7 +2176,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x9601, quirk_amd_780_apc_msi);
>   * return 1 if a HT MSI capability is found and enabled */
>  static int msi_ht_cap_enabled(struct pci_dev *dev)
>  {
> -	int pos, ttl = 48;
> +	int pos, ttl = PCI_FIND_CAP_TTL;
>  
>  	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
>  	while (pos && ttl--) {
> @@ -2235,7 +2235,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
>  /* Force enable MSI mapping capability on HT bridges */
>  static void ht_enable_msi_mapping(struct pci_dev *dev)
>  {
> -	int pos, ttl = 48;
> +	int pos, ttl = PCI_FIND_CAP_TTL;
>  
>  	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
>  	while (pos && ttl--) {
> @@ -2314,7 +2314,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
>  
>  static int ht_check_msi_mapping(struct pci_dev *dev)
>  {
> -	int pos, ttl = 48;
> +	int pos, ttl = PCI_FIND_CAP_TTL;
>  	int found = 0;
>  
>  	/* check if there is HT MSI cap or enabled on this device */
> @@ -2439,7 +2439,7 @@ out:
>  
>  static void ht_disable_msi_mapping(struct pci_dev *dev)
>  {
> -	int pos, ttl = 48;
> +	int pos, ttl = PCI_FIND_CAP_TTL;
>  
>  	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
>  	while (pos && ttl--) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 96453f9..b27b79e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -33,6 +33,8 @@
>  
>  #include <linux/pci_ids.h>
>  
> +#define PCI_FIND_CAP_TTL	48
> +
>  /*
>   * The PCI interface treats multi-function devices as independent
>   * devices.  The slot/function address of each device is encoded
> -- 
> 1.7.9.5
> 
