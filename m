Return-Path: <SRS0=mb4B=4K=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=mb4B=4K=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHp75VcLWrrRuUYwT4Mxww9e3886LqczMXTHo95wUybyCZpqTg@mail.gmail.com>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
 <1493126394-1239-3-git-send-email-deathsimple@vodafone.de>
 <CAHp75VfSFBYgHRsX2JSH0zdSEW8VvXbNMVvBBsD9kKgzGr-v2w@mail.gmail.com>
 <5a9a94f3-34b3-9484-a455-f5b2ee0b4d51@vodafone.de> <CAHp75VcLWrrRuUYwT4Mxww9e3886LqczMXTHo95wUybyCZpqTg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 May 2017 19:44:24 +0300
Message-ID: <CAHp75VcgAYC3nvLv7ueC8CXDdC3=d3tm1RmdxCdH=o6UbQoSMg@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: add functionality for resizing resources v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 4, 2017 at 1:15 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, May 4, 2017 at 12:23 PM, Christian K=C3=B6nig
> <deathsimple@vodafone.de> wrote:
>> Am 26.04.2017 um 19:00 schrieb Andy Shevchenko:

> static int ...xxx...(...)
> {
>     unsigned int i;
>     int ret;
>

>     if (res->parent)
>             release_resource(res);
>

dev_info() should be here. I commented on this earlier, just forgot.

>     res->start =3D 0;
>     res->end =3D 0;
>     dev_info(&bridge->dev, "BAR %d: released %pR\n", i, res);
>     return i;
> }
>
>
> struct pci_dev *next =3D bridge;
> ...
>     do {
>         bridge =3D next;
>
>         ret =3D ...xxx...(...);

>         if (ret)

Here, of course,

if (ret < 0)

>             goto cleanup;
>
>         next =3D bridge->bus ? bridge->bus->self : NULL;
>     } while (next);


--=20
With Best Regards,
Andy Shevchenko
