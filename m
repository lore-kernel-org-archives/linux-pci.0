Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 22 Aug 2016 10:47:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH v2] PCI: altera: Retrain link in rootport mode only
Message-ID: <20160822154738.GB18628@localhost>
References: <1471595078-26297-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471595078-26297-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 19, 2016 at 04:24:38PM +0800, Ley Foon Tan wrote:
> Altera PCIe IP can be configured as rootport or device and they might have
> same vendor ID. It will cause the system hang issue if Altera PCIe is in
> endpoint mode and work with other PCIe rootport that from other vendors.
> So, add the rootport mode checking in link retrain fixup function.
>
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
> v2: change to check PCIe type is PCI_EXP_TYPE_ROOT_PORT
> ---
>  drivers/pci/host/pcie-altera.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> index 58eef99..33b6968 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -139,6 +139,9 @@ static void altera_pcie_retrain(struct pci_dev *dev)
>  	u16 linkcap, linkstat;
>  	struct altera_pcie *pcie = dev->bus->sysdata;
>  
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +		return;
> +
>  	if (!altera_pcie_link_is_up(pcie))
>  		return;

Instead of making this a PCI fixup, can you make an
altera_pcie_host_init() function, call it from altera_pcie_probe(),
and do the link retrain there?  Then you wouldn't need to worry about
whether this is a Root Port or an Endpoint, plus it would make the
altera driver structure more like the other drivers.

You would call altera_pcie_host_init() before pci_scan_root_bus(), so
you wouldn't have a pci_dev yet, so you wouldn't be able to use
pcie_capability_set_word() to set the PCI_EXP_LNKCTL_RL bit.  But I
assume there's some device-dependent way to access it using
cra_writel()?

Bjorn
