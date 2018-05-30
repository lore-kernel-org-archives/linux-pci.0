Return-Path: <SRS0=MEkt=IR=google.com=rajatja@kernel.org>
Return-Path: <SRS0=MEkt=IR=google.com=rajatja@kernel.org>
MIME-Version: 1.0
References: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152770286159.80701.8079550179741454699.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152770286159.80701.8079550179741454699.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Rajat Jain <rajatja@google.com>
Date: Wed, 30 May 2018 11:18:35 -0700
Message-ID: <CACK8Z6HhvLYkEtbROXymfn3pwz=rc8Dm_AstOe5R4tpb5aiJGg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI/AER: Stop printing vendor/device ID
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Oza Pawandeep <poza@codeaurora.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 10:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>

> The Vendor and Device ID of the root port that raised an AER interrupt is
> irrelevant and already available via normal enumeration dmesg logging or
> lspci.

Er, what is getting printed is not the vendor/device id of the root port
but that of the AER source device (the one that root port got an ERR_*
message from). In case of fatal AERs, the end point device may become
inaccessible so lspci will not be available, and enumeration logs (from
boot) may have gotten rolled over. So I think it is still better to print
this information here.

Just my opinion :-)

Thanks,

Rajat


> Remove the Vendor and Device ID from AER logging.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/pcie/aer/aerdrv_errprint.c |    5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c
b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index d7fde8368d81..16116844531c 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -175,9 +175,8 @@ void aer_print_error(struct pci_dev *dev, struct
aer_err_info *info)
>                  aer_error_severity_string[info->severity],
>                  aer_error_layer[layer], aer_agent_string[agent]);

> -       pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> -               dev->vendor, dev->device,
> -               info->status, info->mask);
> +       pci_err(dev, "  error status/mask=%08x/%08x\n", info->status,
> +               info->mask);

>          __aer_print_error(dev, info);
