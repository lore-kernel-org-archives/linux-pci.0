Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36135 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdGJTUb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2017 15:20:31 -0400
Received: by mail-wr0-f174.google.com with SMTP id c11so151840193wrc.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Jul 2017 12:20:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170630052436.15212-2-aik@ozlabs.ru>
References: <20170630052436.15212-1-aik@ozlabs.ru> <20170630052436.15212-2-aik@ozlabs.ru>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 10 Jul 2017 14:20:09 -0500
Message-ID: <CAErSpo6uBEMP_z0EorrKJTXy3SzOz99VqBYP7Cphutz38rEsmA@mail.gmail.com>
Subject: Re: [PATCH kernel v4 1/6] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alex Williamson <alex.williamson@redhat.com>,
        Yongji Xie <elohimes@gmail.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yongji Xie <xyjxie@linux.vnet.ibm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Fri, Jun 30, 2017 at 12:24 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> From: Yongji Xie <elohimes@gmail.com>
>
> We introduce a new pci_bus_flags, PCI_BUS_FLAGS_MSI_REMAP
> which indicates interrupts of all devices on the bus are
> managed by the hardware enabling IRQ remapping (intel naming).
> When the capability is enabled, a given PCI device can only
> shoot the MSIs assigned for it. In other words, the hardware
> can protect system from invalid MSIs of the device by checking
> the target address and data when there is something wrong
> with MSI part in device or device driver.

This needs a reference to the spec that describes how this MSI protection works.

> The new flag will be set by when the kernel decides that it is safe to
> do so.

We also need some clue about how the kernel makes this decision.  That
clue probably doesn't belong in *this* patch, but I didn't see it
anywhere.

> With this flag enabled, we can easily know whether it's safe
> to expose MSI-X tables of PCI BARs to userspace. Some usespace
> drivers such as VFIO may benefit from this.
>
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/linux/pci.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8039f9f0ca05..2c6dbb3dd0da 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -200,6 +200,7 @@ enum pci_bus_flags {
>         PCI_BUS_FLAGS_NO_MSI    = (__force pci_bus_flags_t) 1,
>         PCI_BUS_FLAGS_NO_MMRBC  = (__force pci_bus_flags_t) 2,
>         PCI_BUS_FLAGS_NO_AERSID = (__force pci_bus_flags_t) 4,
> +       PCI_BUS_FLAGS_MSI_REMAP = (__force pci_bus_flags_t) 8,
>  };
>
>  /* These values come from the PCI Express Spec */
> --
> 2.11.0
>
