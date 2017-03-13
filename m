Return-Path: <SRS0=wqlW=2W=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=wqlW=2W=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1489408896-25039-3-git-send-email-deathsimple@vodafone.de>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de> <1489408896-25039-3-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Mar 2017 18:43:42 +0200
Message-ID: <CAHp75VcY_P63T3-XcYafxhSFshQyL1dj0B2+Q4iW9hMiig3tRQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: add functionality for resizing resources v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: helgaas@kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
	Platform Driver <platform-driver-x86@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 2:41 PM, Christian K=C3=B6nig
<deathsimple@vodafone.de> wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> This allows device drivers to request resizing their BARs.
>
> The function only tries to reprogram the windows of the bridge directly a=
bove
> the requesting device and only the BAR of the same type (usually mem, 64b=
it,
> prefetchable). This is done to make sure not to disturb other drivers by
> changing the BARs of their devices.
>
> If reprogramming the bridge BAR fails the old status is restored and -ENO=
SPC
> returned to the calling device driver.

Some style comments.

> v2: rebase on changes in rbar support

This kind of comments usually goes after --- delimiter below.

> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---

...here.

> +int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long =
type)
> +{
> +       const unsigned long type_mask =3D IORESOURCE_IO | IORESOURCE_MEM =
|
> +               IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
> +
> +       struct resource saved;
> +       LIST_HEAD(add_list);
> +       LIST_HEAD(fail_head);

> +       struct pci_dev_resource *fail_res;

Perhaps move before definition of 'saved'?

> +       unsigned i;
> +       int ret =3D 0;
> +
> +       /* Release all children from the matching bridge resource */
> +       for (i =3D PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END; ++i=
) {
> +               struct resource *res =3D &bridge->resource[i];
> +


> +               if ((res->flags & type_mask) !=3D (type & type_mask))

IIUC it would be
if ((res->flags ^ type) & type_mask)

(I consider 'diff' as XOR operation is more understandable, but it's up to =
you)

> +                       continue;

> +       /* restore size and flags */
> +       list_for_each_entry(fail_res, &fail_head, list) {
> +               struct resource *res =3D fail_res->res;
> +
> +               res->start =3D fail_res->start;
> +               res->end =3D fail_res->end;
> +               res->flags =3D fail_res->flags;
> +       }
> +
> +       /* Revert to the old configuration */
> +       if (!list_empty(&fail_head)) {
> +               struct resource *res =3D &bridge->resource[i];
> +

> +               res->start =3D saved.start;
> +               res->end =3D saved.end;
> +               res->flags =3D saved.flags;

Would
 *res =3D saved;
work?

> +int pci_resize_resource(struct pci_dev *dev, int resno, int size)
> +{
> +       struct resource *res =3D dev->resource + resno;
> +       u32 sizes =3D pci_rbar_get_possible_sizes(dev, resno);
> +       int old =3D pci_rbar_get_current_size(dev, resno);
> +       u64 bytes =3D 1ULL << (size + 20);
> +       int ret =3D 0;
> +

I would put
 sizes =3D pci_rbar_get_possible_sizes(dev, resno);
here

> +       if (!sizes)
> +               return -ENOTSUPP;
> +
> +       if (!(sizes & (1 << size)))

BIT(size) ?

> +               return -EINVAL;
> +

and
 old =3D pci_rbar_get_current_size(dev, resno);
here

> +       if (old < 0)
> +               return old;

> +error_resize:
> +       pci_rbar_set_size(dev, resno, old);
> +       res->end =3D res->start + (1ULL << (old + 20)) - 1;

BIT_ULL(old + 20) ?

--=20
With Best Regards,
Andy Shevchenko
