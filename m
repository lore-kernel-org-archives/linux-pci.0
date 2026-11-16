Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815670;
	b=QQBVHW3ie4C/zeB7XhnUUeFRBTs09DiKx6iuLDQHFSmXe0lwKPVTBGRqFc++wypwmGLe
	 eSxoLx0jDJl8EkMyY4iUHGUNQS1P5OtQzEdvFkyx9zN+nnEdhOeEw538MqWQiHBCwdiPb
	 3l59WRSwSiDvHKQu/i3rIzOc8DvNhT3Obe1AWIDXrQ3MEiybesVBVZfmHb07spd7RObs1
	 dTPaIhcRPqYb2X9nP+TOL4jhJg1IzNGbIh31oUVqmw1qbMQJOebjmsVxEp3HizJbJNtWK
	 kjfxhjIrytctIVS56jb2BJVzo1Vx81PzH5M6xICbKCf48l97WzjVZ+OgqchHLypUWGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815670;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ry4FRa3ac835h7vSySSUdeRZEc8SsTj8syebvoCcbqE=;
	b=nbi6HQacDSlabvYG5WjntvgOs9wqvq/7jVr7m6d+iErBy/midpipIu4WjaX0zoq+DXIE
	 IkrVo4KKUO2w1Qsr1lbLTv3ZmNAAcbnnffGO/yopz4oJDGTYIBSHoqz61x1dBrRTGCogU
	 s2pGfodD8pksvPBFRBgO1sHm7GaXc74LylB9IWeVnXezJ59gOSw/tpYm1qasYMfH5z/Jt
	 cA1BcmBChAiFigWIAE6S6XNgIxqTTY0MRPyK99eytN5FMOyMMLuSO6RwHE2JYOcipw1+f
	 DUWjFryPoAWaxxlzNRIG4Awe6j6VheeKJAbJ5gpHfH47UkaDhOe0S516Q8ukfiPs5fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rh+YcUyy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E50606A323;
	Mon, 16 Nov 2026 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rh+YcUyy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458E81F000C4;
	Mon, 16 Nov 2026 07:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794815669;
	bh=Ry4FRa3ac835h7vSySSUdeRZEc8SsTj8syebvoCcbqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rh+YcUyyn8bi6/9p4Nu6aaR1qdLxT5Tlmtr4ZBzkUhtY5fWWRIZVjysqLlucATwvO
	 GnL0S9DIwatYXozgt52GoeGPchoY29+dHTwcwXHbP3EoUXeRym+NNQazzBla/1yeti
	 CqOarSeS097/MmIhNN21KeNPdJNyrp8ht8OqnCYsUBTES/Iw7EvbXU8Xxhc7NS/Ytg
	 srFpef/+B84vKdk+HD4eDqnfYx08Oa3x2ihdO26NtiE7OqDlUC9Qu2SGbGq1DMKWXd
	 YUmxmcJ5ajbVGK6J71pfdvm8zS0LO4OKRKWkIgCrl5PMhc/VMVuo10zQmD5CKGTILG
	 L2yiL94VXYUGg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI/TSM: Move core code into its own directory
Date: Mon, 16 Nov 2026 13:24:20 +0530
Message-ID: <20261116075420.76205-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116075420.76205-1-aneesh.kumar@kernel.org>
References: <20261116075420.76205-1-aneesh.kumar@kernel.org>
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

Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org
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
index 720fe907885b..3e626e45d432 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28549,7 +28549,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tsm/linux.git
 F:	Documentation/ABI/testing/configfs-tsm-report
 F:	Documentation/driver-api/coco/
 F:	Documentation/driver-api/pci/tsm.rst
-F:	drivers/pci/tsm.c
+F:	drivers/pci/tsm/
 F:	drivers/virt/coco/guest/
 F:	drivers/virt/coco/tsm-core.c
 F:	include/linux/*tsm*.h
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

