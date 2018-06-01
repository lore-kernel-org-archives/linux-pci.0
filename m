Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36076 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbeFAPMZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jun 2018 11:12:25 -0400
MIME-Version: 1.0
In-Reply-To: <20180601150129.10486-1-mr.nuke.me@gmail.com>
References: <20180601150129.10486-1-mr.nuke.me@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 18:12:24 +0300
Message-ID: <CAHp75VfzqbXmoEKE791gCPzg9Sn+Anb9evzfuocbO+F2XJVomw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Check for PCIe downtraining conditions
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 1, 2018 at 6:01 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
> PCIe downtraining happens when both the device and PCIe port are
> capable of a larger bus width or higher speed than negotiated.
> Downtraining might be indicative of other problems in the system, and
> identifying this from userspace is neither intuitive, nor straigh
> forward.
>
> The easiest way to detect this is with pcie_print_link_status(),
> since the bottleneck is usually the link that is downtrained. It's not
> a perfect solution, but it works extremely well in most cases.

> +static void pcie_check_upstream_link(struct pci_dev *dev)
> +{

> +

This is redundant, but...

> +       if (!pci_is_pcie(dev))
> +               return;
> +
> +       /* Look from the device up to avoid downstream ports with no devices. */
> +       if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
> +           (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
> +           (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
> +               return;

...wouldn't be better

int type = pci_pcie_type(dev);

?

But also possible, looking at existing code,

static inline bool pci_is_pcie_type(dev, type)
{
  return pci_is_pcie(dev) ? pci_pcie_type(dev) == type : false;
}

-- 
With Best Regards,
Andy Shevchenko
