Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 20 Sep 2016 14:26:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
        Lorenzo.Pieralisi@arm.com, arnd@arndb.de, hanjun.guo@linaro.org,
        okaya@codeaurora.org, jchandra@broadcom.com, cov@codeaurora.org,
        dhdang@apm.com, ard.biesheuvel@linaro.org,
        robert.richter@caviumnetworks.com, mw@semihalf.com,
        Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
        wangyijing@huawei.com, msalter@redhat.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, jcm@redhat.com,
        andrea.gallo@linaro.org, jeremy.linton@arm.com,
        liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
        jhugo@codeaurora.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 0/5] ECAM quirks handling for ARM64 platforms
Message-ID: <20160920192636.GB4941@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473449047-10499-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 09, 2016 at 09:24:02PM +0200, Tomasz Nowicki wrote:
> Quirk handling relies on an idea of simple static array which contains
> quirk enties. Each entry consists of identification information (IDs from
> standard header of MCFG table) along with custom pci_ecam_ops structure and 
> configuration space resource structure. This way it is possible find
> corresponding quirk entries and override pci_ecam_ops and PCI configuration
> space regions.
> 
> As an example, the last 3 patches present quirk handling mechanism usage for
> ThunderX.
> 
> v5 -> v6
> - rebase against v4.8-rc5
> - drop patch 1 form previous series
> - keep pci_acpi_setup_ecam_mapping() in ARM64 arch directory
> - move quirk code to pci_mcfg.c
> - restrict quirk to override pci_ecam_ops and CFG resource structure
>   only, no init call any more
> - split ThunderX quirks into the smaller chunks
> - add ThunderX pass1.x silicon revision support
> 
> v4 -> v5
> - rebase against v4.8-rc1
> - rework to exact MCFG OEM ID, TABLE ID, rev match
>   - use memcmp instead of strncmp
>   - no substring match
> - fix typos and dmesg message
> 
> Tomasz Nowicki (5):
>   PCI/ACPI: Extend pci_mcfg_lookup() responsibilities
>   PCI/ACPI: Check platform specific ECAM quirks
>   PCI: thunder-pem: Allow to probe PEM-specific register range for ACPI
>     case
>   PCI: thunder: Enable ACPI PCI controller for ThunderX pass2.x silicon
>     version
>   PCI: thunder: Enable ACPI PCI controller for ThunderX pass1.x silicon
>     version
> 
>  arch/arm64/kernel/pci.c             |  17 ++--
>  drivers/acpi/pci_mcfg.c             | 168 +++++++++++++++++++++++++++++++++++-
>  drivers/pci/host/pci-thunder-ecam.c |   2 +-
>  drivers/pci/host/pci-thunder-pem.c  |  63 +++++++++++---
>  include/linux/pci-acpi.h            |   4 +-
>  include/linux/pci-ecam.h            |   7 ++
>  6 files changed, 230 insertions(+), 31 deletions(-)

I'm not quite ready to merge these because we haven't resolved the
question of how to expose the resources used by the memory-mapped
config space.  I'm fine with the first two patches (I did make a
couple trivial changes, see below), but there's no point in merging
them until we merge a user for them.

I pushed the series to pci/ecam-v6 for build testing and discussion.
The diff (the changes I made locally) from v6 as posted by Tomasz is
below.

Bjorn


diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index eb14f74..bb3b8ad 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -42,86 +42,59 @@ struct mcfg_fixup {
 	struct resource cfgres;
 };
 
-#define MCFG_DOM_ANY			(-1)
 #define MCFG_BUS_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
 						((end) - (start) + 1),	\
 						NULL, IORESOURCE_BUS)
-#define MCFG_BUS_ANY		MCFG_BUS_RANGE(0x0, 0xff)
-#define MCFG_RES_EMPTY		DEFINE_RES_NAMED(0, 0, NULL, 0)
+#define MCFG_BUS_ANY			MCFG_BUS_RANGE(0x0, 0xff)
 
 static struct mcfg_fixup mcfg_quirks[] = {
-/*	{ OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, cfgres, ops }, */
+/*	{ OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, cfgres, ops }, */
 #ifdef CONFIG_PCI_HOST_THUNDER_PEM
+#define THUNDER_PEM_MCFG(rev, seg, addr) 				\
+	{ "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,			\
+	  &pci_thunder_pem_ops, DEFINE_RES_MEM(addr, 0x39 * SZ_16M) }
+
 	/* SoC pass2.x */
-	{ "CAVIUM", "THUNDERX", 1, 4, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x88001f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 1, 5, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x884057000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 1, 6, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x88808f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 1, 7, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x89001f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 1, 8, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x894057000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 1, 9, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x89808f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 1, 14, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x98001f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 1, 15, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x984057000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 1, 16, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x98808f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 1, 17, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x99001f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 1, 18, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x994057000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 1, 19, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x99808f000000UL, 0x39 * SZ_16M) },
+	THUNDER_PEM_MCFG(1,  4, 0x88001f000000UL),
+	THUNDER_PEM_MCFG(1,  5, 0x884057000000UL),
+	THUNDER_PEM_MCFG(1,  6, 0x88808f000000UL),
+	THUNDER_PEM_MCFG(1,  7, 0x89001f000000UL),
+	THUNDER_PEM_MCFG(1,  8, 0x894057000000UL),
+	THUNDER_PEM_MCFG(1,  9, 0x89808f000000UL),
+	THUNDER_PEM_MCFG(1, 14, 0x98001f000000UL),
+	THUNDER_PEM_MCFG(1, 15, 0x984057000000UL),
+	THUNDER_PEM_MCFG(1, 16, 0x98808f000000UL),
+	THUNDER_PEM_MCFG(1, 17, 0x99001f000000UL),
+	THUNDER_PEM_MCFG(1, 18, 0x994057000000UL),
+	THUNDER_PEM_MCFG(1, 19, 0x99808f000000UL),
 
 	/* SoC pass1.x */
-	{ "CAVIUM", "THUNDERX", 2, 4, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x88001f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 2, 5, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x884057000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 2, 6, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x88808f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 2, 7, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x89001f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 2, 8, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x894057000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 2, 9, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x89808f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 2, 14, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x98001f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 2, 15, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x984057000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 2, 16, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x98808f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 2, 17, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x99001f000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 2, 18, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x994057000000UL, 0x39 * SZ_16M) },
-	{ "CAVIUM", "THUNDERX", 2, 19, MCFG_BUS_ANY, &pci_thunder_pem_ops,
-	  DEFINE_RES_MEM(0x99808f000000UL, 0x39 * SZ_16M) },
+	THUNDER_PEM_MCFG(2,  4, 0x88001f000000UL),
+	THUNDER_PEM_MCFG(2,  5, 0x884057000000UL),
+	THUNDER_PEM_MCFG(2,  6, 0x88808f000000UL),
+	THUNDER_PEM_MCFG(2,  7, 0x89001f000000UL),
+	THUNDER_PEM_MCFG(2,  8, 0x894057000000UL),
+	THUNDER_PEM_MCFG(2,  9, 0x89808f000000UL),
+	THUNDER_PEM_MCFG(2, 14, 0x98001f000000UL),
+	THUNDER_PEM_MCFG(2, 15, 0x984057000000UL),
+	THUNDER_PEM_MCFG(2, 16, 0x98808f000000UL),
+	THUNDER_PEM_MCFG(2, 17, 0x99001f000000UL),
+	THUNDER_PEM_MCFG(2, 18, 0x994057000000UL),
+	THUNDER_PEM_MCFG(2, 19, 0x99808f000000UL),
 #endif
 #ifdef CONFIG_PCI_HOST_THUNDER_ECAM
+#define THUNDER_ECAM_MCFG(rev, seg) 					\
+	{ "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY, &pci_thunder_ecam_ops }
+
 	/* SoC pass1.x */
-	{ "CAVIUM", "THUNDERX", 2, 0, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
-	  MCFG_RES_EMPTY},
-	{ "CAVIUM", "THUNDERX", 2, 1, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
-	  MCFG_RES_EMPTY},
-	{ "CAVIUM", "THUNDERX", 2, 2, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
-	  MCFG_RES_EMPTY},
-	{ "CAVIUM", "THUNDERX", 2, 3, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
-	  MCFG_RES_EMPTY},
-	{ "CAVIUM", "THUNDERX", 2, 10, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
-	  MCFG_RES_EMPTY},
-	{ "CAVIUM", "THUNDERX", 2, 11, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
-	  MCFG_RES_EMPTY},
-	{ "CAVIUM", "THUNDERX", 2, 12, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
-	  MCFG_RES_EMPTY},
-	{ "CAVIUM", "THUNDERX", 2, 13, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
-	  MCFG_RES_EMPTY},
+	THUNDER_ECAM_MCFG(2,  0),
+	THUNDER_ECAM_MCFG(2,  1),
+	THUNDER_ECAM_MCFG(2,  2),
+	THUNDER_ECAM_MCFG(2,  3),
+	THUNDER_ECAM_MCFG(2, 10),
+	THUNDER_ECAM_MCFG(2, 11),
+	THUNDER_ECAM_MCFG(2, 12),
+	THUNDER_ECAM_MCFG(2, 13),
 #endif
 };
 
@@ -141,12 +114,12 @@ static void pci_mcfg_match_quirks(struct acpi_pci_root *root,
 	 * table ID, and OEM revision from MCFG table standard header.
 	 */
 	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
-		if (f->seg == root->segment &&
-		    resource_contains(&f->bus_range, &root->secondary) &&
-		    !memcmp(f->oem_id, mcfg_oem_id, ACPI_OEM_ID_SIZE) &&
+		if (!memcmp(f->oem_id, mcfg_oem_id, ACPI_OEM_ID_SIZE) &&
 		    !memcmp(f->oem_table_id, mcfg_oem_table_id,
 		            ACPI_OEM_TABLE_ID_SIZE) &&
-		    f->oem_revision == mcfg_oem_revision) {
+		    f->oem_revision == mcfg_oem_revision &&
+		    f->seg == root->segment &&
+		    resource_contains(&f->bus_range, &root->secondary)) {
 			if (f->cfgres.start)
 				*cfgres = f->cfgres;
 			if (f->ops)
@@ -195,10 +168,10 @@ skip_lookup:
 	}
 
 	/*
-	 * Let to override default ECAM ops and CFG resource range.
-	 * Also, this might even retrieve CFG resource range in case MCFG
-	 * does not have it. Invalid CFG start address means MCFG firmware bug
-	 * or we need another quirk in array.
+	 * Allow quirks to override default ECAM ops and CFG resource
+	 * range.  This may even fabricate a CFG resource range in case
+	 * MCFG does not have it.  Invalid CFG start address means MCFG
+	 * firmware bug or we need another quirk in array.
 	 */
 	pci_mcfg_match_quirks(root, &res, &ops);
 	if (!res.start)
@@ -239,7 +212,7 @@ static __init int pci_mcfg_parse(struct acpi_table_header *header)
 	/* Save MCFG IDs and revision for quirks matching */
 	memcpy(mcfg_oem_id, header->oem_id, ACPI_OEM_ID_SIZE);
 	memcpy(mcfg_oem_table_id, header->oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
-	mcfg_oem_revision = header->revision;
+	mcfg_oem_revision = header->oem_revision;
 
 	pr_info("MCFG table detected, %d entries\n", n);
 	return 0;
