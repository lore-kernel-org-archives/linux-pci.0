Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46476 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932415Ab2DYXff convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Apr 2012 19:35:35 -0400
Received: by lahj13 with SMTP id j13so538282lah.19
        for <linux-pci@vger.kernel.org>; Wed, 25 Apr 2012 16:35:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1335376563-27274-1-git-send-email-prarit@redhat.com>
References: <1335376563-27274-1-git-send-email-prarit@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Apr 2012 17:35:13 -0600
Message-ID: <CAErSpo7eyENR-R4agG4SdauW3q+WZXjgvUXKeZwJvgQkY2imKw@mail.gmail.com>
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, ddutile@redhat.com, matthew@wil.cx,
	eike-kernel@sf-tec.de, jim.paradis@stratus.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 25, 2012 at 11:56 AM, Prarit Bhargava <prarit@redhat.com> wrote:
> This patch died on the vine after some reviews.  The last version of this
> patch was posted here:
>
> http://marc.info/?l=linux-pci&m=132148921701034&w=2

Sorry this fell through the cracks.  I fiddled with it some more and
tried to understand the topology more clearly.  I'll post it right
now; please take a look and tell me where I screwed up :)

Bjorn

> -----8<-----
>
> pci: Workaround Stratus broken PCIE hierarchy
>
> Stratus systems have a hierarchy that includes a PCIE Downstream bridge
> connected to a PCIE Upstream bridge and a PCI Downstream bridge.  The
> system boots with this wrong hierarchy into a crippled mode (USB doesn't
> work, network doesn't work ...).  Avoiding the Downstream bridge check in
> only_one_child() causes all the bridges to be enumerated and the system to
> function properly.
>
> Unfortunately this hardware is currently available so we should at least
> keep it functional.
>
> [v2]
> - ddutile@redhat.com requested drivers/pci/quirks.c code
> - matthew@wil.cx requested that dmi_name_in_vendors() be called only once with a static var check
> - added a kernel parameter to enable scanning of all PCIE devices.
>
> [v3]
> - matthew@wil.cx requested a clean up of is_broken_pcie_port(
> - eike-kernel@sf-tec.de requested a clean up of the printk level and message
>
> [v4]
> - ddutile pointed out a logic error in is_broken_pcie_port.  It was no longer
> being called only once on failure.
>
> Cc: ddutile@redhat.com
> Cc: matthew@wil.cx
> Cc: eike-kernel@sf-tec.de
> Cc: bhelgaas@google.com
> Cc: jim.paradis@stratus.com
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  Documentation/kernel-parameters.txt |    1 +
>  drivers/pci/pci.c                   |    3 +++
>  drivers/pci/pci.h                   |    5 +++++
>  drivers/pci/probe.c                 |    9 +++++++--
>  drivers/pci/quirks.c                |   18 ++++++++++++++++++
>  include/linux/pci.h                 |    2 ++
>  6 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index c1601e5..1284b2e 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2161,6 +2161,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>                                on: Turn realloc on
>                realloc         same as realloc=on
>                noari           do not use PCIe ARI.
> +               pcie_scan_all   Scan all possible PCIE devices.
>
>        pcie_aspm=      [PCIE] Forcibly enable or disable PCIe Active State Power
>                        Management.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 111569c..82e89ad 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3893,6 +3893,9 @@ static int __init pci_setup(char *str)
>                                pcie_bus_config = PCIE_BUS_PERFORMANCE;
>                        } else if (!strncmp(str, "pcie_bus_peer2peer", 18)) {
>                                pcie_bus_config = PCIE_BUS_PEER2PEER;
> +                       } else if (!strncmp(str, "pcie_scan_all", 13)) {
> +                               printk(KERN_INFO HW_ERR "PCIE: User request scan of all PCIE devices.  Your PCIE hardware is broken if you require this to boot.\n");
> +                               pcie_scan_all = 1;
>                        } else {
>                                printk(KERN_ERR "PCI: Unknown option `%s'\n",
>                                                str);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e494347..a1baad2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -319,11 +319,16 @@ struct pci_dev_reset_methods {
>
>  #ifdef CONFIG_PCI_QUIRKS
>  extern int pci_dev_specific_reset(struct pci_dev *dev, int probe);
> +extern int is_broken_pcie_port(void);
>  #else
>  static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
>  {
>        return -ENOTTY;
>  }
> +static inline int is_broken_pcie_port(void)
> +{
> +       return 0;
> +}
>  #endif
>
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5e1ca3c..07c6245 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1392,13 +1392,18 @@ static unsigned no_next_fn(struct pci_dev *dev, unsigned fn)
>        return 0;
>  }
>
> +int pcie_scan_all; /* set via pci=pcie_scan_all */
>  static int only_one_child(struct pci_bus *bus)
>  {
>        struct pci_dev *parent = bus->self;
> +       if (pcie_scan_all)
> +               return 0;
>        if (!parent || !pci_is_pcie(parent))
>                return 0;
> -       if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
> -           parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM)
> +       if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
> +               return 1;
> +       if (parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM &&
> +           !is_broken_pcie_port())
>                return 1;
>        return 0;
>  }
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4bf7102..d60e99c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3109,3 +3109,21 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
>
>        return -ENOTTY;
>  }
> +
> +static int is_broken_pcie_port_called;
> +int is_broken_pcie_port(void)
> +{
> +       if (is_broken_pcie_port_called)
> +               return pcie_scan_all;
> +       /*
> +        * Stratus/NEC ftServer systems have a broken PCIE hierarchy in which
> +        * one upstream and one downstream port are plugged into a downstream
> +        * port.  Avoiding the downstream port check in only_one_child() results
> +        * in a functional system.
> +        */
> +       if (dmi_name_in_vendors("ftServer"))
> +               pcie_scan_all = 1;
> +
> +       is_broken_pcie_port_called = 1;
> +       return pcie_scan_all;
> +}
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e444f5b..bb3daa7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1720,5 +1720,7 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>  */
>  struct pci_dev *pci_find_upstream_pcie_bridge(struct pci_dev *pdev);
>
> +/* set via pci=pcie_scan_all in order to enumerate all possible PCIE busses */
> +extern int pcie_scan_all;
>  #endif /* __KERNEL__ */
>  #endif /* LINUX_PCI_H */
> --
> 1.7.1
>
