Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901062;
	b=HYt1gHw8mwNZaPBoB1Li/pkEnevONhl/Jv6zBCJeHwc7fXKb0mdNO6F2akONQXPiRzO9
	 MT7uAUTvEuClqkIECYuoLLk3jOjFaBAN5j6rZEi9SultstEjIcmG1JwcJxSsbaVX9SJMV
	 dKS9Fz0uUWleIjXhMg00H9FhqR/CuW1HJMBAGcYhK/qqhdC+GN+ZV0St26g9QCaCydmAQ
	 O5JxWGh8euThrTeezBZzSXjDOMlzhTr4cD0xfE4RdnYfbuQ5MilPd5sBU5bZg+I8mKxyP
	 BFzoHoN0KiqgaxApeOkZDtbVOLE0CrgY4Ff/vQxXRqjV2k5yHQG/0mHeVlCr6dSmndw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vQs/9/+ieViMtOkwrXjmCA1Fgb4ppa6TVTluwiw88qI=;
	b=dfqG2WXJLgaY/4nR00+CVdsDw9OI5noKaaH/4uj0TrL8MYJIoWT51wqaTfqvXQLuJBG3
	 d9KFtuC0EnZMuOwgr2+h93gond0aPs6ozLFpAPEWAL4uJdkl+Py4Izxjn+Ja9E6Fd3cLo
	 gvuQhylPSJpFhhYC6UZvSi2md0tCfocHfFAHjQgxIq+rFZWY+Y6acSfCw+wi9VPRUczUE
	 b/qESIwLDfUUkf2bwQCYrZUJ1fPvpqdiS5Xqs21bUhZPcr54o548peqhkUqMNfJFg6WMR
	 EXwo/cfwWZBOoVNV8z8th7OhQO0ZtWmGbD9jt7UXr1DSDe3BeGVzED9E+RwPbSwzsGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZuEuwjrk;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348F606A31D
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3348F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZuEuwjrk
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14394530ec6so2669939c88.1
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792901061; x=1793505861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vQs/9/+ieViMtOkwrXjmCA1Fgb4ppa6TVTluwiw88qI=;
        b=ZuEuwjrkFboCQLGl7BO2g51vb3rO2T1Zq3HL+L1LrQF3k84K+22gz01pRvMt+zTJxV
         QLj00NAcQInG23OG0LnXkT+0JNGBlWdTvDOZYFtmAE10mrF0MRPo/VnWzTYBOkkc7zC9
         5UEPAePmilbPJZUKVmor0JbEDyEC8DNOm+7ejcDgJEJ5bg5KOisbWji+jXiT6KBk71XN
         c4xV0sVi9yvbLXChvhUBKDEam0m5AMjGV+0whDwCqrLhWT3CHDV0GDraYk4eHa2W5JEW
         8GczFoOp7CcbUxJ6PPG3JTreoi0qckGqavfgY/uvkl1kj3h0/wF7wKeNj/h3TmWcFTMC
         rk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792901061; x=1793505861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vQs/9/+ieViMtOkwrXjmCA1Fgb4ppa6TVTluwiw88qI=;
        b=D/P0z2tQb4QlNdWSFcL33wTCFtFJmyYHR5EJogeCmLsERrCuf7Q9buHpX8WeY5bl2a
         d2uBFTewfZ05Gjlf4J/l89NBQkO/7cQ53M0LLvzBeXUMCAg5h6UiysK83CW1KVfImjxx
         dN0sLvQFNbu8bN9RruSmAzja5u0MK7i6sN2VKAp+ZkdE27mHLV3LTyGUSiUoTg6Y0MQR
         Qp29OTsFXo8qzqQrG/j1H4KEN4vV+Y38NTXlS0GM6vL2Yfm/NRGOHROc2s1/FV3zil3O
         FK0v+Ro8M6DcsZOZAA7nNggOytCR5ai0Kt7Km0LTM4Xb6fVUdaTYbxU7BIBwQ+BOl05S
         bdEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVGd2qRsuPK9htPjIMACIrxoXfqa+ZCAxx/O4EDGRJjmRr00WfF6e3jcRZgFJ/ejvmqDSmSU3KmeI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2C59DCoztpsB06j5Hv+0nnM/zXz2HGPC+nj4CxpijL+6I80wm
	tzXfmNV7WnKzzHTLoJ3cfO4Ib3CZlfqY+UEqxWaffpfwKgO3DQQd+6E=
X-Gm-Gg: AYBFou1M7DjL8PfWjXH0mvBOWuAYNZwKmOd8xhYOGRYRsZVIreBTodHO9pu8kIP8r4d
	l2kkNM7wIJ9fBqzlJZNDSPG6jSQ72Q49NwDHVuFtgVF6bTmpF+vakd2R1wTCu9y+T6fvReBP9FN
	MbonCKQgbmI9/2TWtjV6AZkHrxwgHIeiHGPuYihZDBuCykMdAomacXdOMzwy5yVNyYoulVHp/hN
	vrvTZBWl51D/u5eP1aBWeunPAqYEfuKj4ASV9h/+drCaToMSH5KX2CmuqwhagdPk27jFmyRK4Kz
	fkiM/+QEIXHfv67ieXpptoH7KMiiGVbd7DmRjsHsIlS6AYH7+aoS367puStjVktfR7auXmLUniH
	DUQFUq4m88NbWKB7whsMlRiOTLq7rdY6Yvmi9z1xkMVbbLFhpkkaPO4xhf6F0MXPfgNSshnb/FP
	qY7e8tHTRIE9fQ/4wW98vooYNI3M53Ez7daClr4+obtFopt8rrvO4b/VpY7eRzMmUZnBSZDFgjf
	gUvvNsebMTPkWjDdhL4FCwVFn+GqT3m6RDgpGrJjGCcI6+XSv/CBPHbb0R1WixjaNl4S9PmV+je
	9Ie9/tNG4m52ncsGeRPS90+RHDhkcdttuGoPwUcqTsHAy0lBXFWj8Z9nmjnQRdDOypYAChkvppA
	ZpkSYI2b6UN4=
X-Received: by 2002:a05:7022:7e0a:b0:15b:afce:62c2 with SMTP id a92af1059eb24-19936e39a84mr5336469c88.41.1792901061085;
        Sat, 24 Oct 2026 21:04:21 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:04:20 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>,
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
Subject: [PATCH 13/13] drm/amd/display: Skip panel power savings on eDP links without a panel
Date: Sat, 24 Oct 2026 23:59:49 -0400
Message-ID: <20261025040046.1602-14-atharvatiwarilinuxdev@gmail.com>
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

When GMUX routes the internal panel to the integrated GPU, the eDP link
of the AMD GPU has no sink. It still exposed panel_power_savings, and
tuned writes it on every switch between AC and battery. Each write sends
a hotplug event and the following connector probe runtime resumes the
GPU that GMUX had powered off. Only create the attribute when the link
has a panel.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 3 +++
 1 file changed, 3 insertions(+)

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
 
-- 
2.55.0

