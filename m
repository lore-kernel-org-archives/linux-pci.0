Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266F2EDD58
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 02:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788920579; cv=none; b=UFnoXHUNk55RG4xiHn15hkQBlCuIefKsEQnrkPzb+I6ZbmZlmRVQDgLPSx6bIufbEOrcerC2j1Wo3xXfdtSWeRFhHakSOx7X1x6s2H0Wxp8OngMco8sDI25v1rwmJyDQKelIiGpyNHvo+djahL6tGPfMXJqAsnmVKn8QJh8QvkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788920579; c=relaxed/simple;
	bh=nNOwCpVAX3p0s96EA+H6jaLxJ2gbMs2ykI5rAVzNsH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1OOXpvU+T2YUIdL6s8gIpL72NVGmD/Sp+lDgT77DK34DaEnZ3uIlOnw2taXk/mF8PKPZJdPfHW9Vpubae9O/0vdh7wp/TDvntP/hl6ZD27xoA/4m8MPVEpW7tshxBfj6gUCBp8/zgpL3wn3u/enXLVCRGhZBm219c05ZE8J2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwvspjjQ; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwvspjjQ"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a30eac5so421130b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 19:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788920576; x=1789525376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8HvuJIgvYZHLCMZ3KdaCZTooT85AcaXoY9f8Nx7M4w=;
        b=XwvspjjQ9F0z92cmj54/x3wurMTkFitwcqFQwuFBn77qaZbcLW1A4OLduCAGHyVHLD
         /Ymn+sXyy8wMQO3rMozBAnJDSnu+8AeRzstJHclyyi7Z61Sdo7tazL91WzDaHtOOLf/i
         Y5XAoqMkeqjJ5GEuhKaHbvSEhp/qwcV4Kg0x259o4SOJMvTH/Eig22ODdbvrxKbsoxBw
         rOdl2f/ETXaQ9fKgu8EsuqZhiskcJO57W7CnOxvui63oARs3jKCbRFrENDHY8mGRhYtF
         4BBK6En3AcEbCvQuoCfLfvX4xbrYXQCmyYnzXj7O8s76MIgWJMIoLDdVpzDQMn1vl/m1
         5WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788920576; x=1789525376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b8HvuJIgvYZHLCMZ3KdaCZTooT85AcaXoY9f8Nx7M4w=;
        b=im6n4WHEih63UO+AJr/BNgecjcCgfJvkHPWCtfvPvT46UeM8Dmzf4+00oBMSRGn9HR
         AlVf8BeDzFIs9GcJ8oT4D1wnwcSndo54XHjJHummAr5ktFiHHGcjMyPNP3uUKXJN70hX
         8F+w7IAS+7wKrFxPMBFhScISj6le+AJbBQUEXW5e3qkXvVrdxNjywR1LWFkkU57Mi7ml
         4kFVe3f76WenOYCiFwAiyWJaK9LD4G03jYz7MFHIpgdnmaFSF3zcHcip70wvetBaIirz
         3XnM1CUHNb3fPvaMQm/riuaed0yv0hV3o2m0HukHCo5jO1gcN9gWiOSO0ymivZ9U3iAa
         2Mgw==
X-Forwarded-Encrypted: i=1; AKwUvBxkAnmI0prhFoKlG5y7ook6G4/cquE4gq6NdCboVCuzVCvHl1C+7XtaQ+RyEXWUi1fjJnUtalV1TQM=@vger.kernel.org
X-Gm-Message-State: AFuF++kzyd5FCbNUrMDiCEYGlMklEF1REKswPus2Sy802zijNv4lRfQc
	DwefQIen2YE1t9nQxOSWdkWoIWSO+UMXlvQW+x3h9RTSUk+pm/dEK+lk
X-Gm-Gg: AYBFou3Yb4t8Jhb+n5N7kNV1BTQXzxE9F+uJkcapwlm6vkAiZddzbJmcE95W0uFj4S3
	1b9NcLpkaB6htGKoRYpWY+V6dlrrjbKZ7+AVAKqsXGuTYBeJcSrA2DwGawpsE8FYKVQhxTjvFOe
	SFaZQSFpuUn1Awi+OhmnOmh4cq0xI588tXYccHDcNRxCF6GTbZcNLtlcwy/qg59PlTm+yAhtEDA
	0PfflmFXCsMOwVspl5dPWlf1K4GYopnykVczBF/CBPfovvl8ZUAgJknn2f6MFVlqzUHQUPCImEm
	chV8J3igzBB7zLpZBbCXJe6g5niU3ZC+iUFAjP18lM/r2HwvJRc2T4mbawMSqaXcs4TjP3l8HS0
	mX0zJ10dHInWVM2rG8d22zAEfWcxQ15kwkq7FOYNqtdYgRT019o3b+FKKkdXEeCEWpXB9AVbRkT
	7jUax/38ogjsOAR4dIYheOP0u8nzKUwuzmuA59NSBVp0IXCNZ9UfTL08umD5ekwIQ2h7vl2ajG7
	4LOvpYCqwOZqCB2cCjGiSZ7RQ==
X-Received: by 2002:a05:6808:4f0c:b0:4b2:8d9e:de11 with SMTP id 5614622812f47-4c025dce668mr4332525b6e.19.1788920576516;
        Tue, 08 Sep 2026 19:22:56 -0700 (PDT)
Received: from david-hassan-Inspiron-15-3567 ([69.162.230.54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971aa12cesm15580584b6e.16.2026.09.08.19.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:22:53 -0700 (PDT)
From: Fahmy Hassan <fahmymohammed@gmail.com>
To: helgaas@kernel.org,
	bhelgaas@google.com,
	scott@spiteful.org
Cc: fahmymohammed@gmail.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 0/5] PCI: hotplug: Check pci_hp_add_bridge() return value
Date: Tue,  8 Sep 2026 20:22:21 -0600
Message-ID: <20260909022227.620217-1-fahmymohammed@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909014143.GA123333@bhelgaas>
References: <20260909014143.GA123333@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of a fix originally sent as a single-driver patch against
cpqphp. Bjorn pointed out that pci_hp_add_bridge() is called unchecked
by four other hotplug drivers too, and asked that this be reviewed as
one series rather than driver by driver, so v2 expands the fix to
cover all five callers: cpqphp, cpcihp, ibmphp, pciehp, and shpchp.
Each patch checks the return value and logs via that driver's own
existing error macro, and removes the corresponding now-resolved TODO
entry where one existed.

v1 -> v2:
 - Expanded from a single cpqphp patch to all five drivers that call
   pci_hp_add_bridge(), per Bjorn's review.
 - Fixed the TODO removal that was missing from the v1 patch email
   (a stale archived patch file on my end, not a dropped hunk).
 - Reworded the commit messages: pci_hp_add_bridge() already logs one
   of its two failure paths (no bus number available) via pci_err();
   only the other path (subordinate bus not created after scanning)
   was actually unreported. v1's message overstated this as
   "completely unreported".

Fahmy Hassan (5):
  PCI: cpqphp: Check pci_hp_add_bridge() return value
  PCI: cpcihp: Check pci_hp_add_bridge() return value
  PCI: ibmphp: Check pci_hp_add_bridge() return value
  PCI: pciehp: Check pci_hp_add_bridge() return value
  PCI: shpchp: Check pci_hp_add_bridge() return value

 drivers/pci/hotplug/TODO               | 8 --------
 drivers/pci/hotplug/cpci_hotplug_pci.c | 5 +++--
 drivers/pci/hotplug/cpqphp_pci.c       | 4 +++-
 drivers/pci/hotplug/ibmphp_core.c      | 3 ++-
 drivers/pci/hotplug/pciehp_pci.c       | 3 ++-
 drivers/pci/hotplug/shpchp_pci.c       | 5 +++--
 6 files changed, 13 insertions(+), 15 deletions(-)

-- 
2.53.0

