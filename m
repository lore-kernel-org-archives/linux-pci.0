Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672524;
	b=SZMZwTLiXV3VSwOlLB/CWd4Ey/ZKetRi5wC4rMV/kZos5Kk7ISbg7nlZWnBK72zt8XNf
	 xphNoYfMP3xLGMfKVnIY5TXOWRvJXAZ4wfFF5my3pq1qvQfuLHtFnoH1vIzMAmdxslh2I
	 JCzJeWbDqOUmxl7Xkg5LC2O/St/y3rWXslWIOcN98o+1IA7QnZDPvPUvXfWaI1F5jNpAp
	 RBg7VVtkUfYckMbtrGhBivQ7/FXHzmmBWT8hkS4UZ00RxvrBIOvoB//e/4FGOsdazk84h
	 e+E1DCtn8n9JOhymVi4+v3oxC8TH4IO4xF3a2wh/jhUvhSOm1m+/4G2HztWczztRhYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GtGLStqV/9gomKNOwdwCe8z1kLFSUJF9rkzKgx7PnnM=;
	b=JjYUE9dUzwbNpr55MdP1lXMtYIx0tlNVTZSuoUnEOCbVIpdYJn+Xm5iLZ6TuTtaddhhZ
	 yTAUGFJnW9bOqVYIUlUoWmHsHWsBLdOXLOys2HO3JqH7rw7qiWbQ0PTeMrcsXKIvVWm68
	 995mXaSBt2AstqG48ml1iDfpdzQkFuc6jDy0QL9XdUBCmQJ9559Lulp9cT8h2wXZ3m6VS
	 WJYMCqeHluBs7iWX91vccb/kCaaaf7QAF6uowwqdmActet+8QB7/w2PKHf8I0Mqzue13Z
	 1aKOIbJhAOpci6igj+NvvT1EgfiYFFPblAZAaDfFaxVbmg9G50OgZn8+tc07b0w0HWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HQ9EnJaI;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BA606A32D
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 706BA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HQ9EnJaI
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so2125968c88.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672523; x=1795277323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GtGLStqV/9gomKNOwdwCe8z1kLFSUJF9rkzKgx7PnnM=;
        b=HQ9EnJaIDbGCQLLrWh1x4Y+4/qC6R6Pt+OvJELUSA3/kN4jBG9tUAtlgaoBP2sm9Bw
         GGVF/86fKe2E9k5OtSbY1OZJjMrhxDGe9+iCphB6lbfbfnnOg0/wqcgqI3INundPAkjY
         Cdmx7sBVoWCJudVknh1qXoKJ5JOwkY/z+nWhcPdXiYpX9483M0vlycNm9QlfT6mkBb0Q
         iW3lTiNY7Jh0EKRVGAdb4C4h9mL4z14yajflj9ljl1F5hgR/Br8XlfugfG5IW2HOxs6x
         UtcP+LdZZ9xVIoq+NYKBUYC9KQAlh05PBRVzFJgfazeMQFpYe6LMfL604LzEke9q7gVg
         MtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672523; x=1795277323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GtGLStqV/9gomKNOwdwCe8z1kLFSUJF9rkzKgx7PnnM=;
        b=dUnDfgD63+j49EbsjNX6Gebtc47xDj5qP/+nAndb2waQlpJz9Rpt1LoShb6xgY9Vcx
         mhCVv3Fgq6q2TBJdYjlh60/iIh7DdA9d1rBsHCYMP0lzxEv98xj1ys6pZdKknaWPzcjW
         rr/Y3b0F8dPqprDkmyWIgHjInYsmbz4fuzaVn94nLKLe8vmGoCSKZHZjhM7HUjipdb1G
         mphA8wDalrcV/G+cn34do84pi7imkwJjYcVu1Z41O6A2mUYAU/4HXM/jq1ikxCyxNQoc
         AClBxC0+tQulvB6UMWzpLLbL9ZV9pPGUcMZ/vYtUVVLv+czQroMQA6hymQ5avcIzp07L
         vuPw==
X-Forwarded-Encrypted: i=1; AL+hErEgpA5NxASbNuaTugK+CF4U35/si+o8K069+8OwQTlu2u8lZ4Su3CV0AInODYJOvlmwZn6Nyxegnik=@vger.kernel.org
X-Gm-Message-State: APuU4Z9a2IGBjjv8q0xkfNQHEIYwr+WhTB9N/hM7N/cYOeF9c2OAR/To
	W/QAQ/jIQ+OwlZ6TYkGvPaq478u6FuDOciNiybQPpn75lJ7nETGgSiY=
X-Gm-Gg: AYBFou3E58dzc4yYd0rjDApUsWOjXrpIC3w0ObQmQGuOeGOzlmf8Lrj3JWZIDgzJ2P+
	3TD/Y9c+595Tq8QsKKX+KnoncuDYtC+fNKuK5g7GW2JWQOx69NATjiRYkM2SKjebHIliX2fbrRZ
	qUJwjJGLPmlC/JGL79llp5iuYgHXQf2qT9RCneSEGI6U9XeaznbDa78Dac9VEtyN60sgeoGJUNS
	M4MJPj4DYIpBhCMcX+Gy5ZQHct1HKAjhsxTaekHjSOFRKqQkrHsozGC9AkwH/khx2DrN9x84Fea
	9QH7DnE+k3iBO5jz2CW/JSTqd5KTYmYNlzZKWqcqku0G9rWLdVIKXvltzwR5DIJGGu4XRUSGWSc
	wnO2FNcB7b/MS4vDiRAs10HHnbpNfPIsZ2kCr/0QUQoSVRq7xyQPBSJQyqImzy1R92jhliaBZed
	BbKFZ0+DRzjQvVV6RC7kLzP8b69hZScLIq/8x/zyAuXroLbZbnOE1dDwN3kDaqfr+cvhpVbYBsv
	QcMg6ioBnwXfKsJD3BhGCpSvwOuBJdVnKZxIbeYo6cHYXQkl/yR6K2iJl+o7sM+IapgePqC9jeI
	rdxMWuxrMTjHbvT8y+XGz4dCs+TCfdytsATtay0+jnLrOvFLz51XmkCfL4tgGFXBwC4DEMZIp3m
	/gbE9hscK7kw=
X-Received: by 2002:a05:7022:1081:b0:154:e9d2:d741 with SMTP id a92af1059eb24-1b503112e3amr4894890c88.8.1794672522574;
        Sat, 14 Nov 2026 08:08:42 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:08:42 -0800 (PST)
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
Subject: [PATCH v2 03/12] platform/apple-gmux: Fix MMIO interface
Date: Sat, 14 Nov 2026 11:06:27 -0500
Message-ID: <20261114160731.3756-4-atharvatiwarilinuxdev@gmail.com>
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

This patch brings a lot of fixes to MMIO interface such as:
1. Using 1ms waits instead of 100us.
2. Checking if Timed out before reading and writing
3. Adding missing wait before gmux_mmio_write32

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 60 +++++++++++++++++--------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 34e94f2b2..9625551e5 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -235,8 +235,8 @@ static int gmux_mmio_wait(struct apple_gmux_data *gmux_data)
 	u8 gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
 
 	while (i && gwr) {
+		fsleep(1000);
 		gwr = ioread8(gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
-		udelay(100);
 		i--;
 	}
 
@@ -245,15 +245,16 @@ static int gmux_mmio_wait(struct apple_gmux_data *gmux_data)
 
 static u8 gmux_mmio_read8(struct apple_gmux_data *gmux_data, int port)
 {
-	u8 val;
+	u8 val = 0;
 
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
+		if (gmux_mmio_wait(gmux_data))
+			val = ioread8(gmux_data->iomem_base);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 
 	return val;
@@ -263,28 +264,33 @@ static void gmux_mmio_write8(struct apple_gmux_data *gmux_data, int port,
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
 
 static u32 gmux_mmio_read32(struct apple_gmux_data *gmux_data, int port)
 {
-	u32 val;
+	u32 val = 0;
 
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
+		if (gmux_mmio_wait(gmux_data))
+			val = ioread32be(gmux_data->iomem_base);
+	}
 	mutex_unlock(&gmux_data->index_lock);
 
 	return val;
@@ -294,11 +300,13 @@ static void gmux_mmio_write32(struct apple_gmux_data *gmux_data, int port,
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

