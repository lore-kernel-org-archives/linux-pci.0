Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43407 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeFEM1P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2018 08:27:15 -0400
MIME-Version: 1.0
In-Reply-To: <20180604155523.14906-1-mr.nuke.me@gmail.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 15:27:14 +0300
Message-ID: <CAHp75VciAimPhuMDOzYdMP=S1OWGyOUh4dN4BqfsLVOpTnRBRQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 4, 2018 at 6:55 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
> PCIe downtraining happens when both the device and PCIe port are
> capable of a larger bus width or higher speed than negotiated.
> Downtraining might be indicative of other problems in the system, and
> identifying this from userspace is neither intuitive, nor straigh
> forward.
>
> The easiest way to detect this is with pcie_print_link_status(),
> since the bottleneck is usually the link that is downtrained. It's not
> a perfect solution, but it works extremely well in most cases.

Have you seen any of my comments?
For your convenience repeating below.

>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>
> Changes since v2:
>  - Check dev->is_virtfn flag
>
> Changes since v1:
>  - Use pcie_print_link_status() instead of reimplementing logic
>
>  drivers/pci/probe.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac91b6fd0bcd..a88ec8c25dd5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2146,6 +2146,25 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>         return dev;
>  }
>
> +static void pcie_check_upstream_link(struct pci_dev *dev)
> +{

> +

This is redundant blank line.

> +       if (!pci_is_pcie(dev))
> +               return;
> +
> +       /* Look from the device up to avoid downstream ports with no devices. */
> +       if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
> +           (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
> +           (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
> +               return;

I looked briefly at the use of these calls and perhaps it might make
sense to introduce
pci_is_pcie_type(dev, type) which unifies pci_is_pcie() + pci_pcie_type().

> +
> +       /* Multi-function PCIe share the same link/status. */

> +       if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)

The one pair of parens is not needed.

> +               return;
> +
> +       pcie_print_link_status(dev);
> +}
> +
>  static void pci_init_capabilities(struct pci_dev *dev)
>  {
>         /* Enhanced Allocation */
> @@ -2181,6 +2200,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>         /* Advanced Error Reporting */
>         pci_aer_init(dev);
>
> +       /* Check link and detect downtrain errors */
> +       pcie_check_upstream_link(dev);
> +
>         if (pci_probe_reset_function(dev) == 0)
>                 dev->reset_fn = 1;
>  }
> --
> 2.14.4
>



-- 
With Best Regards,
Andy Shevchenko
