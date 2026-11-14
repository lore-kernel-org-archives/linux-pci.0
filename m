Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672581;
	b=mc00ZlDhVb4CGZCtlNvr3ptIkXBeXYDziN78uZ+XdN5UY5LEuveJnspOxSCSq50ujQcp
	 Ban1RnUEz4SYM9YsYFloCwTynn5t8ogea0RnseLOd9zvsd31p8dy4AIicVpaCJCfg5Ya8
	 ecmiQ3oLyz/bFYyWbJYg11VPLyvsyZQIjBA8joK5oOUMfsBr3Whixj/o3w0+V07derBer
	 XQBm3YXfb1UHdERK30fcAbz6D7i7ivOqe3cQgH7ffVbsIv+k5uQFSgGyYfMPA34CevE0O
	 eblzbatyhIHlp4EAlwq8M35eiFFsltiWTGW3R/Q5kkdO/rl7wB5SSXpXnwVN3qA7JkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5Ir5z9ASuMHPvYC0aOx9GZ500HHk9wmpAKRwADGNQH8=;
	b=5FEzlGKTObHlXvZWaTzqobHosDk9z1OunCu70RFokAchOW1DPjMueGt9Qu8tet65QF4r
	 omWLx4fkTSvo/uTgGBVkihZvAJNwjhPAMBlb2b0HmHVvUEPGJIfPyeJm1iQEYgBli4hvs
	 EDeEwYgekB1cCwc09eex0Ucrc7uck7h7E0qYZYvNzckY/nO+SxLvVxKFGXgFX5r+tKzH7
	 eYOjT6XxLuYUJivC+cY7ak/58L5JxgpO+bqkRJj9Ee/Atyn3miYq8pGEYBcMvUry+vGZa
	 +u10igaR0MbKcAy7erGb0wc9gRktejFkhNBbuj5NmRTYR3yBxsgJ4Zbx9xQ5KA/FlrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uIm9AAin;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0FA606A329
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C0FA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uIm9AAin
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-37986eb6fa2so1680932eec.0
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672580; x=1795277380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Ir5z9ASuMHPvYC0aOx9GZ500HHk9wmpAKRwADGNQH8=;
        b=uIm9AAin37f1DmnmWI/WA9iNizuoMxHTH/ZK/2yI5YNDPtU4tz+Hz3DhfXXM9tWIR4
         NusOf9ieQA4sgvFT38yKJChg1gqwaKl66YD+dkdgfbGZgPcN7xPZ6ZU7vCfUcA5H7DUT
         yH/b7JTtmoCxMMWAFWXI8hcf9C3Enq/IEJzM+OPQ3AU4tp+GTLbSMCCoWL/NC5mv2ENq
         Ag/GKZrZnJFu3qLClJ3MiEVjZc2D8+EYHNTCER2NauyOsYT6wHTVDVPNM0g5B6vhE7R8
         JZJ9xXI77qfuRh/U4Q0WYCg6Eerd6b8o/9MxSpnIvt24SHTVopZmnlqaZkm8kJ1XNv9O
         2caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672580; x=1795277380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Ir5z9ASuMHPvYC0aOx9GZ500HHk9wmpAKRwADGNQH8=;
        b=0iTLCpvA3QrAHNchziVoetHxnU/FvTqpWKxiOOkeg0V32/iJpi6ZPxLndJ08vmIn35
         ysIvLcvtWFiOg1N4h6u7mTT7FS26VGL9h6qvc+3RoWCMxHAcE1RxUrojoEf9cCDvqrxz
         NY2BcYeRglIpYDNa3xGWytmvXlCSBYh5wRj/U2uKETZIaMkWc9FEXDadYfp6SRxVop28
         oRhTYLl5CXqdHEq0y18UL53KtMSzT7zH754u+K+C66gTRDw7yMN9N7Rm1x2k1UkG+KdM
         5CJN7/YHp0lBYW49iP5+uoEU3/YrjQmY6PYUbtPV4lRJAQ+Oq36rr1RcMlLwjJsWetYb
         UuMg==
X-Forwarded-Encrypted: i=1; AL+hErHsY2hdlqs+BzyYh17cODgBjRin5FD9c5uKP9Qv9nmOMikt1cD/vot0o6qkmywN2+8emSODvVy4jK4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OPUCWjud53VdcnnvUsZztN1FVAV2fRUDvmkzZZcB3VCYCNWHO
	lO0KymWe4SCXrMaTpaOCRGpTtxchtUfrcJuI+OZAF1RUAvR+R9EE4rw=
X-Gm-Gg: AYBFou1BELG7+rKz6tAgUVxTjKMLLbH2htgDzkLw7SvOp9nEis33nwTbua0bEJCDVeW
	eURy+/sdW1nzcG2QdYV7QbVypghGvlFQU9IvOrMVnD2Y1zOOxOXguTTzUQRxTFLnIMoNwtpdv1Q
	Bc4GUd4pwfokCYRFogMhBi03pMZSp3p4TNPkpRt4JmpnskO6+btW8RaaM43N3U+gX9hfOo51PvD
	Cfhdl9Q2vjtAUR69IDFeFbiYnkYyQqmxXWfe4shh5yVYDd8bFvXAAdRo+6tpeKQYdDj9jPTs7fD
	QMPbTHnwZhS2fHpYDt6Y7QWI8xd0iaCauTV2ePGA6kn0+URp5H93Ma6mE425ARx/BoOxBVtwoAP
	PbLhnwDZmA25Dma2WksaUZTyWCllGI7EImqr8jy351u4PpYrDCLfr4p4/JEybTlVr4M9JgzWDYH
	PXrva9ipGLS9Z/lflyjGMX7F6vrJmxcnMc3Yfe1ufxN6I+epi39mAvw1VbaXBTVB60L60BnmApo
	0VhPmHkamdvwJ1X470YDaTnFIppMHXybPs5NVCv+92hwQozeU8ER88mAQlLJyZvz53sV9qeXxjh
	wA9p3BYrm+qXo7XiWb514lGrklS2KWrqxHrnnyi17/ZWFeQY8XXqvga6Z2IXFFoP0gE=
X-Received: by 2002:a05:701b:4648:b0:19b:1202:77f8 with SMTP id a92af1059eb24-1b503192303mr5750642c88.32.1794672579670;
        Sat, 14 Nov 2026 08:09:39 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:09:39 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Sebastian Zygadlo <szgit@icloud.com>,
	Yossef Osman <yossef.osman@proton.me>,
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
Subject: [PATCH v2 06/12] platform/apple-gmux: Add check to detect FSS
Date: Sat, 14 Nov 2026 11:06:30 -0500
Message-ID: <20261114160731.3756-7-atharvatiwarilinuxdev@gmail.com>
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

On MMIO macs, there is feature called FSS, we assume its
a display syncing technology between internal links
(for example 5K iMacs).

We detect it and then warn the user about it, if its broken/unavailable.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 2 ++
 include/linux/apple-gmux.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index c4a953b5b..a1b7a4709 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -1196,6 +1196,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	gmux_enable_interrupts(gmux_data, 1);
 	gmux_read_switch_state(gmux_data);
 
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

