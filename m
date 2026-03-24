Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56F2773FF
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329628; cv=none; b=YV4nH/nGNNFp/uieVFZBAXJCOhF0a4Mp2Fv7F+AGbqpYGQNROVHBBXRrr/xLkO9weC8dM+sZn7fZZN9UytmcAQaoY3TK7Qq/wIiGV0mNv6oXNkyklOUqDIgGHNnIhUzQISwKKLaKwCU5Y4VP5YHmdeotqGfQclviLkqUTyZVkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329628; c=relaxed/simple;
	bh=/AlhRTbtRWo7GbL2ds2v9wvogDNH5q6EjWRr3V3z/rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ07JpLGPbbolKbAv1dBuy+c/L0jgW0eP6knp/j3n7oQG1PGDzed9Wf28aK+b2HlK9PffaP5tqA1Wkj2IMN/mFl2W06gxiT4ZEycN41xYzM7wO0gMAjKMbVBwcZoHcPptBIi/knncTcPTwLFMHBH87m85aRvIvVrHlTTtgELLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mpgiqkMk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mpgiqkMk"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso1815052a91.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774329625; x=1774934425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcsyifPwpw7PalUEgFntf8CIjQvjzcA0RCRU1Yc2FT4=;
        b=mpgiqkMk6AkzHkdJJfHxkQKgDj5RYp3+lqt0r/S+AlO0YvbfND26d2rMr+OA35XZUk
         ADosFyLE0L71XTMKbmJrwEzLDMpYCHIkY3XAO96u4uoHpNqFXk1651NN3dvDN/WgS2Yv
         AtV0FTc4znOZLSYFvLJ2GYaxz/gnlHillHQ68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774329625; x=1774934425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcsyifPwpw7PalUEgFntf8CIjQvjzcA0RCRU1Yc2FT4=;
        b=JjNjxKhfuNqvn2xLOV6RDqvh99puNjRHclcbaUDfPJ7drIEfoBVnEph8/p01b1xlt9
         s4fQQ2nCCRSPRVVnUVGGD9ZlXtt/lhspFxej/T35zov7yRw/fHEiMZIKFndFnLsgGWEy
         jOWbpv4yVGyn/NL+zmmxufiG2YJ4HaljoNfMBtFp4IcQXbuoY4VnUYRncIGaA7VriOUj
         09NfabiCvUU4DecvwATkCBf85yVUWmU8l2pqr/Pfmcl6lhSWIp6AxPvvLHHVLIh5DvcC
         Kh0trZkXU2Dlle8fIwkPIIx2EPFByNIpvwO8NrHgIHMSLGFvSOjLTsYIu9Qf30ig+8F1
         RH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+RDE3sqKZLOrQrLXyxQIsHWKowjq4GxUflzjJsjt/3F32TzMLJKrK5hjqbKc/tHkLRMDIwpY2P20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRXCPkQ/dsnvoB1I4DMwSQF6cG56MhsTlyZm7PRwoiqNA746R
	3MjFK5XdtGBP0orn0jjse841xVZ2OaoO1RrMBsCy1MBvSriMP48Ws+mvXQkZZTLktg==
X-Gm-Gg: ATEYQzzCijyqsyF0/cPuSUiaauSr9bZMKx3hPRxsVEQrlMTl2KCE1u62WQAsKPrg1D8
	NWgKLV1BJlcxi3umXw+A5srdC7BwVwUNyU+4I7CrQJe0y4spXXb06XMTHQcUlxeZOa/dPdYvYRQ
	BrgH0+ScziilfHyfWKHMBlQyrHHhiVWJMe30P2ggm9XkEjbfmFHRgM//AEzibI7XMl4Qa4XXIn9
	GZWRbP7yxmJnu7HUINhy9iFrCILejeo0szPhWD5YXyK+1zEBzzMm8qt0HKOfNQQ7bz2D9rK5aG7
	3yhp2xiZF+kvBsc+1szFyj4p+UzNw9B8NsnlKsfZvmZ9TBKriw/820uZDP/0nzKO2UBmlXiSA+J
	QM9eGTQagAMgsYJkFF2x0YnT30vNTTm7t1tiUM1ex5ETUSbcCHamB8Nf7Qr/m5QSoSFy8qZkuQ6
	LTjsrX6znDb8+MPt2+auUJ+jJMw0trx3XA4V63H1UjL7ZGaDK41dqq03FISjqcxQHct6NkkiJYi
	DE9PszKCRJ+xRgQVNA=
X-Received: by 2002:a17:90b:510b:b0:35a:1b43:dff1 with SMTP id 98e67ed59e1d1-35bd2bf7926mr12662239a91.12.1774329625440;
        Mon, 23 Mar 2026 22:20:25 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:19a5:8f2f:d584:8078])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03124a87sm1068647a91.3.2026.03.23.22.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:20:24 -0700 (PDT)
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
Subject: [PATCH v6 4/7] PCI: mediatek-gen3: Add error path for resume driver callbacks
Date: Tue, 24 Mar 2026 13:19:56 +0800
Message-ID: <20260324052002.4072430-5-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
In-Reply-To: <20260324052002.4072430-1-wenst@chromium.org>
References: <20260324052002.4072430-1-wenst@chromium.org>
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
2.53.0.983.g0bb29b3bc5-goog

