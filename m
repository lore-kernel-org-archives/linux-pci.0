Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18555314B72
	for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251723; cv=none; b=Ej975ZPM7AeqJQ0QRUE6heEjVsm/Gf2JpuusNrfzZUNUWY6WFz7wSislVEGlBXKEePTdSKyISNlIc0t4nxu7j4lJTkDxzmSxFBdxUU7gvbiPr3OHot+QMnOjLdSl//ZkL+EXzf/rsw4i7z7TavBV+Kr4i4WcXJ5hUzjiCrb+X6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251723; c=relaxed/simple;
	bh=wzWHHqFMOwki+0X8S01dS5VUbfyqYroFprJPuDT0N74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQDUpLLCrkL0RvCIPZiPDBfbr+NC7mcL4h6Jq4ykxJ9fWOQ4mt/HZDNulcyT0V7XMf8tXm0JtNuWCbJzBYJ86R/B/icijxzs5OwhPxqYRjzd2tCZs5e3ObEYPrQ0uo2iKJDKfl6IV/I4UOEeeKlQlG4cD6ZUqotWeGB4h85czoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pl2H5BtN; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pl2H5BtN"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4837907f535so20263425e9.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 06:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771251719; x=1771856519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ozn5QNaVTZM6XCflZx+XTaaAus+wNSTWM/r0WiJJYgM=;
        b=pl2H5BtNjCdKkuTHzrRNdNcFFs5M0p+NwL7fMu9Cd7ob4Jt2bO0h146vznVMhAx+9i
         ozzG9sVR3SUAeNqQIPvrlgQbWfROhklISoLo1PhIwpeyg2dcRM5LHFmx4zk+qQCk61i9
         Pj8rIEvu6PWJkgPc7Gb9yhEg30poFh+XDNM9yEkdCL7oGzhZhS/FpDI5y8YwYfgLJ6mK
         /hsBzCYR2VVy8dq1Zkif/SSXRmD0Za/yJOBIhbb5GySKt9uw9b4KgK7v983TodQ+ZTjy
         jAjhFQVBE7zf5kCYMnje+w416uHmDUjm5cXYtCLvV/ZFyFxvhqlGXyWEdzPiBy6WNRfX
         RQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771251719; x=1771856519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ozn5QNaVTZM6XCflZx+XTaaAus+wNSTWM/r0WiJJYgM=;
        b=X8q1O6WiEEA2BV/T5AZhO/MvWDby4nNQ44MWvzfYUFIZ6pd9/U/smpN618JIuF9/Iv
         2JWeZO5j1KG0KR9wz4w0V6NZpcX1xwlu6dSiFE/jAC23I/sUhF7nNF9jP6btUfGYArsR
         517o2Tzi8Ab+0P7an6AizIWag06G+PmhLdD5xTJNPk9r6J9GQlDWlBe7U3RDGV8Tv4tF
         NadELAlSxXjjNm4eUOGTLPQJkwrHXt9/4aeiY45EAXBlzzIeaGj2m7j3E/cL1+f1iQFV
         dXwQtvA0YzWexfUBAHnGhlSS7/yIFSB2sHZl1jvrDtAY7CX6GsAX09BOSjjZtoJBoXhy
         zoQA==
X-Forwarded-Encrypted: i=1; AJvYcCWvsO5LD3ImPIsf9x+Lan/ThnIbi1Ve4chY2ZgM9SrApYqMRxfTU7ylQ+TJAKiMPyHMDBdsvoY2U44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGIIRQe1KAN3/mmDdKX147juiA1L+dGQsNln5m0BPblwDsvNq
	W2YEC2JQvEcoC3xDZngLLxcPyAME4S5DwhaMkANOYzFE+7LOOJIqtlAfGdF8ynmJUU0=
X-Gm-Gg: AZuq6aJ8djuPGTu7EydaARaOT41/QxJtzlFMYU6IStAjegYtv2My6ol1+o+PKC5Cfp9
	3PpY90L1ynUmOOCtPrJ9GZswggYEDlMfxGJI3fr8h21UfacxqPPhxospKFhdB7LByVNTU9cn6GO
	oFn0S8X4vjDCqEjGP4B3LPJrt3blUp9818Wj9ou9xmd6Xl3tMA6yti3El5gbYAPWBpbXzc07+ie
	MJ6SHq0LDnz1ciXTiHhNzXOx793lMQNvLIw8MkeVG8ooTEP6HPEcQQfvD5PctKRpFwoHhGYSw+5
	7sz8tWtfKG3/hOeCqK8v5w8POX6a6RpssO01e0HPD0ZNU0FOTfCzgFaAGoNZCNvyk8cmemk8nTA
	YTFVMX2K77lO7uU7T7vrX/IdJdoAhZfQVsdG1y+yG4GXsZQdpKX3QwsVfsgA4QRMZAGU50PQbX+
	SzkIcsbRuW2gHPb7G3skMT8YExInyUSZzMpx2kmg/x/AgR
X-Received: by 2002:a05:600c:8b6f:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-48379bd7409mr134905455e9.18.1771251719284;
        Mon, 16 Feb 2026 06:21:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a63afesm86717475e9.9.2026.02.16.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 06:21:58 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Feb 2026 15:21:51 +0100
Subject: [PATCH v4 7/9] dt-bindings: arm: qcom: document the Ayaneo Pocket
 S2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-7-802c82795431@linaro.org>
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
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wzWHHqFMOwki+0X8S01dS5VUbfyqYroFprJPuDT0N74=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpkyf9k+Jy6GRZo1zmAOB5SAs+yaAqzjE4dfCT/rV2
 H+74vgCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaZMn/QAKCRB33NvayMhJ0aRED/
 9qcigV9CR4KoMFZebkcugIVeXtG/26ZOsDPBZSwz0Uy7JoOR2O+iiMp5lqmxWWR/4BhKPaXIPHd1zI
 KyEAhSWoMFfMU8nt2XbOu7DVfnZCqVDWhWU56Rsmb5SbhbGCQRy3hr/5QeioJaXew/iNVL1JVDvtHH
 pkabNFqkjy7dlaJQMvEtwTNMjexyVOVonhuc+kxNV3giL36DhT4Rn+rqi9g7jlGGtXvAE2UtWXKO3c
 HOuQLSJBMdnB36gzP8WzSceZWciF5fiUMVmvjIueUcHrtjuTw7J5r0ogJdf4/1b3ShTVXexwhGWoUL
 OnFFWUAS2gkMo//oNalAGOBYLTAxkhyIZz2FZBQS/cVvyWQCP2b1hqXoIoiNLg2eltEfDW8/4Y/yfN
 gUg+1y4d6nlL5OwKAXBeGzdRBXprgio89lv9GpFDq9udEg1Ica8BQd/0SNLhT/bL8Jx3x6qEBeXTK7
 JvnhbbzOr/kJi25irV8HguuNThT2wqcE90kSak9kwP9Qrl4FtqQO+j8l8iXZM4NI7zEvWdFW/i3NQe
 JUIALrcV36nbC6ak2P0K1uU/TAr9tluIhvrevPp9hGuc4NzrNcNfs/6rToILnnRDRAoNVIAGgRpfU+
 InRO35gpYcg1wV6eUH3h/t3A1URJg+UAlo1j/KaE1tusNSMtUsaPttkBYmJg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Qualcomm SM8650 based Ayaneo Pocket S2 gaming console.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d84bd3bca201..351cc2eff14a 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1042,6 +1042,7 @@ properties:
 
       - items:
           - enum:
+              - ayaneo,pocket-s2
               - qcom,sm8650-hdk
               - qcom,sm8650-mtp
               - qcom,sm8650-qrd

-- 
2.34.1

