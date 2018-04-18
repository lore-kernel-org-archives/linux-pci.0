Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752487AbeDRQZt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Apr 2018 12:25:49 -0400
Date: Wed, 18 Apr 2018 11:25:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: minyard@acm.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-pci@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] pci:ipmi: Move IPMI PCI device defines to pci_ids.h
Message-ID: <20180418162547.GN28657@bhelgaas-glaptop.roam.corp.google.com>
References: <1524064680-22333-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524064680-22333-1-git-send-email-minyard@acm.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 18, 2018 at 10:18:00AM -0500, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  drivers/char/ipmi/ipmi_si_pci.c | 7 -------
>  include/linux/pci_ids.h         | 5 +++++
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> It seems better to have these definitions in pci_ids.h and not in
> the IPMI driver.
> 
> diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
> index f54ca68..e0bc101 100644
> --- a/drivers/char/ipmi/ipmi_si_pci.c
> +++ b/drivers/char/ipmi/ipmi_si_pci.c
> @@ -18,13 +18,6 @@ module_param_named(trypci, si_trypci, bool, 0);
>  MODULE_PARM_DESC(trypci, "Setting this to zero will disable the"
>  		 " default scan of the interfaces identified via pci");
>  
> -#define PCI_CLASS_SERIAL_IPMI		0x0c07
> -#define PCI_CLASS_SERIAL_IPMI_SMIC	0x0c0700
> -#define PCI_CLASS_SERIAL_IPMI_KCS	0x0c0701
> -#define PCI_CLASS_SERIAL_IPMI_BT	0x0c0702
> -
> -#define PCI_DEVICE_ID_HP_MMC 0x121A
> -
>  static void ipmi_pci_cleanup(struct si_sm_io *io)
>  {
>  	struct pci_dev *pdev = io->addr_source_data;
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 2d61d9b..bedbae9 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -117,6 +117,10 @@
>  #define PCI_CLASS_SERIAL_USB_DEVICE	0x0c03fe
>  #define PCI_CLASS_SERIAL_FIBER		0x0c04
>  #define PCI_CLASS_SERIAL_SMBUS		0x0c05
> +#define PCI_CLASS_SERIAL_IPMI		0x0c07
> +#define PCI_CLASS_SERIAL_IPMI_SMIC	0x0c0700
> +#define PCI_CLASS_SERIAL_IPMI_KCS	0x0c0701
> +#define PCI_CLASS_SERIAL_IPMI_BT	0x0c0702

I'm in favor of this part -- it makes sense to define these along with
all the other similar things.

>  #define PCI_BASE_CLASS_WIRELESS			0x0d
>  #define PCI_CLASS_WIRELESS_RF_CONTROLLER	0x0d10
> @@ -759,6 +763,7 @@
>  #define PCI_DEVICE_ID_HP_DIVA_MAESTRO	0x104B
>  #define PCI_DEVICE_ID_HP_REO_IOC	0x10f1
>  #define PCI_DEVICE_ID_HP_VISUALIZE_FXE	0x108b
> +#define PCI_DEVICE_ID_HP_MMC		0x121a

But I don't think I'd include this one because it's only used on
one driver, so by the guideline at the top of pci_ids.h, we wouldn't
include it there.

Given that, I would change the subject so it mentions "class IDs", not
"device IDs".

>  #define PCI_DEVICE_ID_HP_DIVA_HALFDOME	0x1223
>  #define PCI_DEVICE_ID_HP_DIVA_KEYSTONE	0x1226
>  #define PCI_DEVICE_ID_HP_DIVA_POWERBAR	0x1227
> -- 
> 2.7.4
> 
