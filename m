Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:40261 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab2FOIZq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jun 2012 04:25:46 -0400
Message-ID: <4FDAEE9A.7060706@huawei.com>
Date: Fri, 15 Jun 2012 16:13:14 +0800
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
	Thanks for your review and comments!
On 2012-6-15 15:15, Yinghai Lu wrote:
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
Good cache, how about the following patch to fix this?
I'm also preparing an V8 to fix build failure issues reported by Fengguang,
and also simplify the __pci_mmcfg_init() implementation.

---
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 77f0db2..bcd0928 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -623,11 +623,27 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
                }
        }

-       i = entries * sizeof(*cfg_table);
-       pci_acpi_mcfg_array = kmalloc(i, GFP_KERNEL);
-       if (pci_acpi_mcfg_array) {
-               memcpy(pci_acpi_mcfg_array, cfg_table, i);
-               pci_acpi_mcfg_entries = entries;
+       return 0;
+}
+
+static int __init pci_cache_mcfg(struct acpi_table_header *header)
+{
+       unsigned long i;
+       struct acpi_table_mcfg *mcfg;
+       struct acpi_mcfg_allocation *cfg_table;
+
+       if (!header)
+               return -EINVAL;
+
+       i = (header->length - sizeof(struct acpi_table_mcfg));
+       if (i) {
+               pci_acpi_mcfg_array = kmalloc(i, GFP_KERNEL);
+               if (pci_acpi_mcfg_array) {
+                       mcfg = (struct acpi_table_mcfg *)header;
+                       cfg_table = (struct acpi_mcfg_allocation *) &mcfg[1];
+                       memcpy(pci_acpi_mcfg_array, cfg_table, i);
+                       pci_acpi_mcfg_entries = i / sizeof (*cfg_table);
+               }
        }

        return 0;
@@ -682,8 +698,11 @@ out:
         * Free all MCFG entries if ACPI is enabled. MCFG information will
         * be added back on demand by the pci_root driver later.
         */
-       if (!early && !acpi_disabled && !known_bridge && pci_acpi_mcfg_array)
-               free_all_mmcfg();
+       if (!early && !acpi_disabled && !known_bridge) {
+               acpi_table_parse(ACPI_SIG_MCFG, pci_cache_mcfg);
+               if (pci_acpi_mcfg_array)
+                       free_all_mmcfg();
+       }
 }

 void __init pci_mmcfg_early_init(void)
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

On platform with SFI implementation such as Moorsetown, acpi_disabled will
be set to 1 because there's no ACPI root pointer and acpi initialize will fail.
And sfi_init() implementation confirms that if acpi is enabled, then sfi will
be disabled. So I will it won't break SFI/MRST.

void __init sfi_init(void)
{
        if (!acpi_disabled)
                disable_sfi();

        if (sfi_disabled)
                return;
}

thanks!
Gerry

