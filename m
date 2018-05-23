Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 23 May 2018 16:06:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, Bjorn Helgaas <bhelgaas@google.com>,
        Doug Meyer <dmeyer@gigaio.com>
Subject: Re: [PATCH] PCI: Expand documentation for pci_add_dma_alias()
Message-ID: <20180523160638.03f6db90@w520.home>
In-Reply-To: <20180523210738.2883-1-logang@deltatee.com>
References: <20180523210738.2883-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 23 May 2018 15:07:38 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> Seeing there's been some confusion about the use of pci_add_dma_alias(),
> expand the comment to describe why it must be called early and how
> early it must be called.
> 
> Also, expand on the purpose of this function and common reasons it would
> be used.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Doug Meyer <dmeyer@gigaio.com>
> ---
>  drivers/pci/pci.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index dbfe7c4f3776..2a410745a95a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5395,8 +5395,19 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   * @dev: the PCI device for which alias is added
>   * @devfn: alias slot and function
>   *
> - * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
> - * It should be called early, preferably as PCI fixup header quirk.
> + * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
> + * which is used to program permissible BDF source addresses for
> + * DMA requests in an IOMMU. This is useful for non-transparent bridges
> + * which use BDFs that are not visible on the bus as proxies for devices
> + * in another domain. It's also useful for grouping of multiple devices
> + * that must be done without a host endpoint driver.
> + *
> + * This function must be called early, before the IOMMU creates
> + * the groups for the device which happens with a BUS_NOTIFY_ADD_DEVICE
> + * event. This occurs before the driver's probe function is called seeing
> + * the groups must be ready before any DMA mappings for the device are created.
> + * Therefore, this function cannot be called in a driver and, instead,
> + * should be called as a PCI fixup header quirk.
>   */
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {

I might massage this a little further, something like:

  This helper encodes an 8-bit devfn as a bit number in dma_alias_mask,
  which is used to program permissible BDF source addresses for DMA
  requests in the IOMMU.  These aliases factor into IOMMU group
  creation and are useful for devices generating DMA requests beyond or
  different from their logical bus devfn.  Examples include device
  quirks where the device simply uses the wrong devfn, as well as
  non-transparent bridges where the alias may be a proxy for devices in
  another domain.

  IOMMU group creation is performed during device discovery or
  addition, prior to any potential DMA mapping and therefore prior to
  driver probing, particularly for userspace assigned devices where
  IOMMU group definition cannot be left as a userspace activity.  DMA
  aliases should therefore be configured via quirks, such as the PCI
  fixup header quirk.

Thanks,
Alex
