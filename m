Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:3165 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756685Ab2FOLpV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jun 2012 07:45:21 -0400
Message-ID: <4FDB1FB2.6040401@huawei.com>
Date: Fri, 15 Jun 2012 19:42:42 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 00/10] PCI, x86: update MMCFG information when hot-plugging
 PCI host bridges
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com> <CAErSpo4v_N8MhoCyQMi6vOOipw6Cg8wbMqP2q9FXT+gXjF88iw@mail.gmail.com>
In-Reply-To: <CAErSpo4v_N8MhoCyQMi6vOOipw6Cg8wbMqP2q9FXT+gXjF88iw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
	I have prepared another patch to simplify the __pci_mmcfg_init()
implementation. What's your thoughts? If OK, I will include it in v8.
	Thanks!

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 236872e..b4b07d4 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -626,32 +626,15 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
        return 0;
 }

-static void __init __pci_mmcfg_init(int early)
+static int __init __pci_mmcfg_init(int early)
 {
-       /* MMCONFIG disabled */
-       if ((pci_probe & PCI_PROBE_MMCONF) == 0)
-               return;
-
-       /* for late to exit */
-       if (known_bridge)
-               return;
-
-       /* MMCONFIG already enabled */
-       if (!early && !(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
-               goto out;
-
-       if (early) {
-               if (pci_mmcfg_check_hostbridge())
-                       known_bridge = 1;
-       }
-
        if (!known_bridge)
                acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);

        pci_mmcfg_reject_broken(early);

        if (list_empty(&pci_mmcfg_list))
-               return;
+               return -EINVAL;

        if (pcibios_last_bus < 0) {
                const struct pci_mmcfg_region *cfg;
@@ -668,28 +651,43 @@ static void __init __pci_mmcfg_init(int early)
        else {
                free_all_mmcfg();
                pci_mmcfg_arch_init_failed = true;
+               return -EINVAL;
        }

-out:
-       /*
-        * Free all MCFG entries if ACPI is enabled. MCFG information will
-        * be added back on demand by the pci_root driver later.
-        */
-       if (!early && !acpi_disabled && !known_bridge &&
-           !pci_mmcfg_arch_init_failed) {
-               if (!acpi_pci_cache_mcfg())
-                       free_all_mmcfg();
-       }
+       return 0;
 }

 void __init pci_mmcfg_early_init(void)
 {
-       __pci_mmcfg_init(1);
+       if (pci_probe & PCI_PROBE_MMCONF) {
+               if (pci_mmcfg_check_hostbridge())
+                       known_bridge = 1;
+               __pci_mmcfg_init(1);
+       }
 }

 void __init pci_mmcfg_late_init(void)
 {
-       __pci_mmcfg_init(0);
+       int ret = 0;
+
+       /* MMCONFIG disabled */
+       if ((pci_probe & PCI_PROBE_MMCONF) == 0)
+               return;
+
+       if (known_bridge)
+               return;
+
+       /* MMCONFIG hasn't been enabled yet */
+       if (pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF)
+               ret = __pci_mmcfg_init(0);
+
+       /*
+        * Free all MCFG entries if ACPI is enabled. MCFG information will
+        * be added back on demand by the pci_root driver later.
+        */
+       if (!acpi_disabled && !ret)
+               if (!acpi_pci_cache_mcfg())
+                       free_all_mmcfg();
 }

 static int __init pci_mmcfg_late_insert_resources(void)

On 2012-6-15 11:06, Bjorn Helgaas wrote:
> On Sat, May 26, 2012 at 3:53 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
>> This patchset enhance pci_root driver to update MMCFG information when
>> hot-plugging PCI root bridges. It applies to
>> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/next-3.5
>>
>> -v2: split into smaller patches and skip updating MMCFG information when
>>     MMCFG is disabled
>> -v3: add mmconf_added to simply free path, also make pci_mmconfig_insert()
>>     to process extra exist case --- By Yinghai
>> -v4: tune arch_acpi_pci_root_add() to handle a corner case raised by Kenji
>> -v5: address review comments from Bjorn and Taku, also better handle corner
>>     cases in arch_acpi_pci_root_add()
>> -v6: get rid of arch_acpi_pci_root_xxx() by using existing hooks
>>     add MCFG information for host bridges on demand
>>     more corner cases clear up
>>     correctly handle condition compilation
>>     fix section mismatch issues
>>     fix a issue reported by Taku about a BIOS bug
>> -v7: unify log messages
>>     remove redundant host bridge resource related log messages
>>     fix a issue reported by Taku which breaks pnp resource allocation
>>
>> Jiang Liu (10):
>>  PCI, x86: split out pci_mmcfg_check_reserved() for code reuse
>>  PCI, x86: split out pci_mmconfig_alloc() for code reuse
>>  PCI, x86: use RCU list to protect mmconfig list
>>  PCI, x86: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
>>  PCI, x86: introduce pci_mmconfig_insert()/delete() for PCI root
>>    bridge hotplug
>>  PCI, ACPI: provide MCFG address for PCI host bridges
>>  PCI, x86: update MMCFG information when hot-plugging PCI host bridges
>>  PCI, x86: add MMCFG information on demand
>>  PCI, x86: simplify pci_mmcfg_late_insert_resources()
>>  PCI, x86: get rid of redundant log messages
> 
> I applied this to a topic/jiang-mmconfig-v7 branch with minor changes:
> 
> - I changed uint8_t and uint16_t to the more common u8 and u16.
> - I changed the "not reserved in ACPI motherboard resources" message
> from KERN_ERR to KERN_INFO.
> 
> Previously, we typically would not see "motherboard resources"
> warnings at all because we didn't check for them during early init,
> and late init returned before checking because MMCONFIG was already
> enabled.  Now, the pci_mmconfig_insert() does the checking that we
> skipped before.
> 
> Using KERN_ERR would break the graphical boot experience and users
> would complain, we can't do anything to fix it, and MMCONFIG actually
> works fine anyway.  So I don't think there's any point in having them
> be errors.
> 
> I have to say I'm still ambivalent about this.  I really like the fact
> that we track MMCONFIG space on a per-host bridge basis.  But the code
> in the init path is ridiculously, embarrassingly complicated
> (obviously this is not your fault at all).  It took me a couple hours
> to trace through and figure out why my box emits the "motherboard
> resources" warnings when it didn't before.
> 
> I'm going to apply the series because I do think it's a net win.  So
> just consider this as encouragement to simplify the design when you
> can, even if you're not adding functionality.
> 
> I'll merge this to my "next" branch tomorrow unless you see any issues
> with the tweaks I made.
> 
> Bjorn
> 
> .
> 


