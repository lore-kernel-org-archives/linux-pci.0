Return-Path: <SRS0=mb4B=4K=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=mb4B=4K=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <5a9a94f3-34b3-9484-a455-f5b2ee0b4d51@vodafone.de>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
 <1493126394-1239-3-git-send-email-deathsimple@vodafone.de>
 <CAHp75VfSFBYgHRsX2JSH0zdSEW8VvXbNMVvBBsD9kKgzGr-v2w@mail.gmail.com> <5a9a94f3-34b3-9484-a455-f5b2ee0b4d51@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 May 2017 13:15:49 +0300
Message-ID: <CAHp75VcLWrrRuUYwT4Mxww9e3886LqczMXTHo95wUybyCZpqTg@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: add functionality for resizing resources v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 4, 2017 at 12:23 PM, Christian K=C3=B6nig
<deathsimple@vodafone.de> wrote:
> Am 26.04.2017 um 19:00 schrieb Andy Shevchenko:

>>> +       while (1) {
>>
>> This raises red flag. Care to refactor?
>> Also do {} while () syntax allows faster to get that the loop body
>> goes at least once.
>
>
> I've tried to refactor this, but couldn't come up with something which wo=
rks
> and is readable at the same time.
>
> Any suggestion how this should look like?

This is original code.

--- 8< --- 8< ---

    while (1) {
            for (i =3D PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END; i=
++) {
                    struct resource *res =3D &bridge->resource[i];

                    if ((res->flags & type_mask) !=3D (type & type_mask))
                            continue;

                    /* Ignore BARs which are still in use */
                    if (res->child)
                            continue;

                    ret =3D add_to_list(&saved, bridge, res, 0, 0);
                    if (ret)
                            goto cleanup;

                    if (res->parent)
                            release_resource(res);
                    res->start =3D 0;
                    res->end =3D 0;
                    dev_info(&bridge->dev, "BAR %d: released %pR\n", i, res=
);
                    break;
            }
            if (i =3D=3D PCI_BRIDGE_RESOURCE_END)
                    break;

            if (!bridge->bus || !bridge->bus->self)
                    break;

            bridge =3D bridge->bus->self;
    }

--- 8< --- 8< ---

I would think about something like below

static int ...xxx...(...)
{
    unsigned int i;
    int ret;

    for (i =3D PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END; i++) {
            struct resource *res =3D &bridge->resource[i];

            /* Ignore BARs which are still in use */
            if (((res->flags ^ type) & type_mask) =3D=3D 0 && !res->child)
                    break;
    }
    if (i =3D=3D PCI_BRIDGE_RESOURCE_END)
        return -EBUSY;

    ret =3D add_to_list(&saved, bridge, res, 0, 0);
    if (ret)
            return ret;

    if (res->parent)
            release_resource(res);

    res->start =3D 0;
    res->end =3D 0;
    dev_info(&bridge->dev, "BAR %d: released %pR\n", i, res);
    return i;
}


struct pci_dev *next =3D bridge;
...
    do {
        bridge =3D next;

        ret =3D ...xxx...(...);
        if (ret)
            goto cleanup;

        next =3D bridge->bus ? bridge->bus->self : NULL;
    } while (next);
...

--=20
With Best Regards,
Andy Shevchenko
