Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754263AbeDMN5B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Apr 2018 09:57:01 -0400
Date: Fri, 13 Apr 2018 08:56:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <ray.jui@broadcom.com>, linux-pci@vger.kernel.org
Subject: Re: Issue with Enable LTR while pcie_aspm off
Message-ID: <20180413135659.GC46420@bhelgaas-glaptop.roam.corp.google.com>
References: <CABe79T47vUjq20HuMrJZxhZWMr0q3uXMF6xL1TgkqhqA8qi1wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABe79T47vUjq20HuMrJZxhZWMr0q3uXMF6xL1TgkqhqA8qi1wg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Srinath,

On Fri, Apr 13, 2018 at 12:16:46PM +0530, Srinath Mannam wrote:
> Hi Bjorn,
> 
> In our platform we disable aspm using boot_arg "pcie_aspm=off".
> But with the below patch, LTR is enabled which is part of ASPM.
> even we keep disable aspm using "pcie_aspm=off" then why we need to
> enable LTR. This is causing issues with few NVMe cards.

Strictly speaking, the spec does not define LTR as "part of" ASPM,
although as far as I can tell, the only references to *using* the LTR
information are related to ASPM L1 substates.

I think the reason I made this patch enable LTR regardless of the
initial ASPM settings is because the ASPM settings can be changed at
run-time via sysfs (see pcie_aspm_set_policy()).

If we enable L1 substates at run-time, LTR has to be enabled somehow,
either at enumeration-time (as we currently do) or by some similar
code in the pcie_aspm_set_policy() path.

LTR consumes some PCIe bandwidth, so it's not free, and I do agree
that it seems pointless to enable it if nothing is going to use the
information.

What sort of issues are you seeing?  Are the issues caused by hardware
defects, e.g., things that don't conform to the PCIe spec, or are they
caused by a software defect, e.g., something done wrong in the patch
below, or maybe some requirement that LTR not be enabled unless ASPM
L1 substates are enabled?

If the issues are related to hardware defects with LTR itself, maybe a
quirk would be the best way to approach it.  That would make it clear
what the actual problem is and may allow us to do a better job of
working around it.  For example, maybe we could enable some ASPM
states, but not those requiring LTR.  Or maybe we could enable ASPM in
some parts of the system, but not for the devices that have LTR
issues.

Also, it could potentially remove the need for you to use the
"pcie_aspm=off" parameter, which would improve the user experience.

> Please advice us how can we proceed in this scenario.
> 
> commit c46fd358070f22ba68d6e74c22016a33b914c20a
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Nov 28 16:43:50 2017 -0600
> 
>     PCI/ASPM: Enable Latency Tolerance Reporting when supported
> 
>     Enable Latency Tolerance Reporting (LTR).  Note that LTR must be enabled in
>     the Root Port first, and must not be enabled in any downstream device
>     unless the Root Port and all intermediate Switches also support LTR.
>     See PCIe r3.1, sec 6.18.
> 
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 14e0ea1..3761b13 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1875,6 +1875,38 @@ static void
> pci_configure_relaxed_ordering(struct pci_dev *dev)
>         }
>  }
> 
> +static void pci_configure_ltr(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCIEASPM
> +       u32 cap;
> +       struct pci_dev *bridge;
> +
> +       if (!pci_is_pcie(dev))
> +               return;
> +
> +       pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
> +       if (!(cap & PCI_EXP_DEVCAP2_LTR))
> +               return;
> +
> +       /*
> +        * Software must not enable LTR in an Endpoint unless the Root
> +        * Complex and all intermediate Switches indicate support for LTR.
> +        * PCIe r3.1, sec 6.18.
> +        */
> +       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +               dev->ltr_path = 1;
> +       else {
> +               bridge = pci_upstream_bridge(dev);
> +               if (bridge && bridge->ltr_path)
> +                       dev->ltr_path = 1;
> +       }
> +
> +       if (dev->ltr_path)
> +               pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> +                                        PCI_EXP_DEVCTL2_LTR_EN);
> +#endif
> +}
> +
>  static void pci_configure_device(struct pci_dev *dev)
>  {
>         struct hotplug_params hpp;
> @@ -1883,6 +1915,7 @@ static void pci_configure_device(struct pci_dev *dev)
>         pci_configure_mps(dev);
>         pci_configure_extended_tags(dev, NULL);
>         pci_configure_relaxed_ordering(dev);
> 
> 
> Regards,
> Srinath.
