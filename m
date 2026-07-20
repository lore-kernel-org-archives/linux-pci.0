Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518893CE0A4
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534666; cv=none; b=X3W1uAXxp3AymqY3quHOqS/fy5PC7JMiq6wvScIRuvyYCHb8WfXRE485GkYS8IVDUON8IGApnz0tOen7Ekw9KbCoU+XH8Pdiv93jXWVxRB2k/oJSVBr6GbBRL5yo4ORlqVzh/TTHyCnz7PrEc4nhxatS+U5zG6udoxdCldz/Abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534666; c=relaxed/simple;
	bh=bnTEeD/UVWG+A8qIsKS5oxfA8TAvilyqIIn+RIIDBIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNBYwVc55yrEgOfXQR7e0TqXWUM2hpePXlBNKMkEW+VDw8GtdzwJ5BQrtE/uejdspmYSJEHat5zqc/wv14+eYAq5rRONqYlJsTNVwKhVcUr/Gjpwzu8ohONvnKXe11Ph8cKLP1BSl8sWsNabS51Y+wSk3/9MyPO7gpJwV+BxLeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NfXDaUaN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L34mWyqs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NfXDaUaN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L34mWyqs"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RrOq1263334
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pMLNj+8YpE+ddjFeUDPdXAz+LLoQFrp5xWINARMGems=; b=NfXDaUaNdKUEhoY0
	lnb88ULUhmZaJnNbyOwdDE5UzJ8W2wuFSowyaB2hqJOEnmaVokWErGinYszlqHU4
	M0xvahGmm+pIjxP5SZ7AHhGTjgjJ/LhkIU/LjLc3V1YZdlIVQtZPsZUm3+6jUy79
	lixPhQJ8OtIHuGxmRur/3ElPVvMjZWTUhhjvqMuqselYABDzwuU8Tr5PvQ2YA1kM
	dodwhZip4qcsf6guvDJQKOo7vtJ4mxGIYIfmjkWb1pBP1uOXWLe0ZDOMbP0lZwQE
	+HEoKsGUmHSVoW8h2/zRg4qWOvUB5DfuqjPf70GKeppcES5x3KlkkN+QX3mTWZ9m
	JJRGtQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhn2n3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ec3314f65fso198505766d6.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534661; x=1785139461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pMLNj+8YpE+ddjFeUDPdXAz+LLoQFrp5xWINARMGems=;
        b=L34mWyqsDSHCVQs9L7puuu7BsqV+Ozj9aF8BZEIQBa1MviqG/dPsUnE2j6cJruULqg
         2NmwOY9h0hug81EPRn2OxCLO19J/PRxio00GvOZwvGYykk5oKdQLf5hqwLpZHL1/Sq75
         8afdsLf0MVYwoOfuCZGc3Jp6DXiD/ZZkqN/xM2j1CmiYkP+7RWTTBNu9gi2nAHG0j3Up
         6wlMGLm1Z5wkhXye5zN799GPFcYLVEYRxbqVDFuqQjIZk4Cw3dTqO/JWANOkNtDp4+vl
         DAqOJAi2cyhimCnq4TWJX6qGEIGZrFlTOTKglPYf12O0t0EjTNpbjrNZGUacS2w/nWG7
         MHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534661; x=1785139461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pMLNj+8YpE+ddjFeUDPdXAz+LLoQFrp5xWINARMGems=;
        b=nmjVP++k9U6j9k8WL9uBQmTi0zKyuHfNZ0f3D9c2vuGoO4Tma0KlG3MDtvmWuk4GJj
         m4OsEmkJiK0XAPyN36B5uGhtxIlr/CYWVjyOtohWrRfGo+Uzjm6bkJK8WNyijf6QVVgo
         uC850OskRrEWGDjxNg8naqgHiiooykWhL43Esx69X9ZebyZPPlwKMCetHsW0ZTOmyaVZ
         nvsixeYkyfHI0tAQAl8JFeIR9QbSQYYuPhO9rFoGOJf4sid9JQDIMfB1UCggIecKQurg
         4/5WwRZXfsAWEz5E5GMoQc1yfytJyK6PDIkXc7lE7y1O9ermAjMWcM9jTo2xtHLd6HrN
         DNjg==
X-Gm-Message-State: AOJu0YyXjgK1xGDK3U49VXazS/8BxNCzP/vmwc1EYy1LwdxNqOzA3Mr4
	0fZdyotix6Jzpt/xwKReQJyYIjgIxb7WH8blQve0cS9dqYUMnAzlmKag4829QaPC1PMHj3WdLAU
	ny/HaGmVEA3C5YCUeDhCGZNVD4qYuNg/xrqQqEEuaIvpZkf56HsJ8/4hST6A2RHk=
X-Gm-Gg: AfdE7cmHjjOYYeDGqpPo2CKO4LRDfuZyTL66xWJlfO8SmnI8uFsPAS49DNZF9YgdrR2
	UbLt3lqi0tba+Mp3VRuLvGtMbGAKGPZv40PR4VEAX1TZpKmbCc50adAZcR0hErGXF2TZbevsyzF
	3EwUmGG8okfENePGG3l9m8qI8nztD6GaSkwt/swE6LiiuVvUO1X+8veac6swzTD2sUbntRTBJ8q
	OG/SGUoXzAeQGsBqp+8rVXYpkkVI0C0UAgNOWP895Y4NHDBomFvgmUmYRfD4/eGagbTLChdSNoh
	CYluaCCHz7jO8DDpvn36NPBsfI76UXP6WMhu5FqIsLoTJ+iaDVCqRpk+N8mdZvel3uhNQcTU847
	LiL2Qk9dOCTYY62JLn2PEv+xkMdIKyKh4L7f+3ZyJRm7SM9exMConhwhfPonobH6QkF/K+2zMS+
	TUQwNhFCeTxSlCEZkmiR79ky0YrA62G6a52mqobCHMhg4DXjTkwgg=
X-Received: by 2002:ac8:7d10:0:b0:51a:8c97:938c with SMTP id d75a77b69052e-5213e182f07mr124772271cf.67.1784534661084;
        Mon, 20 Jul 2026 01:04:21 -0700 (PDT)
X-Received: by 2002:ac8:7d10:0:b0:51a:8c97:938c with SMTP id d75a77b69052e-5213e182f07mr124772011cf.67.1784534660628;
        Mon, 20 Jul 2026 01:04:20 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:19 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:09 +0200
Subject: [PATCH v5 07/11] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-7-69ec6743543c@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5dd686 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Z5-lucBUan0SmjtTDS4A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: SjsFFCwCVN761OBr3o3-GnwHDkPiTBPU
X-Proofpoint-ORIG-GUID: SjsFFCwCVN761OBr3o3-GnwHDkPiTBPU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfXzBoNUVPzot3l
 tpaWrq06mObSXJxh5MXKt6023imCcc2KYSUG0WoBffwTOFdCh7MJ4bxP5y57rWZvVGiVI8Gb0r4
 V3yDctvp+ClJCMVfDnG/kCgoEznVPznoLPdCeXkFZpgI0OIsmYrZaRCVFhHPLUiCSH4NxQgg8RD
 SD4ygbuOBL/F9/2yjCF5nUvItkvVlV97uPcZuymaEdXGPPmzluowpW/KXANfwzQk4aef54VS82R
 S/hdiBEBI9nXhRUaDooG9Nq27zl0URYOwgK9TnrcxurVKFXWymimL/IcMo1GfiMcwzyB4mLAbjC
 7tId0UUOixz9L6Ypd49ZWPjreVBAEfX/Kxtloi7hUTx7LoTVjrTfP7iLTGk21BJHoEoLITHNIuA
 V9ISYEwjlK4g1exJatbx8wzCSbYvTqKHlH9RUzsFq+pRDdA3bzPfS11B7YVaQ+W2kukv8aWfkx8
 fvG2S6eJmL+QOb4QuJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfXzw6IcEB70QIi
 tLGGnCjC617aRMWbmZzwA5Hk4RHqPL1xICl+w0WOiGsfEUitmfaSRfF+lfB6jx0YUFrN2e0oJHm
 RrnBCNycoRV2wgbI7ikDNzRGLJmYWzY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088

'bt_power' is allocated dynamically only for a subset of SOC types, using a
switch on the SOC type that mirrors the one that follows it. This is about
to become pointless as the power sequencer path (used by M.2 modules) is
independent of the SOC type and needs 'bt_power' populated for any type.

Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
allocating it separately. This drops the extra allocation and its dedicated
SOC-type switch, and removes the need for NULL checks on the pointer.

No functional change intended.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 72 ++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 46 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 81fa41915363ce577ad7c6f25fe1b0a69536d462..7e4cb03d3db0722e5f9fa2e7a5a9a0894bf4f18c 100644
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
@@ -2549,16 +2529,16 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
-	if (qcadev->bt_power->pwrseq) {
-		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+	if (qcadev->bt_power.pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power.pwrseq);
 		if (!bt_en_available) {
 			/* The host cannot gate the BT power individually.
 			 * Treat it as always-on and drop the pwrseq handle.
 			 * The descriptor itself is still released by devres,
 			 * so dropping the handle here is not a leak.
 			 */
-			pwrseq_power_on(qcadev->bt_power->pwrseq);
-			qcadev->bt_power->pwrseq = NULL;
+			pwrseq_power_on(qcadev->bt_power.pwrseq);
+			qcadev->bt_power.pwrseq = NULL;
 		}
 	}
 
@@ -2596,7 +2576,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:

-- 
2.34.1

