Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900983;
	b=azTequQbnbxPdRcfn4p2P6Z4x6dWr16ZsIZz+CqlHFzsP+cv5N/SAhtn9atu1fitlai9
	 2bh7/r/tUq68VxeC1Vr6x3c+PGPA/sD4XVlbRo2l9OgZ8dO0ByzUfp7hgZYT4GKTz0hja
	 URlZrju8ANqmgXDrUr4+QokHuMxQMa/IW+C2+KxAW3zJhivfad5DZM3+LUF3Xdazo/0rM
	 ywxtk2h6Z67vm3fmdTtYpkebyabZ/tZUk8cDsQKBXoFJErLusY/Q7du+CNRY7kD520Cp9
	 T9+zCEeCxCCphlo2ustxS7Ia1qTX4RdMxPqKMmqwrXX0a5npH3cJbMeOZQBWbXErj0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=788LSEJ/nQEllvwR1yiw9f56ICCRyDbD8OfNlkBC7CM=;
	b=arpfwKD3GgweecHIIBReul13TIeNuhQaI9WSpXD/cY1Z9VgCqCLA+nOqkcT62wEZW43r
	 1eimOB2vC5V4uyY0IptY0GvMkYCrV6B6rfSSxuY5dXWQe3VTG78O5UJaLtPo3EsPiARYA
	 7Ca9+0Edcj9RD/Ebj0KNkXAJJyiVckm0u13YQs4CKekyb/MPBfaIL5inI3h49WzYEmR4l
	 Tm+YGL5NhN5gBqQSBeqH4ANJD1NuVcsuXWgZrTxIB9rN7Da9vH9ykEE9IqHjGhwKGiJrf
	 hwu7ZfC73y9W2UgjaVOhjDXtLNQgQihI9nQQrwrPFaIAx9LcY0dUjMVFIxIUeK9TSAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ixYEsRnk;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67E606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF67E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ixYEsRnk
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1517bda04a0so2120098c88.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792900982; x=1793505782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=788LSEJ/nQEllvwR1yiw9f56ICCRyDbD8OfNlkBC7CM=;
        b=ixYEsRnkcf+nLoavUDfr9s9yHU5Gk20w9A4fBE5XOc+c6F+uphlXnEjou9txBIaHPK
         N1pHduhAjECd8wN1ZDfifTirzhtl0RJiOEScOKQ/Yb0hM79ddp6gHUyHS+pOIh5B7pL2
         dJ2C/nOtWz+ZJQFGKwBuJ/XwAiW5aipTEt4fA7/idc+npvPg1Undt2Wwi8wnyEb2B+k6
         QyClQAahO8pmlx6DtjZynEMLHSnCtq95kJKJNKNmMtRYN44vrkXUZhBvW7vA0HkresgR
         ajH6+fk/yUaNVf0QWhXRZCsEoxAL1Q+bKVq49QhEOrnpYZOUIP/FQlRJm/NSwL+5GD4G
         6dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792900982; x=1793505782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=788LSEJ/nQEllvwR1yiw9f56ICCRyDbD8OfNlkBC7CM=;
        b=v0X/Fh9tFpFOVzi44mPe/5eGgY4HyfuzHAfgsduifVmziIElkLhOqapOu5WECKOzyW
         tya0N0vuq+xHy4d/9caiQPlDEvw1y1ThyZNqKt7dQ0ZF75tgPtMY0vebRNvBLyN4H1v+
         iKuTNtS79/Bi/qoTYoYOPEb9kuLRIYZuf15nFo8fvd7HajQU8V8pH68TvJhcIBr0w5LU
         Fqk2wfLw8tZRZv87sQlJrbe7iRYO3BFnJiKTB1qPr7/rsD4KnPSr1MHJnQL6Nfl2yyl1
         Ghw0Y0fsZ/k+O/To7dtUwg0orl9SI4pr+zA0dnKMnN+NgMA7WgOC0fUSHG//1xaDtDla
         lYZw==
X-Forwarded-Encrypted: i=1; AKwUvBx31VYPm2e0rGTvkog8ENsdClgL0xb2OJDD3JqquHZvgcZDxMiPyIJK5dvOCN0iVtvS25VwQozvBp4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKK50gG1+uQ5bz/KFp9PWab6Z5SXbe4RPjhuJm0Vvwsgxf82v9e
	z4RGG6t7U1zXr0GqpHNXYPyV3TlWc5ZRRwoDVGYMQvTLb9c11nPDXOw=
X-Gm-Gg: AYBFou1HDNgzMer/+c5ms0hDg0HMm/WFIVVXuTL9CfxTcTDNw3pWxJ3htRHndbYcTvL
	PJloczCTzvkRe2aVPX7+s4KaFrRYak2TMcXSXzzGOgT9yuQUDlNBfP0fUK7IOYi7+QE8yyB2mtL
	AbIJSfS69jVceUSxzRzQunbup7E77rLO3mNwGuxu63F6dUb/2jv1SccI+F190Ubgmquj3BNPpQl
	tAs2y9a5+Q0FDhvJuAtHlkeBjwbSdzzvq+zRzm7S4LAm6Xz6ZL2p8fOR4MunWoEDocbrZCure7e
	cR9/DjlHp2OKzrwkLiYwXX8Bl6XXZRplkxdZ6NvlDt/RCxe3pkUGYZDpI2JmyC8U2IBtaRUungX
	nvezIkWZF+jRFbGBQgZfwwW8gEKXmBLATuHv/x8VkM20iOrKI7FVMUNVAvpZHZiYrogEDZDW1bw
	e3L/MReaoksGUtFx5UAezyT36jLKkX5Fa/3HbZ0mwRjWNH2T9Q0DuqIq6HV6B3kPEXga6fV7pVc
	/SsSzh2jWwiB+QPvY33fTc514nfhV6ZF8DJFS3xGe/C0ijBipD51ctew5tP0YBtAUNR7itLVtiJ
	SuSQTa1Z5SUVioY=
X-Received: by 2002:a05:701a:ca05:b0:14c:1f57:3e86 with SMTP id a92af1059eb24-1993f3f1d75mr5747943c88.47.1792900981958;
        Sat, 24 Oct 2026 21:03:01 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:03:01 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
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
	Andre Eikmeyer <dev@deq.rocks>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 07/13] platform/apple-gmux: Add check to detect FSS
Date: Sat, 24 Oct 2026 23:59:43 -0400
Message-ID: <20261025040046.1602-8-atharvatiwarilinuxdev@gmail.com>
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

On MMIO macs, there is feature called FSS, we assume its
a display syncing technology between internal links
(for example 5K iMacs).

We detect it and then warn the user about it, if its broken/unavailable.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 2 ++
 include/linux/apple-gmux.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 6a9580f27..dda281f2f 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -1224,6 +1224,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	else if (boot_gpu == 1)
 		gmux_switchto(VGA_SWITCHEROO_DIS);
 
+	if (type == APPLE_GMUX_TYPE_MMIO && gmux_read8(gmux_data, GMUX_PORT_FSS) & 1)
+		pr_warn("FSS Failure, display tearing expected\n");
 	/*
 	 * Retina MacBook Pros cannot switch the panel's AUX separately
 	 * and need eDP pre-calibration. They are distinguishable from
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index 206d97ffd..a4fa84500 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -22,6 +22,7 @@
 #define GMUX_PORT_VERSION_RELEASE	0x06
 #define GMUX_PORT_SWITCH_DISPLAY	0x10
 #define GMUX_PORT_SWITCH_GET_DISPLAY	0x11
+#define GMUX_PORT_FSS			0x12
 #define GMUX_PORT_INTERRUPT_ENABLE	0x14
 #define GMUX_PORT_INTERRUPT_STATUS	0x16
 #define GMUX_PORT_SWITCH_DDC		0x28
-- 
2.55.0

