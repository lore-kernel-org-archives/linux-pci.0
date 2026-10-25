Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900928;
	b=iWZkYC0u+5FbXM0W5pZFYrbiaYCO8NqSvPhp96QQBDF/xJBwiyYbi/deA/BK3R57kr4I
	 sWV+BgNDgr8icYB3MgikbDbNdbDAvbaIxGIMfBAQh4fY4W4n5bUKzl6wYTBtO+1Ec9Pe2
	 BA98raomIQ9XtaMeF538ELdZ9qbQhsXi+pOJbP5VHpoLGvadNuonKcXF9OdscDWUOuRc7
	 ihyFVWzBPAtlaDJBsjLTVZZuJ9QxIuNZV/zjdLp5mYvqfIQ+EgvMkNiul1n50xSn+0uDv
	 TkdHLxTmW/zYk7izsb6wCued5KJjcqC05IO9wVFB9NcVAzlpL0KrKF55oyRJ+ffgarg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VU2DAJ/OjJ6m6U2gn3WXwMpKFJKrCfikczSVMn3jkTE=;
	b=s9AUYPcSOIVwJhN0NP1aaRgGpUq6GOvyj4mfaR5pyJysVT+kaD7aFE8A9C6tLmE3yR/5
	 uMXhpRZe4ieFqfFsCUS0Gd5fn+UOLHON523aRor09/bE036MtOl6WaXFJip4diNOAum/G
	 yFi3X7KQ7sJ3mOxF7b3MuTy7YvOYEnlPWQuEPzIfpr1D3+TgVsSEPbEjvLedeNK0MRiyR
	 8xhvV6wJkE6el9y4a4bBibzEDG/+6Tz2vRhxbG2EuA0r6ddKz3Rwiw1XwolJZFdSrEi+0
	 jG9LB96OQH3nEWo8OgzGo1XNtAo+CxC2ciuy6Dm5011rV0Bmm+XdBOn3hM3oqO1NHlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bmWNbLuv;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61B606A31D
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE61B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bmWNbLuv
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35f1f76ea84so3425004eec.1
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792900927; x=1793505727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VU2DAJ/OjJ6m6U2gn3WXwMpKFJKrCfikczSVMn3jkTE=;
        b=bmWNbLuvN2IDDdStDByH+gvUY+b+HqEseTNkYtWYn9bthVjAv4m3AguUnxqYJoFX32
         VHQmNIAOYfKzpQw+7bxpzscBmUWHXcO2ebVGN9J3xLssF26lgSWX738roEJ9xaSsspvr
         aAomizoTdnldXnuN8HE1NkPZMUCI2v6yZjUUtS3ZAfSwxcbVNIQM5UBRSTgHIhVXKcjz
         l45RqVv2VQVoLODFAPEJemCyqCVCpzl/FZL++8hCz/q7btLV4L8SS3MHKuv5sodKD710
         tzj4KLClvVq30cqBzhWmEL8lLKkH4kGyvdxtdcK/xLvpjFRB2sOMSn22Rm3YT0B/48VF
         8kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792900927; x=1793505727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VU2DAJ/OjJ6m6U2gn3WXwMpKFJKrCfikczSVMn3jkTE=;
        b=iUL5zBAYiI9sLassT7EFIXkvgmfhlCXMu+esm5Ib4v0dmhB+HFYDKrF0bVN2J5ZaA5
         VFp+Zs3vALR8PLnw0O22Y3SkWOe9AMVoRLTJcWliOeQGZEUk47AjwqSuLjA2P0UXGVd1
         mRTmIZqzWrhtSg3dP2s076kSJye+Z+XxIc08t8iH6CgTqW0G73dqByjkNmXUvt4/nLhq
         tQ8sIlY/J7sv/HCJC3QwgC2dGzTuWK9chGSc+PLxsUNAtXE1QGc74Za5QdZuvqA+OsUG
         wb1gA8WL4OVTMkyo0CePQr3VBJ4JxExGDILrmGIGAqS+C3QO60JAm3q5+uATvtN2LiIc
         neYA==
X-Forwarded-Encrypted: i=1; AKwUvBy1T2HPyT61HuJlOSB/LGiYEXgxYDmGDg39WyhNSXGEA/rLbMdYV6B260jmDQZrwe9bpFKI/6zzQww=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiydRXBJ1rn+Z3jysuVis2uxghMInZ202Ax/dYFghIG0vq6Ko9
	MeajRqmH0+dwerk2bYxFpRA32XK4ATtTnwWHVINHoYl5BGt2CtyHxaY=
X-Gm-Gg: AYBFou3jepHj6LrL59VptZGgl9szpiqJPo2+TzIVTX+h10uhg1kkNPBfWcZbMbirHXD
	AitgBFtdkGRhihJ6tb77hKLqeABlJtBYDvOz+tqt44A22lu3otkXOMZtQA1awTfBjCvkAbj7oWO
	ZZMo9GTgYICHWlxnhw29nJ4iZoUfn1t6uWJtb9ZY5XZIZT3Jwplcq+E1YjUrD4zxBDvTp3WX+It
	YE1ovE9VIOXITZTHGPH1jizcOGpFI9KPhYi2iOFY9FYnHgd3QxRriEMcQjLr31dni0yYlOKYHri
	0I7wdIDRemGG/ehAE20xcnGlR3S+KNsqiE3qLHl1lk6Qr+yuOvPDqZopenFtNHdsYUlyOjFRnIj
	q2yK8lxxj3/aeiEJnzfxi+GBU0u8dhZ5jWf5llxuWTdBrLZOxCEWjh703coD3aci7LGt2atcTXj
	oo1LGfOzZAFsw+VXq/0k3NmB64Z1LiX0jiFcz8Y/YvcwWqtnuRBG+VwkNFWTKMWf+vnezL64dxf
	VQ9t3I+rGbpdEYh4tORjyTJMgLvsM9ReMEY1ugjfGOSPYh2vIKfICnQamoFyEkwWXExZ+iPROK/
	bjYdPPa+0gbA83Y=
X-Received: by 2002:a05:7022:3d83:b0:194:23e7:b526 with SMTP id a92af1059eb24-19937024792mr4822317c88.27.1792900926860;
        Sat, 24 Oct 2026 21:02:06 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:02:06 -0700 (PDT)
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
Subject: [PATCH 03/13] platform/apple-gmux: Fix MMIO interface
Date: Sat, 24 Oct 2026 23:59:39 -0400
Message-ID: <20261025040046.1602-4-atharvatiwarilinuxdev@gmail.com>
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

This patch brings a lot of fixes to MMIO interface such as:
1. Using 1ms waits instead of 100us.
2. Checking if Timed out before reading and writing
3. Adding missing wait before gmux_mmio_write32

Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 59 ++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 4e8786a5e..076ed7ba6 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -237,8 +237,8 @@ static int gmux_mmio_wait(struct apple_gmux_data *gmux_data)
 	u8 gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
 
 	while (i && gwr) {
+		fsleep(1000);
 		gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-		udelay(100);
 		i--;
 	}
 
@@ -250,12 +250,14 @@ static u8 gmux_mmio_read8(struct apple_gmux_data *gmux_data, int port)
 	u8 val;
 
 	mutex_lock(&gmux_data->index_lock);
-	gmux_mmio_wait(gmux_data);
-	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_READ | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-	gmux_mmio_wait(gmux_data);
-	val = ioread8(gmux_data->iomem_base);
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_READ | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+		if (!gmux_mmio_wait(gmux_data))
+			return 0;
+		val = ioread8(gmux_data->iomem_base);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 
 	return val;
@@ -265,14 +267,17 @@ static void gmux_mmio_write8(struct apple_gmux_data *gmux_data, int port,
 			      u8 val)
 {
 	mutex_lock(&gmux_data->index_lock);
-	gmux_mmio_wait(gmux_data);
-	iowrite8(val, gmux_data->iomem_base);
 
-	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite8(val, gmux_data->iomem_base);
 
-	gmux_mmio_wait(gmux_data);
+		iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_WRITE | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+
+		/* We already wrote the value there is no point to check if timeout */
+		gmux_mmio_wait(gmux_data);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 }
 
@@ -281,12 +286,16 @@ static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int port)
 	u32 val;
 
 	mutex_lock(&gmux_data->index_lock);
-	gmux_mmio_wait(gmux_data);
-	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_READ | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-	gmux_mmio_wait(gmux_data);
-	val = ioread32be(gmux_data->iomem_base);
+
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_READ | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+		if (!gmux_mmio_wait(gmux_data))
+			return 0;
+
+		val = ioread32be(gmux_data->iomem_base);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 
 	return val;
@@ -296,11 +305,13 @@ static void gmux_mmio_write32(struct apple_gmux_data *gmux_data, int port,
 			       u32 val)
 {
 	mutex_lock(&gmux_data->index_lock);
-	iowrite32be(val, gmux_data->iomem_base);
-	iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
-	iowrite8(GMUX_MMIO_WRITE | sizeof(val),
-		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-	gmux_mmio_wait(gmux_data);
+	if (gmux_mmio_wait(gmux_data)) {
+		iowrite32be(val, gmux_data->iomem_base);
+		iowrite8(port & 0xff, gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
+		iowrite8(GMUX_MMIO_WRITE | sizeof(val),
+			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
+		gmux_mmio_wait(gmux_data);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 }
 
-- 
2.55.0

