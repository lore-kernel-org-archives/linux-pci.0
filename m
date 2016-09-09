Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: arnd@arndb.de,
	hanjun.guo@linaro.org,
	okaya@codeaurora.org,
	jchandra@broadcom.com,
	cov@codeaurora.org,
	dhdang@apm.com,
	ard.biesheuvel@linaro.org,
	robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	gabriele.paoloni@huawei.com,
	jhugo@codeaurora.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V6 5/5] PCI: thunder: Enable ACPI PCI controller for ThunderX pass1.x silicon version
Date: Fri,  9 Sep 2016 21:24:07 +0200
Message-Id: <1473449047-10499-6-git-send-email-tn@semihalf.com>
In-Reply-To: <1473449047-10499-1-git-send-email-tn@semihalf.com>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

ThunderX pass1.x requires to emulate the EA headers for on-chip devices
hence it has to use custom pci_thunder_ecam_ops for accessing PCI config
space (pci-thuner-ecam.c). Add new entries to MCFG quirk array where they
can be applied while probing ACPI based PCI host controller.

ThunderX pass1.x is using the same way for accessing off-chip devices
(so-called PEM) as silicon pass-2.x so we need to add PEM quirk
entries too.

Quirk is considered for ThunderX silicon pass1.x only which is identified
via MCFG revision 2.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/pci_mcfg.c             | 45 +++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pci-thunder-ecam.c |  2 +-
 include/linux/pci-ecam.h            |  3 +++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 1f73d7b..eb14f74 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -77,6 +77,51 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	  DEFINE_RES_MEM(0x994057000000UL, 0x39 * SZ_16M) },
 	{ "CAVIUM", "THUNDERX", 1, 19, MCFG_BUS_ANY, &pci_thunder_pem_ops,
 	  DEFINE_RES_MEM(0x99808f000000UL, 0x39 * SZ_16M) },
+
+	/* SoC pass1.x */
+	{ "CAVIUM", "THUNDERX", 2, 4, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x88001f000000UL, 0x39 * SZ_16M) },
+	{ "CAVIUM", "THUNDERX", 2, 5, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x884057000000UL, 0x39 * SZ_16M) },
+	{ "CAVIUM", "THUNDERX", 2, 6, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x88808f000000UL, 0x39 * SZ_16M) },
+	{ "CAVIUM", "THUNDERX", 2, 7, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x89001f000000UL, 0x39 * SZ_16M) },
+	{ "CAVIUM", "THUNDERX", 2, 8, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x894057000000UL, 0x39 * SZ_16M) },
+	{ "CAVIUM", "THUNDERX", 2, 9, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x89808f000000UL, 0x39 * SZ_16M) },
+	{ "CAVIUM", "THUNDERX", 2, 14, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x98001f000000UL, 0x39 * SZ_16M) },
+	{ "CAVIUM", "THUNDERX", 2, 15, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x984057000000UL, 0x39 * SZ_16M) },
+	{ "CAVIUM", "THUNDERX", 2, 16, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x98808f000000UL, 0x39 * SZ_16M) },
+	{ "CAVIUM", "THUNDERX", 2, 17, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x99001f000000UL, 0x39 * SZ_16M) },
+	{ "CAVIUM", "THUNDERX", 2, 18, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x994057000000UL, 0x39 * SZ_16M) },
+	{ "CAVIUM", "THUNDERX", 2, 19, MCFG_BUS_ANY, &pci_thunder_pem_ops,
+	  DEFINE_RES_MEM(0x99808f000000UL, 0x39 * SZ_16M) },
+#endif
+#ifdef CONFIG_PCI_HOST_THUNDER_ECAM
+	/* SoC pass1.x */
+	{ "CAVIUM", "THUNDERX", 2, 0, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
+	  MCFG_RES_EMPTY},
+	{ "CAVIUM", "THUNDERX", 2, 1, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
+	  MCFG_RES_EMPTY},
+	{ "CAVIUM", "THUNDERX", 2, 2, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
+	  MCFG_RES_EMPTY},
+	{ "CAVIUM", "THUNDERX", 2, 3, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
+	  MCFG_RES_EMPTY},
+	{ "CAVIUM", "THUNDERX", 2, 10, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
+	  MCFG_RES_EMPTY},
+	{ "CAVIUM", "THUNDERX", 2, 11, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
+	  MCFG_RES_EMPTY},
+	{ "CAVIUM", "THUNDERX", 2, 12, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
+	  MCFG_RES_EMPTY},
+	{ "CAVIUM", "THUNDERX", 2, 13, MCFG_BUS_ANY, &pci_thunder_ecam_ops,
+	  MCFG_RES_EMPTY},
 #endif
 };
 
diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/host/pci-thunder-ecam.c
index d50a3dc..b6c17e2 100644
--- a/drivers/pci/host/pci-thunder-ecam.c
+++ b/drivers/pci/host/pci-thunder-ecam.c
@@ -346,7 +346,7 @@ static int thunder_ecam_config_write(struct pci_bus *bus, unsigned int devfn,
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
-static struct pci_ecam_ops pci_thunder_ecam_ops = {
+struct pci_ecam_ops pci_thunder_ecam_ops = {
 	.bus_shift	= 20,
 	.pci_ops	= {
 		.map_bus        = pci_ecam_map_bus,
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 65505ea..35f0e81 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -62,6 +62,9 @@ extern struct pci_ecam_ops pci_generic_ecam_ops;
 #ifdef CONFIG_PCI_HOST_THUNDER_PEM
 extern struct pci_ecam_ops pci_thunder_pem_ops;
 #endif
+#ifdef CONFIG_PCI_HOST_THUNDER_ECAM
+extern struct pci_ecam_ops pci_thunder_ecam_ops;
+#endif
 
 #ifdef CONFIG_PCI_HOST_GENERIC
 /* for DT-based PCI controllers that support ECAM */
-- 
1.9.1
