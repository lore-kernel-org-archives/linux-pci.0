Return-Path: <SRS0=Qg5I=4N=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=Qg5I=4N=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1493890270-1188-3-git-send-email-deathsimple@vodafone.de>
References: <1493890270-1188-1-git-send-email-deathsimple@vodafone.de> <1493890270-1188-3-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 7 May 2017 13:52:20 +0300
Message-ID: <CAHp75Vds8YrDG7GD3KGx9cd0TuWiRs6-GWm9AVe-_3BhhEBqsg@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: add resizeable BAR infrastructure v5
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
>

Now looks nice!

FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> v2: provide read helper as well
> v3: improve function names, use unsigned values, add better comments.
> v4: move definition, improve commit message, s/bar/BAR/
> v5: split out helper to find ctrl reg pos, style fixes, comment fixes,
>     add pci_rbar_size_to_bytes as well
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/pci/pci.c             | 104 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/pci/pci.h             |   8 ++++
>  include/uapi/linux/pci_regs.h |  11 ++++-
>  3 files changed, 121 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ba34907..0cbf4a6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2944,6 +2944,110 @@ bool pci_acs_path_enabled(struct pci_dev *start,
>  }
>
>  /**
> + * pci_rbar_find_pos - find position of resize ctrl reg for BAR
> + * @dev: PCI device
> + * @bar: BAR to find
> + *
> + * Helper to find the postion of the ctrl register for a BAR.
> + * Returns -ENOTSUPP of resizeable BARs are not supported at all.
> + * Returns -ENOENT if not ctrl register for the BAR could be found.
> + */
> +static int pci_rbar_find_pos(struct pci_dev *pdev, int bar)
> +{
> +       unsigned int pos, nbars;
> +       unsigned int i;
> +       u32 ctrl;
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
> +               if (bar_idx =3D=3D bar)
> +                       return pos;
> +       }
> +
> +       return -ENOENT;
> +}
> +
> +/**
> + * pci_rbar_get_possible_sizes - get possible sizes for BAR
> + * @dev: PCI device
> + * @bar: BAR to query
> + *
> + * Get the possible sizes of a resizeable BAR as bitmask defined in the =
spec
> + * (bit 0=3D1MB, bit 19=3D512GB). Returns 0 if BAR isn't resizeable.
> + */
> +u32 pci_rbar_get_possible_sizes(struct pci_dev *pdev, int bar)
> +{
> +       u32 cap;
> +       int pos;
> +
> +       pos =3D pci_rbar_find_pos(pdev, bar);
> +       if (pos < 0)
> +               return 0;
> +
> +       pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
> +       return (cap & PCI_REBAR_CTRL_SIZES_MASK) >>
> +               PCI_REBAR_CTRL_SIZES_SHIFT;
> +}
> +
> +/**
> + * pci_rbar_get_current_size - get the current size of a BAR
> + * @dev: PCI device
> + * @bar: BAR to set size to
> + *
> + * Read the size of a BAR from the resizeable BAR config.
> + * Returns size if found or negative error code.
> + */
> +int pci_rbar_get_current_size(struct pci_dev *pdev, int bar)
> +{
> +       u32 ctrl;
> +       int pos;
> +
> +       pos =3D pci_rbar_find_pos(pdev, bar);
> +       if (pos < 0)
> +               return pos;
> +
> +       pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +       return (ctrl & PCI_REBAR_CTRL_BAR_SIZE_MASK) >>
> +               PCI_REBAR_CTRL_BAR_SIZE_SHIFT;
> +}
> +
> +/**
> + * pci_rbar_set_size - set a new size for a BAR
> + * @dev: PCI device
> + * @bar: BAR to set size to
> + * @size: new size as defined in the spec (0=3D1MB, 19=3D512GB)
> + *
> + * Set the new size of a BAR as defined in the spec.
> + * Returns zero if resizing was successful, error code otherwise.
> + */
> +int pci_rbar_set_size(struct pci_dev *pdev, int bar, int size)
> +{
> +       u32 ctrl;
> +       int pos;
> +
> +       pos =3D pci_rbar_find_pos(pdev, bar);
> +       if (pos < 0)
> +               return pos;
> +
> +       pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +       ctrl &=3D ~PCI_REBAR_CTRL_BAR_SIZE_MASK;
> +       ctrl |=3D size << PCI_REBAR_CTRL_BAR_SIZE_SHIFT;
> +       pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
> +       return 0;
> +}
> +
> +/**
>   * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
>   * @dev: the PCI device
>   * @pin: the INTx pin (1=3DINTA, 2=3DINTB, 3=3DINTC, 4=3DINTD)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3868828..6290e5c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -359,4 +359,12 @@ static inline int pci_dev_specific_reset(struct pci_=
dev *dev, int probe)
>  }
>  #endif
>
> +u32 pci_rbar_get_possible_sizes(struct pci_dev *pdev, int bar);
> +int pci_rbar_get_current_size(struct pci_dev *pdev, int bar);
> +int pci_rbar_set_size(struct pci_dev *pdev, int bar, int size);
> +static inline u64 pci_rbar_size_to_bytes(int size)
> +{
> +       return 1ULL << (size + 20);
> +}
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index e5a2e68..a75429e 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -932,9 +932,16 @@
>  #define PCI_SATA_SIZEOF_LONG   16
>
>  /* Resizable BARs */
> +#define PCI_REBAR_CAP          4       /* capability register */
> +#define  PCI_REBAR_CTRL_SIZES_MASK     (0xFFFFF << 4)  /* mask for sizes=
 */
> +#define  PCI_REBAR_CTRL_SIZES_SHIFT    4       /* shift for sizes */
>  #define PCI_REBAR_CTRL         8       /* control register */
> -#define  PCI_REBAR_CTRL_NBAR_MASK      (7 << 5)        /* mask for # bar=
s */
> -#define  PCI_REBAR_CTRL_NBAR_SHIFT     5       /* shift for # bars */
> +#define  PCI_REBAR_CTRL_BAR_IDX_MASK   (7 << 0)        /* mask for BAR i=
ndex */
> +#define  PCI_REBAR_CTRL_BAR_IDX_SHIFT  0       /* shift for BAR index */
> +#define  PCI_REBAR_CTRL_NBAR_MASK      (7 << 5)        /* mask for # BAR=
s */
> +#define  PCI_REBAR_CTRL_NBAR_SHIFT     5       /* shift for # BARs */
> +#define  PCI_REBAR_CTRL_BAR_SIZE_MASK  (0x1F << 8)     /* mask for BAR s=
ize */
> +#define  PCI_REBAR_CTRL_BAR_SIZE_SHIFT 8       /* shift for BAR size */
>
>  /* Dynamic Power Allocation */
>  #define PCI_DPA_CAP            4       /* capability register */
> --
> 2.7.4
>



--=20
With Best Regards,
Andy Shevchenko
