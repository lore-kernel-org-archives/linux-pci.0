Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF12326D73
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917189; cv=none; b=HSNr+sqw51d8Wv4N49y1QQ3RZbk5rumS/Pnd2dQsbkwcLpEJz3awfp7TkBenf+eXA0uoVZGtPbLi2tPXIo4kpK6s93cov2XG+WmlahRm07rXHYfBIjq3fAGRGukNAcVpiLJGk6iGNC8MYQEKcPCZaeYYJBLyxyajZd/g1flI9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917189; c=relaxed/simple;
	bh=M6szfNwiniju+Dr2cdLvoennisJiRUEczX+yYFr3ltk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7FI3Qnb5OSGfJiG3SA3PJLfx04ZaexV9AcFikQRAClmNgqDdYgJ9PC58JKYlsftkNo+98Jz8CYagJuZZvU7EJ2Z6YMA0UoZhneyxpTi0UpJaJOFXYEImxlpIA5db3UUeHX7WHUJ9G0q74mHW6NyGhCdK9RvsUnik6tzmHTDU3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I364lwq1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I364lwq1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a871daa98fso36581115ad.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 23:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1771917186; x=1772521986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pizzEVRW6V0EJ2ofyT4vjf5lXvzg1/kqPNoavqTg+CY=;
        b=I364lwq1OwBFMLoBOCCwZJZdFcZyWrqj/+XiToRITlkk2gPiM0PJ2ACidF6wf/CRUd
         BfVppDmm9su4rJM3JvL2vEp/s2iKGKma9AbCDQEjt8JuZ52+oSp9F3pAq7NEmrZ+FhSi
         N4rGdh4RvbgPcysopaYfITg60q3lVhbdMQEno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771917186; x=1772521986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pizzEVRW6V0EJ2ofyT4vjf5lXvzg1/kqPNoavqTg+CY=;
        b=higT4S5lLtd2V5r9MjUQv/f0z2hVc97gCou9qQhPbAirPWxvI34VXvJziLk5pbEsz2
         6hNGnQUzGVX4z4Ycj6VEydnGrtOVbmdOwrwp/SHtdABtinURc/1VEcO9XppzB8BURi+R
         VoLlfsHbNR5KR4pWlLnQlgIsvFpH0F9DscLAMXNzYOiri3bgVNlB9FzMxilPthqQ5O1J
         3x8a7u88MkuokUEfjH1U8Q+12SoJo3DpIpfzfwSOMihJfdjNPzHid7d2djrHZOjnFUXz
         HjoJN2MsdHHUjyVyJlcLRV7bhG1SV1xwVG0D/hIKTDXZna48K7W65taQXiAba74VU3Ri
         DtBg==
X-Forwarded-Encrypted: i=1; AJvYcCW+stvPWlzJW0yEqiBxIfIsA6oBVIglKptpFoYKT8qj6O6euOY+Y9oI/+5rYh/35mvLmz0HGVWpP6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgfotneZkO5YvvZcTx8sOPG2AvDvdGsExhzAdnAbm1ARi1Xpoi
	QXAZGL/DrwWVdhNjMOE4dFfEYRnVXRaVTQ7KDNsrljp/5KsX6CSIT5YCVsuQKEm3rA==
X-Gm-Gg: ATEYQzytgbbFnCMkn2QQRL7obw7OclYet4awIfipaEH/ulDj6KNfL8C7Jjc70HAQ14x
	BPPcJgvJ+0BQyZ25C11jbWVXO4k8jfKITbBEs62E1HYpE/Fn0ukKHGrCw6yb2NDrbTiHWGznaLh
	qJ7WS8wj266kKf1jQynmgVRuX4Q/vuzHsFfSplAhp/ydVixJG739z/2RNL6fd/vv1Yw1Blg7L3b
	pQEw8rg7J6O7dJmJRkIjZGOe1JItExTmYy/WViaHd7TldPDf2kppU4K1KqQ8V0825B2o7sRaJdl
	124KVmp3odqL8z3Dzs99xqtA2clOHjfsu6TxBcipxMAI5DkK2RRFp3TO3eAJt/Ghj4RoSZnji4X
	3EpBFfXv7s5G0jpKEEc4m+pol5kfNp/OKNkgR2Lwkx4rJwIXDRd3M7xL82VqnkwqcVV8Ja7SDI6
	opSrf3DySBK0vDe70gsbal6lajatBZxPyzY87FO0xeFhfCDZkQ9VAijovPO8u+kXA33x1ePb3M0
	mxq9lHY
X-Received: by 2002:a17:903:2445:b0:2aa:ecec:a447 with SMTP id d9443c01a7336-2ad74504e77mr125733335ad.36.1771917185858;
        Mon, 23 Feb 2026 23:13:05 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:752d:3fd0:786d:ab57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34452sm93026605ad.7.2026.02.23.23.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 23:13:05 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH] PCI/pwrctrl: Do not power off on pwrctrl device removal
Date: Tue, 24 Feb 2026 15:12:56 +0800
Message-ID: <20260224071258.2654521-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the move to explicit pwrctrl power on/off APIs, the caller, i.e.
the PCI driver should manage the power state. The pwrctrl drivers should
not try to clean up or power off when they are removed, as this might
end up disabling an already disabled regulator, causing a big warning.
This can be triggered if a PCI controller driver's .remove() callback
calls pci_pwrctrl_destroy_devices() after pci_pwrctrl_power_off_devices().

Drop the devm cleanup parts that turn off regulators from the pwrctrl
drivers.

Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Hi,

I ran into this while integrating the new pci_pwrctrl_*() API into the
MediaTek driver. I am sending this separately since this change is
unrelated and does not conflict with or depend on the other changes for
the driver itself.

I think this should be merged for fixes.

 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 12 ------------
 drivers/pci/pwrctrl/slot.c               | 12 ------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index 0d0377283c37..c7e4beec160a 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -68,13 +68,6 @@ static int pwrseq_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 	return pwrseq_power_off(pwrseq->pwrseq);
 }
 
-static void devm_pwrseq_pwrctrl_power_off(void *data)
-{
-	struct pwrseq_pwrctrl *pwrseq = data;
-
-	pwrseq_pwrctrl_power_off(&pwrseq->pwrctrl);
-}
-
 static int pwrseq_pwrctrl_probe(struct platform_device *pdev)
 {
 	const struct pwrseq_pwrctrl_pdata *pdata;
@@ -101,11 +94,6 @@ static int pwrseq_pwrctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(pwrseq->pwrseq),
 				     "Failed to get the power sequencer\n");
 
-	ret = devm_add_action_or_reset(dev, devm_pwrseq_pwrctrl_power_off,
-				       pwrseq);
-	if (ret)
-		return ret;
-
 	pwrseq->pwrctrl.power_on = pwrseq_pwrctrl_power_on;
 	pwrseq->pwrctrl.power_off = pwrseq_pwrctrl_power_off;
 
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 082af81efe25..0ad920d8596d 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -59,14 +59,6 @@ static int slot_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 	return 0;
 }
 
-static void devm_slot_pwrctrl_release(void *data)
-{
-	struct slot_pwrctrl *slot = data;
-
-	slot_pwrctrl_power_off(&slot->pwrctrl);
-	regulator_bulk_free(slot->num_supplies, slot->supplies);
-}
-
 static int slot_pwrctrl_probe(struct platform_device *pdev)
 {
 	struct slot_pwrctrl *slot;
@@ -105,10 +97,6 @@ static int slot_pwrctrl_probe(struct platform_device *pdev)
 	slot->pwrctrl.power_on = slot_pwrctrl_power_on;
 	slot->pwrctrl.power_off = slot_pwrctrl_power_off;
 
-	ret = devm_add_action_or_reset(dev, devm_slot_pwrctrl_release, slot);
-	if (ret)
-		return ret;
-
 	pci_pwrctrl_init(&slot->pwrctrl, dev);
 
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->pwrctrl);
-- 
2.53.0.371.g1d285c8824-goog

