Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:1315 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbbGVVJd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2015 17:09:33 -0400
Subject: Re: [PATCH v4 1/4] PCI: iproc: enable arm64 support for iProc PCIe
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1437528583-855-1-git-send-email-rjui@broadcom.com>
 <1437528583-855-2-git-send-email-rjui@broadcom.com>
 <20150722205316.GO21967@google.com>
CC: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <55B00684.7070502@broadcom.com>
Date: Wed, 22 Jul 2015 14:09:24 -0700
MIME-Version: 1.0
In-Reply-To: <20150722205316.GO21967@google.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 7/22/2015 1:53 PM, Bjorn Helgaas wrote:
> On Tue, Jul 21, 2015 at 06:29:40PM -0700, Ray Jui wrote:
>> This patch enables arm64 support to the iProc PCIe driver
>>
>> Note struct pci_sys_data is arm32 specific and will eventually be
>> removed. This change is done in such a way that when struct pci_sys_data
>> is removed from arm32, one only needs to also remove it from
>> pcie-iproc.h, no other change in the iProc PCIe core driver is needed
>>
>> In addition, arm64 based PCI driver does not require call to
>> pci_fixup_irqs, as it implements OF based irq parsing and mapping in
>> pcibios_add_device
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>  drivers/pci/host/pcie-iproc.c |   15 ++++-----------
>>  drivers/pci/host/pcie-iproc.h |    8 ++++++--
>>  2 files changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>> index d77481e..8a556d5 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -58,11 +58,6 @@
>>  #define SYS_RC_INTX_EN               0x330
>>  #define SYS_RC_INTX_MASK             0xf
>>  
>> -static inline struct iproc_pcie *sys_to_pcie(struct pci_sys_data *sys)
>> -{
>> -	return sys->private_data;
>> -}
>> -
>>  /**
>>   * Note access to the configuration registers are protected at the higher layer
>>   * by 'pci_lock' in drivers/pci/access.c
>> @@ -71,8 +66,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>>  					    unsigned int devfn,
>>  					    int where)
>>  {
>> -	struct pci_sys_data *sys = bus->sysdata;
>> -	struct iproc_pcie *pcie = sys_to_pcie(sys);
>> +	struct iproc_pcie *pcie = bus->sysdata;
> 
> I'm thinking something like the following so we don't depend on
> pci_sys_data being at the beginning of iproc_pcie.  What do you think?
> It has more ifdefs but feels a bit safer.  And I don't mind if ugly code
> comes with ugly ifdefs -- it's a little incentive to make the code cleaner.
> 
> 
> commit 8d9bfe3702aaea457b3d59b09b86e9f03c322605
> Author: Ray Jui <rjui@broadcom.com>
> Date:   Tue Jul 21 18:29:40 2015 -0700
> 
>     PCI: iproc: Add arm64 support
>     
>     Add arm64 support to the iProc PCIe driver.
>     
>     Note that on arm32, bus->sysdata points to the arm32-specific pci_sys_data
>     struct, and pci_sys_data.private_data contains the iproc_pcie pointer.
>     For arm64, there's nothing corresponding to pci_sys_data, so we keep the
>     iproc_pcie pointer directly in bus->sysdata.
>     
>     In addition, arm64 does IRQ mapping in pcibios_add_device(), so it doesn't
>     need pci_fixup_irqs() as arm32 does.
>     
>     Signed-off-by: Ray Jui <rjui@broadcom.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Scott Branden <sbranden@broadcom.com>
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 9a00dca..fe2efb1 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -58,9 +58,17 @@
>  #define SYS_RC_INTX_EN               0x330
>  #define SYS_RC_INTX_MASK             0xf
>  
> -static inline struct iproc_pcie *sys_to_pcie(struct pci_sys_data *sys)
> +static inline struct iproc_pcie *iproc_data(struct pci_bus *bus)
>  {
> -	return sys->private_data;
> +	struct iproc_pcie *pcie;
> +#ifdef CONFIG_ARM
> +	struct pci_sys_data *sys = bus->sysdata;
> +
> +	pcie = sys->private_data;
> +#else
> +	pcie = bus->sysdata;
> +#endif
> +	return pcie;
>  }
>  
>  /**
> @@ -71,8 +79,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>  					    unsigned int devfn,
>  					    int where)
>  {
> -	struct pci_sys_data *sys = bus->sysdata;
> -	struct iproc_pcie *pcie = sys_to_pcie(sys);
> +	struct iproc_pcie *pcie = iproc_data(bus);
>  	unsigned slot = PCI_SLOT(devfn);
>  	unsigned fn = PCI_FUNC(devfn);
>  	unsigned busno = bus->number;
> @@ -186,6 +193,7 @@ static void iproc_pcie_enable(struct iproc_pcie *pcie)
>  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  {
>  	int ret;
> +	void *sysdata;
>  	struct pci_bus *bus;
>  
>  	if (!pcie || !pcie->dev || !pcie->base)
> @@ -205,10 +213,14 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  
>  	iproc_pcie_reset(pcie);
>  
> +#ifdef CONFIG_ARM
>  	pcie->sysdata.private_data = pcie;
> +	sysdata = &pcie->sysdata;
> +#else
> +	sysdata = pcie;
> +#endif
>  
> -	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
> -				  &pcie->sysdata, res);
> +	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops, sysdata, res);
>  	if (!bus) {
>  		dev_err(pcie->dev, "unable to create PCI root bus\n");
>  		ret = -ENOMEM;
> @@ -226,7 +238,9 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  
>  	pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
> +#ifdef CONFIG_ARM
>  	pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
> +#endif
>  	pci_bus_add_devices(bus);
>  
>  	return 0;
> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
> index ba0a108..c9e4c10 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -21,7 +21,7 @@
>   * @dev: pointer to device data structure
>   * @base: PCIe host controller I/O register base
>   * @resources: linked list of all PCI resources
> - * @sysdata: Per PCI controller data
> + * @sysdata: Per PCI controller data (ARM-specific)
>   * @root_bus: pointer to root bus
>   * @phy: optional PHY device that controls the Serdes
>   * @irqs: interrupt IDs
> @@ -29,7 +29,9 @@
>  struct iproc_pcie {
>  	struct device *dev;
>  	void __iomem *base;
> +#ifdef CONFIG_ARM
>  	struct pci_sys_data sysdata;
> +#endif
>  	struct pci_bus *root_bus;
>  	struct phy *phy;
>  	int irqs[IPROC_PCIE_MAX_NUM_IRQS];
> 

I'm fine with the entire change. Both of us understand it's temporary
and will be removed as soon as struct pci_sys_data is removed from ARM32.

Note I don't know how the code merge should work here. The iProc PCIe
driver is enabled when CONFIG_ARCH_BCM_IPROC is enabled. Note patch #3
of this series enables CONFIG_ARCH_BCM_IPROC for arm64. Without this
patch, arm64 build will be broken because of struct pci_sys_data.

I know you are taking PCI changes and I assume Catalin will be merging
arm64 related changes. But patches in this patch series need to go
together to keep things intact.

Thanks,

Ray
