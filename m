Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:42234 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756262Ab3AOA33 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2013 19:29:29 -0500
Received: by mail-vc0-f173.google.com with SMTP id fl15so41643vcb.32
        for <linux-pci@vger.kernel.org>; Mon, 14 Jan 2013 16:29:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201301071014.22087.roman.fietze@telemotive.de>
References: <201301071014.22087.roman.fietze@telemotive.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 14 Jan 2013 17:29:07 -0700
Message-ID: <CAErSpo43U3FLyWo9DoK9ZRFRrDHzV4YmDHVZARLGQMMw6SPGpg@mail.gmail.com>
Subject: Re: [PATCH] aspm.c: allow to enable PCIe ASPM for PCIe bridges acting
 as an endpoint
To: Roman Fietze <roman.fietze@telemotive.de>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Kenji, Rafael, linux-pm]

On Mon, Jan 7, 2013 at 2:14 AM, Roman Fietze <roman.fietze@telemotive.de> wrote:
> Hello Linux PCI List Members,
>
> We are using a system that contains, besides some other PCIe
> components, two FPGAs connected to the PCIe via two PEX8311 bridges.
> Those PEX8311 are a kind of copy & paste design from a PEX8111 PCIe to
> PCI-X and a PEX9056 PCI-X to local bridge.
>
> I was wondering why the PEX8311's PCIe side, the PEX8111, was never
> able to activate its ASPM link states L0S or L1, or ASPM at all. The
> cause was the code now slightly modified by this patch, disabling ASPM
> for bridges.
>
> In our setup this PCIe bridge definitively acts as a PCIe endpoint,
> the PEX8311 (PEX8111) also has registers to define e.g. the L0S and L1
> timings that only exist in PCIe endpoints (and e.g. not in PCIe
> switches like a PEX8059).
>
> For the possible additional power savings see the commit message
> itself.
>
> I made this new functionality configurable so it wont disturb or risk
> existing systems. It seems that there are a few devices out there
> using a PEX8311 to connect local endpoints to a PCIe bus, at least in
> the embedded market, so this configuration option might help some of
> the developers out there.
>
> Any comments are welcome, as always.
>
>
> From 4f32a8c3db8f4f76ac9777be952fbc7b9c4db65e Mon Sep 17 00:00:00 2001
> From: Roman Fietze <roman.fietze@telemotive.de>
> Date: Mon, 7 Jan 2013 09:29:24 +0100
> Subject: [PATCH] aspm.c: allow to enable PCIe ASPM for PCIe bridges acting as an endpoint
>
> This enables PCI Express ASPM for PCIe-PCI bridges. In this case the
> bridge acts as a PCIe endpoint.
>
> An example for such a device is e.g. the PEX8311, a combined PCIe to
> PCI-X and PCI-X to local bridge. This allows for additional power
> savings when L0S and L1 can be enabled, which depends on the L0S and
> L1 timings programmed in the PCIe part of the device. These programmed
> timings have to match the attached device on the local side of such a
> device.
>
> The measured power savings on an active and busy system with two such
> bridges connected to a PCIe switch are about 20mA at 13.8V when L0S
> up/down and L1 link states can be activated. The test system is an
> Atom Z530 with an US15W, a PEX8509, some other PCIe devices and two
> PEX8311 devices having FPGAs as their local endpoint.
>
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
>  drivers/pci/pcie/Kconfig |   16 ++++++++++++++++
>  drivers/pci/pcie/aspm.c  |    9 +++++++++
>  2 files changed, 25 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 6c8bc58..273ba7e 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -80,6 +80,22 @@ config PCIEASPM_PERFORMANCE
>           Disable PCI Express ASPM L0s and L1, even if the BIOS enabled them.
>  endchoice
>
> +config PCIEASPM_BRIDGES
> +       bool "Enable PCI Express ASPM for PCIe bridges"
> +       depends on PCIEASPM && EXPERIMENTAL
> +       default n
> +       help
> +         This enables PCI Express ASPM for PCIe-PCI bridges. In this
> +         case the bridge acts as a PCIe endpoint.
> +
> +         An example for such a device is e.g. the PEX8311, a combined
> +         PCIe to PCI-X and PCI-X to local bridge. This allows for
> +         additional power savings when L0S and L1 can be enabled,
> +         which depends on the L0S and L1 timings programmed in the
> +         PCIe part of the device. These programmed timings have to
> +         match the attached device on the local side of such a
> +         device.

I don't know why the current code treats bridges differently.

I see why you added a config option, because it clearly won't break
anything.  But I don't really like the config option because either
doing ASPM for bridges is supposed to work according to the spec, in
which case everybody should turn this on and enjoy the benefit, or it
isn't, in which case the parts in your system have non-standard
behavior, and we should use a quirk or similar approach.

>  config PCIE_PME
>         def_bool y
>         depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL && ACPI
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b52630b..435a14a 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -391,6 +391,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>
>         /* Setup initial capable state. Will be updated later */
>         link->aspm_capable = link->aspm_support;
> +
> +#ifndef CONFIG_PCIEASPM_BRIDGES
>         /*
>          * If the downstream component has pci bridge function, don't
>          * do ASPM for now.
> @@ -401,6 +403,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>                         break;
>                 }
>         }
> +#endif
>
>         /* Get and check endpoint acceptable latencies */
>         list_for_each_entry(child, &linkbus->devices, bus_list) {
> @@ -409,6 +412,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>                         &link->acceptable[PCI_FUNC(child->devfn)];
>
>                 if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
> +#ifdef CONFIG_PCIEASPM_BRIDGES
> +                   pci_pcie_type(child) != PCI_EXP_TYPE_PCI_BRIDGE &&
> +#endif
>                     pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
>                         continue;
>
> @@ -621,6 +627,9 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
>                         continue;
>                 list_for_each_entry(child, &linkbus->devices, bus_list) {
>                         if ((pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT) &&
> +#ifdef CONFIG_PCIEASPM_BRIDGES
> +                           (pci_pcie_type(child) != PCI_EXP_TYPE_PCI_BRIDGE) &&
> +#endif
>                             (pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END))
>                                 continue;
>                         pcie_aspm_check_latency(child);
> --
> 1.7.3.4
>
>
>
> Roman
>
>
> --
> Roman Fietze              Telemotive AG Buero Muehlhausen
> Breitwiesen                             73347 Muehlhausen
> Tel.: +49(0)7335/18493-45        http://www.telemotive.de
