Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719589;
	b=NsqvxcKhzOFpJa86XQFbM4j5CqlKKzungf6ae5lDLnuWbbo5WvV07ffSm1TL2NqnSJoF
	 l4ScSMQ0C3UaFyMg68aqFdkCl+knyLFWQvGbVQWb18nPRAG4VEIiwJQIZ/XFuJBqkN927
	 j3XqiZhZkZZMbwAakws841OV+pT8AvUwRgdfj1teAGckJNwxlkputnIGjK+eefCkqYkhN
	 tLJnS0CMkE68+FJVAgeBv2IfbhByuKXPsFHmpmhqM9Ppoa2/5j/WFQXTje+tGPDvwHIRG
	 EUcrHKXEQNiYNSUH1t/OljZVs5hKMzbphoIP719WGVx7iIHC3JAx+trPbnbV6XisA3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719589;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AhIc54J/K4e2MmEA6laRAf4VD5KH58JtaSUM84rvsJE=;
	b=mif6fKjTh43elPTZVUryp+0NmcnEFEXX2WV2Slq3ew5860WIWvB/SKkDukg5Zurgca8g
	 auNZ0BqTMI+Vs9Zu1WjljAh99yTZhXhlprecAo4IV4zAyi2ImQUku+DxjQ/Oi4yxTTx0g
	 wHrS8/fW5Ha0gtb2uceMmzHBWvPF2lq9gh+nh4J9H0oo5k0YfkJXH+U0VY8GAhyKOSpPZ
	 rP7Wah1zSg3AiuuqhIqUN1803ZQ97WZp6F3R3upfkahalrOZoN7N/CxJ5s6pkdWn/XZxv
	 1Y3S4tMtPChEiiCo5+Rxeht+US1AbGppC4BxY7GBXjWKkDgCQKHA+O/6kJ62VFGFaiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MK+PgnPw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A+F22DCc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03B606A323
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 18:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F03B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MK+PgnPw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A+F22DCc
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQFu37r3357102
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 18:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AhIc54J/K4e2MmEA6laRAf4VD5KH58JtaSUM84rvsJE=; b=MK+PgnPwU6+GUzoN
	AcnNkwEYSUDutNe+H0SmSllz4ZaJzG76xQSMz3DJsiuF5Jfn5ZV1xFW960GJHveo
	7YuUMcG77MbXc586q1hIhg0i0DMsie+u6dkAGWXMlhScwL9e8dsRGXyWlxUWuq9X
	pXn28xEzU1yOKA5VeCPVeAzls9p52Bf5ZO1vS2Venca/A8qLpmYdvsn5aG5W3VCZ
	FWve6x+qpHMQ0Zn1QNt0+p7GahqCyRTn5vawV9RQAuhkpQf4fbPko5k1PGiAm05U
	ao+IsY1fdtlnsB1urjM0aGrodwgNPrODwj91vto0rFXUSgNnCR+G7kP0VoPFy4wt
	jwNQ6A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j66qfc66u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 18:59:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso7501506eec.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795719587; x=1796324387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AhIc54J/K4e2MmEA6laRAf4VD5KH58JtaSUM84rvsJE=;
        b=A+F22DCcF3PbLhvOQl/jCrD5J0quqQofaH6H20jW6qGF9+L4tArM1IgQwwT15qGDry
         JqQZkzMH8B2RiTp1cDzNuXW0zPrRChTvZOEWsojFqjdiWvbpnI6WodI9hBA78+gN0aNj
         Tm47UhuXnAX6hi+G12gXKSm157SJ93rXYmS38zBbI641ixxWRkrv2caAmrUqrLYLlLVi
         6nBscLxQHADWoQi4lLtkC4etbvLVVWnteDUQXzZrv3juDrnkqi6dFatpca6XjGEWa7fb
         OJBpTsuMjTU8Yj79/+4bCSba1x7zpt/dke9DlGyfu9RJGCpZSwzYnnaB7xoPRovA88Ft
         tMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795719587; x=1796324387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AhIc54J/K4e2MmEA6laRAf4VD5KH58JtaSUM84rvsJE=;
        b=mZWtcJLVW1VlJeKNUFMM0erqGb4SMhuEiDxs75MXDJo+ES8rY6OEmMJXvz4o10z4qc
         LdsIOQyJ5rNdifgw0MsZgcPHMTHlZkz5VxVjETV0gEQo0pNgp0u4Flt/fsqPk3S1ZTQg
         jRrJPQrtUAwVxaAaADrxmJX8ejsX7D4+KFFvmLFODJ0+daCFNXKJhagaW9x9elVbz1Zp
         oop3qnPXOi2TsNnOp+grooRwq++d3RpuPGteljacq7dqzw+/RNpcIUCwC9SoL6PyNW8k
         OIdpsD1nPL3Lu0qJMTkplrI2v1xFZlosPniIaP+iab76KWA9f5PZPxpcghf+Qzf7FJ45
         SDWw==
X-Forwarded-Encrypted: i=1; AL+hErHzC7LDVjnoRKgRyhlUTvhLzZr59AJhGJ3C2/RLUT9Ae/uYjHa/426wB3/lTVQsvE0j0y+Mvb/vPrM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UWhnu+/jjetxM2XgFMfLFrJs1OmX2UARRoZ6asf5m3j/F1E1j
	vXjx5yZ5HjfAvMh4POF4PKwe9YlDqiGpGi0SbUvkJs/gwsvRrw+H+NliHdq8cpJSpFvJ2Km3j7s
	EvliBBLT1GPZd95V/MGYOV7ocuHLT1vV5BZEfGUgZrj4SeEJd2cSyc4Q3MP5oFyg=
X-Gm-Gg: AZFdTZcQj/slfM2LldOplthd4zioFfxIOvpmUknB7hRDc+ZAWaiDz368OxRTE+GjFo0
	OQRvL/vQFyC16ypAmOxqnky7mA5MULtN4Qy3eEyooBQGzYRcwQYbr5Z4btdQlmjPayIZxjFcTge
	/WSTI2YfFk5c4c7xZuQqSQ1G+oz5SzMubYA4fY/HgLJd0kxBe76/oD+WsJ4M5w+aYsEgWye4N/f
	jZIHT1q3UDmlDOpOOEQUB4V0M31jJZATAvkCopEJv+7R71eiNol4VxEQHtGXYuo/T3HRpLnFl0u
	CWLdvMrugeZMaiD5faqTVHgXsZz/X/DwYBFUuTYwdwUorvXF3ef4ulJqGDDphpEulfeY8zQJyXd
	mho//lBRTJVRPqaT+ICRo08ARzFryBaxaQXDmY5hEkZCa49nqHPQG9KQmOr81y7w3GCdCl+bwuX
	Tgcmda
X-Received: by 2002:a05:7022:3a83:b0:184:992:c9ec with SMTP id a92af1059eb24-1b55693aaabmr29816997c88.38.1795719587078;
        Thu, 26 Nov 2026 10:59:47 -0800 (PST)
X-Received: by 2002:a05:7022:3a83:b0:184:992:c9ec with SMTP id a92af1059eb24-1b55693aaabmr29816968c88.38.1795719586636;
        Thu, 26 Nov 2026 10:59:46 -0800 (PST)
Received: from hu-jkona-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm60868190c88.7.2026.11.26.10.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 10:59:46 -0800 (PST)
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:27:09 +0530
Subject: [PATCH 1/8] clk: qcom: gdsc: Use GenPD hwmode to keep GDSC enabled
 across suspend
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-usb-pcie-gdsc-suspend-v1-1-485a08ffdc6f@oss.qualcomm.com>
References: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
In-Reply-To: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: l2DGiqTJDYbG--nvjxLTl0PwpJW0S95c
X-Proofpoint-GUID: l2DGiqTJDYbG--nvjxLTl0PwpJW0S95c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfXwsJrDQl8InIN
 O0O/Xgl6+UV75HdKSO9/rPqXDSn7t6cmP5UgzUfjhs4j4JGvt9s6404J0dPJ87PtSIAlQMYpnIG
 qZKLXQ5PneedwppbM0HOzsOn9ufCiY4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfXyXYsT7qXvj9a
 f3bab6zGhTEJ1tgvNp2Uyh9yZggKEh85UwAnosmgFpS3WKG+AAA9o+fOR35g//Sv5iMn1z3jUfZ
 M1dQ319W3IBj56LTZ3hyfVsQecWz9TXsF3LIn9m6GZ6+Y5ez2Osngc9kKATg8D4ApgyJIQaMU7u
 JToBkxrdSpuY6sXCzKPxDjeizjdWz2V3O9pJVsL99iGK0HJGnls1P0jRIsC/3gfhy6MTxdmis4J
 ldz+nVbs/BdMxhhVdwk0fg7R8feFIrj18ko0w4bqC+DuBHQFUEGwj4Qj0FnPHYzg1OUJQLmewyF
 e0CvOGc3v4945R+nsYePtRY3/GVg1YfhmdpqfDD9dmOFIty1Dl3x5/vfjxxhu8PuFCr8Y3knCHU
 8pPY3ZeCZFGyztLM/1ikgCHrxTvkESxIn05MEtJUrZxX/T1z7+p3VjVIzbqgNJn3a1izHc6+Qn7
 FqcP0xKw2ipqqHPPJWA==
X-Authority-Analysis: v=2.4 cv=Q5VHcI2a c=1 sm=1 tr=0 ts=6b0881a4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=NuUCN_VPl_z90dSYpTgA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260074

USB and PCIe GDSCs need to remain enabled across system suspend for
certain use cases, such as USB host mode and PCIe non-D3cold. These
GDSCs currently use PWRSTS_RET_ON, which keeps them enabled after
their first enable even when consumers no longer require them.

These GDSCs have a HW mechanism to stay enabled during suspend while
allowing the parent voltage rails to turn off, with HW handling the
parent transition to active voltage rails. Use the existing GenPD
hwmode interface to let consumers dynamically request this behavior
only when required, and clear it once no longer needed, allowing the
GDSC to be powered off when unused.

Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
---
 drivers/clk/qcom/gdsc.c | 21 +++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index be9c14eb7b064f988bb4b330c8784cab82e43b2d..7b2b9ad0485e6035af6c72d035ceb2bb8f4155e5 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -345,6 +345,13 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
+	/*
+	 * Skip GDSC disable if consumer drivers requested
+	 * to keep the GDSC ON in HW even after suspend.
+	 */
+	if (sc->hw_stay_on)
+		return 0;
+
 	if (sc->pwrsts == PWRSTS_ON)
 		return gdsc_assert_reset(sc);
 
@@ -746,3 +753,17 @@ int gdsc_gx_disable(struct generic_pm_domain *domain)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gdsc_gx_disable);
+
+/*
+ * set_hwmode_dev callback for GDSCs that let a consumer request that the
+ * GDSC stay powered in HW across suspend, instead of being torn down.
+ */
+int gdsc_set_hw_stay_on(struct generic_pm_domain *domain, struct device *dev, bool enable)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+
+	sc->hw_stay_on = enable;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gdsc_set_hw_stay_on);
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 2f9665b664e606234fcc632c3f6b302a448d06a7..12bf74a1b2a431cefdab955de15ae6b01db7a10a 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -79,6 +79,7 @@ struct gdsc {
 	bool				needs_icc;
 	unsigned int			icc_path_index;
 	struct icc_path			*icc_path;
+	bool				hw_stay_on;
 };
 
 struct gdsc_desc {
@@ -94,6 +95,7 @@ int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
 void gdsc_unregister(struct gdsc_desc *desc);
 int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
 int gdsc_gx_disable(struct generic_pm_domain *domain);
+int gdsc_set_hw_stay_on(struct generic_pm_domain *domain, struct device *dev, bool enable);
 #else
 static inline int gdsc_register(struct gdsc_desc *desc,
 				struct reset_controller_dev *rcdev,

-- 
2.56.0

