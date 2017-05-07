Return-Path: <SRS0=Qg5I=4N=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=Qg5I=4N=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1493890270-1188-4-git-send-email-deathsimple@vodafone.de>
References: <1493890270-1188-1-git-send-email-deathsimple@vodafone.de> <1493890270-1188-4-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 7 May 2017 13:58:19 +0300
Message-ID: <CAHp75Vch0ytjeSqDRDtYcMymLgDF5b5sR5W+8kdAnMSFYJgRsg@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: add functionality for resizing resources v4
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Platform Driver <platform-driver-x86@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 4, 2017 at 12:31 PM, Christian K=C3=B6nig
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

My comments below.

> +int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long =
type)
> +{
> +       struct pci_dev_resource *dev_res;
> +       LIST_HEAD(saved);
> +       LIST_HEAD(added);
> +       LIST_HEAD(failed);
> +       unsigned int i;
> +       int ret;
> +
> +       /* Walk to the root BUS, releasing bridge BARs when possible */
> +       while (1) {
> +               for (i =3D PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_=
END;
> +                    i++) {
> +                       struct resource *res =3D &bridge->resource[i];
> +
> +                       if ((res->flags ^ type) & PCI_RES_TYPE_MASK)
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
> +                       dev_info(&bridge->dev, "BAR %d: releasing %pR\n",
> +                                i, res);
> +
> +                       if (res->parent)
> +                               release_resource(res);
> +                       res->start =3D 0;
> +                       res->end =3D 0;
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

Please, consider to refactor as I proposed the other day.

> +}

> +int pci_resize_resource(struct pci_dev *dev, int resno, int size)
> +{
> +       struct resource *res =3D dev->resource + resno;

> +       int old, ret =3D 0;

Redundant assignment.

> +       u32 sizes;
> +       u16 cmd;
> +

> +       ret =3D pci_rbar_set_size(dev, resno, size);
> +       if (ret)
> +               goto error_reassign;
> +

> +       return 0;
> +
> +error_resize:
> +       pci_rbar_set_size(dev, resno, old);
> +       res->end =3D res->start + pci_rbar_size_to_bytes(old) - 1;
> +
> +error_reassign:
> +       pci_assign_unassigned_bus_resources(dev->bus);
> +       return ret;
> +}

--=20
With Best Regards,
Andy Shevchenko
