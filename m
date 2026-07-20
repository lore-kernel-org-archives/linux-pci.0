Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0173B3C03
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534664; cv=none; b=ggws75bcT1ty5A0rDqDAbTByr0KHu4yncCiN6zknaGouBmGxZPCgwAMwA9Me9YOPybkVKiIoB/Qv9RgPr53Jw1tB+k3XQB5mAUREv2gGDFedzicC4HZ36SsgyvfIKP6DBLb6oIwHRzUpoVuHz/jj8aOpbmzZ3EnItlkxXeNmMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534664; c=relaxed/simple;
	bh=+a2PwVdZXIN3LhIMygJSk6N3n7PMH7uL5OC0qbZNTaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oembVMb0Ot340lIqRFrL1W8WFN1jRxUxbO1eZVEq4XQ4DOVvZOslg/lizB4oJ7DDF8jGN5nAQICt1MfaEEUoPh0jWYsZRQoWFCz8eYvrrG8Ye+4WNgWyrDkkIEIRJSGBg4JuUEhlmd5P65i6+dZHJiOrYcyksbWHF6zCq6Ps8Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQ7sqhGU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bX2xFmyV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQ7sqhGU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bX2xFmyV"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K76RWi1712957
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=; b=fQ7sqhGUG4Stu72B
	RIyhrfdXdGQySBtD+iwK3oTc/ESzt40Y4Xl7fU0qkimYW1kaHa6jS3xFEAllsWXs
	tWT5FanGg788MO7OtGVhWa1hkxoX53XqWE8Wd8ZrUGhq7ZW4XR0HZ9hnOwer8GC7
	iLYOuNKFFn/kITX6LEWVJAwUfHyfWTlbGw49cQI3Ci+o/E4lHQRw84ajDE3KrVqH
	UwHyuHodFgaFrrZlEVBKCgWEUgNMHjRYKGWxebZcEJLKb4BzdNAD/Q1TB8T6vmPL
	WoSW6DGKASlpI18iU6gBvVxYdur7Py6dtoCshmhMNT4P9M28XTdSzK18Ftngojf0
	Kqxz2A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0c06vj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1e6f602cso141320901cf.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534658; x=1785139458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=;
        b=bX2xFmyVQbMILlBuKiLcakLR0liKvSyfnoQvDeEVAq19g5vcRcgJMPrMZiLKzmP8G9
         lf3sljDEEoCIt4oRjITMpfVEf5RqIbpca4cImwVCvZUCKa+cX3X5ilN2u1rE2WwF5Ik0
         iUuMh42ww2VaV/9edCVuUpfw5YEojaaOqdCctRS4jgzTN49w8FhiEK6JwIAJboKN5G6j
         VL6l5ZsS/lrjt7c9F+WoXM+AUJH40jXQDxcEOrsvmX6OKtxYCHVfZ2h7vOCunbLFaVK5
         kilFBrES1K4VnR3zIEU8BtuRKNtvkoFhu0kvKts/dHGdGGnoq7xKMOAiYxVrpEr3MM3N
         BcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534658; x=1785139458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=;
        b=DMSpVkWvi2szFuo8W1UP395hNVBaIV0/QclTWnOQNN7ysVzy7UFIcqSTaw9k27qcA7
         sH/8fOXZqlUWB9kgvthjWRZ4TC/NkgiEDxBWXEjrbuDJbSN+elCAtCcQ0qR5ihS4j5W+
         pTJtvF4F/zWL9/czpiPy0idhhmU2DA4kSyR5sE+0WP6x/W/WeYhLe5BXWMXTYq2fcuhZ
         e3Ct0hHcYJ+XaAsZlTuRwydMd7XIgg+7cARGhIrzJ55cQKjQNXqMKDBkHmz52tVY/mgm
         9rX8eDblgsu77seUmea/SltmJQgJ56e9CDXyaM7N6eOkmCymGXASBrtZshNQFjdZl0lI
         QdLg==
X-Gm-Message-State: AOJu0YxS5KkXgBCZBnITfExN8RYBIa4Tihi7sx9HBnQ10q0Pps0WdI3w
	popBxCjdZEyOg7Na1h7jFiZ9KJKztXju+cQtdhIMn6e0axbu2qKAv1whP3KHV8ACp5AtUtU4iju
	KdRzTz86RAgnOT9DZonh/7AwYji91zmN5iv9TBHippLLWbXTWY7PFGCA1NKb8ngg=
X-Gm-Gg: AfdE7cluT7z3WQLV58aP7oNq47TuwDxHYzyhCCECK5nTcF8WW6VIEwgQeJJyQnP83Z/
	FWb/wdTSGERBoH4DlDjzyI6Fq6uubDMcSZZz1YItH7dOOPOk9cBMFwJnUlvFgf1wqY/oVIOLKhx
	qG67kxIJyQ4696z0SBkygXQotUzcnfAj1XGZvcRODnpMdXdo+c49CzdjUWbo2N33nyIKi29xura
	JqWq6pwK1XTnXE0GVAxp9A9wXC2i1Rjs75AeFl+jXTspolK8yl9z2ezHAP/iWAmdcPyi3mwCCNF
	ZXUZsOxCOkrqcqi2wgq/YPWMqkZJCvXKWVrmGGlC/3dJEyRvGf1LAS6EU1bDzEoaBsegnB64fPF
	4MtJUU+C645l+lQ+GqHmTEymYeKtMLBWJnfx/r9juYdAhJtK9z2IcXIcPxADJcngOQ1qDB2H5Yr
	hmNRBbf4H6T9SXMK2pVcVv9hU9oprrm1IxXh4DgZArlM35Ks0jtMI=
X-Received: by 2002:a05:622a:43:b0:51c:6d7:215e with SMTP id d75a77b69052e-5213dc9828dmr122931591cf.32.1784534657769;
        Mon, 20 Jul 2026 01:04:17 -0700 (PDT)
X-Received: by 2002:a05:622a:43:b0:51c:6d7:215e with SMTP id d75a77b69052e-5213dc9828dmr122931301cf.32.1784534657277;
        Mon, 20 Jul 2026 01:04:17 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:16 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:07 +0200
Subject: [PATCH v5 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-5-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=HeYkiCE8 c=1 sm=1 tr=0 ts=6a5dd682 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=QWuo0IUDA92h_ITipQ8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 956fTrMc1FWfCcveXRVYTlv6i3GkOIMP
X-Proofpoint-ORIG-GUID: 956fTrMc1FWfCcveXRVYTlv6i3GkOIMP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4NyBTYWx0ZWRfX8/prKwLEMOSS
 3HRA/+OHv/4VDZWJD433x3Rk6LaQqoPNsz7SG+VDt0izUc2beg3HzBou07LQenVShT8QEgry64Q
 TalKmUHNKQ7kvNIICfdKiRQ6Z1w9G4o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4NyBTYWx0ZWRfX2ZzYQmVOXotH
 D62M0PWMVRYwaFvap0uHVCymaEHOl9b2VI2K85QLNeQDbt2D6xfLIrGGHsoaIS0WUIR2J+S/Dni
 GrSGqgdv2+GkTvXssG7n0mjilntjlW2PSQriZ7G6Fh29WNZZNcAelPpTIaf/M4NryOwinfGxudY
 O/iuPFktByHg6Puco+h2Zxhv3z03fp7Y015vvVf/3eX5cF6QtEnEImVerTS29lmeCpIuvfXtJsW
 qntbCTg+K32oNW0hhCGky6arnUMPeUvouyN/4CNp4bkE2L3BECmt11KAap5lfFXS5tWE71cfat4
 5noGIflZ4APLAtABORS50CKgK34N9CHXInZaW17wR10/a1OBRzgb9N539NKb5DPkDChHDvJRmLU
 CQqWtQbAVrQBTOhT17b5pRH9eoizZL3Fjc8V6QpJsN2wh81IamiQ078QlWdLeMIkWy9yBOQa0Fo
 Q6GSTiZ0n/x6lE/gUvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200087

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

