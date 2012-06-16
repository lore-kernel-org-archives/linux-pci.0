Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:27413 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab2FPI67 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2012 04:58:59 -0400
Message-ID: <4FDC4AAC.8010601@huawei.com>
Date: Sat, 16 Jun 2012 16:58:20 +0800
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
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com> <1338026043-3968-9-git-send-email-jiang.liu@huawei.com> <CAE9FiQVHBE7pvaC5aCk-7q_pU3mxSoo5JapQkjG80DcnW16ZxA@mail.gmail.com> <CAErSpo5BtQ3dmn4t==ByG+Y=Q7w+wwZ7sw+LJwkSxQG8bKuUzg@mail.gmail.com> <CAE9FiQUOtdB3PMgmX8aSRYrinhJGWoUBZGii1aowDBLKTH_LJQ@mail.gmail.com>
In-Reply-To: <CAE9FiQUOtdB3PMgmX8aSRYrinhJGWoUBZGii1aowDBLKTH_LJQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,
	How about following patch to solve the "probe/free then install" issue?
For pci_mmcfg_early_init(), we still need the "probe/free then install" dance
because MMCONFIG may be need for hardware quirks at early stage.
For pci_mmcfg_late_init(), the patch get rid of the redundant "probe/free"
steps. It also generates better readable code.
	Thanks!
	Gerry

---
The logic of __pci_mmcfg_init() is a little complex, so simplify it a little.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/pci/mmconfig-shared.c |   72 ++++++++++++++++++++++------------------
 1 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 06da933..e9a791c 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -566,8 +566,6 @@ static void __init pci_mmcfg_reject_broken(int early)
        }
 }

-static int __initdata known_bridge;
-
 static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
                                        struct acpi_mcfg_allocation *cfg)
 {
@@ -647,25 +645,10 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
        return 0;
 }

-static void __init __pci_mmcfg_init(int early)
-{
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
+static int __initdata known_bridge;

+static void __init __pci_mmcfg_init(int early, bool create_on_demand)
+{
        if (!known_bridge)
                acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);

@@ -684,6 +667,13 @@ static void __init __pci_mmcfg_init(int early)
                }
        }

+       /*
+        * Avoid redundant pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap() calls
+        * for each MMCONFIG entry if they will be created on demand.
+        */
+       if (create_on_demand)
+               free_all_mmcfg();
+
        if (pci_mmcfg_arch_init())
                pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
        else {
@@ -694,26 +684,44 @@ static void __init __pci_mmcfg_init(int early)
                pci_mmcfg_resources_inserted = 1;
                pci_mmcfg_arch_init_failed = true;
        }
-
-out:
-       /*
-        * Free all MCFG entries if ACPI is enabled. MCFG information will
-        * be added back on demand by the pci_root driver later.
-        */
-       if (!early && !acpi_disabled && !known_bridge &&
-           !pci_mmcfg_arch_init_failed)
-               if (!acpi_pci_cache_mcfg())
-                       free_all_mmcfg();
 }

 void __init pci_mmcfg_early_init(void)
 {
-       __pci_mmcfg_init(1);
+       if (pci_probe & PCI_PROBE_MMCONF) {
+               if (pci_mmcfg_check_hostbridge())
+                       known_bridge = 1;
+               __pci_mmcfg_init(1, false);
+       }
 }

 void __init pci_mmcfg_late_init(void)
 {
-       __pci_mmcfg_init(0);
+       bool create_on_demand;
+
+       /* MMCONFIG disabled */
+       if ((pci_probe & PCI_PROBE_MMCONF) == 0)
+               return;
+
+       /* Don't touch hardcoded MMCONFIG information */
+       if (known_bridge)
+               return;
+
+       /*
+        * MMCONFIG information will be created on demand by pci_root driver
+        * when binding to ACPI host bridge deivces.
+        */
+       create_on_demand = (!acpi_disabled && !acpi_pci_cache_mcfg());
+
+       /* pci_mmcfg_early_init() fails to setup MMCONFIG, try again. */
+       if (pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF)
+               __pci_mmcfg_init(0, create_on_demand);
+       /*
+        * Free MMCONFIG information created by pci_mmcfg_early_init()
+        * if MMCONFIG information will be created on demand.
+        */
+       else if (create_on_demand)
+               free_all_mmcfg();
 }

 static int __init pci_mmcfg_late_insert_resources(void)
--
1.7.1


On 2012-6-16 0:55, Yinghai Lu wrote:
> On Fri, Jun 15, 2012 at 8:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>>> But the code in the init path is ridiculously, embarrassingly complicated ...
>>
>> I rest my case.  The current init path is unmaintainable.
>>
>> I'll wait for a v8 (or later) with fixes for the build issues
>> Fengguang found and Yinghai's ack.  It will make things somewhat
>> easier for me if you start with my topic/jiang-mmconfig-v7 branch.
> 
> yes. probe/free then install is not good.
> 
> should make __pci_mmcfg_init() to cache needed stuff for all path, and
> then consume stored
> entry just before scan root bus.
> 
> Thanks
> 
> Yinghai
> 
> 


