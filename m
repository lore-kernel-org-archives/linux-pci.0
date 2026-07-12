Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176ED3655D7
	for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878942; cv=none; b=BoJvDVuMiX86/vEQf6BGHuWJa6l5K593Cx1i/MWLN3obHIk+X0NwfBiUU50aMB0OkRLOjhPQrfZtrOx7+s0VKJV86SCtobMNkF4/XC2ZUNJ5bIpat72621T9seHSIcUBL2BfMij255JwxjpsFrGiv/boZOEUJnnmlErhcZ2ncx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878942; c=relaxed/simple;
	bh=RgZg+NcjKlFBkqbvlYHtvyMRvFEwM8G5G0XCnD835vw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DbR/5ivcpL9ewjKlVYZkdWD+NvpzxeKUa4Gkw3RYqPVE8Rn30RUs3Oob621sWzg9pNsYwLCsBet4o6JSfRCz7PC/jYZoRulDWKDXbSVDbHFp0fD62BF6QZskptn0Y0hrwb0vL7ht0isKvOBNlkQYRXDE0WNVHpWMEiK/oxzI9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbeGXB+N; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbeGXB+N"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-493e55619a2so7291315e9.1
        for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783878939; x=1784483739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0E37CKL1qGtMYOAXyCjsl6PdtLnZ6H9NtG5TxTyJ8tM=;
        b=SbeGXB+NjdncMZubtVGJecIQjD7/1ZJQDXWAzWfTzfgZqzFjixGzQyXFJWXA7O32XE
         Xka38BCDdyp5mdYKCL9jOGj9m3NUjXm82fyWKMTbOAzePLObFUes2nXO2zi05XktYfgF
         xtuIVqu4nqT5Z/1TTAHKLB+hKcM6XMuDycEIWMyBO5eVgS/nuLs9VWWyBPTDYFkw5h2H
         yJYS5iEzvV/1AAXozwzi5hOW1xmMh19NXElythFS+NxEUc4z5gFJXJOxY5cXk7ajlb/8
         pylrnBrdDG3NO+OYy390oOPJnB0+ADUrSyTUoh30zAMXcXu22gt8ykmQarCzeb9eUVGo
         rQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783878939; x=1784483739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0E37CKL1qGtMYOAXyCjsl6PdtLnZ6H9NtG5TxTyJ8tM=;
        b=UOx9vwW2oWm4ogXLjpbVo5QPhmnuGxHVb2Blm4CUX9JLVPOclLwi664HBLHMs3aobz
         jiAmxcRrXDFDDNXQ5GqLHkPKO5l/RxNvYB/tMT0CBSKl/N4Q02o5YiPRq6G3veFDPrpD
         knkUAro2B7azOla8xm9O+ZAZrZoS5W0v4xoh2JWc1dnzYse0/Kkd0hwpiKjr8CGnNZqu
         G6mnCSzkDBg34u+58aDLMo/MeYRNJ2GBXIRzypoyPgG/ohl3E57kzBenqyNFDJX/IihF
         6M8720uP8XKvkxXnMm3x/GN3yhIbR2/mK0J0SwRoBqphZy8UVR3Coyx9PZr5FEa/BGME
         IfYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHq0oJVsmiG69mdgNTds+to1GYZEhoPQYWWK+fQDlFLkyH3nR0BB9PHr+qR9Lyp0zl0dpoiya4o5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwQ7dOjYViMm4y7W12T3fzgqEoOCU4kjzdUzDmlqSTo4oxPI4
	ImRiQRVEXPPPjIibYyL9WMFekUQQFJwZhPu7Sqk09Bkxk/8JFICa8WgQ
X-Gm-Gg: AfdE7cknYBquVYjHrCs26qgE8kmL5UnoOZ0aLrigfPbzWcB57yzCrI+A6qoBh0id+Bz
	PjOKIIksISGYGP9xRLi9AXjNKBMnTFDEfRoP+nSnzfwi3VwqEIdfT6EeMqe+TesWE0P5k5DKuP/
	2eaAdLpqeGf3MXmvSUfJNkVOg2oezhdUM4VTzPsPfZLv2KJXrlLHzJDalbX/rfPEkbTOcJ9B8jp
	KbvKYrGjHbOYwROrkd3qZQJjlTNvSTQDeFgG6QTh82vbZrAr90QKYTfm+AOckxGbGVDRK7I1HY0
	v+NbpWUvQVct8VDBgGeZbuPo+CK06SWYJ67o7ZHWilkFIXo+kLNvjw5U+d/cRb8r+ioa0GOP3t/
	hm5mdzfufGvRZ7Skx1L59KT9ohmiMn7Z83eb3WJpd3Vnawfur9+cyQHC1jqDEehMCQexIC1boVR
	I21A688xATScdoBf/JH1k=
X-Received: by 2002:a05:6000:1ac9:b0:478:77c1:787c with SMTP id ffacd0b85a97d-47f2dd0d98bmr6806058f8f.56.1783878939166;
        Sun, 12 Jul 2026 10:55:39 -0700 (PDT)
Received: from workstation.. ([202.163.123.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f273195d9sm19562091f8f.3.2026.07.12.10.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 10:55:38 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Tariq <alitariq45892@gmail.com>
Subject: [PATCH] PCI: starfive: Fix unchecked pm_runtime_get_sync() in probe
Date: Sun, 12 Jul 2026 22:54:27 +0500
Message-Id: <20260712175427.232234-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_get_sync() is called in starfive_pcie_probe() without
checking its return value. If runtime resume fails, the driver
proceeds to configure PCIe hardware through regmap_update_bits(),
enable clocks and resets, and power on the PHY, even though the
device may not actually be powered.

pm_runtime_get_sync() also increments the usage counter even when
resume fails, which would leave the counter unbalanced if this
error path were later handled without additional cleanup.

Switch to pm_runtime_resume_and_get(), which balances the usage
counter internally on failure, and bail out of probe before any
hardware is touched if resume does not succeed.

Tested on StarFive VisionFive 2 v1.2A board.

Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
 drivers/pci/controller/plda/pcie-starfive.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 298036c3e7f9..e9a472985b8a 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -410,7 +410,11 @@ static int starfive_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0) {
+		pm_runtime_disable(&pdev->dev);
+		return dev_err_probe(dev, ret, "failed to resume device\n");
+	}
 
 	plda->host_ops = &sf_host_ops;
 	plda->num_events = PLDA_MAX_EVENT_NUM;
-- 
2.34.1

