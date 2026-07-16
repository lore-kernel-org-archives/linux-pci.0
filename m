Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9937C0F5
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218724; cv=none; b=e82QcAdQ12YSgMhyCwuQYmwNthue+KmI2kKc3metA/zrLUHeoHOBLyKhg3CF52oyrJtdgMsKuZEBGRipGHFNMCnBIgpyc6rov9NitRL2CuQOfZBLpMzadqhEJ9MD3l3EJFuxZKbaqN6/6syrmektQo+Hs8dsRhRdsW62/xFlubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218724; c=relaxed/simple;
	bh=+a2PwVdZXIN3LhIMygJSk6N3n7PMH7uL5OC0qbZNTaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtY8L1FLL5rXhs2K0aY/xqroYa5o1tat5v2TStQ1YMzyc/UaTo+JgIbJf/Qt0NwSGwslfpD3xTLqwFm9QTXd2IwyRWueIR6zop7ok1a/aIB2r2CzzDCnDNsIawOEwgMwSEZNd/WO64c/Gx4dycvSWKpTE4X4vO1weP5A0lESISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GYgQrQs5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rezy1A46; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GYgQrQs5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rezy1A46"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJcAK2946542
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=; b=GYgQrQs5ChdhQ7ok
	ReS1TaxAQ007HtFnLTqhwEoCVtxQ379eB+DhXh9+EyB3WcpPU8tjWydTQzd+WbsY
	oiOz6wf9BlGenF6QpKTBp8JUVF9NoDGQqQuTd9c0WQtE7aytueC2hYjZ0TSxsMfp
	Ozzxle9TRnByuUSVxKviwTCqzC5K7FDVPlYrgiBBroOrgoyzJSTp+ap8dP39G3TU
	1NXC+PRyxXiNTIHaT4LNz6d0jqJEx+ls3OwkWOlfWekpRFvkJDXWnT0BgQp5AcFC
	Jy4dP07WLACoVYkYxhQXOHrsm/d7UTtWSYKzoVrsdCwFil2gdAEukVqJpbl477qr
	6UfDZw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fen4wbf8t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1852a86fso77343881cf.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218715; x=1784823515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=;
        b=Rezy1A46nDEG6VC57m2Qn0+t69pIdyvxrtPc47WlShlXDcalMponOhWRsZW3Cgzg9a
         rrJxwVvod6u7hkD/IQZjvWQu/7vtFuxtzuMcfW+U6yDTGcSCoN60R+fM94yasuCAP6AG
         +ND0MclC1qxWTYx4Gi2aXbO2MGpBEDkazpAanC6VYoTRNod0C/cg1OdWbHxtVhEhaXz8
         onbFpFf/HhgeoF9FmUSeJyV49cQuKUxPkUJLGmDwrn+ex9bmKGHrK2pZmag0gCK9LqfW
         X+r/x2GHCrDGUVO1MEyFgfpPKs+WaV8c3UsoZkh+hL0d6SqlQreK/5x+oWTh4hqZF6sf
         7ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218715; x=1784823515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=;
        b=eghYObPgPGxLw5Qf2yf+BVweSA2rYFAU3LNgOUNLPAgBe0lCTDBCm4wyjdEU7SnAC0
         amEsWW2c1wrKuxL6hYzfnP3tkuRmJ4+hEQEUxTTur/WMC9kdoLwTGWwE+mdndbVa0P31
         KRUr1aXpn5vzxfU2DALUenGhezsCu0ZVmOtynOTjLRasxUuDwPzcOiPigmfUrJqEr47f
         fYo8wUluqHmDgSAzIDMrrYOoZlfdYUwUISrkJ3EKSuu2VBQOmTsalHtIIkCA/clIwIck
         MhXEy1CoyUWtZ0kK1o8bKa7hdNnVgWnUBCkhqwzdAw8vkMts7CYiWFG+6YrLZN718v2S
         FL6A==
X-Gm-Message-State: AOJu0YynmxakV7SLEt7kkNyblr+vEDxno1cvRW0quIt7mtbOKyFjTzMT
	HlxlpVHcdWZNLAHjKQhuP/1MthcrYHWZDfFZKamLqqUEdfkoNEXJGApJpMxPCSBMrZVAdjA/wqq
	t1Vbb/d5MlaTzt6gb8J4RB9dv9v4YLAkPVXCWlVONslbJLI+uypPeSeTLjfjuwHA=
X-Gm-Gg: AfdE7cnwGYXqVDLPnkUEGWWQ9eKZlHAf3xPgAzz39WlYcTDubt0I9gQbR5EmnQSfGSB
	t2rXpeadm4l/QyWa/1mmiqJ/IEu4edOh0SwnPIWPzYsLTDFVUwLCX07YIusHCdFqPC7DlKyQnXv
	vBkEuwX0/7HSavTZVtVVIO1zsvJYyoMPi076tatbtqmwndty8IchsjjDd6zCTi2ZKtE/bzoBjHL
	iXmg5nuGJJ2s1OREXyB7Y+ukdSrsXNh791Mxs7gvFBYfKA+yLvefRIcE1TAIF8XkSxqo4hzSXfT
	Kd9eSuKMJ2iwjOTlPPX9SX6/4Q3DRJD1WHY6b/IlWA5Z7/pj27cQhxy9wnblbMqKeN5VCffVc1i
	VUlhcFJpW93hpoAowl/niJ7MZBuFOgxo3YGdSKuBLiTfYu2ds94Ry/t6LeUjbq+BvPF9peRRP3w
	5APRJQS2Ms0Mj/RkVOfzzTUfjuxhkzj8HXiIfYWLBl1bA6XNoCacE=
X-Received: by 2002:ac8:7f13:0:b0:51c:7b12:5fde with SMTP id d75a77b69052e-51e42497dc8mr115018541cf.74.1784218714502;
        Thu, 16 Jul 2026 09:18:34 -0700 (PDT)
X-Received: by 2002:ac8:7f13:0:b0:51c:7b12:5fde with SMTP id d75a77b69052e-51e42497dc8mr115016901cf.74.1784218712393;
        Thu, 16 Jul 2026 09:18:32 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:31 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:22 +0200
Subject: [PATCH v4 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-5-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=PsejqQM3 c=1 sm=1 tr=0 ts=6a59045b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=QWuo0IUDA92h_ITipQ8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: yMy_pRk2gH3xC37FfYzUB3Abgm_uQAPy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX8C4upNAjLgE8
 i1VlZJWJFLEt45HrXkEMRQ3PSiZYVW7lAgaz9PXl3gRv6IC0xCMl/BcffaFRn4c3Wb/Z/+xTkqb
 FSjyEaZohf1ZPMKPbHMnx/kuD7/y6R8=
X-Proofpoint-ORIG-GUID: yMy_pRk2gH3xC37FfYzUB3Abgm_uQAPy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX7ZFWqMfAtHhp
 W8o7FYFGO0htALGu6OshZNW0fuQJ2WFddZpADnSiNyruRt3MjACdO+a6ykOh2Sj4yA30ZAIixPu
 fCYLS3yu7PEaR2e/n+OHw8EYoEEXUmfT7o2C6MCE8FX2y0KVrFSJZxcRszW3oUKNkTFDK+L+VrF
 ZquYldyaxFN7cafIWexu+LYf/BKDq4fpVfGullPIaxGBkJl+cwIn52JJjLE2nI6hkpFT4CHkK19
 sCSGrFNWRcSx8eyPVUCCJiFZWXA9xD74Guzs1kheRhOLvxUXMco6AjUoMk6jydz7M6sMC3SG3QO
 sHMD0lZjQBAFO+odfRHPHe61tnMEaAf+OGpAxY1pVWcKiqlvyeeqYCI5wyv5n3DKDUJPJU55FIZ
 6P3V3Op/zVr1uhdx/hT5/PoKMEWZS043XoAatuWWwi22hK4fIsEwOqHEul9LDWdPxSm4YIZ5pWW
 t5Iu6/6Z8EyFQNWLRmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160166

The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
gate the respective functions. These GPIOs are optional, on some boards
they are hardwired to an always-on pull-up and not routed to a host GPIO.
In that case the corresponding enable/disable callbacks are no-ops, so the
consumer cannot gate or reset that function on its own.

Implement the .is_controllable() callback on the "bluetooth" and "wlan"
targets so that consumers can query this via the pwrseq API.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index b55b4317e21b626e050e022648147770ca7f386e..19b51c94653b7f8e7e1f5a2fe906c0cc1cd46aa8 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -184,6 +184,19 @@ static int pwrseq_qcom_wcn_bt_disable(struct pwrseq_device *pwrseq)
 	return 0;
 }
 
+static bool pwrseq_qcom_wcn_bt_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The Bluetooth enable is driven through the BT_EN GPIO. When it is not
+	 * wired up (e.g. hardwired to an always-on pull-up), the enable/disable
+	 * callbacks are no-ops, so the host cannot gate the Bluetooth function
+	 * on its own.
+	 */
+	return !!ctx->bt_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_qcom_wcn_bt_unit_data = {
 	.name = "bluetooth-enable",
 	.deps = pwrseq_qcom_wcn_unit_deps,
@@ -218,6 +231,19 @@ static int pwrseq_qcom_wcn_wlan_disable(struct pwrseq_device *pwrseq)
 	return 0;
 }
 
+static bool pwrseq_qcom_wcn_wlan_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The WLAN enable is driven through the WLAN_EN GPIO. When it is not
+	 * wired up (e.g. hardwired to an always-on pull-up), the enable/disable
+	 * callbacks are no-ops, so the host cannot gate the WLAN function on
+	 * its own.
+	 */
+	return !!ctx->wlan_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_qcom_wcn_wlan_unit_data = {
 	.name = "wlan-enable",
 	.deps = pwrseq_qcom_wcn_unit_deps,
@@ -258,12 +284,14 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn_bt_target_data = {
 	.name = "bluetooth",
 	.unit = &pwrseq_qcom_wcn_bt_unit_data,
 	.post_enable = pwrseq_qcom_wcn_pwup_delay,
+	.is_controllable = pwrseq_qcom_wcn_bt_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_qcom_wcn_wlan_target_data = {
 	.name = "wlan",
 	.unit = &pwrseq_qcom_wcn_wlan_unit_data,
 	.post_enable = pwrseq_qcom_wcn_pwup_delay,
+	.is_controllable = pwrseq_qcom_wcn_wlan_is_controllable,
 };
 
 /* There are no separate BT and WLAN enablement pins */
@@ -281,12 +309,14 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn6855_bt_target_data = {
 	.name = "bluetooth",
 	.unit = &pwrseq_qcom_wcn6855_bt_unit_data,
 	.post_enable = pwrseq_qcom_wcn6855_xo_clk_deassert,
+	.is_controllable = pwrseq_qcom_wcn_bt_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_qcom_wcn6855_wlan_target_data = {
 	.name = "wlan",
 	.unit = &pwrseq_qcom_wcn6855_wlan_unit_data,
 	.post_enable = pwrseq_qcom_wcn6855_xo_clk_deassert,
+	.is_controllable = pwrseq_qcom_wcn_wlan_is_controllable,
 };
 
 static const struct pwrseq_target_data *pwrseq_qcom_wcn_targets[] = {

-- 
2.34.1

