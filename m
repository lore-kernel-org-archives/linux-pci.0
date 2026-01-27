Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A342E33AD98
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507871; cv=none; b=Ix4kolxVUxDwCPTEgo1WFDJGvlTL3UKEsc0KTzyTeZbbWFrONgGJPJLfXODblaOgP030VR+MJ/hxWi8TwpUCNiQAP3zdse2ucAixwXNQl4nctDp737xiB7MaXPevyTkZpTScfetI6tDej0vM055xMuF1J9F1dAYsj+Vzfd6ApsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507871; c=relaxed/simple;
	bh=pirzvUMS8i50SX74B9DHasjEK/A+JFKmccu8rvH6JXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rfzj/4mWoPxi6vd4gKh6si+2ivmRQelbiydBJ0Dzug3QiKJ/mS6p0XOIgrYQddngACLUVP4cWUhxlX2UT1WbHxWULt9XETn4V0GeRJ4OlxF0754WRbHsHR0JrxVReLQBA+PJYc4NRGcg+TIDwZuQMTjp21im8Hjcxc1Vc2MEvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DVJ4L/G9; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVJ4L/G9"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso28824135e9.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 01:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769507868; x=1770112668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/72d5PFTHkT60QbelpzW/GReN1mxIpLMWRlkdIN95Hk=;
        b=DVJ4L/G9jNhAiDu8bQG12PnQqDrAVD7z2J0rEBczEt+Ax1Miyo2b8Y2Pl3imp9MsiH
         6AUdJVd23Syw1UxP4Amrnghve4056g8QKM75MyUor3WFQX0Diof06Quksi110n4/Kxls
         qxAuGmhvhCqR/DUU9mBYtVeu4XwEJo6wuOw0gnTssNleLPnB0mOkRFEuIQsJ8duTLf5O
         XhwBEu5uZmiuJj57YTPows1Wko3vrHDgsXMt1yPBwPO1TYOuOTlu2TA4dgfiCQ1PPOUh
         46iYQ5Pr0gHAbHjUFoggBkS6i64B8I0O8FbNSGfsOR8oHDq2Az6CUq3Ij4IDbsNYL1Jy
         ELsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769507868; x=1770112668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/72d5PFTHkT60QbelpzW/GReN1mxIpLMWRlkdIN95Hk=;
        b=DMUQfn83daEYX7uZU0kLa3uibvJvpv6I9DkbLDwFLFKTz0CkbyrlMQ8fbciTtPhMiT
         KJT+78gbPIqkPoV/iuK2ifj0OR0Yste8ubq0iA+NHvQXB4C3PhuByoHggbhjt9Kl0nj1
         9c94gf5c1fV40VYFZoq3Ld2Tx3ivLN05GAqk+X5szhSsDawTUiLQXtwgCnoDTArMrPUJ
         AfW9KX4j+ueLHLlXQr1h8JXB3zQlf9wCPem3FjLydJqZKlbtrdLF3eVMse4lNTtWyue0
         10hH5+0z2fVB+oGlwjy8tzjPR3NitGtel97NMwVrgMAxfuqvAK3e73+OYS37y2TniJdz
         +OGw==
X-Forwarded-Encrypted: i=1; AJvYcCUMjmviF1QJdTea7LUcd21Q3buQ+QXiUAtJOqEzRGNEC3PE0KFVkNaqHE/+XB+Tcrx/wuvs7MNtMD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzGaqh0m4CvWnCu/17lbjowcAn6UoUHwCbqphPtmg17bJVzYeI
	Hqv3mmWI4VquUzlxVdPoR53mAnWUmunhVnws91hpxrYgsP/BMwGdVRoODkXbLReedpk=
X-Gm-Gg: AZuq6aKl4DYHQjKWnmdF3M4t/AduaNuLSVpcB7KBnj4z21eQEEXc7dhBkugbtO8NPNl
	5+fgPi0646ep/Du/C/Lc1auPuzDJqSd5hfOOice7Bxk9SlbBYe/py07zBnsN00mCuk5WYGpLjk9
	282HLagqsXS0vxptSeU8Nu4N46GZ7V4+DRC80ubgOX8XuFj2BxM7byp4/IbAh5pHhUdOJ1o7M4C
	r3UKOYYuqe9TWKWnHMs5IAs2qKes2VrO5J+URYHKU1klAk64sF1Vp+7y0/rXuW+sb+eE+dEzi29
	73vVwM+MaYrTv4KjuXlQyDYa+ohyviuH9mPbr9H9riVHPIy8ER3/WMdMlG3aQqA69DftU3EhLLo
	VDrv1cQOQrDPQA4DYZ6PVE5XXwmEw8jEkxHPyClVMRPAlr1lrf9p1ChbZ6/RZGHKUBq2ZDm6145
	Q/rn4SKMtJqkZMmfwAOvTmarGudkX4qiFZZ5SiNV80+w==
X-Received: by 2002:a05:600c:34d0:b0:480:683f:76e8 with SMTP id 5b1f17b1804b1-48069c7c265mr12611895e9.26.1769507867692;
        Tue, 27 Jan 2026 01:57:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bf93cesm49056225e9.9.2026.01.27.01.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:57:47 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 27 Jan 2026 10:57:32 +0100
Subject: [PATCH v2 5/7] dt-bindings: arm: qcom: document the Ayaneo Pocket
 S2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-5-c55ec1b5d8bf@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=716;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pirzvUMS8i50SX74B9DHasjEK/A+JFKmccu8rvH6JXg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpeIwTWMafMrwJi/UrUblmDswBaoYuUWQ2fwrzpDVA
 O9HMxsmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaXiMEwAKCRB33NvayMhJ0UFBEA
 DPXxue632XoOKUO20a+YCsKF2UAhWuEgIA/+CWcQ8AAkzX0mKU7Ada7O5tgYC+2C6JOx2B2DQX43te
 +5aBc/dnZY90jLZ3DsrXJS2l5r3LPEBqFYiU8u0M+pLDYuDucZBdExoCYmTVshHoXtkJ9LSKSo6nnD
 gqQ0rEjVHTYrjcLYTIxxrgyNitSAFvzcgsm572Gu4urrwcWKJPKHg+PGxRimxRLB53vR1LXsM4m9Eq
 3I/aPsGIlOU4qsl+NSziBRL0bQrh8FLncxI33/Yq+ApgJtf9GIFw5omCPOdmxRT2H87qAV5D4sbJYO
 iw7Ewf9u7IoCJgr9dhpmee043Nnnj9HipdhsM83tbrjn2mJPoSIgufB9qjTvP46AlXiEYtz+rDvilE
 iXYM+wcORtdDgiJgLxqX9LkYxY2s8syHgTWBQBm25ZuTUDuXoW1Ze5IVTFbnJzOY2klsyaFf+2V0Y4
 Ipxpetfml5c9XHYicXC1Kc31vpoAToQckxTjybcua6AmKRLOqqQiRbb0RoQgLEqWbw0QUeEXu97Do1
 fUEazfXdUSif4MYm7YFXrQuMnegrrN039OGFUJXegyNxbBjUSgsvyDGO4woBlxzYT6LmqCIThzJrIF
 gQq3gUt21+BhhuVP8g6tOCoqo602mIWnf7znRDzCQeo3vM7RmUPLTXT1z3jQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Qualcomm SM8650 based Ayaneo Pocket S2 gaming console.

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

