Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752960AbdK0Tw0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Nov 2017 14:52:26 -0500
Received: from localhost (173-25-104-53.client.mchsi.com [173.25.104.53])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4045621921
        for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2017 19:52:23 +0000 (UTC)
Subject: [PATCH v1] PCI: Clean up whitespace in linux/pci.h, pci/pci.h
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Date: Mon, 27 Nov 2017 13:52:18 -0600
Message-ID: <20171127195218.21785.62781.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Clean up whitespace, capitalization, etc. in comments.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h   |   54 +++----
 include/linux/pci.h |  411 ++++++++++++++++++++++++---------------------------
 2 files changed, 222 insertions(+), 243 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f6b58b32a67c..69fc9c1b4668 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -38,21 +38,21 @@ int pci_probe_reset_function(struct pci_dev *dev);
  * struct pci_platform_pm_ops - Firmware PM callbacks
  *
  * @is_manageable: returns 'true' if given device is power manageable by the
- *                 platform firmware
+ *		   platform firmware
  *
  * @set_state: invokes the platform firmware to set the device's power state
  *
  * @get_state: queries the platform firmware for a device's current power state
  *
  * @choose_state: returns PCI power state of given device preferred by the
- *                platform; to be used during system-wide transitions from a
- *                sleeping state to the working state and vice versa
+ *		  platform; to be used during system-wide transitions from a
+ *		  sleeping state to the working state and vice versa
  *
  * @set_wakeup: enables/disables wakeup capability for the device
  *
  * @need_resume: returns 'true' if the given device (which is currently
- *		suspended) needs to be resumed to be configured for system
- *		wakeup.
+ *		 suspended) needs to be resumed to be configured for system
+ *		 wakeup.
  *
  * If given platform is generally capable of power managing PCI devices, all of
  * these callbacks are mandatory.
@@ -112,7 +112,7 @@ struct pci_vpd_ops {
 
 struct pci_vpd {
 	const struct pci_vpd_ops *ops;
-	struct bin_attribute *attr; /* descriptor for sysfs VPD entry */
+	struct bin_attribute *attr;	/* Descriptor for sysfs VPD entry */
 	struct mutex	lock;
 	unsigned int	len;
 	u16		flag;
@@ -199,7 +199,7 @@ extern const struct attribute_group *pci_bus_groups[];
 
 /**
  * pci_match_one_device - Tell if a PCI device structure has a matching
- *                        PCI device id structure
+ *			  PCI device id structure
  * @id: single PCI device id structure to match
  * @dev: the PCI device structure to match against
  *
@@ -231,7 +231,7 @@ struct pci_slot_attribute {
 
 enum pci_bar_type {
 	pci_bar_unknown,	/* Standard PCI BAR probe */
-	pci_bar_io,		/* An io port BAR */
+	pci_bar_io,		/* An I/O port BAR */
 	pci_bar_mem32,		/* A 32-bit memory BAR */
 	pci_bar_mem64,		/* A 64-bit memory BAR */
 };
@@ -255,24 +255,24 @@ void pci_disable_bridge_window(struct pci_dev *dev);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
-	int pos;		/* capability position */
-	int nres;		/* number of resources */
-	u32 cap;		/* SR-IOV Capabilities */
-	u16 ctrl;		/* SR-IOV Control */
-	u16 total_VFs;		/* total VFs associated with the PF */
-	u16 initial_VFs;	/* initial VFs associated with the PF */
-	u16 num_VFs;		/* number of VFs available */
-	u16 offset;		/* first VF Routing ID offset */
-	u16 stride;		/* following VF stride */
-	u16 vf_device;		/* VF device ID */
-	u32 pgsz;		/* page size for BAR alignment */
-	u8 link;		/* Function Dependency Link */
-	u8 max_VF_buses;	/* max buses consumed by VFs */
-	u16 driver_max_VFs;	/* max num VFs driver supports */
-	struct pci_dev *dev;	/* lowest numbered PF */
-	struct pci_dev *self;	/* this PF */
-	resource_size_t barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
-	bool drivers_autoprobe;	/* auto probing of VFs by driver */
+	int		pos;		/* Capability position */
+	int		nres;		/* Number of resources */
+	u32		cap;		/* SR-IOV Capabilities */
+	u16		ctrl;		/* SR-IOV Control */
+	u16		total_VFs;	/* Total VFs associated with the PF */
+	u16		initial_VFs;	/* Initial VFs associated with the PF */
+	u16		num_VFs;	/* Number of VFs available */
+	u16		offset;		/* First VF Routing ID offset */
+	u16		stride;		/* Following VF stride */
+	u16		vf_device;	/* VF device ID */
+	u32		pgsz;		/* Page size for BAR alignment */
+	u8		link;		/* Function Dependency Link */
+	u8		max_VF_buses;	/* Max buses consumed by VFs */
+	u16		driver_max_VFs;	/* Max num VFs driver supports */
+	struct pci_dev	*dev;		/* Lowest numbered PF */
+	struct pci_dev	*self;		/* This PF */
+	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
+	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
 /* pci_dev priv_flags */
@@ -335,7 +335,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 	if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END)
 		return pci_sriov_resource_alignment(dev, resno);
 #endif
-	if (dev->class >> 8  == PCI_CLASS_BRIDGE_CARDBUS)
+	if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS)
 		return pci_cardbus_resource_alignment(res);
 	return resource_alignment(res);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0403894147a3..a1589dec7e33 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -48,17 +48,17 @@
  * In the interest of not exposing interfaces to user-space unnecessarily,
  * the following kernel-only defines are being added here.
  */
-#define PCI_DEVID(bus, devfn)  ((((u16)(bus)) << 8) | (devfn))
+#define PCI_DEVID(bus, devfn)	((((u16)(bus)) << 8) | (devfn))
 /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
 #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
 
 /* pci_slot represents a physical slot */
 struct pci_slot {
-	struct pci_bus *bus;		/* The bus this slot is on */
-	struct list_head list;		/* node in list of slots on this bus */
-	struct hotplug_slot *hotplug;	/* Hotplug info (migrate over time) */
-	unsigned char number;		/* PCI_SLOT(pci_dev->devfn) */
-	struct kobject kobj;
+	struct pci_bus		*bus;		/* Bus this slot is on */
+	struct list_head	list;		/* Node in list of slots */
+	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
+	unsigned char		number;		/* PCI_SLOT(pci_dev->devfn) */
+	struct kobject		kobj;
 };
 
 static inline const char *pci_slot_name(const struct pci_slot *slot)
@@ -72,9 +72,7 @@ enum pci_mmap_state {
 	pci_mmap_mem
 };
 
-/*
- *  For PCI devices, the region numbers are assigned this way:
- */
+/* For PCI devices, the region numbers are assigned this way: */
 enum {
 	/* #0-5: standard PCI resources */
 	PCI_STD_RESOURCES,
@@ -83,23 +81,23 @@ enum {
 	/* #6: expansion ROM resource */
 	PCI_ROM_RESOURCE,
 
-	/* device specific resources */
+	/* Device-specific resources */
 #ifdef CONFIG_PCI_IOV
 	PCI_IOV_RESOURCES,
 	PCI_IOV_RESOURCE_END = PCI_IOV_RESOURCES + PCI_SRIOV_NUM_BARS - 1,
 #endif
 
-	/* resources assigned to buses behind the bridge */
+	/* Resources assigned to buses behind the bridge */
 #define PCI_BRIDGE_RESOURCE_NUM 4
 
 	PCI_BRIDGE_RESOURCES,
 	PCI_BRIDGE_RESOURCE_END = PCI_BRIDGE_RESOURCES +
 				  PCI_BRIDGE_RESOURCE_NUM - 1,
 
-	/* total resources associated with a PCI device */
+	/* Total resources associated with a PCI device */
 	PCI_NUM_RESOURCES,
 
-	/* preserve this for compatibility */
+	/* Preserve this for compatibility */
 	DEVICE_COUNT_RESOURCE = PCI_NUM_RESOURCES,
 };
 
@@ -152,9 +150,10 @@ static inline const char *pci_power_name(pci_power_t state)
 #define PCI_PM_D3COLD_WAIT	100
 #define PCI_PM_BUS_WAIT		50
 
-/** The pci_channel state describes connectivity between the CPU and
- *  the pci device.  If some PCI bus between here and the pci device
- *  has crashed or locked up, this info is reflected here.
+/**
+ * The pci_channel state describes connectivity between the CPU and
+ * the PCI device.  If some PCI bus between here and the PCI device
+ * has crashed or locked up, this info is reflected here.
  */
 typedef unsigned int __bitwise pci_channel_state_t;
 
@@ -184,9 +183,7 @@ enum pcie_reset_state {
 
 typedef unsigned short __bitwise pci_dev_flags_t;
 enum pci_dev_flags {
-	/* INTX_DISABLE in PCI_COMMAND register disables MSI
-	 * generation too.
-	 */
+	/* INTX_DISABLE in PCI_COMMAND register disables MSI too */
 	PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG = (__force pci_dev_flags_t) (1 << 0),
 	/* Device configuration is irrevocably lost if disabled into D3 */
 	PCI_DEV_FLAGS_NO_D3 = (__force pci_dev_flags_t) (1 << 1),
@@ -202,7 +199,7 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
 	/* Get VPD from function 0 VPD */
 	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
-	/* a non-root bridge where translation occurs, stop alias search here */
+	/* A non-root bridge where translation occurs, stop alias search here */
 	PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT = (__force pci_dev_flags_t) (1 << 9),
 	/* Do not use FLR even if device advertises PCI_AF_CAP */
 	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
@@ -222,17 +219,17 @@ enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
 };
 
-/* These values come from the PCI Express Spec */
+/* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
 enum pcie_link_width {
 	PCIE_LNK_WIDTH_RESRV	= 0x00,
 	PCIE_LNK_X1		= 0x01,
 	PCIE_LNK_X2		= 0x02,
 	PCIE_LNK_X4		= 0x04,
 	PCIE_LNK_X8		= 0x08,
-	PCIE_LNK_X12		= 0x0C,
+	PCIE_LNK_X12		= 0x0c,
 	PCIE_LNK_X16		= 0x10,
 	PCIE_LNK_X32		= 0x20,
-	PCIE_LNK_WIDTH_UNKNOWN  = 0xFF,
+	PCIE_LNK_WIDTH_UNKNOWN	= 0xff,
 };
 
 /* Based on the PCI Hotplug Spec, but some values are made up by us */
@@ -263,15 +260,15 @@ enum pci_bus_speed {
 };
 
 struct pci_cap_saved_data {
-	u16 cap_nr;
-	bool cap_extended;
-	unsigned int size;
-	u32 data[0];
+	u16		cap_nr;
+	bool		cap_extended;
+	unsigned int	size;
+	u32		data[0];
 };
 
 struct pci_cap_saved_state {
-	struct hlist_node next;
-	struct pci_cap_saved_data cap;
+	struct hlist_node		next;
+	struct pci_cap_saved_data	cap;
 };
 
 struct irq_affinity;
@@ -280,19 +277,17 @@ struct pci_vpd;
 struct pci_sriov;
 struct pci_ats;
 
-/*
- * The pci_dev structure is used to describe PCI devices.
- */
+/* The pci_dev structure describes PCI devices */
 struct pci_dev {
-	struct list_head bus_list;	/* node in per-bus list */
-	struct pci_bus	*bus;		/* bus this device is on */
-	struct pci_bus	*subordinate;	/* bus this device bridges to */
+	struct list_head bus_list;	/* Node in per-bus list */
+	struct pci_bus	*bus;		/* Bus this device is on */
+	struct pci_bus	*subordinate;	/* Bus this device bridges to */
 
-	void		*sysdata;	/* hook for sys-specific extension */
-	struct proc_dir_entry *procent;	/* device entry in /proc/bus/pci */
+	void		*sysdata;	/* Hook for sys-specific extension */
+	struct proc_dir_entry *procent;	/* Device entry in /proc/bus/pci */
 	struct pci_slot	*slot;		/* Physical slot this device is in */
 
-	unsigned int	devfn;		/* encoded device & function index */
+	unsigned int	devfn;		/* Encoded device & function index */
 	unsigned short	vendor;
 	unsigned short	device;
 	unsigned short	subsystem_vendor;
@@ -307,12 +302,12 @@ struct pci_dev {
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
 	u8		pcie_mpss:3;	/* PCIe Max Payload Size Supported */
-	u8		rom_base_reg;	/* which config register controls the ROM */
-	u8		pin;		/* which interrupt pin this device uses */
-	u16		pcie_flags_reg;	/* cached PCIe Capabilities Register */
-	unsigned long	*dma_alias_mask;/* mask of enabled devfn aliases */
+	u8		rom_base_reg;	/* Config register controlling ROM */
+	u8		pin;		/* Interrupt pin this device uses */
+	u16		pcie_flags_reg;	/* Cached PCIe Capabilities Register */
+	unsigned long	*dma_alias_mask;/* Mask of enabled devfn aliases */
 
-	struct pci_driver *driver;	/* which driver has allocated this device */
+	struct pci_driver *driver;	/* Driver bound to this device */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
@@ -321,9 +316,9 @@ struct pci_dev {
 
 	struct device_dma_parameters dma_parms;
 
-	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
-					   this is D0-D3, D0 being fully functional,
-					   and D3 being off. */
+	pci_power_t	current_state;	/* Current operating state. In ACPI,
+					   this is D0-D3, D0 being fully
+					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
@@ -334,10 +329,10 @@ struct pci_dev {
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
-	unsigned int	mmio_always_on:1;	/* disallow turning off io/mem
-						   decoding during bar sizing */
+	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
+						   decoding during BAR sizing */
 	unsigned int	wakeup_prepared:1;
-	unsigned int	runtime_d3cold:1;	/* whether go through runtime
+	unsigned int	runtime_d3cold:1;	/* Whether go through runtime
 						   D3cold, not set for devices
 						   powered on/off by the
 						   corresponding bridge */
@@ -352,10 +347,10 @@ struct pci_dev {
 	struct pcie_link_state	*link_state;	/* ASPM link state */
 #endif
 
-	pci_channel_state_t error_state;	/* current connectivity state */
-	struct	device	dev;		/* Generic device interface */
+	pci_channel_state_t error_state;	/* Current connectivity state */
+	struct device	dev;			/* Generic device interface */
 
-	int		cfg_size;	/* Size of configuration space */
+	int		cfg_size;		/* Size of config space */
 
 	/*
 	 * Instead of touching interrupt line and base address registers
@@ -364,47 +359,47 @@ struct pci_dev {
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 
-	bool match_driver;		/* Skip attaching driver */
-	/* These fields are used by common fixups */
-	unsigned int	transparent:1;	/* Subtractive decode PCI bridge */
-	unsigned int	multifunction:1;/* Part of multi-function device */
-	/* keep track of device state */
+	bool		match_driver;		/* Skip attaching driver */
+
+	unsigned int	transparent:1;		/* Subtractive decode bridge */
+	unsigned int	multifunction:1;	/* Multi-function device */
+
 	unsigned int	is_added:1;
-	unsigned int	is_busmaster:1; /* device is busmaster */
-	unsigned int	no_msi:1;	/* device may not use msi */
-	unsigned int	no_64bit_msi:1; /* device may only use 32-bit MSIs */
-	unsigned int	block_cfg_access:1;	/* config space access is blocked */
-	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
-	unsigned int	irq_reroute_variant:2;	/* device needs IRQ rerouting variant */
+	unsigned int	is_busmaster:1;		/* Is busmaster */
+	unsigned int	no_msi:1;		/* May not use MSI */
+	unsigned int	no_64bit_msi:1; 	/* May only use 32-bit MSIs */
+	unsigned int	block_cfg_access:1;	/* Config space access blocked */
+	unsigned int	broken_parity_status:1;	/* Generates false positive parity */
+	unsigned int	irq_reroute_variant:2;	/* Needs IRQ rerouting variant */
 	unsigned int	msi_enabled:1;
 	unsigned int	msix_enabled:1;
-	unsigned int	ari_enabled:1;	/* ARI forwarding */
-	unsigned int	ats_enabled:1;	/* Address Translation Service */
+	unsigned int	ari_enabled:1;		/* ARI forwarding */
+	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
 	unsigned int	is_managed:1;
-	unsigned int    needs_freset:1; /* Dev requires fundamental reset */
+	unsigned int	needs_freset:1;		/* Requires fundamental reset */
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
 	unsigned int	reset_fn:1;
-	unsigned int    is_hotplug_bridge:1;
-	unsigned int	is_thunderbolt:1; /* Thunderbolt controller */
-	unsigned int    __aer_firmware_first_valid:1;
+	unsigned int	is_hotplug_bridge:1;
+	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	__aer_firmware_first_valid:1;
 	unsigned int	__aer_firmware_first:1;
-	unsigned int	broken_intx_masking:1; /* INTx masking can't be used */
-	unsigned int	io_window_1k:1;	/* Intel P2P bridge 1K I/O windows */
+	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
+	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	has_secondary_link:1;
-	unsigned int	non_compliant_bars:1;	/* broken BARs; ignore them */
-	unsigned int	is_probed:1;		/* device probing in progress */
+	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
+	unsigned int	is_probed:1;		/* Device probing in progress */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-	u32		saved_config_space[16]; /* config space saved at suspend time */
+	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
-	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
-	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
+	struct bin_attribute *rom_attr;		/* Attribute descriptor for sysfs ROM entry */
+	int		rom_attr_enabled;	/* Display of ROM attribute enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
 
@@ -419,12 +414,12 @@ struct pci_dev {
 	struct pci_vpd *vpd;
 #ifdef CONFIG_PCI_ATS
 	union {
-		struct pci_sriov *sriov;	/* SR-IOV capability related */
-		struct pci_dev *physfn;	/* the PF this VF is associated with */
+		struct pci_sriov	*sriov;		/* PF: SR-IOV info */
+		struct pci_dev		*physfn;	/* VF: related PF */
 	};
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
-	atomic_t	ats_ref_cnt;	/* number of VFs with ATS enabled */
+	atomic_t	ats_ref_cnt;	/* Number of VFs with ATS enabled */
 #endif
 #ifdef CONFIG_PCI_PRI
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
@@ -432,11 +427,11 @@ struct pci_dev {
 #ifdef CONFIG_PCI_PASID
 	u16		pasid_features;
 #endif
-	phys_addr_t rom; /* Physical address of ROM if it's not from the BAR */
-	size_t romlen; /* Length of ROM if it's not from the BAR */
-	char *driver_override; /* Driver name to force a match */
+	phys_addr_t	rom;		/* Physical address if not from BAR */
+	size_t		romlen;		/* Length if not from BAR */
+	char		*driver_override; /* Driver name to force a match */
 
-	unsigned long priv_flags; /* Private flags for the pci driver */
+	unsigned long	priv_flags;	/* Private flags for the PCI driver */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -459,26 +454,26 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 }
 
 struct pci_host_bridge {
-	struct device dev;
-	struct pci_bus *bus;		/* root bus */
-	struct pci_ops *ops;
-	void *sysdata;
-	int busnr;
+	struct device	dev;
+	struct pci_bus	*bus;		/* Root bus */
+	struct pci_ops	*ops;
+	void		*sysdata;
+	int		busnr;
 	struct list_head windows;	/* resource_entry */
-	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* platform IRQ swizzler */
+	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-	void *release_data;
+	void		*release_data;
 	struct msi_controller *msi;
-	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
-	unsigned int no_ext_tags:1;		/* no Extended Tags */
+	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
+	unsigned int	no_ext_tags:1;		/* No Extended Tags */
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
 			resource_size_t start,
 			resource_size_t size,
 			resource_size_t align);
-	unsigned long private[0] ____cacheline_aligned;
+	unsigned long	private[0] ____cacheline_aligned;
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
@@ -500,8 +495,8 @@ void pci_free_host_bridge(struct pci_host_bridge *bridge);
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
-		     void (*release_fn)(struct pci_host_bridge *),
-		     void *release_data);
+				 void (*release_fn)(struct pci_host_bridge *),
+				 void *release_data);
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
 
@@ -521,32 +516,32 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
 #define PCI_SUBTRACTIVE_DECODE	0x1
 
 struct pci_bus_resource {
-	struct list_head list;
-	struct resource *res;
-	unsigned int flags;
+	struct list_head	list;
+	struct resource		*res;
+	unsigned int		flags;
 };
 
 #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
 
 struct pci_bus {
-	struct list_head node;		/* node in list of buses */
-	struct pci_bus	*parent;	/* parent bus this bridge is on */
-	struct list_head children;	/* list of child buses */
-	struct list_head devices;	/* list of devices on this bus */
-	struct pci_dev	*self;		/* bridge device as seen by parent */
-	struct list_head slots;		/* list of slots on this bus;
+	struct list_head node;		/* Node in list of buses */
+	struct pci_bus	*parent;	/* Parent bus this bridge is on */
+	struct list_head children;	/* List of child buses */
+	struct list_head devices;	/* List of devices on this bus */
+	struct pci_dev	*self;		/* Bridge device as seen by parent */
+	struct list_head slots;		/* List of slots on this bus;
 					   protected by pci_slot_mutex */
 	struct resource *resource[PCI_BRIDGE_RESOURCE_NUM];
-	struct list_head resources;	/* address space routed to this bus */
-	struct resource busn_res;	/* bus numbers routed to this bus */
+	struct list_head resources;	/* Address space routed to this bus */
+	struct resource busn_res;	/* Bus numbers routed to this bus */
 
-	struct pci_ops	*ops;		/* configuration access functions */
+	struct pci_ops	*ops;		/* Configuration access functions */
 	struct msi_controller *msi;	/* MSI controller */
-	void		*sysdata;	/* hook for sys-specific extension */
-	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/pci */
+	void		*sysdata;	/* Hook for sys-specific extension */
+	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
 
-	unsigned char	number;		/* bus number */
-	unsigned char	primary;	/* number of primary bridge */
+	unsigned char	number;		/* Bus number */
+	unsigned char	primary;	/* Number of primary bridge */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
@@ -555,12 +550,12 @@ struct pci_bus {
 
 	char		name[48];
 
-	unsigned short  bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
-	pci_bus_flags_t bus_flags;	/* inherited by child buses */
+	unsigned short	bridge_ctl;	/* Manage NO_ISA/FBB/et al behaviors */
+	pci_bus_flags_t bus_flags;	/* Inherited by child buses */
 	struct device		*bridge;
 	struct device		dev;
-	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */
-	struct bin_attribute	*legacy_mem; /* legacy mem */
+	struct bin_attribute	*legacy_io;	/* Legacy I/O for this bus */
+	struct bin_attribute	*legacy_mem;	/* Legacy mem */
 	unsigned int		is_added:1;
 };
 
@@ -617,9 +612,7 @@ static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
 static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev) { return false; }
 #endif
 
-/*
- * Error values that may be returned by PCI functions.
- */
+/* Error values that may be returned by PCI functions */
 #define PCIBIOS_SUCCESSFUL		0x00
 #define PCIBIOS_FUNC_NOT_SUPPORTED	0x81
 #define PCIBIOS_BAD_VENDOR_ID		0x83
@@ -628,9 +621,7 @@ static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev) { return false;
 #define PCIBIOS_SET_FAILED		0x88
 #define PCIBIOS_BUFFER_TOO_SMALL	0x89
 
-/*
- * Translate above to generic errno for passing back through non-PCI code.
- */
+/* Translate above to generic errno for passing back through non-PCI code */
 static inline int pcibios_err_to_errno(int err)
 {
 	if (err <= PCIBIOS_SUCCESSFUL)
@@ -680,13 +671,13 @@ typedef u32 pci_bus_addr_t;
 #endif
 
 struct pci_bus_region {
-	pci_bus_addr_t start;
-	pci_bus_addr_t end;
+	pci_bus_addr_t	start;
+	pci_bus_addr_t	end;
 };
 
 struct pci_dynids {
-	spinlock_t lock;            /* protects list, index */
-	struct list_head list;      /* for IDs added at runtime */
+	spinlock_t		lock;	/* Protects list, index */
+	struct list_head	list;	/* For IDs added at runtime */
 };
 
 
@@ -700,13 +691,13 @@ struct pci_dynids {
 typedef unsigned int __bitwise pci_ers_result_t;
 
 enum pci_ers_result {
-	/* no result/none/not supported in device driver */
+	/* No result/none/not supported in device driver */
 	PCI_ERS_RESULT_NONE = (__force pci_ers_result_t) 1,
 
 	/* Device driver can recover without slot reset */
 	PCI_ERS_RESULT_CAN_RECOVER = (__force pci_ers_result_t) 2,
 
-	/* Device driver wants slot to be reset. */
+	/* Device driver wants slot to be reset */
 	PCI_ERS_RESULT_NEED_RESET = (__force pci_ers_result_t) 3,
 
 	/* Device has completely failed, is unrecoverable */
@@ -742,27 +733,27 @@ struct pci_error_handlers {
 
 struct module;
 struct pci_driver {
-	struct list_head node;
-	const char *name;
-	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
-	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
-	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device suspended */
-	int  (*suspend_late) (struct pci_dev *dev, pm_message_t state);
-	int  (*resume_early) (struct pci_dev *dev);
-	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
+	struct list_head	node;
+	const char		*name;
+	const struct pci_device_id *id_table;	/* Must be non-NULL for probe to be called */
+	int  (*probe)(struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
+	void (*remove)(struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
+	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
+	int  (*suspend_late)(struct pci_dev *dev, pm_message_t state);
+	int  (*resume_early)(struct pci_dev *dev);
+	int  (*resume) (struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown) (struct pci_dev *dev);
-	int (*sriov_configure) (struct pci_dev *dev, int num_vfs); /* PF pdev */
+	int  (*sriov_configure) (struct pci_dev *dev, int num_vfs); /* On PF */
 	const struct pci_error_handlers *err_handler;
 	const struct attribute_group **groups;
 	struct device_driver	driver;
-	struct pci_dynids dynids;
+	struct pci_dynids	dynids;
 };
 
 #define	to_pci_driver(drv) container_of(drv, struct pci_driver, driver)
 
 /**
- * PCI_DEVICE - macro used to describe a specific pci device
+ * PCI_DEVICE - macro used to describe a specific PCI device
  * @vend: the 16 bit PCI Vendor ID
  * @dev: the 16 bit PCI Device ID
  *
@@ -775,7 +766,7 @@ struct pci_driver {
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
 /**
- * PCI_DEVICE_SUB - macro used to describe a specific pci device with subsystem
+ * PCI_DEVICE_SUB - macro used to describe a specific PCI device with subsystem
  * @vend: the 16 bit PCI Vendor ID
  * @dev: the 16 bit PCI Device ID
  * @subvend: the 16 bit PCI Subvendor ID
@@ -789,7 +780,7 @@ struct pci_driver {
 	.subvendor = (subvend), .subdevice = (subdev)
 
 /**
- * PCI_DEVICE_CLASS - macro used to describe a specific pci device class
+ * PCI_DEVICE_CLASS - macro used to describe a specific PCI device class
  * @dev_class: the class, subclass, prog-if triple for this device
  * @dev_class_mask: the class mask for this device
  *
@@ -803,7 +794,7 @@ struct pci_driver {
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
 /**
- * PCI_VDEVICE - macro used to describe a specific pci device in short form
+ * PCI_VDEVICE - macro used to describe a specific PCI device in short form
  * @vend: the vendor name
  * @dev: the 16 bit PCI Device ID
  *
@@ -812,22 +803,21 @@ struct pci_driver {
  * to PCI_ANY_ID. The macro allows the next field to follow as the device
  * private data.
  */
-
 #define PCI_VDEVICE(vend, dev) \
 	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0
 
 enum {
-	PCI_REASSIGN_ALL_RSRC	= 0x00000001,	/* ignore firmware setup */
-	PCI_REASSIGN_ALL_BUS	= 0x00000002,	/* reassign all bus numbers */
-	PCI_PROBE_ONLY		= 0x00000004,	/* use existing setup */
-	PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,	/* don't do ISA alignment */
-	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,	/* enable domains in /proc */
+	PCI_REASSIGN_ALL_RSRC	= 0x00000001,	/* Ignore firmware setup */
+	PCI_REASSIGN_ALL_BUS	= 0x00000002,	/* Reassign all bus numbers */
+	PCI_PROBE_ONLY		= 0x00000004,	/* Use existing setup */
+	PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,	/* Don't do ISA alignment */
+	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,	/* Enable domains in /proc */
 	PCI_COMPAT_DOMAIN_0	= 0x00000020,	/* ... except domain 0 */
-	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* scan all, not just dev 0 */
+	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
 };
 
-/* these external functions are only available when PCI support is enabled */
+/* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
 extern unsigned int pci_flags;
@@ -840,11 +830,11 @@ static inline int pci_has_flag(int flag) { return pci_flags & flag; }
 void pcie_bus_configure_settings(struct pci_bus *bus);
 
 enum pcie_bus_config_types {
-	PCIE_BUS_TUNE_OFF,	/* don't touch MPS at all */
-	PCIE_BUS_DEFAULT,	/* ensure MPS matches upstream bridge */
-	PCIE_BUS_SAFE,		/* use largest MPS boot-time devices support */
-	PCIE_BUS_PERFORMANCE,	/* use MPS and MRRS for best performance */
-	PCIE_BUS_PEER2PEER,	/* set MPS = 128 for all devices */
+	PCIE_BUS_TUNE_OFF,	/* Don't touch MPS at all */
+	PCIE_BUS_DEFAULT,	/* Ensure MPS matches upstream bridge */
+	PCIE_BUS_SAFE,		/* Use largest MPS boot-time devices support */
+	PCIE_BUS_PERFORMANCE,	/* Use MPS and MRRS for best performance */
+	PCIE_BUS_PEER2PEER,	/* Set MPS = 128 for all devices */
 };
 
 extern enum pcie_bus_config_types pcie_bus_config;
@@ -853,7 +843,7 @@ extern struct bus_type pci_bus_type;
 
 /* Do NOT directly access these two variables, unless you are arch-specific PCI
  * code, or PCI core code. */
-extern struct list_head pci_root_buses;	/* list of all known PCI buses */
+extern struct list_head pci_root_buses;	/* List of all known PCI buses */
 /* Some device drivers need know if PCI is initiated */
 int no_pci_devices(void);
 
@@ -891,8 +881,8 @@ int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
 struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-					     struct pci_ops *ops, void *sysdata,
-					     struct list_head *resources);
+				  struct pci_ops *ops, void *sysdata,
+				  struct list_head *resources);
 int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
@@ -949,10 +939,10 @@ int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
-				struct pci_dev *from);
+			       struct pci_dev *from);
 struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
-				unsigned int ss_vendor, unsigned int ss_device,
-				struct pci_dev *from);
+			       unsigned int ss_vendor, unsigned int ss_device,
+			       struct pci_dev *from);
 struct pci_dev *pci_get_slot(struct pci_bus *bus, unsigned int devfn);
 struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
 					    unsigned int devfn);
@@ -1028,7 +1018,7 @@ static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
 	return pcie_capability_clear_and_set_dword(dev, pos, clear, 0);
 }
 
-/* user-space driven config access */
+/* User-space driven config access */
 int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
 int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
 int pci_user_read_config_dword(struct pci_dev *dev, int where, u32 *val);
@@ -1170,7 +1160,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus);
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);
 
-/* Vital product data routines */
+/* Vital Product Data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
 int pci_set_vpd_size(struct pci_dev *dev, size_t len);
@@ -1255,9 +1245,7 @@ static inline pci_bus_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
 int __must_check __pci_register_driver(struct pci_driver *, struct module *,
 				       const char *mod_name);
 
-/*
- * pci_register_driver must be a macro so that KBUILD_MODNAME can be expanded
- */
+/* pci_register_driver() must be a macro so KBUILD_MODNAME can be expanded */
 #define pci_register_driver(driver)		\
 	__pci_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
 
@@ -1272,8 +1260,7 @@ void pci_unregister_driver(struct pci_driver *dev);
  * use this macro once, and calling it replaces module_init() and module_exit()
  */
 #define module_pci_driver(__pci_driver) \
-	module_driver(__pci_driver, pci_register_driver, \
-		       pci_unregister_driver)
+	module_driver(__pci_driver, pci_register_driver, pci_unregister_driver)
 
 /**
  * builtin_pci_driver() - Helper macro for registering a PCI driver
@@ -1312,10 +1299,10 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
 
-#define PCI_IRQ_LEGACY		(1 << 0) /* allow legacy interrupts */
-#define PCI_IRQ_MSI		(1 << 1) /* allow MSI interrupts */
-#define PCI_IRQ_MSIX		(1 << 2) /* allow MSI-X interrupts */
-#define PCI_IRQ_AFFINITY	(1 << 3) /* auto-assign affinity */
+#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
+#define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
+#define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
+#define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
 #define PCI_IRQ_ALL_TYPES \
 	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
 
@@ -1334,8 +1321,8 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 #define	pci_pool_free(pool, vaddr, addr) dma_pool_free(pool, vaddr, addr)
 
 struct msix_entry {
-	u32	vector;	/* kernel uses to write allocated vector */
-	u16	entry;	/* driver uses to specify entry, OS writes */
+	u32	vector;	/* Kernel uses to write allocated vector */
+	u16	entry;	/* Driver uses to specify entry, OS writes */
 };
 
 #ifdef CONFIG_PCI_MSI
@@ -1375,10 +1362,10 @@ static inline int pci_msi_enabled(void) { return 0; }
 static inline int pci_enable_msi(struct pci_dev *dev)
 { return -ENOSYS; }
 static inline int pci_enable_msix_range(struct pci_dev *dev,
-		      struct msix_entry *entries, int minvec, int maxvec)
+			struct msix_entry *entries, int minvec, int maxvec)
 { return -ENOSYS; }
 static inline int pci_enable_msix_exact(struct pci_dev *dev,
-		      struct msix_entry *entries, int nvec)
+			struct msix_entry *entries, int nvec)
 { return -ENOSYS; }
 
 static inline int
@@ -1543,9 +1530,9 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
 #endif
 
-/* some architectures require additional setup to direct VGA traffic */
+/* Some architectures require additional setup to direct VGA traffic */
 typedef int (*arch_set_vga_state_t)(struct pci_dev *pdev, bool decode,
-		      unsigned int command_bits, u32 flags);
+				    unsigned int command_bits, u32 flags);
 void pci_register_set_vga_state(arch_set_vga_state_t func);
 
 static inline int
@@ -1584,10 +1571,9 @@ static inline void pci_clear_flags(int flags) { }
 static inline int pci_has_flag(int flag) { return 0; }
 
 /*
- *  If the system does not have PCI, clearly these return errors.  Define
- *  these as simple inline functions to avoid hair in drivers.
+ * If the system does not have PCI, clearly these return errors.  Define
+ * these as simple inline functions to avoid hair in drivers.
  */
-
 #define _PCI_NOP(o, s, t) \
 	static inline int pci_##o##_config_##s(struct pci_dev *dev, \
 						int where, t val) \
@@ -1723,8 +1709,10 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
 #define pci_root_bus_fwnode(bus)	NULL
 #endif
 
-/* these helpers provide future and backwards compatibility
- * for accessing popular PCI BAR info */
+/*
+ * These helpers provide future and backwards compatibility
+ * for accessing popular PCI BAR info
+ */
 #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
 #define pci_resource_end(dev, bar)	((dev)->resource[(bar)].end)
 #define pci_resource_flags(dev, bar)	((dev)->resource[(bar)].flags)
@@ -1736,7 +1724,8 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
 	 (pci_resource_end((dev), (bar)) -		\
 	  pci_resource_start((dev), (bar)) + 1))
 
-/* Similar to the helpers above, these manipulate per-pci_dev
+/*
+ * Similar to the helpers above, these manipulate per-pci_dev
  * driver-specific data.  They are really just a wrapper around
  * the generic device structure functions of these calls.
  */
@@ -1750,16 +1739,14 @@ static inline void pci_set_drvdata(struct pci_dev *pdev, void *data)
 	dev_set_drvdata(&pdev->dev, data);
 }
 
-/* If you want to know what to call your pci_dev, ask this function.
- * Again, it's a wrapper around the generic device.
- */
 static inline const char *pci_name(const struct pci_dev *pdev)
 {
 	return dev_name(&pdev->dev);
 }
 
 
-/* Some archs don't want to expose struct resource to userland as-is
+/*
+ * Some archs don't want to expose struct resource to userland as-is
  * in sysfs and /proc
  */
 #ifdef HAVE_ARCH_PCI_RESOURCE_TO_USER
@@ -1778,16 +1765,16 @@ static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
 
 
 /*
- *  The world is not perfect and supplies us with broken PCI devices.
- *  For at least a part of these bugs we need a work-around, so both
- *  generic (drivers/pci/quirks.c) and per-architecture code can define
- *  fixup hooks to be called for particular buggy devices.
+ * The world is not perfect and supplies us with broken PCI devices.
+ * For at least a part of these bugs we need a work-around, so both
+ * generic (drivers/pci/quirks.c) and per-architecture code can define
+ * fixup hooks to be called for particular buggy devices.
  */
 
 struct pci_fixup {
-	u16 vendor;		/* You can use PCI_ANY_ID here of course */
-	u16 device;		/* You can use PCI_ANY_ID here of course */
-	u32 class;		/* You can use PCI_ANY_ID here too */
+	u16 vendor;			/* Or PCI_ANY_ID */
+	u16 device;			/* Or PCI_ANY_ID */
+	u32 class;			/* Or PCI_ANY_ID */
 	unsigned int class_shift;	/* should be 0, 8, 16 */
 	void (*hook)(struct pci_dev *dev);
 };
@@ -1829,23 +1816,19 @@ enum pci_fixup_pass {
 #define DECLARE_PCI_FIXUP_CLASS_RESUME(vendor, device, class,		\
 					 class_shift, hook)		\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume,			\
-		resume##hook, vendor, device, class,	\
-		class_shift, hook)
+		resume##hook, vendor, device, class, class_shift, hook)
 #define DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(vendor, device, class,	\
 					 class_shift, hook)		\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume_early,		\
-		resume_early##hook, vendor, device,	\
-		class, class_shift, hook)
+		resume_early##hook, vendor, device, class, class_shift, hook)
 #define DECLARE_PCI_FIXUP_CLASS_SUSPEND(vendor, device, class,		\
 					 class_shift, hook)		\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend,			\
-		suspend##hook, vendor, device, class,	\
-		class_shift, hook)
+		suspend##hook, vendor, device, class, class_shift, hook)
 #define DECLARE_PCI_FIXUP_CLASS_SUSPEND_LATE(vendor, device, class,	\
 					 class_shift, hook)		\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend_late,		\
-		suspend_late##hook, vendor, device,	\
-		class, class_shift, hook)
+		suspend_late##hook, vendor, device, class, class_shift, hook)
 
 #define DECLARE_PCI_FIXUP_EARLY(vendor, device, hook)			\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_early,			\
@@ -1861,20 +1844,16 @@ enum pci_fixup_pass {
 		hook, vendor, device, PCI_ANY_ID, 0, hook)
 #define DECLARE_PCI_FIXUP_RESUME(vendor, device, hook)			\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume,			\
-		resume##hook, vendor, device,		\
-		PCI_ANY_ID, 0, hook)
+		resume##hook, vendor, device, PCI_ANY_ID, 0, hook)
 #define DECLARE_PCI_FIXUP_RESUME_EARLY(vendor, device, hook)		\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume_early,		\
-		resume_early##hook, vendor, device,	\
-		PCI_ANY_ID, 0, hook)
+		resume_early##hook, vendor, device, PCI_ANY_ID, 0, hook)
 #define DECLARE_PCI_FIXUP_SUSPEND(vendor, device, hook)			\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend,			\
-		suspend##hook, vendor, device,		\
-		PCI_ANY_ID, 0, hook)
+		suspend##hook, vendor, device, PCI_ANY_ID, 0, hook)
 #define DECLARE_PCI_FIXUP_SUSPEND_LATE(vendor, device, hook)		\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend_late,		\
-		suspend_late##hook, vendor, device,	\
-		PCI_ANY_ID, 0, hook)
+		suspend_late##hook, vendor, device, PCI_ANY_ID, 0, hook)
 
 #ifdef CONFIG_PCI_QUIRKS
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
@@ -2109,7 +2088,7 @@ static inline u16 pci_vpd_lrdt_size(const u8 *lrdt)
  */
 static inline u16 pci_vpd_lrdt_tag(const u8 *lrdt)
 {
-    return (u16)(lrdt[0] & PCI_VPD_LRDT_TIN_MASK);
+	return (u16)(lrdt[0] & PCI_VPD_LRDT_TIN_MASK);
 }
 
 /**
@@ -2194,7 +2173,7 @@ static inline struct device_node *pci_bus_to_OF_node(struct pci_bus *bus)
 	return bus ? bus->dev.of_node : NULL;
 }
 
-#else /* CONFIG_OF */
+#else	/* CONFIG_OF */
 static inline void pci_set_of_node(struct pci_dev *dev) { }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
@@ -2203,7 +2182,7 @@ static inline struct device_node *
 pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
 static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
-#endif  /* CONFIG_OF */
+#endif	/* CONFIG_OF */
 
 #ifdef CONFIG_ACPI
 struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
@@ -2228,7 +2207,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 			   int (*fn)(struct pci_dev *pdev,
 				     u16 alias, void *data), void *data);
 
-/* helper functions for operation of device flag */
+/* Helper functions for operation of device flag */
 static inline void pci_set_dev_assigned(struct pci_dev *pdev)
 {
 	pdev->dev_flags |= PCI_DEV_FLAGS_ASSIGNED;
@@ -2275,7 +2254,7 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 	return false;
 }
 
-/* provide the legacy pci_dma_* API */
+/* Provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
 
 #endif /* LINUX_PCI_H */
