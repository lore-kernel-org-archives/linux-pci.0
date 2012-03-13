Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1331362837-10740-34-git-send-email-yinghai@kernel.org>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org> <1331362837-10740-34-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 12 Mar 2012 21:37:03 -0600
Message-ID: <CAErSpo6EEf7=tT1ZWQ8+izTwop-KdFGsQszgWSVVyq7J0W1n0g@mail.gmail.com>
Subject: Re: [PATCH v2 33/37] x86, PCI: Add pcibios_root_rescan()
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 10, 2012 at 12:00 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> Need use it to rescan root bus that was not added via acpi probe.

Why would we ever need to rescan for this?  If we're doing host
bridge hotplug on x86, it's via ACPI, so we'll always have an ACPI
host bridge object.

There's no way to even express the idea of "adding or removing buses
we found by blindly probing," so there's no need to do any kind of
rescanning to find them again.  We find them once at boot-time, and
that's more than enough.

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  arch/x86/include/asm/pci.h |    2 ++
>  arch/x86/pci/legacy.c      |   25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 0 deletions(-)
>
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index bb015c7..332c191 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -30,6 +30,8 @@ extern struct pci_bus *pci_scan_bus_on_node(int busno, struct pci_ops *ops,
>                                            int node);
>  extern struct pci_bus *pci_scan_bus_with_sysdata(int busno);
>
> +void pcibios_root_rescan(void);
> +
>  #ifdef CONFIG_PCI
>
>  #ifdef CONFIG_PCI_DOMAINS
> diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
> index aab0e41..251f838 100644
> --- a/arch/x86/pci/legacy.c
> +++ b/arch/x86/pci/legacy.c
> @@ -79,3 +79,28 @@ int __init pci_subsys_init(void)
>        return 0;
>  }
>  subsys_initcall(pci_subsys_init);
> +
> +void __ref pcibios_root_rescan(void)
> +{
> +       int busn;
> +       struct pci_bus *bus;
> +
> +       if (pcibios_last_bus <= 0 || pcibios_last_bus > 0xff)
> +               return;
> +
> +       for (busn = 0; busn <= pcibios_last_bus; busn++) {
> +               bus = pci_find_bus(0, busn);
> +
> +               if (bus)
> +                       continue;
> +
> +               bus = __pcibios_scan_specific_bus(busn, false);
> +
> +               if (!bus)
> +                       continue;
> +
> +               pci_assign_unassigned_bus_resources(bus);
> +
> +               pci_bus_add_devices(bus);
> +       }
> +}
> --
> 1.7.7
>
