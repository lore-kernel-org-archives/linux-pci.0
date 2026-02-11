Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9D34A3A2
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780765; cv=none; b=LjbQaIvDavDn1Ye1QF6ly/akzwa91ZIM1nC6q6J2vVnTEeolAUEWulnLuXXBE8hzMGw7pfTxzqWrV/jyXlQQNcSKh13fZOj2WZLtePl1j7ixCM6AMqrBAcuU1o+PpJ5WEjkBZMD4vyV7l6ykF9Ny3M4orDOY4zEDHQ7xV/GOqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780765; c=relaxed/simple;
	bh=kxAaH/R88X1dnCESSe1LeIaJnXEvtoow32TWakEjvNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZ6zGN1+ijEX2wk9WYCkcOE5ShYVqrDpLOaXPi6891efVIEKdwFXNzqTsCdob7Dxlb43IPTIHr3PqobecIyoXxttU9sPW5NY38si2XgnzQXwX6rdXZQJEvSrqm2BqahRXG9KUvgOO7EA1hJwkZ2mAWcacmqsfsrDvwfn9bJxEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGomaO7o; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGomaO7o"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8249fc726e9so72089b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780763; x=1771385563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQmEdlkVMUMCwxAKuTSKI45sx1LLRiTRlNgCvCrwMvE=;
        b=UGomaO7oVQbLwjxr4hlWHnUKLe8OFZBqhBRAkJIGxpaKWMsVYocc2sNegQk2zuJFuh
         ker0TZBtHULEw6oAlHL8KD0SYqaQU4BqSPoymOX3GQJ/s/l0SC4GJ0e3nj4zQkuIsO6Y
         1nK/IzAMirt3bqeSdzAQvqa3dAN5dNGbpztLMQjqSyiqtEMVkSwo6dysg5uGPfSAkb3X
         ge10dxxUB2hXGswAYdXONM2p386VQ6X/jcrGzLlRz6VCHLndGlXEQUqyEHsACaHCE15N
         h6J1SClQHC5zapOYyAaTS8W3uGR4ksK1DqB+ym7T07FxEIATkHnS7AlSRCWfSsEyKMwW
         wBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780763; x=1771385563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQmEdlkVMUMCwxAKuTSKI45sx1LLRiTRlNgCvCrwMvE=;
        b=JlRjK2wcEbo5VAIsPsPwq880DSbU2DIkVTYBSvfCTEjYDRV0SlOoaOfBqdDsV0wJ/u
         zwjoWB4/tuVPEjRbxERFyIMMTyLRTVrEtbEvflliUKV5rmclylRQ+eLZvfIQPlEyTjWJ
         dZOAyV/Q39JB3fTikU7NWzG0Htvfm4MwprdYMJQLUjCeU92X0mRJXv0WTAQv/gqQ+bbZ
         1F0Ghdy97UKQ+CsTd9XwkbkEfuCRfRZqMXMygkZy4+SzOMvfNVYtbDtTbkKvwTArMWpo
         ou8KCRjidpwd1nVwfAsw2fmw9Rk/cH/dKx0FAv6CmLDlf/dbmtC/vwQOrY4L81sppLMM
         MFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGgGZva/YpTvM8gDdUO6Jw1/sjdUJxIlrqWFNcmULUEUXzo+zsNi6b484baA6FXnMS6W0+Nyam3A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxycaP8AvC9RNhx1bKik/IozPn9KZDOhjMyWXyD2PUxMuCytPT
	Atw2WY8AG+b/Z6tL1m2xipE/w+N+tsbAb6qPY+PqIaWNBsiHpIvORhZw
X-Gm-Gg: AZuq6aL22ELVXMHyvXG2H93R4Uf0MW/O71oiVyjyt4odKD1jDHGzZz807qw917KideF
	PC0xuqSvsPnL3EzfRchDGmfJJmQeOL2sUaZZOvS+ak+pREhZBIPlBxRAHK8N47JGInQF+DMAsxP
	LV3x8Plxzq7dMYWm0UXczQNRC7xPiGGpHR9Wg+RWehribUC/KClSCUmuPecsSqcpef/1wj+166q
	WA/T3dfTlF35FHyTZRvm/2J4kZTqJJA0BcT4k+SR2Pe38PcJGq9sGrO8IaChE55Hy8Vo9aiTVSI
	Wh76QNNkMhH4wu9bGolTYGDzE4Ii/iNnr3JqZYYYS0xMikBe7UU3JiDK/U8IWBatp3KFtikS3CV
	PZEWP0XgV346r2IXaBDqq9L+pshisAcKJZn+o08b1SvjgdrK9AGy3FqGiJ+WCni7aCZ1OAd+2NZ
	ZAt/w8UWcrb3a9fERakuxoYrwXNzqEogtgp4KuSECr4g==
X-Received: by 2002:a05:6a21:b91:b0:37e:4319:d7c8 with SMTP id adf61e73a8af0-3942e6d5e66mr1179185637.75.1770780763333;
        Tue, 10 Feb 2026 19:32:43 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:32:42 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v3 25/27] PCI/CMA: Expose in sysfs whether devices are authenticated
Date: Wed, 11 Feb 2026 13:29:32 +1000
Message-ID: <20260211032935.2705841-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

From: Lukas Wunner <lukas@wunner.de>

The PCI core has just been amended to authenticate CMA-capable devices
on enumeration and store the result in an "authenticated" bit in struct
pci_dev->spdm_state.

Expose the bit to user space through an eponymous sysfs attribute.

Allow user space to trigger reauthentication (e.g. after it has updated
the CMA keyring) by writing to the sysfs attribute.

Implement the attribute in the SPDM library so that other bus types
besides PCI may take advantage of it.  They just need to add
spdm_attr_group to the attribute groups of their devices and amend the
dev_to_spdm_state() helper which retrieves the spdm_state for a given
device.

The helper may return an ERR_PTR if it couldn't be determined whether
SPDM is supported by the device.  The sysfs attribute is visible in that
case but returns an error on access.  This prevents downgrade attacks
where an attacker disturbs memory allocation or DOE communication
in order to create the appearance that SPDM is unsupported.

Subject to further discussion, a future commit might add a user-defined
policy to forbid driver binding to devices which failed authentication,
similar to the "authorized" attribute for USB.

Alternatively, authentication success might be signaled to user space
through a uevent, whereupon it may bind a (blacklisted) driver.
A uevent signaling authentication failure might similarly cause user
space to unbind or outright remove the potentially malicious device.

Traffic from devices which failed authentication could also be filtered
through ACS I/O Request Blocking Enable (PCIe r6.2 sec 7.7.11.3) or
through Link Disable (PCIe r6.2 sec 7.5.3.7).  Unlike an IOMMU, that
will not only protect the host, but also prevent malicious peer-to-peer
traffic to other devices.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
[ Changes by AF:
 - Drop lib/spdm changes and replace with Rust implementation
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 Documentation/ABI/testing/sysfs-devices-spdm | 31 +++++++
 MAINTAINERS                                  |  3 +-
 drivers/pci/cma.c                            | 12 ++-
 drivers/pci/doe.c                            |  2 +
 drivers/pci/pci-sysfs.c                      |  3 +
 drivers/pci/pci.h                            |  5 +
 include/linux/pci.h                          | 12 +++
 lib/rspdm/Makefile                           |  1 +
 lib/rspdm/lib.rs                             |  1 +
 lib/rspdm/req-sysfs.c                        | 98 ++++++++++++++++++++
 lib/rspdm/spdm.h                             | 17 ++++
 lib/rspdm/sysfs.rs                           | 38 ++++++++
 12 files changed, 218 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-spdm
 create mode 100644 lib/rspdm/req-sysfs.c
 create mode 100644 lib/rspdm/spdm.h
 create mode 100644 lib/rspdm/sysfs.rs

diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation/ABI/testing/sysfs-devices-spdm
new file mode 100644
index 000000000000..018acde950ff
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-spdm
@@ -0,0 +1,31 @@
+What:		/sys/devices/.../authenticated
+Date:		June 2025
+Contact:	Lukas Wunner <lukas@wunner.de>
+Description:
+		This file contains 1 if the device authenticated successfully
+		with SPDM (Security Protocol and Data Model).  It contains 0 if
+		the device failed authentication (and may thus be malicious).
+
+		Writing "re" to this file causes reauthentication.
+		That may be opportune after updating the device keyring.
+		The device keyring of the PCI bus is named ".cma"
+		(Component Measurement and Authentication).
+
+		Reauthentication may also be necessary after device identity
+		has mutated, e.g. after downloading firmware to an FPGA device.
+
+		The file is not visible if authentication is unsupported
+		by the device.
+
+		If the kernel could not determine whether authentication is
+		supported because memory was low or communication with the
+		device was not working, the file is visible but accessing it
+		fails with error code ENOTTY.
+
+		This prevents downgrade attacks where an attacker consumes
+		memory or disturbs communication in order to create the
+		appearance that a device does not support authentication.
+
+		The reason why authentication support could not be determined
+		is apparent from "dmesg".  To re-probe authentication support
+		of PCI devices, exercise the "remove" and "rescan" attributes.
diff --git a/MAINTAINERS b/MAINTAINERS
index 58898260fde8..eae4722e40bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23702,7 +23702,8 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
-F:	drivers/pci/cma.c
+F:	Documentation/ABI/testing/sysfs-devices-spdm
+F:	drivers/pci/cma*
 F:	include/linux/spdm.h
 F:	lib/rspdm/
 
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index 8d64008594e2..55b8fe6d3121 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -172,8 +172,10 @@ void pci_cma_init(struct pci_dev *pdev)
 {
 	struct pci_doe_mb *doe;
 
-	if (IS_ERR(pci_cma_keyring))
+	if (IS_ERR(pci_cma_keyring)) {
+		pdev->spdm_state = ERR_PTR(-ENOTTY);
 		return;
+	}
 
 	if (!pci_is_pcie(pdev))
 		return;
@@ -186,8 +188,10 @@ void pci_cma_init(struct pci_dev *pdev)
 	pdev->spdm_state = spdm_create(&pdev->dev, pci_doe_transport, doe,
 				       PCI_DOE_MAX_PAYLOAD, pci_cma_keyring,
 				       pci_cma_validate);
-	if (!pdev->spdm_state)
+	if (!pdev->spdm_state) {
+		pdev->spdm_state = ERR_PTR(-ENOTTY);
 		return;
+	}
 
 	/*
 	 * Keep spdm_state allocated even if initial authentication fails
@@ -205,7 +209,7 @@ void pci_cma_init(struct pci_dev *pdev)
  */
 void pci_cma_reauthenticate(struct pci_dev *pdev)
 {
-	if (!pdev->spdm_state)
+	if (IS_ERR_OR_NULL(pdev->spdm_state))
 		return;
 
 	spdm_authenticate(pdev->spdm_state);
@@ -213,7 +217,7 @@ void pci_cma_reauthenticate(struct pci_dev *pdev)
 
 void pci_cma_destroy(struct pci_dev *pdev)
 {
-	if (!pdev->spdm_state)
+	if (IS_ERR_OR_NULL(pdev->spdm_state))
 		return;
 
 	spdm_destroy(pdev->spdm_state);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 344e01496a8e..96ca77ecba90 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -857,6 +857,7 @@ void pci_doe_init(struct pci_dev *pdev)
 		if (IS_ERR(doe_mb)) {
 			pci_err(pdev, "[%x] failed to create mailbox: %ld\n",
 				offset, PTR_ERR(doe_mb));
+			pci_cma_disable(pdev);
 			continue;
 		}
 
@@ -865,6 +866,7 @@ void pci_doe_init(struct pci_dev *pdev)
 			pci_err(pdev, "[%x] failed to insert mailbox: %d\n",
 				offset, rc);
 			pci_doe_destroy_mb(doe_mb);
+			pci_cma_disable(pdev);
 		}
 	}
 }
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c2df915ad2d2..b2b2096f8162 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1853,6 +1853,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
 #endif
+#ifdef CONFIG_PCI_CMA
+	&spdm_attr_group,
+#endif
 #ifdef CONFIG_PCI_DOE
 	&pci_doe_sysfs_group,
 #endif
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f87a4b7c92b8..80bd998e77e4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -603,10 +603,15 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 void pci_cma_init(struct pci_dev *pdev);
 void pci_cma_destroy(struct pci_dev *pdev);
 void pci_cma_reauthenticate(struct pci_dev *pdev);
+static inline void pci_cma_disable(struct pci_dev *pdev)
+{
+	pdev->spdm_state = ERR_PTR(-ENOTTY);
+}
 #else
 static inline void pci_cma_init(struct pci_dev *pdev) { }
 static inline void pci_cma_destroy(struct pci_dev *pdev) { }
 static inline void pci_cma_reauthenticate(struct pci_dev *pdev) { }
+static inline void pci_cma_disable(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCI_NPEM
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7384846ade19..44e7bd6f2076 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2827,6 +2827,18 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
+#ifdef CONFIG_PCI_CMA
+static inline struct spdm_state *pci_dev_to_spdm_state(struct pci_dev *pdev)
+{
+	return pdev->spdm_state;
+}
+#else
+static inline struct spdm_state *pci_dev_to_spdm_state(struct pci_dev *pdev)
+{
+	return NULL;
+}
+#endif
+
 #include <linux/dma-mapping.h>
 
 #define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
diff --git a/lib/rspdm/Makefile b/lib/rspdm/Makefile
index 1f62ee2a882d..f15b1437196b 100644
--- a/lib/rspdm/Makefile
+++ b/lib/rspdm/Makefile
@@ -8,3 +8,4 @@
 obj-$(CONFIG_RSPDM) += spdm.o
 
 spdm-y := lib.o
+spdm-$(CONFIG_SYSFS) += req-sysfs.o
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 05fa471bb1e2..c0e3e039c14f 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -24,6 +24,7 @@
 
 mod consts;
 mod state;
+pub mod sysfs;
 mod validator;
 
 /// spdm_create() - Allocate SPDM session
diff --git a/lib/rspdm/req-sysfs.c b/lib/rspdm/req-sysfs.c
new file mode 100644
index 000000000000..7971be291627
--- /dev/null
+++ b/lib/rspdm/req-sysfs.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Requester role: sysfs interface
+ *
+ * Copyright (C) 2023-24 Intel Corporation
+ * Copyright (C) 2024 Western Digital
+ */
+
+#include <linux/pci.h>
+#include "spdm.h"
+
+int rust_authenticated_show(void *spdm_state, char *buf);
+
+/**
+ * dev_to_spdm_state() - Retrieve SPDM session state for given device
+ *
+ * @dev: Responder device
+ *
+ * Returns a pointer to the device's SPDM session state,
+ *	   %NULL if the device doesn't have one or
+ *	   %ERR_PTR if it couldn't be determined whether SPDM is supported.
+ *
+ * In the %ERR_PTR case, attributes are visible but return an error on access.
+ * This prevents downgrade attacks where an attacker disturbs memory allocation
+ * or communication with the device in order to create the appearance that SPDM
+ * is unsupported.  E.g. with PCI devices, the attacker may foil CMA or DOE
+ * initialization by simply hogging memory.
+ */
+static void *dev_to_spdm_state(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_dev_to_spdm_state(to_pci_dev(dev));
+
+	/* Insert mappers for further bus types here. */
+
+	return NULL;
+}
+
+/* authenticated attribute */
+
+static umode_t spdm_attrs_are_visible(struct kobject *kobj,
+				      struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	void *spdm_state = dev_to_spdm_state(dev);
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return SYSFS_GROUP_INVISIBLE;
+
+	return a->mode;
+}
+
+static ssize_t authenticated_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	void *spdm_state = dev_to_spdm_state(dev);
+	int rc;
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return PTR_ERR(spdm_state);
+
+	if (sysfs_streq(buf, "re")) {
+		rc = spdm_chall(spdm_state);
+		if (rc)
+			return rc;
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t authenticated_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	void *spdm_state = dev_to_spdm_state(dev);
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return PTR_ERR(spdm_state);
+
+	return rust_authenticated_show(spdm_state, buf);
+}
+static DEVICE_ATTR_RW(authenticated);
+
+static struct attribute *spdm_attrs[] = {
+	&dev_attr_authenticated.attr,
+	NULL
+};
+
+const struct attribute_group spdm_attr_group = {
+	.attrs = spdm_attrs,
+	.is_visible = spdm_attrs_are_visible,
+};
diff --git a/lib/rspdm/spdm.h b/lib/rspdm/spdm.h
new file mode 100644
index 000000000000..43ef56a073c0
--- /dev/null
+++ b/lib/rspdm/spdm.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Copyright (C) 2021-22 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022-25 Intel Corporation
+ */
+
+#ifndef _LIB_SPDM_H_
+#define _LIB_SPDM_H_
+
+int spdm_chall(struct spdm_state *spdm_state);
+
+#endif /* _LIB_SPDM_H_ */
diff --git a/lib/rspdm/sysfs.rs b/lib/rspdm/sysfs.rs
new file mode 100644
index 000000000000..d0e7f6b3de40
--- /dev/null
+++ b/lib/rspdm/sysfs.rs
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
+
+//! Rust sysfs helper functions
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+
+use crate::SpdmState;
+use kernel::prelude::*;
+use kernel::{bindings, str::CString};
+
+/// Helper function for the sysfs `authenticated_show()`.
+#[no_mangle]
+pub extern "C" fn rust_authenticated_show(spdm_state: *mut SpdmState, buf: *mut u8) -> isize {
+    // SAFETY: The opaque pointer will be directly from the `spdm_create()`
+    // function, so we can safely reconstruct it.
+    let state = unsafe { KBox::from_raw(spdm_state) };
+
+    let fmt = match CString::try_from_fmt(fmt!("{}\n", state.authenticated)) {
+        Ok(f) => f,
+        Err(_e) => return 0,
+    };
+
+    // SAFETY: Calling a kernel C function with valid arguments
+    unsafe { bindings::sysfs_emit(buf, fmt.as_char_ptr()) as isize }
+}
+
+/// Helper function to trigger a SPDM challenge
+#[no_mangle]
+pub unsafe extern "C" fn spdm_chall(state: &'static mut SpdmState) -> c_int {
+    if let Err(e) = state.challenge(state.provisioned_slots.trailing_zeros() as u8, false) {
+        return e.to_errno() as c_int;
+    }
+
+    0
+}
-- 
2.52.0

