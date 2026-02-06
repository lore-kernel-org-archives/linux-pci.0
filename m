Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335BA426D07
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389446; cv=none; b=VRMDNsUP0Mn57ycdzS5Y9xsAsr301vEL5E6OJ9CrjNqPa1yu7x3FukKDWLnvrRidTDksTuwl+G0t4KciABAbQPphzhxAvLrotgZLzhvHU6ppRtg2tM82dNtBTA+m6ScqLVslkXy7hqA5Y4XIivmfnXeHaKYhoJuj6uvW0ace7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389446; c=relaxed/simple;
	bh=e8pzRN+C8ACMBcukIaiVpQzGH+euW8HR5vxtjI0f+Ds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjtOROcSAW0fKRyl8YEYmjOXXWguW0zIUbrLQWkWWeDBubMqZsWPN7jMv7bHGiUcg5mn9ujznpg7vQiKvY5hcn6Mrbqm9Dh+WuRd6emSE/Hx+6WcXTdQcxqnrtfkvQpVoxDhCI22yghA3Tc4DeKJBWw+sqtqPMIJe+VWBzcc7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VhefWbOD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhefWbOD"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso19501025e9.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 06:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770389444; x=1770994244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+kM/Pl8XWTSE9o2j4VB9J5wVR5uzUXKqDz9HEirBDc=;
        b=VhefWbODRyqqs1/cbffLLzaIudy0cVbThRZ56gpEmDNuJ4EnRYwetQGK1oB9oxfJzZ
         06tgcv5HtjjeA7vGRnBGUboMnIrgDpaKDpJ6YKLEYP1wIAWoA7IfJqOfN3KNww9jxTOP
         7X23QkKu5jO+2hTPtSdkBZ3k8fJ4Ouf/UsSjcydSBRyyyEsCVTUFBREj6yC3YEMOEErg
         8JOOkOOP8X8cOZDEyee6NS/gI2WUJxRhLF5dhZpZ/ptGP9zsN0zGuHg2stz2IGl1vFBF
         X0DiptYjoh/AnG9RIl62lV8DmhZwTpYs1EDxie+v0m7AJfyeCqQAzC3dkHfdMxtFzO9B
         ZZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389444; x=1770994244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q+kM/Pl8XWTSE9o2j4VB9J5wVR5uzUXKqDz9HEirBDc=;
        b=w6WPeCRfKmdkLSFRhGxF2ZoFcrbjZqVT2Fbw7UVxrDs7L7cgBolLvaY0fkiYntROUK
         YaUCOHEVCSxRQtgt1xgx4VraOdHSlu8055ZnXN7TJ6E/YXKWosx1LHHczNBQCxHRjlTW
         TF3D5Gl0nQHoa9FW2cyX7Voxg47tWC9rSLWODXhSr6hfXAKSTo93Ku01oLWHftHYK0AO
         jV8/vs+PzwQ1n0Rk+wjgC16Gwv3hzmiSuPqvibkSZXyoXEQH5ZV6hoKvasuGCBlSmZS9
         K+Xz0CZ6KwT84FnbbWSm2j9JqOJ+3hlIcvVn9gAoCSRo3dQwpXQjAubxxPtVshrg/IHu
         z6xA==
X-Forwarded-Encrypted: i=1; AJvYcCWg1LbG3x2NdgG7hF5OLyUVCqlEhRWrGhCwt2AlYZ2xu4XydpL80cfv2Y9smYNik1+vtro0yRYXIgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB03rk6JON4QjYd/oGS5nDOJ020D3CSGLgTY0mVyVJVnSBEadQ
	0+y7GwgldOWwHf2jEBo1zejVlknco2e5cBjUWdeF9XWl6GDdN2peAuVAzdct234Wo+z2ciCITH7
	T8uv8
X-Gm-Gg: AZuq6aK1ZwstwbSm2IyMkygnKbj4R16RfFbvdCWO+oH4SOh/ZyQ5s5Phj0pT7NtrUYp
	k7mF39Va7l8RLRyKKtbxhaPzqGf988LrTp+TOFBtqecmpsoT7xAkhTffwJDYFvQcEN3LTEFOdbd
	7HoK2GJ3QSNb0nplyJaXdPSL95o4yq8xW4Aj5eAYBUqLWmCIw4uX/hbxlfvTueBrIOmJzF4CAkr
	8dOk+9pZ8JvYFhVrcO9cxSXjYkzPX3G8u/uEMjmNy1IQkBxf3JKFH7yyxW5pQ4HQqP5N+aNMUiA
	eY6SWEbl/BLY5apxvMATjUQCOE7F0mJhdf6n5XUjn18hAZBjtSMGiRHcLKBuEk4Q9b1pksw2APg
	/24a5plvgiBIsrkiXcinVe8kVsl99oTLaBVTtgx8U4VvcS7HunPxjjAqf8vbR9kg+eA/bmhN4ow
	f2Dth34y88cvk2EgXZ58XFkCaLfjtQUanO
X-Received: by 2002:a05:600c:3b99:b0:480:5951:fc1e with SMTP id 5b1f17b1804b1-48320933765mr34387505e9.11.1770389443497;
        Fri, 06 Feb 2026 06:50:43 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832a38425asm3825805e9.7.2026.02.06.06.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:50:42 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 06 Feb 2026 15:50:32 +0100
Subject: [PATCH v3 4/9] pci: pwrctrl: generic: support for the
 UPD720201/UPD720202 USB 3.0 xHCI Host Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-4-5b79c5d61a03@linaro.org>
References: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org>
In-Reply-To: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=776;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=e8pzRN+C8ACMBcukIaiVpQzGH+euW8HR5vxtjI0f+Ds=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBphf+7ir4ISpN14JC2lFkd5iPKOaXwaAK5xCsLp3Pk
 G5J/0cuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaYX/uwAKCRB33NvayMhJ0TKfEA
 DKQnR6oFqniFA6PEyth+3Dc7qExlLqa+VF2sAijV0VEuuTMTxnXDypSlYF4CSJ4cDPJugF8+mPOBGW
 XLjrM877cNJjAHiQC4e9LRyQWDTWvYrUrLW3BLRC4atjlBhV9ieK34jI/RtA8KOGM9o71nTDtS4BdR
 bh5kUKeDJSCgsBjHm+L6FJmh+DFg+x5Zy8LLq8BYtlkIdm21kBNO4mu+eYj4u68XyFOYzMRq04HaCf
 sVGkHU3kXgpFEaH5yw/P/upacgAnT/i7Uks4SaCX0uQXr9jGX7l6SfWGgKCy3t/xCrwRZJ5Cw6xrSW
 0Nodq5PrNgVLBOMZwywXnx0g++LkFEwJNYmQcRXkLuXs/+Y7p2BvVkC1MZUiq08BuqOCt21rttX6eM
 Zla2Z8LfRe7WcO74dMsR6S0kFLvNRms9ysZ2VAOtRnlvHlZXl3Gq6fiHtIL+o5SydxYOFtm5FXeLZA
 ClMTYvr62dGPPocJL3Rfn8Kg1Mf3+NZmC0YUHBmrR2RwdK3Sv5Ww+OwcxCJwUjk2VjMW5NQlW3YcJ5
 gUQDoXw31/t0MTEmVVLA4QWOXOCYvf+CZTEeHupGH4W4zMCec39luZFGvkKCnIpEY4LaCBP/kSU/UE
 QuxoB9NX6Y9JqkTDaWvYPbDpiXBrWfj/4nM/EXH4c5rqm76+fl+ehWVsbpaw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable the generic pwrctrl driver to control the power of the
PCIe UPD720201/UPD720202 USB 3.0 xHCI Host Controller.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pci/pwrctrl/generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index 08e53243cdbd..4a57a631362f 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -73,6 +73,10 @@ static const struct of_device_id pci_pwrctrl_slot_of_match[] = {
 	{
 		.compatible = "pciclass,0604",
 	},
+	/* Renesas UPD720201/UPD720202 USB 3.0 xHCI Host Controller */
+	{
+		.compatible = "pci1912,0014",
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pci_pwrctrl_slot_of_match);

-- 
2.34.1

