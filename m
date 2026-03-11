Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B713B38B6
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215575; cv=none; b=nxEGV3l4QvjT57vYTxI26fqBleDZkggEz2cYeMd9OPDac17SRktUp4HhpXg1WUOkPaNlg+2//F2zVqYnJWHmpymlFm0kDAxiHIov4DWRMFjO5+FBeA9ZJZAFp4xYDsZfdg5cse/Rxzi5YDIO4jE9letWP5DFXbBOE9yt/wxMLXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215575; c=relaxed/simple;
	bh=dh3HpoAtXE8uw7nBOrcGhCCgEUFGlm+/z1/p3QFqscs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSMo6Ylmh80wzW3MNeDqLN+d1P49HuLONy2UwGZ6wajLomkznF4xVRaQp6OQqmJQX3jUE4bkef0+GJSc/+1wPdtWlJ7G9IuD4xrOkxnKhjQX1zsTCn9ytq6LQ18eWRYYCdEcDe3ukTqvGx3VUCaFKthqBeU12mirzmb7EYyXQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bVXS7Dwi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bVXS7Dwi"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3591cc98871so6245504a91.3
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773215571; x=1773820371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLaqL6RDjLUDRC9IFh+xvK4vJysRmVxopr+1H3G1aWA=;
        b=bVXS7DwiBUPSQTmMkmbqY3aQ5/eJ2rQ3HE8a75LgFjhIPfQDiHNyt2o1sfrNZa+ZI8
         sm5BrYy+re45HLri9lF5Q4PEWNpD9JRWFvzAKxhk4RXkP4+61eu4pKnFUEWJXiAdVe7v
         RtV8o298J8uiNtqOhRuX9sdvNBO0OoMO5d/oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215571; x=1773820371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NLaqL6RDjLUDRC9IFh+xvK4vJysRmVxopr+1H3G1aWA=;
        b=anBgrB1jan8OmxqkHah2ocE9nyqmUnBRCsGfICVHO7dwdhiiXJERtJT4+ZfhLU4yO6
         cNZRAE/sKSlI7OTMI8adXI+S7da78irpO1pfMY23D19y4PAiESAWchqcEAKVlGwcpIaJ
         xjrDQo2B8BPzMmiH0/pCgWCv+rX6CZcH2cpLfdEqi967OuknrU5MtSGUw/ETqUigUSMP
         /i7d/iHVQWUgWb8U80eRVMDZxK/FrpHNQBFTknSVCKdBqyLF2D1PsUYI4KwQiyS1xIf9
         03ObfoSdLvl2cqj0BfABozKBp4sCyv2dTiRz5Xv/CaOHUgbg9MameQwfo1K3aIbd3hJI
         k5Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV4bL/YdZ1SifJbZ2b22qqacuVT6fD7hpu2soD5qR3vKrCGJ0EINPkkjjUvTamOwetkrrtNgPmXc0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMq4P+TeZKUxvigtCxryy6MXwlyN1liZuFfKX62zPTOMYyjo+
	Lc0T7EAq47BFH4jdskStj4MmM8iS/LMP0gr6c/oxuf6zn3Rsm5n3KA3VVQPty18USZquSvxLVVI
	7w+s=
X-Gm-Gg: ATEYQzxUqxVDB+2z0VdjO30dPkVDdEqv7irsFvBoqyfhrz4h0HMNKPhdBAtzxyJB5ae
	t+RBtq5uct2f/dQG4XAaghWjEGOoilm4/9ac2pjGlr9oMYZb1JKzjsn6xtsSMHrmaLv49KjvKVq
	mrIvAicLQB58aijwG9rmTAxtg2M76bjbfSPHwSjFaA/yQ8nVOjWvUHstyQt2r+1W0bjWvalUq5M
	slze7R3RjOoJmrroVey7mza+u7FaO8ikmdwmK6/NUw5jIOZyWbUUh5oV8buLiUjz3lJVGGJXE0S
	qz9wKd3y/vb2J13jvItfpSsknlEW68w8sVuqZ9KD1CRha7wlpg5BsSw/OkrHaPgI60UNzxurjRR
	ZDEHzrmHgHCtfYLazmSkvCJ1HucP3F3KUx9Lfh0P9RIA/URQrdK+jZIhwMDT+6wSKyAshvQOkPp
	Kxe3WhO1AWAjmz7gjzHhfcH9ShxuQu4R5jBx1KaPW0VORUcV6OJX/0xFUqIxISJAs3dUjFv9iX2
	5kckqm8
X-Received: by 2002:a17:90b:2fcf:b0:359:91a0:98fc with SMTP id 98e67ed59e1d1-35a012eabfcmr1678387a91.21.1773215571523;
        Wed, 11 Mar 2026 00:52:51 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:805b:14e9:f783:bcae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0236f79asm727816a91.6.2026.03.11.00.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:52:50 -0700 (PDT)
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
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v5 4/7] PCI: mediatek-gen3: Add error path for resume driver callbacks
Date: Wed, 11 Mar 2026 15:52:19 +0800
Message-ID: <20260311075223.3303497-5-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260311075223.3303497-1-wenst@chromium.org>
References: <20260311075223.3303497-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resume callback currently does teardown in the conditional block
directly. This is going to get ugly when the pwrctrl calls are added.

Move the teardown to a proper error cleanup path.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Dropped probe function error path; covered in previous patch
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 1b6290f2c360..22a16e4ebc76 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1304,14 +1304,16 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 		return err;
 
 	err = mtk_pcie_startup_port(pcie);
-	if (err) {
-		mtk_pcie_power_down(pcie);
-		return err;
-	}
+	if (err)
+		goto err_power_down;
 
 	mtk_pcie_irq_restore(pcie);
 
 	return 0;
+
+err_power_down:
+	mtk_pcie_power_down(pcie);
+	return err;
 }
 
 static const struct dev_pm_ops mtk_pcie_pm_ops = {
-- 
2.53.0.473.g4a7958ca14-goog

