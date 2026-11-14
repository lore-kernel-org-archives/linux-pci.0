Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672543;
	b=F62L2tzlMqS2wDleC7GmhV+vTROJo6l+3d6MErp9deJJtumpvJW0/5Op61m9cLW5YlP3
	 623khcDXuoOREasgqd2ryE0NeyDmvw9YnV+MxYPDMtsmnlWf+DhDCFOP1tVxLe2fF+deP
	 eA1NMLsnErMIMW1GVSiv3xRaAIhmUXAjEM+R/udobbuSYk3z9FrgMAPeTFOLeEvPQ2PIK
	 U6aHKPcF/IeHn6MV6Kvvc0y3DcwuKERyLaxnsfR4UvaMfc1ZHQry1blFpiIWeiejnzMY0
	 HJoHdaXQj5cSQDwH2ZpZZFQv63J4A2h9XMxjF6Q4FPrrjyhDHd7SZd/LsZsma/FFstw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+LcEkWrq+TcQgEw8Wv5fzNU6IOsV4OoefE8SBVTJLlU=;
	b=zLmZyjRCuptdWblPOy3+1x9oIldQmLXXurkB3Qi/lYpj3ujsld1ZepjEyuvyrV0q4+/c
	 O0WUPOSpCkQGz486xxjYkUWpuSgAdi2iB9c3m+jOmYZ+ny4mzf3FScKKIYrca+Yp/v2j2
	 lqGOO4QXKM9fl5Jlqu4UYuYLKse5foih5D3W4t08kZqCcgS1qmoAv+Yu9cbP1hHPa1g/B
	 79t64SPnzzHVRpAV+UGwyuOskoYOMdwIabX759Y/91oAg9OO0iQFdidkCesKw2FuGzg67
	 XLOXxCEcRP1ztUnGMtV/c68A9EhFiX9Gy83FOLtVMaNKH0PLRqcHRQAtpLRgXfd6usw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwmMlYc2;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A14606A32E
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22A14606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwmMlYc2
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3720addb068so3246060eec.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672542; x=1795277342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+LcEkWrq+TcQgEw8Wv5fzNU6IOsV4OoefE8SBVTJLlU=;
        b=QwmMlYc2sVgMn8E9hE3ob5Yq+vDS4hjwciqsN9LQdZ9WykVUJsFGwE3j1sdZy4XbZw
         d8LMNc2qt4zv239xZsBIwmtMfYXS0j3JnrIbcYj83uoM4ZmveKlU5k05lsO3AGqba8JG
         Kt3bk4bChLNWbS8vMEnc3Qqyvb3NnEsmfgy1WW7Mj+WZc+c252XIYv8msld7bxuWgGzW
         BoWBrO90SpkYvgqkGe2xZCpQZ6YJz6zUK5Zm+ZflPlCSEfTWCw2m9lF6R8Y2kjtIamI9
         VSUbuMbNB2mxGZ5718mlUiv7Bn3zYPU7XC00/PE1qqzrbBQugRP3ntm9tTyaLjdoz8Zk
         FvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672542; x=1795277342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+LcEkWrq+TcQgEw8Wv5fzNU6IOsV4OoefE8SBVTJLlU=;
        b=LgLzCs2X+SxOUEoNTXIl6rh8YIUWKkA3N4zM2tFzBqTG8cSySEl6fP8f4+1PzusSET
         gy/j91w8ERi8+mP9im9EUsOxUFNe19VxFM0eQu3usgYbkGxHz3b0xqMoSWT6x8mSarb1
         eXmqrrIs5w0L5mZKLz5lG7z61/ExOEzSpjePhoDllcrdeJs1pkTWeFbBajoWsBneomcy
         qBjIWVvUCh+lyCGRp+UiP9PwZeW8ZNXy+j5MWvDAb3jCivARtEmVhDHfCbVMKgYTbu8x
         YPk1eHbZT7/EwPwWOSyrxG6vbQhVL6oRz+1nNXxAVc1Y2B8r0T/K2JgwH4GY61/dvImP
         7WeA==
X-Forwarded-Encrypted: i=1; AL+hErFKMWxOq1A7Uhr9ObecDoOSKsGVyU/8pkmN6cFXASSC8Zkau2P4NXkFiOyAS0V/2qlOj+eF8CuU8TU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fhXhytFQbJZVh72XqaCvHUEtW3kKzt6PAzxQ5AXjf7zHOaj+x
	ZuqabMyN8OAN/FOJW1GxMUkihAzBxgUaTzic7ghOD6ATkEmIpTM7dW0=
X-Gm-Gg: AYBFou1SfgHJxb5QKXRuaSA4bk+FdrhMSbSzWOvGSoXBdH0ApBUYX8YqR5wxQx441//
	Ibuu64rclRhnb43JmgMRKuAAugW3V9l/q1eLy+ocihtSZNwSiYp+QMkKY5Zh4r3wegxHmNHSRkP
	JlwgpuYAKxSLSNDiEgxtlz9GB/3gL1ME4q0NWZIxeabtpc3cCYLvO4ZisWL2Rz0sVqk2hrRosUA
	no20qZ66mx5o+/wgPLy74UyaSCeko0GoYxhH0R+1AUyVW8wDn6GXIkC8NEKh++RRHBDCuIoPtER
	DC+SVczGOYQ5Aa8kJhZ8gtRlCIilmfULpk0HuIwLL7J0DxLIaLy6Bmwb1NTbAqJ+6Azei8jJY+e
	+rT/z5t7YlBQb9qGoX9Q6FmFLQwnu2rOu4GlIKJI7YuYunGFD5xltwcHOeV5eTiYOQWEg3Nj596
	A72psmdt6i+Sn3UXTwPiET2B0wB3fxHRx8QNOy4isxAX0IeVwMe9pRINbu05on/Yrpmy4VbY2/W
	RYP8r9jFln0+wrFAqYf8iVQdnTWlJKu4hjfnGWf2myjtIWQHTExvPsu7gASwf+3PAsV6N9IG1Ml
	qbntzXbj8/2K4STnNpVkJOrf44rznzL6Hp27Wosy5r6sPIJcIvBGrbUWnXUfA7Bkkg==
X-Received: by 2002:a05:693c:4019:b0:35f:2858:aa4b with SMTP id 5a478bee46e88-379675fc9ebmr5136627eec.30.1794672542162;
        Sat, 14 Nov 2026 08:09:02 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:09:01 -0800 (PST)
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
Subject: [PATCH v2 04/12] platform/apple-gmux: Fix Interrupts for MMIO systems
Date: Sat, 14 Nov 2026 11:06:28 -0500
Message-ID: <20261114160731.3756-5-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
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

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 101 ++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9625551e5..37ba20779 100644
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
@@ -22,6 +24,8 @@
 #include <linux/pci.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/debugfs.h>
+#include <linux/workqueue.h>
+#include <linux/pm_runtime.h>
 #include <acpi/video.h>
 #include <asm/io.h>
 
@@ -65,6 +69,10 @@ struct apple_gmux_data {
 
 	struct backlight_device *bdev;
 
+	/* interrupt handling data */
+	u8 external_state;
+	struct work_struct interrupt_work;
+
 	/* power handling data */
 	struct pci_dev *discrete_pdev;
 	enum apple_gmux_type type;
@@ -103,6 +111,7 @@ struct apple_gmux_config {
 
 #define GMUX_INTERRUPT_STATUS_ACTIVE	0
 #define GMUX_INTERRUPT_STATUS_DISPLAY	(1 << 0)
+#define GMUX_INTERRUPT_STATUS_FAILED	(1 << 1)
 #define GMUX_INTERRUPT_STATUS_POWER	(1 << 2)
 #define GMUX_INTERRUPT_STATUS_HOTPLUG	(1 << 3)
 
@@ -412,8 +421,8 @@ static const struct backlight_ops gmux_bl_ops = {
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
@@ -777,9 +786,10 @@ static const struct apple_gmux_config apple_gmux_mmio = {
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
@@ -788,8 +798,11 @@ static inline void gmux_disable_interrupts(struct apple_gmux_data *gmux_data)
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
@@ -806,23 +819,78 @@ static void gmux_clear_interrupts(struct apple_gmux_data *gmux_data)
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
+			u8 external_state = gmux_read8(gmux_data,
+						GMUX_PORT_SWITCH_GET_DISPLAY);
+			if (external_state != gmux_data->external_state) {
+				gmux_data->external_state = external_state;
+				if (external_state)
+					pr_debug("A display has been connected\n");
+				else
+					pr_debug("All displays has been disconnected\n");
+			}
+			turn_on_gpu = true;
+		}
+		status = gmux_interrupt_get_status(gmux_data);
+	}
+
+	gmux_enable_interrupts(gmux_data, 0);
+
+	if (turn_on_gpu && !gmux_data->external_switchable && gmux_data->discrete_pdev &&
+			    pm_runtime_enabled(&gmux_data->discrete_pdev->dev))
+		pm_request_resume(&gmux_data->discrete_pdev->dev);
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
@@ -916,7 +984,7 @@ static int gmux_resume(struct device *dev)
 	struct pnp_dev *pnp = to_pnp_dev(dev);
 	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
 
-	gmux_enable_interrupts(gmux_data);
+	gmux_enable_interrupts(gmux_data, 1);
 	gmux_write_switch_state(gmux_data);
 	if (gmux_data->power_state == VGA_SWITCHEROO_OFF)
 		gmux_set_discrete_state(gmux_data, gmux_data->power_state);
@@ -1072,6 +1140,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 			goto err_notify;
 		}
 
+		if (type == APPLE_GMUX_TYPE_MMIO)
+			INIT_WORK(&gmux_data->interrupt_work, gmux_notify_work);
 		status = acpi_enable_gpe(NULL, gmux_data->gpe);
 		if (ACPI_FAILURE(status)) {
 			pr_err("Cannot enable gpe: %s\n",
@@ -1094,7 +1164,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 
 	apple_gmux_data = gmux_data;
 	init_completion(&gmux_data->powerchange_done);
-	gmux_enable_interrupts(gmux_data);
+	gmux_enable_interrupts(gmux_data, 1);
 	gmux_read_switch_state(gmux_data);
 
 	/*
@@ -1124,6 +1194,9 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		acpi_remove_notify_handler(gmux_data->dhandle,
 					   ACPI_DEVICE_NOTIFY,
 					   &gmux_notify_handler);
+
+	if (gmux_data->type == APPLE_GMUX_TYPE_MMIO)
+		cancel_work_sync(&gmux_data->interrupt_work);
 err_notify:
 	backlight_device_unregister(bdev);
 err_unmap:
@@ -1145,7 +1218,6 @@ static void gmux_remove(struct pnp_dev *pnp)
 
 	gmux_fini_debugfs(gmux_data);
 	vga_switcheroo_unregister_handler();
-	pci_dev_put(gmux_data->discrete_pdev);
 	gmux_disable_interrupts(gmux_data);
 	if (gmux_data->gpe >= 0) {
 		acpi_disable_gpe(NULL, gmux_data->gpe);
@@ -1154,6 +1226,9 @@ static void gmux_remove(struct pnp_dev *pnp)
 					   &gmux_notify_handler);
 	}
 
+	if (gmux_data->type == APPLE_GMUX_TYPE_MMIO)
+		cancel_work_sync(&gmux_data->interrupt_work);
+	pci_dev_put(gmux_data->discrete_pdev);
 	backlight_device_unregister(gmux_data->bdev);
 
 	if (gmux_data->iomem_base) {
-- 
2.55.0

