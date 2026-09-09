Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191FA322C88
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788920582; cv=none; b=kHQg6BZcvvBvT+bhYimOxGbwllhb9Fx+6Cii5qT8aHtQCXCQZN9AdUakEo986aQVlxVdHrSZXiQJH2sSb3W0yTN6pQVVP2APB6iPJj6+SMkX0erLGbXe4a6Y4FJ3Okb5n+8uO4Y51NsDw7k5P5I0Vxg/C46X26m7s4waHfxMPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788920582; c=relaxed/simple;
	bh=kahNmhGL8r0OStd+UDk1yegSCb1Wry94V4qhk0XcnPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fid35R8lNRDSbVi/AI9mSmR1oB59SrbDBN91HvRDkocaYCLVS7uM71HvpdsQ0iogTuEp09ga5OStNc+HusTtwqbYOhs2mP2KAMhnbWCY081VeduLiLxjDptWgltrIbnck8Sv9dRhHe+lAYT2lJ4sfJALmSVVIDIifCKO5G6e/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCAVcNKZ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCAVcNKZ"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so3778421b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 19:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788920580; x=1789525380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZMyQef+oIqclLbtgPWrdXN2+jow9YDnTQ19wlR5TNs=;
        b=mCAVcNKZc+1JZK03AAOp/VBYhRQz5oNSv+yRNRsJaiIS8pgfXyv9YidJsykTBKvOZo
         wE++7BTif5mnAUIDmu7E0wzbRmRgkue57KBXN2dhNNgrWIZHmxn9mfdHoqvYykCEc4JY
         MQ/gEcC0SO5s0apmeXNO+Y0sjGdcwM00xWkywPOdNpNnlEal606DZSp3rN9JGNGstzRG
         HLZoMEmfyvIc/LuDuSKO0WBtQUKR0x1NxdrVRYnFNiRdFWF5Uiv/UK9oysohp6T+HKxl
         JySH6s8IBnGbuKe6tYDz/ZMkigyaSD1GaUHqmn5BygLemjf/1gpx+1P9maJmM5dG+4Ps
         FQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788920580; x=1789525380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VZMyQef+oIqclLbtgPWrdXN2+jow9YDnTQ19wlR5TNs=;
        b=bSB8D8MftIeZM26vW655EFK7UoyRfHbsg8SZqSROx6zoruDt70sza4v2qkqt6pm3gE
         KmCnQ0E+UaKV+qP2JykIoRqCQDWr9FaW3dgOgwSCCmw/Hf+JWHvi0mmBFaS6QVo9nvjW
         nR2s073Un3XZgTLaYmQUuJqqJWcSm5lBblx1GuibP2ov9bb14voIhTAv3mlHcPBvj9oe
         DjzFpq0qMnS4eBRX4LAlad2VHlQuYaoBOUof3/J9+L7iUgsHj4B29M/pIVxXpjlvyLwE
         VOLuCPnxq4PkZv8S18ywVCgwF2QHf9Q6GpUZo9RodXZ2qwOZijoPfLL6u9wxzU46iaC6
         X2CQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKOy5BysAIPmuKiE+ELpXbjoG2+OXJe2m4Y97BI3VFWFkaGOOhUIO5x3obljui13Pz1BoFOS2F+EA=@vger.kernel.org
X-Gm-Message-State: AFuF++kraz7VPH7e4YyjQgm3FpjNPUYCYUd5o3/IrZCBE8qx8dmHKmpv
	aD9/ODisoqQzUBQDSsViAgpBrFTtfXJjT0+3cp1i4fo2wp8vL1/oh9kG
X-Gm-Gg: AYBFou027iLR4s6mQ6EZd8AYcMhPd+KE0fbrMX8oMK8KC6GaVQqURGctWSxjCwsdPl8
	iMLoYUmxLk4teP7DeyTpzfCTv96z9dAHk5e5CdYYI3OVAGHu0gCDHerTQXf0J47vlhu6jFJh6Ee
	FfLzk79efkV1VILgVg3HciZv55lxAt7WpwzE2y8BM2dt+DUa/0yr2VhfXgTjJib2JubhX+gHhza
	Vi/bPxfHkXQ5NI27CiGUu/FI+UaXwK+wWemFfBhaNlYnD7URSdhaeNN+iGCm+r8Wr1g05QwC6oQ
	mnGsLHOOBQKVx5FYk5Vcw5+/d/D3vZb2UNkPj4YH7hIpZR3fAj/l/lxZlZhVJgZWUBI1Ox8RgHI
	n46SlIJJuss7ddJeQO0lg91wNW/GEKr9/xAx0iGi9KzXdlbE1XAkmt14rqRRjAK5sKXfL6TnEd2
	avHnIbixzKAjhFpVWWsbUvQ3jPPvbcptPXlfRjYgHdX/R2TYDNtOW4AYFcTho5ADgZJvMzDIYCI
	IqMfsZRRYGx90GTCL0ylX7HvQ==
X-Received: by 2002:a05:6808:1783:b0:4b1:b83a:5878 with SMTP id 5614622812f47-4b961a7b906mr20611009b6e.14.1788920579975;
        Tue, 08 Sep 2026 19:22:59 -0700 (PDT)
Received: from david-hassan-Inspiron-15-3567 ([69.162.230.54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971aa12cesm15580584b6e.16.2026.09.08.19.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:22:57 -0700 (PDT)
From: Fahmy Hassan <fahmymohammed@gmail.com>
To: helgaas@kernel.org,
	bhelgaas@google.com,
	scott@spiteful.org
Cc: fahmymohammed@gmail.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/5] PCI: cpqphp: Check pci_hp_add_bridge() return value
Date: Tue,  8 Sep 2026 20:22:22 -0600
Message-ID: <20260909022227.620217-2-fahmymohammed@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909022227.620217-1-fahmymohammed@gmail.com>
References: <20260909014143.GA123333@bhelgaas>
 <20260909022227.620217-1-fahmymohammed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpqhp_configure_device() calls pci_hp_add_bridge() without checking
its return value. pci_hp_add_bridge() already logs an error for one
failure path (no bus number available for the hot-added bridge), but
returns silently if the bridge's subordinate bus isn't created after
scanning -- that path goes completely unreported, and either way the
caller currently has no way to notice or react to the failure.

Log an error via the driver's existing err() macro when
pci_hp_add_bridge() fails, identifying the device involved, and
remove the now-resolved TODO entry.

Signed-off-by: Fahmy Hassan <fahmymohammed@gmail.com>
---
 drivers/pci/hotplug/TODO         | 2 --
 drivers/pci/hotplug/cpqphp_pci.c | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index 7397374af171..215ab36df11d 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -14,8 +14,6 @@ cpqphp:
 * A large portion of cpqphp_ctrl.c and cpqphp_pci.c concerns resource
   management.  Doesn't this duplicate functionality in the core?
 
-* Returned code from pci_hp_add_bridge() is not checked.
-
 ibmphp:
 
 * Implementations of hotplug_slot_ops callbacks such as get_adapter_present()
diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 81c58b1ec200..34803f36ba65 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -100,7 +100,9 @@ int cpqhp_configure_device(struct controller *ctrl, struct pci_func *func)
 	}
 
 	if (func->pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		pci_hp_add_bridge(func->pci_dev);
+		if (pci_hp_add_bridge(func->pci_dev))
+			err("bus/device/function %x/%x/%x: pci_hp_add_bridge() failed\n",
+			    func->bus, func->device, func->function);
 		child = func->pci_dev->subordinate;
 		if (child)
 			pci_bus_add_devices(child);
-- 
2.53.0

