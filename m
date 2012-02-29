Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1330556858-11768-40-git-send-email-yinghai@kernel.org>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org> <1330556858-11768-40-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 29 Feb 2012 16:32:30 -0700
Message-ID: <CAErSpo63hAtPMFdSEuVCcgw5ERMkiKx2Z8pREc2PdiCwmWpvkg@mail.gmail.com>
Subject: Re: [PATCH 39/39] x86, PCI: kill busn in acpi pci_root_info
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 29, 2012 at 4:07 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Bjorn thought that we should just use that in acpi_root.
>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  arch/x86/pci/acpi.c |   19 ++++++-------------
>  1 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index ff5243e..5178917 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -12,7 +12,6 @@ struct pci_root_info {
>        char name[16];
>        unsigned int res_num;
>        struct resource *res;
> -       struct resource busn;
>        struct pci_sysdata sd;
>  };
>
> @@ -283,9 +282,6 @@ static void add_resources(struct pci_root_info *info,
>        int i;
>        struct resource *res, *root, *conflict;
>
> -       if (info->busn.flags & IORESOURCE_BUS)
> -               pci_add_resource(resources, &info->busn);
> -
>        coalesce_windows(info, IORESOURCE_MEM);
>        coalesce_windows(info, IORESOURCE_IO);
>
> @@ -346,16 +342,12 @@ static void release_pci_root_info(struct pci_host_bridge *bridge)
>
>  static void
>  probe_pci_root_info(struct pci_root_info *info, struct acpi_device *device,
> -                   int busnum, int busmax, int domain)
> +                   int busnum, int domain)
>  {
>        size_t size;
>
>        sprintf(info->name, "PCI Bus %04x:%02x", domain, busnum);
>        info->bridge = device;
> -       info->busn.name = info->name;
> -       info->busn.start = busnum;
> -       info->busn.end = busmax;
> -       info->busn.flags = IORESOURCE_BUS;

You just *added* this stuff in a prior patch that hasn't been merged
yet.  Why can't you just fix that series rather than doing the
add/remove churn?

>        info->res_num = 0;
>        acpi_walk_resources(device->handle, METHOD_NAME__CRS, count_resource,
> @@ -379,7 +371,6 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>        struct pci_root_info *info = NULL;
>        int domain = root->segment;
>        int busnum = root->secondary.start;
> -       int busmax = root->secondary.end;
>        LIST_HEAD(resources);
>        struct pci_bus *bus;
>        struct pci_sysdata *sd;
> @@ -432,15 +423,17 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>                memcpy(bus->sysdata, sd, sizeof(*sd));
>                kfree(info);
>        } else {
> -               probe_pci_root_info(info, device, busnum, busmax, domain);
> +               probe_pci_root_info(info, device, busnum, domain);
>
>                /*
>                 * _CRS with no apertures is normal, so only fall back to
>                 * defaults or native bridge info if we're ignoring _CRS.
>                 */
> -               if (pci_use_crs)
> +               if (pci_use_crs) {
> +                       /* insert busn res at first */
> +                       pci_add_resource(&resources,  &root->secondary);
>                        add_resources(info, &resources);
> -               else {
> +               } else {
>                        free_pci_root_info_res(info);
>                        x86_pci_root_bus_resources(busnum, &resources);
>                }
> --
> 1.7.7
>
