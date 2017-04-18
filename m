Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 18 Apr 2017 14:47:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Michael Davidson <md@google.com>
Subject: Re: [PATCH v3] PCI: Make PCI_ROM_ADDRESS_MASK a 32-bit constant
Message-ID: <20170418194738.GI25295@bhelgaas-glaptop.roam.corp.google.com>
References: <20170414203802.119399-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170414203802.119399-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 14, 2017 at 01:38:02PM -0700, Matthias Kaehlcke wrote:
> A 64-bit value is not needed since a PCI ROM address consists in 32 bits.
> This fixes a clang warning about "implicit conversion from 'unsigned
> long' to 'u32'".
> 
> Also remove now unnecessary casts to u32 from __pci_read_base() and
> pci_std_update_resource().
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Applied to pci/resource for v4.12, thanks!

> ---
> Changes in v3:
> - Remove unnecessary casts
> - Updated commit message
> 
> Changes in v2:
> - Define PCI_ROM_ADDRESS_MASK as a 32-bit constant instead of using a cast
> - Updated commit message
> 
>  drivers/pci/probe.c           | 2 +-
>  drivers/pci/setup-res.c       | 2 +-
>  include/uapi/linux/pci_regs.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dfc9a2794141..7d5d4a56a186 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -231,7 +231,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  			res->flags |= IORESOURCE_ROM_ENABLE;
>  		l64 = l & PCI_ROM_ADDRESS_MASK;
>  		sz64 = sz & PCI_ROM_ADDRESS_MASK;
> -		mask64 = (u32)PCI_ROM_ADDRESS_MASK;
> +		mask64 = PCI_ROM_ADDRESS_MASK;
>  	}
>  
>  	if (res->flags & IORESOURCE_MEM_64) {
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 4bc589ee78d0..85774b7a316a 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -63,7 +63,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
>  		mask = (u32)PCI_BASE_ADDRESS_IO_MASK;
>  		new |= res->flags & ~PCI_BASE_ADDRESS_IO_MASK;
>  	} else if (resno == PCI_ROM_RESOURCE) {
> -		mask = (u32)PCI_ROM_ADDRESS_MASK;
> +		mask = PCI_ROM_ADDRESS_MASK;
>  	} else {
>  		mask = (u32)PCI_BASE_ADDRESS_MEM_MASK;
>  		new |= res->flags & ~PCI_BASE_ADDRESS_MEM_MASK;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 634c9c44ed6c..fff521c9458c 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -114,7 +114,7 @@
>  #define PCI_SUBSYSTEM_ID	0x2e
>  #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1 reserved */
>  #define  PCI_ROM_ADDRESS_ENABLE	0x01
> -#define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)
> +#define PCI_ROM_ADDRESS_MASK	(~0x7ffU)
>  
>  #define PCI_CAPABILITY_LIST	0x34	/* Offset of first capability list entry */
>  
> -- 
> 2.12.2.762.g0e3151a226-goog
> 
