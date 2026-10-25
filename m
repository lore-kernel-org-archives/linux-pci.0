Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901036;
	b=1aylqPlcsngrbXCwBzTch8ogT3u0nfxB0oH54nhMns2+XKlUEwRb3Wom6pwW9+lGYxdE
	 n80MiuENqCC2mDlqNasnTucRglPXec9IDiDyFonzgCgBN4cybsDdi8m1MPy+qLcgIuCnb
	 x2otoH1EdlQnL4rif5bSRRu1MjeCL+GjX0gYom+vdbHAI92EHN8IGturR6GkuQcvaTDdo
	 pFkhQKdjQ/8FZh6Z5gJLf663QbtSeUEZAovHJ0hn6vKC4KonsinB3gw2PkUC9vMF1EBf0
	 ycEh9rZlqTUQ5sIrQoOQIRR/5XNjVRC1cNwfb6YIpHj8w1p4rjwo9Jvf8qJ5yCTF2uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LMc3CYZEKLGD01XMea94oTj/yeGbugpGFxEInSpf2Xs=;
	b=05qEz2F19nUs5FDYyesuB+5/h9U97Zwxeva8fzJilbkhB+WdUFxFZxi+I98X8Tt5tLZ/
	 Dc/bn5nXSBiXcffvac8tr/RtkgO5YpkMyHCF2nx70npbFpEfrWj3hfrPyPDD4/zDsRkIf
	 qTSKyE0fRSwAyge0Itq/FymV6PDFpLOKGxSrerpS/9JV2+jKwEw8116aVDHqHojj2v0SM
	 YDuh0Wo1nbl4PWqQgxg2jtx6VgP07FzWYMJZ6Fju1rN1xCTuimIBA3dnbmO8vEK0TWzwN
	 B3V3zYficDms/kn5WGKf5F98Z9FK0N+4lWyxTwqpPNhaKh2X6NsswPT90VeG+iziPDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QGd5I5HD;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CCE606A31E
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28CCE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QGd5I5HD
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14fd9dafb0dso1649911c88.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792901035; x=1793505835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMc3CYZEKLGD01XMea94oTj/yeGbugpGFxEInSpf2Xs=;
        b=QGd5I5HD1H6NCJpr1gY99R+GQwI6Lfi+gl5HpCwWAv7ACSrLI2nAAUBsMTb9LuViuk
         CKo6SoydrgyqUkwKqPO1rB721LH++KcE22039XwYe1Dj7/KseV8NmC25+4rM4Pdk6NI8
         bhbtA7jVr4ZkW8BW91pBWT32vYkJOHAfyvXNtD90krp0XOg6y6bUCPq8ze7VWB5+h/Pg
         VbwQfQ1zp3/PfT5eUU77bvySFBo3G9MbRfeDd6d/zugYHvQITfiC52z+vYEKXYk74uOI
         HQMc2Q+kTvsu+YNcMfLBBgxA43Xgbgh3ALGtcYt8UWVH9fLmO1IFckuKGxtK4K0cGYn3
         hFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792901035; x=1793505835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMc3CYZEKLGD01XMea94oTj/yeGbugpGFxEInSpf2Xs=;
        b=VDtxGC0akRgZeHjkaT6EG/mGAB4nzfXEO1LWLdb79WBF1du+QrlKnJyUnVfE2pUA9q
         B9kLFWt0pz0Gkc8f6t7YHAqneIdsL6DCDLxHljPVep6QTPNLIPh5wVy4oIMwWf8d/XLQ
         dLePRXfvvqE66VEBua811DfGc3CvqLgnQ7JkpD4LA6t1RiL/GnouMMfG93joUoHrtt/W
         Ru8GpbpuukKS6RPOijkazadEPnJ5Qo5QCKhcRFCBcMQsKOnQjRBKDdoNNTrOQg2wB837
         9hE/vFIMtMRTYCcVF1VItCRXffe9gNzxY4daz7MyZ8/TrOZGlvUUX6i0avpTdIXEX50C
         FaGw==
X-Forwarded-Encrypted: i=1; AKwUvBwpEElG8ZEwzXUXT+iDit5GOulHNSpqqVPkaQac0dhvRNLX9l4UY6XNDnxCbLCsJO+fMJCybpSRS7s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhckFjOHO/O8uLWDiv40UD23uw66gPAfR4FxbvVdD0TWJSmuT+
	w2j2ULcr+2V3kvrbn+rms5xx2KXy/Et5OY0f9glVb1THXIWktBMJGoA=
X-Gm-Gg: AYBFou30pcyMwvrl/8bk4ODqIyySuXkuiZsl2HP+t80vY4CavkZI5rGwLVBqGsONKXE
	RFqTeoGY9j0ZFFJCz2g+OTtoFKox7GHVmMX+q8XAyR+0pasFavP61MaCP4SZDMUWW40hfOibWzF
	Q898uamX92gxG0lPTI3ghF/ifUW7T1Rh62mbZSZfXT+S4MK9pp0S4R+0csBFMxbsZ/r8eOA83tq
	CWxuHz2qHwxBo5vuPRJiLk3xaRgqbPYPvYhFZAZzyQXV3BtixwL76pTQXRQIN31y5E2ls0BjRSL
	Og+eIiPQ9IVKU86iDAdHtQ1SBAVVziWhUmJkC2nC+B3suFyV7xeBBXBn2lkOs2+sDXio2YF89G9
	CimQo5YdVi3SwF9w0Mmog5eTYYFW/0wZ5pTYX9OjocR4si4pmag2vd63VEXMAIRreo/I85px4Bs
	9AUqPB9jHpV0pH7FWUAzBZyu4lOyDs0icFmqtDbwx9mC6iFIkBHlcvyC1GxkY64vD4nOo5/+dhe
	5spheu0cYBWFH6XDmgd1d39YBXbxKP2hbINDev/pAbJC0JgtXkNZ2TX3r5QPnW+BL0q+66tBNbY
	bd5WD6ZjOMnpQ5s=
X-Received: by 2002:a05:7023:885:b0:16e:6e3:9a9f with SMTP id a92af1059eb24-1993639e6efmr6212921c88.34.1792901035199;
        Sat, 24 Oct 2026 21:03:55 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:03:54 -0700 (PDT)
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
Subject: [PATCH 11/13] drm/amd/display: Refuse DP AUX while GMUX keeps the GPU off
Date: Sat, 24 Oct 2026 23:59:47 -0400
Message-ID: <20261025040046.1602-12-atharvatiwarilinuxdev@gmail.com>
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

fwupd reads /dev/drm_dp_aux* while the GPU is runtime suspended. The AUX
device holds no runtime PM reference, so the transfer touched registers of
the powered off GPU and caused a CPU CATTER.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7261317d4..b099bf520 100644
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
+	 * without a runtime PM reference. Refuse the transfer while GMUX keeps
+	 * the GPU powered off, a register access then hangs the PEG link.
+	 */
+	pm_runtime_get_noresume(adev->dev);
+	if (READ_ONCE(adev->gmux_off)) {
+		pm_runtime_put_noidle(adev->dev);
+		return -EBUSY;
+	}
+
 	payload.address = msg->address;
 	payload.data = msg->buffer;
 	payload.length = msg->size;
@@ -126,13 +141,13 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	result = dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &payload,
 				      &operation_result);
 
+	pm_runtime_put_autosuspend(adev->dev);
+
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

