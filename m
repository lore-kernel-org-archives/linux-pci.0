Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311EC3358B0
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507869; cv=none; b=V03w9EcHx5XYhePErBcXW5a7zZp+DnHPRuALmu4uMwN/PRzDLakwrDPvvj8MMJcOgtzqXz+wijVwqzH4bYpRhK6NfYNYtsmVqzNTPfrLocxxZJHeuMnAN/rm8mL3jguACf5Os1uu6/yvS0VBBk/iB5REqRR6uQ3TL9YIhBADNJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507869; c=relaxed/simple;
	bh=R2eSMSfkF1CrXn+gdldnHlOy1u5nKEpnHBlABgFJnG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YebDIjCY6yxtwuR4q5i3icyjloha1/m6/70XE/IXvbLXDK9YjBUetYCOpNGs3yh2t2sTY1Qr5uSrC4MLrsAz8ODpvdbtHwViUOn9KZVPR1OTxnkg1ODoN+LG8drQd6orKJALKm8l8JIOsy+vMMz5up9kStLVCfCdEd7KraxC+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H4iSseZy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4iSseZy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801bc32725so42450265e9.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 01:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769507865; x=1770112665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cb9V9b2ORNjXPVcwOKQNOEMmMPtYl7t/ceGkGIE011E=;
        b=H4iSseZyy1Hq1WnpO3S0m0azf7wKXxQeSLGwbiMu7ekOXJMIHfibF5lKbdZBekL2UW
         fVbRK5sC5VrTRPZ4emLoBlrIOKgpoQnPZ+uxLr14POPmEPb0k2sTNei8azQs6tDZMd35
         pGOpOWfrvd/BRgSeTYMQVMaVTzKhwjVTbZU7syCj5CIy041LlGaSArUNsKxqG7Sh8Gwg
         jRzvdbcAjbINndOZLLf/8ieEYDUNCJJbOPRwt0ER260Y8llvoG5f03zwf+LJ3yrvX5Ks
         Fow1Wbr8dBFl1rO9pUPsEwVBcw890SY1QXno8RRo7sJpzLnjTa6Y1Aa2CaEFfwYeUaRR
         ZYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769507865; x=1770112665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cb9V9b2ORNjXPVcwOKQNOEMmMPtYl7t/ceGkGIE011E=;
        b=SSYBodAf/4Ijx8nl7BDvBwJMKvnlz3dJVNGvU9HszvIrHxrfab7PuQDMy5iFnQvUuG
         i2WLOeG2MgFbntGAQNsehue5ot3qRz//MHplAMbGHxIyWs5sX4eRrzD/bGnAYaFD4J45
         kMSWTgO7OmJ2LzDywZnsEymULHQPV1D8EnYU+EKaJXZwEV4FRqS3JoKRPaavAJ2/yEjM
         SKlTZSAUjfHo8NYlScqPeSe0BuKBpH4luFC/jz1wJnbeVPQ/yaLX1x78zrvhjlg2OV3r
         098+MNWOvmoqCCSjXI2Soqao5UaIBNMp4+vMqcjPLkKeMc5x65U0e/QihRf7o4axZF9H
         F+eA==
X-Forwarded-Encrypted: i=1; AJvYcCUH2aUTCPH9+7p0vI/zRWTuDW8D8W6Qit+RE243hTD8/mmpENSiDf/lwFSR7piwWP+/H9cXBfGXsWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjy5CLmAv+KXPAvrDdBasGRJMmyGbiDvSyY68kyvLqyHbItXMa
	Y/d+dXMV5Z+NZ3qkfJfjIjMgWD4tTbdaHpx3cPdWDQLixY6KumgvNcTjQUH+K7mRs44=
X-Gm-Gg: AZuq6aI5qTpViAeL1LmjUTdyscJbUIsdjxC3HFVunFKj4A8W8OTld5Cm3MMcvo15gDj
	1KTKZtsJ0mwN+k2YH+h4FmpXRivgOiA9uXibHJ8L59mu2T02GpaclJGR1ID/Mqd1qoZ7g+XI48W
	oqK846kBpOaF09gdy89xn97gjPzwBZDDlv6KkbgbMPu9B8Moy2+YKppKLFnTbdR+ZkurtnQWNy6
	hwwKm53i7ubA9kdyA5UliPp0L+fkelDrlLN0Fikd1Rw3f/W7a38EjZ6UFEwaET16wsxNBQ/M7pT
	tvJNoj1Tm9nGz8jgoDhIVp8OlI/q588a8x0c9kffTc1b+PWfJiwV9MyQfT6xIOudOKf12COJJIC
	3BqtIpRIBZ+lWR7G7ZQ2iYsNADrKB+CvYOPtGqGxRhjW83kn9n+jSlSNxt9OCrSJGMR6fE2q3ba
	7VPEEVb9OxHnmQZpayNPQYIVCbCm9BZJU=
X-Received: by 2002:a05:600c:3505:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-48069b8bd79mr13663395e9.0.1769507865414;
        Tue, 27 Jan 2026 01:57:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bf93cesm49056225e9.9.2026.01.27.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:57:45 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 27 Jan 2026 10:57:30 +0100
Subject: [PATCH v2 3/7] arm64: defconfig: enable pci-pwrctrl-upd720201 as
 module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-3-c55ec1b5d8bf@linaro.org>
References: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
In-Reply-To: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-usb@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=724;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=R2eSMSfkF1CrXn+gdldnHlOy1u5nKEpnHBlABgFJnG4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpeIwSWwYfTlxDUpjTB45rdckHrd/ghXsMVEfoz3KA
 UJIdDDOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaXiMEgAKCRB33NvayMhJ0XFfD/
 0ebA/1uCI8aJQIY1G5W2HlDeP9+sA6gxCy85Fvlqu2QKR3v6HVdjmWewHNw7QmUyO5DavQTVVHKnhe
 nrwTvnHhShHIokOkxqLidW1RgWFFBXuAKNT3Py33p6UIFRFdUUqZnP4h67dezuWMkU20ldSyRmhfCc
 nYklx+uuwFhZKhZWI6LAg0wmTWUqj9eyvd2M88Eovk5uVP5baUWiIjMmNYLYpLKtk+TR5l47+v5i74
 GA6Fs36+RrakZzYXCfg5BGrNVTBVPkPmYAQ4h6BYsMEgisj8zFWTJIhz6RUMuOCLC11kC+BQoiezNL
 1nmMvEDYFbIOttmDi7qohh0aD/vMiu6vvXFhnAHok8qXpvygBD1FXmAV2E7TX9LzS6l8OsmzTuFmpb
 fuHfRHWFiEN3vhqJMfaJYwRJdcQfIvYttQKWKaqrNelljs1UZewRIPMynslHWhKNASwWImTkjiu8aO
 zIRpcbOaAj6V3s+wB9czZuXEudHIt0uM/CsIzy/d7Ej/NlbG/VVASaHlNZF8S0MPmQbAQ0oquUFqkJ
 TetXbupkFi6TAHpLJLs/1BruV5sTO4OB60LqBoXcsFWySSc5VASS5FahQbjY8MOqelxfeZJkYW7LPw
 XOqevKwZKEpZnRxhBsxBiI5mVfSTc4cHYZick8NejQ2VcmO0RF3o27j17KnQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable the Renesas UPD720201 power control driver module since
this USB3 controller can be found on the Ayaneo Pocket S2 gaming
console.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 45288ec9eaf7..67c642821d35 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -250,6 +250,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
+CONFIG_PCI_PWRCTRL_UPD720201=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y

-- 
2.34.1

