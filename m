Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbdH3OkO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Aug 2017 10:40:14 -0400
Date: Wed, 30 Aug 2017 08:40:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jan Glauber <jglauber@cavium.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.daney@cavium.com,
        Jon Masters <jcm@redhat.com>,
        Robert Richter <robert.richter@cavium.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: Avoid slot reset for Cavium cn8xxx root
 ports
Message-ID: <20170830084012.19d91759@w520.home>
In-Reply-To: <20170830142454.10971-4-jglauber@cavium.com>
References: <20170830142454.10971-1-jglauber@cavium.com>
        <20170830142454.10971-4-jglauber@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 30 Aug 2017 16:24:54 +0200
Jan Glauber <jglauber@cavium.com> wrote:

> Root ports of cn8xxx do not function after a slot reset when used with
> some e1000e and LSI HBA devices. Add a quirk to prevent slot reset on
> these root ports.
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/pci/quirks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 85191b8..6679971 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -845,6 +845,22 @@ static void quirk_cavium_sriov_rnm_link(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xa018, quirk_cavium_sriov_rnm_link);
>  #endif
>  
> +/*
> + * Root port on some Cavium CN8xxx chips do not successfully complete
> + * a bus reset when used with certain types of child devices. Config
> + * space access to the child may quit responding. Flag all devices under
> + * the secondary bus as non-resettable.
> + */
> +static void quirk_CN8xxx_secondary_bus(struct pci_dev *dev)
> +{
> +	struct pci_dev *pdev;
> +
> +	dev_warn(&dev->dev, "Cavium CN8xxx quirk detected; reset for devices on secondary bus disabled\n");
> +	list_for_each_entry(pdev, &dev->subordinate->devices, bus_list)
> +		pdev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_CN8xxx_secondary_bus);
> +
>  /*
>   * Some settings of MMRBC can lead to data corruption so block changes.
>   * See AMD 8131 HyperTransport PCI-X Tunnel Revision Guide


This doesn't seem reliable, doesn't the user just need to remove and
reprobe the slot and the device would re-appear without this flag set?
Thanks,

Alex
