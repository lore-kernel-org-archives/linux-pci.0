Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DD4FDE4B
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536557; cv=none; b=ZDqIaF6FgJHq24tNmKxmZtBhTnXNzioMoVkOjzY3B4pZ3yEwfjhjeW74XmX+XTSBTOKfqMbPw0f2vkSz5edl53XXJuo8/cxpmQMyPEtXOMieGqwYoaTqscI87aKDCjGAO3tzwrRCDhOjoNIIHqrVz1/813GnVv+Vckgq/b+sXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536557; c=relaxed/simple;
	bh=DketuHJTJ2AlfYdQleqI6+O28Z0Vk44wfCYCPKymfKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NoLOXGEU9XZyjFq6wjSQ8lrnOMcCU92hMlhsRJakrDZQnbmRGQnFNa8wpuvCDj+6c1xHW54dNkbdkv74AARXe9Y18dZ7YiATsj/7cgySNIHm5xuu3YrXmp0zSnaA6X5dClJQntpNDrNBULrVRzeSEMKUseGvvCowXNxaZ0uczsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GbRXD4v9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MuKMUSHT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GbRXD4v9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MuKMUSHT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Ekjh64163413
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2026 15:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yApsV8ek6sm1DDA8uG/ESAfoNPZgj9MCFK73tfFdH0A=; b=GbRXD4v9A27QZCV0
	IePXKo7wnG3hRuINtPA+y7vQ4hAhufw1eSbZGR8ApfMIJOGvE/CNtQZjUAoQrikR
	esR+cBp2gROES1vue+m9bq2TVfENRNJFfeVniBzvdefPPjvXH+vhH9fMNkueKtfw
	/GqAELUGXHt0/FKBf59Um+ddN1swEdGT92yG3FPap9uw3kjmdNZA6NTgMktDKxCi
	8uye4/AJfDuO0MX7ktD/bFQiqHMUiv9hDGPkpEiqm5zvS8zF29iLskzj96I00M9W
	mQntvqqOUAm9wQcltweDatgMRhJaB+0ZjsT6Mrxw7UI38ZHyWXJElG74sgTnSmJH
	CaPpzA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg011gh29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 15:42:30 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7866c4ed349so1000164137.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536549; x=1789141349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yApsV8ek6sm1DDA8uG/ESAfoNPZgj9MCFK73tfFdH0A=;
        b=MuKMUSHT5ndCJdn1lpnW6Hop6zfnVCiw1NhWkqSTHI4OytO1Fb0PsCpmysQT26StXN
         4uKMGaXv7tDlHUT05y28m5er/bqGcUEnZj317WxenJteINl2Bz9L0lNzw+jIT1eik4Ut
         ndJ0qHdZgjetXcIVtCNAJQhfeZANoHWYmgpKDgz5FGFV/AV3FCaA5TEvst0xyc4Qqbha
         oynerrTuPo/6rf09bmZK9062SW+B21aO+ATpL46chbqN2ChM8vezcqLm5xqqjdLVUt7N
         SUpjZ2Bz9DzMnbDmJf+CWsYdCYYbrP3Us86AN7nw1/bWYT84FViwn36g0UOLI/HMlHar
         NmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536549; x=1789141349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yApsV8ek6sm1DDA8uG/ESAfoNPZgj9MCFK73tfFdH0A=;
        b=p48k2moxjLIB1e0MsQCnQXoTGM/bZIjtxzkqjM9mvhvha7JOLjTaTQ9z1ttMxYrOdz
         bB3PaClgR7J3q7OZ7hIBUCZaY6ovIw+YxBpq9/L4Nhe3Pf5TQeJtJGSI067nt12bmZn5
         QV9hztnEA3Q88TOILzod0tG49gc1r3uGG36NipllldYE3ww6GbhA287yuOspFbICUiSE
         FCkESNEm+yqjOSYvvC/SKJ0qZSig+YC6L4i8y47uZ80TqtBLfJEcXbPE5XVH26i9KkCu
         rinSIKzziYlOBiFbQQjqGzj7pfhzzNAwE0b/AYJY8ZFKX7LpJD648ZRMBnEQT78natG8
         xoPQ==
X-Gm-Message-State: AFuF++lB11EqApFqqaDpKHorQKdbeDewL0k88ivJIN5EU1YuK41rTEqS
	LE+tEizVtPg28TPZGKoQtq+oHK4XwTXxHlQe7L1C40/vgwHrf3UA26pScalQ7eS9je1axk+Hpq6
	f5WwLHS+kISQY04FX1MUQ+UCDYbz1+W2QrxaJdQarUa1uJBtxnLGBFe2lFnSzlhs=
X-Gm-Gg: AYBFou1cKlL9aREtgQE8HlITWYOVd1ida++Ygo7lVyysEBMujk47zFJ8QtTbZTZ/ja5
	Fa7xF2uuIcs1Tq89ybdGVthBWfjMnno1ZRzbJgT9iENw+DCB3wqRosEw4axmErBa5i+5M85tunT
	0X0qahuCRAJoR/8y+3WhLdJi6OA7g5m28fqc0b24U8QgSqvkpdoeLPXbi54hDUdUjb6jK13S9zR
	G6drB0XkkWopwkK2cXnqhHVeNQJr3W1CUOvgPZ+y+ltBmtEapMFgKoXxsg4I3+qiIZznY0eZk2/
	kkzU9Rt1Is8glN62xvIvlba3ZUetp6KgzckG7AGYvtgjlkWqZH5SQrwdTHpGM1OldWwmKnWm3EQ
	ZfvU3CTBY93+cqQ6lcEM6ZlOR80IhZwwR0n1EqLJ97GMKPz15Nw0HIubWW6ENtlakQ61eM0iuLx
	ZJOLxlLvLGezJwV8oVOoRTspTg8uVUpSwZAclNCAbwTezLTOFdPcE=
X-Received: by 2002:a05:6102:80a3:b0:77d:9fe9:1716 with SMTP id ada2fe7eead31-78a4a6e83e9mr3371652137.2.1788536549412;
        Fri, 04 Sep 2026 08:42:29 -0700 (PDT)
X-Received: by 2002:a05:6102:80a3:b0:77d:9fe9:1716 with SMTP id ada2fe7eead31-78a4a6e83e9mr3371628137.2.1788536548990;
        Fri, 04 Sep 2026 08:42:28 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:28 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:20 +0200
Subject: [PATCH v6 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-5-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX+C+bIkiTt0RV
 VbNF7i75oQo2vwwOV2yb0yT8KxVXoB4eljskNSz5KXB221EnXpKhu6BuzXbZOuLWn5tdwKLia7o
 8eWyRzpw4wzuwzlriUiXzP5jYBb/6e3txSGxl/Ps5frTnRYS3jlh5dCcDj6sy2844SAszN12Rv9
 MpjZ0szUyc/C427U45/DBe71pAPyrKlwiIBdQq+wEtirQgo4kvEEc5IVKbIoNnjCg0f9vaE5B/F
 MBsefJRz9cmLacSL91K+x173cIZCJzVGHCpAXpAbonwaNFe309o0IvVY7/WkpFkN36eIFmAgqN9
 BrzTxW73toNH0i+gSMk3KUS+W3TeTOobqM2TPcO7Gm23mr71EvlHKXAw+Yuz+r7GNsK/kLYjYfz
 0UIr1SKghsnwNaX7wLxOGv1LV+od+5qcThUBOAarWaMZo+Hs/oPanTlJ5EdyC8FhZTnPHN33Bmo
 g4i+qJpg+wF3Syfv/EQ==
X-Proofpoint-GUID: IqHeZYRZ_p_vOHZutdI7L57kMBsyfsOa
X-Proofpoint-ORIG-GUID: IqHeZYRZ_p_vOHZutdI7L57kMBsyfsOa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX/XJuJJjAsZ/s
 QhiSfOzjDBafR9DFMt0LuM5Ps5+d8dl2l992RYGMM16P9Z6wlEqABA7647Hx5bW+SGKA/JR4T8w
 hQT1T/5aTR/6kVO07cWL3k+emyGPD2o=
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a9ae6e6 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=QWuo0IUDA92h_ITipQ8A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040143

The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
gate the respective functions. These GPIOs are optional, on some boards
they are hardwired to an always-on pull-up and not routed to a host GPIO.
In that case the corresponding enable/disable callbacks are no-ops, so the
consumer cannot gate or reset that function on its own.

Implement the .is_controllable() callback on the "bluetooth" and "wlan"
targets so that consumers can query this via the pwrseq API.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index d41793e1fcd94e6d9073023498e111720af2c0ac..7f88a29b2c33bba5b1bc8e625f7bad26321fb1a4 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -183,6 +183,19 @@ static int pwrseq_qcom_wcn_bt_disable(struct pwrseq_device *pwrseq)
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
@@ -217,6 +230,19 @@ static int pwrseq_qcom_wcn_wlan_disable(struct pwrseq_device *pwrseq)
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
@@ -257,12 +283,14 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn_bt_target_data = {
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
@@ -280,12 +308,14 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn6855_bt_target_data = {
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

