Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672684;
	b=03rVLJgWwSXFGu5Gnkqp6USh0ViVJWHJnBcImORkppcMhh9WrY1+O39bP52fBtZ+aZYp
	 7j0loSnKE8WV1hMPsc8ZJa/rriJiXlEfWu/Xph+FmwEHTDyuQat4LfpPyxHNuH9KQ708G
	 38woxc1knt2DbATlzLqYDJfLceUBRvKUkVsqWBkKOhqEasaV4ABQEfqcWWM97BCIq+J04
	 GaicJ4Nkp0YIL+9wpKY0ecjxsRixDZ2UE1yze8y0pDym/OeN9MWmm2MCzwqPJcuOQKrge
	 o+LGaUJC2/xH6zdDrSj71qFdnT9WvbfpRhLAAVfs7YEvU0ZN23hvHPqbNvZYGZohsDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kYhEGps0UomI4ThdCaZM/6xhr977LUTH98N7MCn1AQg=;
	b=VnHaurbp60Syg+bIFy2GdXduGGIW5VCD8erw6yqK0/C2WK0wWrdupqDP1qknd5B0Ku6C
	 3wtHU8sicN6TaDfSAkHX//uQP3VmwUrfnCcrZMPdi1/tpD9da/68egjARa400S+EYTrgz
	 KFO9xQE+Bk2gwpg7PKJ1VIsHb1LdsXBBYDGDQLzNG4iMR5tm19usWYbH8Gp7racCiIzP6
	 yqFn304HHu1KJ07eHDuwKG5NIImrVUdUKybsh7LNl3rDMRxwIAWtN4hgUB2HVv/iz9lEz
	 /AFVrar2gZXEgekFyShfM4x7hFmY1WSAxO4ny+4DR0xCYfzoxVT9X4lyS+w2IccTKLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=woZHVd2i;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5E606A334
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16B5E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=woZHVd2i
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36f6295304dso1709387eec.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672683; x=1795277483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kYhEGps0UomI4ThdCaZM/6xhr977LUTH98N7MCn1AQg=;
        b=woZHVd2iT20k8onAr2nEkXQnRJzo+gE+XboKYFuhp+KmzrYT6SgzU1/w8CLaRyxH7W
         MG7hnoPZP1hoTDWDHF7hpqsnitZ7bgNjWJPRhDKjaswZGCPLZJTbE+SgOSioqSU56i8m
         KaPJgYraiHigKrQF2TJpzcvdZ7ubfJ1rUoVZ+CvWKGnTNEhjHVGk2NFp9sE9OBY+umOz
         6R+imaKPsGgejASGmM9w0fbxB3Ec6Z6TOitLqyHmr5StObSyx0wRx3uFLRFJrAg1pEmU
         tEEXbqpH9J7fHogpX2xqUr9KTuElLmDAhnv8DcF4GOeM6dILd93+CZ8fHQyJuMqi91Iq
         HJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672683; x=1795277483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kYhEGps0UomI4ThdCaZM/6xhr977LUTH98N7MCn1AQg=;
        b=ABVLRK9g9xYJ0Y9CVmWpscjY46DNv9IIvyiejyLR34cPQmJT0OCLfOF0vCBnR+UbBD
         1DF8Dau4w4Aq22T7Gseb0zsKywoI4wUcpulIH0LR6duW6yALNGvHcUhC5TCp6NSTtUl0
         uSD/8gD2Sn8vllqvPKRrFfLq5AlR44knAgaywKcdaVOM8ERmZviG3225ANSJFQCHUCkD
         31SWpERl4l/91HaNDCW0HvqgHPhsZIt0S601p2gF/ISnOYqQXMMMDDTImaH4TuQmQEX0
         L1hHUPU/6fuEJkX3qEGdLljHt1JXhUbXlJP1AFIBl+KC20q1gt10f3oRbAwJLbnelWhN
         XMhw==
X-Forwarded-Encrypted: i=1; AL+hErEQDZFlLswXZ/Yv9TKz8D+7onqR+7pG3wfi/HIghuuU0q+PTVQRdFyRC09v1VtDk+ejrY3ZC035L7g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Dq38lvR+XDRB41/qpHO4s+sZTxWVZiuKdAMfPwfaVyr0wNcdb
	JiCQYpgkZYJks+bCPT91JuN68GTW7x1FMzHlf+nPHseXjQ9Kx6a9YR8=
X-Gm-Gg: AYBFou1UbQ32TlUWuUDRGQdfx/qhQKLIHm6JAaYUl5tOSUdq331/h3JNWXnf4p195zH
	kgCy3LH4emjXjW9rJ9R7hpt9m5kvMQPXbuAUkcY3CA/tPSjreNfyGF3TUW9PTDjXUoznsVahu+U
	WqjtIaNUj7rBHkxj4D+GoExIcaUGBiBUNNd/jdVVf6Az8m6+fzevEK15Zb+/8kAm1pP8U871iNs
	EPIk830X7z7dZP3kVqc4Q7NJ0rbhFnzN50JZhFnyW/pSIxmeyTfl+t4xPAfj++1sd/DGiY4yeD3
	ndpZqjA/uQ7ipUdORFguxQvMqpw5BZwNsqms/Rg9j2UzTuu4QrQ4dtsoBkWNvMXm6FNEW1+Td7z
	LInUB9ku/uDTbXDO3Du4dqwXP+IesY2QCggOhpmE42f+dI5rRLCRPNI90EDS+xYd28Xlq80hu0+
	ax/ZUZUSLgTbWTBkHh+ssFxe5HJ17tJI2/stInDrz9jB+GNXNJ0O+KyeZzbkMK92Ys+MSoEGlqZ
	v4RcgpukQCc86JK0ucfKTd3itlVTTCELm09iI1XLFVZ8ALSmTf21S9vSm5wEa+Gh7DKqOBMxOZW
	kYtM0bevhPAFgQ1/CT/DH0SEjUkPq4y84eIuRb1Ddd2GY4UQ8rOlCEAZB5iOpRt+UQ==
X-Received: by 2002:a05:693c:8115:b0:36a:1008:5815 with SMTP id 5a478bee46e88-37963372d85mr5904580eec.5.1794672683015;
        Sat, 14 Nov 2026 08:11:23 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:11:22 -0800 (PST)
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
Subject: [PATCH v2 12/12] drm/amd/display: Skip panel power savings on eDP links without a panel
Date: Sat, 14 Nov 2026 11:06:36 -0500
Message-ID: <20261114160731.3756-13-atharvatiwarilinuxdev@gmail.com>
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

When GMUX routes the internal panel to the integrated GPU, the eDP link
of the AMD GPU has no sink. It still exposed panel_power_savings, and
tuned writes it on every switch between AC and battery. Each write sends
a hotplug event and the following connector probe runtime resumes the
GPU that GMUX had powered off. Only create the attribute when the link
has a panel.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 3 +++
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 703d0617d..c8fbd2167 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -761,6 +761,9 @@ amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
 	if (amdgpu_dm_connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
 		return false;
 
+	if (!amdgpu_dm_connector->dc_link->edp_sink_present)
+		return false;
+
 	if (link->panel_type != PANEL_TYPE_LCD && !link->panel_config.cacp.cacp_supported)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 7ca17f803..d71f5e5da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -52,6 +52,7 @@ static void setup_test_connector(struct kunit *test,
 	fixture->aconnector->dc_link = fixture->link;
 	fixture->aconnector->base.dev = &fixture->adev->ddev;
 	fixture->link->connector_signal = signal;
+	fixture->link->edp_sink_present = true;
 }
 
 static void setup_test_dm_ddev(struct kunit *test, struct amdgpu_display_manager *dm)
-- 
2.55.0

