Return-Path: <SRS0=5+pe=CA=gmail.com=alexdeucher@kernel.org>
Return-Path: <SRS0=5+pe=CA=gmail.com=alexdeucher@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171018135821.3248-5-deathsimple@vodafone.de>
References: <20171018135821.3248-1-deathsimple@vodafone.de> <20171018135821.3248-5-deathsimple@vodafone.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Nov 2017 12:43:31 -0400
Message-ID: <CADnq5_MOTfeck34SMpTCihVJKXupPRgLY5-m13tjB1iz8Mj=7A@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on AMD Family 15h
 (Models 30h-3fh) Processors v5
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>,
	amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 18, 2017 at 9:58 AM, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Most BIOS don't enable this because of compatibility reasons.
>
> Manually enable a 64bit BAR of 64GB size so that we have
> enough room for PCI devices.
>
> v2: style cleanups, increase size, add resource name, set correct flags,
>     print message that windows was added
> v3: add defines for all the magic numbers, style cleanups
> v4: add some comment that the BIOS should actually allow this using
>     _PRS and _SRS.
> v5: only enable this if CONFIG_PHYS_ADDR_T_64BIT is set
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  arch/x86/pci/fixup.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 11e407489db0..7b6bd76713c5 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -618,3 +618,83 @@ static void quirk_apple_mbp_poweroff(struct pci_dev =
*pdev)
>                 dev_info(dev, "can't work around MacBook Pro poweroff iss=
ue\n");
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_po=
weroff);
> +
> +#ifdef CONFIG_PHYS_ADDR_T_64BIT
> +
> +#define AMD_141b_MMIO_BASE(x)  (0x80 + (x) * 0x8)
> +#define AMD_141b_MMIO_BASE_RE_MASK             BIT(0)
> +#define AMD_141b_MMIO_BASE_WE_MASK             BIT(1)
> +#define AMD_141b_MMIO_BASE_MMIOBASE_MASK       GENMASK(31,8)
> +
> +#define AMD_141b_MMIO_LIMIT(x) (0x84 + (x) * 0x8)
> +#define AMD_141b_MMIO_LIMIT_MMIOLIMIT_MASK     GENMASK(31,8)
> +
> +#define AMD_141b_MMIO_HIGH(x)  (0x180 + (x) * 0x4)
> +#define AMD_141b_MMIO_HIGH_MMIOBASE_MASK       GENMASK(7,0)
> +#define AMD_141b_MMIO_HIGH_MMIOLIMIT_SHIFT     16
> +#define AMD_141b_MMIO_HIGH_MMIOLIMIT_MASK      GENMASK(23,16)
> +
> +/*
> + * The PCI Firmware Spec, rev 3.2 notes that ACPI should optionally allo=
w
> + * configuring host bridge windows using the _PRS and _SRS methods.
> + *
> + * But this is rarely implemented, so we manually enable a large 64bit B=
AR for
> + * PCIe device on AMD Family 15h (Models 30h-3fh) Processors here.
> + */
> +static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
> +{
> +       struct resource *res, *conflict;
> +       u32 base, limit, high;
> +       unsigned i;
> +
> +       for (i =3D 0; i < 8; ++i) {
> +               pci_read_config_dword(dev, AMD_141b_MMIO_BASE(i), &base);
> +               pci_read_config_dword(dev, AMD_141b_MMIO_HIGH(i), &high);
> +
> +               /* Is this slot free? */
> +               if (!(base & (AMD_141b_MMIO_BASE_RE_MASK |
> +                             AMD_141b_MMIO_BASE_WE_MASK)))
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
> +       res->start =3D 0x100000000ull;
> +       res->end =3D 0xfd00000000ull - 1;
> +
> +       /* Just grab the free area behind system memory for this */
> +       while ((conflict =3D request_resource_conflict(&iomem_resource, r=
es)))
> +               res->start =3D conflict->end + 1;
> +
> +       dev_info(&dev->dev, "adding root bus resource %pR\n", res);
> +
> +       base =3D ((res->start >> 8) & AMD_141b_MMIO_BASE_MMIOBASE_MASK) |
> +               AMD_141b_MMIO_BASE_RE_MASK | AMD_141b_MMIO_BASE_WE_MASK;
> +       limit =3D ((res->end + 1) >> 8) & AMD_141b_MMIO_LIMIT_MMIOLIMIT_M=
ASK;
> +       high =3D ((res->start >> 40) & AMD_141b_MMIO_HIGH_MMIOBASE_MASK) =
|
> +               ((((res->end + 1) >> 40) << AMD_141b_MMIO_HIGH_MMIOLIMIT_=
SHIFT)
> +                & AMD_141b_MMIO_HIGH_MMIOLIMIT_MASK);
> +
> +       pci_write_config_dword(dev, AMD_141b_MMIO_HIGH(i), high);
> +       pci_write_config_dword(dev, AMD_141b_MMIO_LIMIT(i), limit);
> +       pci_write_config_dword(dev, AMD_141b_MMIO_BASE(i), base);
> +
> +       pci_bus_add_resource(dev->bus, res, 0);
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_=
bar);
> +

We may want to expand this to cover more host bridges.  E.g., on my KV
system I have these:
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
15h (Models 30h-3fh) Processor Root Complex [1022:1422]
00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:1424]
00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:1424]
00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:1424]
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
15h (Models 30h-3fh) Processor Function 0 [1022:141a]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
15h (Models 30h-3fh) Processor Function 1 [1022:141b]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
15h (Models 30h-3fh) Processor Function 2 [1022:141c]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
15h (Models 30h-3fh) Processor Function 3 [1022:141d]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
15h (Models 30h-3fh) Processor Function 4 [1022:141e]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
15h (Models 30h-3fh) Processor Function 5 [1022:141f]

And on my CZ system:
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:1576]
00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:157b]
00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:157b]
00:09.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:157d]
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:1570]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:1571]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:1572]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:1573]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:1574]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device
[1022:1575]

Do you know if Zen based systems use the same registers?  They have
yet more set of pci ids for host bridges.

Alex


> +#endif
> --
> 2.11.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
