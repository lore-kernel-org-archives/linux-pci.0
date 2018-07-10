Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 10 Jul 2018 18:19:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/AER: Fix aerdrv loading with "pcie_ports=native"
 parameter
Message-ID: <20180710231956.GD188359@bhelgaas-glaptop.roam.corp.google.com>
References: <20180703163854.GA61685@bhelgaas-glaptop.roam.corp.google.com>
 <20180703232755.2472-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180703232755.2472-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 03, 2018 at 06:27:43PM -0500, Alexandru Gagniuc wrote:
> According to the documentation, "pcie_ports=native", linux should use
> native AER and DPC services. While that is true for the _OSC method
> parsing, this is not the only place that is checked. Should the HEST
> table list PCIe ports as firmware-first, linux will not use native
> services.
> 
> This happens because aer_acpi_firmware_first() doesn't take
> 'pcie_ports' into account. This is wrong. DPC uses the same logic when
> it decides whether to load or not, so fixing this also fixes DPC not
> loading.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Applied to pci/aer for v4.19, thanks!

> ---
>  drivers/pci/pcie/aer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e88386af28..63a66a3b2fb5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -303,6 +303,9 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return 0;
>  
> +	if (pcie_ports_native)
> +		return 0;
> +
>  	if (!dev->__aer_firmware_first_valid)
>  		aer_set_firmware_first(dev);
>  	return dev->__aer_firmware_first;
> @@ -323,6 +326,9 @@ bool aer_acpi_firmware_first(void)
>  		.firmware_first	= 0,
>  	};
>  
> +	if (pcie_ports_native)
> +		return 0;
> +
>  	if (!parsed) {
>  		apei_hest_parse(aer_hest_parse, &info);
>  		aer_firmware_first = info.firmware_first;
> -- 
> 2.14.3
> 
