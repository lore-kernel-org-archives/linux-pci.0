Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Expand documentation for pci_add_dma_alias()
To: Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Doug Meyer <dmeyer@gigaio.com>
References: <20180524173913.4506-1-logang@deltatee.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b2481367-3acc-4d54-bae7-cc27fb38232e@infradead.org>
Date: Thu, 24 May 2018 10:44:03 -0700
MIME-Version: 1.0
In-Reply-To: <20180524173913.4506-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/24/2018 10:39 AM, Logan Gunthorpe wrote:
> Seeing there's been some confusion about the use of pci_add_dma_alias(),
> expand the comment to describe why it must be called early and how
> early it must be called.
> 
> Also, expand on the purpose of this function and common reasons it would
> be used.
> 
> [The comment was reworded to some extent by Alex Williamson]
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Doug Meyer <dmeyer@gigaio.com>
> ---
> 
> v2: Reworked the patch with Alex's suggested wording.
> 
>   drivers/pci/pci.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index dbfe7c4f3776..1c0c1ea23b90 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5395,8 +5395,19 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   * @dev: the PCI device for which alias is added
>   * @devfn: alias slot and function
>   *
> - * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
> - * It should be called early, preferably as PCI fixup header quirk.
> + * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
> + * which is used to program permissible BDF source addresses for DMA

It took me a few seconds to decode BDF.  FWIW, I would prefer to see
bus-devfn or bus-dev-fn or bus-dev-func or bus-dev-function.

> + * requests in an IOMMU. These aliases factor into IOMMU group creation
> + * and are useful for devices generating DMA requests beyond or different
> + * from their logical bus devfn. Examples include device quirks where the

                         ^ Here it's "bus devfn."

> + * device simply uses the wronge devfn, as well as non-transparent bridges

                             wrong

> + * where the alias may be a proxy for devices in another domain.
> + *
> + * IOMMU group creation is performed during device discovery or addition,
> + * prior to any potential DMA mapping and therefore prior to driver probing
> + * (especially for userspace assigned devices where IOMMU group definition
> + * cannot be left as a userspace activity). DMA aliases should therefore
> + * be configured via quirks, such as the PCI fixup header quirk.
>   */
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
> --
> 2.11.0
> 


-- 
~Randy
