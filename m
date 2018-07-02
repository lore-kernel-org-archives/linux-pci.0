Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 2 Jul 2018 08:19:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Fix aerdrv loading with "pcie_ports=native"
 parameter
Message-ID: <20180702131923.GB15983@bhelgaas-glaptop.roam.corp.google.com>
References: <20180619195835.5423-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180619195835.5423-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 19, 2018 at 02:58:20PM -0500, Alexandru Gagniuc wrote:
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
> ---
>  drivers/pci/pcie/aer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Changes since v1:
>  - Re-tested with latest and greatest (v4.18-rc1) -- works great
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e88386af28..98ced0f7c850 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -291,7 +291,7 @@ static void aer_set_firmware_first(struct pci_dev *pci_dev)
>  
>  	rc = apei_hest_parse(aer_hest_parse, &info);
>  
> -	if (rc)
> +	if (rc || pcie_ports_native)
>  		pci_dev->__aer_firmware_first = 0;
>  	else
>  		pci_dev->__aer_firmware_first = info.firmware_first;
> @@ -327,6 +327,9 @@ bool aer_acpi_firmware_first(void)
>  		apei_hest_parse(aer_hest_parse, &info);
>  		aer_firmware_first = info.firmware_first;
>  		parsed = true;
> +		if (pcie_ports_native)
> +			aer_firmware_first = 0;

Trivial comment for both of these hunks: if we test for
pcie_ports_native *first*, we won't have to run apei_hest_parse().
It's fairly obvious that we ignore the result of apei_hest_parse()
anyway, but I think it's a courtesy to the reader if we don't run it
at all, so we don't have to worry about side effects.

> +
>  	}
>  	return aer_firmware_first;
>  }
> -- 
> 2.14.3
> 
