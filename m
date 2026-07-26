Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1437F8C0
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785058342; cv=none; b=can+RzSO3ffgnVmZ+NcmHhApnbd/FO+GIO78Y1Y6Wq6XoEfi0JULASv/fLfn+PebTVe4BolEruipIKV3whIXNloYrciEAo81HEa6Aid5DeB25XajYRhVKHtrG1AAfrluF4cOx3iHiNrowOLbHWuJ4ptAn8g+I7/C1CVz1BxeK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785058342; c=relaxed/simple;
	bh=LUrxNRKSHtQWhflLuNK0zNgmVt6PH8l82UeFkiACQIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdGaLesLemfeEobZuC7LXcp+qVPjzZlbdim3La34QQ8RjDWG3gCPnbuM/We9eTDgyqxj2crQz/1zhNS0TUH+HkJh7prIqPBXwTxUU1zmi8DIPPGAuLWqwQLX84pZ0DSfxgLDEW6ynEhSkxzyU6zLtjmzJGlmJdMQvgz12rEC9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxaf6Vkb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxaf6Vkb"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e682b30ecso267906b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785058340; x=1785663140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVZjXnnk2jihD1ItfNbHIR/890XeYrWeJjusBszoF44=;
        b=Yxaf6Vkbzuy8DAu+5Yz3kC1GgxU41CEqAF1+CY7qcalBavg3Gu59Z6KBF0mLYh/bya
         qHNjK/BjPMRCN/H4lFeDtGquj9DXT6PewP7YaopgNecGwNLbM2MJ9y53+WXT5ZMkcCt3
         xEoFuN3UzSCw1JIzMMkdgENfn8Ss/tiXXhVpwSoCE0D7sEUq8rrHVF0vNqlx8O2lziMf
         26v5qB7+TOFZuHQhDzaNniQiE8HdooUrbJ/H6neRMDkA96JhOvDxyusLkEx5djgmVbbF
         zNzOIbREfR6zUKg3Vs0NPKInx9kgBkzw8CvFBeoAzTMlLWOZa28vpTqjnivjaJuifzZl
         e8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785058340; x=1785663140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WVZjXnnk2jihD1ItfNbHIR/890XeYrWeJjusBszoF44=;
        b=lusc1RixiuUQbVyIbf07x81pq0zsG0C4y4ZGpRsDFjqL1vfrSsjphHeomjx5599/hc
         uqrI/wBRCZWwTnCaKF+pcD1gRCdshZP7sZ/gjQcH4kupyVESAwVY7+l1xxF3AdkQAhRa
         hY7xaH00kPf9u6mIfuyHRsIZnjsEqokICdFLdF3V0JuU7MAKPV+hj/MNbRw4rNnNODrh
         kCu+59Rn1YJOiyLs99sRfnVM2H6mUd3ZtdqbO8kmuE4YNYYQch0jZiFOBUGD/tCysJzn
         zBTFB+KJDVhyZExDYkmV6lW5eDeVPHC95BsWoD6qnnBZXPieEzIrSwgtW8EbJO/5MGM7
         a8lw==
X-Gm-Message-State: AOJu0Yzr5K4YfY24vRhX6xIBmyebyx5wFL8c0fuy88/eDHeceeTImx9a
	dM+uFWeg0osSvxIX1v9+GifThntcnKnEbMltjIo7tgIFtoeDIOI+o6VP
X-Gm-Gg: AR+sD10DcmwGRN70RtB1owabVAZkDjvyqqmmHOotya5S23TzERUFe8RD39yjw5Terlj
	n+XGXrBNI1+Tt2QFQ6tsPW6JiRhiUp3l/ZFQ8ljGo5NrLg4DWlkjnGjRbKFSxd4K2dAfP6iJnf5
	sZ/e37af+n0qLZGJYlpALf5rFa3b+Bpu+XZ9cuX38cZLWDa2LqLHjtCcEP6CLsehL08JIh/urAb
	c8AL3IJrW0mLk1z0VEXU/XhCXAjjKdo1HCjwnnjHsvQQ9QSLxRvFZz7XIdgUXL9r6acxgvXYdbP
	RoVvhXoLiHNTaXC7giJ82/d9R1aSEeS3DGY/vjr+p16fISynblMWdKW2h/Rfh9hKovgxvn2CTqx
	gAO6Ww/lpydWV80Zr5QTo7sq4seJJcCN1UCBInvTmA3OEOacW2YE1CkkF9pP1andQbntR9LcO3A
	/rlA==
X-Received: by 2002:a05:6a00:bb05:b0:84b:e69f:1b3f with SMTP id d2e1a72fcca58-84e59411a41mr3345821b3a.8.1785058340278;
        Sun, 26 Jul 2026 02:32:20 -0700 (PDT)
Received: from ubuntu.. ([2001:2d8:72ac:5ae4:b4c0:11d6:e62a:f791])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533d1448sm1731781b3a.30.2026.07.26.02.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:32:19 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	tarunsahu@google.com,
	djeffery@redhat.com,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v2 2/2] PCI: Free the device name on the pci_setup_device() error path
Date: Sun, 26 Jul 2026 18:32:00 +0900
Message-ID: <20260726093200.146111-3-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726093200.146111-1-rihyeon8648@gmail.com>
References: <20260726093200.146111-1-rihyeon8648@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_setup_device() sets the device name with dev_set_name(), which
allocates it.  When the header type turns out to be unknown the function
returns -EIO, and pci_scan_device() then releases the device with kfree()
rather than put_device(), because the device has not been initialized with
device_initialize() yet.  The name is never freed, so it is leaked.

Free it there and clear the pointer, so the freed name is not left behind
in the kobject.

Yang Yingliang reported the same leak in 2022.

Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Suggested-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/linux-pci/20220817084444.2876059-1-yangyingliang@huawei.com/
Assisted-by: Claude:claude-opus-5 sparse
Signed-off-by: Rihyeon Kim <rihyeon8648@gmail.com>
---
v2: new patch, picked up from Yang Yingliang's 2022 posting as suggested in
    review, with the NULL assignment added.

 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3e6f0eb7d456..74d84093943b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2192,6 +2192,8 @@ int pci_setup_device(struct pci_dev *dev)
 	default:				    /* unknown header */
 		pci_err(dev, "unknown header type %02x, ignoring device\n",
 			dev->hdr_type);
+		kfree_const(dev->dev.kobj.name);
+		dev->dev.kobj.name = NULL;
 		pci_release_of_node(dev);
 		return -EIO;
 
-- 
2.43.0

