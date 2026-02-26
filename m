Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42113A0B16
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097770; cv=none; b=uwSROxtLdx+anWMGysu2nilSx45YtYEEUxq92VPemW5B3ItkV8+JEqyE0kYgCS2QRqDpq0LSdTZPCiRaBoGyG5zvDuy+VAuNQ1c5Lkqpnds68rQtVNDHYSLcpztvBdcQvK7ouv0jdKVSjTomfOb+5xuoCIJBD9FiT/+eFbJukTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097770; c=relaxed/simple;
	bh=uwSQmlLedA0XM/MofT/WPTTrwO/hP/xkkFLlNhjroMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/LYfmfoyBr8E51hk1ufivJLpyV9+wvx1U845ADfNNgTnWwCGcx5XBKP4aVMjDJo3/D1/7U6fWp+YFpAiYTDWItAKP26RsyL5uZgOlwbjmDCw855fDv6Chye32BlJU09WQYICn5tJ0Jm5ONwvCEe/mTWQ2Je2zzKtL1qPJmiZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BslHiaBp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BslHiaBp"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824adc96ad2so713678b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 01:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772097767; x=1772702567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XPrx9KTPgR+h13PjCahv5Y+K3yQbrf8iaR2zrkCxJ1A=;
        b=BslHiaBp5aqv41Fhtnpb6OwULPA1lSUZHTvhTzKxxXowPPaTWnSgAZ5RQor2gutlj/
         t5HQdoR8T0Vka4ZzJabXeO/T0lNVSpFdaTTkyUc5ZK205SSOY6ROOGFNHuaeAbKxcXET
         givDLLeyOdCRCDaqniza8Y/7OISAMnggi173M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097767; x=1772702567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPrx9KTPgR+h13PjCahv5Y+K3yQbrf8iaR2zrkCxJ1A=;
        b=lfxv2Zk6neHT0x6jlia9ZavTULmmySeXcMSpzpycgPukGNx86FLX9y8tFeeqXO/B0f
         9M2m2dtpNtzHxBPTumUxgFgf8QoJT6m5DW0dwC4fwPxli76m44TidnrpHoGhWPGhYwJO
         2ucwmRrAUpgUMxzhxtns8Xt36ZtkhEUp6yhB6PQnL8gsHWwceAQHgkbeUN8r4h0cDMYX
         GUH5EjduBfrGy7py9mq9ODxwMFCXHrE60mj/7T0CZ51YUxrIkBA9filyVNe+4LlpydpY
         fg/tSX8n6p5a7PJa+NYaRvM4xojrOXvduoQbExcS4mGxp18/fPTfLQnI1gXzVUAFXFop
         UNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuesY+HiEOEI9z36sn4S+c8vSHFcTyh4luPbvKi6Zf3n8B1HMyBv+bBT5NHq3nZMq6qTKO90KrR5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWxed183CURIaDDKnVR4b9uyrd4N+VXyN1LbUle6B6DOUw4ZH
	NjIiQGx5LuXXhWD9tUUceYksZZsUVYqiK2aCUupifiI+VFNEXZW4vK7bejrtkQu23A==
X-Gm-Gg: ATEYQzz5iwUYInTzxWOvt/oCpprODYJ2uO09KbqRFkldqpJdghumVAUJYB3lxiEF8Be
	C3gFcnnZXBQa/bbKof1iKTdLWbCBZu/Zp7wLoVBgZHKKSwxU78/Z4R1Qv3hLpUMXCv7l+Zi1EyU
	IF31zFW3znKDWLP/J8fReR1LZWRx9H1nw8qBoHv/DRZYnIgRxkF9o4tOrFrM3zJ2eC0y5ZalUN3
	ywRao8rn4gZ9xSqUdXNjPCYBuKWTZZ2dL6eFebeCWdykR0vQTI/kR7gfCduly4310EXdGj2ykdA
	vZV5lAFqb9zq7v5yl6chcwvIdisHZZeiO+K3ChNc6tQinjAA4jwNcdYSRvZgwdKKpmWuavDKOKt
	X9F+j3NZZT2B1/Qo/FmnzIFPDpQKKrXhjPZQUHQecALF0SyUCvUlhmrvX7yLB84GUiKarH9xPuA
	s4zxg4B0gQUGC/adxvrIR16Li8M8TnpQe/vOPfmJ7cY0ga1JzC/5bt6HhlCrLmd6VQ/aut7HrPY
	0+/CsAc
X-Received: by 2002:a05:6a20:c90d:b0:38b:e9eb:b12c with SMTP id adf61e73a8af0-39545ee6537mr17910465637.31.1772097767231;
        Thu, 26 Feb 2026 01:22:47 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bf01:7f64:477a:2f97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f46c2sm19024205ad.89.2026.02.26.01.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:22:46 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2] PCI/pwrctrl: Do not power off on pwrctrl device removal
Date: Thu, 26 Feb 2026 17:22:33 +0800
Message-ID: <20260226092234.3859740-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

---
Changes since v1:
- Keep the release function for the PCI slot driver to free the
  regulators

I ran into this while integrating the new pci_pwrctrl_*() API into the
MediaTek driver. I am sending this separately since this change is
unrelated and does not conflict with or depend on the other changes for
the driver itself.

I think this should be merged for fixes.

---
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 12 ------------
 drivers/pci/pwrctrl/slot.c               |  1 -
 2 files changed, 13 deletions(-)

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
index 082af81efe25..b87639253ae2 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -63,7 +63,6 @@ static void devm_slot_pwrctrl_release(void *data)
 {
 	struct slot_pwrctrl *slot = data;
 
-	slot_pwrctrl_power_off(&slot->pwrctrl);
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
 }
 
-- 
2.53.0.414.gf7e9f6c205-goog

