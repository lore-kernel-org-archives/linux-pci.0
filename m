Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672611;
	b=KXKWoNyUvqIylTcNAz9xPEZcANr70rOdbRibDQr/knwOIdx/p7F1UsIBhxX5W+LJCupK
	 3YLuOs1pH0DoFEWuUKBLDvWjmQ34hysGyQ9TI3JCq1uAJx7j0ZZHJhxTCGa+4iuYMzj2Q
	 c4O/jjq6T9/noVFB015whv+C0LNK3muTczMmD4WqWUZmMTz0ofxKAwsQHw949f9Nojxk4
	 LEON8eYYndLZAoiaNUB3DbXDenFRpnKEiC6f88tx0z3+1Xfek6i0Qew607IeVNXR2rJjg
	 2GhuAD15MyF+9tv4bXIYMTce/89zzjwN3YzSfYI7ZrktTOzm581zIHxiodgx08NzyxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6i90yi+2i+h6vm8bBYguarmyscARAWzwRKq+KdO6ysk=;
	b=HzWS5rh8+zyVGh5yXB7K5OCP214PRCqObhSpXm+E4/Eu5k3RJqFON7JZOfqlnXKS8hu3
	 tDOuueA8nVzAuh1Gt1JqqvXE5HhPp0/7sm181ilVBYLTw8zFaPaNR53emxsQ2qZILyJKj
	 BozHq7NXgI04D5fzTBng5AbVyzs0iaL8RORugMFzR2+/r4+3O7q+AgH0QQQOp/bCkz09s
	 nPELUkKT99WGhG1uaRWdzTpTSpE76KsKwJZO4EIzpzLkKCDkLjXrtJY+1EnL0AedpNFwX
	 dEpPYCxdsfMYrcwmKSMnEniuzazQDhyaF8wWVyi1+ZMb/eA1DB3emFNMhGK728CLM5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwFCVOLL;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCCE606A330
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DCCE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwFCVOLL
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so3782576eec.0
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672611; x=1795277411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6i90yi+2i+h6vm8bBYguarmyscARAWzwRKq+KdO6ysk=;
        b=CwFCVOLLhiEHshMZsg6/sYXV5cp7WDUz+hQNL9NNXxWGbtLoHqh2BXAPyJziHEbeFE
         zAX00w7mAqUFr0WKSBc/bJTH5AFyJX6m+M/J+urR9dTUOOY7efM5WRH/o07Kobds0jhT
         nLP1EyM+xqBgH1PPqruPxV2NMfgR8G9zoulNDVGJS2zU3Ciqr7bwNp68BwmlVxRi2gQD
         kjh8TH7Z0RSTEItYnM5QFaaacxoCy1HGmLhKxtUvCTzGLgQ8AksYyBb/eHQRORMTPhi2
         aUCmZKilrrn1L8hgem21MHoUEdxkMk7T7ZnCdUaE0VGFx0Kw0g7qt+OU+VyA96sKUmE8
         DidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672611; x=1795277411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6i90yi+2i+h6vm8bBYguarmyscARAWzwRKq+KdO6ysk=;
        b=yAJZNhfdPI16AklZ2xrUbmHiIR+b30NUqoq0Tsx7lFnzSFjl0emG+lOFVhyK42kNtw
         DIcoC3BApOtWhjxAl88jRjsgloa6kNKodIoIs936YCbtPHk5dfgiTA3z7OIWKYO9DvtI
         LPNLrV81/ei39QrBrZL+IiCjxWgwOIRgj1ef77B/HSqt0x+siAe65nF5RMpUaG9Y9ynb
         FuFdSOXbmE9UOOO88Zd9dez5HUulzvSRjuAAtZ7kFff8uONQ7uOhVp1rdbPCqZ9vd3gL
         N/FdZTRmjRoiZW4bdKQOJl64EZJnEcutWYk4EILbwZckuGsR2tQuJK3yRB4mFzK+HfaU
         Ttdg==
X-Forwarded-Encrypted: i=1; AL+hErHUuFAO2ojzAcSydKoB6kTHdc39LZG+V4VJ58pjG31VlycYi4coGlS6dgBG5FxlNYy9b/qrlHaLsgM=@vger.kernel.org
X-Gm-Message-State: APuU4Z81+6SnZduTnJNrMTndsIPmTLtDxur9oT27h5+riLOr5kXESsLo
	cOqDLyoXEa9hKSwtkHn0ouQewacscksUkf7zc66XodL1qHiLvX4wuKk=
X-Gm-Gg: AYBFou0qCEn0Iv8GaoHQLie8CHqHRZbJf0tfsMDCoc5NE2eQuTdwiFYvmaAkdCRnMDv
	YADVGO8D3grHx4YI+NLaD/DxGNLnvh1S8aXJt+wQU4uQEz6WIoiOH7Hyu8yroaO2yvp5lI6smPf
	k7xz0FtwvBto8b9Dnnq5MzlxZ55qsUZIt9xzYLWoNCmFn3A4FsiAcQ5JmLdc5zme73svM/2WLK7
	Iv8VciVXqHRnLtvqUrCH0OJT+wxCXxQZPbr775nNTayS4U4mqKEi7obc62ppohTBKHwX62aCls5
	09LkQ01bS/amixJy+wzX5FMmmqGoiuWTGvYBQXmNh4EDIiKYR4Q2rozGrUcVd2odc+Lxilq9r5m
	C0/3lbJPn4fN+JEi+0JPEr93z2awgNPobQhXiA6eACX7X4nGRVW+IZfleZQFjVt1M9Ly1aC/Zsv
	I6BkQUBD/VpcVXvFGl+SxMOzzCbj9+X8BTwrQ+mUjU0yuwnqGek5rqck2gmBafuT/KiKJrZIiKV
	1asv+aBvYaS8pQXjbXVB8CFjb1h7qhkrnw1bhwtCFlB9JOtBjmnqSqs23YRjCZgjtB6Axc+XZv3
	wwyeBSTLH0O3i4B5YT3mcYDbK66VTcfMsFrgNA8ro9Gao7snhU2mMgqg3yfsajyb6g==
X-Received: by 2002:a05:7301:540d:b0:36f:4d62:2884 with SMTP id 5a478bee46e88-3796721cfcdmr5462750eec.30.1794672610471;
        Sat, 14 Nov 2026 08:10:10 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:10:10 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>,
	Sebastian Zygadlo <szgit@icloud.com>,
	Yossef Osman <yossef.osman@proton.me>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
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
Subject: [PATCH v2 08/12] drm/amdgpu: Add Apple GMUX runtime PM support
Date: Sat, 14 Nov 2026 11:06:32 -0500
Message-ID: <20261114160731.3756-9-atharvatiwarilinuxdev@gmail.com>
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

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 56 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 43 +++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 5 files changed, 97 insertions(+), 19 deletions(-)

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
index 9269e780f..ac336594b 100644
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
@@ -570,6 +571,46 @@ bool amdgpu_device_supports_px(struct amdgpu_device *adev)
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
+	       !pci_is_thunderbolt_attached(adev->pdev) &&
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
@@ -640,6 +681,9 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 			/* enable PX as runtime mode */
 			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
 			dev_info(adev->dev, "Using ATPX for runtime pm\n");
+		} else if (amdgpu_device_supports_gmux(adev)) {
+			adev->pm.rpm_mode = AMDGPU_RUNPM_GMUX;
+			dev_info(adev->dev, "Using Apple GMUX for runtime pm\n");
 		} else if (amdgpu_device_supports_boco(adev)) {
 			/* enable boco as runtime mode */
 			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
@@ -3767,7 +3811,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 {
 	struct pci_dev *pdev = adev->pdev;
 	int r, i;
-	bool px = false;
+	bool gmux, px = false;
 	u32 max_MBps;
 	int tmp;
 
@@ -4202,12 +4246,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
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
@@ -4336,7 +4381,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
 	int i;
-	bool px;
+	bool gmux, px;
 
 	amdgpu_device_ip_fini(adev);
 	amdgpu_fence_driver_sw_fini(adev);
@@ -4367,11 +4412,12 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
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
index d9d794a7d..3978ed284 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2398,6 +2398,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -EINVAL;
 	}
 
+	if (vga_switcheroo_client_probe_defer(pdev))
+		return -EPROBE_DEFER;
+
 	/* skip devices which are owned by radeon */
 	for (i = 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
 		if (amdgpu_unsupported_pciidlist[i] == pdev->device)
@@ -2494,11 +2497,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
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
@@ -2610,7 +2614,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if (amdgpu_device_supports_boco(adev) && pm_runtime_suspended(dev))
+	if ((amdgpu_device_supports_boco(adev) ||
+	     adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX) &&
+	    pm_runtime_suspended(dev))
 		return 1;
 
 	/* if we will not support s3 or s2i for the device
@@ -2881,6 +2887,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	adev->in_runpm = true;
+	/* GMUX dGPUs drive displays, so hotplug handlers may reopen them. */
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
@@ -2891,7 +2898,8 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	 * platforms.
 	 * TODO: this may be also needed for PX capable platform.
 	 */
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO ||
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
 
 	ret = amdgpu_device_prepare(drm_dev);
@@ -2900,16 +2908,19 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
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
@@ -2956,10 +2967,12 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
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
@@ -2979,12 +2992,14 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
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

