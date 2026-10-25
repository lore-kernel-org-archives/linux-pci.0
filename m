Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901010;
	b=ttZkhd2nS5zBKPQel67kNbAGKcQ8b6jaVDkuvOeMrnGZZduX20FVrLe9N0/YUMIbXLSk
	 2nYrz2wsZLy+r3D5Yf67dJN9z8DcHcKgBRVIYBTJrR0epdkDPegpwCSoTIkiw6X/q25lW
	 0hhO5SaFFZVo+KpSjLC3lEtf9yUwFLRRHsnW1VK8wqnx2fV94IeMMUkMJJy5pPnqwxJke
	 +Q8VjlTx+Uvdrlnx75Af5OdQvZrz8kGQ18zMIVJgc1wGqI9KH0RIhqHWeQ4UHZoMEfVpk
	 9HTqwl6dGIGs7qcYdIIf6E8XCz3UXIj2L8uGQINnrn/zUonFG7QyGv15lO8MC+0SJ4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ld0b6jnrv9lRwiEj850RVsyn17/7q2cRzxdIYpNocEM=;
	b=1+/m5ETHD2gTLxXXF5N0LZpYHTFG2DmjX0GO2biNxZhILcnpGlFkF/ftPmtZ0+YmKXrh
	 2Gq33sNiB79la0EObJ0qv0pEKDucvuwYImvDjRiaaVjSqOMlj/HAbSMuMobKu6LvL347B
	 51V/ZTGhEX4OJPyaFvojJbAO9acMpMrHrdZBMNvsoD2rSB2ZFr0NAkjC24NbO3H/XTiT0
	 uShQLtAsgPTkdTa/IaeMhXWD3+krzLZraF8ZadJsZBpaLEV8tgkY15ZcP8BdmV4GLhFSO
	 6/IFMhf//K+OXdP0/TnxFAEbmrj+2ZAqP8BhfR/zqqy/PxnOac9h9fi6QjD7ZVQG0cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AM0uRj5N;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F565606A31B
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F565606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AM0uRj5N
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14fc585291cso716520c88.1
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792901008; x=1793505808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ld0b6jnrv9lRwiEj850RVsyn17/7q2cRzxdIYpNocEM=;
        b=AM0uRj5Ni7AVIcmLeHYqnhgJL5glYj9pmfjYAEkYwXLA2M3nSbfZFYqtnxRtrZ4b7w
         8K9zNrzpqDaFxY3kFaYiDnyFTPvmqZgUrPrQVZrf81hzVR+aRanRnZWNEa94ExLC5ASH
         I1X72VUzfiUVdGQq6ClApCjwhoBBCluFlr72HHCV8nqALB7wIs5jX5dwOjSpF2uX7xr3
         m71EfYgUvlCOzGXNE6+y7OVqHeFb7Ynda5dYBuVvuCiGmwsjoqoYsikXjJyjNSJRsYAf
         +Gab036V3AH+boxsd0vqnpmWph3SCV4aFwjmnk+JOaXJ3Te3yTrc6inSfOqw79cd7a9g
         rRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792901008; x=1793505808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ld0b6jnrv9lRwiEj850RVsyn17/7q2cRzxdIYpNocEM=;
        b=HPwhLWbRI52zRlB/HLtTPf6rtYMU8bPLHZ9u87d993unLCikLsiWCD1ellwBBKHcVr
         s4deV2kJaD9K4d8pqm18Iaxarcmc1Yas28ViBNQp9AIfVL6hQEEbaHobsR7TtUpG3vf3
         SYQnZQs5iaN7CQQZ7XFNW7y92ln1fPgM4L/9/pI97gp+Faioq3CTOjTAXYeZCiEJbLIP
         ifQlFmUbKvabkpkIpZcLfdFTZaRJ4e8BYxc5YkLyMxhcQVUczEN5AlwhkNoQVqGaRZgr
         DHtyPyDwCsGPFc4T2NgAMY3vvT8K7RcvyA3Mt5iVu8b/+o8dt3DHLXSBq19/7UVPWjbG
         Ywfw==
X-Forwarded-Encrypted: i=1; AKwUvBw4Fqz/8nX7Moy5zl6VGPjbkMI0abo2mWZnffoJ8kx3flbjThybke2Iomx1K9W8v1MCMI/3H9N8dj4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKax3eyQss1pWA0E5hD7S1U6kgSKDlpGM+VQK+6Ej8CV+YFCGBt
	K5lBonDAd339h/7mFTLE/fXNPTmXtia911IRmbO7mv5h46aYSh09Y9o=
X-Gm-Gg: AYBFou1tuCt98uIn87HpRk64P5F5lUI1gt0VwFQb9K8z3Ow+zHtvLZswoNd1M/5jY6K
	h3cxb8T1NqP1vpddY4jvfTr4eDckqlDZEODRXZG4tUDkQfpbKtl+tTu/E84HGi1WDpUA3wr06j4
	8OHpaZfO7TWfbFf+va1vqKF05nU/FO9TgDd3jj48Y5z1Qk0LnTOD+dgm2oNVZUSjnhZIdLwIdki
	9z3EaUavClyQjVXGj9bE2W2bQUKtc1vNn9/K2DcAx1+qkD/YJ75IPHCbhn9acwMg86JvGZx7Hjd
	E+2ocE7hHU1WNM4Y43Km5N/HiniCUbGww0Y+CPtbfkLvzaeIUUGR/VVtPQwcw4RXLa0FH8t9pqk
	3m2YKQiOksKT6dQPVXWvpEeHErH/wDC5HCKCm77UaNjqCnp7ssvBYoQzUoRCIzmMCyFZnV1u9vM
	uA1uZ77LmjC0wHo+rQmuoXtfTwHzcBVNJCs2B2oJxATXVHJ/K3h6fOD6xfLcJw2x25ljHn1v3Js
	DM62nO7Ry34MFxSgvYS+4rFsqZk7jwsOdvC4DgP5jT1R4tr+GZMZb3V5/9o3W9Y55I/oKAFw5OW
	LaG7UegNio8Umsc9dlHW9AYTEotrhtauncAS
X-Received: by 2002:a05:701b:42cd:10b0:187:ec67:2fc5 with SMTP id a92af1059eb24-1993702567cmr5122803c88.32.1792901008081;
        Sat, 24 Oct 2026 21:03:28 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:03:27 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>,
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
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 09/13] drm/amdgpu: Add Apple GMUX runtime PM support
Date: Sat, 24 Oct 2026 23:59:45 -0400
Message-ID: <20261025040046.1602-10-atharvatiwarilinuxdev@gmail.com>
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

From: Andre Eikmeyer <dev@deq.rocks>

The T2 MacBookPro's uses Apple GMUX to control power to the discrete GPU,
but it does not expose the ATPX or ACPI power-resource interfaces currently
recognized by amdgpu. The driver therefore leaves runtime PM disabled even
though vga_switcheroo can switch the GPU reliably.

A dedicated GMUX runtime PM mode uses the existing vga_switcheroo PM domain
to sequence GPU power. A runtime-suspended GMUX GPU can remain powered off
across system sleep, following the smart-suspend handling already used by
BOCO devices.

On muxed systems the inactive GPU cannot reach the panel AUX channel. Like
the macOS driver, tell Display Core that eDP is disconnected before
dc_create() when the GMUX GPU is not the boot display device, and skip eDP
detection at init as the resume path already does. This avoids powering the
panel from the inactive GPU and retaining a fail-safe sink that reports as
connected and keeps the GPU runtime busy.

This allows the discrete GPU to enter D3cold while the integrated GPU is
primary and allows PRIME workloads and external displays to wake it on
demand.

This was tested on MacBookPro15,1, 16,1, 16,4 together
with the corresponding apple-gmux power-sequencing support.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 55 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 40 +++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 5 files changed, 93 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a9c6f5d4a..6fd607587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1194,6 +1194,8 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev);
 int amdgpu_device_link_reset(struct amdgpu_device *adev);
 bool amdgpu_device_supports_atpx(struct amdgpu_device *adev);
 bool amdgpu_device_supports_px(struct amdgpu_device *adev);
+bool amdgpu_device_supports_gmux(struct amdgpu_device *adev);
+bool amdgpu_device_has_gmux_edp(struct amdgpu_device *adev);
 bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
 bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
 int amdgpu_device_supports_baco(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9269e780f..c1f196242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/iommu.h>
 #include <linux/pci.h>
+#include <linux/dmi.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/apple-gmux.h>
 #include <linux/nospec.h>
@@ -570,6 +571,45 @@ bool amdgpu_device_supports_px(struct amdgpu_device *adev)
 	return false;
 }
 
+static const struct dmi_system_id amdgpu_gmux_runpm_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,3"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
+		},
+	},
+	{ }
+};
+
+bool amdgpu_device_supports_gmux(struct amdgpu_device *adev)
+{
+	return dmi_check_system(amdgpu_gmux_runpm_dmi_table) &&
+	       !dev_is_removable(&adev->pdev->dev) &&
+	       apple_gmux_detect(NULL, NULL);
+}
+
+bool amdgpu_device_has_gmux_edp(struct amdgpu_device *adev)
+{
+	return amdgpu_device_supports_gmux(adev) &&
+	       (dmi_match(DMI_PRODUCT_NAME, "MacBookPro15,3") ||
+		dmi_match(DMI_PRODUCT_NAME, "MacBookPro16,1") ||
+		dmi_match(DMI_PRODUCT_NAME, "MacBookPro16,4"));
+}
+
 /**
  * amdgpu_device_supports_boco - Is the device a dGPU with ACPI power resources
  *
@@ -640,6 +680,9 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 			/* enable PX as runtime mode */
 			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
 			dev_info(adev->dev, "Using ATPX for runtime pm\n");
+		} else if (amdgpu_device_supports_gmux(adev)) {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_GMUX;
+			dev_info(adev->dev, "Using Apple GMUX for runtime pm\n");
 		} else if (amdgpu_device_supports_boco(adev)) {
 			/* enable boco as runtime mode */
 			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
@@ -3767,7 +3810,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 {
 	struct pci_dev *pdev = adev->pdev;
 	int r, i;
-	bool px = false;
+	bool gmux, px = false;
 	u32 max_MBps;
 	int tmp;
 
@@ -4202,12 +4245,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
 
 	px = amdgpu_device_supports_px(adev);
+	gmux = amdgpu_device_supports_gmux(adev);
 
 	if (amdgpu_device_should_register_switcheroo(adev, px))
 		vga_switcheroo_register_client(adev->pdev,
-					       &amdgpu_switcheroo_ops, px);
+					       &amdgpu_switcheroo_ops, px || gmux);
 
-	if (px)
+	if (px || gmux)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
 
 	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
@@ -4336,7 +4380,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
 	int i;
-	bool px;
+	bool gmux, px;
 
 	amdgpu_device_ip_fini(adev);
 	amdgpu_fence_driver_sw_fini(adev);
@@ -4367,11 +4411,12 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	adev->xcp_mgr = NULL;
 
 	px = amdgpu_device_supports_px(adev);
+	gmux = amdgpu_device_supports_gmux(adev);
 
 	if (amdgpu_device_should_register_switcheroo(adev, px))
 		vga_switcheroo_unregister_client(adev->pdev);
 
-	if (px)
+	if (px || gmux)
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
 
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d9d794a7d..5ad7b6dd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2494,11 +2494,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
 
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
-		/* only need to skip on ATPX */
+		/* ATPX requires a full system-sleep transition. */
 		if (amdgpu_device_supports_px(adev))
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
-		/* we want direct complete for BOCO */
-		if (amdgpu_device_supports_boco(adev))
+		/* BOCO and GMUX can remain runtime suspended across system sleep. */
+		if (amdgpu_device_supports_boco(adev) ||
+		    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
 						DPM_FLAG_SMART_SUSPEND |
 						DPM_FLAG_MAY_SKIP_RESUME);
@@ -2610,7 +2611,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if (amdgpu_device_supports_boco(adev) && pm_runtime_suspended(dev))
+	if ((amdgpu_device_supports_boco(adev) ||
+	     adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX) &&
+	    pm_runtime_suspended(dev))
 		return 1;
 
 	/* if we will not support s3 or s2i for the device
@@ -2881,6 +2884,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	adev->in_runpm = true;
+	/* GMUX dGPUs drive displays, so hotplug handlers may reopen them. */
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
@@ -2891,7 +2895,8 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	 * platforms.
 	 * TODO: this may be also needed for PX capable platform.
 	 */
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO ||
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
 
 	ret = amdgpu_device_prepare(drm_dev);
@@ -2900,16 +2905,19 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	ret = amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm = false;
-		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO ||
+		    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 			adev->mp1_state = PP_MP1_STATE_NONE;
 		return ret;
 	}
 
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO ||
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 		adev->mp1_state = PP_MP1_STATE_NONE;
 
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
-		/* Only need to handle PCI state in the driver for ATPX
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX ||
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX) {
+		/* Only need to handle PCI state in the driver for ATPX and GMUX.
 		 * PCI core handles it for _PR3.
 		 */
 		amdgpu_device_cache_pci_state(pdev);
@@ -2956,10 +2964,12 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
 
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
-		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX ||
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX) {
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
+			drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
-		/* Only need to handle PCI state in the driver for ATPX
+		/* Only need to handle PCI state in the driver for ATPX and GMUX.
 		 * PCI core handles it for _PR3.
 		 */
 		pci_set_power_state(pdev, PCI_D0);
@@ -2979,12 +2989,14 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
 	if (ret) {
-		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX ||
+		    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 			pci_disable_device(pdev);
 		return ret;
 	}
 
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX ||
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 
 	amdgpu_restore_umd_profile_pstate_after_runpm(adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 47a0ff2ed..aee12cd76 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -81,6 +81,7 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
+#include <linux/vgaarb.h>
 #include <linux/pci.h>
 #include <linux/power_supply.h>
 #include <linux/firmware.h>
@@ -623,6 +624,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	else
 		init_data.bb_from_dmub = NULL;
 
+	if (amdgpu_device_has_gmux_edp(adev) &&
+	    adev->pdev != vga_default_device())
+		init_data.flags.edp_not_connected = true;
+
 	/* Display Core create. */
 	adev->dm.dc = dc_create(&init_data);
 
@@ -2545,6 +2550,15 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			dm->hpd_rx_offload_wq[aconnector->base.index].aconnector =
 				aconnector;
 
+		/* Like the resume path, skip eDP detection without a sink. */
+		if (link->connector_signal == SIGNAL_TYPE_EDP &&
+		    amdgpu_device_has_gmux_edp(adev) &&
+		    !link->edp_sink_present) {
+			drm_info(adev_to_drm(adev), "Skipping detection of inactive GMUX eDP link %d\n",
+				 i);
+			continue;
+		}
+
 		if (!dc_link_detect_connection_type(link, &new_connection_type))
 			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 8e8a052e1..025fa806d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -48,6 +48,7 @@ enum amdgpu_int_thermal_type {
 enum amdgpu_runpm_mode {
 	AMDGPU_RUNPM_NONE,
 	AMDGPU_RUNPM_PX,
+	AMDGPU_RUNPM_GMUX,
 	AMDGPU_RUNPM_BOCO,
 	AMDGPU_RUNPM_BACO,
 	AMDGPU_RUNPM_BAMACO,
-- 
2.55.0

