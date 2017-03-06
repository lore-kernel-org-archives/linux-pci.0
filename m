Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36022 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753253AbdCFMU0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2017 07:20:26 -0500
MIME-Version: 1.0
In-Reply-To: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de>
References: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 6 Mar 2017 14:20:24 +0200
Message-ID: <CAHp75Vet-gb_mXA2Uwdai+G2AeJ4p10eTjgmC2h5Gnmosd69WA@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI: add resizeable BAR infrastructure v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 6, 2017 at 1:40 PM, Christian K=C3=B6nig <deathsimple@vodafone.=
de> wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Just the defines and helper functions to read the possible sizes of a BAR=
 and
> update it's size.
>
> See https://pcisig.com/sites/default/files/specification_documents/ECN_Re=
sizable-BAR_24Apr2008.pdf.
>
> v2: provide read helper as well

Commit message left away the explanation at which point this API might
be useful and how it fits in managed resources model?

>  /**
> + * pci_rbar_get_sizes - get possible sizes for BAR

Why not simple pci_rbar_get_possible_sizes() ?

> +u32 pci_rbar_get_sizes(struct pci_dev *pdev, int bar)
> +{
> +       int pos, nbars;
> +       u32 ctrl, cap;
> +       int i;
> +
> +       pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +       if (!pos)

> +               return 0x0;

return 0;

> +
> +       pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +       nbars =3D (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBA=
R_SHIFT;
> +

> +       for (i =3D 0; i < nbars; ++i, pos +=3D 8) {

8 is defined somewhere in the spec? (Yes, I understand that is just 64
bits shift)

> +               int bar_idx;
> +
> +               pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +               bar_idx =3D (ctrl & PCI_REBAR_CTRL_BAR_IDX_MASK) >>
> +                               PCI_REBAR_CTRL_BAR_IDX_SHIFT;
> +               if (bar_idx !=3D bar)
> +                       continue;
> +
> +               pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
> +               return (cap & PCI_REBAR_CTRL_SIZES_MASK) >>
> +                       PCI_REBAR_CTRL_SIZES_SHIFT;
> +       }
> +

> +       return 0x0;

return 0;

> +/**
> + * pci_rbar_get_size - get the current size of a BAR

pci_rbar_get_current_size() ?

> +/**
> + * pci_rbar_set_size - set a new size for a BAR
> + * @dev: PCI device
> + * @bar: BAR to set size to

> + * @size: new size as defined in the spec.

 * @size: bitmasked value of new size (bit 0=3D1MB, ..., bit 19=3D512G)

?

It will briefly get a clue without reading either spec or long description.

> + *
> + * Set the new size of a BAR as defined in the spec (0=3D1MB, 19=3D512GB=
).
> + * Returns true if resizing was successful, false otherwise.
> + */

> +bool pci_rbar_set_size(struct pci_dev *pdev, int bar, int size)

I would return int and error code. It would be better in the future
and seems in alignment with above.

> +{
> +       int pos, nbars;
> +       u32 ctrl;
> +       int i;

All ints are unsigned?

--=20
With Best Regards,
Andy Shevchenko
