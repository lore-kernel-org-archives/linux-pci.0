Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290999;
	b=1f1tby965B894QNgNWWku68jsS5YkmfNxaKlajvwv496rV7uN7edUWEiZwmJLUY7pSMZ
	 n55mAPZPUHHqOwQhgxwcM2DUECzZu+QQLXMBaADqWlEuN/LprBsyxGOzdWT5+/1BlFEC5
	 vMB1L5tn+A+EF971znzAZFlLcQawFMOn6GtPK0Il84egbvcnNB3UTWTm8Xw8Vc8UW6g0E
	 IuEjQDOLhQnEhWhtas4u8NTqa0x/ygBY5iEmlKP8FhnU/BvJNSvTb3uzbGq3OrlTq9Npb
	 WCj0Kdkzuu+oZxjnDOEA1gGOQOsIlNmL50rGdBSgisYWqr03N0Z3ubKYNHxeVbFcpZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pmMAA3zxsaH8NpSbi674z9mZNWB0uLuDo+2Mdyd35Hs=;
	b=MpFmgZ1XDjbZz2Wtkfl3LL21VZUu2AIDPhQMxTwRX4OtLm081XSRuXzn203DkexjCNlQ
	 rOIokclJJg02rseGXjfLPUnwVCxwkffMyhJ4cVUXnc0wXfDC4Gtesoz1TIsLaCz32FQCI
	 HiNfYpstEb0Y1GulAqTv9alanv8NH3CW/gIsMA0p0ZOgi2QFcN5p+obC+56OEe55FNibC
	 Hpz7dOM01cRxxD8zTDK/BRrD5fYsZ3AJN5KOn2JWxdJQ/jHvOTY3fWxoE9ql4GvKpdEZ+
	 MlriI2ANoZYK9GJEi3dQsXbsvJnH45zO0sNUi3caNedJd3gh/qmURg6IlD1uO3JgoCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Hb5sagTj;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84802606A32A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 16:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84802606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Hb5sagTj
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93efc0452b5so153984585a.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793290997; x=1793895797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pmMAA3zxsaH8NpSbi674z9mZNWB0uLuDo+2Mdyd35Hs=;
        b=Hb5sagTjqXkLketPYMPvOpYFJMOblRr6tth450tgZUXXuCu8KLf5Roys/m08GkUz8E
         AG9xaup3ufOGFVmZodGRWzQ6d0CPXX/M2CROqkyxXDpP5N3vOctOIsZoJQGTd54l37pz
         h2A/fzILqsp7gWqKF+zJjWmJIhMPcul0Yzu4LbmTcebWlQLL3iYI9Ao0IxpGfv2Vtzqc
         owssKPbpAkNZ/uYs/HzHuvlrI1Vkc7MyjoQtgXFNefwfy1hEgdnph2100QkhDhZt+qts
         9g+FEtnambYFjI4WtTzTyMw3qbUbvADRFXqEmNEH7fozfoORGG6aWSa3G4h84KsJ/DMh
         q7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290997; x=1793895797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pmMAA3zxsaH8NpSbi674z9mZNWB0uLuDo+2Mdyd35Hs=;
        b=xzp46dSmjAx6oZ3++Zb0K+0x6rsHenDOGNf0A7F/csQK70SMpI6t+xiaQEO4x/CzFe
         B2Xb6FN+2eDRvkIDlP6ewBii3VQtSxoa6Tq3qGGXOKonHZ4SdwDJu2n1LufFq9tn+sHa
         Ov2FaY0tXpr+nVMj1D2n5l2MZkOHQtRCnhbUmNUwPX6qLdFy8EpHovPS5Vz4MTOrE4XN
         PVmIS8Vf0qo/jAsVd+/cYtS/PMVQyYLubWcfx1Y0+80MDrtjwzjVi86XKct9teBFs+Dw
         KNoL8zDFXv4WdAx96wXsdRkudR/Mc45XiLXgjfvacvwsflJZOXw1JG8QBKHGaLSXJvCk
         f+ww==
X-Forwarded-Encrypted: i=1; AKwUvBzlUnFAPdy8Uz3+s4l/bjyMnlIdgjk8bQAZJNrmo7q9J6npWbIIu0iIPBYVxGpuYybWugRkvgZhoQ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK98EeXuu/w/K6Oij9Dxi+zi5LhmrJBksM1jOTyEmMHJmsd7Csw
	s8MUhhr0sYv+7jDlEEw9iWo+KeSxkjCdPRcAUcXIz0XBPur7XUQC/CzEKkzFbjQABQ==
X-Gm-Gg: AYBFou0EkRzunmMQpw972iai4b5HkrUD66lAJC4Mq0P0ssq6MJNrQtH0DqhvcQgF0rk
	qJFBlekhKFh03UPuLzLb0Ym19mQSyvBq7HppfBEbcsNriqsQ19CNPm3G7GagPvFJVzoaJPkkL1Z
	ktqJ2eS41rvrODFSlZQwpKG1J5ZCbiCEJWw2iSljtS1k72zRKxijIBt7yBF7RVvBYQsM7dfFlPx
	tQLIG1FCcJdg2DwUe6OkYtOgfEnYwCu7qluFJ43MPtxhXhlK63t+DJ7NlnsOaU5XTdW0zHuPd15
	FMGg4dTI97T3wqodOuoe2g2SjxqJFD7d8oUuvaF0L5bcEr7w2JygoAeWaSZ821pCV3Z4QqZhXBk
	TsfZVBgT9WlMLg5frWObxWXBqLguCDKGHUgijajtdFtkeldezVFPgrwhpTeFcogJfHLM9ddZwWI
	S3ywO9yVlgpTLEBa0rTZkbqB6MOcjjwdYOh40lsh6Dy8PnUcj9os+dKhumi+BLChtDzVX7qcySO
	1ox27Zp8UAimbElMFhf3XxacI7x7Cwusz06328jbqpMMCP8Mfm3wZM+CU3VvzjtgMtg57kW7pcE
	oJArmDRRw0QRGiFd/CO2FgkLOmTTodVKp1qf3O2o786dJblKIea3
X-Received: by 2002:a05:620a:1a10:b0:93a:9ef5:d370 with SMTP id af79cd13be357-9440893885amr892995885a.1.1793290997148;
        Thu, 29 Oct 2026 09:23:17 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a771c9sm1565150285a.34.2026.10.29.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:23:16 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: x86@kernel.org
Cc: mario.limonciello@amd.com,
	tzimmermann@suse.de,
	aaron.ma@canonical.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] x86/video: Preserve the default VGA fallback for legacy modes
Date: Thu, 29 Oct 2026 12:23:11 -0400
Message-ID: <20261029162311.3389523-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit 596b3678326d ("x86/video: Only fall back to vga_default_device()
without screen info") made video_is_primary_device() rely exclusively
on screen_info resources whenever any are available.

However, screen_info_resources() also returns legacy I/O and memory
ranges for VGA text modes. These ranges are not PCI BARs, so the resource
lookup fails and the default VGA fallback is skipped.

On a SeaBIOS QEMU guest with bochs and VKMS, the boot VGA loses its DRM
boot_display attribute and fbcon leaves the console on VKMS. This can
be checked with:

    cat /sys/class/drm/card1/boot_display
    stty -F /dev/tty1 size

Without the fix, boot_display is missing and tty1 is 48 rows by 128
columns. With it, boot_display contains 1 and tty1 is 50 rows by 160
columns.

Use resource-based selection only for linear framebuffers. Fall back to
vga_default_device() for legacy display modes, while keeping EFI and
VESA framebuffer ownership authoritative.

Fixes: 596b3678326d ("x86/video: Only fall back to vga_default_device() without screen info")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested in QEMU/KVM with identical KASAN configs: SeaBIOS VGA text mode
(with and without VKMS), VESA, and OVMF with one and two virtual GPUs.
All 26 guest-only helper checks pass, including EFI/VESA framebuffer
ownership, missing framebuffer resources, and addresses above 4 GiB.
Also build-tested x86-32 with/without CONFIG_SCREEN_INFO, and x86-64
without CONFIG_SCREEN_INFO.

 arch/x86/video/video-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
index 8ed82fff7638..b8f83346dfe8 100644
--- a/arch/x86/video/video-common.c
+++ b/arch/x86/video/video-common.c
@@ -45,7 +45,7 @@ bool video_is_primary_device(struct device *dev)
 
 #ifdef CONFIG_SCREEN_INFO
 	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
-	if (numres > 0) {
+	if (numres > 0 && __screen_info_has_lfb(screen_info_video_type(si))) {
 		for (i = 0; i < numres; ++i) {
 			if (!(res[i].flags & IORESOURCE_MEM))
 				continue;

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.53.0

