Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA09315D21
	for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251724; cv=none; b=IyGdbhjd+Wnj6ifuruzQAg+HuwX3+0NHXrll5B/kH5ZmaG/6/cQ5BiglMobo9Dv2L7h/fPRD9/qygO6vnbaSG/F/uCVjvfgy16i84y1r/zay9KyNMSIvzXC51YpiteKSdhIfkSFWaWh2RxFFO9PyoSHEwyPq+DMqFeyhtiolqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251724; c=relaxed/simple;
	bh=UhlMaTJRZ9fLa8E4fuLuIg9nXiWgxX4wZpZOm+FPpVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pp/EuRDkgwLeaB3mChZd4HU68W71SwaB/Ls60ya8/6VdXau72p0DLwF15rGuTkpZOHfrwEzrAmNa5iEfLpvfrgA2zbjGoJpkHZ9YRiZa/eaIWzs4jnxRLCljlQmi0unEXr66Sf8oNnTJ9UeE7owDUTkKp3Wnwn6OYMZPCKZrRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sBiGe49+; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBiGe49+"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48372efa020so22510625e9.2
        for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 06:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771251720; x=1771856520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZLm3gI01t7k0CB1F3RPdej8cy0OV8XKyJkxMLlBgyY=;
        b=sBiGe49+ave/J770/xqZErlE21w1AAbRIMIz+1A6BaCdPGoZUKEd44oQo0hrTLle2z
         QTBNyEqv5a9QvDParNDwaKj6HX6WBhMbK/NlflvndYyDFmPBCeiwgl+Oj1Sg4ytJnL8T
         ToWGTkbGr24iooiAm2zT3XduLu48E3KIEtLQYWaWvPk04df9xVMd1KzuLvsMMTnaFcO6
         pohT4l8MX88oAkfDLlU8e4GMu3V4xvf4TL7v9NkcKAzof97HBfbWX4jblGth9LX+Lm6N
         /ltP+g1RNa4S4ZMCT8eIFt7su7aH5YwopBy22MMOmhwxngjQNSI5EyFQIhJY6QVvUF4W
         vAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771251720; x=1771856520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lZLm3gI01t7k0CB1F3RPdej8cy0OV8XKyJkxMLlBgyY=;
        b=vd0CV9MJ5FMyw7JZWFc6HMy7T67WdEFQVlMlEUPN4frYszDT55kxonNo/yHbBq/JzF
         MLeLukerAUHOOze1igHbhUEz33rkd5w5tuD9y7bqIkzBLdUVC1U9BppdN3BhaiQYIQ6X
         J+HOJf5VRgVDRtbbBkk6+eU/dGebOPQJGP2nnqh2E65QciJjNEJ0aNV7SMdPi5eynikg
         MyU50t9V0oU3k3aBAYRhviUXtKsF/BCF93xoV5TIlSyFhi1QnFSY/w27xd1txNwiX902
         7P8d2Rn/3oCfCc//+gvTXVU+51zNLdeWaiVoIl3tvrbF/EwCGEmRbFcXm15GffkoK0uE
         EKaw==
X-Forwarded-Encrypted: i=1; AJvYcCUMv517dTT09WHHjCXdzJi3UsS0IWdufH35LT+6QxKVxV90aNc99rD25BoRqjCnhz/fcIqn+L+/43U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZamBZcRhacd7rMwGHJtDY15Hp+QK86+5PMFXpuuoIDGHy3mHh
	cpBR7Xl3TU4Dcph66l4zD3lhXJL+lDHavO+QggqLusrEeMSR278X6BZrAK+hCIeG7xNDNrwcCdZ
	mIrL490xitQ==
X-Gm-Gg: AZuq6aJ5VXSaetE1lbeO5oMIAneDvdMmUb5AKlQ+VHOqWdj5Cfrq0Nbw+GvAS3pYf/F
	nA3fLTkl260E46OeQDevJloYjseayxL4YGYEKtRb6x7szp3Da+2bpxyup7niz5C/00JIwsBnB4O
	HvjRfA9gTaRAfozeSf18SioNYA+rE0viLJze7HXWNHx/erAJcXsZECFBj1r1lSuAYiLTcTp4JCs
	L4gxUeRAnFySu+Xhvf/UrjEKGUMx+Nf4ETxt2ZqXJM3bAyLVT+nqNiyCTMdmJbsb8GI1mxswaR/
	ljyxCMgSJlqMxSuydn9l42eRw5a1nPjDM47sdsBKLq11ScdgBXhWpy+e0ZBZnTcORI3JyTxmDfI
	jTjXLtAju27/pHwNOF+lItXu7h8dB5F9NFs2kSGwD8EKWnVIcUtPhEyN1O/tH19asFXZOdaUreq
	6v9NQIkegSKx3KSJ3WUW5SCXsStCYJw/85sKLwxvuyEQFg
X-Received: by 2002:a05:600c:4443:b0:47e:e20e:bbb0 with SMTP id 5b1f17b1804b1-48379bac837mr120118635e9.6.1771251720343;
        Mon, 16 Feb 2026 06:22:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a63afesm86717475e9.9.2026.02.16.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 06:22:00 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Feb 2026 15:21:52 +0100
Subject: [PATCH v4 8/9] arm64: dts: qcom: sm8650: Add sound DAI prefix for
 DP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-8-802c82795431@linaro.org>
References: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-0-802c82795431@linaro.org>
In-Reply-To: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-0-802c82795431@linaro.org>
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
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=911;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UhlMaTJRZ9fLa8E4fuLuIg9nXiWgxX4wZpZOm+FPpVM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpkyf9alGreRCevIfARG+2CS9U8xFI01sSnnbt6Rp1
 YgyKjEaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZMn/QAKCRB33NvayMhJ0RQlD/
 9gdGpMW7udNzorRnTxGVQNi958K60kf4eU7jNVk20JU4e7AVB4PsaOKCXsfanOkeZYJ+nUgfWUjco/
 Qr0awa7jK/DDIL4dXPwLe5qj3EVuescmxg1h1kAqnemmT4jV3jbVSu64PVBNZsHfA47XqqEL87TQQL
 pj1LicLl/T57H2OrcCSDv7/bbjF88QrKYzuQe24NLnFwD+O6IB0U0h79WewAwFflB/QpcDHunbCmzs
 nO2Lb+0MO3FyzSU1gYrJ6Icq3j96NX5Qpj3Naz/IX0HRjMLe6XVBeNKUK+ITUJMrArYD0Z4JAeg4Ou
 pEbIcqy3wvcEkAneC3bttfApzibxoC9PhGo1t8ymc7BUhg30O0HZWCM2f6PcpogGCAy8wjJ0L1hGfu
 XJdYtl3nQUaNC0ru52M05CgrDob8zP8P6hQve3tOGCEAYLAlN4CqrxvGKeAFefCURPdRYg/Mb/QOw4
 b5kH8xri5gJcyIjHvx5nopRX2dVuWXo3GFIVFMFAELSUUl2btqdR5gmNHMvTcuQGTVHQZbOGp6yToo
 C1DlwEE3V1CXevh44itIBML+WU0DFAdHb5n3p+ivIXsTLUpgeqW8Jg7voMkkj89cfjMjPHWS/M2OTq
 TUDRWJQzlzLhf5qoptusI69N4gCBrcEivzgBHobOGluV13Sq1/1vVDATqv4g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Sound DAI devices exposing same set of mixers, e.g. each DisplayPort
controller, need to add dedicated prefix for these mixers to avoid
conflicts and to allow ALSA to properly configure given instance.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index a7a06f78e564..6098d6201002 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5773,6 +5773,7 @@ mdss_dp0: displayport-controller@af54000 {
 				phy-names = "dp";
 
 				#sound-dai-cells = <0>;
+				sound-name-prefix = "DisplayPort0";
 
 				status = "disabled";
 

-- 
2.34.1

