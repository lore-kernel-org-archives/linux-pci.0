Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Mar 2017 10:28:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: add resizeable BAR infrastructure v3
Message-ID: <20170324152853.GD25380@bhelgaas-glaptop.roam.corp.google.com>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-2-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1489408896-25039-2-git-send-email-deathsimple@vodafone.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 01:41:33PM +0100, Christian König wrote:
> From: Christian König <christian.koenig@amd.com>
> 
> Just the defines and helper functions to read the possible sizes of a BAR and
> update it's size.

s/it's/its/

> See https://pcisig.com/sites/default/files/specification_documents/ECN_Resizable-BAR_24Apr2008.pdf.

It's good to have the public ECN that anybody can read, but we should
also have a reference to the full spec that incorporates it, e.g.,
PCIe r3.1, sec 7.22.

> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1946,6 +1946,9 @@ void pci_request_acs(void);
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
>  			  struct pci_dev *end, u16 acs_flags);
> +u32 pci_rbar_get_possible_sizes(struct pci_dev *pdev, int bar);
> +int pci_rbar_get_current_size(struct pci_dev *pdev, int bar);
> +int pci_rbar_set_size(struct pci_dev *pdev, int bar, int size);

These should be declared in drivers/pci/pci.h unless they're needed
outside drivers/pci.  I hope they aren't needed outside, because
they're not safe to use after the PCI core has claimed resources.

>  #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
>  #define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e5a2e68..6de29d6 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -932,9 +932,16 @@
>  #define PCI_SATA_SIZEOF_LONG	16
>  
>  /* Resizable BARs */
> +#define PCI_REBAR_CAP		4	/* capability register */
> +#define  PCI_REBAR_CTRL_SIZES_MASK	(0xFFFFF << 4)	/* mask for sizes */
> +#define  PCI_REBAR_CTRL_SIZES_SHIFT	4	/* shift for sizes */
>  #define PCI_REBAR_CTRL		8	/* control register */
> +#define  PCI_REBAR_CTRL_BAR_IDX_MASK	(7 << 0)	/* mask for bar index */
> +#define  PCI_REBAR_CTRL_BAR_IDX_SHIFT	0	/* shift for bar index */
>  #define  PCI_REBAR_CTRL_NBAR_MASK	(7 << 5)	/* mask for # bars */
>  #define  PCI_REBAR_CTRL_NBAR_SHIFT	5	/* shift for # bars */
> +#define  PCI_REBAR_CTRL_BAR_SIZE_MASK	(0x1F << 8)	/* mask for bar size */
> +#define  PCI_REBAR_CTRL_BAR_SIZE_SHIFT	8	/* shift for bar size */

s/bar/BAR/ several places above

>  /* Dynamic Power Allocation */
>  #define PCI_DPA_CAP		4	/* capability register */
> -- 
> 2.7.4
> 
