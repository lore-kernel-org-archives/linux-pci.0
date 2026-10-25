Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900915;
	b=3k+vdbauskGh0PxyA3KeMPL4rW0+i/9civcQZcwCoNk6QNu5B8vTDMREb+hgKStHW3at
	 36atx9FbWGlxHguFuK4y+biD+Lm+D2dTtyndnbkqCR7xAj7BzrEowWENRjqe+srshd1YD
	 S7dgZFkQQlSkQ+V+UmaLYbThavwVSlfSHph1WVwedy3RK9snHVJbEAxaZ8ecBAU3FNO3L
	 aLC93XGW5Isl00Cosm5reHV4hobxnp6EWLNqJVXcfevrDSX0xCsB3fXUVaw34zbtiJWkl
	 GLy6TbOVuRm4RlhifX3hmwqKnA4rF9sc+fnYlmXFP7sm2eBBTK1OTvRPNNCgbZi6dbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gibUibvdgP83xG+GS9VEMDqCdWat6T2Cw1tMDL5UgY8=;
	b=cWFO4v8uQk2f0iWIrxSTITUm7dbjLYdNM+zRet5yq+ncor9tndc6eYrel3/KXIBgq/sp
	 aRbnaJUP6L9nauhKowqv3HZPOpQh6tYDxHzTifmu2IFObNk2P9qOxXgubO9IbtHjFDM0t
	 eNqzVe8xLvQWhLu3/jkM+YDiB9U6Lk5UMd9YkgaHYEbZQhG0bVyomdlOYyKL9NihSocUx
	 UqIIZvUrFMfPoJ3trhLKxRYyjDjYLrYcGXP1ALJEVf3ODhMmIpBR7rXbQ/m5ThgMCtnwG
	 VhAx/uq0o1R5DXi8ycKSv1cZM7RoaNXGXIJFN0xo92C/UdUdTGqy0kj+8Lf5Uj+cbyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GtXclqD3;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E1C606A31B
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4E1C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GtXclqD3
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1931ff67a29so4176844c88.1
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792900914; x=1793505714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gibUibvdgP83xG+GS9VEMDqCdWat6T2Cw1tMDL5UgY8=;
        b=GtXclqD3RPiO9qfAjdxm2/8/bNf068OSXxCp91ix/6CZYY/CXIHPFXmZ9CpLGtrcWd
         palAgkzrt+8SBEiHtf2UlXFJdfdYXdHFCJtvoPy/g2cqjJcIbokymdlpFWn+oMzDNvVS
         GmHoy4gHXM9o8CL7LmYMSA4FQtVf8sZGlwEAgShTXJK2QAMm23lN0d+IIeDOKH+EBZ4E
         hsMC5V+ou1+kkLfkRsrs8sjFynkgTYjPhWE0wfxwQuNNxLKNLBg2f4KS8IPCU1FQILZw
         CmZtwOjiK0cZKzJOm7oXMYQ5igvYbCcy6pQ71KecKL4oD3VwHAK0r6OL4oicKyNdq1tA
         xcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792900914; x=1793505714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gibUibvdgP83xG+GS9VEMDqCdWat6T2Cw1tMDL5UgY8=;
        b=GE/5Z9kTLbu1Kf3PDWsFShHxWUe8WX9Axd/+Va5tOlIZSOgayyePGXmTqgsWWeQbo2
         J+dtj3LU/dKdFUk4LdDzdPi2nIxZzrB0ce6iSRdbd53dc/okSglHyBzIyxAXJ4GU6b5X
         dKtUsTSfwlayeLV9ATXHyR8RULMlcwtrXDWdwFFogvaWddkT+jkvYbsE4eTHvO5zAGqW
         hSCqwHl2nfUBGjGys7E3kMjQtNJw7Wb6cOZjhSqHrDVaseBkLf15vxNGq+Cc5BK4iT6V
         6t9xGcmoxd1xSm+6Maq6ZrBEOYlhkuNDztIqzNcI/Xd+4AHD35FiGTv/tRNC5eIJarpY
         z5UQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMecmGYzVeduScUBlaG0KvU6Xy3O/1hKvaINkYAEUjtv0FE91ze8fdYoSkH23xClyQ8riCcQ1F+Wc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEJtQ4fA0i7kfRfTniFKPyFhTp5gElLp2sNmvOjsv9i67GagmI
	exdbTrlsPJwxtCqzRewFrph3XBO+pzlbHQ+09WZ27zpEpI9zKhLlQlE=
X-Gm-Gg: AYBFou1ggqW2PVJKYVPkPUZgusILedtBTSE4XxAr+GXcTf18+F65Uc9DsEIyhDmYJsn
	c3jVzrgCCijmGSNgyfhJ74KPy3mWNIUd8gvPOYAUvOq8qnv4py0r0ZSC15/aATyNWE8EpE4/xDL
	hrieHv/W5vDfxvgEflxHve5ujqri9BkXuFhSaAr9mBR5cDrkC8zbr+Je30l/xbaiACF/Ff8K2Yv
	IEEM7puGV/YzBmezFSZ3hIizhpy3nWi1xbK/zRMYH23O51JFh9xCndkd8RyxiWH/a5pl/AM/h06
	88P4xxGO2iZ3lGbGSd4TPVlLdshlYH1A69g9IiB+hheTvft0jaizQ53g2uwPF5OuR0DbPq7bY4B
	jiSaCmrG3NUWeHK/qeSDPIXx2CXdcOrm0UpyBmt3dFuVRHPuXOYkTovbxPjRY7Y11PkRoITl2J0
	YdgqHL0rJOb5t1Q3zKNu5dKF51SbDhp7h4aQR1HOBxUOmtk9R319FwQtF3W1BjVJz4k8VYOrkbm
	LEbxHxtneOii8cAdIeb7sDYlvdNp8T9oCmVhzMPx+v21PRZqHHLyFFQ7BMVH+PYvQJOM+OyxlCw
	m37H8rqio7Riwf8=
X-Received: by 2002:a05:701b:2501:b0:17b:fed6:7449 with SMTP id a92af1059eb24-19937abc522mr4807131c88.47.1792900913608;
        Sat, 24 Oct 2026 21:01:53 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:01:53 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andre Eikmeyer <dev@deq.rocks>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 02/13] PCI: Disable pcie port and access on D3 on specific amd devices
Date: Sat, 24 Oct 2026 23:59:38 -0400
Message-ID: <20261025040046.1602-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
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

As mentioned in the previous commit, PWRD turns off the entire
bridge, and if we read/write anything to the config space
or the PCIE space when the bridge is dead, the CPU CATERR's,
so to avoid interaction when the bridge is dead,
we remove pcieport support for the bridges, and we restrict
access to those bridges when the bridge is dead.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 arch/x86/pci/fixup.c       | 30 ++++++++++++++++++++++++++++++
 drivers/pci/access.c       | 18 ++++++++++++++++++
 drivers/pci/pcie/portdrv.c |  2 +-
 include/linux/pci.h        |  7 +++++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 795d81c7a..66829941e 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1094,6 +1094,35 @@ static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
 
+static const struct dmi_system_id quirk_disable_pcie_port_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
+		},
+	},
+	{}
+};
+
+static void quirk_disable_pcie_port(struct pci_dev *pdev)
+{
+	struct pci_dev *upstream = pdev;
+
+	if (dmi_check_system(quirk_disable_pcie_port_dmi_table)) {
+		while ((upstream = pci_upstream_bridge(upstream))) {
+			upstream->no_pcie_port = 1;
+			upstream->ignore_access_d3 = 1;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7340, quirk_disable_pcie_port);
+
 #ifdef CONFIG_SUSPEND
 /*
  * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
@@ -1179,4 +1208,5 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
+
 #endif /* CONFIG_SUSPEND */
diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b..5e9513067 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -559,6 +559,9 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
 
 int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev)) {
 		PCI_SET_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -569,6 +572,9 @@ EXPORT_SYMBOL(pci_read_config_byte);
 
 int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev)) {
 		PCI_SET_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -580,6 +586,9 @@ EXPORT_SYMBOL(pci_read_config_word);
 int pci_read_config_dword(const struct pci_dev *dev, int where,
 					u32 *val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev)) {
 		PCI_SET_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -590,6 +599,9 @@ EXPORT_SYMBOL(pci_read_config_dword);
 
 int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
@@ -598,6 +610,9 @@ EXPORT_SYMBOL(pci_write_config_byte);
 
 int pci_write_config_word(const struct pci_dev *dev, int where, u16 val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
@@ -607,6 +622,9 @@ EXPORT_SYMBOL(pci_write_config_word);
 int pci_write_config_dword(const struct pci_dev *dev, int where,
 					 u32 val)
 {
+	if (pci_dev_ignore_access(dev))
+		return PCIBIOS_SUCCESSFUL;
+
 	if (pci_dev_is_disconnected(dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index a9cbfc1d2..d2f19e566 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -688,7 +688,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	int type = pci_pcie_type(dev);
 	int status;
 
-	if (!pci_is_pcie(dev) ||
+	if (!pci_is_pcie(dev) || dev->no_pcie_port ||
 	    ((type != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (type != PCI_EXP_TYPE_UPSTREAM) &&
 	     (type != PCI_EXP_TYPE_DOWNSTREAM) &&
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107..8835b1c82 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -420,6 +420,8 @@ struct pci_dev {
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
+	unsigned int	no_pcie_port:1; /* PCIE Port driver is forbidden */
+	unsigned int	ignore_access_d3:1;	/* Ignore access when device is in D3Cold */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */
@@ -2747,6 +2749,11 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 	return READ_ONCE(dev->error_state) == pci_channel_io_perm_failure;
 }
 
+static inline bool pci_dev_ignore_access(const struct pci_dev *dev)
+{
+	return dev->ignore_access_d3 && dev->current_state == PCI_D3cold;
+}
+
 void pci_request_acs(void);
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
-- 
2.55.0

