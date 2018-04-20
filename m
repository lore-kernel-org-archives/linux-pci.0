Return-Path: <SRS0=8CyD=HJ=broadcom.com=srinath.mannam@kernel.org>
Return-Path: <SRS0=8CyD=HJ=broadcom.com=srinath.mannam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <152417192976.76853.5171081412139699180.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152417080402.76853.4258398181136860884.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152417192976.76853.5171081412139699180.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Fri, 20 Apr 2018 14:22:06 +0530
Message-ID: <CABe79T546trxQ2YSUj74SmW2qVUPkB1Mor2TP-K3SM0rerpogw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PCI/ASPM: Disable ASPM L1.2 Substate if we don't
 have LTR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Sinan Kaya <okaya@codeaurora.org>, Rajat Jain <rajatja@google.com>,
	Ray Jui <ray.jui@broadcom.com>, Keith Busch <keith.busch@intel.com>, linux-acpi@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

I have verified this patch, it works fine for me.

Thanks & Regards,
Srinath.

On Fri, Apr 20, 2018 at 2:35 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> When in the ASPM L1.0 state (but not the PCI-PM L1.0 state), the most
> recent LTR value and the LTR_L1.2_THRESHOLD determines whether the link
> enters the L1.2 substate.
>
> If we don't have LTR enabled, prevent the use of ASPM L1.2.
>
> PCI-PM L1.2 may still be used because it doesn't depend on
> LTR_L1.2_THRESHOLD (see PCIe r4.0, sec 5.5.1).
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aspm.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index f76eb7704f64..c687c817b47d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -400,6 +400,15 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
>                 info->l1ss_cap = 0;
>                 return;
>         }
> +
> +       /*
> +        * If we don't have LTR for the entire path from the Root Complex
> +        * to this device, we can't use ASPM L1.2 because it relies on the
> +        * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
> +        */
> +       if (!pdev->ltr_path)
> +               info->l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
> +
>         pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL1,
>                               &info->l1ss_ctl1);
>         pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL2,
>
