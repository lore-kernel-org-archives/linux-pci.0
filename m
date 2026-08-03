Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784BD1A6834
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789307; cv=none; b=eA/w+nruyb7/fwkCJ/fBqpbAL2/y3zQ3oNQ9/L/nMGXKoplgcaUxGN4mgjfLIa+ZqSVfdxCt/TFq/7Y0XFxzajmM1N3ORYxQHzRYjHvsz1h1PX6d3gS5RJJYmD1kx58liycXdnJ1+zxhu/ooEVDxoOhiwWlpGAL1iIy3QSwqS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789307; c=relaxed/simple;
	bh=zZ+0Ys5z8pKVDZyoJ/Y0XdgribttAXdkOphSOt6WyYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BtE+fJdS6T1JwZ/baGlzz3DvAZp0wQK9YpUcnI3KAQUVgYx2FY9KctLGZHQt84TDNWdodryXstdOd6whly1i2ScniH+fszSqU+Yn5wGv4FbWFestUX80iZYjHPzoNoXTcUea+iiJBXvTnOFhAhKV8Qk5AwNpE45Bmc1h1DKqRIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/1Pb5aj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/1Pb5aj"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848479c9bd5so3233810b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785789306; x=1786394106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cixi5TIZgPhWdioZ9yVsb8xvdmeBuYTw+3rH5f+ApH4=;
        b=f/1Pb5ajV1OR07mJIrvxYlvclZNPbXKwl9KrlsmAyITkNCxBCxNQNqAiJ/0C9PUWXm
         cj7n/xptg9A1ZQyvdSVslrd+UNoVI2aW4XcmE1UCLnwR68IXvpLWlrvkRteBTmcAxod7
         fkcjkCCrqIh2MOU8G9nd882lTujLbMMFAqujnp8WoC43sqfOEy5Xy9Ouu1MyE/ruXef1
         jL99kqQqCCK4IBaytHcPshTKfiPRoeNLLP12aBmtYPM7trztLCWSkU2SxbDXYHOL0oSp
         CO7UdEA+xFHdOXUNC0MIeqXQmuooAgj52fS9AE4ld3etryIPcLvUt56FHojHmCpcLQVF
         ZE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785789306; x=1786394106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cixi5TIZgPhWdioZ9yVsb8xvdmeBuYTw+3rH5f+ApH4=;
        b=MdzI/3+YbfpU/btGRJ+qHm5eAuBUjsG0gl5VeX+gsjBBr1C9QFZbwZFBwqqn0FFyt5
         DoDhl/LcK6SNLg2FqJdUeycWVpPTrjPB2ansApkD7biIExHlqdgP46j/iZcKPFzme6jf
         WjfeaC+mnOlRbrg1ZCLWOnE8fXisXGxOtYokNvo/+7wg2nB0dOXY/KHA8BUUh2c54Ceq
         JTGZ17QolQgdgqTVNCTKHrYvgeBpR2EUAhUORay/WCkCAl3++BhWXe+q5cUXXYrz3BL8
         29AAo4dXsMoW7oM14j8DyBwKG+NmflioOGJjJ6YeedkoNfvQWCoqFTnvdGYWebM07rP7
         LMrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8ggDUP8TSKlHwakeSebmQf4Rk64DMzNx3s0pM3iUDNGyu9PCdPCwi+wNd1dR1QEKFM6JE3tlMYfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUqRzXcv3d6WLY6Bta4lmeFzYh8r7eNJmt4PaPf8HmnNgVgb3B
	w72xOpZqrZvYb7nu1Lfdx3dLZynQN5ZVf0OsddYEembqvP1MOkG+KUWp
X-Gm-Gg: AR+sD138GqxkDumcfdckT17g91a7R4q8uZfbD85Z/t4WWyagd24vLYqpLtYjJD0nnIo
	L6B8K47z22Sz+jnz3LTpoEqp1MODifryYhRkylQyO+XwZEJwEqeEu+iLK2IDeRizC6rhPgf+bsT
	N1qsI5OaCbSOMDMm9uoM62p/ANJ+cZMIjo9F5Muq+uiGjQbrLT7jT0du0lUTJSVrR5GON+kfi/S
	2QpYWoNDkKO084Hjl9lsoEgVoHnNo/rr1OabX1B+Uf2ffXbBEZjAw9erOoxATEuC8vcz0Bg6ZQE
	ygXWX0kLUKdXJiTQ49wG01Zfs3AuEHPeQc+S438Gt8lH1k+ee1M1qGCkj8W3lo2SNFEOZahpcYM
	4liMPcLy6j8IxgYSh/hViIPRwnqzqSS+JqVpW3X2p+q8FWX5QXpvpPzD83oiTgkX8uFO/5Q+ek1
	UyCD6XUj2+hOVPepkruFAl20mRHFKodRtgvwrYy29KuFBF1AuJ313w1q6Nfsb4YU0mhoucRRpBD
	nzuKc2X9B1dGP4aTn8w0bW2eSYvHssm/dT660GnLQ==
X-Received: by 2002:a05:6a21:339c:b0:3c3:7f8f:88c9 with SMTP id adf61e73a8af0-3c92a8f4275mr14233266637.54.1785789305817;
        Mon, 03 Aug 2026 13:35:05 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e47dsm60318373eec.3.2026.08.03.13.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 13:35:05 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Subject: [PATCH] acpi: pci_root: Add quirks table for _OSC support
Date: Mon,  3 Aug 2026 13:34:59 -0700
Message-ID: <20260803203459.10680-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MSI Claw A8 hard-locks on resume from s2idle whenever an SD/MMC
card is present in the RTS525A card reader (10ec:525a, PCI ID). This
issue is not present on the Lenovo Legion Go with the same card reader.
The primary difference is that the Claw A8 withholds LTR and DPC while
granting ASPM control to the OS, leading to a split ownership. The issue
can be mitigated by passing pcie_asmp=off, but quirking on the pci_dev
in pci/quirks has no effect.

Attempted quirks included use of pci_disable_link_state(),
dev->link_state = NULL, manually zeroing aspm_l0s_support/aspm_l1_support
via DECLARE_PCI_FIXUP_FINAL, and pcie_aspm_remove_cap() on
DECLARE_PCI_FIXUP_HEADER. Only by disabling ASPM on the root hub is the
system able to resume successfully. This strongly suggests a race between
the OS resuming the link under its own ASPM assumptions and firmware
independently acting on the same link based on state it never
relinquished.

As an attempt to localize the workaround to as low level as possible
while also being effective, introduce a quirk system to the existing
acpi pci_root calculate_support() mechanism.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/acpi/pci_root.c | 68 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 6f78f96332ea..abd436a10438 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -422,7 +422,69 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask,
 	return AE_OK;
 }
 
-static u32 calculate_support(void)
+/*
+ * Some platforms advertise ASPM support in _OSC but withhold related
+ * control (e.g. LTR, DPC) from the OS on a specific root complex. The
+ * resulting split ownership between OS-managed ASPM and firmware-owned
+ * LTR/DPC can cause resume failures on s2idle. Rather than disabling
+ * ASPM system-wide, strip the offending support bits only on the
+ * affected root bridge so the OS abstains from requesting _OSC control
+ * there, leaving every other root complex on the system unaffected.
+ */
+struct osc_support_quirk {
+	const struct dmi_system_id dmi_match[2];
+	u16 segment;
+	u8 bus;
+	u32 strip_support;
+};
+
+static const struct osc_support_quirk osc_support_quirks[] = {
+	/*
+	 * MSI Claw A8 (MS-1T8K): firmware withholds LTR/DPC control on
+	 * the primary root complex despite advertising ASPM support,
+	 * causing a hard lock on s2idle resume when the onboard RTS525A
+	 * SD card reader is populated.
+	 */
+	{
+		.dmi_match = {
+			{
+				.ident = "MSI Claw A8 BZ2EM",
+				.matches = {
+					DMI_MATCH(DMI_SYS_VENDOR,
+						  "Micro-Star International Co., Ltd."),
+					DMI_MATCH(DMI_BOARD_NAME, "MS-1T8K"),
+				},
+			},
+			{}
+		},
+		.segment = 0,
+		.bus = 0,
+		.strip_support = OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT,
+	},
+};
+
+static u32 pci_osc_support_quirk_mask(struct acpi_pci_root *root)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(osc_support_quirks); i++) {
+		const struct osc_support_quirk *q = &osc_support_quirks[i];
+
+		if (dmi_first_match(q->dmi_match) &&
+		    root->segment == q->segment &&
+		    root->secondary.start == q->bus) {
+			dev_info(&root->device->dev,
+				 "PCI Root Bridge [%04x:%02x] _OSC quirk: stripping support 0x%08x (%s)\n",
+				 root->segment, (unsigned int)root->secondary.start,
+				 q->strip_support, q->dmi_match[0].ident);
+			return ~q->strip_support;
+		}
+	}
+
+	return ~0;
+}
+
+static u32 calculate_support(struct acpi_pci_root *root)
 {
 	u32 support;
 
@@ -441,6 +503,8 @@ static u32 calculate_support(void)
 	if (IS_ENABLED(CONFIG_PCIE_EDR))
 		support |= OSC_PCI_EDR_SUPPORT;
 
+	support &= pci_osc_support_quirk_mask(root);
+
 	return support;
 }
 
@@ -571,7 +635,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 		return;
 	}
 
-	support = calculate_support();
+	support = calculate_support(root);
 
 	decode_osc_support(root, "OS supports", support);
 
-- 
2.55.0

