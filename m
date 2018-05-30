Return-Path: <SRS0=sOCM=IR=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=sOCM=IR=h08.hostsharing.net=foo00@kernel.org>
Date: Wed, 30 May 2018 20:32:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Oza Pawandeep <poza@codeaurora.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI/AER: Decode Error Source Requester ID
Message-ID: <20180530183241.GA20222@wunner.de>
References: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152770285586.80701.6545710900591672975.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152770285586.80701.6545710900591672975.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 12:54:15PM -0500, Bjorn Helgaas wrote:
>  void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	pci_info(dev, "AER: %s%s error received: id=%04x\n",
> +	u8 bus = info->id >> 8;
> +	u8 devfn = info->id & 0xff;
> +
> +	pci_info(dev, "AER: %s%s error received: %04x:%02x:%02x.%d\n",
>  		info->multi_error_valid ? "Multiple " : "",
> -		aer_error_severity_string[info->severity], info->id);
> +		aer_error_severity_string[info->severity],
> +		pci_domain_nr(dev->bus), bus, devfn >> 3, devfn & 0x7);

I think PCI_SLOT(devfn), PCI_FUNC(devfn) is a bit more readable.
