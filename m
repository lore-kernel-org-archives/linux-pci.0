Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794791324;
	b=iuHaq/83/K5+0+5x+pqf/ruID5cgrTn/h/DyxY+rt1wjMH3CiYNDVcyJhNEeuTTKybM2
	 LxMbSXk05z0N1u/2cs/puTGfsYS4OGfXA4RSyOXAZE6VVVfAOvUXxOt+s6zI0KN02ndjG
	 cxVhp91golVGpHArlQLmc+Ou6BF7U3DnoyEPenBSHBoCxwRKyT0G32vn57PIivmX7SYqs
	 1ygLPTCl6HX8a6F9iW0HVtXb9X6T7CHj6FwENkjxyaoriLr7OM6cRTBULq1PTzW7G9he5
	 AAvtY2ttWWBGXMtzcSyjjKY+1tkASzDiNfoaJkbGv+kE/Gg40RnwV8yRgwmlRiSfRBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794791324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mFzOX27YVk8gNisk1XMtnU2TrmoCuSj2ju0F2Azj71M=;
	b=rVeVBE+3s+pHtaUDmRT4pYMFOXz3AllYXmLTyCNHaL1ddx4of1rc6jQKm7xaKZWF7Aur
	 w73wDttKiTc3t2IZizdmwwtKoPKenTSBH5n28rMqPKsQXOs0vHZGun99ig5qRbdyucyNg
	 I5Yd9bAhEguEUVO89Uxe4yQKg4P9rLRU5RPXUHqaX2GNYyJ8Kr+FmI7UlScn6tPTz4MLW
	 svIOJWhsHmOT6AZT1zYtOZ4LflYslKfewgONgUSYGZBjsEhp5XpulTDUKHEwEUOdZxCBB
	 8+nmLcWcU8Ppu4bEvlO0skyzxcUMAdTtGzzCiV++pI+vI+bmt38ZXO9Lge4FOJBNvdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKoyY2zp;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E8606A32C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 01:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C30E8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKoyY2zp
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37198ed3727so4446314eec.0
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 17:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794791323; x=1795396123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mFzOX27YVk8gNisk1XMtnU2TrmoCuSj2ju0F2Azj71M=;
        b=SKoyY2zp8+yXqlocJW7opDJjUYrUD09ncBiC+biblc+vuLAbNfbb80yKkxvkacrPyI
         Tjx9y6EE5mtNBQJVzaNqtcV0J4FWg/Dkd2t8gcKndjAXUQDWPO9ImjG0bAyGhtrjzw2G
         1TfzLkZt/wvlArX3jBTHT1pu9e82lueS07e/Sg1j/jAw4thV5yTaAPFS2doOihUMKSBB
         49t2sC6g846SvXroY88AFioqgV7WfxzSiFdNyhN9xtv580sP/7evt7otvj1GDUJVKhzD
         9LNORNwv/0SFSb93y/hD5E3jwWoNjGucCl9SBIIkK8HS3ynHCeUAir9Lsn2ChNIowtYy
         L5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794791323; x=1795396123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mFzOX27YVk8gNisk1XMtnU2TrmoCuSj2ju0F2Azj71M=;
        b=bu/lzUPy5SEdOMBZT/So0yCzTeFP2IAYEK1RrUU9cpU+1hJEKudGyik/+7c9Z+FLX/
         JnblUSdpOeefMYeCWYVlEvODljhwXhxX3RGMJO03qiyPwT/wF3rSnVUuFw6jizhGNZIj
         EefmZ8hgp8L5g7+RPPdFlv/vrPrqQT9d/9zrC2gfvO3+LsryLO/Gqsf0wCwUseUPk8lR
         +ykPZrtaww4ts8m46+XkCKlTp09fthDnH4NdiLvuQ0R+MH1ruimAEkLY+J/tQTeR1mvD
         rhZJbY7BJukGneeZpm2l5xi1EMb1Iyiw1wKuReLx7jRddg24rkemNIqW/qbOi0a5QRCF
         3XUQ==
X-Forwarded-Encrypted: i=1; AL+hErEF23Es7ekDgb2Hg5fJ+6703Vfee3FlNOynHKaNkAHDVWN8aAJQz/7NJpRvJSGMPaFk3U0mw1hxi3o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/rutjRV70bmTkuWzCvkTKDpTx5XFfXCtmtMv6MutzDPA5NV0H
	xGR6c+Iz9jdp/G0uHHscOwcqpyc7RBpOQxltuzomb2a2XRYlHl9QvlA=
X-Gm-Gg: AYBFou0ZL4Vd0njlG2Q6vZNdpCTlSewGohVglaYblG7uUDQfamJ0xFkcB3+IQIZ+QuL
	6EzVVRNnBJ2QbIcJABWs4P9wcK6xAA+o/xxUIZYDTM4pEWLVfTYi5V4m3SgntB0NgIFnSP0qC5R
	vn0e10NkqWZAYjK+Yud/6HRcEsyMgCPA34NPr5vWW2NlDRL3nr3+0SUZkGfrfnLfLj1C7/xUAL4
	dmWTVbdDKSnfDt8+m+/2SIVyTrztYF/XiKN0xIrIIhnvkl1PC7KfKpyHDF9b3bcgTRPPLCgiUG8
	MDsqopKt5nNqVhYzmtbphCU9gvfF/8xn2YEzmXpVasx9YgssqdBjak64BzjJGe4PRM3euC39Ua+
	D15JflJIAoxC50uPHJZAD0l0cu1h214UB9Yq/IHrmg+wrXwvntQUeP4hoHJ/1Z6UEPYM8XrpoZh
	0TSazZAapCDHrk+BEYHiO4WInJZpWOOWc6y4mNhOxWjzPgx3tNZavr4V2gBViMNkhrVy4iYTh1E
	swti0Y2Yr7Fs1EUEYuqOFCA3+wFOnB1NooBzBtr3LF+AzE/fsaKvr9gdSwMcsWWj9BI+o4/t7t4
	OIcwjdmUSxnGa7f69BCLMQx1738i4fweZLUvQA2GqI6OiIEOoAyqzFqfpEwSeK70TwRbVf++a3l
	lJazFi+p9JA==
X-Received: by 2002:a05:7301:182e:b0:367:a092:3c73 with SMTP id 5a478bee46e88-377e1016111mr10414537eec.12.1794791322602;
        Sun, 15 Nov 2026 17:08:42 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.120.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379508762a5sm28611259eec.0.2026.11.15.17.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 17:08:42 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Add quirk to mask ACSViol on XHCI on iMac20,1 And iMac20,2
Date: Sun, 15 Nov 2026 20:08:33 -0500
Message-ID: <20261116010835.1191-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
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

On iMac20,1 and iMac20,2 the Thunderbolt xHCI (8086:15ec) triggers an ACS
Violation on its upstream port whenever it is runtime-resumed from D3hot,
e.g. on suspend and shutdown:

  [  141.535310] pcieport 0000:00:1c.4: AER: Uncorrectable (Non-Fatal) Error message received from 0000:08:02.0
  [  141.535325] pcieport 0000:08:02.0: PCIe Bus Error: severity=Uncorrectable (Non-Fatal)
  [  141.535325] pcieport 0000:08:02.0:   device [8086:15ea] error status/mask=00200000/00000000
  [  141.535327] pcieport 0000:08:02.0:   [21] ACSViol           | Receiver    | Transaction Layer (First)
  [  141.535328] pcieport 0000:08:02.0: AER:   TLP Header: 0x34000000 0x00000010 0x00000000 0x00000000
  [  141.551637] xhci_hcd 0000:0a:00.0: AER: can't recover (no error_detected callback)
  [  141.551655] pcieport 0000:08:02.0: AER: device recovery failed

The violation is raised inside the 10 ms D3hot->D0 recovery window: the
port's AER status is still clean right after the PM_CTRL write
and set once the delay has elapsed,
before any config space has been restored.
The kernel cannot run anything in that window.
The ACPI _PS0 and _PS3 methods were also checked and have no effect on it.

This is most likely a hardware defect: the port correctly drops the
message, and the same controller on MacBookPro16,1 is not affected. The
error is unrecoverable noise, so mask ACSViol on the upstream port on these
models. ACS stays enabled.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 arch/x86/pci/fixup.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 795d81c7a..b7c0de6c2 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1094,6 +1094,26 @@ static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
 
+#ifdef CONFIG_PCIEAER
+/*
+ * On iMac20,1 and iMac20,2 the XHCI controller gives ACSViolations
+ * When switching from D3Hot/D3cold to D0, and it happens because of
+ * the D0 write, so we mask ACSViol at boot on these devices.
+ */
+static void titan_ridge_xhci_mask_acsv(struct pci_dev *pdev)
+{
+	struct pci_dev *up = pci_upstream_bridge(pdev);
+
+	if (!dmi_match(DMI_PRODUCT_NAME, "iMac20,1") &&
+	    !dmi_match(DMI_PRODUCT_NAME, "iMac20,2"))
+		return;
+	if (up && up->aer_cap)
+		pci_clear_and_set_config_dword(up, up->aer_cap + PCI_ERR_UNCOR_MASK,
+					       0, PCI_ERR_UNC_ACSV);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15ec, titan_ridge_xhci_mask_acsv);
+#endif /* CONFIG_PCIEAER */
+
 #ifdef CONFIG_SUSPEND
 /*
  * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
-- 
2.55.0

