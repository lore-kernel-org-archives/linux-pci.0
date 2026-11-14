Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672629;
	b=m7JRC8zD7MPNNNQIZQVgCkrrsCClrMZuoC1PEmHlTRXFBu0h7AySXfvNd1BtQVjHvVkI
	 vlPWoJ+BDXZt2pjl82QhqsfnMaJ5zbPdMwaedGTpoZXl7KL331S1dsIsC/M6p+kyGvCv8
	 AiCNRy9Q7VHXHoLEPfvY2+eHaRYSKpSAKMQKaCj5Y3KMIWrlrxjSGh0Bi9i+V3iFKE8AL
	 MG3pRtMd65yup/x4TR1RbhYNx2gJh6bD/zjIZYkA6E9VcW11guiDVL4zJGN52zxhRkL5X
	 L34Lv8OgXHUftraDf7eqon3MjZP+73YlaO1weYkSH0JoVggggwwXLJvJGNybYKPlmMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sS1w6ypVXjVKbAJDNdl2VMNTbmFYN5LqfnAkQkSsnPU=;
	b=pIdqxv3HyL8i2dqaY1K+NbYUIwSabg/ys+n6ax3DVPrLps1GOoL4wWinpCk6lS4XSrEm
	 6Jihqk+0JP/gX/OrrzK91elbwrbF3X2fjWgz5cOPqOGGo+Ah5V0J9d92D2DltjFUA6xnq
	 7r1QkTmnAX/F5C6FEuNO4kYVTAVkHPo9CwXWrs+u673+tppMZfkLJnVwLlHdNB0csubMa
	 2a2m6sLGsxTG3aeh3njFYLrZ+AzgQ1HA4p1uDTGtez1/SdY1FizZlam+G49BiZ7VE055W
	 k/5p4m0OVd2Be5XWqSsJqXZgy8LiLiixG1+mw40MhnpgOYCRksTSP7T7fbb9D+4MVAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o4LiLLZC;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AD606A32E
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 104AD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o4LiLLZC
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3704d30b84fso2581594eec.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672628; x=1795277428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sS1w6ypVXjVKbAJDNdl2VMNTbmFYN5LqfnAkQkSsnPU=;
        b=o4LiLLZCBh1ZHZESPp0KqiHXgbJvc1KMHOxDu3JT4SWVWuXGwcIt99NLQ77HqJNMZ7
         DJfFip7zX3tloMNQQbiyBp5AplUydIZSCwdW5QYp0qBdLHUIxREnB0/NFAwbpym+bRnV
         TqyZNmhNiY5Rvdo75LN8lAUfsL9F+jqu11cLo4vxbJyCbn2C09Im2WacuhFCrBllxQj3
         0Os74uf8sLbSO9agpnUSlxDjd8w0MaPIu7sQadEqEgJNPpJstAdIzTq8F2KP5lKqTOoJ
         zN0pkMt6Mu0cbOrTC5Ei2RxClprh+d6QnWf4YrPq70HOV6bKSamNHFynmsb74AM0PDlW
         BjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672628; x=1795277428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sS1w6ypVXjVKbAJDNdl2VMNTbmFYN5LqfnAkQkSsnPU=;
        b=BBJ13v0sHPACNbe054P+H3m75X7CDRqv03R92Hffm/S6MHUqXGoZczfl94ArR3QC2T
         UkGYUgQuscCKeGrXk3+p9kh67eUf97R5u3gbMB6PWRlmzLHk7n41J5NzPX10FS9hNuHy
         2UERa/7idu/65erduFNsZZXAOSHK4Zd/CsLOu+SO0IzLyAXmn+mrbUlWFmE3SJ9krc3E
         07n3suKHeBCuU1jEAhVDon0MQ0zYMkHpFe1OFIk9dmFqoaW4fA2Ob9UBttBqXO6cxtRK
         pgigZ6D6oJqH2QPJZrvizUKD79QSXJSLedCntBcfnB1YDVj2i0Un7mdlmSZZFQNCLCCh
         iFag==
X-Forwarded-Encrypted: i=1; AL+hErG6moWviUcMSNedQGT5fsBFn7h5iYwOmpGcE7+6pHKz9EWb3YZx8d1PXi2X1EOLvV9A2kpqitTronY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Iu6mSpxWKiZX2qDcimZCf8v4TtvUBHJl6NT1v3NgyZSeZtrFp
	5NuiX1ONpwAWlWQZPqMOhHsK2g2iBEUAgkUZeSCWaEueEH+Myrly6gA=
X-Gm-Gg: AYBFou1hzm8qfFQ/GDuI4Su/nKSRpVAomsF74nzgRwrbLwr7ae5VlQDQmn0FpSsLwaD
	3z6PZCX/VOjvRO8eA7oAh5s6jFO+wm+cHKoyRIIYMSYKJynccYPV31Go5EDoGWwkFVD6/Fv+AvP
	NhRjRj9Grb4O2mjO9/loXXACYkzMDc+zfvedPJ6hKR2Ijj9OBcqGDEzOTDFCWz4sfmliaWo2g8j
	gGI7m8pmItdTnzfMyBs2WxTCsN4HJDHzC4OlAHOrmkASReNHPNZaTfJ+GFtX4VkdWTAqRj04Rhs
	IEx4SFJ1uBiU2n212tYzxiWgZDghHgq95sjC+qYhAHUk5bX5I86RHA0T+ZK1tJ9Xl8a2KxErfdI
	ANzXOp9TBMc6788F/rnug+zfXGLUr2/d2IA1Ru9RKZTdxEfwB7uszH7eOqb5s3Ttj/Kx7RKv9lg
	ve+O9rA5Wo3FpPoERd5Ks8hieBY8uNNvEqPTOpyDAqfCjvIZhbcSJa5B5DPd3y8rZouNwcK2lU6
	/OnVkph6pjS9Trif6V3MptPyiww6TWybYitTyCLUXGLGPcFSdhyXdfevNfrn0F3jRl40e9AQMLS
	E5ANGQEbw3ej3ZZwzA6ZW7+RXH9ujFAhx53ETuuXNOrAH4ZnFyA=
X-Received: by 2002:a05:7301:d812:b0:373:d25b:8cf0 with SMTP id 5a478bee46e88-379681cc558mr5747473eec.29.1794672627992;
        Sat, 14 Nov 2026 08:10:27 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:10:27 -0800 (PST)
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
Subject: [PATCH v2 09/12] drm/amdgpu: Catch register access while GMUX keeps the GPU off
Date: Sat, 14 Nov 2026 11:06:33 -0500
Message-ID: <20261114160731.3756-10-atharvatiwarilinuxdev@gmail.com>
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

As mentioned previous any access to the GPU when the GMUX has
shut off the rails results in a CPU CATTER, skip and report
any register access after the GPU was runtime suspended for GMUX power-off.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 ++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 24 +++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6fd607587..9938ae48f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -881,6 +881,7 @@ struct amdgpu_device {
 	/* enable runtime pm on the device */
 	bool                            in_runpm;
 	bool                            has_pr3;
+	bool                            runpm_active;
 
 	bool                            ucode_sysfs_en;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ac336594b..ed205352f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -947,6 +947,10 @@ bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev)
 	if (adev->no_hw_access)
 		return true;
 
+	if (unlikely(!READ_ONCE(adev->runpm_active))) {
+		WARN_RATELIMIT(1, "%s: register access while powered off\n", dev_name(adev->dev));
+		return true;
+	}
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * This is a bit complicated to understand, so worth a comment. What we assert
@@ -2029,6 +2033,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	int i, r;
 
 	amdgpu_device_enable_virtual_display(adev);
+	adev->runpm_active = true;
 
 	if (amdgpu_sriov_vf(adev)) {
 		/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3978ed284..d1b0c6c73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2935,6 +2935,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		amdgpu_device_baco_enter(adev);
 	}
 
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_GMUX)
+		WRITE_ONCE(adev->runpm_active, false);
+
 	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
 
 	return 0;
@@ -2963,6 +2966,8 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
 		return -EINVAL;
 
+	WRITE_ONCE(adev->runpm_active, true);
+
 	/* Avoids registers access if device is physically gone */
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 7468855c1..64eba8a97 100644
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
 
@@ -617,6 +620,9 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev, u64 reg_addr)
 	void __iomem *pcie_index_hi_offset;
 	void __iomem *pcie_data_offset;
 
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
 	if (unlikely(!adev->nbio.funcs)) {
 		pcie_index = AMDGPU_PCIE_INDEX_FALLBACK;
 		pcie_data = AMDGPU_PCIE_DATA_FALLBACK;
@@ -677,6 +683,9 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev, u32 reg_addr)
 	void __iomem *pcie_data_offset;
 	u64 r;
 
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

