Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F234F251
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599898; cv=none; b=Ghlm+w9leLGXNAdFDYJ9ToP+FcdDXdF33jTYV0jQBWK5RCeT1JhytDFSr7DV5bPTOFDgd34XbVUsfAYj0WK0rm1Za+2LLRpmvIskXHX8FO5YXTeDDnC/6dIA1fn6aQU6kT9bFKO7hi4C7ggtbc7q/lhnx90XSvVNMekSoq9Cq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599898; c=relaxed/simple;
	bh=ucacCxa/mj+2F+aX6+B50wEhYPy32LXUflgKJU4wTxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jb5FUkXyK07EUO9gfXXlauI1Rqbrt/fOTbczjRxDqGZmMlGofmwCQ2dXkHNFfn9JyXkdRNZYdWUUrUnrLNbCd43bJBqkhBAUEiVCsrPIqshuw8atSTawFuey1f3dpVwCScNuo7YTLJ8PObr7+fRaZQUz4TVa+ewtmoWa2w5/XB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=alkGBNM2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alkGBNM2"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso18776795e9.2
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771599894; x=1772204694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dv+SXo/Sv4fvOm9Bdd13zyWuAiiFrpYo+dzeHabNNsc=;
        b=alkGBNM2yctjUTP2a66q6aRLUKLQHmVZ9AMGL2EXkkFAU4WbcZdOSitvQ1bY4ao9+3
         VE45VQM8NkZhTGhkUhmsyC2e+aSb8qcW0hT6UznmsPWbqYjC5Iaxr4gDnqvGys+iqDQh
         lVXord/hj1IiK+3tZiWTw9ZpjyfjLKI1nnlN2+aXdDmCAPhxoULL+4hl43/xJ2mEAPUk
         n+UTAbv94OTmG/kMvEjJwAynprI2XCBJyIIWrx7ky+6/nejeu0ER9snf0YltV0NDPsi2
         5GSuiQgL5T3Gn8ElUFg8ftxEjwCHnnaTbNw3w46cV+VqdSSuJ0em1ZoGCJsLGZW7WUom
         WfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771599894; x=1772204694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dv+SXo/Sv4fvOm9Bdd13zyWuAiiFrpYo+dzeHabNNsc=;
        b=Vsh2tVHcWIsDqsTc2MBLSWmMb8ZGuawUqUSeApr2fOr+/CNIYqkg/CB2s01qoJr3Rg
         04x/pm4Dly43nxdnck271S5ukby24aLQk62z6LK9PtToTl/mFotrzG3muIU+Wq87r7JZ
         gRRoZVEHUgdsI+KRAT3K4MWw+7MP77VC1utxy+UIBJFzW5IQ7SDTk6P/PKZDlCW5FCEj
         BLhO4FuHlVMoZ1oA/viXswST9R61ceB2xv+KV1P2Tp7Jkc/tQmycWVFpVfw5AUb5Dh6b
         AEYXsIy1vrfAdWuSHZp4p/ryBRsyFy7M6xQ3zRXk52fK2wKF2ZLE4ucekP4hFw4SwWAJ
         1Ufg==
X-Forwarded-Encrypted: i=1; AJvYcCVe/NEaZ2bFPpr6Y8SlvYakrgXY2AwajIDHaWhNP3zrWwhlHrjZ+28FTySzaptRM/IodA9DFq4b5DU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DuWZrgZuIAmrKa4wEhId3bM2zrBqPIBG2UJ5sFU+iDLayFyt
	131h8GaD9X7or+SvUGfgFaU3pZrq9/DQYqd3kOrKaRaUEngDsl3APaYyEE0Uh8/OvEs=
X-Gm-Gg: AZuq6aKdWEb5GJN3X24nxrWdi2O8cNjfSqhYF/ZmuUy3VarF7fw/y2qHHp809CmObbM
	LwyC7mazdN/QIzSOcWDQlc7KuM5dckwjhpDosTo8ufkOwk5Nqf4pRk8w3UBNUaObMhzFbVkc7kU
	mKBGtLcB9RNwSHG+lumRESUoTBrHzAxYtizwO+OWOwIkKcTcpNmTHwx8Q0pmxW/ILaKoUu+WFzy
	2YPMmu4UrXA7OWdftboKx6yNp/I5IfnFEdueUIbHjzPDjEI8wmOAyLH7qbdBFyxf1BW2UJ0Z+Qt
	bVBErWE+G6DYDSzezJDSx0ZgYf9x/2hqNxjNkMqqx0oT0ZnxbRkiFnaxLF4qadCSqGSK9LBwqdf
	zsqbcpuiFs8oJxJT8O4T22bHxGpzo++kjjohMq6S3BQczc1/frZOZ3dOXmVBKYD3tkNEBPm/vyW
	kwAr6qiJmIUk/WiD93h0QwyyCusWZ3j5fbJBqgi9hDDcCh
X-Received: by 2002:a05:600c:3f0a:b0:480:52fd:d2e4 with SMTP id 5b1f17b1804b1-483a52b2e32mr41598565e9.0.1771599893489;
        Fri, 20 Feb 2026 07:04:53 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm122064505e9.8.2026.02.20.07.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:04:52 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Feb 2026 16:04:44 +0100
Subject: [PATCH v5 5/9] arm64: defconfig: enable pci-pwrctrl-generic as
 module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-5-1ad79caa1efa@linaro.org>
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
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=786;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ucacCxa/mj+2F+aX6+B50wEhYPy32LXUflgKJU4wTxY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpmHgMWIfn4SgSHhWQnnkQkpLCpCCiDb2cJXWObnzN
 iW+G1ySJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZh4DAAKCRB33NvayMhJ0ZYeD/
 4mc6uejEUp9T+4+gG8RCsrT1Aa+N6h+H9ToFhbv8hKKYE2EIUPxVsfwFjc23XbA+Vny8t0VzRjLf32
 UvrTK6j2Va2XQW1aeaAHWkdWtNwCTU04fmMCyjmSvpExDUtZzQsCTCw8dNekvR+k4wQ9K1aC1bToCm
 qO/RfuveNUaLtUJKg+ZhNLzaAdSeqzSi6Bkg8+fY9ZpM3Z9goQBHMSaU02N/Xs8yweVPG64rbCYTV3
 pXV+uWbS6wKQ9l7JycKlUr/DkaXMaktIM+1v1KRRqrxUNrdmbbxgsH0UsEdNAf4qTb5yeFfFh9sApR
 zvSoIFbIdKbEJipTic08Qs66lYs6VTIr1FwKXBY8PDpepu257raCvWluryVBRLWqucprYiZ9l9XIeQ
 zjJAgTzLjKWbYTIYizKHzj+Qu+/0L6f7AxQTrq1xHalrmaZUQlaZ8BV+iu8MOPqC1/zWF0zHaQALPp
 c3cc6LKX7iXtuhIp7n8FETP1pxzn2pb1WCHtMvfjMS7Ty4NOVCb/IRraj2utZdW5Zbh9fMEtIv2Lku
 L/zSKVHXzVvDZVJ8lHo0axAqmrqlgvZUkoNpHdXqrQOxfGyPkE6HSYJFzAHAYGeZOu2QBRPY8S6LqL
 whv9Vz3NSaMt8HAT8DntqEy/ZEIdLy3lN8C779VndPbl+w7q/EqNkklsP0aQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Enable the generic power control driver module since it's required
to power up the PCIe USB3 controller found on the Ayaneo Pocket S2
gaming console.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b67d5b1fc45b..0e8b62ffa7db 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -258,6 +258,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
+CONFIG_PCI_PWRCTRL_GENERIC=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y

-- 
2.34.1

