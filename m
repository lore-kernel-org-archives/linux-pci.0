Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672667;
	b=Bmnb4K3s2NhoKVCIIMwMLoG/47yDtdfC++oeWr4Tytg446qKHMFM+Et7jaG2kTjBbKP1
	 4ZgIqrgP83XCbjUejOWyQl8wDoyfnCI3xx1KNJ2CyVSTI1Uw06pftVc+zdWeqUq2ydu1c
	 SzhIaQyUXJCPYyH74kDWYhrQwWYDFdBRc/o7GCC2+41edSQ5CVfARd+tJ7BTQOhDQkpS5
	 8gQMPaQVWHGTwoIfKk/+bOsZsCi/4h5D7jMXkC0Hb8iOkHTlJOPMJBUaxv++dUkkXyo9y
	 8gOuKSrEx1SMshX6AL1zMM70jx8YFYzsmUsbnOX3U8XzbtCsoLzgNkrHCHQLlxlfOsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MmSYBT0oM+9e7OOhRP6rlPjvDndoWmXiY3l/U4zXmz0=;
	b=kvuvXGTlOGw5g2bWJ3GEyDtFji95rGUpZHHqCgxmuMquOinG6IwsgPDz4hSGau6QEq6S
	 dr7JIwqXskOtIaJG4Uuv3Hox0bfKdQUiRkX+e7OnR/aAZj6RqipvfRABZuOyEeVoMKMyY
	 xhHl7IqK2ALM4fLLzs7s8Ey6KqsKb8TDizFd7GGsVTmFZEPJ0TBkqIFb/IajLPrLWd9dk
	 FI0fEPegF4pIXZiD5awlJaAgteUzHs8V9hs9meGvR+hbCOsveMU8uqD3biylQxfPYGIzU
	 k3hbz0d6EuGaKvozFkvx9E41Uj5MRVurLcpv9Hf4RD3tFCWGpSenx0UjuFf5UqaWzlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qUiTkYMN;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02055606A335
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02055606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qUiTkYMN
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso131032eec.0
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672666; x=1795277466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmSYBT0oM+9e7OOhRP6rlPjvDndoWmXiY3l/U4zXmz0=;
        b=qUiTkYMNIBLLP6fruNVmymNOken5TH+ZMKj5c5qKCKzeNVQPk+UaK2+j3L+Tsv6ICm
         iUKuZU3aJlISkT/LuB0cFXQrpedRFoopgVw6y89nfkdBmJleyM/yS1fXDhyzXYtwFJuc
         7rsC+8GPtcECcw8RNmn8s4e2Mn0wQNQL0xYzsVic78lR6/bNISZKbpLiuIGDvQRCw7Ok
         ONfNaklfm5jAMQq95jt5HLSQih5LyF7q51PHZTucnSBsklZbFZGhLrcriSClBAIFbY5h
         ZYIp5MBvgIrznXz9Z7r8myawp1pmbK7u4khIfnRegOFkmWsBgXWk3/ejyhfyRPWYhGZd
         sScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672666; x=1795277466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MmSYBT0oM+9e7OOhRP6rlPjvDndoWmXiY3l/U4zXmz0=;
        b=ORVCFZhwhERdrSVTie7TbDQUVYq5MR/+rYoQC6E7I2wx0Z3PfwPXNmXMORQKy/reDM
         BMyeipVybWPBPyyis3FA98n98wUy155EwBL71i6bGcoiWWvsyNd3MnwhXpsEfM9vn8MU
         PHyOJ6ZZGkmCAoYNV4FQRErFVS98wwV7muTP9mRTXQUdsqEssXPgYMXhsjl1SW+37rdp
         esDlJimZ5f6tvSrIRU9JC5cQQ3z42j07piNau7kx3Hw60nDiL5DhzyB1GM7h1RiSFuDx
         g65Rpy/BheTiC/sdkbgQaEy2k3dfRZiZqKSA+v/fphbFYcxRScwGRh80NqYRdwC8TIJl
         JVCw==
X-Forwarded-Encrypted: i=1; AL+hErE9XHhcdSyGrsr0qTh1n+n3nKCv6VUtsCPAhIoW6M5NgWtsKxzT/H1xQQu/XPZa6aSICAcZFX9C6A4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WSYS2YQGVKqc/kLh+dgKSdH0WXit86CO2AfrTveWhFwWtXrsk
	CiO7gkrxGgyvK6etBbJRH/n4KBC0l3BpNSho1ABp69X5PkQh3B7n2Wo=
X-Gm-Gg: AYBFou1jFcRdxG8JVTj40IJy0taEZPPhQdJfEGgt5LLJodxRy2o9NVPRsyGUlDNKAX1
	+9raj2lxxkeqE5EPwO/4OAvUfccIZlxAAsmsn+iFJLjMzslxis64G+bcnQNjRg6RzHFhiFo9mfX
	3wpezR1EHKhcb0TJFU//90Hm1eOHgvQHPWPqXVWQtTjk8pAgX1YpyoxX/Yg88im56JVrxyXzm9R
	EaNl068aKDv7RjYOaennipcCvAORoHMAQKJmBbkHaTOV6vPyggse2tSZFCDnA8Jbajh6ywBmGYD
	hGrAA9LXnCfbuboWQwQ3PkU2RbCJzd/ac5jzsky9BpH+AgdbuOKpXsCIbbNKjBV4GEi90DDQzyn
	A29esIBCpdaQoez6xcmPtgL1WuQ6Obb5oC/dkJ8th5AJ7n7enqSMoZsEY9dIjMl/wFNp3cWynQV
	76ohAacHv8SAFrevQZ+jnmc+F8RKwcxEWRiCX3+vKWfrVqIIgBAI9klLw6iZ8AVLYvJ9Hqphvym
	IOQFg75HSekCARMdAm4btfB1N42LwEi7lj2ICn00plJ7MT0eEziUIVIpu1dP6RgMZW2M7iJMoyc
	SFLY3mSzTAPAlmMfdnKPPpr0gpw8PbzmtrBiuqsBuPqMC5KF0uDix+g/a/MzyYsahA==
X-Received: by 2002:a05:7300:cc9e:b0:372:2ed7:8f89 with SMTP id 5a478bee46e88-3796702a36amr5694460eec.34.1794672665837;
        Sat, 14 Nov 2026 08:11:05 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:11:05 -0800 (PST)
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
Subject: [PATCH v2 11/12] drm/amdgpu: Skip AC/DC notification while the GPU is runtime suspended
Date: Sat, 14 Nov 2026 11:06:35 -0500
Message-ID: <20261114160731.3756-12-atharvatiwarilinuxdev@gmail.com>
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

Plugging or unplugging the charger raises an ACPI AC event. The handler
sent the new power source to the SMU without a runtime PM reference, so
with GMUX keeping the GPU off every SMU message spun on skipped register
reads for seconds. A runtime resume racing with that left the SMU
firmware unable to start on MacBookPro15,1 and the GPU in runtime PM
error state. Record the power source only and let the resume apply it.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 808be6c42..3c6dde386 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -30,6 +30,7 @@
 #include "amd_pcie.h"
 #include "amdgpu_display.h"
 #include "hwmgr.h"
+#include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include "amdgpu_smu.h"
 
@@ -498,19 +499,27 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
 
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 {
+	int active = 0;
+
 	if (adev->pm.dpm_enabled) {
 		mutex_lock(&adev->pm.mutex);
+		active = pm_runtime_get_if_active(adev->dev);
+
 		if (power_supply_is_system_supplied() > 0)
 			adev->pm.ac_power = true;
 		else
 			adev->pm.ac_power = false;
 
-		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->notify_ac_dc)
-			amdgpu_dpm_notify_ac_dc(adev);
+		if (active > 0) {
+			if (adev->powerplay.pp_funcs &&
+			    adev->powerplay.pp_funcs->notify_ac_dc)
+				amdgpu_dpm_notify_ac_dc(adev);
 
-		if (is_support_sw_smu(adev))
-			smu_set_ac_dc(adev->powerplay.pp_handle, true);
+			if (is_support_sw_smu(adev))
+				smu_set_ac_dc(adev->powerplay.pp_handle, true);
+
+			pm_runtime_put(adev->dev);
+		}
 
 		mutex_unlock(&adev->pm.mutex);
 	}
-- 
2.55.0

