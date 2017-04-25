Return-Path: <SRS0=5PB6=4B=gmail.com=alexdeucher@kernel.org>
Return-Path: <SRS0=5PB6=4B=gmail.com=alexdeucher@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1493126394-1239-4-git-send-email-deathsimple@vodafone.de>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de> <1493126394-1239-4-git-send-email-deathsimple@vodafone.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Apr 2017 11:00:28 -0400
Message-ID: <CADnq5_Mg1vmpL-8N8kZY_yhsT982xjVOGj5-JuBZPGXVupzCKA@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models
 30h-3fh) Processors v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Maling list - DRI developers <dri-devel@lists.freedesktop.org>, platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 25, 2017 at 9:19 AM, Christian K=C3=B6nig
<deathsimple@vodafone.de> wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Most BIOS don't enable this because of compatibility reasons.
>
> Manually enable a 64bit BAR of 64GB size so that we have
> enough room for PCI devices.
>
> v2: style cleanups, increase size, add resource name, set correct flags,
>     print message that windows was added
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  arch/x86/pci/fixup.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 6d52b94..8d949c4 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -571,3 +571,56 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0,=
 pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
> +
> +static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
> +{
> +       uint32_t base, limit, high;
> +       struct resource *res, *conflict;
> +       unsigned i;
> +
> +       for (i =3D 0; i < 8; ++i) {
> +               pci_read_config_dword(dev, 0x80 + i * 0x8, &base);
> +               pci_read_config_dword(dev, 0x180 + i * 0x4, &high);

Might be nice to define names for the register offsets.


> +
> +               /* Is this slot free? */
> +               if ((base & 0x3) =3D=3D 0x0)
> +                       break;
> +
> +               base >>=3D 8;
> +               base |=3D high << 24;
> +
> +               /* Abort if a slot already configures a 64bit BAR. */
> +               if (base > 0x10000)
> +                       return;
> +       }
> +       if (i =3D=3D 8)
> +               return;
> +
> +       res =3D kzalloc(sizeof(*res), GFP_KERNEL);
> +       if (!res)
> +               return;
> +
> +       res->name =3D "PCI Bus 0000:00";
> +       res->flags =3D IORESOURCE_PREFETCH | IORESOURCE_MEM |
> +               IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
> +       res->start =3D 0x100000000;
> +       res->end =3D 0xfd00000000 - 1;
> +
> +       /* Just grab the free area behind system memory for this */
> +       while ((conflict =3D request_resource_conflict(&iomem_resource, r=
es)))
> +               res->start =3D conflict->end + 1;
> +
> +       dev_info(&dev->dev, "adding root bus resource %pR\n", res);
> +
> +       base =3D ((res->start >> 8) & 0xffffff00) | 0x3;
> +       limit =3D ((res->end + 1) >> 8) & 0xffffff00;
> +       high =3D ((res->start >> 40) & 0xff) |
> +               ((((res->end + 1) >> 40) & 0xff) << 16);
> +
> +       pci_write_config_dword(dev, 0x180 + i * 0x4, high);
> +       pci_write_config_dword(dev, 0x84 + i * 0x8, limit);
> +       pci_write_config_dword(dev, 0x80 + i * 0x8, base);

Same here.  Either way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +
> +       pci_bus_add_resource(dev->bus, res, 0);
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_=
bar);
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
