Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BCC34DB57
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599893; cv=none; b=E5M7VYGCucYfrnvtSusujY/oM9HgX4K3xoJemNJ5JOnOBx+rvg8orrnMSpjplEO5v8UVNmkuiFUUVTuF4QxgeU/dZHnayBDYUKmgCAmjRJptCnsYNhh+aiw2sfGkMxk3tdleFtKMHqy1VMIeSHPRPdyEy1jwjRPS9sStqxCZuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599893; c=relaxed/simple;
	bh=LSJ6iVt1fKqUBE+D4hO2jHttM0Mg6l5uyfncK8nFUsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLjENDIo8OQze9mG+H22zMhs3nXcOaIzQkkzrPhJh5eXl9UJIWpSBQeSkf3Mr97ebQPaS2zZLIp0L97qcDO5WmLm3qN9iO+PXilYZ+EjfwbXhZysbPS8TN6DpTg7zONHkdzwcxQCH7YESc/GQzZFc1C2jVRZ0Ws+EyR2LdXUiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vaY3bOWv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vaY3bOWv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so20630985e9.2
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 07:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771599890; x=1772204690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rodd3MUSh6tvMD3m/O9jejBF/2t7v6lgidsmMLGv4EQ=;
        b=vaY3bOWvB8wfenM1n/uiGN6jYBQB+v/2Vw6aUutuHsP7o2gnVdyCgbUjaxVDA/AqN1
         THOf8YafjiuZhxotDgo9THQPaW76zX3xcOK5MTCIIppuz3HTWqJ2L2649vVSJdX8rgQZ
         wW6LyTMcwhqZriR+JvKxktSAqZOHWi1JplGh5NXIr3HuWBBVoWOhhr3abXznBbvzRpsZ
         2IhFu7NGsXtaabNy8w7eYDDPa3E+hdYgVKQsYfX5AMo2yriKQpx+L8VfVEiZSsDvamtU
         abIDs+wmE9Mp/ljWp8djG0S8qFcFeg4b76en8cOL0IAkf+bnsbm5NRR0OlOQwP8P78Z6
         Kp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771599890; x=1772204690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rodd3MUSh6tvMD3m/O9jejBF/2t7v6lgidsmMLGv4EQ=;
        b=YcFZhoYwT6cJzNM50EXM6sPJm6oRrjqDTIsD+v4a28Rr3weLhQR1DzHx6jJwzm9WiP
         QwWfsnxdejLu4ZUKt0z/ss4pqVNH19NWvlX2RXidP+4zVJ+20Q7jayLL9nFjbJ2cpfPs
         j1xR97C8OARefINiKN9USXfEXOAWWpA6v6jDJkb4wx8lZGgrPdQE/hQiciFNjqBTKGcK
         KyKEe4a5UmqmuNkjrxOgowgSdKIkwstkb9SNuGv+YdlxOMnhxka36J40ryXA2IZPOmt5
         piT1kAzcRCatD5VOEtQC/S8MtjSmJJiFfdOwpqgJt08xkzUckaknZF+EOBvoLNtpZzCz
         jaSA==
X-Forwarded-Encrypted: i=1; AJvYcCUjxLazQsMUnKV/e0G7/vdbbFGl8YNNEb5nuDyRKNvmfaLMfb3PRSbByXMLbX4rrWT2+glFRpBxMMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYl5dEnsGjSIjDokM0Xi3FD4/mbmxQK9f4HyagcbW/VFuXLWjQ
	7JUItj/B4PIAwx6jjGQYbEnnMywwccLAxSK+Vyk67qS3IukKc5Li6QBqD4T1MTDrVEA=
X-Gm-Gg: AZuq6aKfvDwOTcdoEqPM4blxpAjU3Xur2q0d+riI5/JYiafhGP9ekO/+N5wwL1Rpag9
	bKGgNduls1Mv5FvnncHyAUvFElvuIR+Obeq874PplHnzKiYo2t8oHAdla5E2BhpehTELyXAYw1U
	GsP6a9VZzjXfZmfDr2dtqRaiZD8Ntof4lNeOAU1pTL8OUPhM0MCVpa1hxl5Otf6ozHYgLYn6It3
	hgiF3k7eFbmwrl39+mvaRy+sCp6C5V37WrwMAlNZ3fpN6verT03lakDyweJlmGdq7EgHDKckX+V
	UIIxlhZIAc1Vs5Lz7El/84bMDsWZU06cLl6vnMTpexKF17w9H/Xy6ESVQ98pY/rmOEWEjNGwkGM
	mgP15yanPK/gt77BN4WCuoBTxhpBpqvOmeDNREVlUQfHoPFyDLLK+xO2HTtJUetFyAXltqMZjmb
	nsdGBZzRa8od93Zm8l/9DHNedJnT5PMWRX3VbCVb47414D
X-Received: by 2002:a05:600c:1e24:b0:483:a21:774c with SMTP id 5b1f17b1804b1-4839e668a55mr114317005e9.25.1771599890008;
        Fri, 20 Feb 2026 07:04:50 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm122064505e9.8.2026.02.20.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:04:49 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Feb 2026 16:04:41 +0100
Subject: [PATCH v5 2/9] pci: pwrctrl: slot: fix dev_err_probe() usage
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-2-1ad79caa1efa@linaro.org>
References: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
In-Reply-To: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LSJ6iVt1fKqUBE+D4hO2jHttM0Mg6l5uyfncK8nFUsY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpmHgLvAqgpyS3WqEtzwpidrWJupURRMxHHCbYRiCH
 s2cHeQGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZh4CwAKCRB33NvayMhJ0VnvD/
 9JxYCAzcI+M+RYnaW+fQ5gm0DcADfB4wSW/ncXdOTNzw9LTvMkqbhtK/7qp6IsesiNZUWpif2ZiEH2
 sD0fr3RdWo6TI9uUGAsICG/mc+tHB7Gh/cp1PxprLrUhMhp3pXVcTkDF3qoZkDmK4TYEzV4I75VKci
 N+/dXI4qgpOF5T3LMvCbX7fREmTfv/rF/f3D7UrEYqaH36oer49SaEoylq0qVPnwCZzeTLjKhyP6RW
 yoYjWDKEeSF/Kf6uM2K7SAFwio4KNXa+3GI2q+d4IhFk8rG2lrVaka4OGbCRFrUZQ5X4STcq55P+4v
 gHB7ieWqafW4DQ4wd7vQT/sJvSuWk9CnYjEYcCsgR0rb9jVh5ThwVQJrERNkmOGOxwzP7hssqBqDAE
 r3i252QykXNG2nMtKhk0+4LbIecm+vxLaccSD00waLDeeoIlN/avkIvJpnQdL1pkzyKySq6UEQqrrk
 SmQYoxPeSo7mVZrSdUS88t2HudZGcHtvmL/+LMXiNExUbtecw/na81wuyhIhgCwrwfoMXED+NzNUa7
 FSnOdRPJCjd51v5reoU6dOzC2aUDV5KFeVM8EGvMeiA6B6M+6LM79Wt0/iIfEwRlHtiwfZ+occGxe2
 E09RHwUZpi8mZQ4Ju4EpL/GnLuHGdrlZFz8FyiXUabhd06ixIwXQeLHQs5yQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The code was not returning dev_err_probe() but dev_err_probe()
returns the error code, so simplify the code.

Suggested-by: Bartosz Golaszewski <brgl@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pci/pwrctrl/slot.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 082af81efe25..f03debabbc73 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -88,18 +88,15 @@ static int slot_pwrctrl_probe(struct platform_device *pdev)
 
 	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
 					&slot->supplies);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to get slot regulators\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get slot regulators\n");
 
 	slot->num_supplies = ret;
 
 	slot->clk = devm_clk_get_optional(dev, NULL);
-	if (IS_ERR(slot->clk)) {
+	if (IS_ERR(slot->clk))
 		return dev_err_probe(dev, PTR_ERR(slot->clk),
 				     "Failed to enable slot clock\n");
-	}
 
 skip_resources:
 	slot->pwrctrl.power_on = slot_pwrctrl_power_on;

-- 
2.34.1

