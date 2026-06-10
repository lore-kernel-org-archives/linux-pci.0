Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D823D4183AA
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099844; cv=none; b=jL4dvlFJDRUB1s4bLMjDULzWy4FcUYl3ls+Aiw7wY5t5s+zatSd2MULjPOIzdZt8fu+ttHUuWiUH9af4KaqQHXEcXw6HXLw4mcHS/OWjjonfdL9+WkP3s0CnZ4JkkTrTnG5ksYPd9VzVHHms33YkgUP7RlDJIVpHmqwk2gWOI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099844; c=relaxed/simple;
	bh=WaosMbjfwHRBHBEEDV3W8lJK6/4vapnN1+pjcrONctQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPl6c2gba41z2oiKYncOvofMBaQmkxMKXwO71/FJtr+3QY8ASMB53/t0zh6S+hP0blZCAuyay65EgrTKS5T6KjjjR3fw8hZ7zTHBKVrBYm/fz5QEP/lqsssCQ4L3ySN9QmuDDwB1jC20AdpoWqhhsA3HRKQbbEI/m3jUzQktPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWtGojL2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWtGojL2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f1e2f8eso5196859b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099842; x=1781704642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPY6kv+qAU78zF0fcea5dJTa14wAhSte/v9aqMKiagg=;
        b=FWtGojL2JCAw+4cBk+hKdeRuBA+ttoB5oavQC4S4lz6hHRj33O8OVKUplOiS6FFCDc
         0JL/yzD9hRqaQQSCRv6iZAM0v89qFdiI7cmufV6lnEG+DcB7YG7bfihOlEb7OOi3t9Og
         PqS+P9aZ4Wj1zIYDBvihSyrydB8r59699P1GKhQBiO++ubPs6u548r2fdTlGGSX0LPHV
         /ZSO21QpO1TypDjYRRx8ebjIfQ3GXPkGxFcmCW+gCPfzzReIoiz2oadoFzbqDjEkPS6a
         8ZHmC0YTUJusrbv+0rT3cDoMl2t+RzdDFEAHVsvzfK2kU0+AQ+3gOPW62l7VOQb9z7qF
         PJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099842; x=1781704642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPY6kv+qAU78zF0fcea5dJTa14wAhSte/v9aqMKiagg=;
        b=pJkQgO2mi1QpdTLxD9p2P7JfTk9TAemELUh7TL3HEyObz2HcHgvKPom2pmpc7LsUmd
         D35tK3wyO0N9twYian9mbaGfCQrloOgqb317OXJ2MggiHslx0nR9JuZi5osoWR+8Wi0W
         6hTFSLs+IGQn6G3AgGBUHNPVSlV484pqdzsTtzkkSEC9+O/hV9skeZf5DT+HWt7VyFq2
         Zy4YxRP42cChuktagNpE9pEjW8J+LYKbAEb6kfwe21rCnJMUJI+3Rp+MgUfTS8MqEarY
         QA4kAZTFb/OCJrHpdVQxWsoT9eMn3iXSluqkzCm+9zciuXIZLC6AIvefpOeWuib+PITN
         7dqw==
X-Gm-Message-State: AOJu0YyuUjxUXSTdjqOrpn4pYMYb8jl4epbbFBZ8ACsxZXOEhbmjUeTc
	kTjkXJB4ZrISVPzMmdGK5cL8A/n57MqHPVgK41EQaEZHH1uVmWLA6bc6YfRB1kvxPPM=
X-Gm-Gg: Acq92OHMD/qW3vApPD/VTEJRPjh2mC+6b0mw4F3AkZllatdVGbMQJWD4FuWLQ8zC7a0
	qqiP0WjLPyHdAV303nKGM9L2BFc4sBhPvNTgET0Us4XftBUg55u24fm6g5IV/dPiW5N2Suygdse
	jfEEW9iby/P7ldwWjdcc34dXtlSqsG4zRXPtXIQW5C6Or+KJsYA0sAPAtFGiPGXwMUT5BdNs1hG
	MJ6zQR50oWIfFd2OYgyAw312SuMYPoVG/K726L9TC5xd+v4qX9GVb5ESggKFic2ioTbV3WRCtFZ
	G4aMJCWJBRhwWzXemlis5+d0LbhCF+N0DnM7jhoxKLA3h1sbD5/YKuTQkLwgfEQpPs8Slwu+pdw
	cKzV+99uaPJpGaOee53z+dAgcV6UVUGs6Tspwf1hnLxrIoy5d0OLL3DK32jo1rjSuRruKP8WjHP
	ZrNNU2Au9S3ELGeSKQIBmm1z+TGz0/aL1sXfw9vBXK8A7ZLfqfRGau88oOv341/a4Me5RcqlEuT
	fzn1w==
X-Received: by 2002:a05:6a00:94d8:b0:832:e65:ddcd with SMTP id d2e1a72fcca58-842b0f4278cmr25864658b3a.45.1781099842209;
        Wed, 10 Jun 2026 06:57:22 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428706fa9asm24411168b3a.45.2026.06.10.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:57:22 -0700 (PDT)
From: Yuguo Li <cs.hugolee@gmail.com>
X-Google-Original-From: Yuguo Li <hugoolli@tencent.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Yinghai Lu <yinghai@kernel.org>,
	Yuguo Li <hugoolli@tencent.com>
Subject: [PATCH 2/2] PCI: setup-res: Guard against bus->self == NULL in _pci_assign_resource()
Date: Wed, 10 Jun 2026 21:57:09 +0800
Message-ID: <20260610135709.1630627-3-hugoolli@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260610135709.1630627-1-hugoolli@tencent.com>
References: <20260610135709.1630627-1-hugoolli@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_pci_assign_resource() walks up the parent buses looking for a
transparent bridge to retry resource allocation against.  The
termination check dereferences bus->self->transparent without first
testing bus->self.

For SR-IOV virtual buses created by virtfn_add_bus() via
pci_add_new_bus(parent, NULL, busnr) -- which happens when a VF lands
on a bus number different from its PF -- bus->self is NULL.  When
__pci_assign_resource() is invoked on such a VF (e.g. via
pci_assign_resource() from userspace-triggered LTP coverage) and the
allocation fails on the first iteration, the !bus->parent test passes
because the virtual bus does have a parent, and the next term then
NULL-derefs bus->self.

Add an explicit !bus->self check, mirroring the established pattern
elsewhere in drivers/pci/ (e.g. pci.c, probe.c, pciehp_hpc.c).

Reproduced on mainline 7.1.0-rc7+ on x86_64 with an SR-IOV PF whose
VFs span multiple bus numbers, by triggering pci_assign_resource() on
a VF that lives on a virtual bus:

    BUG: kernel NULL pointer dereference, address: 0000000000000860
    RIP: 0010:_pci_assign_resource+0x63/0x130
    Call Trace:
     pci_assign_resource+0xe9/0x370
     ... (LTP tpci test-case 12 driving pci_assign_resource via sysfs)
     do_syscall_64+0xab/0x500

This is the same SR-IOV-virtual-bus / self == NULL pattern fixed for
pci_read_bridge_bases() in commit ("PCI: Bail out of
pci_read_bridge_bases() for SR-IOV virtual buses").

Fixes: d09ee9687e02 ("PCI: improve resource allocation under transparent bridges")
Cc: stable@vger.kernel.org
Signed-off-by: Yuguo Li <hugoolli@tencent.com>
---
 drivers/pci/setup-res.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 991d3ed543f5..e8bd3d4ff923 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -353,7 +353,7 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 
 	bus = dev->bus;
 	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
-		if (!bus->parent || !bus->self->transparent)
+		if (!bus->parent || !bus->self || !bus->self->transparent)
 			break;
 		bus = bus->parent;
 	}
-- 
2.43.7

