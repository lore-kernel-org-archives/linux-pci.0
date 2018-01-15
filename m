Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180115162006.45553-1-Yazen.Ghannam@amd.com>
References: <20180115162006.45553-1-Yazen.Ghannam@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Jan 2018 17:47:25 +0100
Message-ID: <CAJZ5v0jDaxOV4k5Od4Ku0p=2wUcQefW-BHUev8gnP1RAP89Lmg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/ACPI: Disable AER when _OSC control bit is clear.
To: Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 15, 2018 at 5:20 PM, Yazen Ghannam <Yazen.Ghannam@amd.com> wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>
> Currently, aer_service_init() checks if AER is available and that
> Firmware First handling is not enabled. The _OSC request for AER is not
> taken into account when deciding to enable AER in Linux.
>
> From ACPI 6.2 Section 6.2.11.3, "If any bits in the Control Field are
> returned cleared (masked to zero) by the _OSC control method, the
> respective feature is designated unsupported by the platform and must
> not be enabled by the OS."
>
> The OS and the Platform should agree that the OS can have control of AER
> otherwise we should disable AER in the OS.
>
> Mark AER as disabled if the _OSC request was not made or accepted.
>
> This covers two cases where the OS and Platform disagree:
> 1) The OS requests AER control and Platform denies the request.
> 2) The OS does not request AER control but the Platform returns the AER
>    control bit set, possibly due to a Firmware bug.
>
> The _OSC control for AER is not requested when APEI Firmware First is
> used, so the same condition applies from case 2 above.
>
> Remove redundant check for aer_acpi_firmware_first() when calling
> aer_service_init(), since this check is already included when checking
> the _OSC control.
>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Bjorn, what do you think?

> ---
> Link:
> https://lkml.kernel.org/r/20180111150316.19951-1-Yazen.Ghannam@amd.com
>
> v1->v2:
> * Expand commit message.
> * Add Spec reference to commit message.
> * Fix spelling error in commit message.
> * Add comment for 3-way bitwise AND.
>
>  drivers/acpi/pci_root.c       | 7 +++++++
>  drivers/pci/pcie/aer/aerdrv.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 6fc204a52493..ab0192fd24c7 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -512,6 +512,13 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>                  */
>                 *no_aspm = 1;
>         }
> +
> +       /*
> +        * We can use a 3-way bitwise AND to check that the AER control bit is
> +        * both requested by the OS and granted by the Platform.
> +        */
> +       if (!(requested & control & OSC_PCI_EXPRESS_AER_CONTROL))
> +               pci_no_aer();
>  }
>
>  static int acpi_pci_root_add(struct acpi_device *device,
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 6ff5f5b4f5e6..39bb059777d0 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -374,7 +374,7 @@ static void aer_error_resume(struct pci_dev *dev)
>   */
>  static int __init aer_service_init(void)
>  {
> -       if (!pci_aer_available() || aer_acpi_firmware_first())
> +       if (!pci_aer_available())
>                 return -ENXIO;
>         return pcie_port_service_register(&aerdriver);
>  }
> --
