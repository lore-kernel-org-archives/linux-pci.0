Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809023;
	b=HdRwNUABDee8esFJGQlruH2ShVZLTPSuXmizISeaSiHdaF2ATL4djMbOnPHgRy0Azbd0
	 ndX0xqNTCSmpfKgjDRewKfrLz8Ec2dJW7ldICjNG3jlilABxZ0vQiFtyp5jeaUMTHthwN
	 L20w+Opb5s0356fQcVWcbSzWEgRAYD0sgVbdm6uccOx0bbbEYvlqmNphQ4E6XztcXd3ea
	 ZfNRfruOia+JAKRalI1Z/0zFMDh3t1YZnqswO/lgf5L2qmgCLrWPfX+7yBA5U6HpIR2UV
	 UWcSisLiu4siF6DX+aEqNonNsvGJe+UwmDCv9zJ/3yhy+pFEGo2IjGzMyt/xKBj4WGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809023;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VC0kuAI8YTTP8xqxIGPPjehsRscbtuqmLo3CRUhyHGY=;
	b=CAZYzAS9e1WRqyVsUgPECbwXF+LiICQEk9YTQl0xYzCfSyhD985Urh8OBq06HP18L3eX
	 9TLsAu4/xwFqp5zOm2QNwjbabhqoshhnM8AVHOXd8yk/ZPl0cqfqmoO4Kb+UgouNQ7tkj
	 4C/nMfRSzuyT0jrAXlQHipBf3vTRMGuWdLDXyXCh0+2Da3tLb+7HWXy1x48bQf4bXKoQU
	 2ui/GQAQv6kQmmeF3FGwubKt+LKjlTfhfge0phEqEw++3la9dTIMwPyQqLbdnamWMLcQW
	 FBQfbRh1Vi0NBGKEoTZApuxWhmkXoRwPyAfQ54t9Oee3JMzWEcsvFg5ys5nRNk8QxDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6PfgsQi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72255606A32E;
	Wed,  4 Nov 2026 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6PfgsQi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109AD1F00919;
	Wed,  4 Nov 2026 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809023;
	bh=VC0kuAI8YTTP8xqxIGPPjehsRscbtuqmLo3CRUhyHGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G6PfgsQitDZ1twMbvHRuDjOQSiduhDAjzyHbaIUOA6txxiAu2D1QHpHqF0/SkSCSc
	 sEoUEK79ryNJpGzvRuao/UGmwpcO7/Lf+tJTzvwJFZ59Ltkqe7WTpIj2vI6SbEjcTf
	 gEsWQ6vV3YdSU+TpI3tPB2WQmGTxR14A6bHR5wZdepMyI4ffpQoUsnjEsghEou0lBI
	 lhjNM2aE0+/Rq9F3VITQHpiDvyea+t8LHJ5lxExc+TfbmvQP7q/6ZqdSH2jcQbex8W
	 MZmP+pS0wOCrYFfo4B8d5v9Lt6HFsyzBrHrXD/OvjVVvAUk6qg6TimK4glFad8+ebP
	 pMer4fiajWMXg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v8 01/15] PCI/TSM: Move core code into its own directory
Date: Wed,  4 Nov 2026 21:46:18 +0530
Message-ID: <20261104161632.3547423-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple patch series modify drivers/pci/tsm.c, and some add new files
to the PCI/TSM subsystem. Move tsm.c to tsm/core.c so these series can
share the directory layout and reduce merge conflicts.

Update the build rules, local header include, and MAINTAINERS entry for
the new location.

No functional change.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 Documentation/driver-api/pci/tsm.rst | 2 +-
 MAINTAINERS                          | 2 +-
 drivers/pci/Makefile                 | 2 +-
 drivers/pci/tsm/Makefile             | 7 +++++++
 drivers/pci/{tsm.c => tsm/core.c}    | 2 +-
 5 files changed, 11 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/tsm/Makefile
 rename drivers/pci/{tsm.c => tsm/core.c} (99%)

diff --git a/Documentation/driver-api/pci/tsm.rst b/Documentation/driver-api/pci/tsm.rst
index 232b92bec93f..c95c513019b5 100644
--- a/Documentation/driver-api/pci/tsm.rst
+++ b/Documentation/driver-api/pci/tsm.rst
@@ -17,5 +17,5 @@ Subsystem Interfaces
 .. kernel-doc:: include/linux/pci-tsm.h
    :internal:
 
-.. kernel-doc:: drivers/pci/tsm.c
+.. kernel-doc:: drivers/pci/tsm/core.c
    :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..561914074d01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28487,7 +28487,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report
 F:	Documentation/driver-api/coco/
 F:	Documentation/driver-api/pci/tsm.rst
-F:	drivers/pci/tsm.c
+F:	drivers/pci/tsm/
 F:	drivers/virt/coco/guest/
 F:	include/linux/*tsm*.h
 F:	samples/tsm-mr/
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..211f195ff2c9 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_IDE)		+= ide.o
-obj-$(CONFIG_PCI_TSM)		+= tsm.o
+obj-$(CONFIG_PCI_TSM)		+= tsm/
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/tsm/Makefile b/drivers/pci/tsm/Makefile
new file mode 100644
index 000000000000..464414c11a72
--- /dev/null
+++ b/drivers/pci/tsm/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the PCI/TSM infrastructure
+
+obj-$(CONFIG_PCI_TSM) += tsm.o
+
+tsm-y := core.o
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm/core.c
similarity index 99%
rename from drivers/pci/tsm.c
rename to drivers/pci/tsm/core.c
index 5fdcd7f2e820..76ef03a1b3ec 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm/core.c
@@ -15,7 +15,7 @@
 #include <linux/sysfs.h>
 #include <linux/tsm.h>
 #include <linux/xarray.h>
-#include "pci.h"
+#include "../pci.h"
 
 /*
  * Provide a read/write lock against the init / exit of pdev tsm
-- 
2.43.0

