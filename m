Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:40649 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab3DLUs3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2013 16:48:29 -0400
Received: by mail-ie0-f176.google.com with SMTP id x12so3846479ief.21
        for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2013 13:48:28 -0700 (PDT)
Subject: [PATCH 6/6] PCI: Remove "extern" from function declarations
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 12 Apr 2013 14:48:21 -0600
Message-ID: <20130412204821.5237.84225.stgit@bhelgaas-glaptop>
In-Reply-To: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
References: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We had an inconsistent mix of using and omitting the "extern" keyword
on function declarations in header files.  This removes them all.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpiphp.h          |   26 ++++-----
 drivers/pci/hotplug/cpci_hotplug.h     |   36 ++++++------
 drivers/pci/hotplug/cpqphp.h           |   70 +++++++++++-------------
 drivers/pci/hotplug/cpqphp_nvram.h     |   12 ++--
 drivers/pci/hotplug/ibmphp.h           |   68 +++++++++++------------
 drivers/pci/hotplug/pci_hotplug_core.c |    4 +
 drivers/pci/hotplug/pciehp.h           |   22 ++++---
 drivers/pci/hotplug/rpadlpar.h         |    8 +--
 drivers/pci/hotplug/rpaphp.h           |   16 +++--
 drivers/pci/hotplug/shpchp.h           |   26 ++++-----
 drivers/pci/pci.h                      |   89 ++++++++++++++----------------
 drivers/pci/pcie/aer/aerdrv.h          |   14 ++---
 drivers/pci/pcie/portdrv.h             |   18 +++---
 include/linux/pci-aspm.h               |   20 +++----
 include/linux/pci-ats.h                |   26 ++++-----
 include/linux/pci.h                    |   95 ++++++++++++++++----------------
 include/linux/pci_hotplug.h            |   12 ++--
 include/linux/pcieport_if.h            |    4 +
 18 files changed, 278 insertions(+), 288 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index b70ac00..9daddf4 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -174,23 +174,23 @@ struct acpiphp_attention_info
 /* function prototypes */
 
 /* acpiphp_core.c */
-extern int acpiphp_register_attention(struct acpiphp_attention_info*info);
-extern int acpiphp_unregister_attention(struct acpiphp_attention_info *info);
-extern int acpiphp_register_hotplug_slot(struct acpiphp_slot *slot);
-extern void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *slot);
+int acpiphp_register_attention(struct acpiphp_attention_info*info);
+int acpiphp_unregister_attention(struct acpiphp_attention_info *info);
+int acpiphp_register_hotplug_slot(struct acpiphp_slot *slot);
+void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *slot);
 
 /* acpiphp_glue.c */
-extern int acpiphp_glue_init (void);
-extern void acpiphp_glue_exit (void);
+int acpiphp_glue_init(void);
+void acpiphp_glue_exit(void);
 typedef int (*acpiphp_callback)(struct acpiphp_slot *slot, void *data);
 
-extern int acpiphp_enable_slot (struct acpiphp_slot *slot);
-extern int acpiphp_disable_slot (struct acpiphp_slot *slot);
-extern int acpiphp_eject_slot (struct acpiphp_slot *slot);
-extern u8 acpiphp_get_power_status (struct acpiphp_slot *slot);
-extern u8 acpiphp_get_attention_status (struct acpiphp_slot *slot);
-extern u8 acpiphp_get_latch_status (struct acpiphp_slot *slot);
-extern u8 acpiphp_get_adapter_status (struct acpiphp_slot *slot);
+int acpiphp_enable_slot(struct acpiphp_slot *slot);
+int acpiphp_disable_slot(struct acpiphp_slot *slot);
+int acpiphp_eject_slot(struct acpiphp_slot *slot);
+u8 acpiphp_get_power_status(struct acpiphp_slot *slot);
+u8 acpiphp_get_attention_status(struct acpiphp_slot *slot);
+u8 acpiphp_get_latch_status(struct acpiphp_slot *slot);
+u8 acpiphp_get_adapter_status(struct acpiphp_slot *slot);
 
 /* variables */
 extern bool acpiphp_debug;
diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
index 9fff878..e131bfc 100644
--- a/drivers/pci/hotplug/cpci_hotplug.h
+++ b/drivers/pci/hotplug/cpci_hotplug.h
@@ -75,28 +75,28 @@ static inline const char *slot_name(struct slot *slot)
 	return hotplug_slot_name(slot->hotplug_slot);
 }
 
-extern int cpci_hp_register_controller(struct cpci_hp_controller *controller);
-extern int cpci_hp_unregister_controller(struct cpci_hp_controller *controller);
-extern int cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last);
-extern int cpci_hp_unregister_bus(struct pci_bus *bus);
-extern int cpci_hp_start(void);
-extern int cpci_hp_stop(void);
+int cpci_hp_register_controller(struct cpci_hp_controller *controller);
+int cpci_hp_unregister_controller(struct cpci_hp_controller *controller);
+int cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last);
+int cpci_hp_unregister_bus(struct pci_bus *bus);
+int cpci_hp_start(void);
+int cpci_hp_stop(void);
 
 /*
  * Internal function prototypes, these functions should not be used by
  * board/chassis drivers.
  */
-extern u8 cpci_get_attention_status(struct slot *slot);
-extern u8 cpci_get_latch_status(struct slot *slot);
-extern u8 cpci_get_adapter_status(struct slot *slot);
-extern u16 cpci_get_hs_csr(struct slot * slot);
-extern int cpci_set_attention_status(struct slot *slot, int status);
-extern int cpci_check_and_clear_ins(struct slot * slot);
-extern int cpci_check_ext(struct slot * slot);
-extern int cpci_clear_ext(struct slot * slot);
-extern int cpci_led_on(struct slot * slot);
-extern int cpci_led_off(struct slot * slot);
-extern int cpci_configure_slot(struct slot *slot);
-extern int cpci_unconfigure_slot(struct slot *slot);
+u8 cpci_get_attention_status(struct slot *slot);
+u8 cpci_get_latch_status(struct slot *slot);
+u8 cpci_get_adapter_status(struct slot *slot);
+u16 cpci_get_hs_csr(struct slot * slot);
+int cpci_set_attention_status(struct slot *slot, int status);
+int cpci_check_and_clear_ins(struct slot * slot);
+int cpci_check_ext(struct slot * slot);
+int cpci_clear_ext(struct slot * slot);
+int cpci_led_on(struct slot * slot);
+int cpci_led_off(struct slot * slot);
+int cpci_configure_slot(struct slot *slot);
+int cpci_unconfigure_slot(struct slot *slot);
 
 #endif	/* _CPCI_HOTPLUG_H */
diff --git a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
index d8ffc73..516b877 100644
--- a/drivers/pci/hotplug/cpqphp.h
+++ b/drivers/pci/hotplug/cpqphp.h
@@ -404,50 +404,44 @@ struct resource_lists {
 
 
 /* debugfs functions for the hotplug controller info */
-extern void cpqhp_initialize_debugfs(void);
-extern void cpqhp_shutdown_debugfs(void);
-extern void cpqhp_create_debugfs_files(struct controller *ctrl);
-extern void cpqhp_remove_debugfs_files(struct controller *ctrl);
+void cpqhp_initialize_debugfs(void);
+void cpqhp_shutdown_debugfs(void);
+void cpqhp_create_debugfs_files(struct controller *ctrl);
+void cpqhp_remove_debugfs_files(struct controller *ctrl);
 
 /* controller functions */
-extern void cpqhp_pushbutton_thread(unsigned long event_pointer);
-extern irqreturn_t cpqhp_ctrl_intr(int IRQ, void *data);
-extern int cpqhp_find_available_resources(struct controller *ctrl,
-					  void __iomem *rom_start);
-extern int cpqhp_event_start_thread(void);
-extern void cpqhp_event_stop_thread(void);
-extern struct pci_func *cpqhp_slot_create(unsigned char busnumber);
-extern struct pci_func *cpqhp_slot_find(unsigned char bus, unsigned char device,
-					unsigned char index);
-extern int cpqhp_process_SI(struct controller *ctrl, struct pci_func *func);
-extern int cpqhp_process_SS(struct controller *ctrl, struct pci_func *func);
-extern int cpqhp_hardware_test(struct controller *ctrl, int test_num);
+void cpqhp_pushbutton_thread(unsigned long event_pointer);
+irqreturn_t cpqhp_ctrl_intr(int IRQ, void *data);
+int cpqhp_find_available_resources(struct controller *ctrl,
+				   void __iomem *rom_start);
+int cpqhp_event_start_thread(void);
+void cpqhp_event_stop_thread(void);
+struct pci_func *cpqhp_slot_create(unsigned char busnumber);
+struct pci_func *cpqhp_slot_find(unsigned char bus, unsigned char device,
+				 unsigned char index);
+int cpqhp_process_SI(struct controller *ctrl, struct pci_func *func);
+int cpqhp_process_SS(struct controller *ctrl, struct pci_func *func);
+int cpqhp_hardware_test(struct controller *ctrl, int test_num);
 
 /* resource functions */
-extern int	cpqhp_resource_sort_and_combine	(struct pci_resource **head);
+int	cpqhp_resource_sort_and_combine	(struct pci_resource **head);
 
 /* pci functions */
-extern int cpqhp_set_irq(u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num);
-extern int cpqhp_get_bus_dev(struct controller *ctrl, u8 *bus_num, u8 *dev_num,
-			     u8 slot);
-extern int cpqhp_save_config(struct controller *ctrl, int busnumber,
-			     int is_hot_plug);
-extern int cpqhp_save_base_addr_length(struct controller *ctrl,
-				       struct pci_func *func);
-extern int cpqhp_save_used_resources(struct controller *ctrl,
-				     struct pci_func *func);
-extern int cpqhp_configure_board(struct controller *ctrl,
-				 struct pci_func *func);
-extern int cpqhp_save_slot_config(struct controller *ctrl,
-				  struct pci_func *new_slot);
-extern int cpqhp_valid_replace(struct controller *ctrl, struct pci_func *func);
-extern void cpqhp_destroy_board_resources(struct pci_func *func);
-extern int cpqhp_return_board_resources	(struct pci_func *func,
-					 struct resource_lists *resources);
-extern void cpqhp_destroy_resource_list(struct resource_lists *resources);
-extern int cpqhp_configure_device(struct controller *ctrl,
-				  struct pci_func *func);
-extern int cpqhp_unconfigure_device(struct pci_func *func);
+int cpqhp_set_irq(u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num);
+int cpqhp_get_bus_dev(struct controller *ctrl, u8 *bus_num, u8 *dev_num,
+		      u8 slot);
+int cpqhp_save_config(struct controller *ctrl, int busnumber, int is_hot_plug);
+int cpqhp_save_base_addr_length(struct controller *ctrl, struct pci_func *func);
+int cpqhp_save_used_resources(struct controller *ctrl, struct pci_func *func);
+int cpqhp_configure_board(struct controller *ctrl, struct pci_func *func);
+int cpqhp_save_slot_config(struct controller *ctrl, struct pci_func *new_slot);
+int cpqhp_valid_replace(struct controller *ctrl, struct pci_func *func);
+void cpqhp_destroy_board_resources(struct pci_func *func);
+int cpqhp_return_board_resources(struct pci_func *func,
+				 struct resource_lists *resources);
+void cpqhp_destroy_resource_list(struct resource_lists *resources);
+int cpqhp_configure_device(struct controller *ctrl, struct pci_func *func);
+int cpqhp_unconfigure_device(struct pci_func *func);
 
 /* Global variables */
 extern int cpqhp_debug;
diff --git a/drivers/pci/hotplug/cpqphp_nvram.h b/drivers/pci/hotplug/cpqphp_nvram.h
index e89c070..34e4e54 100644
--- a/drivers/pci/hotplug/cpqphp_nvram.h
+++ b/drivers/pci/hotplug/cpqphp_nvram.h
@@ -30,26 +30,26 @@
 
 #ifndef CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM
 
-static inline void compaq_nvram_init (void __iomem *rom_start)
+static inline void compaq_nvram_init(void __iomem *rom_start)
 {
 	return;
 }
 
-static inline int compaq_nvram_load (void __iomem *rom_start, struct controller *ctrl)
+static inline int compaq_nvram_load(void __iomem *rom_start, struct controller *ctrl)
 {
 	return 0;
 }
 
-static inline int compaq_nvram_store (void __iomem *rom_start)
+static inline int compaq_nvram_store(void __iomem *rom_start)
 {
 	return 0;
 }
 
 #else
 
-extern void compaq_nvram_init	(void __iomem *rom_start);
-extern int compaq_nvram_load	(void __iomem *rom_start, struct controller *ctrl);
-extern int compaq_nvram_store	(void __iomem *rom_start);
+void compaq_nvram_init(void __iomem *rom_start);
+int compaq_nvram_load(void __iomem *rom_start, struct controller *ctrl);
+int compaq_nvram_store(void __iomem *rom_start);
 
 #endif
 
diff --git a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
index a8d391a..c7d4aa1 100644
--- a/drivers/pci/hotplug/ibmphp.h
+++ b/drivers/pci/hotplug/ibmphp.h
@@ -275,17 +275,17 @@ extern struct list_head ibmphp_slot_head;
 * FUNCTION PROTOTYPES                                      *
 ***********************************************************/
 
-extern void ibmphp_free_ebda_hpc_queue (void);
-extern int ibmphp_access_ebda (void);
-extern struct slot *ibmphp_get_slot_from_physical_num (u8);
-extern int ibmphp_get_total_hp_slots (void);
-extern void ibmphp_free_ibm_slot (struct slot *);
-extern void ibmphp_free_bus_info_queue (void);
-extern void ibmphp_free_ebda_pci_rsrc_queue (void);
-extern struct bus_info *ibmphp_find_same_bus_num (u32);
-extern int ibmphp_get_bus_index (u8);
-extern u16 ibmphp_get_total_controllers (void);
-extern int ibmphp_register_pci (void);
+void ibmphp_free_ebda_hpc_queue(void);
+int ibmphp_access_ebda(void);
+struct slot *ibmphp_get_slot_from_physical_num(u8);
+int ibmphp_get_total_hp_slots(void);
+void ibmphp_free_ibm_slot(struct slot *);
+void ibmphp_free_bus_info_queue(void);
+void ibmphp_free_ebda_pci_rsrc_queue(void);
+struct bus_info *ibmphp_find_same_bus_num(u32);
+int ibmphp_get_bus_index(u8);
+u16 ibmphp_get_total_controllers(void);
+int ibmphp_register_pci(void);
 
 /* passed parameters */
 #define MEM		0
@@ -381,24 +381,24 @@ struct res_needed {
 
 /* functions */
 
-extern int ibmphp_rsrc_init (void);
-extern int ibmphp_add_resource (struct resource_node *);
-extern int ibmphp_remove_resource (struct resource_node *);
-extern int ibmphp_find_resource (struct bus_node *, u32, struct resource_node **, int);
-extern int ibmphp_check_resource (struct resource_node *, u8);
-extern int ibmphp_remove_bus (struct bus_node *, u8);
-extern void ibmphp_free_resources (void);
-extern int ibmphp_add_pfmem_from_mem (struct resource_node *);
-extern struct bus_node *ibmphp_find_res_bus (u8);
-extern void ibmphp_print_test (void);	/* for debugging purposes */
+int ibmphp_rsrc_init(void);
+int ibmphp_add_resource(struct resource_node *);
+int ibmphp_remove_resource(struct resource_node *);
+int ibmphp_find_resource(struct bus_node *, u32, struct resource_node **, int);
+int ibmphp_check_resource(struct resource_node *, u8);
+int ibmphp_remove_bus(struct bus_node *, u8);
+void ibmphp_free_resources(void);
+int ibmphp_add_pfmem_from_mem(struct resource_node *);
+struct bus_node *ibmphp_find_res_bus(u8);
+void ibmphp_print_test(void);	/* for debugging purposes */
 
-extern void ibmphp_hpc_initvars (void);
-extern int ibmphp_hpc_readslot (struct slot *, u8, u8 *);
-extern int ibmphp_hpc_writeslot (struct slot *, u8);
-extern void ibmphp_lock_operations (void);
-extern void ibmphp_unlock_operations (void);
-extern int ibmphp_hpc_start_poll_thread (void);
-extern void ibmphp_hpc_stop_poll_thread (void);
+void ibmphp_hpc_initvars(void);
+int ibmphp_hpc_readslot(struct slot *, u8, u8 *);
+int ibmphp_hpc_writeslot(struct slot *, u8);
+void ibmphp_lock_operations(void);
+void ibmphp_unlock_operations(void);
+int ibmphp_hpc_start_poll_thread(void);
+void ibmphp_hpc_stop_poll_thread(void);
 
 //----------------------------------------------------------------------------
 
@@ -749,12 +749,12 @@ struct controller {
 
 /* Functions */
 
-extern int ibmphp_init_devno (struct slot **);	/* This function is called from EBDA, so we need it not be static */
-extern int ibmphp_do_disable_slot (struct slot *slot_cur);
-extern int ibmphp_update_slot_info (struct slot *);	/* This function is called from HPC, so we need it to not be be static */
-extern int ibmphp_configure_card (struct pci_func *, u8);
-extern int ibmphp_unconfigure_card (struct slot **, int);
-extern struct hotplug_slot_ops ibmphp_hotplug_slot_ops;
+int ibmphp_init_devno(struct slot **);	/* This function is called from EBDA, so we need it not be static */
+int ibmphp_do_disable_slot(struct slot *slot_cur);
+int ibmphp_update_slot_info(struct slot *);	/* This function is called from HPC, so we need it to not be be static */
+int ibmphp_configure_card(struct pci_func *, u8);
+int ibmphp_unconfigure_card(struct slot **, int);
+struct hotplug_slot_ops ibmphp_hotplug_slot_ops;
 
 #endif				//__IBMPHP_H
 
diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index d0f9eda..2f02e7e 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -64,8 +64,8 @@ static LIST_HEAD(pci_hotplug_slot_list);
 static DEFINE_MUTEX(pci_hp_mutex);
 
 #ifdef CONFIG_HOTPLUG_PCI_CPCI
-extern int cpci_hotplug_init(int debug);
-extern void cpci_hotplug_exit(void);
+int cpci_hotplug_init(int debug);
+void cpci_hotplug_exit(void);
 #else
 static inline int cpci_hotplug_init(int debug) { return 0; }
 static inline void cpci_hotplug_exit(void) { }
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 2c113de..7fb3269 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -127,15 +127,15 @@ struct controller {
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		((ctrl)->slot_cap >> 19)
 
-extern int pciehp_sysfs_enable_slot(struct slot *slot);
-extern int pciehp_sysfs_disable_slot(struct slot *slot);
-extern u8 pciehp_handle_attention_button(struct slot *p_slot);
-extern u8 pciehp_handle_switch_change(struct slot *p_slot);
-extern u8 pciehp_handle_presence_change(struct slot *p_slot);
-extern u8 pciehp_handle_power_fault(struct slot *p_slot);
-extern int pciehp_configure_device(struct slot *p_slot);
-extern int pciehp_unconfigure_device(struct slot *p_slot);
-extern void pciehp_queue_pushbutton_work(struct work_struct *work);
+int pciehp_sysfs_enable_slot(struct slot *slot);
+int pciehp_sysfs_disable_slot(struct slot *slot);
+u8 pciehp_handle_attention_button(struct slot *p_slot);
+u8 pciehp_handle_switch_change(struct slot *p_slot);
+u8 pciehp_handle_presence_change(struct slot *p_slot);
+u8 pciehp_handle_power_fault(struct slot *p_slot);
+int pciehp_configure_device(struct slot *p_slot);
+int pciehp_unconfigure_device(struct slot *p_slot);
+void pciehp_queue_pushbutton_work(struct work_struct *work);
 struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
 int pciehp_enable_slot(struct slot *p_slot);
@@ -166,8 +166,8 @@ static inline const char *slot_name(struct slot *slot)
 #include <acpi/acpi_bus.h>
 #include <linux/pci-acpi.h>
 
-extern void __init pciehp_acpi_slot_detection_init(void);
-extern int pciehp_acpi_slot_detection_check(struct pci_dev *dev);
+void __init pciehp_acpi_slot_detection_init(void);
+int pciehp_acpi_slot_detection_check(struct pci_dev *dev);
 
 static inline void pciehp_firmware_init(void)
 {
diff --git a/drivers/pci/hotplug/rpadlpar.h b/drivers/pci/hotplug/rpadlpar.h
index 4a0a59b..81df939 100644
--- a/drivers/pci/hotplug/rpadlpar.h
+++ b/drivers/pci/hotplug/rpadlpar.h
@@ -15,10 +15,10 @@
 #ifndef _RPADLPAR_IO_H_
 #define _RPADLPAR_IO_H_
 
-extern int dlpar_sysfs_init(void);
-extern void dlpar_sysfs_exit(void);
+int dlpar_sysfs_init(void);
+void dlpar_sysfs_exit(void);
 
-extern int dlpar_add_slot(char *drc_name);
-extern int dlpar_remove_slot(char *drc_name);
+int dlpar_add_slot(char *drc_name);
+int dlpar_remove_slot(char *drc_name);
 
 #endif
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index df56774..3135856 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -86,18 +86,18 @@ extern struct list_head rpaphp_slot_head;
 /* function prototypes */
 
 /* rpaphp_pci.c */
-extern int rpaphp_enable_slot(struct slot *slot);
-extern int rpaphp_get_sensor_state(struct slot *slot, int *state);
+int rpaphp_enable_slot(struct slot *slot);
+int rpaphp_get_sensor_state(struct slot *slot, int *state);
 
 /* rpaphp_core.c */
-extern int rpaphp_add_slot(struct device_node *dn);
-extern int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
+int rpaphp_add_slot(struct device_node *dn);
+int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
 		char **drc_name, char **drc_type, int *drc_power_domain);
 
 /* rpaphp_slot.c */
-extern void dealloc_slot_struct(struct slot *slot);
-extern struct slot *alloc_slot_struct(struct device_node *dn, int drc_index, char *drc_name, int power_domain);
-extern int rpaphp_register_slot(struct slot *slot);
-extern int rpaphp_deregister_slot(struct slot *slot);
+void dealloc_slot_struct(struct slot *slot);
+struct slot *alloc_slot_struct(struct device_node *dn, int drc_index, char *drc_name, int power_domain);
+int rpaphp_register_slot(struct slot *slot);
+int rpaphp_deregister_slot(struct slot *slot);
 	
 #endif				/* _PPC64PHP_H */
diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index b849f995..e260f20 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -168,19 +168,19 @@ struct controller {
 #define WRONG_BUS_FREQUENCY		0x0000000D
 #define POWER_FAILURE			0x0000000E
 
-extern int __must_check shpchp_create_ctrl_files(struct controller *ctrl);
-extern void shpchp_remove_ctrl_files(struct controller *ctrl);
-extern int shpchp_sysfs_enable_slot(struct slot *slot);
-extern int shpchp_sysfs_disable_slot(struct slot *slot);
-extern u8 shpchp_handle_attention_button(u8 hp_slot, struct controller *ctrl);
-extern u8 shpchp_handle_switch_change(u8 hp_slot, struct controller *ctrl);
-extern u8 shpchp_handle_presence_change(u8 hp_slot, struct controller *ctrl);
-extern u8 shpchp_handle_power_fault(u8 hp_slot, struct controller *ctrl);
-extern int shpchp_configure_device(struct slot *p_slot);
-extern int shpchp_unconfigure_device(struct slot *p_slot);
-extern void cleanup_slots(struct controller *ctrl);
-extern void shpchp_queue_pushbutton_work(struct work_struct *work);
-extern int shpc_init( struct controller *ctrl, struct pci_dev *pdev);
+int __must_check shpchp_create_ctrl_files(struct controller *ctrl);
+void shpchp_remove_ctrl_files(struct controller *ctrl);
+int shpchp_sysfs_enable_slot(struct slot *slot);
+int shpchp_sysfs_disable_slot(struct slot *slot);
+u8 shpchp_handle_attention_button(u8 hp_slot, struct controller *ctrl);
+u8 shpchp_handle_switch_change(u8 hp_slot, struct controller *ctrl);
+u8 shpchp_handle_presence_change(u8 hp_slot, struct controller *ctrl);
+u8 shpchp_handle_power_fault(u8 hp_slot, struct controller *ctrl);
+int shpchp_configure_device(struct slot *p_slot);
+int shpchp_unconfigure_device(struct slot *p_slot);
+void cleanup_slots(struct controller *ctrl);
+void shpchp_queue_pushbutton_work(struct work_struct *work);
+int shpc_init( struct controller *ctrl, struct pci_dev *pdev);
 
 static inline const char *slot_name(struct slot *slot)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 91b9ce6..0f1b306 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -8,26 +8,25 @@
 
 /* Functions internal to the PCI core code */
 
-extern int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev);
-extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
+int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev);
+void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 #if !defined(CONFIG_DMI) && !defined(CONFIG_ACPI)
 static inline void pci_create_firmware_label_files(struct pci_dev *pdev)
 { return; }
 static inline void pci_remove_firmware_label_files(struct pci_dev *pdev)
 { return; }
 #else
-extern void pci_create_firmware_label_files(struct pci_dev *pdev);
-extern void pci_remove_firmware_label_files(struct pci_dev *pdev);
+void pci_create_firmware_label_files(struct pci_dev *pdev);
+void pci_remove_firmware_label_files(struct pci_dev *pdev);
 #endif
-extern void pci_cleanup_rom(struct pci_dev *dev);
+void pci_cleanup_rom(struct pci_dev *dev);
 #ifdef HAVE_PCI_MMAP
 enum pci_mmap_api {
 	PCI_MMAP_SYSFS,	/* mmap on /sys/bus/pci/devices/<BDF>/resource<N> */
 	PCI_MMAP_PROCFS	/* mmap on /proc/bus/pci/<BDF> */
 };
-extern int pci_mmap_fits(struct pci_dev *pdev, int resno,
-			 struct vm_area_struct *vmai,
-			 enum pci_mmap_api mmap_api);
+int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
+		  enum pci_mmap_api mmap_api);
 #endif
 int pci_probe_reset_function(struct pci_dev *dev);
 
@@ -60,17 +59,17 @@ struct pci_platform_pm_ops {
 	int (*run_wake)(struct pci_dev *dev, bool enable);
 };
 
-extern int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
-extern void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
-extern void pci_power_up(struct pci_dev *dev);
-extern void pci_disable_enabled_device(struct pci_dev *dev);
-extern int pci_finish_runtime_suspend(struct pci_dev *dev);
-extern int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
-extern void pci_wakeup_bus(struct pci_bus *bus);
-extern void pci_config_pm_runtime_get(struct pci_dev *dev);
-extern void pci_config_pm_runtime_put(struct pci_dev *dev);
-extern void pci_pm_init(struct pci_dev *dev);
-extern void pci_allocate_cap_save_buffers(struct pci_dev *dev);
+int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
+void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
+void pci_power_up(struct pci_dev *dev);
+void pci_disable_enabled_device(struct pci_dev *dev);
+int pci_finish_runtime_suspend(struct pci_dev *dev);
+int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
+void pci_wakeup_bus(struct pci_bus *bus);
+void pci_config_pm_runtime_get(struct pci_dev *dev);
+void pci_config_pm_runtime_put(struct pci_dev *dev);
+void pci_pm_init(struct pci_dev *dev);
+void pci_allocate_cap_save_buffers(struct pci_dev *dev);
 void pci_free_cap_save_buffers(struct pci_dev *dev);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
@@ -96,7 +95,7 @@ struct pci_vpd {
 	struct bin_attribute *attr; /* descriptor for sysfs VPD entry */
 };
 
-extern int pci_vpd_pci22_init(struct pci_dev *dev);
+int pci_vpd_pci22_init(struct pci_dev *dev);
 static inline void pci_vpd_release(struct pci_dev *dev)
 {
 	if (dev->vpd)
@@ -105,9 +104,9 @@ static inline void pci_vpd_release(struct pci_dev *dev)
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
-extern int pci_proc_attach_device(struct pci_dev *dev);
-extern int pci_proc_detach_device(struct pci_dev *dev);
-extern int pci_proc_detach_bus(struct pci_bus *bus);
+int pci_proc_attach_device(struct pci_dev *dev);
+int pci_proc_detach_device(struct pci_dev *dev);
+int pci_proc_detach_bus(struct pci_bus *bus);
 #else
 static inline int pci_proc_attach_device(struct pci_dev *dev) { return 0; }
 static inline int pci_proc_detach_device(struct pci_dev *dev) { return 0; }
@@ -118,8 +117,8 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 int pci_hp_add_bridge(struct pci_dev *dev);
 
 #ifdef HAVE_PCI_LEGACY
-extern void pci_create_legacy_files(struct pci_bus *bus);
-extern void pci_remove_legacy_files(struct pci_bus *bus);
+void pci_create_legacy_files(struct pci_bus *bus);
+void pci_remove_legacy_files(struct pci_bus *bus);
 #else
 static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
 static inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
@@ -134,7 +133,7 @@ extern unsigned int pci_pm_d3_delay;
 
 #ifdef CONFIG_PCI_MSI
 void pci_no_msi(void);
-extern void pci_msi_init_pci_dev(struct pci_dev *dev);
+void pci_msi_init_pci_dev(struct pci_dev *dev);
 #else
 static inline void pci_no_msi(void) { }
 static inline void pci_msi_init_pci_dev(struct pci_dev *dev) { }
@@ -198,12 +197,11 @@ enum pci_bar_type {
 
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
-extern int pci_setup_device(struct pci_dev *dev);
-extern int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
-				struct resource *res, unsigned int reg);
-extern int pci_resource_bar(struct pci_dev *dev, int resno,
-			    enum pci_bar_type *type);
-extern void pci_configure_ari(struct pci_dev *dev);
+int pci_setup_device(struct pci_dev *dev);
+int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
+		    struct resource *res, unsigned int reg);
+int pci_resource_bar(struct pci_dev *dev, int resno, enum pci_bar_type *type);
+void pci_configure_ari(struct pci_dev *dev);
 
 /**
  * pci_ari_enabled - query ARI forwarding status
@@ -217,7 +215,7 @@ static inline int pci_ari_enabled(struct pci_bus *bus)
 }
 
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
-extern void pci_disable_bridge_window(struct pci_dev *dev);
+void pci_disable_bridge_window(struct pci_dev *dev);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
@@ -241,7 +239,7 @@ struct pci_sriov {
 };
 
 #ifdef CONFIG_PCI_ATS
-extern void pci_restore_ats_state(struct pci_dev *dev);
+void pci_restore_ats_state(struct pci_dev *dev);
 #else
 static inline void pci_restore_ats_state(struct pci_dev *dev)
 {
@@ -249,14 +247,13 @@ static inline void pci_restore_ats_state(struct pci_dev *dev)
 #endif /* CONFIG_PCI_ATS */
 
 #ifdef CONFIG_PCI_IOV
-extern int pci_iov_init(struct pci_dev *dev);
-extern void pci_iov_release(struct pci_dev *dev);
-extern int pci_iov_resource_bar(struct pci_dev *dev, int resno,
-				enum pci_bar_type *type);
-extern resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev,
-						    int resno);
-extern void pci_restore_iov_state(struct pci_dev *dev);
-extern int pci_iov_bus_range(struct pci_bus *bus);
+int pci_iov_init(struct pci_dev *dev);
+void pci_iov_release(struct pci_dev *dev);
+int pci_iov_resource_bar(struct pci_dev *dev, int resno,
+			 enum pci_bar_type *type);
+resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
+void pci_restore_iov_state(struct pci_dev *dev);
+int pci_iov_bus_range(struct pci_bus *bus);
 
 #else
 static inline int pci_iov_init(struct pci_dev *dev)
@@ -282,10 +279,10 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 
 #endif /* CONFIG_PCI_IOV */
 
-extern unsigned long pci_cardbus_resource_alignment(struct resource *);
+unsigned long pci_cardbus_resource_alignment(struct resource *);
 
 static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
-					 struct resource *res)
+						     struct resource *res)
 {
 #ifdef CONFIG_PCI_IOV
 	int resno = res - dev->resource;
@@ -298,7 +295,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 	return resource_alignment(res);
 }
 
-extern void pci_enable_acs(struct pci_dev *dev);
+void pci_enable_acs(struct pci_dev *dev);
 
 struct pci_dev_reset_methods {
 	u16 vendor;
@@ -307,7 +304,7 @@ struct pci_dev_reset_methods {
 };
 
 #ifdef CONFIG_PCI_QUIRKS
-extern int pci_dev_specific_reset(struct pci_dev *dev, int probe);
+int pci_dev_specific_reset(struct pci_dev *dev, int probe);
 #else
 static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 {
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 22f840f..d12c77c 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -110,15 +110,15 @@ static inline pci_ers_result_t merge_result(enum pci_ers_result orig,
 }
 
 extern struct bus_type pcie_port_bus_type;
-extern void aer_do_secondary_bus_reset(struct pci_dev *dev);
-extern int aer_init(struct pcie_device *dev);
-extern void aer_isr(struct work_struct *work);
-extern void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
-extern void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info);
-extern irqreturn_t aer_irq(int irq, void *context);
+void aer_do_secondary_bus_reset(struct pci_dev *dev);
+int aer_init(struct pcie_device *dev);
+void aer_isr(struct work_struct *work);
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
+void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info);
+irqreturn_t aer_irq(int irq, void *context);
 
 #ifdef CONFIG_ACPI_APEI
-extern int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
+int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
 #else
 static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
 {
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index eea2ca2..d2eb80a 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -21,18 +21,18 @@
 #define get_descriptor_id(type, service) (((type - 4) << 4) | service)
 
 extern struct bus_type pcie_port_bus_type;
-extern int pcie_port_device_register(struct pci_dev *dev);
+int pcie_port_device_register(struct pci_dev *dev);
 #ifdef CONFIG_PM
-extern int pcie_port_device_suspend(struct device *dev);
-extern int pcie_port_device_resume(struct device *dev);
+int pcie_port_device_suspend(struct device *dev);
+int pcie_port_device_resume(struct device *dev);
 #endif
-extern void pcie_port_device_remove(struct pci_dev *dev);
-extern int __must_check pcie_port_bus_register(void);
-extern void pcie_port_bus_unregister(void);
+void pcie_port_device_remove(struct pci_dev *dev);
+int __must_check pcie_port_bus_register(void);
+void pcie_port_bus_unregister(void);
 
 struct pci_dev;
 
-extern void pcie_clear_root_pme_status(struct pci_dev *dev);
+void pcie_clear_root_pme_status(struct pci_dev *dev);
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 extern bool pciehp_msi_disabled;
@@ -59,7 +59,7 @@ static inline bool pcie_pme_no_msi(void)
 	return pcie_pme_msi_disabled;
 }
 
-extern void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable);
+void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable);
 #else /* !CONFIG_PCIE_PME */
 static inline void pcie_pme_disable_msi(void) {}
 static inline bool pcie_pme_no_msi(void) { return false; }
@@ -67,7 +67,7 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
 #ifdef CONFIG_ACPI
-extern int pcie_port_acpi_setup(struct pci_dev *port, int *mask);
+int pcie_port_acpi_setup(struct pci_dev *port, int *mask);
 
 static inline int pcie_port_platform_notify(struct pci_dev *port, int *mask)
 {
diff --git a/include/linux/pci-aspm.h b/include/linux/pci-aspm.h
index c832014..8af4610 100644
--- a/include/linux/pci-aspm.h
+++ b/include/linux/pci-aspm.h
@@ -23,14 +23,14 @@
 #define PCIE_LINK_STATE_CLKPM	4
 
 #ifdef CONFIG_PCIEASPM
-extern void pcie_aspm_init_link_state(struct pci_dev *pdev);
-extern void pcie_aspm_exit_link_state(struct pci_dev *pdev);
-extern void pcie_aspm_pm_state_change(struct pci_dev *pdev);
-extern void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
-extern void pci_disable_link_state(struct pci_dev *pdev, int state);
-extern void pci_disable_link_state_locked(struct pci_dev *pdev, int state);
-extern void pcie_clear_aspm(struct pci_bus *bus);
-extern void pcie_no_aspm(void);
+void pcie_aspm_init_link_state(struct pci_dev *pdev);
+void pcie_aspm_exit_link_state(struct pci_dev *pdev);
+void pcie_aspm_pm_state_change(struct pci_dev *pdev);
+void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pci_disable_link_state(struct pci_dev *pdev, int state);
+void pci_disable_link_state_locked(struct pci_dev *pdev, int state);
+void pcie_clear_aspm(struct pci_bus *bus);
+void pcie_no_aspm(void);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev)
 {
@@ -56,8 +56,8 @@ static inline void pcie_no_aspm(void)
 #endif
 
 #ifdef CONFIG_PCIEASPM_DEBUG /* this depends on CONFIG_PCIEASPM */
-extern void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
-extern void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
+void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
+void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
 {
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 7ef6872..68bcefd 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -14,9 +14,9 @@ struct pci_ats {
 
 #ifdef CONFIG_PCI_ATS
 
-extern int pci_enable_ats(struct pci_dev *dev, int ps);
-extern void pci_disable_ats(struct pci_dev *dev);
-extern int pci_ats_queue_depth(struct pci_dev *dev);
+int pci_enable_ats(struct pci_dev *dev, int ps);
+void pci_disable_ats(struct pci_dev *dev);
+int pci_ats_queue_depth(struct pci_dev *dev);
 
 /**
  * pci_ats_enabled - query the ATS status
@@ -54,12 +54,12 @@ static inline int pci_ats_enabled(struct pci_dev *dev)
 
 #ifdef CONFIG_PCI_PRI
 
-extern int  pci_enable_pri(struct pci_dev *pdev, u32 reqs);
-extern void pci_disable_pri(struct pci_dev *pdev);
-extern bool pci_pri_enabled(struct pci_dev *pdev);
-extern int  pci_reset_pri(struct pci_dev *pdev);
-extern bool pci_pri_stopped(struct pci_dev *pdev);
-extern int  pci_pri_status(struct pci_dev *pdev);
+int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
+void pci_disable_pri(struct pci_dev *pdev);
+bool pci_pri_enabled(struct pci_dev *pdev);
+int pci_reset_pri(struct pci_dev *pdev);
+bool pci_pri_stopped(struct pci_dev *pdev);
+int pci_pri_status(struct pci_dev *pdev);
 
 #else /* CONFIG_PCI_PRI */
 
@@ -95,10 +95,10 @@ static inline int pci_pri_status(struct pci_dev *pdev)
 
 #ifdef CONFIG_PCI_PASID
 
-extern int pci_enable_pasid(struct pci_dev *pdev, int features);
-extern void pci_disable_pasid(struct pci_dev *pdev);
-extern int pci_pasid_features(struct pci_dev *pdev);
-extern int pci_max_pasids(struct pci_dev *pdev);
+int pci_enable_pasid(struct pci_dev *pdev, int features);
+void pci_disable_pasid(struct pci_dev *pdev);
+int pci_pasid_features(struct pci_dev *pdev);
+int pci_max_pasids(struct pci_dev *pdev);
 
 #else  /* CONFIG_PCI_PASID */
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2461033a..614512b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -348,7 +348,7 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 	return dev;
 }
 
-extern struct pci_dev *alloc_pci_dev(void);
+struct pci_dev *alloc_pci_dev(void);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
@@ -504,10 +504,10 @@ struct pci_ops {
  * ACPI needs to be able to access PCI config space before we've done a
  * PCI bus scan and created pci_bus structures.
  */
-extern int raw_pci_read(unsigned int domain, unsigned int bus,
-			unsigned int devfn, int reg, int len, u32 *val);
-extern int raw_pci_write(unsigned int domain, unsigned int bus,
-			unsigned int devfn, int reg, int len, u32 val);
+int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
+		 int reg, int len, u32 *val);
+int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
+		  int reg, int len, u32 val);
 
 struct pci_bus_region {
 	resource_size_t start;
@@ -658,7 +658,7 @@ struct pci_driver {
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
-extern void pcie_bus_configure_settings(struct pci_bus *bus, u8 smpss);
+void pcie_bus_configure_settings(struct pci_bus *bus, u8 smpss);
 
 enum pcie_bus_config_types {
 	PCIE_BUS_TUNE_OFF,
@@ -675,7 +675,7 @@ extern struct bus_type pci_bus_type;
  * code, or pci core code. */
 extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 /* Some device drivers need know if pci is initiated */
-extern int no_pci_devices(void);
+int no_pci_devices(void);
 
 void pcibios_resource_survey_bus(struct pci_bus *bus);
 void pcibios_fixup_bus(struct pci_bus *);
@@ -699,7 +699,7 @@ void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			     struct pci_bus_region *region);
 void pcibios_scan_specific_bus(int busn);
-extern struct pci_bus *pci_find_bus(int domain, int busnr);
+struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
 struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus,
 				      struct pci_ops *ops, void *sysdata);
@@ -732,14 +732,14 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
-extern struct pci_dev *pci_dev_get(struct pci_dev *dev);
-extern void pci_dev_put(struct pci_dev *dev);
-extern void pci_remove_bus(struct pci_bus *b);
-extern void pci_stop_and_remove_bus_device(struct pci_dev *dev);
+struct pci_dev *pci_dev_get(struct pci_dev *dev);
+void pci_dev_put(struct pci_dev *dev);
+void pci_remove_bus(struct pci_bus *b);
+void pci_stop_and_remove_bus_device(struct pci_dev *dev);
 void pci_stop_root_bus(struct pci_bus *bus);
 void pci_remove_root_bus(struct pci_bus *bus);
 void pci_setup_cardbus(struct pci_bus *bus);
-extern void pci_sort_breadthfirst(void);
+void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
 #define dev_num_vf(d) ((dev_is_pci(d) ? pci_num_vf(to_pci_dev(d)) : 0))
@@ -1141,18 +1141,17 @@ static inline int pci_msi_enabled(void)
 	return 0;
 }
 #else
-extern int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
-extern int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec);
-extern void pci_msi_shutdown(struct pci_dev *dev);
-extern void pci_disable_msi(struct pci_dev *dev);
-extern int pci_msix_table_size(struct pci_dev *dev);
-extern int pci_enable_msix(struct pci_dev *dev,
-	struct msix_entry *entries, int nvec);
-extern void pci_msix_shutdown(struct pci_dev *dev);
-extern void pci_disable_msix(struct pci_dev *dev);
-extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
-extern void pci_restore_msi_state(struct pci_dev *dev);
-extern int pci_msi_enabled(void);
+int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
+int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec);
+void pci_msi_shutdown(struct pci_dev *dev);
+void pci_disable_msi(struct pci_dev *dev);
+int pci_msix_table_size(struct pci_dev *dev);
+int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec);
+void pci_msix_shutdown(struct pci_dev *dev);
+void pci_disable_msix(struct pci_dev *dev);
+void msi_remove_pci_irq_vectors(struct pci_dev *dev);
+void pci_restore_msi_state(struct pci_dev *dev);
+int pci_msi_enabled(void);
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
@@ -1167,8 +1166,8 @@ extern bool pcie_ports_auto;
 static inline int pcie_aspm_enabled(void) { return 0; }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 #else
-extern int pcie_aspm_enabled(void);
-extern bool pcie_aspm_support_enabled(void);
+int pcie_aspm_enabled(void);
+bool pcie_aspm_support_enabled(void);
 #endif
 
 #ifdef CONFIG_PCIEAER
@@ -1186,8 +1185,8 @@ static inline void pcie_set_ecrc_checking(struct pci_dev *dev)
 }
 static inline void pcie_ecrc_get_policy(char *str) {};
 #else
-extern void pcie_set_ecrc_checking(struct pci_dev *dev);
-extern void pcie_ecrc_get_policy(char *str);
+void pcie_set_ecrc_checking(struct pci_dev *dev);
+void pcie_ecrc_get_policy(char *str);
 #endif
 
 #define pci_enable_msi(pdev)	pci_enable_msi_block(pdev, 1)
@@ -1198,9 +1197,9 @@ int  ht_create_irq(struct pci_dev *dev, int idx);
 void ht_destroy_irq(unsigned int irq);
 #endif /* CONFIG_HT_IRQ */
 
-extern void pci_cfg_access_lock(struct pci_dev *dev);
-extern bool pci_cfg_access_trylock(struct pci_dev *dev);
-extern void pci_cfg_access_unlock(struct pci_dev *dev);
+void pci_cfg_access_lock(struct pci_dev *dev);
+bool pci_cfg_access_trylock(struct pci_dev *dev);
+void pci_cfg_access_unlock(struct pci_dev *dev);
 
 /*
  * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
@@ -1225,7 +1224,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 /* some architectures require additional setup to direct VGA traffic */
 typedef int (*arch_set_vga_state_t)(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
-extern void pci_register_set_vga_state(arch_set_vga_state_t func);
+void pci_register_set_vga_state(arch_set_vga_state_t func);
 
 #else /* CONFIG_PCI is not enabled */
 
@@ -1627,8 +1626,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev,
 int pcibios_add_device(struct pci_dev *dev);
 
 #ifdef CONFIG_PCI_MMCONFIG
-extern void __init pci_mmcfg_early_init(void);
-extern void __init pci_mmcfg_late_init(void);
+void __init pci_mmcfg_early_init(void);
+void __init pci_mmcfg_late_init(void);
 #else
 static inline void pci_mmcfg_early_init(void) { }
 static inline void pci_mmcfg_late_init(void) { }
@@ -1639,12 +1638,12 @@ int pci_ext_cfg_avail(void);
 void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
 
 #ifdef CONFIG_PCI_IOV
-extern int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
-extern void pci_disable_sriov(struct pci_dev *dev);
-extern irqreturn_t pci_sriov_migration(struct pci_dev *dev);
-extern int pci_num_vf(struct pci_dev *dev);
-extern int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
-extern int pci_sriov_get_totalvfs(struct pci_dev *dev);
+int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
+void pci_disable_sriov(struct pci_dev *dev);
+irqreturn_t pci_sriov_migration(struct pci_dev *dev);
+int pci_num_vf(struct pci_dev *dev);
+int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
+int pci_sriov_get_totalvfs(struct pci_dev *dev);
 #else
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 {
@@ -1672,8 +1671,8 @@ static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
 #endif
 
 #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
-extern void pci_hp_create_module_link(struct pci_slot *pci_slot);
-extern void pci_hp_remove_module_link(struct pci_slot *pci_slot);
+void pci_hp_create_module_link(struct pci_slot *pci_slot);
+void pci_hp_remove_module_link(struct pci_slot *pci_slot);
 #endif
 
 /**
@@ -1817,13 +1816,13 @@ int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 /* PCI <-> OF binding helpers */
 #ifdef CONFIG_OF
 struct device_node;
-extern void pci_set_of_node(struct pci_dev *dev);
-extern void pci_release_of_node(struct pci_dev *dev);
-extern void pci_set_bus_of_node(struct pci_bus *bus);
-extern void pci_release_bus_of_node(struct pci_bus *bus);
+void pci_set_of_node(struct pci_dev *dev);
+void pci_release_of_node(struct pci_dev *dev);
+void pci_set_bus_of_node(struct pci_bus *bus);
+void pci_release_bus_of_node(struct pci_bus *bus);
 
 /* Arch may override this (weak) */
-extern struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus);
+struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus);
 
 static inline struct device_node *
 pci_device_to_OF_node(const struct pci_dev *pdev)
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 45fc162..8db71dc 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -125,12 +125,12 @@ static inline const char *hotplug_slot_name(const struct hotplug_slot *slot)
 	return pci_slot_name(slot->pci_slot);
 }
 
-extern int __pci_hp_register(struct hotplug_slot *slot, struct pci_bus *pbus,
-			     int nr, const char *name,
-			     struct module *owner, const char *mod_name);
-extern int pci_hp_deregister(struct hotplug_slot *slot);
-extern int __must_check pci_hp_change_slot_info	(struct hotplug_slot *slot,
-						 struct hotplug_slot_info *info);
+int __pci_hp_register(struct hotplug_slot *slot, struct pci_bus *pbus, int nr,
+		      const char *name, struct module *owner,
+		      const char *mod_name);
+int pci_hp_deregister(struct hotplug_slot *slot);
+int __must_check pci_hp_change_slot_info(struct hotplug_slot *slot,
+					 struct hotplug_slot_info *info);
 
 /* use a define to avoid include chaining to get THIS_MODULE & friends */
 #define pci_hp_register(slot, pbus, devnr, name) \
diff --git a/include/linux/pcieport_if.h b/include/linux/pcieport_if.h
index e6f91b1..9572669 100644
--- a/include/linux/pcieport_if.h
+++ b/include/linux/pcieport_if.h
@@ -62,7 +62,7 @@ struct pcie_port_service_driver {
 #define to_service_driver(d) \
 	container_of(d, struct pcie_port_service_driver, driver)
 
-extern int pcie_port_service_register(struct pcie_port_service_driver *new);
-extern void pcie_port_service_unregister(struct pcie_port_service_driver *new);
+int pcie_port_service_register(struct pcie_port_service_driver *new);
+void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 
 #endif /* _PCIEPORT_IF_H_ */

