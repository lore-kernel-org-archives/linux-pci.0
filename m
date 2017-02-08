Return-Path: <SRS0=6HLn=ZV=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=6HLn=ZV=codeaurora.org=okaya@kernel.org>
Subject: Re: [V2] PCI: enable extended tags support for PCIe devices
To: linux-pci@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org,
 Bjorn Helgaas <helgaas@kernel.org>
References: <1484922050-9139-1-git-send-email-okaya@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 open list <linux-kernel@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <4a7f4c62-dd93-a834-c689-436a80889d15@codeaurora.org>
Date: Wed, 8 Feb 2017 13:25:55 -0500
MIME-Version: 1.0
In-Reply-To: <1484922050-9139-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 1/20/2017 9:20 AM, Sinan Kaya wrote:
> Each PCIe device can issue up to 32 transactions at a time by default.
> Each transaction is tracked by a tag number on the bus. 2.2.6.2.
> Transaction Descriptor – Transaction ID Field section of the PCIe 3.1
> specification describes extended tags.
> 
> 32 transaction limit has been extended to 256 on PCI Express. According
> to the specification, all PCIe devices are required to support receiving
> 8-bit Tags (Tag completer). The PCIe-PCI bridges handle the translation
> of 8-bit tags to 5-bit tags.
> 
> However, the generation of 8-bit tags is left optional to a particular HW
> implementation. The code needs to check HW support before attempting
> to enable extended tags producer capability.
> 
> 32 outstanding transactions is not enough for some performance critical
> applications especially when a lot of small sized frames are transmitted.
> 
> Extended tags support increases this number to 256. Devices not
> supporting extended tags tie-off this field to 0. According to ECN, it
> is safe to enable this feature for all PCIe devices.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/probe.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e164b5c..1192475 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1650,12 +1650,28 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
>  	 */
>  }
>  
> +static void pci_configure_extended_tags(struct pci_dev *pdev)
> +{
> +	u32 dev_cap;
> +	int ret;
> +
> +	ret = pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP, &dev_cap);
> +
> +	if (ret)
> +		return;
> +
> +	if (dev_cap & PCI_EXP_DEVCAP_EXT_TAG)
> +		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL,
> +					 PCI_EXP_DEVCTL_EXT_TAG);
> +}
> +
>  static void pci_configure_device(struct pci_dev *dev)
>  {
>  	struct hotplug_params hpp;
>  	int ret;
>  
>  	pci_configure_mps(dev);
> +	pci_configure_extended_tags(dev);
>  
>  	memset(&hpp, 0, sizeof(hpp));
>  	ret = pci_get_hp_params(dev, &hpp);
> 

Any feedback?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
