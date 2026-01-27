Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706C33B6FB
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507873; cv=none; b=AjWZUrTaf+qPnURJm7UUraVScBdGoGRVuLopEiT0hsP5v410fs1gCYyGZvtWrIYK3bC63BM+DGx5q5GyzGuC0tBQMRZOpz94dOc+WxhGVCOmSf2B0k5VX3ctjzstwFvHP15sb5Byx7ZuuY53IYRATlHHfj8t7klxHC3pitTcgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507873; c=relaxed/simple;
	bh=gSbiWZ3nnwhx0HYBWb2dVDb/9iL5lwNnvS44cVKbvhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/Vh4iPs7HgNAIoZZDTHTk/cyPLMIedqGzAw6w0AqHBid2rFr9bssrqu8FKTW9ITiRpEFgo3wTGIKeKwu5ukjkc3IvJH+yDtsTOKMxiMdsdPe626tH5zLEK4/SoyifG2Dj0s2IjkyX4lw6DeqK/eqXPDWlrUyyC6A9nyTUq1woE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t2RuSAy3; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2RuSAy3"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so79742355e9.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 01:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769507869; x=1770112669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpvSM11iZ+VIl5UylAE730s9GzN2gw5t3lFduUFl6UQ=;
        b=t2RuSAy3K15j69TUhkNGVZl2RYSlDVL/TOOhVSqoW/NJO3GqYzu5B1zFk6qG8TLSzM
         VUkSlRJMtBVrVXu2JmHX8Zlq9ILqtmB5mDS2/cwemVYP2zbRHHaKCJPqXNkeeHdN44fl
         +qY/3e2MKrlanhHaUgaG9u8UTBqF1Yg5ZX/ZbXu8vUNx0XGwfImQYF/0Y1wKg+4rh3xM
         pD2GPLcVvTTKLFVXUFq/0ZkkKq7uX0CaFYht/FkKVhorHMZ6TLKDWmWIGju5vjpzWtCx
         kwwrQKQ5wdUjpsTUONeavcXIIjj4Wmt6xU827mLK6mwQdJgIOprb1VASq8ZD0c5mT+3B
         7d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769507869; x=1770112669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BpvSM11iZ+VIl5UylAE730s9GzN2gw5t3lFduUFl6UQ=;
        b=uyuio1bmeQrMOEwRqAFtJG0L0HJbWga6eZv3X1NJrZNwNI+4iCjJUOS+SYEPlAVGrN
         7nYlUwIn+AWNZiQNUoTyjhUX3syw+uBQ/lN03UmBAUHSQ6Vdy7wCpcIlXju/7WTe42S7
         2p3E1DlJbs7A9o1WZePJjs/uNySPOVn6cpBUVhwkHTbcxGonljYgwa1hKqfuwfK2FcOl
         FsW48KACSTPQgMpcOb3tm747eW5eqfKrlfj8cW6VWSiOA57t89vHhefHafGJZtGdkHxf
         T/G7Yjvy/JMxoZGbK5SdTJya1OzxYqp/wru0Y5DLAu4UJah1cBiYJ4K4eiWEz+5Ijtnb
         OKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV+C6Lx1BTKyE3DnoI9bm1qZbJKagW6MLDOdDFmhQy66ECAL3pxk80ptVTD+tN+EHXLG8llZ0jty8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73VVhqyRnSlNZLzxVFeXs8MWwfjuNlucNnJS+yEMSoHKNDUI7
	nCYcGboBQc6lnTGIhDZy8O7VEz1vfHTIq5r9nb1mbHnLHde0a0whgG4IIPZX/KEn0jo=
X-Gm-Gg: AZuq6aKijfGOpkZqgG2SjWmv+/j75BedgDcoHrppzYtbdLRc+P+tulrMwNLJXUj2M8O
	H8iS8hs/yQ7YsgEd3DeWYXnXQ34y5Dk99RzJzVYcWSL7Ki/G2u8nxE+xmAq0wpmpefdzGJ9n5Wj
	iE2eMNLS2sNvso1NNS/x3HmqjBIcA5bwrm/aBMtm9A4BfuGe/Q9FRhL7MBGetqq9a5e6QWFCUdG
	MzkMni2uprnDGZ/XZJV0Q+DGzRv5lK0mCUeHfVz9pCoZsOmR76DyKUGfDzgSuyTeXZaqZJNIL3g
	gjXWHJ9K4BddLhbmmOQYCExpyN5TQWXgBGi/AC+nqrL9PC+j/wUw7hKOQvBsRNje1jz3GQh4jEB
	pL7iLXSl1HrgQpLrBoUKHcQXRsGD1FyAdTBPI3zW6IKXthd6/P6IIYB6vtZiqrmvTcT2M2m2lx9
	8lHDlK+kne8fXSbz1rM42w5PRj92Sk/4Y=
X-Received: by 2002:a05:600c:8b26:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-48069c164d8mr13882815e9.7.1769507868824;
        Tue, 27 Jan 2026 01:57:48 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bf93cesm49056225e9.9.2026.01.27.01.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:57:48 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 27 Jan 2026 10:57:33 +0100
Subject: [PATCH v2 6/7] arm64: dts: qcom: sm8650: Add sound DAI prefix for
 DP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-6-c55ec1b5d8bf@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=783;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gSbiWZ3nnwhx0HYBWb2dVDb/9iL5lwNnvS44cVKbvhY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpeIwUQjm7QH1p8rQRVenNqQ0wOOWP6xu0215VvBsl
 7jSVnguJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaXiMFAAKCRB33NvayMhJ0fKYEA
 DKjj+Z8YzdOvfOnzStvABIT7k4x4isAu30Z5CXb+Mvz29hh03cTeG7wTRJH565eZRDWPoHI6hlsk+O
 lghQtth1j1Bj9A6xh4ECqzUHAiG0TQjV7q5fUMkW8SzWm26L1+5CGPtVcm87qS3Yen0b+5tvYvgxz6
 TTEgeEYgtRwcHdadkjNJ5G0JqU14qQjbBe5SuUL1vBl+ZDk9Qv1kCm91KFO6Gn/g/CuQ6QDgrGx7Fq
 mJgLoa5rQgtu/Y1NwpO3isuBN/rJQ591y6uAhIIeeB0Ho6nONRW9w6FCp5ov06tnHm86iQ4AHaPs/t
 L618s3sK3FI+ATlXqBeL4YEezrCQrNJp4jrDOwCzuuS+m/VA2+kua1owqZZJE/kb2HapTJuOQ33/Uv
 9VjRaS1Qei63ln293HLt10bstkYS24I+dIJSPDUVM7O3GZOPswnUGaMcdXorpGME0zWJsQ72lkpeQ8
 oW7/+EdpozmLT9C+2KvgvBFX6Qk2tPU31WH+mCLLJ6l0cz8QgRYSEgJVuiAKVtZeeWif1IuCWFEBA/
 YC9wa0qsGXDhQAhu/iuSBZ0STVVAUOEL3HDtOKj6mLoJZIzhlbX9ST0yC6b+WT2Tr7oP3k74sff++m
 /XygLVHFHkC5UgxtwsQ1BypETfBo+w+LJx4oldHPIS4V/P464LimH/eMgrnA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Sound DAI devices exposing same set of mixers, e.g. each DisplayPort
controller, need to add dedicated prefix for these mixers to avoid
conflicts and to allow ALSA to properly configure given instance.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index ec79ba904f5d..db769baf4d58 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5721,6 +5721,7 @@ mdss_dp0: displayport-controller@af54000 {
 				phy-names = "dp";
 
 				#sound-dai-cells = <0>;
+				sound-name-prefix = "DisplayPort0";
 
 				status = "disabled";
 

-- 
2.34.1

