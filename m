Return-Path: <SRS0=imYQ=4C=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=imYQ=4C=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1493126394-1239-2-git-send-email-deathsimple@vodafone.de>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de> <1493126394-1239-2-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Apr 2017 19:45:30 +0300
Message-ID: <CAHp75VfJKkFTXbia=CiZapriEg6ObUh=js6cKJv3xe=2DBHbqA@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: add resizeable BAR infrastructure v4
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
> Just the defines and helper functions to read the possible sizes of a BAR=
 and
> update it's size.
>
> See https://pcisig.com/sites/default/files/specification_documents/ECN_Re=
sizable-BAR_24Apr2008.pdf
> and PCIe r3.1, sec 7.22.
>
> This is useful for hardware with large local storage (mostly GFX) which o=
nly
> expose 256MB BARs initially to be compatible with 32bit systems.

> +u32 pci_rbar_get_possible_sizes(struct pci_dev *pdev, int bar)
> +{

> +       unsigned pos, nbars;
> +       u32 ctrl, cap;
> +       unsigned i;

Are we supposed to use plain 'unsigned' nowadays? I would go with
'unsigned int'.

> +}

> + * Returns size if found or negativ error code.

Typo: negative.

> +int pci_rbar_get_current_size(struct pci_dev *pdev, int bar)
> +{
> +       unsigned pos, nbars;

> +       u32 ctrl;
> +       unsigned i;

Reversed tree order?

> +       for (i =3D 0; i < nbars; ++i, pos +=3D 8) {
> +               int bar_idx;
> +
> +               pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +               bar_idx =3D (ctrl & PCI_REBAR_CTRL_BAR_IDX_MASK) >>
> +                               PCI_REBAR_CTRL_BAR_IDX_SHIFT;
> +               if (bar_idx !=3D bar)
> +                       continue;
> +
> +               return (ctrl & PCI_REBAR_CTRL_BAR_SIZE_MASK) >>
> +                       PCI_REBAR_CTRL_BAR_SIZE_SHIFT;
> +       }

This one the same as previous function, the difference only in what is
returned. CAre to split static helper function for both?

> +       return -ENOENT;
> +}

> +/**
> + * pci_rbar_set_size - set a new size for a BAR
> + * @dev: PCI device
> + * @bar: BAR to set size to

> + * @size: new size as defined in the spec (log2(size in bytes) - 20)

Not clear is it rounded up / down. I would go with "...in the spec
(0=3D1MB, 19=3D512GB)".

> + *
> + * Set the new size of a BAR as defined in the spec (0=3D1MB, 19=3D512GB=
).
> + * Returns true if resizing was successful, false otherwise.
> + */

> +int pci_rbar_set_size(struct pci_dev *pdev, int bar, int size)
> +{
> +       unsigned pos, nbars;
> +       u32 ctrl;
> +       unsigned i;


> +
> +       pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +       if (!pos)
> +               return -ENOTSUPP;
> +
> +       pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +       nbars =3D (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBA=
R_SHIFT;
> +
> +       for (i =3D 0; i < nbars; ++i, pos +=3D 8) {
> +               int bar_idx;
> +
> +               pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +               bar_idx =3D (ctrl & PCI_REBAR_CTRL_BAR_IDX_MASK) >>
> +                               PCI_REBAR_CTRL_BAR_IDX_SHIFT;
> +               if (bar_idx !=3D bar)
> +                       continue;

Above is duplicating previous.

So,
static int ..._find_rbar(..., u32 *ctrl)
{
}

Returns: (i.e.) 0 - found, 1 - not found, -ERRNO.

ret =3D _find_rbar();
if (ret < 0)
 return ret;
if (ret)
 return -ENOENT;
...
return 0;

So, please refactor.

> +
> +               ctrl &=3D ~PCI_REBAR_CTRL_BAR_SIZE_MASK;
> +               ctrl |=3D size << PCI_REBAR_CTRL_BAR_SIZE_SHIFT;
> +               pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
> +               return 0;
> +       }
> +
> +       return -ENOENT;
> +}

> -#define  PCI_REBAR_CTRL_NBAR_MASK      (7 << 5)        /* mask for # bar=
s */
> -#define  PCI_REBAR_CTRL_NBAR_SHIFT     5       /* shift for # bars */

> +#define  PCI_REBAR_CTRL_NBAR_MASK      (7 << 5)        /* mask for # BAR=
s */
> +#define  PCI_REBAR_CTRL_NBAR_SHIFT     5       /* shift for # BARs */

I understand why, but I dunno it worth to do.

--=20
With Best Regards,
Andy Shevchenko
