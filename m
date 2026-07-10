Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406343FCB34
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677472; cv=none; b=C6kOQPGOYP8KWYACLCw1OInWk0irb/Y8FRDPjlkFcaf2tX+h1F7NqSC5cXR02/V/ecMkWQ4GyUrhv6j1fakDhVoxhr+rvaoQQZxHhj1bWnm16X1rf4L3ZDBa1PCilJW1MOYBW8yAi1ltgz+0UaoH7/CdfjaIiZW7DzXjLSJcwmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677472; c=relaxed/simple;
	bh=jak2vbWmlDxX6sjIkSns6YH/+A3MhzHcWj1aIP5tIEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gf6pQ7Qj8U3qSxzDCk2qrXLeGDA1kH5SPHfZfYYglgS8DY2t1tpiTKwFIWSgiOVDZ2URX/EoF+HArI6eFx/PHVFHYMDXGofCgAps+AHJ0QwJBjYQUnBz4Fg3JlKLqQF9iI19bZMHXeR27RFXt5iZpMIhXuzAkX/k0+CNALIMKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D/D2jK7s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d0JIck98; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D/D2jK7s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d0JIck98"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7eI2P141535
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TPH+i5HvLekvhup2XBK3JToyvmBF7nw7B0CLErOBc1A=; b=D/D2jK7sp374QMHJ
	H2e42JSrk1/dO8Kfs+sqpSiyuE3CiQBaj9HLTeuj2LttAFge70bxeCQOpYlR/NTQ
	Lt8s96POUO/SQbTPmlTWJ8fq4yh3QkXhOYhhlLDpUKk0va4O7+1qhyPsnDQ/DMIN
	R77zdpCZvcD0ZVi9KdVVzPOK4431qfpGJ2vQK5WK9ShSdb4VJ4TIU6epjhvee8DX
	XA/tKuU/WJutt6ZopHZ7czglmITuroV1RXPu09Fkh73AkVguKRDh/QT6QJkgv5yu
	O4nY14i6IgpiIh7V7+fRG698CAEFfA/gqoTNJtpbBGx8t9MPPX2VIuIz5lNxedLt
	xBNeLg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5munq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c33f48ee4so7624721cf.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677465; x=1784282265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TPH+i5HvLekvhup2XBK3JToyvmBF7nw7B0CLErOBc1A=;
        b=d0JIck982Xf+61T8uTc5kOHM7MzsAJKes5RtNLuM+u7TD2lwQxpN6JQ4hWjLP/ZN18
         /f4i8iMGO1hK0y2M+eX9TSE87H3OTT/rXwYGpHJdR3sFTOoGrxKv3kZMRT7TLzm9Co0x
         QxUa8haEt8gINU6ZGNhK9PwvI2jUO6e/nBLo9rY+tstb7/bf4ntRmJC4hVb9po+JaLvK
         rhXp5YI89FOByMyRO3lEtdBXYUb0sGlHxD8vIheg9j3+gcAHCapo6EZpyaLpxXKZDOM5
         L+ZWLBXq5h26qBzGKHR7lmkynMpkilwXxFMQkA6cUF8jqAonVTuwI7hjIIpWMOgxVI9Y
         dshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677465; x=1784282265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TPH+i5HvLekvhup2XBK3JToyvmBF7nw7B0CLErOBc1A=;
        b=Xnf+s6opEls6o4WPhIRjPdxFqVXL9AZ4im8xm71QHS57IZXNuMzj9uKPI7x0HBGC6u
         1hnbUEkVNjdcLlttcGtc7ydkz/UZmAT4SuvkVH73tXVh3L8CmbvoHDgfq6rlVx0yi5P8
         XFd697XkHwx7GDjZFh9r7C5xIkcsndgnEvlkl0tP9Aqr/QImwS5Dv1tMZ7W0RQimeCFd
         sMu//qIZPrWRKiGr3NimP9YtZNA1jHQnCQ81UlP6PuRSQ1UTtaYugiE7NeLlqenwnSpc
         Oj+R6AfLrUBqNUrvcYnTj3rF0QU7xrG+gr6inU8hlMpoYnPOA16gEpblfe0TiKlqDpDc
         w6kw==
X-Gm-Message-State: AOJu0YwANnq/VkGA3HsRE99+yuof0v03MfP2gLygiR6o+t4dnWhOAGS9
	HleFWUs197JqJq9g3N48eHVuUeMgF/bP24+QqWD5ewPjWjKFQ8zn2vDFvPM04uf80NdOCdamuBn
	Hjq5kIFfH4tKaxzAYzIjEbcDJuec8hf16nrEkZ+EGPXmcsHjBfj2c/9hWrfylXe4=
X-Gm-Gg: AfdE7ckHsL4OeRVFsLTjwc+ZhBuuUkdmds4RPo+7lso4sDqLcRjyUsnin27Jgp3ey5l
	e4/qgrCDtw/j1z/ZuYHV3L33lM4Efxpi+8aG2Id5hw3YvKn4DvwFPwOIn/hg5UOYpf0Z62L+dqv
	L53V7iV1rwfZa06gXzJMvM6qlzK2ZpuVB3UrKLQkZZXmW5XdKexVpYc+ZkUVdHSVneeuukJTDz2
	aC6AFwZAfvJXsqY2FWTt/vyPSU4fBC7EHWyp9NlytCawWDPPEto84gErs4sYnVWH5rvvHJj5fVV
	A+7y9uNbkith0xaIPHU5cq2GQaKs0Tu9vDiNLH45+8ODHTCFbGwTsZlMOIfoUogvO7L7p9U1JoP
	8R0/55sBB5zxFRvduHSF2IZKMTwNmhu523yhnySjdC/gDh0NloPCXqxmuaJNcvqe3IO7t7w5qyJ
	8T3s0+pGXEy1ygbZM27ov/TU5R9qY+SepravpGO6aqHkikowtP/1Cqac/1zF0p0o49fw821FCMN
	iUy7e0OV3j3OEddD+8T
X-Received: by 2002:a05:622a:588:b0:51c:7b12:5ffe with SMTP id d75a77b69052e-51c8b5767ecmr113377861cf.74.1783677464641;
        Fri, 10 Jul 2026 02:57:44 -0700 (PDT)
X-Received: by 2002:a05:622a:588:b0:51c:7b12:5ffe with SMTP id d75a77b69052e-51c8b5767ecmr113377591cf.74.1783677464091;
        Fri, 10 Jul 2026 02:57:44 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:43 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:33 +0200
Subject: [PATCH v3 07/11] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-7-46253587af64@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 8cKAK5ETeMs9NJcFFl0h3h-w0-MsJyvz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX21fxBwDsjryz
 1rGYljCM7DSY/+EIlITodthb41hEEKv0qUE6eU4wgLXTJeduGtizlhqnEIK+mXeL4TN0e8ZHr0B
 340lGp/jyk1LwmmjsLdTMYbniry3voQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX1whRNsFcPRif
 3a1VHcEExzz9YcKGsKcM/Iqg1U5t/8KDLAtuZEwsDCzUil/TGcQDwwNzp3qGayYl/VQEVEdKlVh
 h9GMT4t8pZZNUCW9NJW4Px/K1Q3ROZ0ixMbyhxdksNFKFtvn9kJ1q8GwzRuBg+hZxDEcblUirp8
 YBkhTyIBuowQcD1ShDgNRPxJhVRI7h55cm6Ey2UMJ/YGVSAn4z6+NJxkcDcMjOoI5/dTtWzTwhZ
 7lcQhQnmjeihvKXut6bfZKRmfxr3/sQlF1EQ7q2JeUIEJ51pvb2hiWsI1y8EHE5i8GQczV14MDh
 +kEEBsxnbzaHNy7u0ZIxBWxqJppxBlIX3WGFjHBzzG9flSHqqnImk/CODCnovbPkqPd7LN5AaSY
 7KXJLY//sF4f4wjYe+g94p8PVe+pCECvQFjkhNEIW88ekZUCxJFzZhufv+zKwQENUU82q3fn9gl
 YzR3uNfiGXjbwya7MNw==
X-Proofpoint-GUID: 8cKAK5ETeMs9NJcFFl0h3h-w0-MsJyvz
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a50c219 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Z5-lucBUan0SmjtTDS4A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

'bt_power' is allocated dynamically only for a subset of SOC types, using a
switch on the SOC type that mirrors the one that follows it. This is about
to become pointless as the power sequencer path (used by M.2 modules) is
independent of the SOC type and needs 'bt_power' populated for any type.

Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
allocating it separately. This drops the extra allocation and its dedicated
SOC-type switch, and removes the need for NULL checks on the pointer.

No functional change intended.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 72 ++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 46 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4a1ef316e715f4f1f0c8f7deafa971887af040f3..24dc5bf6d192be7e1d500df6bdf36e6184f9eaf7 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -226,7 +226,7 @@ struct qca_serdev {
 	struct gpio_desc *sw_ctrl;
 	struct clk	 *susclk;
 	enum qca_btsoc_type btsoc_type;
-	struct qca_power *bt_power;
+	struct qca_power bt_power;
 	u32 init_speed;
 	u32 oper_speed;
 	bool bdaddr_property_broken;
@@ -1776,7 +1776,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (!qcadev->bt_power->vregs_on) {
+	if (!qcadev->bt_power.vregs_on) {
 		serdev_device_close(hu->serdev);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
@@ -2242,7 +2242,7 @@ static void qca_power_off(struct hci_uart *hu)
 		return;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	switch (soc_type) {
 	case QCA_WCN3988:
@@ -2256,7 +2256,7 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power && power->pwrseq) {
+	if (power->pwrseq) {
 		pwrseq_power_off(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
@@ -2313,7 +2313,7 @@ static int qca_hci_shutdown(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 	int ret;
 
 	if (power->pwrseq)
@@ -2345,7 +2345,7 @@ static void qca_regulator_disable(struct qca_serdev *qcadev)
 	if (!qcadev)
 		return;
 
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	/* Already disabled? */
 	if (!power->vregs_on)
@@ -2417,26 +2417,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
-	switch (qcadev->btsoc_type) {
-	case QCA_QCA6390:
-	case QCA_WCN3950:
-	case QCA_WCN3988:
-	case QCA_WCN3990:
-	case QCA_WCN3991:
-	case QCA_WCN3998:
-	case QCA_WCN6750:
-	case QCA_WCN6855:
-	case QCA_WCN7850:
-		qcadev->bt_power = devm_kzalloc(&serdev->dev,
-						sizeof(struct qca_power),
-						GFP_KERNEL);
-		if (!qcadev->bt_power)
-			return -ENOMEM;
-		break;
-	default:
-		break;
-	}
-
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2451,10 +2431,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		 * the M.2 Key E connector.
 		 */
 		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
-								   "uart");
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				return PTR_ERR(qcadev->bt_power->pwrseq);
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
+								  "uart");
+			if (IS_ERR(qcadev->bt_power.pwrseq))
+				return PTR_ERR(qcadev->bt_power.pwrseq);
 			break;
 		}
 
@@ -2465,8 +2445,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * let's use the power sequencer. Otherwise, let's
 			 * drive everything ourselves.
 			 */
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-								   "bluetooth");
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+								  "bluetooth");
 
 			/*
 			 * Some modules have BT_EN enabled via a hardware pull-up,
@@ -2474,21 +2454,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * through the power sequence. In such cases, fall through
 			 * to follow the legacy flow.
 			 */
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				qcadev->bt_power->pwrseq = NULL;
+			if (IS_ERR(qcadev->bt_power.pwrseq))
+				qcadev->bt_power.pwrseq = NULL;
 			else
 				break;
 		}
 
-		qcadev->bt_power->dev = &serdev->dev;
-		err = qca_init_regulators(qcadev->bt_power, data->vregs,
+		qcadev->bt_power.dev = &serdev->dev;
+		err = qca_init_regulators(&qcadev->bt_power, data->vregs,
 					  data->num_vregs);
 		if (err) {
 			BT_ERR("Failed to init regulators:%d", err);
 			return err;
 		}
 
-		qcadev->bt_power->vregs_on = false;
+		qcadev->bt_power.vregs_on = false;
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
@@ -2522,10 +2502,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	case QCA_QCA6390:
 		if (dev_of_node(&serdev->dev)) {
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-								   "bluetooth");
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				return PTR_ERR(qcadev->bt_power->pwrseq);
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+								  "bluetooth");
+			if (IS_ERR(qcadev->bt_power.pwrseq))
+				return PTR_ERR(qcadev->bt_power.pwrseq);
 			break;
 		}
 		fallthrough;
@@ -2549,14 +2529,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 	
-	if (qcadev->bt_power->pwrseq) {
-		bt_en_available = pwrseq_power_is_controllable(qcadev->bt_power->pwrseq);
+	if (qcadev->bt_power.pwrseq) {
+		bt_en_available = pwrseq_power_is_controllable(qcadev->bt_power.pwrseq);
 		if (!bt_en_available) {
 			/* The host cannot gate the BT power individually.
 			 * Treat it as always-on and drop the pwrseq handle.
 			 */
-			pwrseq_power_on(qcadev->bt_power->pwrseq);
-			qcadev->bt_power->pwrseq = NULL;
+			pwrseq_power_on(qcadev->bt_power.pwrseq);
+			qcadev->bt_power.pwrseq = NULL;
 		}
 	}
 
@@ -2594,7 +2574,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:

-- 
2.34.1

