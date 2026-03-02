Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3AB319858
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429493; cv=none; b=A6YBubcPobLE9dumDCpNXCELZnIzPWex97MhJ/thUzSj4X34N7onrewbhOEvWQ5yRXYEhY+DU/RC2SZ3JLbEZXKDkgoin9+6pF4IpJI5rJVx6s1QfBo2ouAjTE55pB8XODCbYoZ0sPqtgEoW4Sa1F86LbeahW8B74x+7nw+vVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429493; c=relaxed/simple;
	bh=sT3yqyHzruEvKWZj6k2mc4CeNmdBmWqvDm0NA0ApQa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdQpMCuCBURhyeNKUOQc0Aw2s4vfFLqb8wXnvW3i0q7WYflVzhzZAQ0oFMLuCvfSJzHKnDIpvbzssLSO0Ji9gdkUKHw06gNLJO41qVwZvnM8s2TgbFfdiVZq4DA2bYJ+j0k/c6TsRS28xfcBIYV4lTGUmev5UKNaXyQ1YbObeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G/1mL+hf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G/1mL+hf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae46b9c70dso3718135ad.1
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 21:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772429489; x=1773034289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPd8tgeA/RssAFD8jAQGxHvdFlZ13vWwzgtMLfIKr3c=;
        b=G/1mL+hfmNlTRanAsQcPsovy6TTRyun8CDvaOVl+LAY3ZjR7XbZ4VGpVInkczECzrZ
         mdxyrtnCPwtzkEzh7r3PJLZcFrEHOJ1kuc44XtDtHNyQYt4R9HqLWRv2mZMANMGsYHHn
         m26CuCchP70mGkaZL1nwLCkhAA6+4rVi0Hd8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429489; x=1773034289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tPd8tgeA/RssAFD8jAQGxHvdFlZ13vWwzgtMLfIKr3c=;
        b=DRlBviCwkSZ4WL3tuOcsrGoLirkV02DEiYoTOAfo2KfVI404hYgBJ6t+T22qNSKXeQ
         YLR4OizHHrYZRcENQUtLLuPW3YCqe7QeGMNCmokEu/p4+kH8ZHszJj0HAtro/su1MQbL
         UjWbc+/KBBDBt/dS0PzVeyjkJXRLaikiHILS45ITPj9mRwBGAWhf6BOzJtp3BW6aic8/
         V6JE4kwQu6NieILk5T7v8tNlkQrTxdi37hHU2fuxUKjSVF4dqyeDEl0B2gpKDF3nVYn9
         a6hU5La+rO0DIiHqOef9rBUOqurhrXUPwij5Yqbk9U4JU6xqGH+x6kAqQZU7w2sYZYlV
         W0HA==
X-Forwarded-Encrypted: i=1; AJvYcCXyL4bLPrvx/ENVCTov+eNVP66F6Vs5//3JwnHDTR4I5o5pug4l339PEfkBE4WuovpbJW0TI9b1SzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ArtIl+t45osaKXibZ3fopOaEpitCyrfC7dU8EOvYgMlFOnO7
	wLpy79HTtlSZyPYBBcCFhDQGEpGWa56nVCCDijRFCQKCH/szcrzwBsOlUEv4KiJ4aA==
X-Gm-Gg: ATEYQzxZWWDqbJpBh+cBmjFQ2HcDrYXibc+46gceRfVdnAC2heQgY1pCtGgU9ifPloI
	0k8uYY368JKLMpw1bnJX6waLTeGiu+8hVWjm20ZmbBhGUyp018JsB9l2tYdpwjtcgMDUXRjvgLs
	XJEuNJhxvP/plduhlQzJDsgzsTIlJJ78kDPNRKSToU/i1NWn0HygKGknz2MZc7mAZp6FUPUbnSk
	QEasplEY56Pimd6c0izG0a8fB0lro+zRebRY9QK6wtKjIXxfkFmNJExIHmjrEUY74z8xkaDqD+7
	/a1KolfI3OGNSww7p0ErmtomhoFjK1mJhfDYSR/ibrN72UzLPRuBKJqmsXWCjOQ6oNG/kbKdkkf
	oN2rYDyuU2aKFBL0gyWgGRMxrY4qNarkBPnF6HPBuF87HaFcQ4v9sRIuc2T0FgU1DAs6E9Q9s/H
	XycmYBK/gapM0N+xjbn3VnQwjkPW1iuNPQ98nn5HFPnb+zNB/xJvfoQFUEML47DWMXgVqneuRFS
	SYWW1bk
X-Received: by 2002:a17:902:ffce:b0:2ae:4ef0:168e with SMTP id d9443c01a7336-2ae4ef019e0mr23031325ad.13.1772429488915;
        Sun, 01 Mar 2026 21:31:28 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b9b7:93f7:8c3c:59d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5229cda1sm15196435ad.23.2026.03.01.21.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:31:28 -0800 (PST)
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
Subject: [PATCH v3 4/7] PCI: mediatek-gen3: Disable device if further setup fails
Date: Mon,  2 Mar 2026 13:31:04 +0800
Message-ID: <20260302053109.1117091-5-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260302053109.1117091-1-wenst@chromium.org>
References: <20260302053109.1117091-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If further setup fails after the device is powered on and link training
succeeds, we want to place the device back in a quiescence state to
avoid unintended activity and save power. This also helps with power
state tracking and balancing once pwrctrl API is integrated.

Power down the device in the error paths of mtk_pcie_startup_port() and
mtk_pcie_setup().

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 870d3b3db11d..7459e1c1899d 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -531,7 +531,7 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		dev_err(pcie->dev,
 			"PCIe link down, current LTSSM state: %s (%#x)\n",
 			ltssm_state, val);
-		return err;
+		goto err_power_down_device;
 	}
 
 	mtk_pcie_enable_msi(pcie);
@@ -556,10 +556,14 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		err = mtk_pcie_set_trans_table(pcie, cpu_addr, pci_addr, size,
 					       type, &table_index);
 		if (err)
-			return err;
+			goto err_power_down_device;
 	}
 
 	return 0;
+
+err_power_down_device:
+	mtk_pcie_device_power_down(pcie);
+	return err;
 }
 
 #define MTK_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
@@ -1174,15 +1178,17 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	/* Try link up */
 	err = mtk_pcie_startup_port(pcie);
 	if (err)
-		goto err_setup;
+		goto err_power_down;
 
 	err = mtk_pcie_setup_irq(pcie);
 	if (err)
-		goto err_setup;
+		goto err_device_power_off;
 
 	return 0;
 
-err_setup:
+err_device_power_off:
+	mtk_pcie_device_power_down(pcie);
+err_power_down:
 	mtk_pcie_power_down(pcie);
 
 	return err;
-- 
2.53.0.473.g4a7958ca14-goog

