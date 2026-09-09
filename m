Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA16336EDA
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788920596; cv=none; b=lmcd6ueaTx2+I0nQ+TPjS8iVOqy5aCvZacVaiKpYRlNPWrn0bo3GLDMFwUxN19uTI1qMFi9zI60L+BrKd8qJQC6UieXfUmZOebpvlkwkW1zS+s+k6wv+KcTh6d70pl0aQINwTWdbE7RnHixWJDpMJ7SV3hwUbKmo+WaPICI0i3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788920596; c=relaxed/simple;
	bh=OlnxTMf1OS7EffZSZon0z25ejT2la63Mm23HWuKKSfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJ9fNVQcB8TcQA8yndqCX4Im96567shcKn88YHQcfa9p0lVQDvpo5erpWNE8g9g3xQ56vbi8tnOFmgFvy31p/pakBENePj/zJ8rEqlFG7QGdcmXSs4JvYjsUGwRnR8CiCCb+esRJyv/0I0q/LE4tcN3X1zRtzgv7IosC5fdorDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrgeDPVI; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrgeDPVI"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4b28d9537bcso3656015b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788920593; x=1789525393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JAgTxvl/DOmwjv6Cc0tmXlZdkUKiZ0mQGF7jFKNHR0w=;
        b=VrgeDPVIYMLoY/NWVzLr6GrRpjoeKCxlQ8MuzMLYnZG3YIFFOzWz1lsEIpjGECC+bJ
         tk5asnKpp3AuBDc8uFOTLMFwz6i20AXz06ao9a3pHLkWGNo3fD6C5NTr8CjKsr7MAGBY
         eoIWNrkilXaIFGK22msIqeevNcKOI7+lT0g8OxHZ2+2tQdANLThWAmzJoouoTZQxTwHX
         e6/Yn4CSvtCntUu/z3Uon5XJ0wLsoaMbe8WFVeTv5FndSUV7T/sfswG8v2CGMYKuqGpe
         bXD6gk9gvYxRIqi/taqCoKXN8yq0OGRwKKlpTp/6K2sT9FxVXcIWbs+uOacuVXyvgMqO
         GO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788920593; x=1789525393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JAgTxvl/DOmwjv6Cc0tmXlZdkUKiZ0mQGF7jFKNHR0w=;
        b=LbH12oDKyz5LmmGfB47nCc3Li8csqzBXqUXkCYJMR9pfqU8n6CXI8X4G76ywOHapQY
         lTCOpAMb8Go5R/XIZ2/ptEv+VYzt6sPunkktxYKWByUXxBMdff0cep/ZFc/oIdGU+qxW
         5awsfNfI8yHRSxY2au0bwE7C5zO+1F0fcSIFxylRmbEJvxu4X+20K8+iLuOntnJbGSrz
         F1rYkS/UR3IZVkX4stMcR5T+zxsCiLx8+7vA2FlbywITIVDfJeO8Rnva987vHuP3TIx0
         UKAH3O8D6oLJTwdh93HiCnbeqzPm/BKYFmY/Pl7Shp4W8I2cQT9NwdUyA+lFVoJ67HTZ
         sfUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwA0Y0eBII9Y2nPcIgClGmCh1psyGDhIkCEsN/ONbg/1eYgpLGweTZ1AI8OlrHNbCDZUonbPTGXJUY=@vger.kernel.org
X-Gm-Message-State: AFuF++mn+JCO38gCnPoufet28miI4g4dlUhwFhsrSnBg3Mlqf0fDV5yv
	7UbZ4p8GZMogMVCUfEZ9bNFzt62KsQaO5QJ24NvCwUFKtf9MX1x+9BlW
X-Gm-Gg: AYBFou3J2/fwUwQMfZriptM7sOv7pWai1XxfGXXEq0oplioe2rvim+Mu4KBi2JHS57f
	VEyCX/vly9XQ6il6z1ANwZexh/VxGqCiaLXpqEaqQuAJfE4unclI/Us1g/hGHccoL93rDRWNX9T
	QToAY7RRjjI3Mw97QjPxg7slquzd5U1RMMZVYUX03Lfs1pdVtVLc0B4rY5zUYBA33EBCUfaBaJQ
	BhBmk0djdwGdS5vYBHPNxwxpUxjxFiWs2Q3qXwHp8FOaTiG8/VyCHLXv4Qg0Rj5z04TDS+TKB7B
	ZfUCG76Ud9RsT+yR15hELxZ7qmm3aQiCT++E9QgEYRQUzFyk0A9gO9Jea8zcVM50lfeC6lfMDYR
	xu9hcjKQol0y1XL//To/5FlTNN4VtMQ0i7dXH4PgT4f9ccRX880lxBmrrzHYTYLSgd70cvES9py
	305T98neDuRnK1/2uampIV1XljpQvrgG1lHoRHKNMHcsbDbhhSp3gMDAZXxw8MpyktquMloz95g
	NX7uKjB2hJD+MxNnyb2oWp2vQ==
X-Received: by 2002:a05:6808:c1fc:b0:4b8:4703:db93 with SMTP id 5614622812f47-4b84703dc46mr13211353b6e.28.1788920593574;
        Tue, 08 Sep 2026 19:23:13 -0700 (PDT)
Received: from david-hassan-Inspiron-15-3567 ([69.162.230.54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971aa12cesm15580584b6e.16.2026.09.08.19.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:23:11 -0700 (PDT)
From: Fahmy Hassan <fahmymohammed@gmail.com>
To: helgaas@kernel.org,
	bhelgaas@google.com,
	scott@spiteful.org
Cc: fahmymohammed@gmail.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 5/5] PCI: shpchp: Check pci_hp_add_bridge() return value
Date: Tue,  8 Sep 2026 20:22:26 -0600
Message-ID: <20260909022227.620217-6-fahmymohammed@gmail.com>
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

shpchp_configure_device() calls pci_hp_add_bridge() for each bridge on
the newly added slot without checking its return value.
pci_hp_add_bridge() already logs an error for one failure path (no
bus number available for the hot-added bridge), but returns silently
if the bridge's subordinate bus isn't created after scanning -- that
path goes completely unreported, and either way the caller currently
has no way to notice or react to the failure.

Log an error via the driver's existing ctrl_err() macro when
pci_hp_add_bridge() fails, identifying the device involved.

Signed-off-by: Fahmy Hassan <fahmymohammed@gmail.com>
---
 drivers/pci/hotplug/shpchp_pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index 36db0c3c4ea6..b9b18879b8ab 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -48,8 +48,9 @@ int shpchp_configure_device(struct slot *p_slot)
 	}
 
 	for_each_pci_bridge(dev, parent) {
-		if (PCI_SLOT(dev->devfn) == p_slot->device)
-			pci_hp_add_bridge(dev);
+		if (PCI_SLOT(dev->devfn) == p_slot->device &&
+		    pci_hp_add_bridge(dev))
+			ctrl_err(ctrl, "pci_hp_add_bridge(%s) failed\n", pci_name(dev));
 	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
-- 
2.53.0

