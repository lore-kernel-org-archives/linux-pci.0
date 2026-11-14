Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672649;
	b=SlFPLyoDOhirEJddanFtH1MsvFD3wj63oQpgH+wGlXR/yn8/cpXx28BNLIo5U8LCxBMl
	 +yLiiMcSFTwbE8K5ZYDIZv7BEA/OnZtMtJpXxIsvscVGcZLGRG8uTDz82PhrTCfy9au63
	 u4JiCEvJSQsqPWJP6vqtNapMtynDu4+Vd3XAfBLzskpPniiUJiFhf/YaGN+3mn2uuSZNE
	 O5+898uUzGgt4efsqlf8TYV8i6zjqN39h5JIiO8ZiNWrC/b6tlzawglWr8YpreO6Fn2P8
	 6FfbvRCe+I0uNrWoPOwCLSCtFyThh10//t4j6AiYEuhFrLOTPpTeN5b0dmyCY9V9Lpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KPSDYqCooXPcCbLVRB9OOYzMNaTmNZPbW1+34+f9KRM=;
	b=YDm5KetiEhxmPh/pl5kYQTE1NJgkcsh/aT1jOUhBG7f8f6zZ32bOJZgkhrtwEIzbkgFv
	 w1jSCS5CkCsqPFFMAy7PYGYzCBsO2PPQV0QVxmHoaFCfL5yZ92wLfi3xufexqjpQC1uso
	 fxL8+1CB5Ay6kfQ2ziFG/7Mw4Zu5TKuJ/SSi1kkRHzum9kiNXgktsrEr6H6vvmRX8k8Vm
	 djcFtuldFW5JoSHZzN8hy6BaQZjLNrFtgvs7eNvARdGRhWF2Z+N3F+5vpTjHcmSMRCzW7
	 s5+gAWcOErJns2lnPIjP7pcjl8JwF3jRqmOhDpQZOE+kiAkXMG6bZXe1uzfGk+zO5Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UI+8X9u1;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C49606A329
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C49606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UI+8X9u1
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3712b6d9843so1744197eec.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672648; x=1795277448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KPSDYqCooXPcCbLVRB9OOYzMNaTmNZPbW1+34+f9KRM=;
        b=UI+8X9u1K6VpjHdMnY8BtVFWuMOw2NqNYUAUYXDVrOZUKQ/I2nEt+VAnyc5dX+W5d1
         Mddl/IIWkuZh9WdnaqzgenfUuwuCVp/CE1Mef5Pc1hSXmHS9hzNnikBReI0hM8WiKEzM
         Oe5mC78RbP/wKBnN2j+dUxHEvzG9wI/NPe2fh56u22u9KazAlkYyNcE6kEWROzlFv2P1
         P8JNWjX58l8eFhjHw/VwzrliLLCXZwm8KmXeo+KhRMBfTgdcsbLauCnnVypp5FzpRjT8
         gBg99LDPl8pMsgK6CW6AVxP2aDI3T7PjJLaqtYuVD75JLwCRLwWIRYnOc+7S2iJ4FzpC
         dL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672648; x=1795277448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KPSDYqCooXPcCbLVRB9OOYzMNaTmNZPbW1+34+f9KRM=;
        b=SF8MnXCMo+3xKrTVzYgChJB1rL1GuxOIGA1h9iplCyzpJ21uhzO6Oc0sQ2d/ziBw2/
         H9hav4yRMzyOVSUqUQQpaGwieBmesX/Hvu823O5wJMMUR2PH0kpHj8/OZ33sLJADywYO
         cO/VV4bK1l0MLnh9ABtoL+Oa5ABuR1btKfJT4b8gwpfCBQD7JzDBAbISgfJzuCYjLNxX
         JTYZLdt21mOtyihKiClfbif6u3wvJqz/aZffm5Ubsdo7HzmDMwbcWi3ji457l1GZKLig
         fMz+i9SVQ80Q+4N2TFcKpBH6M+471Khb4cR3BnBEaHu0Rex0YMikYDkZZuEx5Ye+5B4f
         SlRQ==
X-Forwarded-Encrypted: i=1; AL+hErHveFtvlVPbEbCk/1yivp1Dd2ij8j5+R1nHjU26RRUq6buzL+xRTfT/hWsC1MjsI9L88/Dhz6tM7zs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8A9rwjjb+HOMGZizQUWuHb8UlNjqrXk55EoxmwA2RGrsWUiGM0
	MUm3jVPmeEqM51X2/+xk1sY3eEn7SjbbKlf7jmd2kZQwuCu9o5j1mNY=
X-Gm-Gg: AYBFou2t0L0+k9cXF+vQ7RDlnyPfgdBC4eiHC0AuEsOTYe4Fk5Mf7nOGcVjB+8WXWRL
	M2dMwzZA2j4VMp23TE5SOyiXuXAtnTXOkPoZ9VQM1K13TMy5DcdnhsM61wmAVB2/RNok162kT0H
	kXvOCe0pp8DS61ZnxueDcwMRsDYMEnLmzJWHHNfCmDZf/xLLiy3vmxme3akhIh6IhBnstfj1loy
	9gKp92sD27qMW/ZnMZvZliw4ze5kDnJwQiHFIVC0BWwdckHzQN74Y9lTcFFISmbs6RTkaBPSDht
	AvoGPv1zrg06h3c1mEB7VRdeMiu9pZpot2dv+RB2rByKXSn3MMzEIVSZXXn9tMUdssUGZZnGrfx
	UobUZLPOuFZRrYwGkKQ30B133f9JpRaOLLq9F7wZw7k6XpM4TBaOUO0WIPZW1zjhTzamgK+bXhU
	B5XTgHRCaTzVtJ5QmjyQx2CFJfzWPPOz5/MmgQO2ybylbnkHACe9ObTCuC8LO+77P3rioeaiJzE
	Ybp0aCChRAjy9JSByG105jd+ZNe9yB6D0um00KjJkpzlAwrgZCGCl+3L2lGlaT0owj4pQ59XQRM
	zQGA1GyJ6xBeVKiW+Y/mCW+k1kTf6cALVxgRoAbMt0aVKQfcvjJ+eNXS2a7LAnanUw==
X-Received: by 2002:a05:7301:5401:b0:35c:8b96:94d9 with SMTP id 5a478bee46e88-37966f31fddmr5041718eec.19.1794672647666;
        Sat, 14 Nov 2026 08:10:47 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:10:47 -0800 (PST)
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
Subject: [PATCH v2 10/12] drm/amd/display: Refuse DP AUX while GMUX keeps the GPU off
Date: Sat, 14 Nov 2026 11:06:34 -0500
Message-ID: <20261114160731.3756-11-atharvatiwarilinuxdev@gmail.com>
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

fwupd reads /dev/drm_dp_aux* while the GPU is runtime suspended. The AUX
device holds no runtime PM reference, so the transfer touched registers of
the powered off GPU and caused a CPU CATTER.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7261317d4..0d11a9443 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include <linux/pm_runtime.h>
 #include <linux/vmalloc.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
@@ -111,6 +112,20 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
 
+	ddc = TO_DM_AUX(aux)->ddc_service;
+	adev = ddc->ctx->driver_context;
+
+	/*
+	 * User space reaches this through the drm_dp_aux_dev character device
+	 * check if the gpu is active or not.
+	 */
+	if (adev->dev) {
+		pm_runtime_get_noresume(adev->dev);
+		if (!READ_ONCE(adev->runpm_active)) {
+			pm_runtime_put_noidle(adev->dev);
+			return -EBUSY;
+		}
+	}
 	payload.address = msg->address;
 	payload.data = msg->buffer;
 	payload.length = msg->size;
@@ -126,13 +141,13 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	result = dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &payload,
 				      &operation_result);
 
+	if (adev->dev)
+		pm_runtime_put_autosuspend(adev->dev);
 	/*
 	 * w/a on certain intel platform where hpd is unexpected to pull low during
 	 * 1st sideband message transaction by return AUX_RET_ERROR_HPD_DISCON
 	 * aux transaction is succuess in such case, therefore bypass the error
 	 */
-	ddc = TO_DM_AUX(aux)->ddc_service;
-	adev = ddc->ctx->driver_context;
 	if (adev->dm.aux_hpd_discon_quirk) {
 		if (msg->address == DP_SIDEBAND_MSG_DOWN_REQ_BASE &&
 			operation_result == AUX_RET_ERROR_HPD_DISCON) {
-- 
2.55.0

