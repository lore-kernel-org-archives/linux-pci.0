Return-Path: <SRS0=Qg5I=4N=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=Qg5I=4N=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1493890270-1188-2-git-send-email-deathsimple@vodafone.de>
References: <1493890270-1188-1-git-send-email-deathsimple@vodafone.de> <1493890270-1188-2-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 7 May 2017 13:48:30 +0300
Message-ID: <CAHp75Vd+U1udezBh32nMco7367XFNBy+9FO_-kg3HPwb6KjUDA@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI: add a define for the PCI resource type mask
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
> We use this mask multiple times in the bus setup.

Couple of nitpicks below.
Otherwise, FWIW:

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> +#define PCI_RES_TYPE_MASK (IORESOURCE_IO | IORESOURCE_MEM | \
> +                          IORESOURCE_PREFETCH | IORESOURCE_MEM_64)

I would go with following indentation:
#define PCI_RES_TYPE_MASK \
(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH | IORESOURCE_MEM_64)

or (if it doesn't fit well)

#define PCI_RES_TYPE_MASK \
    (IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH | \
     IORESOURCE_MEM_64)

>                 pci_bus_release_bridge_resources(fail_res->dev->bus,
> -                                                fail_res->flags & type_m=
ask,
> +                                                fail_res->flags &
> +                                                PCI_RES_TYPE_MASK,

I would leave it on one line even if it goes as far as ~85ish column.

>                 pci_bus_release_bridge_resources(fail_res->dev->bus,
> -                                                fail_res->flags & type_m=
ask,
> +                                                fail_res->flags &
> +                                                PCI_RES_TYPE_MASK,

Ditto.

--=20
With Best Regards,
Andy Shevchenko
