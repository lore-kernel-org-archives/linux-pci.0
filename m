Return-Path: <SRS0=wqlW=2W=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=wqlW=2W=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1489408896-25039-4-git-send-email-deathsimple@vodafone.de>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de> <1489408896-25039-4-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Mar 2017 18:49:00 +0200
Message-ID: <CAHp75Ve4RXtuh7=8FUDv8RXGFMuYLte9GCOd02Y427BrFtPzYA@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models
 30h-3fh) Processors
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: helgaas@kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
	Platform Driver <platform-driver-x86@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 2:41 PM, Christian K=C3=B6nig
<deathsimple@vodafone.de> wrote:

> Most BIOS don't enable this because of compatibility reasons.
>
> Manually enable a 64bit BAR of 64GB size so that we have
> enough room for PCI devices.

> +static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
> +{
> +       const uint64_t size =3D 64ULL * 1024 * 1024 * 1024;

Perhaps extend <linux/sizes.h> and use SZ_64G here?

It would be nice to do, since some of the drivers already are using
sizes like 4GB and alike.

> +       uint32_t base, limit, high;
> +       struct resource *res;
> +       unsigned i;
> +       int r;
> +

> +       for (i =3D 0; i < 8; ++i) {

> +

Redundant empty line.

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

> +

Ditto.

> +       }

> +

Ditto.

> +       if (i =3D=3D 8)
> +               return;
> +
> +       res =3D kzalloc(sizeof(*res), GFP_KERNEL);
> +       res->flags =3D IORESOURCE_MEM | IORESOURCE_PREFETCH | IORESOURCE_=
MEM_64 |
> +               IORESOURCE_WINDOW;
> +       res->name =3D dev->bus->name;
> +       r =3D allocate_resource(&iomem_resource, res, size, 0x100000000,
> +                             0xfd00000000, size, NULL, NULL);
> +       if (r) {
> +               kfree(res);
> +               return;
> +       }
> +
> +       base =3D ((res->start >> 8) & 0xffffff00) | 0x3;
> +       limit =3D ((res->end + 1) >> 8) & 0xffffff00;
> +       high =3D ((res->start >> 40) & 0xff) |
> +               ((((res->end + 1) >> 40) & 0xff) << 16);

Perhaps some of constants can be replaced by defines (I think some of
them are already defined in ioport.h or somewhere else).

--=20
With Best Regards,
Andy Shevchenko
