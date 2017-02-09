Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750940AbdBIXdv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Feb 2017 18:33:51 -0500
Date: Thu, 9 Feb 2017 17:33:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] PCI: enable extended tags support for PCIe devices
Message-ID: <20170209233346.GB29169@bhelgaas-glaptop.roam.corp.google.com>
References: <1484921814-8511-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1484921814-8511-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 20, 2017 at 09:16:51AM -0500, Sinan Kaya wrote:
> Each PCIe device can issue up to 32 transactions at a time by default.
> This limitation is historically coming from PCI. Each transaction is
> tracked by a tag number on the bus. 2.2.6.2. Transaction Descriptor
> – Transaction ID Field section of the PCIe 3.1 specification describes
> extended tags.
> 
> PCI supports 32 outstanding non-posted requests at a given time. This
> number has been extended to 256 on PCI Express. According to the
> specification, all PCIe devices are required to support receiving
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

Applied to pci/enumeration for v4.11 as follows, thanks!

I added a check for PCIe, so we don't have to rely on
pcie_capability_read_dword() doing the right thing for PCI and PCI-X
devices.  I think pcie_capability_read_dword() would set dev_cap to zero
and return zero, which would be safe, but I don't the reader should have to
do that much analysis to figure it out.

commit 8de9dcb0d1e0c92c525a826dd69ce61a21264050
Author: Sinan Kaya <okaya@codeaurora.org>
Date:   Fri Jan 20 09:16:51 2017 -0500

    PCI: Enable PCIe Extended Tags if supported
    
    Every PCIe device can generate 5-bit transaction Tags, which allow up to 32
    concurrent requests.  Some devices can generate 8-bit Extended Tags, which
    allow up to 256 concurrent requests.
    
    Per the ECN mentioned below, all PCIe Receivers are expected to support
    Extended Tags, so devices are allowed (but not required) to enable them by
    default.
    
    If a device supports Extended Tags but does not enable them by default,
    enable them.  This allows the device to have up to 256 outstanding
    transactions at a time, which may improve performance.
    
    [bhelgaas: changelog, check for PCIe device]
    Link: https://pcisig.com/sites/default/files/specification_documents/ECN_Extended_Tag_Enable_Default_05Sept2008_final.pdf
    Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
    Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index aca5b2466adb..3abc94212197 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1661,12 +1661,30 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 */
 }
 
+static void pci_configure_extended_tags(struct pci_dev *dev)
+{
+	u32 dev_cap;
+	int ret;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &dev_cap);
+	if (ret)
+		return;
+
+	if (dev_cap & PCI_EXP_DEVCAP_EXT_TAG)
+		pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
+					 PCI_EXP_DEVCTL_EXT_TAG);
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	struct hotplug_params hpp;
 	int ret;
 
 	pci_configure_mps(dev);
+	pci_configure_extended_tags(dev);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);

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
> -- 
> 1.9.1
> 
