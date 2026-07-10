Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52953F0779
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677467; cv=none; b=Qu1oxpq6Zi51+WcATfeODymCQUPtvswOTRI4vYeYRDHGg3SGAPopKcSLQrM7yDW6BpxxEjXKkmv8hz5Y44WI9vQFCIyPybU7dVtLw+PBk6nJkvOX/F/iiUDClChhR2o8bCmschsx/COQyR7Nwxwjxjbl4XqnNhu6LQcOPO5pSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677467; c=relaxed/simple;
	bh=7I0RHdk3qWyJVFH388ZwLbLetJ7qn/3xCwzAVbmebN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2fy0bbz0Rx07v2+3iHSybSMQmihK2nW1iSRH0pfT1/QQAYHQausOcI1opQ6sNGeCVjIxox5DllWfdgIu+sWUxzsWZnTiqWVvrPvOcrktJuK9XTiaH9TiNAK/TBx0LyVD2dkrWqtu/pQ3NBZT+j7udeTWTMTL9AnCcEE8sZLXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GMR9edp4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N5lsTuVF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GMR9edp4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N5lsTuVF"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dNFP182277
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GW8pkbZvfYORJjmA07dNF76DD9uMqzlV8iaeANQ36+M=; b=GMR9edp4MEDRJZ3d
	eefnwfkR+g07cZAGReOZ0R2RW5AXUSz3E0WrR7XQ/vsYDCkQWqrYaX5k25zDHyvA
	UP8QuxYnWrp15YFPdGb1JaK1fJK30PX2gHZIsFAPByTMSLbFLi7Qk6vWfshIuSgg
	VCsLeDYBYFjRvXe6aSyyzN3O28sJTpshEOOXrHOvPQ/6avygar1zLHeScandaO4N
	9sl+zVyEzmWe6lgGp16+A/mT5iysCDAm/YWqdaPIfWjaSEzcubYt55MzAhRmW1Mk
	nhyDg9ZtzMI6sM2lluobJROKOeoDbsZq6i8g8o5l9b65dgluh2EPCx52jsGQKb0m
	duQ9BA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte2hec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1852a86fso7931391cf.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677461; x=1784282261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GW8pkbZvfYORJjmA07dNF76DD9uMqzlV8iaeANQ36+M=;
        b=N5lsTuVF5QT24cUfIAsvdKWTqTWkmoWTsWqbu5LPXSzzfTNBRSzcKCI6FA0d2J3kr0
         6sB2yg9d14TzGufEwAKyR5cKggRMm6lY4Rbk7dGXjdyDuNnz0/djGs1o1YKLPNwnAZd7
         9mDLrhpfA4z0RxVVqVj6bih2EXcKDHkUgtbjJuvCtgd9FwQie4hipyqywuOGUl2kG75S
         HrFJaz6SEgFlAmYnnqZTbRX5osR5HCuvdIlAb43JzoiFbNsHheOLjCXMzfL47NXxQH3D
         krm0eHVw0douH2qWm1R5hkmuwKv6g801OXeAapCNB+ps96L7vEzBWkCYIcBqz1YderH5
         x6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677461; x=1784282261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GW8pkbZvfYORJjmA07dNF76DD9uMqzlV8iaeANQ36+M=;
        b=RfEMTcloUrJIiiwaglg6TIQEl6sn5rPfn+TIr66lH88cUCHLiwQU6KvVEM+MJvBjpp
         /sttSwDMIvrS/vT0khtINaJZkvorxPHLQ61+tNTBjYKLLKgdj3pvk7m3a6CSvyYkS+h8
         bYdG8T9InrIZwizk3Kpy87OkXN6eE2+W67e22C9rNCBuTRyPiCv4nbyei1K+mFLLmFtH
         4i59zA4jAIeWH38aDBLNrZMAqIq8EOHuRIj36yCvxYl6oeK+hQrcQiyutHI1RhXiyJGj
         su3dzfmltFOMZVSTPC37zMOAH/nJgZW1YW4nhYuIDxpPI59n+RVZ9tNXtJNPmYkXZcZ/
         uO6g==
X-Gm-Message-State: AOJu0YyHSxZoXXMzTe1BWQJGJ5Qj0GChhVfvZXl8GDsFG8tYu3G4R+MM
	2EetVrWxnAjnS9CWtEyz0UTSvaOfwKF1yB7Nj3FO9/eW3D3ztnyb6/gZfKCO++e9+zt3JYYeYaP
	YQ4uw/KDA47RW62SjNiw1k1XpnIMaE3m219jAvNwbRiWwFMNSnGW7Uvgma0usgEU=
X-Gm-Gg: AfdE7cncAGGDLedXTH/S31i1jAYtkNro+itESOgtkmxedV0LaK2WL8ABiahPXsdHhM+
	T+jUt01PyzoFdlg25MKKvT2DqrZIC34iR0G331O8piAWwG7f3SyktP0PPcugxHfL3At9li5raX5
	nPVW7DZu7zPOZ+vHp1QFXdIAYddUodcfalfx+NrY4+/pgiQzsJ0RbHUnGf0qL2u8H5atpM16uu/
	ZMCqQs60AqMJLc/XEO5Mm5k0jiGhjxBpf65YFlGR2q5/7Ot+cUVkQUCCx2Jb+Z+nNKGb4gwQoyp
	e81rYvDKXaBqpZEI4VYNN5lYfITabNT9PKtFRfyBSOjCc2CQwofF/UlYb/VUwqtG8+Mmi3PFWPY
	tK3DGUY/13DSb2UfoEeDmyvcAIMr6fr1AQM+cHlkNf1tT/qHLDsfyYJvYLXBm6RmIiypG0Y/zV6
	OPBn4muVzo126atU5qfHhzepWbMTjUOSPmwSPNWfePkz6PU+8cx/4gx8/4jd2KUf6d53pvekQR7
	lUsOQsFpFv530MRPZVi
X-Received: by 2002:ac8:5956:0:b0:51c:7b12:5fe9 with SMTP id d75a77b69052e-51c8b42893amr134253211cf.85.1783677460962;
        Fri, 10 Jul 2026 02:57:40 -0700 (PDT)
X-Received: by 2002:ac8:5956:0:b0:51c:7b12:5fe9 with SMTP id d75a77b69052e-51c8b42893amr134253051cf.85.1783677460461;
        Fri, 10 Jul 2026 02:57:40 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:31 +0200
Subject: [PATCH v3 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-5-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
X-Proofpoint-GUID: AZijCxlRWmbdRmzRUuU7SDklk4Vz9nH5
X-Proofpoint-ORIG-GUID: AZijCxlRWmbdRmzRUuU7SDklk4Vz9nH5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX9rMpLzpELvfe
 VjoPMfF4cxWt6Br//uU4pO0q4bh63+VsORN6zP9sR4Ey1pUyk9xcDppujp1hDdqHaNmJJE/QVDK
 6tMVK3S1RCNlhL2yAI0f8nlQMcDak86NG+KOSjlrC9+DKVB3T+iKFSR5/j0dca8Zwz5rUBMx0Fy
 14ef2g3VSDqr9Tx5iarOHBBsQYbPaS17oBUHXfDer/4SET1AnSr879pbTyJOW2RfOiHhR9d8Wrk
 u8226mk5crwOiFF8YxLztuGHZ6O6TS/IEJ1hIcHpAm9QhtzLifYgtKm96+nQ6qOA56jvdZ5v9DH
 GnACH+cky5QLjCNjJY/Zp9mhj5zaSAOj1QO4oJBhgFr1Zzr5tmUEBj/4iSWfN92lSrPLMSB2h3G
 I+dBgdsUNwdWeJW7PMQSbtkP7THfQkJzWSC7geWwfB+Q/gJyJjw7ciSXyzmaZZ3fApwqJMwqsct
 KYyTuemuu4beI84QXZg==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a50c216 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=QWuo0IUDA92h_ITipQ8A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX9fjLG0SKmsoM
 Zns1zV1qW82s9Xu9ImWix4WInaQiNPMFtSf2tZk2tHyn0p+1muDK5N9guVRaAp4oCH4HCktAl2d
 52c9xsEAdJdypQnPXXc/l5TRQn/kYlo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
gate the respective functions. These GPIOs are optional, on some boards
they are hardwired to an always-on pull-up and not routed to a host GPIO.
In that case the corresponding enable/disable callbacks are no-ops, so the
host cannot gate that function's power on its own.

Implement the per-unit .is_controllable() callback on the bluetooth-enable
and wlan-enable units so that consumers can query this via the pwrseq API.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index b55b4317e21b626e050e022648147770ca7f386e..d5c9b734b0538e209734e15980ff2877ef5a614d 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -184,11 +184,25 @@ static int pwrseq_qcom_wcn_bt_disable(struct pwrseq_device *pwrseq)
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
 	.enable = pwrseq_qcom_wcn_bt_enable,
 	.disable = pwrseq_qcom_wcn_bt_disable,
+	.is_controllable = pwrseq_qcom_wcn_bt_is_controllable,
 };
 
 static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_bt_unit_data = {
@@ -196,6 +210,7 @@ static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_bt_unit_data = {
 	.deps = pwrseq_qcom_wcn6855_unit_deps,
 	.enable = pwrseq_qcom_wcn_bt_enable,
 	.disable = pwrseq_qcom_wcn_bt_disable,
+	.is_controllable = pwrseq_qcom_wcn_bt_is_controllable,
 };
 
 static int pwrseq_qcom_wcn_wlan_enable(struct pwrseq_device *pwrseq)
@@ -218,11 +233,25 @@ static int pwrseq_qcom_wcn_wlan_disable(struct pwrseq_device *pwrseq)
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
 	.enable = pwrseq_qcom_wcn_wlan_enable,
 	.disable = pwrseq_qcom_wcn_wlan_disable,
+	.is_controllable = pwrseq_qcom_wcn_wlan_is_controllable,
 };
 
 static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_wlan_unit_data = {
@@ -230,6 +259,7 @@ static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_wlan_unit_data = {
 	.deps = pwrseq_qcom_wcn6855_unit_deps,
 	.enable = pwrseq_qcom_wcn_wlan_enable,
 	.disable = pwrseq_qcom_wcn_wlan_disable,
+	.is_controllable = pwrseq_qcom_wcn_wlan_is_controllable,
 };
 
 static int pwrseq_qcom_wcn_pwup_delay(struct pwrseq_device *pwrseq)

-- 
2.34.1

