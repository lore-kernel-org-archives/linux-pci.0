Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6CD34678E
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780666; cv=none; b=NY2WtW0NoiLzGB8DZeSBpaUMa3uopGqXc3wyUJp34f/FzKaH4ck4hs72v57EH3b8zdH+Q+bP6h5AQrg2JFrgsj1DFyCoRx5fUcEXtchgPeQhBJk3iqGKZZw/7ryXzS6E3Rj4Sb5jwZGWQn6KVqWHAYjA/KSWISAilEpabvVUJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780666; c=relaxed/simple;
	bh=nEGbuxBRykRFhxcsk3nfLY/F3Mx9sTgZjjxcuTK+f0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZRyT8+oq3Hyu7H5sFWrz44wF8x+KB1/0LwzMf2w5tApkO/gHMQ0zF8KLSSH6Io31AWoLmpJszBcxj4ULC21noCwaUzHG+o02O4ODFp/73oijEohMq0j1JPDOy7mrJ6gXADpC2pQ/66rJozolv8JiDDdtls+XBWxCFeiVQK53Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxj5BO4g; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxj5BO4g"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8249fc726e9so71463b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780665; x=1771385465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2+pbfB22AAo9Fg9A+J5YEYX8Vl3inVVO54MfCnuT58=;
        b=fxj5BO4gvTnsK0Ow4irLuMjhcMEnmpMTKmsZ2CX15z4h3bJqNgmF7KCQtoCiSp7F2a
         HclUnhNiVZBN0RDU/OUElTj2nbpF4SDIymOgR9ctUC9GSxuHQtAoh7iz5ovrh6zv6PGF
         0UR2un9DwAWdNHUQLRfzvjwQiguF2cigxszJGDOx5xEa6jSbb89d/UbmGhR+gBhcdkNJ
         cHD5IF1SR+Ioy5Jow4wvFfjZBahegKdHQ+azHU7ArQ9nFJIlJME1Dwf6sqVAUE9lr/WP
         5ZZmXEqer6iEm2nVvdX7V5hrvX0lD5gBGOjaejoldugfTCnj0mKp+C/lE7T8nzGHrtct
         ml2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780665; x=1771385465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+2+pbfB22AAo9Fg9A+J5YEYX8Vl3inVVO54MfCnuT58=;
        b=T3e+YG7Bcz8sT0Q0HrCWtz1COl2wqUuNIufn/umQsfP+iqVvcU0SzMICKULJVfU02Y
         Zvis2rk7/xfHmIHNBwpJHs2Fi3h8cSeYxAPz9WuAdv3Gbj2MrTfchj0IEaGoIe+mF19H
         cR9vQPcIZHL+nS3pvuurQDlzVZ4HOSzW9tTQxXk+weIL1V9mrHeDpCrWCcRILvI/IM5j
         11LDOo/yjWFPqtcUbD94RVNIF2+GnfiGeVeNAS/53I3OfPsFom2WutmTj4UPusSSLFpU
         Hm3cGxXLHYSfWcSzOUDH7vlYiRJCYBYG+zEVnbavXfYMiFMGjzebAI+sr3wTuVvZG1J6
         Pknw==
X-Forwarded-Encrypted: i=1; AJvYcCUxlTUtweEMWZS/bIDFTTJFv8gJb2Fw1/70zEHKFByHctGx0+fmkV9XviKXBqZdyyABqOGjiWIfGi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7OdRsITl1brdjSmEdzsgj0RCOnqGRGJUr/1LEOGw9mcR7PCq
	oUffh57rNT7D2hxJH1JghKjrqa6SrxoiS9h+jQinNzEkP/g4WKiHi0fh
X-Gm-Gg: AZuq6aIxHpGGT+ftrwHYCL4c/aRBSvi7sn2kdfR11CbD8kbjbustTq6fiqkjH1YEvLs
	dQTWS/UuEElMfyVACSM890AGzi9dBW3cjv9ksD1mYKt3B0STbIMMuimQ4Se+wr5/eiWCLU3mRfZ
	RrrUTBaybgbGHYDe+Ujv9ouY23F3spYuo3Gj+XqV0PpX0V1L+l+bI95+bCtQ4w0REHxzfSd0TU/
	n5gbG6DezqNIZW3IxPajLpZkzeGxs0qL129bPzfuXoCTJlr571f6U6ha6DiusqX+C3SeNyh1Vsh
	ZABgD5weANz+4IV4Vdlfp2nJu8yX+CNIiAGAHEBh2PMNX1yuHcuzGLEIk9hGPrfXcbEN+cyLifx
	RIk319F04sV4PSKRI2RV/LN54SjojmuqJtd9skKeWz/0F9Z5JP361WSUwZAQZNUJ8gvAMtLzJg9
	J7zyCPJIXqeAnPIuys3l34Do1cvLouO/j4PxRz8pv4F6vn6MAkZCkb
X-Received: by 2002:a05:6a20:4308:b0:34f:2f38:cad9 with SMTP id adf61e73a8af0-3942e6994f7mr1430450637.53.1770780664657;
        Tue, 10 Feb 2026 19:31:04 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:31:04 -0800 (PST)
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
Subject: [RFC v3 11/27] PCI/CMA: Reauthenticate devices on reset and resume
Date: Wed, 11 Feb 2026 13:29:18 +1000
Message-ID: <20260211032935.2705841-12-alistair.francis@wdc.com>
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

From: Lukas Wunner <lukas@wunner.de>

CMA-SPDM state is lost when a device undergoes a Conventional Reset.
(But not a Function Level Reset, PCIe r6.2 sec 6.6.2.)  A D3cold to D0
transition implies a Conventional Reset (PCIe r6.2 sec 5.8).

Thus, reauthenticate devices on resume from D3cold and on recovery from
a Secondary Bus Reset or DPC-induced Hot Reset.

The requirement to reauthenticate devices on resume from system sleep
(and in the future reestablish IDE encryption) is the reason why SPDM
needs to be in-kernel:  During ->resume_noirq, which is the first phase
after system sleep, the PCI core walks down the hierarchy, puts each
device in D0, restores its config space and invokes the driver's
->resume_noirq callback.  The driver is afforded the right to access the
device already during this phase.

To retain this usage model in the face of authentication and encryption,
CMA-SPDM reauthentication and IDE reestablishment must happen during the
->resume_noirq phase, before the driver's first access to the device.
The driver is thus afforded seamless authenticated and encrypted access
until the last moment before suspend and from the first moment after
resume.

During the ->resume_noirq phase, device interrupts are not yet enabled.
It is thus impossible to defer CMA-SPDM reauthentication to a user space
component on an attached disk or on the network, making an in-kernel
SPDM implementation mandatory.

The same catch-22 exists on recovery from a Conventional Reset:  A user
space SPDM implementation might live on a device which underwent reset,
rendering its execution impossible.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/pci/cma.c        | 15 +++++++++++++++
 drivers/pci/pci-driver.c |  1 +
 drivers/pci/pci.c        | 12 ++++++++++--
 drivers/pci/pci.h        |  2 ++
 drivers/pci/pcie/err.c   |  3 +++
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index e974d489c7a2..f2c435b04b92 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -195,6 +195,21 @@ void pci_cma_init(struct pci_dev *pdev)
 	spdm_authenticate(pdev->spdm_state);
 }
 
+/**
+ * pci_cma_reauthenticate() - Perform CMA-SPDM authentication again
+ * @pdev: Device to reauthenticate
+ *
+ * Can be called by drivers after device identity has mutated,
+ * e.g. after downloading firmware to an FPGA device.
+ */
+void pci_cma_reauthenticate(struct pci_dev *pdev)
+{
+	if (!pdev->spdm_state)
+		return;
+
+	spdm_authenticate(pdev->spdm_state);
+}
+
 void pci_cma_destroy(struct pci_dev *pdev)
 {
 	if (!pdev->spdm_state)
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a9590601835a..d1a574e21b0b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -589,6 +589,7 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 	pci_pm_power_up_and_verify_state(pci_dev);
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
+	pci_cma_reauthenticate(pci_dev);
 }
 
 static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..7f03e07150a0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4887,8 +4887,16 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 	rc = pci_dev_reset_slot_function(dev, probe);
 	if (rc != -ENOTTY)
-		return rc;
-	return pci_parent_bus_reset(dev, probe);
+		goto done;
+
+	rc = pci_parent_bus_reset(dev, probe);
+
+done:
+	/* CMA-SPDM state is lost upon a Conventional Reset */
+	if (!probe)
+		pci_cma_reauthenticate(dev);
+
+	return rc;
 }
 
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1ab1a39e8df3..f87a4b7c92b8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -602,9 +602,11 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCI_CMA
 void pci_cma_init(struct pci_dev *pdev);
 void pci_cma_destroy(struct pci_dev *pdev);
+void pci_cma_reauthenticate(struct pci_dev *pdev);
 #else
 static inline void pci_cma_init(struct pci_dev *pdev) { }
 static inline void pci_cma_destroy(struct pci_dev *pdev) { }
+static inline void pci_cma_reauthenticate(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCI_NPEM
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index bebe4bc111d7..700663c38e31 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -151,6 +151,9 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
 	pci_ers_result_t vote, *result = data;
 	const struct pci_error_handlers *err_handler;
 
+	/* CMA-SPDM state is lost upon a Conventional Reset */
+	pci_cma_reauthenticate(dev);
+
 	device_lock(&dev->dev);
 	pdrv = dev->driver;
 	if (!pci_dev_set_io_state(dev, pci_channel_io_normal) ||
-- 
2.52.0

