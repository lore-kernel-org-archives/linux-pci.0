Return-Path: <SRS0=imYQ=4C=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=imYQ=4C=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1493126394-1239-3-git-send-email-deathsimple@vodafone.de>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de> <1493126394-1239-3-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Apr 2017 20:00:34 +0300
Message-ID: <CAHp75VfSFBYgHRsX2JSH0zdSEW8VvXbNMVvBBsD9kKgzGr-v2w@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: add functionality for resizing resources v3
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

> +int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long =
type)
> +{
> +       const unsigned long type_mask =3D IORESOURCE_IO | IORESOURCE_MEM =
|
> +               IORESOURCE_PREFETCH | IORESOURCE_MEM_64;

> +

Redundant.

> +       struct pci_dev_resource *dev_res;
> +       LIST_HEAD(saved);
> +       LIST_HEAD(added);
> +       LIST_HEAD(failed);

> +       unsigned i;

unsigned int i;

> +       int ret =3D 0;
> +
> +       /* Walk to the root BUS, releasing bridge BARs when possible */

> +       while (1) {

This raises red flag. Care to refactor?
Also do {} while () syntax allows faster to get that the loop body
goes at least once.

> +               for (i =3D PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_=
END;
> +                    i++) {

> +                       struct resource *res =3D &bridge->resource[i];
> +

> +                       if ((res->flags & type_mask) !=3D (type & type_ma=
sk))

I would rather go with

if ((res->flags ^ type) & type_mask)

> +                               continue;
> +
> +                       /* Ignore BARs which are still in use */
> +                       if (res->child)
> +                               continue;
> +
> +                       ret =3D add_to_list(&saved, bridge, res, 0, 0);
> +                       if (ret)
> +                               goto cleanup;
> +
> +                       if (res->parent)
> +                               release_resource(res);

> +                       res->start =3D 0;
> +                       res->end =3D 0;

> +                       dev_info(&bridge->dev, "BAR %d: released %pR\n",
> +                                i, res);

I doesn't make much sense to me after zeroing a range.

> +                       break;
> +               }
> +               if (i =3D=3D PCI_BRIDGE_RESOURCE_END)
> +                       break;
> +
> +               if (!bridge->bus || !bridge->bus->self)
> +                       break;
> +
> +               bridge =3D bridge->bus->self;
> +       }
> +
> +       if (list_empty(&saved))
> +               return -ENOENT;
> +
> +       __pci_bus_size_bridges(bridge->subordinate, &added);
> +       __pci_bridge_assign_resources(bridge, &added, &failed);
> +       BUG_ON(!list_empty(&added));
> +
> +       if (!list_empty(&failed)) {
> +               ret =3D -ENOSPC;
> +               goto cleanup;
> +       }

> +
> +

Remove extra empty line.

> +       list_for_each_entry(dev_res, &saved, list) {
> +               /* Skip the bridge we just assigned resources for. */
> +               if (bridge =3D=3D dev_res->dev)
> +                       continue;
> +
> +               bridge =3D dev_res->dev;
> +               pci_setup_bridge(bridge->subordinate);
> +       }
> +

> +       free_list(&saved);
> +       free_list(&failed);
> +       return ret;

You might re-use two lines with below, but perhaps better to show
which case returns 0 explicitly and drop assignment ret =3D 0 above.

> +
> +cleanup:
> +       /* restore size and flags */
> +       list_for_each_entry(dev_res, &failed, list) {
> +               struct resource *res =3D dev_res->res;
> +
> +               res->start =3D dev_res->start;
> +               res->end =3D dev_res->end;
> +               res->flags =3D dev_res->flags;
> +       }
> +       free_list(&failed);
> +
> +       /* Revert to the old configuration */
> +       list_for_each_entry(dev_res, &saved, list) {
> +               struct resource *res =3D dev_res->res;
> +
> +               bridge =3D dev_res->dev;
> +               i =3D res - bridge->resource;
> +
> +               res->start =3D dev_res->start;
> +               res->end =3D dev_res->end;
> +               res->flags =3D dev_res->flags;
> +
> +               pci_claim_resource(bridge, i);
> +               pci_setup_bridge(bridge->subordinate);
> +       }

> +       free_list(&saved);
> +
> +       return ret;

> +}

> +void pci_release_resource(struct pci_dev *dev, int resno)
> +{
> +       struct resource *res =3D dev->resource + resno;
> +
> +       release_resource(res);

> +       res->end =3D resource_size(res) - 1;
> +       res->start =3D 0;
> +       res->flags |=3D IORESOURCE_UNSET;

> +       dev_info(&dev->dev, "BAR %d: released %pR\n", resno, res);

Makes little sense to me after you cleared information out.

> +}
> +EXPORT_SYMBOL(pci_release_resource);
> +
> +int pci_resize_resource(struct pci_dev *dev, int resno, int size)
> +{
> +       struct resource *res =3D dev->resource + resno;

> +       u64 bytes =3D 1ULL << (size + 20);

> +       res->end =3D res->start + (1ULL << (old + 20)) - 1;

Perhaps macro or helper?

static inline u64 rbar_size_to_bytes(size)
{
return 1ULL << (size + 20);
}

--=20
With Best Regards,
Andy Shevchenko
