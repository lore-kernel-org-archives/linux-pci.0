Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3948EBE8
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332096; cv=none; b=XUFkDL2rhQ2cm2UJw10kjXoNtD7vBjbKm8cLLJJVD6tcQVJgZjdp8nNq+4nHFCI6q/zX/21vJ37JFRTvVRNLixUY9d2vH9Sxryc3KnYKLZ4dyFcG9I70LxEfWwgn43eXhxmlolmg1kiM0/lqmkFDkB68IdxIeEaf1gj3Wv16lP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332096; c=relaxed/simple;
	bh=qU1bsNF5sgI8K5fI8fOugs4FNulj81wGym9z0+a8Wno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtA4slbQYbLXpvt9nUFpoPdr0yrNhErdBjar8KHqylu68E35SJtHSI8EizmFkqaxEz/AfNoAR+VVHOCyqrANzPv7qiqg+Ebb+Rn9kH5OdpxwvlxgdWbUfIlvlRd/eHbnz2Umjt7O/Gco9s/VtCdGs1w335UqKQRyu8GPUISq28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iCrsgMY8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PIGTofL9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iCrsgMY8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PIGTofL9"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TD7uR81691272
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IGEWc/ZRCBChaNwcCIeIAU2FveunJAEpvqYm0/CW2W8=; b=iCrsgMY8rrlMNGXd
	7fOdiGzlHN8xptUmB0wXiXW/d/ZZfWExrd0p7q3zv0BvfJLoe2Z8b1unuvrhi1rC
	NvJ6gZA1CMdJHBYS9vOvLFd8qxbEBzbV/fkHf+fwwI6rXCd783dT2chhRNqcuG22
	0FBbul/me+8DxJ/vsw8He5y4ZfpeAq/7b4mAforzH8/IrtP9KIwuWo6/yFRoXMow
	C0QGx7AlCGWyAlz/hHMxIOVJq/JQfbpbJT5vBK7n86p7DGOhR0nRphhgwP7bapWW
	T8AC4Ajr7bt+OOu0pt4xY512tEWnuTqJkN5uRnPkbAknPBTsCbBhacirw/5KIyDC
	tDWo9g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgy90dnm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:34:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e606e8f3eso79298085a.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785332089; x=1785936889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGEWc/ZRCBChaNwcCIeIAU2FveunJAEpvqYm0/CW2W8=;
        b=PIGTofL97NUKH3rzM0FIFz8LBDrll4ZXEB9Xuj7odBLugtNz0roJQHEkeP/I5j3VDX
         hLJv3lck5o+uj4aBcxx2x9rTao/V3jR5HT30hRndZn4NQW3iDhghcn/OnVWGzB8/eMIp
         thi1wZjM3gHv174Rb3gaDreJGs0vXf27dGoDM+nkD7rCdRPddxxxmXl9SyDWnL8MnbL3
         YiBOnPdoi9k6s5TIoM/cBHtmwqd2NRH7c/jG4ragalw3E1QgG09iGKJmySabL2kP39pq
         7nRGIx2gYkqFgI1XEiD8A0bx8Io9+5kZtZcVdwuOZJPIe+H9l2oGJhIFRyGcFBcY6AZL
         XHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332089; x=1785936889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGEWc/ZRCBChaNwcCIeIAU2FveunJAEpvqYm0/CW2W8=;
        b=i9sA3ULBWTiaCcD5DgtX2D8LtosnzITplfvMENQlKsdhpBnsGv069GKcGoPPex7Yx5
         MNuqrKEwE8Y3OlOPyjreymuerXRxCz+L/+kvl4NWnOKOqkJQPg9j7WRmTFdmeYwJ7MhV
         5XWz2PoLjSmHswil6OzbHcwK3OBanmMxXLRQgWyUUwJEM6phaPGml43qXP+vbYxwok3w
         gzM6u+EwIEKCcglfUpZ6V2xcKwoIIO4CGntzfiQZFZRKvvLyxNpPnuvuAWG+vGC3S5kD
         tF+klrPY/k6YRUh0TDTrfNO7wmY0PRzCgXA9yHJUlFNvUV8JH4BYycnGU1am5HCdSzd3
         Os3Q==
X-Forwarded-Encrypted: i=1; AHgh+RpJZ5Y3UX1VhD1rfG38ckuvCuxGFx8VzlA0EKRSREWQq7pVkVS4yLCIQo3zK3eQLsu2H/wQVCJUSWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbvDreLyFNopAueQ2Mt7TzHrGkWEyCbLFbOYUxWdnxJzeGVvsl
	KuZ5nvdkH1pp41tHSx91CvS20rUJY9dm0Fd5F8sPw6aXCpDk7jKxrkg7JBMxlaiYuQvo9EoIMdP
	nViufwHjjSV/NTJk74lAMzSWAX4ZoV312nJ+vPLnjOukAepQFMFuASv3468C+jXNPxd5yFN0=
X-Gm-Gg: AR+sD11uy5wgsKXdMGsOHMsmMhLM7uPbTnQxjiffoS04sttNQhvz2lMV3WiKg2kepeD
	iqo6jSifbfKN9on9M9pgq1L+FgiaLgciSIxWoiKnto4P5eVZyjePJYNjxhlg8HHiQU13W4tVdA1
	0K4wXPD8Sy2DuHLr+qv37xQ75OJ7GuxIG7lSaURVZDv45pPvxxqFh5QxokfElO/fAY5A0y8hTu3
	w6kvnADDsliXmWlCqDgeTOmnEWDwdq30YMlZcdIdqIaw93UAcrHwZvjZI31clZ4Dsw2OEuml4/Y
	mblOGhgXv3V2NnwKcC+OH9WM4Ds47LYnb7C0yrUc1A6xME4lV6DGtgjsDs9vaKJ1MOZdyN2qZIm
	9jBWS59aYswZ8oDs=
X-Received: by 2002:ac8:5a82:0:b0:51c:8fb:fa45 with SMTP id d75a77b69052e-529d7110314mr60563211cf.58.1785332089127;
        Wed, 29 Jul 2026 06:34:49 -0700 (PDT)
X-Received: by 2002:ac8:5a82:0:b0:51c:8fb:fa45 with SMTP id d75a77b69052e-529d7110314mr60562771cf.58.1785332088607;
        Wed, 29 Jul 2026 06:34:48 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f4dd13sm112903466b.31.2026.07.29.06.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:34:47 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 15:34:26 +0200
Subject: [PATCH 2/2] PCI/pwrctrl: tc9563: use devm-managed I2C dummy device
 allocation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-pci-pwrctrl-tc956x-regmap-v1-2-20ce61a3ce12@oss.qualcomm.com>
References: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
In-Reply-To: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExMiBTYWx0ZWRfX6pVZkZTOQmlI
 D1BLLB9A1FwCYuLE/1NuOYAmDqwP3A/cpuYGZN5WAcMA616oD8xKFtitlOu1IrMWLnMKeaqh/Iz
 qer6dJ39KvxJ4pl2I9dmQRPa8kd8MGg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExMiBTYWx0ZWRfX6PEMHotaevLE
 IwmOlI4GkLUllRN1iT3tPvOJURaGE0mCMeMXB+HxKozvwAw1J+gKI1SOiwi3GpoXyUhEcC3eNbE
 HywSjKrVR+kqD3cQs0T3fD0MMdh4x7aNsdR6KSnd3ydLxeIv5woJVERtXXfFwq6KUnnzQok8b5L
 KTpYCSsVce/JmJgJYni69A4pwCQ1HHLb0DDurP7lZUkjlv0wBeaGwggkFvRxviOYRuT8Fxspbxl
 ouS9DwJmD4Oyhir2e+PhvDbYhYoKnjB+yOM9xQwIDzlTxxYpQ1ajl/dmvObFE+Tpm9U3hQZZHb7
 xJEzu7goJOZtJK5HeDSqTjuJFslunvhS9lJObObknjsrNIdi1ReHaIyqhcI+mOVe+BM3qTCr/2y
 nBoMuAKeEWsuV8aZMpXgO3w1bYQ/OZ7LoX6+QbehrXAkhcP+FvVUn12LbeGJ13Q5ScrzOQHde40
 zr8+sION3CN+HGetmaQ==
X-Authority-Analysis: v=2.4 cv=LtKiDHdc c=1 sm=1 tr=0 ts=6a6a017a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=L7XwPe1Ly6gV5MiGEaQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: V_dE0x68bNh8haaFvtxvm5JkPi9oaZTs
X-Proofpoint-ORIG-GUID: V_dE0x68bNh8haaFvtxvm5JkPi9oaZTs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290112

Switch from i2c_new_dummy_device() to its devm variant
devm_i2c_new_dummy_device() so the I2C client is automatically
unregistered when the driver is removed or on probe failure.

This allows removing the manual i2c_unregister_device() calls from
both the probe error path and the remove function, and lets the
i2c_client pointer be a local variable in probe instead of storing
it in the driver data structure.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 8bccf3abd189..5b05e76f6c80 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -106,7 +106,6 @@ struct tc9563_pwrctrl {
 	struct tc9563_pwrctrl_cfg ep_cfg;
 	struct gpio_desc *reset_gpio;
 	struct i2c_adapter *adapter;
-	struct i2c_client *client;
 	struct regmap *regmap;
 };
 
@@ -505,6 +504,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	enum tc9563_pwrctrl_ports port;
 	struct tc9563_pwrctrl *tc9563;
 	struct device_node *i2c_node;
+	struct i2c_client *client;
 	int ret, addr;
 
 	tc9563 = devm_kzalloc(dev, sizeof(*tc9563), GFP_KERNEL);
@@ -521,15 +521,14 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	if (!tc9563->adapter)
 		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to find I2C adapter\n");
 
-	tc9563->client = i2c_new_dummy_device(tc9563->adapter, addr);
-	if (IS_ERR(tc9563->client)) {
+	client = devm_i2c_new_dummy_device(dev, tc9563->adapter, addr);
+	if (IS_ERR(client)) {
 		dev_err(dev, "Failed to create I2C client\n");
-		i2c_put_adapter(tc9563->adapter);
-		return PTR_ERR(tc9563->client);
+		ret = PTR_ERR(client);
+		goto remove_i2c;
 	}
 
-	tc9563->regmap = devm_regmap_init_i2c(tc9563->client,
-					      &tc9563_regmap_config);
+	tc9563->regmap = devm_regmap_init_i2c(client, &tc9563_regmap_config);
 	if (IS_ERR(tc9563->regmap)) {
 		ret = dev_err_probe(dev, PTR_ERR(tc9563->regmap),
 				    "Failed to allocate register map\n");
@@ -607,7 +606,6 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 power_off:
 	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
 remove_i2c:
-	i2c_unregister_device(tc9563->client);
 	i2c_put_adapter(tc9563->adapter);
 	return ret;
 }
@@ -619,7 +617,6 @@ static void tc9563_pwrctrl_remove(struct platform_device *pdev)
 					struct tc9563_pwrctrl, pwrctrl);
 
 	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
-	i2c_unregister_device(tc9563->client);
 	i2c_put_adapter(tc9563->adapter);
 }
 

-- 
2.55.0

