Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672354;
	b=S7PUoL59fA50RCZwDQpBGeM0tEiezy8PupUysB+0GiMHNdSIsS2nNfvzfI4euYprhuZo
	 N5ETZGpNxmlWIKE+cZrQLXIqKc7ADs8Pl4oKUWSK28V+6uuE4iXmwM6wRvT2QjZNtlAsB
	 sJNTbPUwagowKGI4k5vjH98uxaFfremX8nMBXrT82Sk7rqRzbkasrlKy4kzdzcTcZhEe5
	 GZ5pOs0wz697JeV+5F717GW62e1DbsuIdamhbVfJqyfYqd7V1VOvR5AKmztDSERri1jbl
	 JRNe14YVdDghEB7F9aUET+ZBNrM2txlA0q7sR9Kb0k5hn0267JLRmWj9Id+rCVF9c1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rwXxXGuI8odA6JxbQFYflPGUh67I5rWeLK+lGKx8MRg=;
	b=zJ2DK1LX7VrL4Jyoyn9x3p7wfLU9uf4LVEL3IFYuWrtUg9rJFnCJCg79gXQIm6w8e4Lp
	 NAksFWEodkE0Zaw6nM8aYKeczNnpMXT3ylc4bgPdQtUQFlZtrp+DQu4U/fIe9ZBumwX2G
	 +l9Qfrb9nmUrwEVocWn7ryzsS4kqnjFY36eGMHxSUF60/IVE8yABmw3lV8rpnCRDctWXr
	 wrZ7/yyYVyaOVkpwbuy7vFMccQHUPjiTU1rfWDB8tiE4CzzD2lQLQO8EKuS7bH/hJRshe
	 aMnSTDpBGzTqzZGersTdMMnZ5YopYGO22Ss63mrJ4a46T/JfjD7a+ThzdGvFMkn0InA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylt25xxI;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388E606A329
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9388E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylt25xxI
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a3c08d6928so2740340c88.0
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672354; x=1795277154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwXxXGuI8odA6JxbQFYflPGUh67I5rWeLK+lGKx8MRg=;
        b=ylt25xxIBag8hj1X6iBLXaTpMY5Pb0x9gWZ9v811l2u2hHhfwwFVcmDKQXepxHIRwX
         c7PyaEK9KIy3GU77RlSxBsezWsRbkN21rabe7XYhjAETrN7wW9KP4nWH3/TPVufNzUfd
         35t1OD8UXG5J15P4SqlR6T6XOvhd49FQe0PRVY8EzlvKtUTbN9WIJRn8mrvRjBHRmrBZ
         GCP3W2aJfwPBRm8m1Tfd6LSkSbx/N6DqActZwrJccRYgaVjo0GKTAdjnQyZoFucqoIdr
         /G/Pb8WOS+3R2GE8c/PCNJn2mJt6Q9B5bAp718IUyI1kGJ5L8LCuBrkT1di1k/pcvR+i
         Bniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672354; x=1795277154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rwXxXGuI8odA6JxbQFYflPGUh67I5rWeLK+lGKx8MRg=;
        b=StNv08gksksj22stWQL6pNiL9qIQ6GGe/i13y5eJvjHdvSloowY/o7Fwav0wtcuGsC
         Ziw0fDI6a3NZwZpqBzAHhEPw+/a/L1o6zN/q+zbACWRqUrj2F9pab0h1AO/Hab60uwKi
         Hrly6Fj8dCP2BFmdRQBZRZ6ioN1jL52HgJJVLkceDKUZ54mXVcUIoGCGKlizAJ6MXs/u
         fF1hn329SIT5tkvXIWif1sjHCLRex6lwJDSgbQx6QIeSG7EdJRaYCHtHd4ntQxpop4bG
         1dMplCnjZOfxihE5K5XTLW1DCO8S9Y8EN83m0ppX4xE5MrC/yor5B3baAAaHrQLMiuqR
         MMlw==
X-Forwarded-Encrypted: i=1; AL+hErEqfJkeGS7reI9i4JRKAPFfHPhz9wrWOZIk6nR9zFJ3svZbwOwxIGQp0Bb6ri5DBWsKBY4gZwrqgik=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iqH8OmPKI+dnpRKneJ/UqMxS1SbNZz3JXYuKQBQxgX1E2crUP
	eonvKjv1eDvggYhzL0fgr4SLGOm7kYKivqiNKxzqnBKuEXvQk5lElqM=
X-Gm-Gg: AYBFou11KfGVe+eYfo+9pLx7P7jA6zUcpcwU5yYqXHWbtu4CxZQEuHToP2DqeF6vLsi
	PPSe6xp5U5cGrPTahk8/osit3/F0BKllQqyQKKkjBRMcgQBicI7IpDf14Tf/iLB3llvZNFroMe4
	Z12b4whemNOpDPGytPCaBHDMM8b7dGm8LAduREi7phSWy+FHKAbcHZrBCQP1pc8gJ9TA4Ri2Gh5
	FZX9NuzCyrCZhrR91p2hwF3A9IUgqcEE+I4pPH+nR/wC6wRnCVuEYkABqsQ6N0NLngD6h+hNogi
	qTXmOYzEq35bRWfw2WRqNJEJ1XyZK32M+IYZO2C+8MG8cacQYNaQio4d9vyEba0jhhMiwpWAdGj
	9uogh+V3/+kcrRqvvu56XcDrp5lltqZjKV+C744cexREMn3aXFS0B1DUaj/xZ3RiD61q6BL5sUo
	XUTXz5S/N0ffqjewoc2jz2vqvHAh7lPycDCaguoUxml1/CQZkeG2ZQ862989X9m8vntyAsxvztA
	IPg1pXp5EeOOfGa7ibapxHQdoi+6SYxROWNEhk9NOZRb71nxHHHzYeJRBbvjRxBpkrKGE8nA4Rx
	vLmgUNpiMnRJ9RtQb+W/Q6KoqrRP4IAf9bajY8t92E2yY5Aa3X95+hvTTc+QVEqLEg==
X-Received: by 2002:a05:7023:d0a:b0:1a4:fac9:aeee with SMTP id a92af1059eb24-1b50302aba6mr5983738c88.4.1794672353408;
        Sat, 14 Nov 2026 08:05:53 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.114.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b505b5bf76sm13378548c88.10.2026.11.14.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:05:53 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Sebastian Zygadlo <szgit@icloud.com>,
	Yossef Osman <yossef.osman@proton.me>,
	Andre Eikmeyer <dev@deq.rocks>,
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
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH v2 01/12] platform/apple-gmux: Fix power for MMIO systems
Date: Sat, 14 Nov 2026 11:03:48 -0500
Message-ID: <20261114160457.3034-2-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160457.3034-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160457.3034-1-atharvatiwarilinuxdev@gmail.com>
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

Currently The dGPU on MMIO Systems, dies when we write the gmux values
to turn off the gpu.

On MMIO macs Using only gmux dosent work, instead we have to use PWRD
method + GMUX, which turns off the entire bridge, and completely messes the
pci config, so we can't use pci to traverse through it. we save the
entire bridge using ACPI addresses then we run PWRD(1) to turn off
the bridge, then we write gmux states, and resume we do the vice
versa, but here we dont need to retrain the link and write the
MMIO variable.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 159 ++++++++++++++++++++++++++++--
 1 file changed, 152 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9c728ac4e..34e94f2b2 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -65,6 +65,10 @@ struct apple_gmux_data {
 
 	struct backlight_device *bdev;
 
+	/* power handling data */
+	struct pci_dev *discrete_pdev;
+	enum apple_gmux_type type;
+
 	/* switcheroo data */
 	acpi_handle dhandle;
 	int gpe;
@@ -502,23 +506,158 @@ static int gmux_switch_ddc(enum vga_switcheroo_client_id id)
 /**
  * DOC: Power control
  *
- * gmux is able to cut power to the discrete GPU. It automatically takes care
+ * gmux is able to cut power to the discrete GPU. On most
+ * Systems the gmux automatically takes care
  * of the correct sequence to tear down and bring up the power rails for
  * core voltage, VRAM and PCIe.
+ *
+ * But on MMIO systems, the standard gmux writes does not work instead we
+ * have to use a combination of ACPI and GMUX,
+ * and Using PWRD (the method that used in macOS to turn on/off the dGPU and its bridges),
+ * which turns off the entire bridge and messes up the PCI config,
+ * so we can't use pci_upstream_bridge to traverse
+ * through the bridge, so we use ACPI addresses to save/restore bridges.
+ *
+ * NOTE: Communication to these bridges (not the dGPU/HDA) in any form
+ * when the bridge is off, will result in CPU CATERR.
  */
 
+static int gmux_save_restore_pci(acpi_handle parent_handle, const char *name,
+				bool save, acpi_handle *out_handle)
+{
+	acpi_status status;
+	acpi_handle handle;
+	struct acpi_device *adev;
+	struct device *dev;
+	struct pci_dev *pdev;
+
+	if (name) {
+		status = acpi_get_handle(parent_handle, name, &handle);
+		if (ACPI_FAILURE(status))
+			return -EIO;
+
+		if (out_handle)
+			*out_handle = handle;
+	} else
+		handle = parent_handle;
+
+	adev = acpi_fetch_acpi_dev(handle);
+	if (!adev)
+		return -EIO;
+
+	dev = acpi_get_first_physical_node(adev);
+	if (!dev || !dev_is_pci(dev))
+		return -EIO;
+
+	pdev = to_pci_dev(dev);
+
+	if (save) {
+		pci_save_state(pdev);
+		pdev->current_state = PCI_D3cold;
+	} else {
+		pdev->current_state = PCI_D0;
+		pci_restore_state(pdev);
+	}
+	return 0;
+}
+
 static int gmux_set_discrete_state(struct apple_gmux_data *gmux_data,
 				   enum vga_switcheroo_state state)
 {
 	reinit_completion(&gmux_data->powerchange_done);
+	acpi_handle discrete_handle;
+	acpi_status status;
+	unsigned long long result;
+
+	if (!gmux_data->discrete_pdev)
+		return -ENODEV;
+
+	discrete_handle = ACPI_HANDLE(&gmux_data->discrete_pdev->dev);
+	if (!discrete_handle)
+		return -ENODEV;
 
 	if (state == VGA_SWITCHEROO_ON) {
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+		if (gmux_data->type == APPLE_GMUX_TYPE_MMIO) {
+			acpi_handle handle;
+			u16 vendor;
+			int i;
+
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 2);
+			msleep(100);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+
+			status = acpi_execute_simple_method(discrete_handle, "PWRD", 0);
+			if (ACPI_FAILURE(status))
+				return -EIO;
+			msleep(20);
+
+			if (gmux_save_restore_pci(NULL, "\\_SB_.PCI0.PEG0", 0, &handle))
+				return -EIO;
+
+			if (gmux_save_restore_pci(handle, "EGP0", 0, &handle))
+				return -EIO;
+
+			if (gmux_save_restore_pci(handle, "EGP1", 0, &handle))
+				return -EIO;
+
+			for (i = 0; i < 1000; i++) {
+				pci_read_config_word(gmux_data->discrete_pdev,
+							PCI_VENDOR_ID, &vendor);
+				if (vendor != 0xffff)
+					break;
+				msleep(1);
+			}
+			if (vendor == 0xffff)
+				return -ETIMEDOUT;
+
+			if (gmux_save_restore_pci(handle, "GFX0", 0, NULL))
+				return -EIO;
+
+			if (gmux_save_restore_pci(handle, "HDAU", 0, NULL))
+				return -EIO;
+		} else {
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
+		}
 		pr_debug("Discrete card powered up\n");
 	} else {
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
-		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
+		if (gmux_data->type == APPLE_GMUX_TYPE_MMIO) {
+			acpi_handle parent_handle = discrete_handle;
+			bool saved_hda = false;
+
+			/* If the power state was OFF, then we only do
+			 * PWRD and we do not save registers, as the
+			 * registers are already saved
+			 */
+			if (gmux_data->power_state == VGA_SWITCHEROO_OFF)
+				goto do_pwrd;
+
+			while (ACPI_SUCCESS(acpi_get_parent(parent_handle,
+							&parent_handle))) {
+				if (!saved_hda) {
+					if (!gmux_save_restore_pci(parent_handle,
+								"HDAU", true, NULL)) {
+						saved_hda = true;
+						pci_save_state(gmux_data->discrete_pdev);
+						gmux_data->discrete_pdev->current_state =
+								PCI_D3cold;
+					}
+				}
+				if (gmux_save_restore_pci(parent_handle, NULL, true, NULL))
+					break;
+			}
+do_pwrd:
+			status = acpi_execute_simple_method(discrete_handle, "PWRD", 1);
+			if (ACPI_FAILURE(status))
+				return -EIO;
+			msleep(20);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
+			mdelay(10);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
+		} else {
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
+			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
+		}
 		pr_debug("Discrete card powered down\n");
 	}
 
@@ -552,10 +691,14 @@ static enum vga_switcheroo_client_id gmux_get_client_id(struct pci_dev *pdev)
 	else if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
 		 pdev->device == 0x0863)
 		return VGA_SWITCHEROO_IGD;
-	else
+	else {
+		if (!apple_gmux_data->discrete_pdev)
+			apple_gmux_data->discrete_pdev = pci_dev_get(pdev);
+
 		return VGA_SWITCHEROO_DIS;
-}
 
+	}
+}
 static const struct vga_switcheroo_handler gmux_handler_no_ddc = {
 	.switchto = gmux_switchto,
 	.power_state = gmux_set_power_state,
@@ -803,6 +946,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	if (!gmux_data)
 		return -ENOMEM;
 	pnp_set_drvdata(pnp, gmux_data);
+	gmux_data->type = type;
 
 	switch (type) {
 	case APPLE_GMUX_TYPE_MMIO:
@@ -993,6 +1137,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 
 	gmux_fini_debugfs(gmux_data);
 	vga_switcheroo_unregister_handler();
+	pci_dev_put(gmux_data->discrete_pdev);
 	gmux_disable_interrupts(gmux_data);
 	if (gmux_data->gpe >= 0) {
 		acpi_disable_gpe(NULL, gmux_data->gpe);
-- 
2.55.0

