Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org,
	jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	dhdang@apm.com,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	cov@codeaurora.org,
	gabriele.paoloni@huawei.com,
	jhugo@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH v4 4/5] ARM64/PCI: Start using quirks handling for ACPI based PCI host controller
Date: Tue, 28 Jun 2016 09:54:01 +0200
Message-Id: <1467100442-28078-5-git-send-email-tn@semihalf.com>
In-Reply-To: <1467100442-28078-1-git-send-email-tn@semihalf.com>
References: <1467100442-28078-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Since there are platforms which have non-compliant ECAM space we need to
override these accessors prior to PCI buses enumeration. In order to do
that we call pci_mcfg_match_quirks() to retrieve custom
pci_config_window structure. If no correlated quirk on list, use
fully ECAM compliant generic PCI config accessors.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/kernel/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index addf00c..ef142b8 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -152,8 +152,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (!ri)
 		return NULL;
 
-	ri->cfg = pci_acpi_setup_ecam_mapping(root,
-					      &pci_generic_ecam_ops.pci_ops);
+	ri->cfg = pci_mcfg_match_quirks(root);
 	if (!ri->cfg) {
 		kfree(ri);
 		return NULL;
-- 
1.9.1
