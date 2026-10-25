Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900942;
	b=e+w6GXIOfH+emrxDkfWfU7ZjYSpbkbuuGvskeE2qf9q6BVDvcH0koQk4jY/WR/JOoO68
	 kQq23IZStIl2sNk8YGKGYaCAucs4gMjw7NbEEXDoWJxryIhzZFdbojWN9pT5m7oP8ROYo
	 3WrNXqYGPH3vc2kz4RomO7wu+0ROEYRAusQ+V2BGTulY1DgMTnjJmiZLyItpBb4hV6lCs
	 e1wn63hlA+Augd+L6glJqEuiIFbWxFKuPyBDYHPmOV/6g3mDgFFm3OQZ/yBy4pkO7K+hY
	 0UuO+2NpDKwtQ/T0SMIvk3dRa2gJq+aMZ+Km0CBrMDD5BgKchq5QC/cIxSVGMm/vJnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9V8bhrkeRqD536LIpEdmwvDv4vBsMscyvHJCjoTqtsw=;
	b=rSsWJZjTbwptj+KsuKDh3wxEjs88rpDU4L3O3uk3Y2oAxenU6OxU86s8/n+R+R8kCcoB
	 Aiuu/82JEmN5eELfaRuS6QlUGMLxiPuMDq1x65Z23wZP9jaDxkGvP9M8UqT5v6wrNo7mp
	 X1bbFXjXKIi78jDVEltNiHYnPZTASZQp5MBLXNiEgPfP+N9ikpXkt+u6xqTMKKAUl84cq
	 w0oaZxHHQmIRZMp/SI13zfK+fFB+z2hmOQpZGikzhBxsO2qkk+jM2gh3SyJw4Uw4GiHxC
	 sr/ubD24OLNiv8rm/pgTspNs0XRQO+5fUyw56IFsxxcfVVWSeZS1btSjith2ra4xmqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Edbei+9+;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E612606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E612606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Edbei+9+
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-156cbe59622so1285707c88.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792900941; x=1793505741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9V8bhrkeRqD536LIpEdmwvDv4vBsMscyvHJCjoTqtsw=;
        b=Edbei+9+prgspDDlFtXr6lXH7oZp3Bu+pRv2o4XtsaMRudMu8MtLiOElGlLizbMP0k
         Fr0TeAqB3xodFxj0h3gxbXvlROmI+URcC3zF0Je3ygXwaljKwBLtEsonFhjMCIXAoZUw
         WG93PfTEByDD+FaiqAv41FC4xxi4aw0/QK/HFbyfrMz1VRk3+Yejez3Il3OTE43pcjrq
         UOZ1e2cwrNy28uOCYikzK84bIfjc6Z8BaoUftbU0X5eg1lVbmLoWj2ldfA7XCkn+ZHx6
         MBNnOyBLEO3afuJZGqWB3onxG9cDTraNZMPespPxOvJ8Z3/6qGegES/6QZuIVTZ6t+/e
         LtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792900941; x=1793505741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9V8bhrkeRqD536LIpEdmwvDv4vBsMscyvHJCjoTqtsw=;
        b=B73/0WH8QNdZrXV5TYgtRwwDlioVG3X77sswbMAgw6OKRcVwXNd3c+a+Hksm7BgCHt
         rYg8q4NzkZgt7c+z8JaEwhD3mvEoWiO2cerV9XDk8tW1IOR1z8neRY231F75AFLbdD00
         /VTOF43M1vEp/Tls9BVNCQtAH2rIuS7lhBGDxfGkjI9sKe0Cm+zrqj8RjPzPKS54pVJu
         a/F7hIeFKefWGwjhAfOJvpADNFJPxXqahmCeJDcWqHpj7w8OAD3wGGRiqiTRAq75fm/g
         Wa+wwOgOmgjYEXtKReJiXW6eDP5GzoM01sFcSRTeF6itSfriuvUT4kh8gd4qjRazY/Zh
         z3bA==
X-Forwarded-Encrypted: i=1; AKwUvBw1cVOHjC5su9rroJykIQDTmHXwU1PAv4poXg//MHjKjCmBJy8KxFyeZAjMQDQWNxwwxG9RWv0M3J8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUcYLapF57jMdGTE6yTO68UWIjDx9Nk17xn7TSNF5O7WJOet/8
	D1f6fieupVVMX5fgC3pzkRqYITJm38vglhK0VBo72IyqKFOpAN8mNMk=
X-Gm-Gg: AYBFou3Hohb9ju26Bo3zrMzc5i2P8uwBootan1BJg+nr/nNuMHoYbSk+xw0DS3OdEq/
	kJH47f1cqrvCACkr9zvjHObcGeSsJYvC3OkXCM1P/CNST71PyWC2lgnGG7MGV4jUxwnyoQNSa/I
	FXovYB4KM09EWzCUuPyOWLCVlonME63ntRIPzufjv0su5lohDiRygMfuKruOMlskZjfpANVZR3j
	sLn228EU6TU1VPYPP5HQ4zCizEFSAbD5unXdJMDc8EoceqAJpGs8htyKI42JNM8Bd2y3Dv4egzE
	KgDiJWRwHLH9P2JapM4W303YNhrMI6uw7GVPOGH52TGTYu2paN1kvKPgtFDyXCjPqz4pPfZmRFT
	lVVGqRJ0c+C1yNdXltMQpHf+AK5E+zyE0tkukUyRkanmNiNYOlbIza7ujYeWnQArXQvdw9FOkWJ
	o+ez+5r6YM782oR+qiE5uTuM+jEoZjIbvkqpMWloXKQWBkdwHsFcOcVJV7ObzTG/Lkqa1gGVQik
	2Pdj+t1Mk2EnXSjbLe21bZk6rVbI42J3b/fitVm04uHXbyswTpePhhuHH+Gt8HTE0m3U8T+1nqt
	OSwL7sC0WjHKzpc=
X-Received: by 2002:a05:7023:d04:b0:15c:1679:1cc7 with SMTP id a92af1059eb24-19936e34bacmr5319231c88.37.1792900941134;
        Sat, 24 Oct 2026 21:02:21 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:02:20 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
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
Subject: [PATCH 04/13] platform/apple-gmux: Fix Interrupts for MMIO systems
Date: Sat, 24 Oct 2026 23:59:40 -0400
Message-ID: <20261025040046.1602-5-atharvatiwarilinuxdev@gmail.com>
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

on MMIO systems, we need check to for failure in interrupts,
and we have implimented display hotplug to wake up the gpu.

Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 96 +++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 076ed7ba6..bef87a57a 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -6,6 +6,8 @@
  *  Copyright (C) 2010-2012 Andreas Heider <andreas@meetr.de>
  *  Copyright (C) 2015 Lukas Wunner <lukas@wunner.de>
  *  Copyright (C) 2023 Orlando Chamberlain <orlandoch.dev@gmail.com>
+ *  Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
+ *  Copyright (C) 2026 Andre Eikmeyer <dev@deq.rocks>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -23,6 +25,8 @@
 #include <linux/vga_switcheroo.h>
 #include <linux/debugfs.h>
 #include <linux/dmi.h>
+#include <linux/workqueue.h>
+#include <linux/pm_runtime.h>
 #include <acpi/video.h>
 #include <asm/io.h>
 
@@ -66,6 +70,10 @@ struct apple_gmux_data {
 
 	struct backlight_device *bdev;
 
+	/* interrupt handling data */
+	bool external_state;
+	struct work_struct interrupt_work;
+
 	/* power handling data */
 	struct pci_dev *discrete_pdev;
 	bool uses_pwrd;
@@ -105,6 +113,7 @@ struct apple_gmux_config {
 
 #define GMUX_INTERRUPT_STATUS_ACTIVE	0
 #define GMUX_INTERRUPT_STATUS_DISPLAY	(1 << 0)
+#define GMUX_INTERRUPT_STATUS_FAILED	(1 << 1)
 #define GMUX_INTERRUPT_STATUS_POWER	(1 << 2)
 #define GMUX_INTERRUPT_STATUS_HOTPLUG	(1 << 3)
 
@@ -417,8 +426,8 @@ static const struct backlight_ops gmux_bl_ops = {
  * the discrete GPU can then be woken to drive the newly connected display.
  * The ability to switch AUX on these generations could be used to improve
  * reliability of hotplug detection by having the integrated GPU poll the
- * ports while the discrete GPU is asleep, but currently we do not make use
- * of this feature.
+ * ports while the discrete GPU is asleep, but currently we only make use of
+ * this feature on MMIO/T2 Macs.
  *
  * Our switching policy for the external port is that on those generations
  * which are able to switch it fully, the port is switched together with the
@@ -796,9 +805,10 @@ static const struct apple_gmux_config apple_gmux_mmio = {
  * value is read and then inverted.
  *
  * Because Linux masquerades as Darwin, it ends up in the notification-only code
- * path. On MMIO gmux's, this seems to lead to us being unable to clear interrupts,
- * unless we call GMSP(0). Without this, there is a flood of status=0 interrupts
- * that can't be cleared. This issue seems to be unique to MMIO gmux's.
+ * path. On MMIO gmux's, The Polarity is initally left in a undefined state leading
+ * to lots of interrupts, that we can't clear, to fix this we set the polarity to 0
+ * everytime we enable interrupts, On MMIO gmux's, GMLV reads the same GPIO pin as
+ * GMSP, and setting the polarity to 1, stops the Interrupts completely.
  */
 
 static inline void gmux_disable_interrupts(struct apple_gmux_data *gmux_data)
@@ -807,8 +817,11 @@ static inline void gmux_disable_interrupts(struct apple_gmux_data *gmux_data)
 		    GMUX_INTERRUPT_DISABLE);
 }
 
-static inline void gmux_enable_interrupts(struct apple_gmux_data *gmux_data)
+static inline void gmux_enable_interrupts(struct apple_gmux_data *gmux_data, bool do_gmsp)
 {
+	if (gmux_data->type == APPLE_GMUX_TYPE_MMIO && do_gmsp)
+		acpi_execute_simple_method(gmux_data->dhandle, "GMSP", 0);
+
 	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_ENABLE,
 		    GMUX_INTERRUPT_ENABLE);
 }
@@ -825,23 +838,78 @@ static void gmux_clear_interrupts(struct apple_gmux_data *gmux_data)
 	/* to clear interrupts write back current status */
 	status = gmux_interrupt_get_status(gmux_data);
 	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
-	/* Prevent flood of status=0 interrupts */
-	if (gmux_data->config == &apple_gmux_mmio)
-		acpi_execute_simple_method(gmux_data->dhandle, "GMSP", 0);
 }
 
+static void gmux_notify_work(struct work_struct *work)
+{
+	struct apple_gmux_data *gmux_data =
+		container_of(work, struct apple_gmux_data, interrupt_work);
+	u8 status;
+	bool turn_on_gpu = false;
+
+	status = gmux_interrupt_get_status(gmux_data);
+	if (!status)
+		return;
+
+	gmux_disable_interrupts(gmux_data);
+	pr_debug("Notify handler called: status %d\n", status);
+	acpi_execute_simple_method(gmux_data->dhandle, "GMSP", 0);
+
+	status = gmux_interrupt_get_status(gmux_data);
+	while (status) {
+		gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
+		if (status & GMUX_INTERRUPT_STATUS_FAILED) {
+			pr_warn_ratelimited("interrupt failed: status: 0x%x\n", status);
+			status = gmux_interrupt_get_status(gmux_data);
+			continue;
+		}
+		if (status & GMUX_INTERRUPT_STATUS_POWER)
+			complete(&gmux_data->powerchange_done);
+
+		if (status & GMUX_INTERRUPT_STATUS_HOTPLUG) {
+			/*
+			 * We get an interrupt every time a display connects or disconnects, but
+			 * the GET_DISPLAY port only tells us if a display is connected or not,
+			 * so we resume every time a display is connected or disconnected.
+			 */
+			bool external_state = !!gmux_read8(gmux_data,
+						GMUX_PORT_SWITCH_GET_DISPLAY);
+			if (external_state != gmux_data->external_state) {
+				gmux_data->external_state = external_state;
+				if (external_state)
+					pr_debug("A display has been connected\n");
+				else
+					pr_debug("All displays has been disconnected\n");
+			}
+			if (!gmux_data->external_switchable && gmux_data->discrete_pdev)
+				turn_on_gpu = true;
+		}
+		status = gmux_interrupt_get_status(gmux_data);
+	}
+
+	gmux_enable_interrupts(gmux_data, 0);
+
+	if (turn_on_gpu)
+		pm_runtime_resume(&gmux_data->discrete_pdev->dev);
+
+}
 static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
 {
 	u8 status;
 	struct pnp_dev *pnp = (struct pnp_dev *)context;
 	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
 
+	if (gmux_data->type == APPLE_GMUX_TYPE_MMIO) {
+		schedule_work(&gmux_data->interrupt_work);
+		return;
+	}
+
 	status = gmux_interrupt_get_status(gmux_data);
 	gmux_disable_interrupts(gmux_data);
 	pr_debug("Notify handler called: status %d\n", status);
 
 	gmux_clear_interrupts(gmux_data);
-	gmux_enable_interrupts(gmux_data);
+	gmux_enable_interrupts(gmux_data, 0);
 
 	if (status & GMUX_INTERRUPT_STATUS_POWER)
 		complete(&gmux_data->powerchange_done);
@@ -935,7 +1003,7 @@ static int gmux_resume(struct device *dev)
 	struct pnp_dev *pnp = to_pnp_dev(dev);
 	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
 
-	gmux_enable_interrupts(gmux_data);
+	gmux_enable_interrupts(gmux_data, 1);
 	gmux_write_switch_state(gmux_data);
 	if (gmux_data->power_state == VGA_SWITCHEROO_OFF)
 		gmux_set_discrete_state(gmux_data, gmux_data->power_state);
@@ -996,6 +1064,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 			pr_err("couldn't remap gmux mmio region");
 			goto err_release;
 		}
+		INIT_WORK(&gmux_data->interrupt_work, gmux_notify_work);
 		goto get_version;
 	case APPLE_GMUX_TYPE_INDEXED:
 		gmux_data->config = &apple_gmux_index;
@@ -1115,7 +1184,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 
 	apple_gmux_data = gmux_data;
 	init_completion(&gmux_data->powerchange_done);
-	gmux_enable_interrupts(gmux_data);
+	gmux_enable_interrupts(gmux_data, 1);
 	gmux_read_switch_state(gmux_data);
 
 	/*
@@ -1150,6 +1219,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 err_unmap:
 	if (gmux_data->iomem_base)
 		iounmap(gmux_data->iomem_base);
+	if (gmux_data->type == APPLE_GMUX_TYPE_MMIO)
+		cancel_work_sync(&gmux_data->interrupt_work);
 err_release:
 	if (gmux_data->config->resource_type == IORESOURCE_MEM)
 		release_mem_region(gmux_data->iostart, gmux_data->iolen);
@@ -1168,6 +1239,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 	vga_switcheroo_unregister_handler();
 	pci_dev_put(gmux_data->discrete_pdev);
 	gmux_disable_interrupts(gmux_data);
+	cancel_work_sync(&gmux_data->interrupt_work);
 	if (gmux_data->gpe >= 0) {
 		acpi_disable_gpe(NULL, gmux_data->gpe);
 		acpi_remove_notify_handler(gmux_data->dhandle,
-- 
2.55.0

