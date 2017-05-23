Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968111AbdEWT4h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 15:56:37 -0400
Date: Tue, 23 May 2017 14:56:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sujith Pandel <sujithpshankar@gmail.com>
Cc: linux-pci@vger.kernel.org, Shai@ScaleMP.com, Narendra_K@Dell.com
Subject: Re: [PATCH] Add PCI domain number check to
 find_smbios_instance_string
Message-ID: <20170523195635.GE7241@bhelgaas-glaptop.roam.corp.google.com>
References: <20170502105540.GA36230@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170502105540.GA36230@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 02, 2017 at 06:55:40AM -0400, Sujith Pandel wrote:
> The function 'find_smbios_instance_string' does not consider the
> PCI domain number. As a result, SMBIOS type 41 device type instance
> would be exported to sysfs for all the PCI domains which have a
> PCI device with same bus/device/function, though PCI bus/device/func
> from a specific PCI domain has SMBIOS type 41 device type instance
> defined.
> Address the issue by making 'find_smbios_instance_string' function
> check PCI domain number as well.
> 
> Reported-by: Shai Fultheim <Shai@ScaleMP.com>
> Suggested-by: Shai Fultheim <Shai@ScaleMP.com>
> Signed-off-by: Sujith Pandel <sujithpshankar@gmail.com>
> Signed-off-by: Narendra K <Narendra_K@Dell.com>
> Tested-by: Shai Fultheim <Shai@ScaleMP.com>

Applied to pci/misc for v4.13, thanks!

> ---
>  drivers/pci/pci-label.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index 5135737..1d828a6 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -43,9 +43,11 @@ static size_t find_smbios_instance_string(struct pci_dev *pdev, char *buf,
>  {
>  	const struct dmi_device *dmi;
>  	struct dmi_dev_onboard *donboard;
> +	int domain_nr;
>  	int bus;
>  	int devfn;
>  
> +	domain_nr = pci_domain_nr(pdev->bus);
>  	bus = pdev->bus->number;
>  	devfn = pdev->devfn;
>  
> @@ -53,8 +55,9 @@ static size_t find_smbios_instance_string(struct pci_dev *pdev, char *buf,
>  	while ((dmi = dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD,
>  				      NULL, dmi)) != NULL) {
>  		donboard = dmi->device_data;
> -		if (donboard && donboard->bus == bus &&
> -					donboard->devfn == devfn) {
> +		if (donboard && donboard->segment == domain_nr &&
> +				donboard->bus == bus &&
> +				donboard->devfn == devfn) {
>  			if (buf) {
>  				if (attribute == SMBIOS_ATTR_INSTANCE_SHOW)
>  					return scnprintf(buf, PAGE_SIZE,
> -- 
> 1.8.3.1
> 
