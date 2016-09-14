Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Wed, 14 Sep 2016 13:40:16 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
	arnd@arndb.de, hanjun.guo@linaro.org, okaya@codeaurora.org,
	jchandra@broadcom.com, cov@codeaurora.org, dhdang@apm.com,
	ard.biesheuvel@linaro.org, robert.richter@caviumnetworks.com,
	mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org, jcm@redhat.com,
	andrea.gallo@linaro.org, jeremy.linton@arm.com,
	gabriele.paoloni@huawei.com, jhugo@codeaurora.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 2/5] PCI/ACPI: Check platform specific ECAM quirks
Message-ID: <20160914124016.GA4123@red-moon>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-3-git-send-email-tn@semihalf.com>
 <57D76626.1050109@huawei.com>
 <bac9f822-ce0a-7070-94df-4d66fc30f774@semihalf.com>
 <57D7E53F.1000106@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57D7E53F.1000106@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 07:38:39PM +0800, Dongdong Liu wrote:
> Hi Tomasz
> 
> ?? 2016/9/13 14:32, Tomasz Nowicki ????:
> >Hi Liu,
> >
> >On 13.09.2016 04:36, Dongdong Liu wrote:
> >>Hi Tomasz
> >>
> >>?? 2016/9/10 3:24, Tomasz Nowicki ????:
> >>>Some platforms may not be fully compliant with generic set of PCI config
> >>>accessors. For these cases we implement the way to overwrite CFG
> >>>accessors
> >>>set and configuration space range.
> >>>
> >>>In first place pci_mcfg_parse() saves machine's IDs and revision number
> >>>(these come from MCFG header) in order to match against known quirk
> >>>entries.
> >>>Then the algorithm traverses available quirk list (static array),
> >>>matches against <oem_id, oem_table_id, rev, domain, bus number range> and
> >>>returns custom PCI config ops and/or CFG resource structure.
> >>>
> >>>When adding new quirk there are two possibilities:
> >>>1. Override default pci_generic_ecam_ops ops but CFG resource comes
> >>>from MCFG
> >>>{ "OEM_ID", "OEM_TABLE_ID", <REV>, <DOMAIN>, <BUS_NR>, &foo_ops,
> >>>MCFG_RES_EMPTY },
> >>>2. Override default pci_generic_ecam_ops ops and CFG resource. For
> >>>this case
> >>>it is also allowed get CFG resource from quirk entry w/o having it in
> >>>MCFG.
> >>>{ "OEM_ID", "OEM_TABLE_ID", <REV>, <DOMAIN>, <BUS_NR>, &boo_ops,
> >>>   DEFINE_RES_MEM(START, SIZE) },
> >>>
> >>>pci_generic_ecam_ops and MCFG entries will be used for platforms
> >>>free from quirks.
> >>>
> >>>Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> >>>Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> >>>Signed-off-by: Christopher Covington <cov@codeaurora.org>
> >>>---
> >>>  drivers/acpi/pci_mcfg.c | 80
> >>>+++++++++++++++++++++++++++++++++++++++++++++----
> >>>  1 file changed, 74 insertions(+), 6 deletions(-)
> >>>
> >>>diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> >>>index ffcc651..2b8acc7 100644
> >>>--- a/drivers/acpi/pci_mcfg.c
> >>>+++ b/drivers/acpi/pci_mcfg.c
> >>>@@ -32,6 +32,59 @@ struct mcfg_entry {
> >>>      u8            bus_start;
> >>>      u8            bus_end;
> >>>  };
> >>>+struct mcfg_fixup {
> >>>+    char oem_id[ACPI_OEM_ID_SIZE + 1];
> >>>+    char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> >>>+    u32 oem_revision;
> >>>+    u16 seg;
> >>>+    struct resource bus_range;
> >>>+    struct pci_ecam_ops *ops;
> >>>+    struct resource cfgres;
> >>>+};
> >>>+
> >>>+#define MCFG_DOM_ANY            (-1)
> >>>+#define MCFG_BUS_RANGE(start, end)    DEFINE_RES_NAMED((start),    \
> >>>+                        ((end) - (start) + 1),    \
> >>>+                        NULL, IORESOURCE_BUS)
> >>>+#define MCFG_BUS_ANY        MCFG_BUS_RANGE(0x0, 0xff)
> >>>+#define MCFG_RES_EMPTY        DEFINE_RES_NAMED(0, 0, NULL, 0)
> >>>+
> >>>+static struct mcfg_fixup mcfg_quirks[] = {
> >>>+/*    { OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, cfgres, ops }, */
> >>>+};
> >>>+
> >>>+static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> >>>+static char mcfg_oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
> >>>+static u32 mcfg_oem_revision;
> >>>+
> >>>+static void pci_mcfg_match_quirks(struct acpi_pci_root *root,
> >>>+                  struct resource *cfgres,
> >>>+                  struct pci_ecam_ops **ecam_ops)
> >>>+{
> >>>+    struct mcfg_fixup *f;
> >>>+    int i;
> >>>+
> >>>+    /*
> >>>+     * First match against PCI topology <domain:bus> then use OEM ID,
> >>>OEM
> >>>+     * table ID, and OEM revision from MCFG table standard header.
> >>>+     */
> >>>+    for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++,
> >>>f++) {
> >>>+        if (f->seg == root->segment &&
> >>
> >>why not use MCFG_DOM_RANGE, I think MCFG_DOM_RANGE is better.
> >>if drop MCFG_DOM_RANGE, mcfg_quirks[] will be more complex.
> >>
> >>static struct mcfg_fixup mcfg_quirks[] = {
> >>/*    { OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, cfgres, ops }, */
> >>#ifdef CONFIG_PCI_HOST_THUNDER_ECAM
> >>    /* SoC pass1.x */
> >>    { "CAVIUM", "THUNDERX", 2, 0, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
> >>      MCFG_RES_EMPTY},
> >>    { "CAVIUM", "THUNDERX", 2, 1, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
> >>      MCFG_RES_EMPTY},
> >>    { "CAVIUM", "THUNDERX", 2, 2, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
> >>      MCFG_RES_EMPTY},
> >>    { "CAVIUM", "THUNDERX", 2, 3, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
> >>      MCFG_RES_EMPTY},
> >>    { "CAVIUM", "THUNDERX", 2, 10, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
> >>      MCFG_RES_EMPTY},
> >>    { "CAVIUM", "THUNDERX", 2, 11, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
> >>      MCFG_RES_EMPTY},
> >>    { "CAVIUM", "THUNDERX", 2, 12, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
> >>      MCFG_RES_EMPTY},
> >>    { "CAVIUM", "THUNDERX", 2, 13, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
> >>      MCFG_RES_EMPTY},
> >>#endif
> >>.....
> >>};
> >>
> >>As PATCH v5 we only need define mcfg_quirks as below, It looks better.
> >>static struct pci_cfg_fixup mcfg_quirks[] __initconst = {
> >>/*    { OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, pci_ops, init_hook
> >>}, */
> >>#ifdef CONFIG_PCI_HOST_THUNDER_PEM
> >>    /* Pass2.0 */
> >>    { "CAVIUM", "THUNDERX", 1, MCFG_DOM_RANGE(4, 9), MCFG_BUS_ANY, NULL,
> >>      thunder_pem_cfg_init },
> >>    { "CAVIUM", "THUNDERX", 1, MCFG_DOM_RANGE(14, 19), MCFG_BUS_ANY, NULL,
> >>      thunder_pem_cfg_init },
> >>#endif
> >>#ifdef CONFIG_PCI_HISI_ACPI
> >>    { "HISI  ", "HIP05   ", 0, MCFG_DOM_RANGE(0, 3), MCFG_BUS_ANY,
> >>      NULL, hisi_pcie_acpi_hip05_init},
> >>    { "HISI  ", "HIP06   ", 0, MCFG_DOM_RANGE(0, 3), MCFG_BUS_ANY,
> >>      NULL, hisi_pcie_acpi_hip06_init},
> >>    { "HISI  ", "HIP07   ", 0, MCFG_DOM_RANGE(0, 15), MCFG_BUS_ANY,
> >>      NULL, hisi_pcie_acpi_hip07_init},
> >>#endif
> >>};
> >
> >Note this series disallow hisi_pcie_acpi_hip07_init() call. According to the Bjorn suggestion I rework quirk code to override ops and CFG resources only. Giving that I do not see the way to use MCFG_DOM_RANGE macro. For HISI you would need to get CFG range for each possible case:
> >
> >#ifdef CONFIG_PCI_HISI_ACPI
> >     { "HISI  ", "HIP05   ", 0, 0, MCFG_BUS_ANY, &hisi_pcie_ops,
> >       DEFINE_RES_MEM(start0, size0)},
> >     { "HISI  ", "HIP05   ", 0, 1, MCFG_BUS_ANY, &hisi_pcie_ops,
> >       DEFINE_RES_MEM(start1, size1)},
> >     { "HISI  ", "HIP05   ", 0, 2, MCFG_BUS_ANY, &hisi_pcie_ops,
> >       DEFINE_RES_MEM(start2, size2)},
> >     { "HISI  ", "HIP05   ", 0, 3, MCFG_BUS_ANY, &hisi_pcie_ops,
> >       DEFINE_RES_MEM(start3, size3)},
> >[...]
> >#endif
> >
> >Indeed there are more entries here but you do not have to define the same resource array in driver.
> 
> Our host bridge is non ECAM only for the RC bus config space;
> for any other bus underneath the root bus we support ECAM access.
> 
> RC config resource with hardcode as DEFINE_RES_MEM(0xb0070000, SZ_4K),
> EP config resource we get it from MCFG table.
> So we need to override ops, but config resource we only need to hardcode with RC config resource.
> 
> Our host controller ACPI support patch can be found:
> https://lkml.org/lkml/2016/8/31/340
> This patch is based on RFC V5 quirk mechanism.
> 
> Based on V6 quirk mechanism, we have to change it as below:

That's because you are hacking around the quirk mechanism to define
resources that have nothing to do with PCI config regions (that you
ioremap and use to check the PCI link status) and of top of that you are
*still* using the MCFG to describe config regions that are NOT ECAM
compliant, which is the exact opposite of what this patchset is meant
to achieve.

If a config region is not ECAM compliant having it defined in the MCFG
is a firmware bug and the way you are using this patchset is not what
we designed it for, please correct me if I am wrong.

Thanks,
Lorenzo

> 
> #ifdef CONFIG_PCI_HISI_ACPI
> 	{ "HISI ", "HIP05 ", 0, 0, MCFG_BUS_ANY, &hisi_pcie_hip05_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP05 ", 0, 1, MCFG_BUS_ANY, &hisi_pcie_hip05_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP05 ", 0, 2, MCFG_BUS_ANY, &hisi_pcie_hip05_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP05 ", 0, 3, MCFG_BUS_ANY, &hisi_pcie_hip05_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP06 ", 0, 0, MCFG_BUS_ANY, &hisi_pcie_hip06_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP06 ", 0, 1, MCFG_BUS_ANY, &hisi_pcie_hip06_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP06 ", 0, 2, MCFG_BUS_ANY, &hisi_pcie_hip06_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP06 ", 0, 3, MCFG_BUS_ANY, &hisi_pcie_hip06_ops,
>          MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP07 ", 0, 0, MCFG_BUS_ANY, &hisi_pcie_hip07_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP07 ", 0, 1, MCFG_BUS_ANY, &hisi_pcie_hip07_ops,
> 	  MCFG_RES_EMPTY},
> 	....
> 	
> 	{ "HISI ", "HIP07 ", 0, 15, MCFG_BUS_ANY, &hisi_pcie_hip07_ops,
> 	  MCFG_RES_EMPTY},
> 
> #endif
> 
> struct pci_ecam_ops hisi_pci_hip05_ops = {
> 	.bus_shift	= 20,
> 	.init		=  hisi_pci_hip05_init,
> 	.pci_ops	= {
> 		.map_bus	= pci_ecam_map_bus,
> 		.read		= hisi_pcie_acpi_rd_conf,
> 		.write		= hisi_pcie_acpi_wr_conf,
> 	}
> };
> 
> struct pci_ecam_ops hisi_pci_hip06_ops = {
> 	.bus_shift = 20,
> 	.init = hisi_pci_hip06_init,
> 	.pci_ops = {
> 		.map_bus = pci_ecam_map_bus,
> 		.read = hisi_pcie_acpi_rd_conf,
> 		.write = hisi_pcie_acpi_wr_conf,
> 	}
> };
> 
> hisi_pci_hipxx_init function is used to get RC config resource with hardcode.
> .....
> 
> So I hope we can use MCFG_DOM_RANGE, Then I can change it as below.
> 
> #ifdef CONFIG_PCI_HISI_ACPI
> 	{ "HISI  ", "HIP05   ", 0, MCFG_DOM_RANGE(0, 3), MCFG_BUS_ANY,
> 	 &hisi_pcie_hip05_ops, MCFG_RES_EMPTY},
> 	{ "HISI  ", "HIP06   ", 0, MCFG_DOM_RANGE(0, 3), MCFG_BUS_ANY,
> 	 &hisi_pcie_hip06_ops, MCFG_RES_EMPTY},
> 	{ "HISI  ", "HIP07   ", 0, MCFG_DOM_RANGE(0, 15), MCFG_BUS_ANY,
> 	  &hisi_pcie_hip07_ops, MCFG_RES_EMPTY},
> #endif
> 
> Thanks
> Dongdong
> >
> >Thanks,
> >Tomasz
> >
> >.
> >
> 
