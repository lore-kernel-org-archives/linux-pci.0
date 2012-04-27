Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36847 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759678Ab2D0Dfh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 23:35:37 -0400
Received: by obbta14 with SMTP id ta14so481731obb.19
        for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 20:35:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120425233632.12292.32916.stgit@bhelgaas.mtv.corp.google.com>
References: <20120425233632.12292.32916.stgit@bhelgaas.mtv.corp.google.com>
Date: Fri, 27 Apr 2012 11:35:36 +0800
Message-ID: <CADLM8XNoeOmJCP6+v-5TOoPaaSgo5b_xN9PrCBbDcL-fdDB37Q@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: work around Stratus ftServer broken PCIe hierarchy
From: Wei Yang <weiyang.kernel@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Matthew Wilcox <matthew.wilcox@linux.intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Myron Stowe <mstowe@redhat.com>,
	James Paradis <jim.paradis@stratus.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn

One question, both Upstream and DownStream port is represented by
pci_dev in kernel?

2012/4/26 Bjorn Helgaas <bhelgaas@google.com>:
> A PCIe downstream port is a P2P bridge.  Its secondary interface is
> a link that should lead only to device 0 (unless ARI is enabled)[1], so
> we don't probe for non-zero device numbers.
>
> Some Stratus ftServer systems have a PCIe downstream port (02:00.0) that
> leads to both an upstream port (03:00.0) and a downstream port (03:01.0),
> and 03:01.0 has important devices below it:
>
>  [0000:02]-+-00.0-[0000:03]--+-00.0
>                              \-01.0-[0000:xx]--+-[USB]
>                                                \-[NIC]
>
> Previously, we didn't enumerate device 03:01.0, so USB and the network
> didn't work.  This patch adds a DMI quirk to scan all device numbers,
> not just 0, below a downstream port.
>
> Based on a patch by Prarit Bhargava.
>
> [1] PCIe spec r3.0, sec 7.3.1
>
> CC: Myron Stowe <mstowe@redhat.com>
> CC: Don Dutile <ddutile@redhat.com>
> CC: James Paradis <jim.paradis@stratus.com>
> CC: Matthew Wilcox <matthew.wilcox@linux.intel.com>
> CC: Jesse Barnes <jbarnes@virtuousgeek.org>
> CC: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/kernel-parameters.txt |    3 +++
>  arch/x86/pci/common.c               |   16 ++++++++++++++++
>  drivers/pci/pci.c                   |    3 +++
>  drivers/pci/probe.c                 |    8 ++++++--
>  include/asm-generic/pci-bridge.h    |    6 ++++++
>  5 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index c1601e5..57c3870 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2161,6 +2161,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>                                on: Turn realloc on
>                realloc         same as realloc=on
>                noari           do not use PCIe ARI.
> +               pcie_scan_all   Scan all possible PCIE devices.  Otherwise we
> +                               only look for one device below a PCIE downstream
> +                               port.
>
>        pcie_aspm=      [PCIE] Forcibly enable or disable PCIe Active State Power
>                        Management.
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 323481e..16c5d78 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -11,6 +11,7 @@
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
>
> +#include <asm-generic/pci-bridge.h>
>  #include <asm/acpi.h>
>  #include <asm/segment.h>
>  #include <asm/io.h>
> @@ -229,6 +230,14 @@ static int __devinit assign_all_busses(const struct dmi_system_id *d)
>  }
>  #endif
>
> +static int __devinit set_scan_all(const struct dmi_system_id *d)
> +{
> +       printk(KERN_INFO "PCI: %s detected, enabling pci=pcie_scan_all\n",
> +              d->ident);
> +       pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
> +       return 0;
> +}
> +
>  static const struct dmi_system_id __devinitconst pciprobe_dmi_table[] = {
>  #ifdef __i386__
>  /*
> @@ -420,6 +429,13 @@ static const struct dmi_system_id __devinitconst pciprobe_dmi_table[] = {
>                        DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant DL585 G2"),
>                },
>        },
> +       {
> +               .callback = set_scan_all,
> +               .ident = "Stratus/NEC ftServer",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ftServer"),
> +               },
> +       },
>        {}
>  };
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9e31c0a..8f16900 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -22,6 +22,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
> +#include <asm-generic/pci-bridge.h>
>  #include <asm/setup.h>
>  #include "pci.h"
>
> @@ -3900,6 +3901,8 @@ static int __init pci_setup(char *str)
>                                pcie_bus_config = PCIE_BUS_PERFORMANCE;
>                        } else if (!strncmp(str, "pcie_bus_peer2peer", 18)) {
>                                pcie_bus_config = PCIE_BUS_PEER2PEER;
> +                       } else if (!strncmp(str, "pcie_scan_all", 13)) {
> +                               pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>                        } else {
>                                printk(KERN_ERR "PCI: Unknown option `%s'\n",
>                                                str);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5e1ca3c..2dc8675 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/cpumask.h>
>  #include <linux/pci-aspm.h>
> +#include <asm-generic/pci-bridge.h>
>  #include "pci.h"
>
>  #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
> @@ -1395,10 +1396,13 @@ static unsigned no_next_fn(struct pci_dev *dev, unsigned fn)
>  static int only_one_child(struct pci_bus *bus)
>  {
>        struct pci_dev *parent = bus->self;
> +
>        if (!parent || !pci_is_pcie(parent))
>                return 0;
> -       if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
> -           parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM)
> +       if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
> +               return 1;
> +       if (parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM &&
> +           !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
>                return 1;
>        return 0;
>  }
> diff --git a/include/asm-generic/pci-bridge.h b/include/asm-generic/pci-bridge.h
> index a5b5d5a..20db2e5 100644
> --- a/include/asm-generic/pci-bridge.h
> +++ b/include/asm-generic/pci-bridge.h
> @@ -30,6 +30,12 @@ enum {
>        PCI_ENABLE_PROC_DOMAINS = 0x00000010,
>        /* ... except for domain 0 */
>        PCI_COMPAT_DOMAIN_0     = 0x00000020,
> +
> +       /* PCIe downstream ports are bridges that normally lead to only a
> +        * device 0, but if this is set, we scan all possible devices, not
> +        * just device 0.
> +        */
> +       PCI_SCAN_ALL_PCIE_DEVS  = 0x00000040,
>  };
>
>  #ifdef CONFIG_PCI
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Richard Yang
Help You, Help Me
