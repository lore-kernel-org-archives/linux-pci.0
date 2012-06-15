Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:58263 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab2FOL7M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jun 2012 07:59:12 -0400
Message-ID: <4FDB2192.5070709@huawei.com>
Date: Fri, 15 Jun 2012 19:50:42 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH v7 08/10] PCI, x86: add MMCFG information on demand
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com> <1338026043-3968-9-git-send-email-jiang.liu@huawei.com> <CAE9FiQVHBE7pvaC5aCk-7q_pU3mxSoo5JapQkjG80DcnW16ZxA@mail.gmail.com>
In-Reply-To: <CAE9FiQVHBE7pvaC5aCk-7q_pU3mxSoo5JapQkjG80DcnW16ZxA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,
	A formal patch to fix "here cache cfg too early.  should do 
that after pci_mmcfg_reject_broken()". This patch also improves
readability and fixes two condition compilation issues reported by
Fengguang. If you are ok with it, I will fold it into 
"[PATCH v7 08/10] PCI, x86: add MMCFG information on demand".
	Thanks!
	Gerry

---
diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 7eae174..5eb2ac9 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -142,7 +142,7 @@ extern int __devinit pci_mmconfig_insert(struct device *dev,
                                         u16 seg, u8 start, u8 end,
                                         phys_addr_t addr);
 extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
-#ifdef CONFIG_ACPI
+#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_MMCONFIG)
 extern void pci_mmconfig_probe(u8 start);
 #else
 static inline void pci_mmconfig_probe(u8 start) { }
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 20ab4f5..636de35 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -636,13 +636,6 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
                }
        }

-       i = entries * sizeof(*cfg_table);
-       pci_acpi_mcfg_array = kmalloc(i, GFP_KERNEL);
-       if (pci_acpi_mcfg_array) {
-               memcpy(pci_acpi_mcfg_array, cfg_table, i);
-               pci_acpi_mcfg_entries = entries;
-       }
-
        return 0;
 }

@@ -699,8 +692,11 @@ out:
         * Free all MCFG entries if ACPI is enabled. MCFG information will
         * be added back on demand by the pci_root driver later.
         */
-       if (!early && !acpi_disabled && !known_bridge && pci_acpi_mcfg_array)
-               free_all_mmcfg();
+       if (!early && !acpi_disabled && !known_bridge &&
+           !pci_mmcfg_arch_init_failed) {
+               if (!acpi_pci_cache_mcfg())
+                       free_all_mmcfg();
+       }
 }

 void __init pci_mmcfg_early_init(void)
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index f5d2157..93e0f91 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -163,8 +163,34 @@ acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
 }

 /* acpi_table_parse() is marked as __init, so cache MCFG info at boot time */
-int pci_acpi_mcfg_entries;
-struct acpi_mcfg_allocation *pci_acpi_mcfg_array;
+static int pci_acpi_mcfg_entries;
+static struct acpi_mcfg_allocation *pci_acpi_mcfg_array;
+
+static int __init pci_cache_mcfg(struct acpi_table_header *header)
+{
+       u32 sz;
+       void *ptr;
+
+       if (!header || (header->length <= sizeof(struct acpi_table_mcfg)))
+               return -EINVAL;
+
+       sz = (header->length - sizeof(struct acpi_table_mcfg));
+       pci_acpi_mcfg_array = kmalloc(sz, GFP_KERNEL);
+       if (!pci_acpi_mcfg_array)
+               return -ENOMEM;
+
+       ptr = (void *)header + sizeof(struct acpi_table_mcfg);
+       memcpy(pci_acpi_mcfg_array, ptr, sz);
+       pci_acpi_mcfg_entries = sz / sizeof (struct acpi_mcfg_allocation);
+
+       return 0;
+}
+
+int __init acpi_pci_cache_mcfg(void)
+{
+       acpi_table_parse(ACPI_SIG_MCFG, pci_cache_mcfg);
+       return pci_acpi_mcfg_array ? 0 : -EINVAL;
+}

 phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle, u16 seg,
                                        u8 start, int *endp)
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 946789f..e03207c 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -11,15 +11,13 @@
 #include <linux/acpi.h>

 #ifdef CONFIG_ACPI
-extern int pci_acpi_mcfg_entries;
-extern struct acpi_mcfg_allocation *pci_acpi_mcfg_array;
-
 extern acpi_status pci_acpi_add_bus_pm_notifier(struct acpi_device *dev,
                                                 struct pci_bus *pci_bus);
 extern acpi_status pci_acpi_remove_bus_pm_notifier(struct acpi_device *dev);
 extern acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
                                             struct pci_dev *pci_dev);
 extern acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev);
+extern int acpi_pci_cache_mcfg(void);
 extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle,
                        u16 seg, u8 start, int *endp);

@@ -40,6 +38,8 @@ static inline acpi_handle acpi_pci_get_bridge_handle(struct pci_bus *pbus)
        return acpi_get_pci_rootbridge_handle(pci_domain_nr(pbus),
                                              pbus->number);
 }
+#else
+static inline int acpi_pci_cache_mcfg(void) { return -EINVAL; }
 #endif

 #ifdef CONFIG_ACPI_APEI
---

On 2012-6-15 15:15, Yinghai Lu wrote:
> On Sat, May 26, 2012 at 2:54 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
>> This patch changes mmconfig logic on x86 platforms to add MMCFG
>> information on demand instead of adding all MMCFG entries from
>> the ACPI MCFG table at boot time. So only MMCFG address ranges
>> used by active PCI host bridges will be actually mapped.
>>
>> Signed-off-by: Jiang Liu <liuj97@gmail.com>
>> ---
>>  arch/x86/include/asm/pci_x86.h |    5 +++
>>  arch/x86/pci/legacy.c          |    1 +
>>  arch/x86/pci/mmconfig-shared.c |   54 +++++++++++++++++++++++++++++++++++++---
>>  3 files changed, 56 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
>> index 3e5f43c..4a1a9aa 100644
>> --- a/arch/x86/include/asm/pci_x86.h
>> +++ b/arch/x86/include/asm/pci_x86.h
>> @@ -142,6 +142,11 @@ extern int __devinit pci_mmconfig_insert(struct device *dev,
>>                                         uint16_t seg, uint8_t start,
>>                                         uint8_t end, phys_addr_t addr);
>>  extern int pci_mmconfig_delete(uint16_t seg, uint8_t start, uint8_t end);
>> +#ifdef CONFIG_ACPI
>> +extern void pci_mmconfig_probe(uint8_t start);
>> +#else
>> +static inline void pci_mmconfig_probe(uint8_t start) { }
>> +#endif
>>  extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
>>
>>  extern struct list_head pci_mmcfg_list;
>> diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
>> index a1df191..e9a2384 100644
>> --- a/arch/x86/pci/legacy.c
>> +++ b/arch/x86/pci/legacy.c
>> @@ -49,6 +49,7 @@ void __devinit pcibios_scan_specific_bus(int busn)
>>                    l != 0x0000 && l != 0xffff) {
>>                        DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
>>                        printk(KERN_INFO "PCI: Discovered peer bus %02x\n", busn);
>> +                       pci_mmconfig_probe(busn);
>>                        pci_scan_bus_on_node(busn, &pci_root_ops, node);
>>                        return;
>>                }
>> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
>> index fa0aa90..e80b5c2 100644
>> --- a/arch/x86/pci/mmconfig-shared.c
>> +++ b/arch/x86/pci/mmconfig-shared.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/mutex.h>
>>  #include <linux/rculist.h>
>> +#include <linux/pci-acpi.h>
>>  #include <asm/e820.h>
>>  #include <asm/pci_x86.h>
>>  #include <asm/acpi.h>
>> @@ -616,6 +617,16 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
>>                        return -ENODEV;
>>                }
>>
>> +               /*
>> +                * MMCFG information for host brideges will be added on demand
>> +                * by pci_root driver if ACPI is enabled. But there are special
>> +                * requirements for devices on segment 0, MMCFG information may
>> +                * be needed for fixing hardware quirks and probing for hidden
>> +                * buses.
>> +                */
>> +               if (!acpi_disabled && cfg->pci_segment)
>> +                       continue;
>> +
>>                if (pci_mmconfig_add(cfg->pci_segment, cfg->start_bus_number,
>>                                   cfg->end_bus_number, cfg->address) == NULL) {
>>                        printk(KERN_WARNING PREFIX
>> @@ -625,6 +636,13 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
>>                }
>>        }
>>
>> +       i = entries * sizeof(*cfg_table);
>> +       pci_acpi_mcfg_array = kmalloc(i, GFP_KERNEL);
>> +       if (pci_acpi_mcfg_array) {
>> +               memcpy(pci_acpi_mcfg_array, cfg_table, i);
>> +               pci_acpi_mcfg_entries = entries;
>> +       }
>> +
> 
> here cache cfg too early.  should do that after
> 
> pci_mmcfg_reject_broken().
> 
> otherwise will use mcfg even try to reject that before.
> 
>>        return 0;
>>  }
>>
>> @@ -634,14 +652,14 @@ static void __init __pci_mmcfg_init(int early)
>>        if ((pci_probe & PCI_PROBE_MMCONF) == 0)
>>                return;
>>
>> -       /* MMCONFIG already enabled */
>> -       if (!early && !(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
>> -               return;
>> -
>>        /* for late to exit */
>>        if (known_bridge)
>>                return;
>>
>> +       /* MMCONFIG already enabled */
>> +       if (!early && !(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
>> +               goto out;
>> +
>>        if (early) {
>>                if (pci_mmcfg_check_hostbridge())
>>                        known_bridge = 1;
>> @@ -675,6 +693,14 @@ static void __init __pci_mmcfg_init(int early)
>>                pci_mmcfg_resources_inserted = 1;
>>                pci_mmcfg_arch_init_failed = true;
>>        }
>> +
>> +out:
>> +       /*
>> +        * Free all MCFG entries if ACPI is enabled. MCFG information will
>> +        * be added back on demand by the pci_root driver later.
>> +        */
>> +       if (!early && !acpi_disabled && !known_bridge && pci_acpi_mcfg_array)
>> +               free_all_mmcfg();
> 
> that really change the logic.
> 
> looks like it will break mrst/sfi path.
> 
> the scan from pci_legacy_init() for mrst/sfi will not have ext_pci_ops
> set for bus 0.
> 
> | int __init pci_subsys_init(void)
> | {
> |        /*
> |         * The init function returns an non zero value when
> |         * pci_legacy_init should be invoked.
> |         */
> |        if (x86_init.pci.init())
> |                pci_legacy_init();
> |
> |        pcibios_fixup_peer_bridges();
> 
> 
> Yinghai
> 
>>  }
>>
>>  void __init pci_mmcfg_early_init(void)
>> @@ -809,3 +835,23 @@ int pci_mmconfig_delete(uint16_t seg, uint8_t start, uint8_t end)
>>
>>        return -ENOENT;
>>  }
>> +
>> +/* Probe MMCFG information for PCI bus blind probe */
>> +void __devinit pci_mmconfig_probe(uint8_t start)
>> +{
>> +       int end_bus, temp;
>> +       phys_addr_t addr;
>> +
>> +       if (!(pci_probe & PCI_PROBE_MMCONF) || pci_mmcfg_arch_init_failed)
>> +               return;
>> +
>> +       addr = acpi_pci_root_get_mcfg_addr(NULL, 0, start, &end_bus);
>> +       if (addr && end_bus >= 0 && end_bus <= 255) {
>> +               for (temp = start + 1; temp <= end_bus; temp++)
>> +                       if (pci_find_bus(0, temp))
>> +                               break;
>> +
>> +               temp--;
>> +               pci_mmconfig_insert(NULL, 0, start, (uint8_t)temp, addr);
>> +       }
>> +}
>> --
>> 1.7.1
>>
>>
> 
> .
> 


