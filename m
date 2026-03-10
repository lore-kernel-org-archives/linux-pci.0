Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C643E483
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134409; cv=none; b=fi6mIPIkbJ3jWMv5a7VSG56qgFhjs3hL7zZ+JdwLeV+cnby6Tmk8ZXNR51XkEiOoj31p7yp2zTJZ3B7jJnhJK79h85GnEhCrSohZ0nbcPgQhQOMXz6WB0++orf0DNTgNK2gmhCm2oyOpoo0e2CLhM2S5R0nFJ7Jx3OMp2JndqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134409; c=relaxed/simple;
	bh=dh3HpoAtXE8uw7nBOrcGhCCgEUFGlm+/z1/p3QFqscs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca+mL+XdWn/V8POhDsTddBP2ZXKeGWsAzlAzw++kwZObJl0aM83vXfQXdoC/pFJJh6LZz5D16io+vlKtHViQsJvcz+ImfnpyQndFAJ+Ossxp7dlfzz2K/tsrrXoFoCd03JFzBHGsmK3ARTK4cErANl0KHRIIhMAm7JS2Y9MOxZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JbfZsZZx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JbfZsZZx"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-829b2018c94so1986486b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773134408; x=1773739208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLaqL6RDjLUDRC9IFh+xvK4vJysRmVxopr+1H3G1aWA=;
        b=JbfZsZZxOwJBhy1RMKAaiuo4otC556HZbyrPygKn/IRtl+JRpjhHbo/cIByi+qRLnF
         vViJidn+xpOKGS0N1D4Fi9D7RNHeKbEQDYrALHvOjEpB5Xv9OYqq3qmjbvOA46475r4K
         B9qs+lkC/JEHCIb3dbq8m9QmmtN0HdZn9QYPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134408; x=1773739208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NLaqL6RDjLUDRC9IFh+xvK4vJysRmVxopr+1H3G1aWA=;
        b=Ui7scP4ECinVTojEOBXP6pBwAO+VWjeMkHQDLyyuGWqKiuXgGAWm4uj85G6Q3oHPrQ
         FwB/QaOnntAQMuiwJ1hFHfzC7pxY8SNOlA0qFe784StdGZCn4EmCTUPGPL+LZb3Tx2eG
         xHcHmZLSPmwgcqG/utS1pE5VMjPHsH+5m3JbUXmWPbvTFfE8NTh3dxEOwkI+azI0bdzl
         XbJM8YL7Fn253Wq+06hUaW4Zwa0Row8IAxkgoEuqptq/18AuQ703wqDSYwK99yun8Nk5
         /BKroq8b5Np4nUpF+BBbac91NrcfTmhvtLeIZAj/CKyebMvr5janOA+OC+C1sy50KPuT
         /94A==
X-Forwarded-Encrypted: i=1; AJvYcCUsb/VqSxzGrJhmvgo4YGiBL90ixuWe2MyzFKz1fzZyoeW8mDwS++rF6ueZmpOOovqecdfvn1iZe60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjf9iP3gYHJPBiIA0nibIMNLK44+X5aoiv2AwGyhXmv4pFi/d3
	FvKJmSG41k/iJ87w8EZgcqYBZZgJWbLwaV9eeoKbEsSENNM/C0IW8N1/q2XT2Oqw6g==
X-Gm-Gg: ATEYQzwTtO5Tk+o9LqRpRsveAjZudZV1x32B6hyqy0X8VhzlZqkgd+XEGCPV3gV1AA1
	9nUF8koJFaBshcQGzbcaUqsN2jW/3rEOVLIsRgHimCjmy6AOHhDNNPz+R80+WrLix6NLHMvNVZn
	Umg7+7TzrKnwW10C7dhlFfFb3ua1YiWlhPbsBaGyStV7t0bJVSZNB4GeVgRiXTHsh6mh6Znkj3B
	CwFFMyCWbkvHg2EnJKJfCrsSJe/NVRqCo9Zy8L0IaS0pfLvRNFAMoKWID5Qr+Auvi1BLErsNXA3
	o76vuRMHbMba8Z+5xgl1ojsWJS/YSTsPFDwf4KL5G7uGt9f/9yGPipO6B0su9sjJofk8s0cG8o4
	LU7LW7ZgC7ikNNdoXX4tsWarvHPWe8oLEoafTf/3Zz2s/hqx+/K6L4prJK6XprUk54pbIggSRQI
	ePhSSJIVzQiR3li7yE1zGTAsR3hvPijsPZ80eeKEJYal7hpnleCkerHT1bJhZjkcwXaeTxCZnP8
	8J8TokdJTBiyAZ6+Xk=
X-Received: by 2002:a05:6a00:1301:b0:829:8942:2c96 with SMTP id d2e1a72fcca58-829a2de2aa3mr12505372b3a.18.1773134408064;
        Tue, 10 Mar 2026 02:20:08 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:ee38:e01e:e888:6900])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a3b74sm16965190b3a.45.2026.03.10.02.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:20:07 -0700 (PDT)
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
Subject: [PATCH v4 4/7] PCI: mediatek-gen3: Add error path for resume driver callbacks
Date: Tue, 10 Mar 2026 17:19:43 +0800
Message-ID: <20260310091947.2742004-5-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260310091947.2742004-1-wenst@chromium.org>
References: <20260310091947.2742004-1-wenst@chromium.org>
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

