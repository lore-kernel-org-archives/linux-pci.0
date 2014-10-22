Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:49659 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933179AbaJVXXK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Oct 2014 19:23:10 -0400
Received: by mail-ie0-f171.google.com with SMTP id x19so3953840ier.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2014 16:23:09 -0700 (PDT)
Date: Wed, 22 Oct 2014 17:23:07 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 2/3] PCI: use u8 instead of int for pci configuration
 space pos and cap
Message-ID: <20141022232307.GD4795@google.com>
References: <1413269253-8990-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1413269253-8990-3-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413269253-8990-3-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Tue, Oct 14, 2014 at 02:47:31PM +0800, Wei Yang wrote:
> For pci devices complying with PCI LB 3.0, the configuration space size is
> 256 and the Cap ID is represented by a 8bit field. This means a type of u8 is
> enough to repsent the Cap's position and ID.
> 
> This patch does some clean up for the Cap position and ID by replacing the int
> type with u8. And consolidate the check of whether a Cap is represented from
> (pos <= 0) to (!pos).
> 
> And two functions use char to represent cap, it is changed to u8 in this
> patch.

Please spell-check the changelog.  Please also split the return value check
changes ("pos <= 0" to "!pos") into a separate patch.  That part is not
obviously correct.

> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  drivers/pci/pci.c    |   55 +++++++++++++++++++++++++-------------------------
>  drivers/pci/probe.c  |    8 ++++----
>  drivers/pci/quirks.c |   19 ++++++++---------
>  include/linux/pci.h  |   20 +++++++++---------
>  4 files changed, 52 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 76b002b1..47d8d0c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -138,8 +138,8 @@ EXPORT_SYMBOL_GPL(pci_ioremap_bar);
>  #endif
>  
>  
> -static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
> -				   u8 pos, int cap, int *ttl)
> +static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
> +				   u8 pos, u8 cap, int *ttl)
>  {
>  	u8 id;
>  
> @@ -159,22 +159,22 @@ static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
>  	return 0;
>  }
>  
> -static int __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
> -			       u8 pos, int cap)
> +static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
> +			       u8 pos, u8 cap)
>  {
>  	int ttl = PCI_FIND_CAP_TTL;
>  
>  	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
>  }
>  
> -int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
> +u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, u8 cap)
>  {
>  	return __pci_find_next_cap(dev->bus, dev->devfn,
>  				   pos + PCI_CAP_LIST_NEXT, cap);
>  }
>  EXPORT_SYMBOL_GPL(pci_find_next_capability);
>  
> -static int __pci_bus_find_cap_start(struct pci_bus *bus,
> +static u8 __pci_bus_find_cap_start(struct pci_bus *bus,
>  				    unsigned int devfn, u8 hdr_type)
>  {
>  	u16 status;
> @@ -215,9 +215,9 @@ static int __pci_bus_find_cap_start(struct pci_bus *bus,
>   *  %PCI_CAP_ID_PCIX         PCI-X
>   *  %PCI_CAP_ID_EXP          PCI Express
>   */
> -int pci_find_capability(struct pci_dev *dev, int cap)
> +u8 pci_find_capability(struct pci_dev *dev, u8 cap)
>  {
> -	int pos;
> +	u8 pos;
>  
>  	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
>  	if (pos)
> @@ -240,9 +240,9 @@ EXPORT_SYMBOL(pci_find_capability);
>   * device's PCI configuration space or 0 in case the device does not
>   * support it.
>   */
> -int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap)
> +u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, u8 cap)
>  {
> -	int pos;
> +	u8 pos;
>  	u8 hdr_type;
>  
>  	pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type);
> @@ -327,7 +327,7 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_ext_capability);
>  
> -static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
> +static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>  {
>  	int rc, ttl = PCI_FIND_CAP_TTL;
>  	u8 cap, mask;
> @@ -367,7 +367,7 @@ static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
>   * NB. To be 100% safe against broken PCI devices, the caller should take
>   * steps to avoid an infinite loop.
>   */
> -int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap)
> +u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap)
>  {
>  	return __pci_find_next_ht_cap(dev, pos + PCI_CAP_LIST_NEXT, ht_cap);
>  }
> @@ -384,9 +384,9 @@ EXPORT_SYMBOL_GPL(pci_find_next_ht_capability);
>   * The address points to the PCI capability, of type PCI_CAP_ID_HT,
>   * which has a Hypertransport capability matching @ht_cap.
>   */
> -int pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
> +u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
>  {
> -	int pos;
> +	u8 pos;
>  
>  	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);
>  	if (pos)
> @@ -896,7 +896,7 @@ static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
>  	return NULL;
>  }
>  
> -struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap)
> +struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, u8 cap)
>  {
>  	return _pci_find_saved_cap(dev, cap, false);
>  }
> @@ -956,11 +956,11 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  
>  static int pci_save_pcix_state(struct pci_dev *dev)
>  {
> -	int pos;
> +	u8 pos;
>  	struct pci_cap_saved_state *save_state;
>  
>  	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
> -	if (pos <= 0)
> +	if (!pos)
>  		return 0;
>  
>  	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> @@ -977,13 +977,14 @@ static int pci_save_pcix_state(struct pci_dev *dev)
>  
>  static void pci_restore_pcix_state(struct pci_dev *dev)
>  {
> -	int i = 0, pos;
> +	int i = 0;
> +	u8 pos;
>  	struct pci_cap_saved_state *save_state;
>  	u16 *cap;
>  
>  	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
>  	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
> -	if (!save_state || pos <= 0)
> +	if (!save_state || !pos)
>  		return;
>  	cap = (u16 *)&save_state->cap.data[0];
>  
> @@ -2036,7 +2037,7 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
>   */
>  void pci_pm_init(struct pci_dev *dev)
>  {
> -	int pm;
> +	u8 pm;
>  	u16 pmc;
>  
>  	pm_runtime_forbid(&dev->dev);
> @@ -2126,7 +2127,7 @@ static int _pci_add_cap_save_buffer(struct pci_dev *dev, u16 cap,
>  	else
>  		pos = pci_find_capability(dev, cap);
>  
> -	if (pos <= 0)
> +	if (!pos)
>  		return 0;
>  
>  	save_state = kzalloc(sizeof(*save_state) + size, GFP_KERNEL);
> @@ -2141,7 +2142,7 @@ static int _pci_add_cap_save_buffer(struct pci_dev *dev, u16 cap,
>  	return 0;
>  }
>  
> -int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size)
> +int pci_add_cap_save_buffer(struct pci_dev *dev, u8 cap, unsigned int size)
>  {
>  	return _pci_add_cap_save_buffer(dev, cap, false, size);
>  }
> @@ -3046,7 +3047,7 @@ EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
>   */
>  void pci_msi_off(struct pci_dev *dev)
>  {
> -	int pos;
> +	u8 pos;
>  	u16 control;
>  
>  	/*
> @@ -3120,7 +3121,7 @@ static int pcie_flr(struct pci_dev *dev, int probe)
>  
>  static int pci_af_flr(struct pci_dev *dev, int probe)
>  {
> -	int pos;
> +	u8 pos;
>  	u8 cap;
>  
>  	pos = pci_find_capability(dev, PCI_CAP_ID_AF);
> @@ -3888,7 +3889,7 @@ EXPORT_SYMBOL_GPL(pci_try_reset_bus);
>   */
>  int pcix_get_max_mmrbc(struct pci_dev *dev)
>  {
> -	int cap;
> +	u8 cap;
>  	u32 stat;
>  
>  	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
> @@ -3911,7 +3912,7 @@ EXPORT_SYMBOL(pcix_get_max_mmrbc);
>   */
>  int pcix_get_mmrbc(struct pci_dev *dev)
>  {
> -	int cap;
> +	u8 cap;
>  	u16 cmd;
>  
>  	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
> @@ -3936,7 +3937,7 @@ EXPORT_SYMBOL(pcix_get_mmrbc);
>   */
>  int pcix_set_mmrbc(struct pci_dev *dev, int mmrbc)
>  {
> -	int cap;
> +	u8 cap;
>  	u32 stat, v, o;
>  	u16 cmd;
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4170113..9b316bf 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -606,7 +606,7 @@ static enum pci_bus_speed agp_speed(int agp3, int agpstat)
>  static void pci_set_bus_speed(struct pci_bus *bus)
>  {
>  	struct pci_dev *bridge = bus->self;
> -	int pos;
> +	u8 pos;
>  
>  	pos = pci_find_capability(bridge, PCI_CAP_ID_AGP);
>  	if (!pos)
> @@ -958,7 +958,7 @@ static void pci_read_irq(struct pci_dev *dev)
>  
>  void set_pcie_port_type(struct pci_dev *pdev)
>  {
> -	int pos;
> +	u8 pos;
>  	u16 reg16;
>  
>  	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> @@ -1046,7 +1046,7 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
>  
>  int pci_cfg_space_size(struct pci_dev *dev)
>  {
> -	int pos;
> +	u8 pos;
>  	u32 status;
>  	u16 class;
>  
> @@ -1087,7 +1087,7 @@ int pci_setup_device(struct pci_dev *dev)
>  	u32 class;
>  	u8 hdr_type;
>  	struct pci_slot *slot;
> -	int pos = 0;
> +	u8 pos = 0;
>  	struct pci_bus_region region;
>  	struct resource *res;
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a5f46b8..15b76a0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2176,7 +2176,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x9601, quirk_amd_780_apc_msi);
>   * return 1 if a HT MSI capability is found and enabled */
>  static int msi_ht_cap_enabled(struct pci_dev *dev)
>  {
> -	int pos, ttl = PCI_FIND_CAP_TTL;
> +	u8 pos, ttl = PCI_FIND_CAP_TTL;
>  
>  	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
>  	while (pos && ttl--) {
> @@ -2235,7 +2235,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
>  /* Force enable MSI mapping capability on HT bridges */
>  static void ht_enable_msi_mapping(struct pci_dev *dev)
>  {
> -	int pos, ttl = PCI_FIND_CAP_TTL;
> +	u8 pos, ttl = PCI_FIND_CAP_TTL;
>  
>  	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
>  	while (pos && ttl--) {
> @@ -2314,7 +2314,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
>  
>  static int ht_check_msi_mapping(struct pci_dev *dev)
>  {
> -	int pos, ttl = PCI_FIND_CAP_TTL;
> +	u8 pos, ttl = PCI_FIND_CAP_TTL;
>  	int found = 0;
>  
>  	/* check if there is HT MSI cap or enabled on this device */
> @@ -2343,7 +2343,7 @@ static int ht_check_msi_mapping(struct pci_dev *dev)
>  static int host_bridge_with_leaf(struct pci_dev *host_bridge)
>  {
>  	struct pci_dev *dev;
> -	int pos;
> +	u8 pos;
>  	int i, dev_no;
>  	int found = 0;
>  
> @@ -2376,7 +2376,8 @@ static int host_bridge_with_leaf(struct pci_dev *host_bridge)
>  
>  static int is_end_of_ht_chain(struct pci_dev *dev)
>  {
> -	int pos, ctrl_off;
> +	int ctrl_off;
> +	u8 pos;
>  	int end = 0;
>  	u16 flags, ctrl;
>  
> @@ -2401,7 +2402,7 @@ out:
>  static void nv_ht_enable_msi_mapping(struct pci_dev *dev)
>  {
>  	struct pci_dev *host_bridge;
> -	int pos;
> +	u8 pos;
>  	int i, dev_no;
>  	int found = 0;
>  
> @@ -2439,7 +2440,7 @@ out:
>  
>  static void ht_disable_msi_mapping(struct pci_dev *dev)
>  {
> -	int pos, ttl = PCI_FIND_CAP_TTL;
> +	u8 pos, ttl = PCI_FIND_CAP_TTL;
>  
>  	pos = pci_find_ht_capability(dev, HT_CAPTYPE_MSI_MAPPING);
>  	while (pos && ttl--) {
> @@ -2460,7 +2461,7 @@ static void ht_disable_msi_mapping(struct pci_dev *dev)
>  static void __nv_msi_ht_cap_quirk(struct pci_dev *dev, int all)
>  {
>  	struct pci_dev *host_bridge;
> -	int pos;
> +	u8 pos;
>  	int found;
>  
>  	if (!pci_msi_enabled())
> @@ -3226,7 +3227,7 @@ fs_initcall_sync(pci_apply_final_quirks);
>   */
>  static int reset_intel_generic_dev(struct pci_dev *dev, int probe)
>  {
> -	int pos;
> +	u8 pos;
>  
>  	/* only implement PCI_CLASS_SERIAL_USB at present */
>  	if (dev->class == PCI_CLASS_SERIAL_USB) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b27b79e..399a18a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -818,12 +818,12 @@ enum pci_lost_interrupt_reason {
>  	PCI_LOST_IRQ_DISABLE_ACPI,
>  };
>  enum pci_lost_interrupt_reason pci_lost_interrupt(struct pci_dev *dev);
> -int pci_find_capability(struct pci_dev *dev, int cap);
> -int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
> +u8 pci_find_capability(struct pci_dev *dev, u8 cap);
> +u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, u8 cap);
>  int pci_find_ext_capability(struct pci_dev *dev, int cap);
>  int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
> -int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
> -int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
> +u8 pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
> +u8 pci_find_next_ht_capability(struct pci_dev *dev, u8 pos, int ht_cap);
>  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
>  
>  struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
> @@ -1004,10 +1004,10 @@ void pci_restore_state(struct pci_dev *dev);
>  struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev);
>  int pci_load_and_free_saved_state(struct pci_dev *dev,
>  				  struct pci_saved_state **state);
> -struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
> +struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, u8 cap);
>  struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
>  						   u16 cap);
> -int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size);
> +int pci_add_cap_save_buffer(struct pci_dev *dev, u8 cap, unsigned int size);
>  int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
>  				u16 cap, unsigned int size);
>  int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state);
> @@ -1045,7 +1045,7 @@ void set_pcie_port_type(struct pci_dev *pdev);
>  void set_pcie_hotplug_bridge(struct pci_dev *pdev);
>  
>  /* Functions for PCI Hotplug drivers to use */
> -int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
> +u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, u8 cap);
>  unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
>  unsigned int pci_rescan_bus(struct pci_bus *bus);
>  void pci_lock_rescan_remove(void);
> @@ -1360,10 +1360,10 @@ static inline int __pci_register_driver(struct pci_driver *drv,
>  static inline int pci_register_driver(struct pci_driver *drv)
>  { return 0; }
>  static inline void pci_unregister_driver(struct pci_driver *drv) { }
> -static inline int pci_find_capability(struct pci_dev *dev, int cap)
> +static inline u8 pci_find_capability(struct pci_dev *dev, u8 cap)
>  { return 0; }
> -static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
> -					   int cap)
> +static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post,
> +					   u8 cap)
>  { return 0; }
>  static inline int pci_find_ext_capability(struct pci_dev *dev, int cap)
>  { return 0; }
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
