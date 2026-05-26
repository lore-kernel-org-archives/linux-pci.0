Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAAD4218B1;
	Tue, 26 May 2026 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819818; cv=none; b=AsFB4XocLBI81TShD2i5RgIsq0kn8Hx+SrZlZuQYtfDQX2TqftvVRMAsAIFFzWXhqyZ+PgUqMOV8AfB7zuDPLQ+7hfDAcbKFs2afiXH1HH7xz6oqD4rPhFIPhNY7oTm7GoohBI1GRm6d2ldxA6QmnPIwmfWNNHfSAhGsWPjkcFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819818; c=relaxed/simple;
	bh=lo/EkcmIHvM1p3W+P8dwKRZqLtSnYdmTVgFEYn997ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=br2dCKZAWsWzf9RRk9k3w2Rgof8qmxyPcXVXLJPmIAqhcJ2lW1sjHGNaUmiAxgPk2Qsux44OLPtd1Lj5QUJhWa0ZY3oCvD+Ztcqw1vjJppWtE3rPWd3I2O7+ku1JVgLhS8B5tYWs3HSkKC00RhnMGRwtadPh+aTUWiCuq+IkmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3881F00A3A;
	Tue, 26 May 2026 18:23:36 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: terry.bowman@amd.com,
	bhelgaas@google.com,
	jic23@kernel.org,
	djbw@kernel.org
Subject: [RFC PATCH 1/2] PCI/CXL: Add RDPAS parsing support
Date: Tue, 26 May 2026 11:23:33 -0700
Message-ID: <20260526182334.1010870-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526182334.1010870-1-dave.jiang@intel.com>
References: <20260526182334.1010870-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add parsing of the RCEC Downstream Port Association Structure (RDPAS),
which is a structure defined in the CXL spec r4.0 9.18.1.5. This
structure allows error handler to locate the downstream port(s)
that report errors to a given Root Complex Event Collector (RCEC).
The structure is part of CXL Early Discovery Table (CEDT) and can
be parsed like other CEDT tables.

A base address is provided in the RDPAS structure where depending on
the protocol field, it is the RCRB base associated with the downstream
port for CXL.io or the Component Base Register base associated with the
downstream port for CXL.cachemem.

The 64bit address of the base address field will be stored in an xarray
indexed by the combination of the RCEC segment plus the BDF in a 32bit
field. Currently only the CXL.io base address will be stored. If the
protocol is CXL.cachemem, there is no way to retrieve a source id and
therefore identifying the BDF of the error device.

A helper is also added to retrieve the base address based on the segment
and BDF of the RCEC.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/acpi.c             |  5 ++
 drivers/pci/pcie/aer_cxl_rch.c | 89 ++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 127537628817..e33cae64def9 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -7,6 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include <linux/node.h>
+#include <cxl/ras.h>
 #include <asm/div64.h>
 #include "cxlpci.h"
 #include "cxl.h"
@@ -933,6 +934,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return -ENXIO;
 
+	rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_RDPAS, cxl_parse_rdpas, host);
+	if (rc < 0)
+		dev_dbg(host, "No RDPAS entries found or failed to parse\n");
+
 	rc = add_cxl_resources(cxl_res);
 	if (rc)
 		return rc;
diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index 83142eac0cab..37bbecf495af 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -4,9 +4,98 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/bitfield.h>
+#include <linux/acpi.h>
+#include <cxl/ras.h>
 #include "../pci.h"
 #include "portdrv.h"
 
+enum cxl_rdpas_protocol {
+	CXL_RDPAS_PROTO_IO = 0,
+	CXL_RDPAS_PROTO_CACHEMEM = 1
+};
+
+static DEFINE_XARRAY(cxl_rdpas);
+
+/*
+ * CXL r4.0 9.18.1.5 Table 9-24. The segment and the BDF belongs to the RCEC */
+static unsigned long __rdpas_index(u16 segment, u16 bdf)
+{
+	return FIELD_PREP(GENMASK(31, 16), segment) |
+	       FIELD_PREP(GENMASK(15, 0), bdf);
+}
+
+static unsigned long rdpas_index(u16 segment, u8 bus, u8 device, u8 function)
+{
+	return __rdpas_index(segment,
+			     FIELD_PREP(GENMASK(15, 8), bus) |
+			     FIELD_PREP(GENMASK(7, 3), device) |
+			     FIELD_PREP(GENMASK(2, 0), function));
+}
+
+static int __cxl_parse_rdpas(struct acpi_cedt_rdpas *rdpas, struct device *dev)
+{
+	unsigned long index;
+	int rc;
+
+	/* Skip CXL.cachemem as the current RDPAS scheme only supports CXL.io */
+	if (rdpas->protocol != CXL_RDPAS_PROTO_IO)
+		return 0;
+
+	u64 *addr __free(kfree) = kzalloc(sizeof(*addr), GFP_KERNEL);
+	if (!addr)
+		return -ENOMEM;
+
+	*addr = rdpas->address;
+
+	index = __rdpas_index(rdpas->segment, rdpas->bdf);
+	rc = xa_insert(&cxl_rdpas, index, addr, GFP_KERNEL);
+	if (rc) {
+		if (rc != -EBUSY)
+			return rc;
+
+		dev_dbg(dev, "Duplicate RDPAS: PCI %04x:%02lx:%02lx.%ld\n",
+			rdpas->segment, FIELD_GET(GENMASK(15, 8), rdpas->bdf),
+			FIELD_GET(GENMASK(7, 3), rdpas->bdf),
+			FIELD_GET(GENMASK(2, 0), rdpas->bdf));
+		return 0;
+	}
+
+	retain_and_null_ptr(addr);
+	dev_dbg(dev, "RDPAS entry: PCI %04x:%02lx:%02lx.%ld -> CXL addr %016llx\n",
+		rdpas->segment, FIELD_GET(GENMASK(15, 8), rdpas->bdf),
+		FIELD_GET(GENMASK(7, 3), rdpas->bdf),
+		FIELD_GET(GENMASK(2, 0), rdpas->bdf),
+		rdpas->address);
+
+	return 0;
+}
+
+int cxl_parse_rdpas(union acpi_subtable_headers *header, void *arg,
+		    const unsigned long end)
+{
+	struct acpi_cedt_rdpas *rdpas = (struct acpi_cedt_rdpas *)header;
+	struct device *dev = arg;
+
+	return __cxl_parse_rdpas(rdpas, dev);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_parse_rdpas, "cxl_acpi");
+
+static int __maybe_unused cxl_get_rdpas_by_rcec(struct pci_dev *rcec, u64 *dsp_addr)
+{
+	u64 index;
+	u64 *addr;
+
+	index = rdpas_index(pci_domain_nr(rcec->bus), rcec->bus->number,
+			    PCI_SLOT(rcec->devfn), PCI_FUNC(rcec->devfn));
+	addr = xa_load(&cxl_rdpas, index);
+	if (!addr)
+		return -ENOENT;
+
+	*dsp_addr = *addr;
+
+	return 0;
+}
+
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
-- 
2.54.0

