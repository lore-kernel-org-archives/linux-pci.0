Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900969;
	b=ihvYRApusfM14QcDVTCgjow8A41fW/Q5ciuRMdciCW9eOtSGhX+Ge3vBy7qNmdeAIRB1
	 DVD6eqMrsKnupG1MhRvdbObQZ1AQRCX1ahz3JISymogwb+HMxda1padVghfC7Y7ihzOm3
	 6DZBhdL8nMlnfpkdSmju5bF+CnQIr6ZERtWyYVIZZDlQcWgsKVSB2VFKRL+TVkWXSTvuG
	 Q20IIk7rTbw97z0eAorCqzIaZf660XbWidfbMFELTNXuuR1BPe4jTvkrdO21V3m58wfBN
	 PbZhPxzmCjl+CNo5kZBHnNQUjpSbLv4uQ8hoyffUwNY4aq3sY2gMDkUobfJIdyzF6Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kIWFjWx6bY2aMzP1Dlox6FZiyYw6gduqI5+MEIlEj5E=;
	b=P4SI5+opL0o/PZjgsH9OPjqLwcAHsY9ttmsmSw9fh2rIoGJZCiuLNPhPGsIsUJ+90VBr
	 PXYdCAzmXx0Q8d0u1Tf2pGTdH7g2pgzjXgUjseOitvy3GzG5zyU3Abz/hzmKQ78FHlazm
	 AMqkWNs542S9wxe/TLocE0APQiTq3tMqjgouHcf9HtkcHrLN2cwc4J5X5sXLFZgqJM8bC
	 4ibIseSeRj9nwfkevBhCCvtX2rlFT8aZqFKQDTiuEk4lSte3ZvWiZGddRYBfZ+0UoylO+
	 3vhrTOEWQJhMiy3ATx4hoKJWSmORwPduYj+0m8iK9+ph0+OlUNBw+QugUBtNM0G5ldw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WDBnovbH;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12904606A31E
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12904606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WDBnovbH
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3550c917fd3so3059830eec.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792900968; x=1793505768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIWFjWx6bY2aMzP1Dlox6FZiyYw6gduqI5+MEIlEj5E=;
        b=WDBnovbHpvOpjdqqRAZCqZ/d1ZGckJZx8Ecb+LplBowbPWF38i1otc7fHClqk3vswU
         6p6p2KhpZKXDiP7533kfVkOVMDVmV/JlYmIGBxfwc3YeW/jvJC08/E8XPOCiZeXhc7TI
         Fkk93D9W8429SPchCLu8sJxpRx3ZJaSoPBBAQNOIpmV1LJqggboW65XMg8dchAkLoyl1
         zQKW8WShzk3zOYZ9UEyiIVpANUVK+0RSGiefC6FU64TSO/2uFPFoHgBA8F6cfhXTpqHn
         1ogASV07H0M7oWHiVdWJJiI4Avuq/7XYHbKjP0ntYPUrSd1R4GgA/BNiPG76sK79nXJ0
         EA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792900968; x=1793505768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kIWFjWx6bY2aMzP1Dlox6FZiyYw6gduqI5+MEIlEj5E=;
        b=d/yTMtMJrO4xE8k7pe59D5oFvScjO065eK8ULFyllwEmtSm4U986alCj7VY+FgePb5
         C930LRw48FNJVjriOkQX0vNaRpKlfTSZjBXp3lr4JnwcEI59oLN6K2GEg8nfw75iVmNy
         672xAwPvFRYiFTKMXyqM4pz6hkWZGYNhbfH8ZgqXeOTi+J9+AfzlhIUDOksHS23M1lR/
         Q124HKbU/BgMVOhXdNAXA5ZjzZg6v0werSXCJBl5HBwwrzyt+LGmHClTIN2/1MptgtAN
         BTqtr71S5f4y1F+sFIOoDozS88w91qIJxa5vh+up2ykWikg+JPLB8fTEtfXb5bytEDLD
         LkQQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5x04WkXuU83V12e8s7oKXck9rDqZdvoTronDZNVpEfCw5LXSgEos0NDvXKvB730s2m3gRGENL4V0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVD1Ckee3wtlnzJU0YjfwHtM9PGtBtcF3qbzhXSgC/uOQwIZ8G
	CMNLE3M74lOLbAibmgkAOG48DPt4uR5NRnP4qRrxc7yHoQbnI9zR/As=
X-Gm-Gg: AYBFou0m4z0vnQlr25qTu7fqELCocTO4LAIsfLYiU6UFSA27at/e5uNwl5LN9YY/qVX
	UCeg3KYTfmuNc+HM8vLdRXd0NyR7BGHUv8FLZqw3Bc1/DN78zAbgodfIBojN0Lhlh0iJ6KdH//V
	57R5fKi91GrIS1YeFwrni2bY0k4dHLJxUB9pHuuaGnjGiFD/k+RBvC2cQyiGll6slexHKXCQUde
	we63os4ePO3E5S8Hf82Q1MJQWThF4vFMWYGX2OD/3Hvd/nCKs8ulCC44/Wm9FTT4gtzv1kAYTHh
	gYKHo9XPd9FSdDk5yjN9rPCwvDdvlMMq3xUnp4boCMrUiPgPFMjkDa2Akp6CqWfMqHf3U9KCRfl
	umVNXklHy7uU4AhaIVmtjjo+6O9hQ5HyXkPy0zhEMxgInb4DIEKVzvu4mNL4rg4FU2Cb+TD8akc
	mkB4rx3k6571yN83hpA10J31ytcz6DOPBazDQaRQdjxG5ldWPUy8JCYw5JKtBr6y/y+gwOt9k1J
	VUH5Qla9qdPtKoT3bHHTIQCDTFUvl/tnUS1INRcrz2QlFkzm8nxrDELNxxsn6/BIayiBKNLtVRN
	st/lb2xsfUUncwMe
X-Received: by 2002:a05:701a:ca0b:b0:17d:7b45:f91f with SMTP id a92af1059eb24-1993580fcd2mr5442774c88.32.1792900968114;
        Sat, 24 Oct 2026 21:02:48 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:02:47 -0700 (PDT)
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
Subject: [PATCH 06/13] platform/apple-gmux: Add parameter to configure boot gpu
Date: Sat, 24 Oct 2026 23:59:42 -0400
Message-ID: <20261025040046.1602-7-atharvatiwarilinuxdev@gmail.com>
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

Currently on Indexed and MMIO systems, the system can't change
GPU's on runtime, as the display is not trained on the secondary
GPU, to combat this, we add a module parameter to configure the boot
GPU, so users can change to iGPU or dGPU via reboot.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 637b3b216..6a9580f27 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -109,6 +109,10 @@ struct apple_gmux_config {
 	char *name;
 };
 
+static int boot_gpu = -1;
+module_param(boot_gpu, int, 0);
+MODULE_PARM_DESC(boot_gpu, "Configure the boot gpu (-1 = auto, 0 = iGPU, 1 = dGPU)");
+
 #define GMUX_INTERRUPT_ENABLE		0xff
 #define GMUX_INTERRUPT_DISABLE		0x00
 
@@ -1215,6 +1219,11 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	gmux_enable_interrupts(gmux_data, 1);
 	gmux_read_switch_state(gmux_data);
 
+	if (boot_gpu == 0)
+		gmux_switchto(VGA_SWITCHEROO_IGD);
+	else if (boot_gpu == 1)
+		gmux_switchto(VGA_SWITCHEROO_DIS);
+
 	/*
 	 * Retina MacBook Pros cannot switch the panel's AUX separately
 	 * and need eDP pre-calibration. They are distinguishable from
-- 
2.55.0

