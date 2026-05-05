Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51296413249
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978767; cv=none; b=vE6q5jL+MLIRYgXpNs8hz40I2CITkI1hrd0g2IBRTdGn7CvGei8G867aZWpFQiU+3ugE+tFRNKmI2iPXyl82vc/I+cakk1V6ZT4zWsIpDDZy0duilGKHieDcfbQvSEeH6QrCbjXXdTTcdvewCGr3UFpJBB9Ut0bZyj1ay0Aycrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978767; c=relaxed/simple;
	bh=+1OMtPQnjvsrjv2z1oNYsQPynllgk0fbt+9DPHqnSdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcuY0XCFLT/mGqijn2CNeeubezfx0OJXoxVU9dVuEkcI/gmgSwUkvmDsCCfywriP8EXCtQlrc7X9gnnmS5o5P4ihcEed92TO5WYrl99ZyYCFLAqZbFB6bXSMDpLufl99gPSETNc4d3oLpccnQ8eGATU35dOYM50yh+l7rGdJomo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LjXdg19f; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LjXdg19f"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c80227b1f6cso777186a12.1
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2026 03:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777978765; x=1778583565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm/1AnMDt5e46hwN56ltGnjEOkXvSOu1rxl9OIWCxKE=;
        b=LjXdg19fHxOUvmD7neSNQ/4DswaPpPhcSmslLnDZnjqxeVpo+ChvspGfZx9P+jIuTx
         SsucXBUwOVPVg4rStcn7XF1grySGocbnCSKZGrSwURtrP5YqQfwqe7p2lsG6yP8diTLC
         zvDB+lHmI+a/DlaYPTkUfDDT0C+LWkZe3cjTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777978765; x=1778583565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm/1AnMDt5e46hwN56ltGnjEOkXvSOu1rxl9OIWCxKE=;
        b=iGKEUeKGjwurXNT0r/kqQLUrcuO5Vc7qeQ0hFDY3udZc4HEgalxNOW/+x7VmMbfLOr
         sjUFJyhSuEqPurT9Zma0OSKmL+mWd9FEZSx28OTYKU28wmtgBqdYSWEgE+VVpC3ff6o0
         9ocl6LNzptKBoGI0HRxAsayxixaYX9vR0LXBEHglZTTPrXn0ozRb8Ipfa4K9dk6OGICX
         7mY/rmS0S75CzE3+0SaBXwJIniycjFjLknpWl+D8ZshKDIZ2L0Km6EvG/uEmt+rzQBJS
         AnEqf0IsbIgWCBMMKwM9FA64Mbrg2zPRIrkc6OPR/MaUQZPQXIfMuXqIWzU/2a58Kl1J
         Scag==
X-Forwarded-Encrypted: i=1; AFNElJ+LBodADvqYDeos1UcfO8R/cOu9zseiRgWsSQHI+1BKBQYu5TfoP1FI39ffifBuuv1oZpjz6mbJYPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJZs0iecBoJBh+h+Y2sn6rpKyGiFdj0ic5RLrbeAFIyIMt2w/
	UhrJUloHUQKFmvOGK6xJATH4nH65MJBnviFmPetiACdIC3Wv/PlumCDusf48TApmwQ==
X-Gm-Gg: AeBDieswqAdYGnkeY98fm0KtMLjs8bq2QpCHcawSiOPdz+iOmO5NjLyGQmy+6Qfz/rS
	p5eQOzP1agPz5FNzegn/59vPcF1eh6BPUgvXmVyn9ga3Tk1lk3x+2KKvWQaJ6mMwxnt/ixUTVd8
	r1gh9CnlumpzOEQchi2bpFcTcNeaSctLgaue/LUKFCi27uoTBUY/nsacy9aqsQ8RRJ1B7WH/jZa
	2SQc6tcLWc5flMV98mQCo9cp+KA32US+hCcn6l9KLQOSC8tGJiDMz/eBsZJvIXTu5XizERjits3
	C/1Vqzwg00rrxZotEqr8ikfPBrMek7XTdYGzzamae7vamA+0AfogWcb+n8PMK+WtuOAkVHSeJo2
	KvbWckkUR4Woft24lOdtTjLsvZt1GGQPadYd8CGGLFNa/Ov3P+fna2QJ/o2KX+VQBbEFIqsqgzF
	M0PNP8BQSz3uxsrhBNnXRPVO7NB1zO4pAzFuvYXLl8ze+iMT/f+B4YvMKyLCmZ7HdEf5wS8Ld1C
	kp1MFPGPBk/Z/WV2XA=
X-Received: by 2002:a05:6a20:e210:b0:398:7ffe:472f with SMTP id adf61e73a8af0-3a7f1a1e096mr14432341637.2.1777978765661;
        Tue, 05 May 2026 03:59:25 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f1d4:2ef0:7d08:9dd8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbba71b0sm13005611a12.2.2026.05.05.03.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:59:24 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mediatek-gen3: Do full device power down on removal
Date: Tue,  5 May 2026 18:59:16 +0800
Message-ID: <20260505105918.1823170-1-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When power control for downstream devices was introduced in the
mediatek-gen3 PCIe controller driver, only the power to the downstream
devices was cut when the controller driver is removed. This matched
existing behavior, but in hindsight a proper power down sequence should
have been followed.

Call mtk_pcie_devices_power_down() on driver removal so that in addition
to removing power from the downstream devices, PERST# is asserted.

Fixes: 1a152e21940a ("PCI: mediatek-gen3: Integrate new pwrctrl API")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index b0accd828589..e6acca7e79a0 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1260,7 +1260,7 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(host->bus);
 	pci_unlock_rescan_remove();
 
-	pci_pwrctrl_power_off_devices(pcie->dev);
+	mtk_pcie_devices_power_down(pcie);
 	mtk_pcie_power_down(pcie);
 	pci_pwrctrl_destroy_devices(pcie->dev);
 	mtk_pcie_irq_teardown(pcie);
-- 
2.54.0.545.g6539524ca2-goog

