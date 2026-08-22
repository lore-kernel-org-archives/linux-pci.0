Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1F2F25F5
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787361745; cv=none; b=dluwvZNKNMdxiHqNt03i5eXvxt2OBAFd+fgaE9tyM/ila1psDkfudhGbP2WudgHAsHqDPnks3T/z3hAruHAVL/+DxQWEU1CzsXBJLpj9IBel9LujBPb1Q4fIHA4o9t9PJQ1zYC9HOTGCAH9GU3Z+1FjBJdzn7w7mRZV9zWKpSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787361745; c=relaxed/simple;
	bh=AURKOmGEjz8Y2p/odOo8yUCzmm57mPtXY6UFzZRhmi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O1LI8PCbuxBkUKZeeGendZm65aTO9ti8KAQ0LQblny3Yu+dVgCdJwJdPtv67QnbDOB4+Z9BLW+q3i2/3kbnFwg6hoOM4Y4xeTo8xmM551elddIty0h3lLTY43yaLuG5kkkA2vNtINDo6U/mVYvH0Rs20L8dbP8hdKBUWxqvPYgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2Pp7kQp; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2Pp7kQp"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso1201639a12.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 18:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787361743; x=1787966543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XNcfeMEYwNlJBKitvYBP+hWuT3fX1KTsmGqaiTl4+vY=;
        b=c2Pp7kQpeU+yRfCKZ9BQxfyBW9Jifr4+YY6UOrw/eSN6QnRqoW3E3k2G73PfjgWNQa
         RxFO9BuGSnpcqeaWwd7Rl2N+7qMxyubILqVUVQtMNmdvRhgAcVqHvucxOZGVEJCoSCox
         XpOdIeCvwtJq6lqjyoW4QoeixWlVOeYSwDiEvEdpYdp8cDFTwk7Ek79Puvj5iWVMaAT2
         IZ5ph8FJmW/WARDJ470H0ItiUqOf0E0mtj5kn3/D5G1AHidk/pe17Id5kKLvTLtO9Wjr
         XS1vJpZnNLAO44g+jD3ki53+0woB7h0u4kTs1160paVGtEALSOsx6hgWqCHslnDnCqhj
         EQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787361743; x=1787966543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XNcfeMEYwNlJBKitvYBP+hWuT3fX1KTsmGqaiTl4+vY=;
        b=JTzXx9a3ePTiAWr3EYNvJphsg3il9HwyLkUsjgWv4k5MwXlIWRS5wp+/N2Ica/xjYp
         CLvsGV7Smbb8e1eqKkMbcZSGCnN9LFHkrf/9sKb9gBTSXDpfJMWYBOrJJVEFfF1vHHro
         SMvuDPlxcyBnDE35wkW+V7iG5Yg4kVbHibB7r2yF/xV2EsJrldZnjnaPUIiaPzRPS8kV
         zNPvrjxFcJ0PyX5tD1OZyOCr6dMLV4SjsUBufPM32VNl8OzJi4a4GO+jvlXHg6CCwhbY
         6DLY543X4vwWc37TTxt8mdX/AZyxQ/iC/71Lk4WZs0EN3bIToE5WaPzBXJk+q3aJ5MrM
         CUbg==
X-Forwarded-Encrypted: i=1; AHgh+RokXhTh4jWIvHbqSfHoxsiOAQi2NLK+mzxfKBx5Mcc4HUToVN+O2dVg4lAyAERY7oxxWscrN1j7FBc=@vger.kernel.org
X-Gm-Message-State: AFuF++loTpYDU4G0lqhyS+mr5ruprtrAaD2ZKNUu94N/OOitd41doyTp
	k+ACpz06sVihC0Y4yQAPajr1XitGXZcij4HRYK5s7lnJkwpHMkRR5A3M
X-Gm-Gg: AR+sD10vNhcnFfH2sqbuZzpZ76bf47/GCiD0FmV5sDzGYhblxATH2NThLy6+oLeeyad
	vt/jJDyEwiyFqnhAd3fsxopAVEBAhWrY8UoHyM6GYoD2Og43dCGns3aLGqcal993B8jkPaGd9QH
	npiJkuMrsaH1jgvKGGplTxSWjxSciiAaPC8r2amFYL/Wo21/X/fUewNwT8uosl02RkXaaRlI0cb
	54GDd+BId1v9KyXAIgJ0ETRzSGN6hbNceSgLhTf3IVTLEVfjjHvnxiA7G0BuygnuAEkkYU7Dp3c
	BL+Od9UVL1Wa6Y3htiR4mfYOxQBKlOjPownBkwnG9a0ACUUEdkC+WAhmgzs785K/Go2pV/vRvff
	Xk3jQVF5vNnUEmbOfPWEz6IgC34z9cFAcyfWqdPIt8qPtpUKD39omcKjAzWRrgsWG1aD2Qn/YZn
	wdrIz4TPLv2V9quAQI5D0//7j3qEDHhOpElINCJ7vLwaZPl9MKmFnxOkQ10KWzkCrKbsR0BZA1w
	jHKQ5Yyi6ayeHEePCXws58YW7P5eiprZmx24PR5MQGPyDijonW6I4OqDfr1XFs=
X-Received: by 2002:a05:6a00:1407:b0:851:8394:1696 with SMTP id d2e1a72fcca58-8520ba16a9bmr3668474b3a.12.1787361743351;
        Fri, 21 Aug 2026 18:22:23 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b243sm144370b3a.31.2026.08.21.18.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 18:22:23 -0700 (PDT)
From: hanzhijian <hanzhijian1991@gmail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hanzhijian <hanzhijian1991@gmail.com>
Subject: [PATCH] PCI: imx6: fix pwrctrl device leak on PM runtime setup failure
Date: Sat, 22 Aug 2026 09:22:05 +0800
Message-ID: <20260822012205.2459806-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In imx_pcie_probe(), after pci_pwrctrl_create_devices() creates the
pwrctrl devices, the error paths for imx_add_pcie_ep() and
dw_pcie_host_init() both jump to err_pwrctrl_destroy to tear them down.
However, the error path for devm_pm_runtime_set_active_enabled() returns
directly, leaking the pwrctrl devices.

Jump to err_pwrctrl_destroy instead so the pwrctrl devices are cleaned
up on this error path too.

Signed-off-by: hanzhijian <hanzhijian1991@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 39790e66b..616c42932 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1975,7 +1975,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			pm_runtime_no_callbacks(dev);
 			ret = devm_pm_runtime_set_active_enabled(dev);
 			if (ret < 0)
-				return ret;
+				goto err_pwrctrl_destroy;
 		}
 
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
-- 
2.43.0

