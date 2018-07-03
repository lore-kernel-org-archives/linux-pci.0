Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 3 Jul 2018 11:38:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/AER: Fix aerdrv loading with "pcie_ports=native"
 parameter
Message-ID: <20180703163854.GA61685@bhelgaas-glaptop.roam.corp.google.com>
References: <20180702131923.GB15983@bhelgaas-glaptop.roam.corp.google.com>
 <20180702161611.2048-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180702161611.2048-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 02, 2018 at 11:16:01AM -0500, Alexandru Gagniuc wrote:
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
>  drivers/pci/pcie/aer.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e88386af28..db2c01056dc7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -283,13 +283,14 @@ static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
>  
>  static void aer_set_firmware_first(struct pci_dev *pci_dev)
>  {
> -	int rc;
> +	int rc = 0;
>  	struct aer_hest_parse_info info = {
>  		.pci_dev	= pci_dev,
>  		.firmware_first	= 0,
>  	};
>  
> -	rc = apei_hest_parse(aer_hest_parse, &info);
> +	if (!pcie_ports_native)
> +		rc = apei_hest_parse(aer_hest_parse, &info);
>  
>  	if (rc)
>  		pci_dev->__aer_firmware_first = 0;
> @@ -324,7 +325,9 @@ bool aer_acpi_firmware_first(void)
>  	};
>  
>  	if (!parsed) {
> -		apei_hest_parse(aer_hest_parse, &info);
> +		if (!pcie_ports_native)
> +			apei_hest_parse(aer_hest_parse, &info);
> +
>  		aer_firmware_first = info.firmware_first;
>  		parsed = true;
>  	}

I was thinking something along the lines of the patch below, so we
don't have to work through the settings of "rc" and "info".  But maybe
I'm missing something subtle?

One subtle thing that I didn't look into is the
pcie_aer_get_firmware_first() stub for the non-CONFIG_ACPI_APEI case.


diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b24f2d252180..5ccbd7635f33 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -342,6 +342,9 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return 0;
 
+	if (pcie_ports_native)
+		return 0;
+
 	if (!dev->__aer_firmware_first_valid)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
@@ -362,6 +365,9 @@ bool aer_acpi_firmware_first(void)
 		.firmware_first	= 0,
 	};
 
+	if (pcie_ports_native)
+		return false;
+
 	if (!parsed) {
 		apei_hest_parse(aer_hest_parse, &info);
 		aer_firmware_first = info.firmware_first;
