Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921983D1AA6
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411295; cv=none; b=k5w5xywVz1q+7+f+WV6O7z7kElweaLZufYSqOK6ZnSxEhkrxM34Ymb3JCXRDCXjZdb78useTN7WnKxvu0slkOk22kncbrU6JNHAkrgynZ04m4BNB33/iNpwXffdwGQ9Qe8Vs/eEWSu2FEvAf9XJEYXSn36wZananqmBAEwi3j/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411295; c=relaxed/simple;
	bh=B23Kydln9+sFNwl/EddPsXeSNGxgpJc+Bv5D8Nfp/CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnybP+/62KPsz12rOpr0dZrKANwyCjCEk58hjBkdnJuc9afvVDAFPP/sQgAiuTFfloGHz7UCHVHBr3Ko2Kfxx0fUgfV7bTpTvErrbD5+oHcZSHM50fdRsStr3sRxNTnXL8zz5o6mtyzTAVnAlX6oscTT/bhvfRMK7nXCShVF8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfroaLax; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfroaLax"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84830c774a0so2291721b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787411294; x=1788016094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/zhBj9KsrWu1iz3uRFGRfIc5hKkqLHf63XbozGChRc=;
        b=sfroaLaxYUfoSaeQ/atwN8JuYjCSALC9mC5xCx6sF+524JQ7rfY5vLRJDlHMq/Y5db
         6vDRF4NerW6nLO7WcoHY/my1AOcIp+pnKy/6UecV9c6B/EpgueiRgyhbSezXELfiAaJ9
         iHIit0wlX+NMT+piVs9CFbsQMkuTA4WsLsM/pMt5kjMt6I10jinjL56ULG17iRWDWuB1
         CuF7KIeeG4hHly9Meo9sPFaWBiO+Nt/rTZrh14MjCeQcRGIVecmyEZCEqL2ncsAJ/o+/
         WRg6d0LMZodoG6FMUJXjdHfEpyvM2RbuHzZN/7y5NOblMd5DASfK8aZVot7M5nK+1K3Y
         G6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787411294; x=1788016094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7/zhBj9KsrWu1iz3uRFGRfIc5hKkqLHf63XbozGChRc=;
        b=O3rlA7Lq8k1omY++HJeNs9wazWgRdmRvzOeH1hXVl1HHumelXBvc8xm0E7xy7MK5B9
         caIOVymSpHQOJ9USG6qLlHTyHxrReyajSzjUJf8bFQ9cc9gPr/vz7JaF5WfPmk2NZq7z
         V57zSEhN+YXolFSTTNb2NOn9kTSW2Q5ejSphxCyW+cQO1c+UWsY8MYj09ipEf+YNj7Y0
         dY38A6cTmqYhuhcF4QVeNS7IsyFLIuEaEVImsuEpCmlX9zf8j1zHydAsxXmRvOLfkgr9
         mfdGpW8h7qYLK8QlJeRCw6LH0tCCbRVYau7O35t+fiWvdHhlrgw1OamUM+b3/qDiU//v
         5p4A==
X-Forwarded-Encrypted: i=1; AHgh+RriKwR5zt423Q1tqkfH1J0HHQKYQO+D2WLfYLLW6/T4jcIDRQbMDYOw2gf4Uq/ak9eQMlMVMTMBOf4=@vger.kernel.org
X-Gm-Message-State: AFuF++nGLAooGEoeuacyiPvmoenMe9O12gdu8IoVU+2yikc3fbuCKO8M
	LmOKqpj2wuU/6HXeLJFavbTQbsS1ObhlAhEdZYUssceApMUWKwlPOoeu
X-Gm-Gg: AR+sD12j4VCYbibiElq5HDOR0UqabZY1+mKIZmDmPpNsBaF27ZdMY7piAx0EovoIRuZ
	2BRBLKVIuk2pSWamdV3em7z4oj2p7sbcgpysUhvm+5SWwCaly9l/UC+9Z7x4X4EfpNM7Gg6XFfQ
	/4uN/A6jaYgSsqttA/IvVgO6tuOokkp7T40uxsXP49OqsmXT00P4+8SgrWRPI/LJdOz4dTJo5CX
	Z1AWuavpa2/GqokAIPhlCw7dWJKt4gc7OSpNF68BQNu3fduZLEiq43T2OtXr9yfUZqHx3Y6oVUb
	TPtqzTyUFlSAW/9S9PDuhhwecFxpOh53HdKWrmmsGRevNYnd1SDWMWyszABO8WwaC67JZuWtFUr
	gGPKwH+aokrzS0OscqNTYFbIE4IlWihR0rOb49128q0oX7yZxqyuvZYY3PFT9pGf+mratjLEdCe
	ddjYQdYMWF4ullBy5Vxw3Fa6zZ1gHYqPHtVyDErd0CNhmQYchtXP0KQBCCGCZCBL7UNjGS19IOg
	RYEGwx/U8xew1jDcd8uhDVH8m9+hZm4uMMJ9YFtDBNH9hIQ1m+PW2ey
X-Received: by 2002:a05:6a00:14d4:b0:84a:2fff:cef9 with SMTP id d2e1a72fcca58-851f9f84b8emr18586843b3a.13.1787411293482;
        Sat, 22 Aug 2026 08:08:13 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b1ebsm628242b3a.30.2026.08.22.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 08:08:13 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 22 Aug 2026 23:07:48 +0800
Subject: [PATCH 2/3] PCI: dra7xx: Fix device link leak when devm_phy_get()
 fails
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-dra7xx-v1-2-23e204d5548b@gmail.com>
References: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
In-Reply-To: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sekhar Nori <nsekhar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787411275; l=1121;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=B23Kydln9+sFNwl/EddPsXeSNGxgpJc+Bv5D8Nfp/CM=;
 b=TX1ESX7RK6u/H0zkVg6E0SCFWHpFzbnS5YCn4VL1Y4bMfduClDLmt6rcMJoaUKwAyiOBXMhmO
 cENEnoJzPM9DLryFJyE8Xfafq84ILfLThjpcV/5SGBtHXPuUruKAjOu
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When devm_phy_get() fails, the code returned immediately and left the
already created device links behind.

Jump to the existing err_link cleanup instead so those links are
deleted on failure.

Fixes: 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d43253f7dea6..bf32b14436f9 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -740,8 +740,10 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	for (i = 0; i < phy_count; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
 		phy[i] = devm_phy_get(dev, name);
-		if (IS_ERR(phy[i]))
-			return PTR_ERR(phy[i]);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_link;
+		}
 
 		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
 		if (!link[i]) {

-- 
2.43.0

