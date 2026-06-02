Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFD6367B66;
	Tue,  2 Jun 2026 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436542; cv=none; b=I6OLucvPaXuGZgnwdxlZ5LPt9FHEHGEuXeB+aF+cqQETF31rihdyiZ/zqF3g/Lw0Iqx2N6LT2hkhw7D4JWxzr6vntRLw04oLzIWyvOG1ejDqt98xdRJAZxT/JW/Cqo7sSfMp2ZYAdaB0jiwjwRu/DOQsI1WnmuMHFRWlKfJrnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436542; c=relaxed/simple;
	bh=iwksXPWGv4tIgOlo1e6YlBEfiKWeZGsyIese+2pCBkc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mNJ7i8SuRoRDidvF6VcYx8x+EFUqcM5247PfMm29IH04wEfJFfrsQuriMcMsfwybtYu/zv2aGrebLDui81bcBSrmDHq/KUXg8WWNOhSYuz8mMCTrZyZdX5MoGDOTBnFB30huuF7isRLc21tHOKLr4/K7zjjGhQgOtBY35aj5+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dfo59/ii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dfo59/ii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B021F00899;
	Tue,  2 Jun 2026 21:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780436539;
	bh=DfqJQX1037ghsePHowZ2n8pRe/SNJy+eVbW9xiykoFQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Dfo59/ii8mB0wDxTfTKtJOt7SzRvRBTy5bCdrntvs8xybjfuiDoWHKQiJRTfZy10t
	 1RaoBaakJxmaKLm8AOcRPhT0Ifaz3ML9juKW3zdgmdizGF1h7xDo+4BJfatKzpUoQl
	 80CYthvu/TnCWYmbNAxKyVKEgl893MOz/T6IJAawtcMVVhg5g9uEL0AiBi/2wEXu8L
	 SAWeCvOX6TDNmSTa0bsowvzE6b2wBZIUEgSPj3gHjgw+v06SJd6Ewi1BMXeCuLw+/p
	 p2JCc3X9ZQAOFHWpBREoHoqLdi+n4o76QzgV+fZVVJVYt0x/qDjUyIflWbJFbXw9CV
	 S+VqFojYH5pPQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 02078F40075;
	Tue,  2 Jun 2026 17:42:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 17:42:18 -0400
X-ME-Sender: <xms:OU4fai11oc-sNRp2TIRm27UEhTN4Y4TkIXino4vF3QLm7GVn3117YA>
    <xme:OU4fahfSYcOHQN3GzapA8fVBj-IE2qiArPIGXENN8QE5fsVitWP-F5n1O9I8alXYE
    bQNj5-sJICCaO3N9qCqBHjAiSpEf_ZbSPzHohCoizFEokJO3a7KMEI>
X-ME-Received: <xmr:OU4favWuVvXQ_OjJZe8LPIMq7npa5WVeXjQdy1oRWNZtSCPs5VxgHSryzjsaW-XePAdrgwrdokIZ-Gy9OCqapV010Vjumc_Mr1c>
X-ME-Proxy-Cause: dmFkZTGDuR9avNyX8x47lX56cmFF08cabxRreH7aUpn7J5lgixXwmeHpmicHdmzGe5Q8FS
    3LgrCOm5/QJEpBVyN+9vVBXSFsiTUws2muWz8hPXE0lk9j3oBxoqBqXKHXDdjpQqud+PMJ
    ReLVrfGNv/NWvWpQC3qAVXVTyVo1iQu9XvlpgBJ3hD+w2eGWia1pR4+z6sLCsTApV2HPyS
    coCHVwqm9ubl/Y+1FWX6AO/31LdlLUYExljFOQqQIvaAe3pkIYUhL4ZQ/f/InnBN/YfA19
    6QhfLK0xi5Xbbv+hh8M5xTqWKDiGbtWX1K6BDKSQpD9JdhoN5XtBKVaWvcKOEq34MZALPF
    dqRik25VM7tJBXMcAP1nHtinWxmbs3y7e9IYsQS31jrPczKIFalZmuF/N7MqtQytgZdQVi
    I0OxI1hkbcvQ1h7miM/p5PzqIeOMzJZkcA5dK7odwFD8eYpnBxvtIhZ4piR90C+ZNxYrjn
    8vZs5EjZnTMDslzRArEKTHy8m+aM6K/tcxVTOTp8zxLLDGlP6XfZGfE0rbWVooIo2yQ5Qk
    rI3tMggGILB1zSUMyUPdYoi1k/hJ4pku9tmEr7k6ivFUp6I8z86yKN03PMqnaOvE7yGbZ0
    Uahy3DCedjrEPFmh91JNWedREfPOD2j7g8xs1FyFoZz1gJia8rjdtMb2HpLw
X-ME-Proxy: <xmx:OU4fah-xKZ4pK_Ofia39DwwPac7PFrDUIqR63MZUHEQDMmcPWxKv1Q>
    <xmx:OU4fahjkPKRqTnw9NV45W6RqyPeGiAWKwaEcc3UVqaHsrGehPypcbA>
    <xmx:OU4falfSYdQHkhWkn55HNJZ2Q-KCVw2jnZ7FQ7R6serTpU1rqXU6og>
    <xmx:OU4faiK-_z4EAkWzld-TjMQlGT-WFSHi9yws4yX5LDxRyC3jtBZqgw>
    <xmx:Ok4faqnzuI4MkmySWy-9wrGUjfdST-g7NKjAMR5N5Jc_gJ1t9L6XA-O8>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:42:17 -0400 (EDT)
Date: Tue, 02 Jun 2026 14:42:16 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, 
 alwilliamson@nvidia.com, 
 Dan Williams <danwilliams@nvidia.com>, 
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
 Vishal Aslot <vaslot@nvidia.com>, 
 Manish Honap <mhonap@nvidia.com>, 
 Jiandi An <jan@nvidia.com>, 
 Richard Cheng <icheng@nvidia.com>, 
 linux-tegra@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a1f4e383073d_42b9100e3@djbw-dev.notmuch>
In-Reply-To: <20260528083154.137979-1-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
Subject: Re: [PATCH v6 0/9] cxl: Add cxl_reset sysfs attribute for memdevs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Srirangan Madhavan wrote:
> Hi folks!
> 
> This patch series introduces support for the CXL Reset method for CXL
> Type 2 devices, implementing the reset procedure outlined in the CXL
> Specification r3.2 [1], Sections 8.1.3, 9.6, and 9.7.
> 
> The userspace ABI is a write-only cxl_reset attribute under the CXL
> memdev device:
> 
>     /sys/bus/cxl/devices/memX/cxl_reset

Hi Srirangan,

To move this forward we need a compromise between reimplementing CXL
bits in drivers/pci/ (what I reacted to in the initial postings), but
still wanting to use the /sys/bus/pci reset entry point (what you and
Alex reacted to in my comments).

I started a suggestion here...

http://lore.kernel.org/6a0620acec806_57ad71008c@djbw-dev.notmuch

...however, looking at it again, this:

     echo 1 > /sys/bus/pci/devices/$pdev/cxl/reset

...ends up functionally equivalent to the original:

     echo cxl_reset > /sys/bus/pci/devices/$pdev/reset_method
     echo 1 > /sys/bus/pci/devices/$pdev/reset_method

Now, the motivations why I pushed on /sys/bus/cxl/devices/memX/cxl_reset
were to avoid duplicating HDM enumeration in multiple places, and
provide for coordinating changes to the CXL memory configuration with
CXL reset. I.e. CXL reset can take HDM locks (where the PCI reset device
locks may not be sufficient)

The fatal downside of that proposal is that the memX/cxl_reset ABI
requires driver loading. Long term, as you and Alex convinced me, that
is going to be a pain and breaks current device assignment flows.

A compromise that lets PCI and CXL share infrastructure while still
supporting the long-standing PCI reset ABI is:

1/ Carry CXL decoder settings in the PCI device
2/ Build in shared low level helpers for marshaling decoder settings
   to/from hardware.
3/ Allow the low-level helpers to reference CXL locks

I drafted a rough conversion of what would be needed to share this
low-level coordination across the PCI and CXL core.

It introduces 'struct cxl_decoder_settings' and moves all the HDM decode
related definitions to cxl/cxl.h. It moves the core locks and low-level
hardware update helpers into a built-in drivers/cxl/core/reset.o object
where all of this reset coordination can be shared. It provides for
saving and restoring HDM state not just over reset, but from initial
device enumeration for devices that may forget their CXL configuration
for other reasons besides PCI reset.

The bulk of this is movement from drivers/cxl/cxl.h to
include/cxl/cxl.h, and drivers/cxl/core/hdm.c to
drivers/cxl/core/reset.c.

Thoughts? Does this compromise address all the open ABI concerns? I will
go through the rest of the patches and provide some notes with this
proposal in mind.

Applies against v7.1-rc3, needs splitting once we agree on this shape
(only build tested):

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..a809ba0dcc0c 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -5,6 +5,7 @@ menuconfig CXL_BUS
 	select FW_LOADER
 	select FW_UPLOAD
 	select PCI_DOE
+	select CXL_HDM
 	select FIRMWARE_TABLE
 	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
 	select FWCTL if CXL_FEATURES
@@ -243,4 +244,7 @@ config CXL_ATL
 	depends on CXL_REGION
 	depends on ACPI_PRMT && AMD_NB
 
+config CXL_HDM
+	bool
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ce7213818d3c..ebb0891daeb5 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
+obj-$(CONFIG_CXL_HDM) += reset.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
 CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1297594beaec..e31462fcf37b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -252,49 +252,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
 #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
 
-enum cxl_decoder_type {
-	CXL_DECODER_DEVMEM = 2,
-	CXL_DECODER_HOSTONLYMEM = 3,
-};
-
-/*
- * Current specification goes up to 8, double that seems a reasonable
- * software max for the foreseeable future
- */
-#define CXL_DECODER_MAX_INTERLEAVE 16
-
 #define CXL_QOS_CLASS_INVALID -1
 
-/**
- * struct cxl_decoder - Common CXL HDM Decoder Attributes
- * @dev: this decoder's device
- * @id: kernel device name id
- * @hpa_range: Host physical address range mapped by this decoder
- * @interleave_ways: number of cxl_dports in this decode
- * @interleave_granularity: data stride per dport
- * @target_type: accelerator vs expander (type2 vs type3) selector
- * @region: currently assigned region for this decoder
- * @flags: memory type capabilities and locking
- * @target_map: cached copy of hardware port-id list, available at init
- *              before all @dport objects have been instantiated. While
- *              dport id is 8bit, CFMWS interleave targets are 32bits.
- * @commit: device/decoder-type specific callback to commit settings to hw
- * @reset: device/decoder-type specific callback to reset hw settings
-*/
-struct cxl_decoder {
-	struct device dev;
-	int id;
-	struct range hpa_range;
-	int interleave_ways;
-	int interleave_granularity;
-	enum cxl_decoder_type target_type;
-	struct cxl_region *region;
-	unsigned long flags;
-	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
-	int (*commit)(struct cxl_decoder *cxld);
-	void (*reset)(struct cxl_decoder *cxld);
-};
-
 /*
  * Track whether this decoder is free for userspace provisioning, reserved for
  * region autodiscovery, whether it is started connecting (awaiting other
@@ -310,7 +269,6 @@ enum cxl_decoder_state {
  * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
  * @cxld: base cxl_decoder_object
  * @dpa_res: actively claimed DPA span of this decoder
- * @skip: offset into @dpa_res where @cxld.hpa_range maps
  * @state: autodiscovery state
  * @part: partition index this decoder maps
  * @pos: interleave position in @cxld.region
@@ -318,7 +276,6 @@ enum cxl_decoder_state {
 struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
 	struct resource *dpa_res;
-	resource_size_t skip;
 	enum cxl_decoder_state state;
 	int part;
 	int pos;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index fa7269154620..1460bfefe593 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -5,6 +5,7 @@
 #ifndef __CXL_CXL_H__
 #define __CXL_CXL_H__
 
+#include <linux/device.h>
 #include <linux/node.h>
 #include <linux/ioport.h>
 #include <cxl/mailbox.h>
@@ -23,7 +24,56 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
-struct device;
+enum cxl_decoder_type {
+	CXL_DECODER_DEVMEM = 2,
+	CXL_DECODER_HOSTONLYMEM = 3,
+};
+
+/*
+ * Current specification goes up to 8, double that seems a reasonable
+ * software max for the foreseeable future
+ */
+#define CXL_DECODER_MAX_INTERLEAVE 16
+
+/**
+ * struct cxl_decoder - Common CXL HDM Decoder Attributes
+ * @dev: this decoder's device
+ * @id: kernel device name id
+ * @hpa_range: Host physical address range mapped by this decoder
+ * @skip: offset into @dpa_res where @cxld.hpa_range maps (endpoint)
+ * @targets: interleave position to dport mapping (switch)
+ * @interleave_ways: number of cxl_dports in this decode
+ * @interleave_granularity: data stride per dport
+ * @target_type: accelerator vs expander (type2 vs type3) selector
+ * @flags: memory type capabilities and locking
+ * @region: currently assigned region for this decoder
+ * @target_map: cached copy of hardware port-id list, available at init
+ *              before all @dport objects have been instantiated. While
+ *              dport id is 8bit, CFMWS interleave targets are 32bits.
+ * @commit: device/decoder-type specific callback to commit settings to hw
+ * @reset: device/decoder-type specific callback to reset hw settings
+*/
+struct cxl_decoder {
+	struct device dev;
+	struct_group_tagged(cxl_decoder_settings, settings,
+		int id;
+		struct range hpa_range;
+		union {
+			u64 skip;
+			u64 targets;
+		};
+		int interleave_ways;
+		int interleave_granularity;
+		enum cxl_decoder_type target_type;
+		unsigned long flags;
+	);
+	struct cxl_region *region;
+	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
+	int (*commit)(struct cxl_decoder *cxld);
+	void (*reset)(struct cxl_decoder *cxld);
+};
+
+int cxl_commit(struct cxl_decoder_settings *cxld, void __iomem *hdm);
 
 /*
  * Using struct_group() allows for per register-block-type helper routines,
@@ -116,6 +166,12 @@ struct cxl_register_map {
 	};
 };
 
+struct cxl_hdm_info {
+	int decoder_count;
+	struct cxl_component_regs regs;
+	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
+};
+
 /**
  * struct cxl_dpa_perf - DPA performance property entry
  * @dpa_range: range for DPA address
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..35d05c8bdd43 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/resource_ext.h>
 #include <linux/msi_api.h>
+#include <cxl/cxl.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -577,6 +578,9 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_TSM
 	struct pci_tsm *tsm;		/* TSM operation state */
+#endif
+#ifdef CONFIG_CXL_HDM
+	struct cxl_hdm_info *hdm;
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	u16		acs_capabilities; /* ACS Capabilities */
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..8c236d116174 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,11 +16,6 @@
  * for enumerating these registers and capabilities.
  */
 
-struct cxl_rwsem cxl_rwsem = {
-	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
-	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
-};
-
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
 	int rc;
@@ -249,17 +244,18 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_decoder *cxld = &cxled->cxld;
 	struct resource *res = cxled->dpa_res;
 	resource_size_t skip_start;
 
 	lockdep_assert_held_write(&cxl_rwsem.dpa);
 
 	/* save @skip_start, before @res is released */
-	skip_start = res->start - cxled->skip;
+	skip_start = res->start - cxld->skip;
 	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
-	if (cxled->skip)
-		release_skip(cxlds, skip_start, cxled->skip);
-	cxled->skip = 0;
+	if (cxld->skip)
+		release_skip(cxlds, skip_start, cxld->skip);
+	cxld->skip = 0;
 	cxled->dpa_res = NULL;
 	put_device(&cxled->cxld.dev);
 	port->hdm_end--;
@@ -343,6 +339,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_decoder *cxld = &cxled->cxld;
 	struct device *dev = &port->dev;
 	struct resource *res;
 	int rc;
@@ -388,7 +385,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		return -EBUSY;
 	}
 	cxled->dpa_res = res;
-	cxled->skip = skipped;
+	cxld->skip = skipped;
 
 	/*
 	 * When allocating new capacity, ->part is already set, when
@@ -679,39 +676,12 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
-static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
-{
-	u16 eig;
-	u8 eiw;
-
-	/*
-	 * Input validation ensures these warns never fire, but otherwise
-	 * suppress unititalized variable usage warnings.
-	 */
-	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
-		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
-		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
-		      "invalid interleave_granularity: %d\n",
-		      cxld->interleave_granularity))
-		return;
-
-	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
-	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
-	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
-}
-
-static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
-{
-	u32p_replace_bits(ctrl,
-			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
-			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
-}
-
-static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
+static void cxlsd_set_targets(struct cxl_decoder *cxld)
 {
+	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	struct cxl_dport **t = &cxlsd->target[0];
 	int ways = cxlsd->cxld.interleave_ways;
+	u64 *tgt = &cxld->targets;
 
 	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
 	if (ways > 1)
@@ -730,73 +700,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
 }
 
-/*
- * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
- * committed or error within 10ms, but just be generous with 20ms to account for
- * clock skew and other marginal behavior
- */
-#define COMMIT_TIMEOUT_MS 20
-static int cxld_await_commit(void __iomem *hdm, int id)
-{
-	u32 ctrl;
-	int i;
-
-	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
-		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
-			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
-			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-			return -EIO;
-		}
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
-			return 0;
-		fsleep(1000);
-	}
-
-	return -ETIMEDOUT;
-}
-
-static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
-{
-	int id = cxld->id;
-	u64 base, size;
-	u32 ctrl;
-
-	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
-	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
-	base = cxld->hpa_range.start;
-	size = range_len(&cxld->hpa_range);
-
-	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
-	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
-	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
-
-	if (is_switch_decoder(&cxld->dev)) {
-		struct cxl_switch_decoder *cxlsd =
-			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
-		u64 targets;
-
-		cxlsd_set_targets(cxlsd, &targets);
-		writel(upper_32_bits(targets), tl_hi);
-		writel(lower_32_bits(targets), tl_lo);
-	} else {
-		struct cxl_endpoint_decoder *cxled =
-			to_cxl_endpoint_decoder(&cxld->dev);
-		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
-		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
-
-		writel(upper_32_bits(cxled->skip), sk_hi);
-		writel(lower_32_bits(cxled->skip), sk_lo);
-	}
-
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
-}
-
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
@@ -832,21 +735,17 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 				dev_name(&cxld->dev));
 			return -EBUSY;
 		}
-	}
-
-	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
-		setup_hw_decoder(cxld, hdm);
+	} else
+		cxlsd_set_targets(cxld);
 
-	rc = cxld_await_commit(hdm, cxld->id);
-	if (rc) {
+	rc = cxl_commit(&cxld->settings, hdm);
+	if (rc)
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
-		return rc;
-	}
-	port->commit_end++;
-	cxld->flags |= CXL_DECODER_F_ENABLE;
+	else
+		port->commit_end++;
 
-	return 0;
+	return rc;
 }
 
 static int commit_reap(struct device *dev, void *data)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..0349d73140e3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2899,6 +2899,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	struct cxl_endpoint_decoder *cxled;
 	enum cxl_partition_mode mode;
 	struct cxl_dev_state *cxlds;
+	struct cxl_decoder *cxld;
 	struct cxl_memdev *cxlmd;
 	u64 offset, length;
 	int rc = 0;
@@ -2912,11 +2913,12 @@ static int poison_by_decoder(struct device *dev, void *arg)
 
 	cxlmd = cxled_to_memdev(cxled);
 	cxlds = cxlmd->cxlds;
+	cxld = &cxled->cxld;
 	mode = cxlds->part[cxled->part].mode;
 
-	if (cxled->skip) {
-		offset = cxled->dpa_res->start - cxled->skip;
-		length = cxled->skip;
+	if (cxld->skip) {
+		offset = cxled->dpa_res->start - cxld->skip;
+		length = cxld->skip;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
 		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
 			rc = 0;
diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
new file mode 100644
index 000000000000..0b4372b6d608
--- /dev/null
+++ b/drivers/cxl/core/reset.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 NVIDIA Corporation & Affiliates */
+#include <cxl/cxl.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/range.h>
+#include <cxl.h>
+#include "core.h"
+
+/*
+ * Common lowlevel setup and re-initialization (reset) helpers for the
+ * CXL memory associated with a PCI device. CXL core locks are built-in
+ * to the main kernel image for coordination with in-kernel mechanisms
+ * like reset.
+ */
+
+struct cxl_rwsem cxl_rwsem = {
+	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
+	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
+};
+EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
+
+static void cxld_set_interleave(struct cxl_decoder_settings *cxld, u32 *ctrl)
+{
+	u16 eig;
+	u8 eiw;
+
+	/*
+	 * Input validation ensures these warns never fire, but otherwise
+	 * suppress unititalized variable usage warnings.
+	 */
+	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
+		return;
+	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
+		      "invalid interleave_granularity: %d\n",
+		      cxld->interleave_granularity))
+		return;
+
+	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
+	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
+	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
+}
+
+static void cxld_set_type(struct cxl_decoder_settings *cxld, u32 *ctrl)
+{
+	u32p_replace_bits(ctrl,
+			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
+			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+}
+
+static void setup_hw_decoder(struct cxl_decoder_settings *cxld, void __iomem *hdm)
+{
+	u32 ctrl;
+	u64 base, size;
+	int id = cxld->id;
+	void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
+	void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
+
+	/* common decoder settings */
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+	cxld_set_interleave(cxld, &ctrl);
+	cxld_set_type(cxld, &ctrl);
+	base = cxld->hpa_range.start;
+	size = range_len(&cxld->hpa_range);
+
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+
+	/* endpoint 'skip' and switch 'targets' settings alias */
+	writel(upper_32_bits(cxld->skip), sk_hi);
+	writel(lower_32_bits(cxld->skip), sk_lo);
+
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+/*
+ * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
+ * committed or error within 10ms, but just be generous with 20ms to account for
+ * clock skew and other marginal behavior
+ */
+#define COMMIT_TIMEOUT_MS 20
+static int cxld_await_commit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
+			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+			return -EIO;
+		}
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
+int cxl_commit(struct cxl_decoder_settings *cxld, void __iomem *hdm)
+{
+	int rc;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+		setup_hw_decoder(cxld, hdm);
+
+	rc = cxld_await_commit(hdm, cxld->id);
+	if (rc == 0)
+		cxld->flags |= CXL_DECODER_F_ENABLE;
+	return rc;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit, "cxl_core");
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 418669927fb0..de088bb930c3 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -840,11 +840,11 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
 		dbg_cxld(port, "restore", &td->cxled.cxld);
 		cxld_copy(cxld, &td->cxled.cxld);
 		cxled->state = td->cxled.state;
-		cxled->skip = td->cxled.skip;
+		cxld->skip = td->cxled.cxld.skip;
 		if (range_len(&td->dpa_range)) {
 			rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
 						  range_len(&td->dpa_range),
-						  td->cxled.skip);
+						  td->cxled.cxld.skip);
 			if (rc) {
 				init_disabled_mock_decoder(cxld);
 				return rc;
@@ -882,7 +882,7 @@ static void __cxld_registry_save(struct cxl_test_decoder *td,
 
 		cxld_copy(&td->cxled.cxld, cxld);
 		td->cxled.state = cxled->state;
-		td->cxled.skip = cxled->skip;
+		td->cxled.cxld.skip = cxld->skip;
 
 		if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
 			td->dpa_range.start = 0;
@@ -970,7 +970,7 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 			to_cxl_endpoint_decoder(&cxld->dev);
 
 		cxled->state = CXL_DECODER_STATE_MANUAL;
-		cxled->skip = 0;
+		cxld->skip = 0;
 	}
 	if (decoder_reset_preserve_registry)
 		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
@@ -1021,7 +1021,7 @@ static void init_disabled_mock_decoder(struct cxl_decoder *cxld)
 			to_cxl_endpoint_decoder(&cxld->dev);
 
 		cxled->state = CXL_DECODER_STATE_MANUAL;
-		cxled->skip = 0;
+		cxld->skip = 0;
 	}
 }
