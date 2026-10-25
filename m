Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901049;
	b=RG6+5MWeKR0aaqpmR+53SeTdVfnBBwxA9LVqTe3TUYmkpM61+C3Kou37B8A9U1anXUZB
	 TjmXxRhwkAxKi/2v5eeskCQAkR92lf0WtMOGbnN646YGIpsbBQNX6PHGcsGKFBsJsejXF
	 O13fuQ5aVFedWCYd4+vE1emRV5kGobm22G9UldcKkyj7goSlXiT2aqU+yoZvylCHK7cuB
	 wBTc/2VjLuvx7+VDmTe0po8fJs+saJJrHXAshJZ0goebxWsk/fWx6GwW6JBj+2GRQVVKm
	 rWA7ZTAZrz48QkYYPULRaSXSyLezMlplEaLCphLv2yl4thnblhv4w32rYpiGzoOquNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HlYNTG1YeavwC+hNZqZ9gnXD5hsIPEAX4XNijQPWf9E=;
	b=JTepQvFHaTl0SKjge/DjtcF0CMM3d3umR2Z4HgoIrHbN1i9F0BC4twNX5pK4uYoN582J
	 xXCBW5IUB6KF0tVuUIAwUAlrYNbZe0J2KVOqi6kw37aJ7cGtdVOGz+WTQ6ofPYCzl7cC7
	 g33F1ggYMUwlBaqioYKAGBaKnasGWGsQjxjfH9PAh2xqI5ALF+iBpyScbDQw4aJQjZYwz
	 SksqXfaNNeyAlR3U2FjF+NhIqYXBBFusD51tWLhxeSW4+RU7QPrWyKtaNZnMwi6vQqJ6u
	 G1Bz5aXeyPCaiau7biMGftlAPonVncGO6UB/XSl1KzJvfj3WDBFTjuBlkvalSnUb1yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L9SKuc6l;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC9606A334
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01DC9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L9SKuc6l
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35829219da8so3698653eec.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792901048; x=1793505848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HlYNTG1YeavwC+hNZqZ9gnXD5hsIPEAX4XNijQPWf9E=;
        b=L9SKuc6l7H2xpZ1V5KZNPlLweEJXM4cfELyqf0EUFa6eSqOjr+QKnsRdDfoyqAgqA2
         rdQcY6UPG1T2QMg6w6WpbXAlsoN8kWZykxClLarrfczhRYFUntL/t8I/giAXuzP2Cf1o
         R6W5/UB9mWrShso0fhqK/jnmBWsRHv1YUiT++MzGr3aT8hVanXIprRbcwlEUv6u376So
         KLJpOiQcPsyxLQ0JCcaKzIFEpLeM6UVYIN4EZpyjm0v/BPinXiXplRQTMBFFz40UjkTP
         i6R04EZZ9aVIgsbQ9nbrobfT1tFwoLFObp6+b/Ml61aJmmthENEB0CpO2Re2o7hZDKq8
         vIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792901048; x=1793505848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HlYNTG1YeavwC+hNZqZ9gnXD5hsIPEAX4XNijQPWf9E=;
        b=nZVc/1mPUJTbDCl0/nZF8h7kVR7Nhhei0j6hLM3zHA5zMiNAc6VRDAKVhCMzGDQWnv
         AnXq+kUk9GRhjl+WPdMmIimCm7dcWB4jjfSQiPTkFy0uzp22+3tt9NhYM7ZWso5o3X2a
         1/8NkeaQLj/qW9kK5+4jXYNwgQj8Ls0h6Oyf76B9u91YEfYBrsS1CrtHjBDKVChOB/3B
         kMSy1mODvegBHOtagv35ZN4q+UFDrV9nD+Kqa9rmyyO/hdfrQzbkewIGme/O46jn9ULp
         yjNFk79ni+130Bq0JjRjIRcN8faApgKq3WO4gPBCq391bfHyk5h7Y61Bufcm5k0uNO95
         SU3w==
X-Forwarded-Encrypted: i=1; AKwUvBxrVuj+sfCifkFLI14prwKKH1W2gO9VtMCcU3Yf2IBflsWgcfSnrjxCpamjxU+LM2KZXfxZplZRDy4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdkxaXeUluN+DX2/N9ECdSLK8GCsBLEtpM8CvJo6jdW7/N2woB
	dSJ17dn/EjIj5ZRFA+f5GxC0kPxGwXAYyt2eeXA+XNumn0DpJ28us7E=
X-Gm-Gg: AYBFou0fxa8Ecu6RsigxW2FLvDjkU1zLf2SaS3o4FbD7lx36gqdyb4crkZUtRSBUgPp
	EiewZf42qvcrj5xyzEp0r+7XgbfJvmQcBODs83ySdlXkK1mX4+gwwkGxQxBy6yBMUkfEgxTlaBM
	4VOeVwDEbHus/vhfu1JHJTNePSN0EG+gh0q7oEqBtT9hDaH5V8JUrKYSWm1MHS1eSW2+KkC+W6H
	qNxtlUxopdezH78/20vFgP98FOtTeA9Zqb02gfG/ac7L7GK/0RkQLVihB3oEtT0e0kmWACn5PWI
	xMD6tqu6VcuskB1pfIB/P2IMtiR/QUroQY1ncurh7w8hJlWu9UA7lT3E5NeYSFK3vf8FvF1z1cY
	zg4qXZFxlzKpQY8sDv9QwVKxxT/QF5j4KXmvEeKJrk3w8ZKy+zioWpicIeviXASzEWj9e05tGtW
	M4lIbTassZb91CGUMYhEjX4n+sbr2OIC95d6KU6iuirjF7fgyigcU4sIoEUc/gcPpSqA6FKeP9l
	uThd7RUGIf69zcw+KQupIEotmk4fQXI0NrCP+tHk+5hGOWRR/S8cnSrGCj0+P6WO+WR6QUY/xpL
	hGma0rjCFCpr5Q6Ekl44Av3s9TKZ1q2mCafBt3iMuRFHjIxRNVbszV6pKd+EtyFmhw==
X-Received: by 2002:a05:7022:5f14:b0:146:5f73:d45b with SMTP id a92af1059eb24-1994cb430a1mr4374141c88.3.1792901048032;
        Sat, 24 Oct 2026 21:04:08 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:04:07 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>,
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
Subject: [PATCH 12/13] drm/amdgpu: Skip AC/DC notification while the GPU is runtime suspended
Date: Sat, 24 Oct 2026 23:59:48 -0400
Message-ID: <20261025040046.1602-13-atharvatiwarilinuxdev@gmail.com>
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

Plugging or unplugging the charger raises an ACPI AC event. The handler
sent the new power source to the SMU without a runtime PM reference, so
with GMUX keeping the GPU off every SMU message spun on skipped register
reads for seconds. A runtime resume racing with that left the SMU
firmware unable to start on MacBookPro15,1 and the GPU in runtime PM
error state. Record the power source only and let the resume apply it.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 808be6c42..b64f0b681 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -30,6 +30,7 @@
 #include "amd_pcie.h"
 #include "amdgpu_display.h"
 #include "hwmgr.h"
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include "amdgpu_smu.h"
 
@@ -498,20 +499,26 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 {
+	int active = 0;
+
 	if (adev->pm.dpm_enabled) {
 		mutex_lock(&adev->pm.mutex);
+		active = adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX ?
+				pm_runtime_get_if_active(adev->dev) : 1;
+
 		if (power_supply_is_system_supplied() > 0)
 			adev->pm.ac_power = true;
 		else
 			adev->pm.ac_power = false;
 
-		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->notify_ac_dc)
-			amdgpu_dpm_notify_ac_dc(adev);
-
-		if (is_support_sw_smu(adev))
-			smu_set_ac_dc(adev->powerplay.pp_handle, true);
+		if (active) {
+			if (adev->powerplay.pp_funcs &&
+			    adev->powerplay.pp_funcs->notify_ac_dc)
+				amdgpu_dpm_notify_ac_dc(adev);
 
+			if (is_support_sw_smu(adev))
+				smu_set_ac_dc(adev->powerplay.pp_handle, true);
+		}
 		mutex_unlock(&adev->pm.mutex);
 	}
 }
-- 
2.55.0

