Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED774349CF0
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585340; cv=none; b=bUQTkvkgiZU4CXKgKuYE48Ov+UNSO+0G5hwYsJdZapRPh/hWiX5i2FCb2C6zfocyQ+lMyu2uXRDN19zMfmIMxt2kpS5Xf06NsuYSDDutOZ+BguHnu/uiR/7fPjg6edWu4YTRSidwAtwGoUMRUUjTuNYdGjFcDxwUqnNhbKVbfb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585340; c=relaxed/simple;
	bh=kJuxLZf86ZqSbpShflnMOB+ctfigqiv/tAU0BzdYWQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpTvkagYZvVGRmDuxo2f5N7A41TeUWphJX4p5NmcZ6oZ9Jfh0OdpcQiHEzX5+ZunFhv1Wh/zEeXC19ckt0qLeCjj5NmpxrBKHTa/Hu5cSGO1umLj6wrMssa4FuReR7n/2IeLyotCamjDImuve5LpLk6TbBZCs41kwOsUOv8rZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZE4L28Je; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE4L28Je"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf114b0cf9so6904075ad.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585336; x=1781190136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAIcBy7MNrXi3sYH0OZZ5XdCzjkRdcl8LnKIR3KqnsI=;
        b=ZE4L28JeEt98ayHhij68xyrTIzSZADSXw1H78H6XACnfN77KfmASyYpxz2i85zv9eH
         K207HApcjkHCgDJxr4+IUBcTIBUhSrdP2W/zkFjUq7dKzoBycAaimboEPaS89J9TdRsa
         pnA9eejyCG4KcNZzvholQGeuf0+E/aNgWeqgOIVW5o3E7H+AVohWONaO3VRSscq3zFh9
         w/MJjXaLU8PpKIi6eFq7oXkrAsvUDrJhyKbvkFt2E+4ndmK0KMye1xAfRD8S5kSZ1tgk
         UYzFW+tYMCIUhP2402jLKirvBZuB5B3RFQ+f9wXQ3smTpAc0Pg4m90m8avyHJk54HAFD
         vBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585336; x=1781190136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAIcBy7MNrXi3sYH0OZZ5XdCzjkRdcl8LnKIR3KqnsI=;
        b=CKfo/+vr6txYGnzeJjfN820zi61OIYJI4qnoxg0D37TJg1LN56S+NL1dk4P1elKk+E
         5mGkXEKqJ2/cTyABMIFnC5k+5V6vQfsQZZCG98K+a+XxZT9SjbZzzw7gLHxIIlZdfO4U
         XX7irAzFwv2cT/MV5CZiUHiV222wW5UKay2jaGtKRkHCtuvh4jPso7Z8jBFykRcz/s42
         yhzYYHvvDgJxmRhHUwGt2wj2CtraKNVD4hPwsHXEV7h1MelbRUdXW/NZ4Dfvmdld1K66
         We6v+9O7LSCwSbFCkBfn3qj8hNG2Ee8m9M4vdyYtai+5zsmyavzsVsbtNUUJyZwXpIln
         yYXg==
X-Gm-Message-State: AOJu0Yz6q83W/+3lAI2QQypfk1RseeBQ7s2YcVUW7226wq0NGX9MY4eG
	/PqEPPkvOXkdXIliuakLRNlB8GKtWbQBjcgWX3qxY4KI1SnlB7cg+SF0
X-Gm-Gg: Acq92OHFjyseAeDR7x75MYWdxLd5dFh6UQ6QG7QoVJ1asz53sG1B9llNU8DMfdXcBp6
	gAlQq/4uyIGTjRg7aMzBmsSyK6ByWmaVx8A8w72mnRRVjwJrqP4LDJOMXBDkgHtWCPIEm2u3DGF
	BH37vyUTMmDEHuLm6K/TJllNWKgJSZTgXOWIef7vpY/Y+Uql2QXdpb/AsRKtTW2h4L+l9MySR46
	dwvRVJYaWDLTGDm6Nj0y/8fpzrP5jreEAk/G0aCCR+G0vsvDxf0Ix4xURQLf3iegNq5hdhhq+Or
	IGUUUELhoeEuhLI5tFztYZ1KHmT8u6FRPS8aSWcQXIih9gnDlSJuxSf0llb1ikpK5NH7Gfugmkw
	uQg3lQeaMsFQ4znCL68C5NVAXLZKt47wEtomVT1QRJORHkQ3mZij+YdPoBiLrWo1V63ejXdeLG7
	8Hsj2YWWY3YO/ft/TV7RzNPl42bY11tgw9iXtAEJI=
X-Received: by 2002:a17:903:3c45:b0:2c0:bb2d:a30b with SMTP id d9443c01a7336-2c1644ae17fmr84740035ad.32.1780585333563;
        Thu, 04 Jun 2026 08:02:13 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e05fsm64303575ad.54.2026.06.04.08.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:13 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 11/12] PCI: Initialize and release SIOV capability
Date: Thu,  4 Jun 2026 08:01:52 -0700
Message-ID: <20260604150153.3619662-12-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dimitri Daskalakis <daskald@meta.com>

Modify pci_init_capabilities() to discover the SIOV extended capability
(cap ID 0x38). When present, allocate struct pci_siov that records the
capability position, total SDI count, routing ID offset and stride, and
the maximum bus range the SDIs can span.

The init path mirrors sriov_init(): read the capability registers,
compute the worst-case bus consumption from total_SDIs, and stash the
result in the PF's pci_dev. Release frees the structure on teardown.

If is_physfn was already set (by sriov_init), it will not be cleared if
siov_init() fails. This prevents clobbering the flag for devices that
enable both virtualization types.

The SR-IOV code does not unset the is_physfn bit of a pci device
when disabled, and the SIOV code follows that pattern.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/Makefile |   1 +
 drivers/pci/pci.h    |  16 ++++++
 drivers/pci/probe.c  |   2 +
 drivers/pci/siov.c   | 113 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 drivers/pci/siov.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..a584cd1bf08a 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_PCI_ATS)		+= ats.o
 obj-$(CONFIG_PCI_IOV)		+= iov.o
+obj-$(CONFIG_PCI_SIOV)		+= siov.o
 obj-$(CONFIG_PCI_BRIDGE_EMUL)	+= pci-bridge-emul.o
 obj-$(CONFIG_PCI_LABEL)		+= pci-label.o
 obj-$(CONFIG_X86_INTEL_MID)	+= pci-mid.o
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd7c04e26c16..a516db996aab 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1042,6 +1042,22 @@ static inline u16 pci_virtfn_routing_id(struct pci_dev *pf, u16 offset,
 }
 #endif
 
+#ifdef CONFIG_PCI_SIOV
+int pci_siov_init(struct pci_dev *dev);
+void pci_siov_release(struct pci_dev *dev);
+int pci_siov_bus_range(struct pci_bus *bus);
+#else
+static inline int pci_siov_init(struct pci_dev *dev)
+{
+	return -ENODEV;
+}
+static inline void pci_siov_release(struct pci_dev *dev) { }
+static inline int pci_siov_bus_range(struct pci_bus *bus)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_PCIE_TPH
 void pci_restore_tph_state(struct pci_dev *dev);
 void pci_save_tph_state(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..bebc32c8d374 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2473,6 +2473,7 @@ static void pci_release_capabilities(struct pci_dev *dev)
 	pci_aer_exit(dev);
 	pci_rcec_exit(dev);
 	pci_iov_release(dev);
+	pci_siov_release(dev);
 	pci_free_cap_save_buffers(dev);
 }
 
@@ -2666,6 +2667,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_vpd_init(dev);		/* Vital Product Data */
 	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */
 	pci_iov_init(dev);		/* Single Root I/O Virtualization */
+	pci_siov_init(dev);		/* Scalable I/O Virtualization */
 	pci_ats_init(dev);		/* Address Translation Services */
 	pci_pri_init(dev);		/* Page Request Interface */
 	pci_pasid_init(dev);		/* Process Address Space ID */
diff --git a/drivers/pci/siov.c b/drivers/pci/siov.c
new file mode 100644
index 000000000000..7372ce95714b
--- /dev/null
+++ b/drivers/pci/siov.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Express Scalable I/O Virtualization (SIOV) support
+ */
+
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/export.h>
+#include "pci.h"
+
+static int pci_siov_sdi_bus(struct pci_dev *dev, int sdi_id)
+{
+	if (!dev->siov)
+		return -EINVAL;
+	return pci_virtfn_routing_id(dev, dev->siov->offset,
+				  dev->siov->stride, sdi_id) >> 8;
+}
+
+static int compute_max_sdi_buses(struct pci_dev *dev)
+{
+	struct pci_siov *siov = dev->siov;
+
+	if (!siov->offset || (siov->total_SDIs > 1 && !siov->stride))
+		return -EIO;
+
+	siov->max_SDI_buses = pci_siov_sdi_bus(dev, siov->total_SDIs - 1);
+	return 0;
+}
+
+static int siov_init(struct pci_dev *dev, int pos)
+{
+	struct pci_siov *siov;
+	bool was_physfn;
+	u16 total;
+	u8 status;
+	int rc;
+
+	pci_read_config_byte(dev, pos + PCI_SIOV_STATUS, &status);
+	if (status & PCI_SIOV_STATUS_ENABLED)
+		pci_warn(dev, "SIOV: SDIs active at init, FLR may be required\n");
+
+	pci_read_config_word(dev, pos + PCI_SIOV_TOTAL_SDI, &total);
+	if (!total)
+		return 0;
+
+	siov = kzalloc_obj(*siov);
+	if (!siov)
+		return -ENOMEM;
+
+	siov->pos = pos;
+	siov->total_SDIs = total;
+	siov->driver_max_SDIs = total;
+	siov->self = dev;
+	pci_read_config_dword(dev, pos + PCI_SIOV_CAP, &siov->cap);
+	pci_read_config_word(dev, pos + PCI_SIOV_SDI_OFFSET, &siov->offset);
+	pci_read_config_word(dev, pos + PCI_SIOV_SDI_STRIDE, &siov->stride);
+
+	was_physfn = dev->is_physfn;
+
+	dev->siov = siov;
+	dev->is_physfn = 1;
+	dev->is_siov = 1;
+	rc = compute_max_sdi_buses(dev);
+	if (rc) {
+		dev->siov = NULL;
+		dev->is_siov = 0;
+		if (!was_physfn)
+			dev->is_physfn = 0;
+		kfree(siov);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void siov_release(struct pci_dev *dev)
+{
+	WARN_ON_ONCE(dev->siov->num_SDIs);
+
+	kfree(dev->siov);
+	dev->siov = NULL;
+	dev->is_siov = 0;
+}
+
+/**
+ * pci_siov_init - initialize the Scalable IOV capability
+ * @dev: the PCI device
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int pci_siov_init(struct pci_dev *dev)
+{
+	int pos;
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SIOV);
+	if (pos)
+		return siov_init(dev, pos);
+
+	return -ENODEV;
+}
+
+/**
+ * pci_siov_release - release resources used by the SIOV capability
+ * @dev: the PCI device
+ */
+void pci_siov_release(struct pci_dev *dev)
+{
+	if (dev->siov)
+		siov_release(dev);
+}
-- 
2.52.0

