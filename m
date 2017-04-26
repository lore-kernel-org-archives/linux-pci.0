Return-Path: <SRS0=imYQ=4C=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=imYQ=4C=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1493126394-1239-4-git-send-email-deathsimple@vodafone.de>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de> <1493126394-1239-4-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Apr 2017 20:18:15 +0300
Message-ID: <CAHp75Vf5ETss24VkMpNn388D5AT5Yckeav0nSS-ESn-AdiHSGQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models
 30h-3fh) Processors v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: helgaas@kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 25, 2017 at 4:19 PM, Christian K=C3=B6nig
<deathsimple@vodafone.de> wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Most BIOS don't enable this because of compatibility reasons.
>
> Manually enable a 64bit BAR of 64GB size so that we have
> enough room for PCI devices.

> +static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
> +{

> +       uint32_t base, limit, high;

Is u32 or uint32_t used actually in this file?

> +       struct resource *res, *conflict;

> +       unsigned i;

unsigned int i;

Reversed tree order.

> +       for (i =3D 0; i < 8; ++i) {
> +               pci_read_config_dword(dev, 0x80 + i * 0x8, &base);
> +               pci_read_config_dword(dev, 0x180 + i * 0x4, &high);
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

You are using this constant twice AFAICS, perhaps define it in generic
pci.h and re-use?

> +       res->start =3D 0x100000000;
> +       res->end =3D 0xfd00000000 - 1;

Perhaps you forgot ul / ull in many places in your code. Care to
compile for 32-bit and fix the warnings?

> +       dev_info(&dev->dev, "adding root bus resource %pR\n", res);

Some of your messages I think are rather dev_dbg() than dev_info().

> +       base =3D ((res->start >> 8) & 0xffffff00) | 0x3;
> +       limit =3D ((res->end + 1) >> 8) & 0xffffff00;
> +       high =3D ((res->start >> 40) & 0xff) |
> +               ((((res->end + 1) >> 40) & 0xff) << 16);

It would be nice to have the magics defined (just on top of this function) =
like

#define PCI_AMD_BAR_XXX_MASK GENMASK(...)
#define PCI_AMD_BAR_XXX_SHIFT nn

> +       pci_write_config_dword(dev, 0x180 + i * 0x4, high);
> +       pci_write_config_dword(dev, 0x84 + i * 0x8, limit);
> +       pci_write_config_dword(dev, 0x80 + i * 0x8, base);

Ditto for pos:s.

> +
> +       pci_bus_add_resource(dev->bus, res, 0);
> +}

--=20
With Best Regards,
Andy Shevchenko
