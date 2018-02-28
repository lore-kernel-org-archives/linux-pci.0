Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933687AbeB1Tx6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 14:53:58 -0500
Date: Wed, 28 Feb 2018 13:53:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Michael Moese <mmoese@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Eli Billauer <eli.billauer@gmail.com>,
        Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 1/2] PCI: add vendor id for Altera
Message-ID: <20180228195356.GH127842@bhelgaas-glaptop.roam.corp.google.com>
References: <20180228084418.7566-1-jthumshirn@suse.de>
 <20180228084418.7566-2-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180228084418.7566-2-jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

s/PCI: add vendor id for Altera/PCI: Add Altera vendor ID/

On Wed, Feb 28, 2018 at 09:44:17AM +0100, Johannes Thumshirn wrote:
> Add the Altera PCI Vendor id to pci_ids.h and remove the private
> definitions from xillybus_pcie.c and altera-cvp.c.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Eli Billauer <eli.billauer@gmail.com>
> Cc: Anatolij Gustschin <agust@denx.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Feel free to merge this along with the other.  If you'd like me to
take them, just let me know.

> ---
> Changes to v1:
> - Remove redundant pci_ids.h include (Andy)
> ---
>  drivers/char/xillybus/xillybus_pcie.c | 1 -
>  drivers/fpga/altera-cvp.c             | 2 --
>  include/linux/pci_ids.h               | 2 ++
>  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
> index dff2d1538164..05e5324f60bd 100644
> --- a/drivers/char/xillybus/xillybus_pcie.c
> +++ b/drivers/char/xillybus/xillybus_pcie.c
> @@ -24,7 +24,6 @@ MODULE_LICENSE("GPL v2");
>  
>  #define PCI_DEVICE_ID_XILLYBUS		0xebeb
>  
> -#define PCI_VENDOR_ID_ALTERA		0x1172
>  #define PCI_VENDOR_ID_ACTEL		0x11aa
>  #define PCI_VENDOR_ID_LATTICE		0x1204
>  
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 00e73d28077c..77b04e4b3254 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -384,8 +384,6 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *dev_id);
>  static void altera_cvp_remove(struct pci_dev *pdev);
>  
> -#define PCI_VENDOR_ID_ALTERA	0x1172
> -
>  static struct pci_device_id altera_cvp_id_tbl[] = {
>  	{ PCI_VDEVICE(ALTERA, PCI_ANY_ID) },
>  	{ }
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a6b30667a331..6a96a70fb462 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1561,6 +1561,8 @@
>  #define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
>  #define PCI_DEVICE_ID_SERVERWORKS_HT1100LD 0x0408
>  
> +#define PCI_VENDOR_ID_ALTERA		0x1172
> +
>  #define PCI_VENDOR_ID_SBE		0x1176
>  #define PCI_DEVICE_ID_SBE_WANXL100	0x0301
>  #define PCI_DEVICE_ID_SBE_WANXL200	0x0302
> -- 
> 2.13.6
> 
