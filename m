Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901023;
	b=i91d3X+vCgK+eJaOnOjK6+N68gSNhlR5M5NufxS47XHZP4Ztq0BNZC3qAHByT4jQGf3Y
	 FfyvYQ1MbYbG0hsb9v0ExdcdJeKz/u7avAxOjU2sPX0cOfeId2zVEFzpQDOwqSl44VI+e
	 lBPTQ6X/Ex8Z7W9O0bSflpytEblcRhaxcI8r+gDg7enX/qg8hEAnoEoP+ZZL5sS0V+n71
	 9Z0AtFsjBxM9aErZdtrF2pBeTtdLcHYWnw/ZpudnA7zzwyqJTkaJ2c96JYjf42O7PztL/
	 +GMAQm0vJvwpYY/2drTN6sx16OVIufNcXnmUFHGJSamIeiKgx9r70O1EV4Chl5o1AXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iig0z0KMkzGM7EBZYC3zYQ+uH8lNfEJyczCziU7pfIM=;
	b=LSdC0OK2/Ucc2wvS6ubWMhQknsStoGmQeacy6izeoX5rVq6GUea3m98NnFLitHnFzveK
	 R1vmi/43lVLS9jh+7aQIcnXMe3xjF4u2yXPkcpAj8NARlFNijefNKVoqP6nG0ABzPiNbj
	 NAITxvzTjfsZaPPFTXjTPJKMzRqZkuDowhUdkNEDmKbiZT6BtPkzAVwDkoQFbrrlK3GUG
	 MQL1a2meKRIQiC8TKxTWdgcC+Hw+zJj22EFCYWxdNm/zQhftjEJYZ8UMR6xZNZZUngnax
	 5yEMy/xm/pd1N/0GLNeYeVuIDB9ebKbdz+yK0pjG3Bt3tTrAwzwmUCAeuBf5mpzY4Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PJtxf6Nk;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD3606A31B
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBFD3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PJtxf6Nk
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1846bc43c28so2098578c88.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792901022; x=1793505822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iig0z0KMkzGM7EBZYC3zYQ+uH8lNfEJyczCziU7pfIM=;
        b=PJtxf6NkKfEOOHQLs4zYC2Hznepq2CsdFd24+OGx88t7IlFyrpiRpm0fCWe30C9LU/
         0IhNvRfSkw/Y+LMgxZ2yvRQVK4wtjnkKiZb0obEZnW/B+9wGVz4n0zmBZKLLg5fEXrlE
         cF+dPDQhvmaui3Ptk6UkusVRH4mz1Szol5Rkz7JIOw2EzXcq3uagbkoeIsIqvPEXWF76
         eNrrnqcy+zuPdSukRf81k6LSGF0J8GcRcNn7C+xkPkD4e6JlqRJ8vCyV2tYGTSM7Crwe
         1VovFpoIHbUKrsCAXU57jex2hh2Pa4XkL+TqDDnP+t2FQKmKcAh7LnwXQ6/5KXvWzDkM
         +FmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792901022; x=1793505822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iig0z0KMkzGM7EBZYC3zYQ+uH8lNfEJyczCziU7pfIM=;
        b=X08yWWQsZ/mty7tQAFEjAYwPH8/TFXwi48flbqYPdoJMzoIFQRxUKFOugDtGoA9hkG
         KXHhXqUVvRHVMzfJT9jmn6+cbgIVfzL5Jw39PlqzLpM9Qt/kZ3eo0wsUqrDYub4+8cQZ
         oBqBxqHT7C/Z39S4wCM9ebKa4MWbBgZtdu8HlKUzyHQdQgdrbZqL7fILejHH0P5uFGHe
         6tUv4UeAPj99b0Nvuu/sleEOsRFsRgChrSYOVxLrMg1jzyityz1Bg7HY5li5GLkxJlKh
         WTBnIfjbdsDLkjQ1bOPHHt+nGtEMefBF/LvDvxhUiLQp8sNSoeExw4ZMUXeonT93Hoiq
         sI/A==
X-Forwarded-Encrypted: i=1; AKwUvBzi68WWN7yBIUXdN6Hgi9I5ANpoKCtbEU64lveNq5tnWJOGdk5tpPK3uJPJPGMDRhWEv6JS+FYrr0I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ73vxUsiCNA7J1VyhSeb12aDozVxNCHIWm6RlMsb1wnhPggoIP
	DifCHlKF5YFLLdbGOVeqW8u9QZU+qlccjUC50gjYBZFF9AIxQBFGCDc=
X-Gm-Gg: AYBFou1kPmX17Bfzpfbc9WnCtFDHf52vtdA4QDQy7H+ialI6yRCs9Ud6Dw49yDIloYC
	nt88R3CuoIpiZNAypD34AWwtdGULXSEX+0zBVu7igTm3eZzr6q8dMuHd+XKMdWO2O21fj3ikfmH
	qleqXCrCj6PDmj+p72hZiNwDZZrRshzGz3BOJYSUbTGiDHkwtajXX+kwf/KYnfP2RG5UYFuIREf
	NLyQb69a87Dy0ge4EbZnjnOztK6MrVVAaeomTe5hLK3r9p0dncgV7xjS0YNZFTau0j5K5icD+l2
	+1wJS99MGaKqYZVwAgaAvXDX2w0K3bE8s479za8d9vzCfiAZY2FGMqgSpl/yov0JFhIPixMpSvk
	zwz/Iy3VJGVu8akr96UKurjhdB+gpQy9luA+AA5giU4SQPBK5qAqIZC/UZw4FNEcexy2oOnm8ju
	XNO95IjJ15T7vcvXttngAwB0wnhs2o64dI9GVqJUoCW5VgPvHwghit0bwnzllnxxiDfNNkR7TIp
	QulDS80sCb3amflWaXRV+4U2E2Gf5UYfziOoFnJ5UHcDc04fmLx0sNdJ1vtM50K4FJ4V6Hm8X3r
	nXP/9Luw4vDOeYOK
X-Received: by 2002:a05:7022:7f12:b0:176:2095:1ac4 with SMTP id a92af1059eb24-19935be809dmr5230234c88.18.1792901022034;
        Sat, 24 Oct 2026 21:03:42 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:03:41 -0700 (PDT)
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
Subject: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX keeps the GPU off
Date: Sat, 24 Oct 2026 23:59:46 -0400
Message-ID: <20261025040046.1602-11-atharvatiwarilinuxdev@gmail.com>
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

As mentioned previous any access to the GPU when the GMUX has
shut off the rails results in a CPU CATTER, skip and report
any register access after the GPU was runtime suspended for GMUX power-off.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 ++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 24 +++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6fd607587..ac8dfc3ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -881,6 +881,8 @@ struct amdgpu_device {
 	/* enable runtime pm on the device */
 	bool                            in_runpm;
 	bool                            has_pr3;
+	/* GMUX has cut power, any register access would hang the PEG link */
+	bool                            gmux_off;
 
 	bool                            ucode_sysfs_en;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c1f196242..8185934b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -946,6 +946,11 @@ bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev)
 	if (adev->no_hw_access)
 		return true;
 
+	if (unlikely(READ_ONCE(adev->gmux_off))) {
+		WARN_RATELIMIT(1, "%s: register access while powered off by GMUX\n",
+					dev_name(adev->dev));
+		return true;
+	}
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * This is a bit complicated to understand, so worth a comment. What we assert
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5ad7b6dd8..135798c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2932,6 +2932,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		amdgpu_device_baco_enter(adev);
 	}
 
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
+		WRITE_ONCE(adev->gmux_off, true);
+
 	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
 
 	return 0;
@@ -2960,6 +2963,8 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
 		return -EINVAL;
 
+	WRITE_ONCE(adev->gmux_off, false);
+
 	/* Avoids registers access if device is physically gone */
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 7468855c1..bb5dbeb7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -594,6 +594,9 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev, u32 reg_addr)
 	void __iomem *pcie_data_offset;
 	u32 r;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
@@ -677,6 +680,12 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev, u32 reg_addr)
 	void __iomem *pcie_data_offset;
 	u64 r;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
@@ -706,6 +715,9 @@ u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev, u64 reg_addr)
 	void __iomem *pcie_data_offset;
 	u64 r;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
@@ -762,6 +774,9 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev, u32 reg_addr,
 	void __iomem *pcie_index_offset;
 	void __iomem *pcie_data_offset;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
@@ -784,6 +799,9 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev, u64 reg_addr,
 	void __iomem *pcie_index_hi_offset;
 	void __iomem *pcie_data_offset;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
@@ -832,6 +850,9 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev, u32 reg_addr,
 	void __iomem *pcie_index_offset;
 	void __iomem *pcie_data_offset;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
@@ -861,6 +882,9 @@ void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev, u64 reg_addr,
 	void __iomem *pcie_index_hi_offset;
 	void __iomem *pcie_data_offset;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
-- 
2.55.0

