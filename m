Return-Path: <SRS0=MEkt=IR=google.com=rajatja@kernel.org>
Return-Path: <SRS0=MEkt=IR=google.com=rajatja@kernel.org>
MIME-Version: 1.0
References: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152770285586.80701.6545710900591672975.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152770285586.80701.6545710900591672975.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Rajat Jain <rajatja@google.com>
Date: Wed, 30 May 2018 11:41:23 -0700
Message-ID: <CACK8Z6Gs6Wt=qQ9PJJifZT7ZazK1yGtwNZRSTtvwek8iT8oW6w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PCI/AER: Decode Error Source Requester ID
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Oza Pawandeep <poza@codeaurora.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 10:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>

> Decode the Requester ID from the AER Error Source Register into domain/
> bus/device/function format to match other logging.  In cases where the ID
> matches the device used for pci_err(), drop the extra ID completely so we
> don't print it twice.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/pcie/aer/aerdrv_errprint.c |   18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)

> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c
b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index 21ca5e1b0ded..d7fde8368d81 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -163,17 +163,17 @@ void aer_print_error(struct pci_dev *dev, struct
aer_err_info *info)
>          int id = ((dev->bus->number << 8) | dev->devfn);

>          if (!info->status) {
> -               pci_err(dev, "PCIe Bus Error: severity=%s,
type=Unaccessible, id=%04x(Unregistered Agent ID)\n",
> -                       aer_error_severity_string[info->severity], id);
> +               pci_err(dev, "PCIe Bus Error: severity=%s,
type=Inaccessible, (Unregistered Agent ID)\n",
> +                       aer_error_severity_string[info->severity]);

Does this code path indicate that a requester id was decoded to a device
that is not registered with the kernel? If so, shouldn't we log the bad
requester ID for better debugging, specifically since there is not going to
be any subsequent print about this ID (since we return from this function
in this case)?

>                  goto out;
>          }

>          layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>          agent = AER_GET_AGENT(info->severity, info->status);

> -       pci_err(dev, "PCIe Bus Error: severity=%s, type=%s,
id=%04x(%s)\n",
> +       pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>                  aer_error_severity_string[info->severity],
> -               aer_error_layer[layer], id, aer_agent_string[agent]);
> +               aer_error_layer[layer], aer_agent_string[agent]);

>          pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>                  dev->vendor, dev->device,
> @@ -186,7 +186,7 @@ void aer_print_error(struct pci_dev *dev, struct
aer_err_info *info)

>   out:
>          if (info->id && info->error_dev_num > 1 && info->id == id)
> -               pci_err(dev, "  Error of this Agent(%04x) is reported
first\n", id);
> +               pci_err(dev, "  Error of this Agent is reported first\n");

>          trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
>                          info->severity, info->tlp_header_valid,
&info->tlp);
> @@ -194,9 +194,13 @@ void aer_print_error(struct pci_dev *dev, struct
aer_err_info *info)

>   void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>   {
> -       pci_info(dev, "AER: %s%s error received: id=%04x\n",
> +       u8 bus = info->id >> 8;
> +       u8 devfn = info->id & 0xff;
> +
> +       pci_info(dev, "AER: %s%s error received: %04x:%02x:%02x.%d\n",
>                  info->multi_error_valid ? "Multiple " : "",
> -               aer_error_severity_string[info->severity], info->id);
> +               aer_error_severity_string[info->severity],
> +               pci_domain_nr(dev->bus), bus, devfn >> 3, devfn & 0x7);
>   }

>   #ifdef CONFIG_ACPI_APEI_PCIEAER
