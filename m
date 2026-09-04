Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803C501F3F
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536570; cv=none; b=J+CSNbTQKbHaQRZe/N/e13b1mbF80ULLiLcjfK5hU3pFUdGMFI3qmMbrE3kDNJXmCI8Mq7rBvv1zaTbt8nYIfHUWvw3fqCbi15bwfsGUY98LZ6plcDtedza9u3jJ9iO9OW+PTDGmSY9z+y20l/bcjx+nhhjhXmQ8DXcQzNOQY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536570; c=relaxed/simple;
	bh=b1TR2pqK8UJ/JlXul7C47szMhQ5AcfN48BdqST6LpvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RarQGTd1rzovC1IHlhTPaw9CGQ7iLoWsHhaS4Q+H1nUafLrlG9puSBavmbRzleEsETYqg+qqIwcg2UGrbdKQtyQEOd9BwvKiJZHAyf+hVtbZ3SWnsjITtnDMvoojXNbaP/6U3tAEox4FUAIN00kJFv1nEdAxPNOOUdDoMTcjBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bc8alp2R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KuMq5ygT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bc8alp2R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KuMq5ygT"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684EigCB3329807
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2026 15:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YwfxVIyuLh7//i+KBksOTM7bUklANqq0Gb6i7boEe8A=; b=bc8alp2R6YmdF8iF
	ZF4BIBhMqoABQH7YNXRoat2VDZxoCj999D/qbMhnTPhlkt+j9+PRRtpJCoOdgB1h
	9y49iyiyxyinnekmGEa3+kIWy5PtoaylxeyxeF1BQqzRnL3PtRgEvC3ur+BQPUUE
	9HgdSbKTZ5ugfLs8D1Jtik6yPts9Eka6i8WvIehn2d3kDRpmiVjFJJKrRzUEeh1o
	+wVvM7MAL0fV3vhN1Tn1Wj0tn9s7W9Nk7PDhzcC2PGu/4f9rNYSSYS9sQVA1Dqfu
	0mR3fl0aor6e4odoAhXdr3IHN0fmRiDoowvHPN14D37q4v/ztKJd6MforPkuJSn1
	zob4Uw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg00y88sr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 15:42:36 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97e99aaaa6fso98173241.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 08:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536556; x=1789141356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YwfxVIyuLh7//i+KBksOTM7bUklANqq0Gb6i7boEe8A=;
        b=KuMq5ygTiUvXH6rRtuntm++zIopRPVIEr/fPkSPbVJ5MBdT2X8fhyCouaE7FFesSoC
         YdbPA1l74eI1GQU2MVn4eQ9N1LQ6D6km2ep68JBfcTc6a5zx6tvrbM2lWQU+mMm+Zy7/
         BvVEqr9sMPsA90j9R9XhCYYDY4nCJiCUGbLx3RWtlOkBvyiDDxX7JfxcIseMq5nLJZO5
         2K+oVKIZet9ExOIK25LWfH0qbL9wEErJLjbCHuZWrmw4TCZLYovbm/Kzobg5ByCdXYa/
         eewoH9jIJSAoYh+xq5j7GhOg7yt9Sk9KgAcdv6vVFZKJjq8wSy6WHKMdO3Pq6EpXu8CT
         /BUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536556; x=1789141356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YwfxVIyuLh7//i+KBksOTM7bUklANqq0Gb6i7boEe8A=;
        b=LOrrxoK1rIq824N4MxQEwacla/kl+aDAYGCBMCoAw5WK1Kbq7cm6zJDXcE+iyK1bjg
         t+1DVKA/G+tsZ1LPB7dKeebV4o0IWhHeUPRdb9kJLkXdbXaCAGNkMrJ5NAaaGkjHp4fj
         /F7HLpXqbt8rJ8jWJ93oNwuB9guIaRfWJmx4VJ5K3GMZMUPgjCY6SBnoBshLVKbaV2MJ
         9ndU6utMNrM0uYF8gwWqbhPDUDaZG+oZF1lpiNzK0grO/me/eu75CjlTO4NvT0/n2omr
         4bDJIjvKD+7a5zNHFH6Rx+4ZvzDwOiLUdlfSU9E+PRfgLmWj79L2bK/pFQQ1773AG95I
         XXqw==
X-Gm-Message-State: AFuF++n7pOjR8GFkiPvlSbimZNMjQrrnWUprrG8nDDKdi62MDBL5OgHs
	fwpIYxj5OpNHJ/jsxjM8BhU+rVOjszIW8HTWdVG/TV/iujoLBGW2f7N+FXTz5wURF3Am7VyPZSl
	twvmUq0rlOf79nkV5elbMDnfEhtjFTZgvx0gvaOII9TpLmlLkyLx2FxucRyUONDA=
X-Gm-Gg: AYBFou2LpdiVWhWCpvxKW5VWGp0ztMDoy/gFoz7wBudvVO0PXxF98pb288P9rknYBq4
	7Nr4jRaSCjTf+JTa3+/OZaOna786HSK5CcS3Aes02W6eGgwJn4s1nf3txKRH5ROTYNlVSSbG04t
	TlXAfp9FGLVF0Kzq+NsWSjKQrT6RFV/u/hAdjDYBW4afFwrJu4ZOAONIuyW8PWJtvNPUar1O5FN
	n7S/bNaf6ICdsuoYyDyVDrbghb6fjB0TbHlsH9A6c9qzPuCMq93wfQK7Is+3JOQTSw3TbxOdIVQ
	yzFdF0KO07HXHIDbScnxtnBK/GaYJPRS4r4zD4lM54ZGJQffl96quwZU5m6cjOZWUIsdRWNlwLZ
	VUjNMylFqYYqLCWNC0LVYBPk2NeyHnyWlpIt1agk2JR+8EMdbuxIuEzuvDZzdaaG/J4DXrS3VQm
	U9Mj7iX7+cwszsCq+TnueSodrJRx+DetfMzl3YFGXodDv8ZVK62EE=
X-Received: by 2002:a05:6102:a1d8:10b0:785:e069:6c5 with SMTP id ada2fe7eead31-78a5675c4eemr812150137.8.1788536555470;
        Fri, 04 Sep 2026 08:42:35 -0700 (PDT)
X-Received: by 2002:a05:6102:a1d8:10b0:785:e069:6c5 with SMTP id ada2fe7eead31-78a5675c4eemr812120137.8.1788536554895;
        Fri, 04 Sep 2026 08:42:34 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:33 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:22 +0200
Subject: [PATCH v6 07/11] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-7-d8c5042b3efd@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: SahzXVn4vqGrAADZFCtvhrW74JaUoA2p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX+GfFog6vsYhF
 akYJdNes29ZUlDwLHT8ZEO0FYCXAHGC5GX7OVVPDfvN8LXEvzf9ig9WNIoVk6FT5nDQBjF56TWH
 3mPVNtS/J3kgJmRS55WY5v9nsu5P5m+NRUV4PQkgfI4vB1LTYyheSaMohjGWg17Byo31Op+Zs80
 pYVK96K/DocDCC0tk769hgwbjolzwhKCWuiHug3Cikd1U8SDQBFwBnMKOcstFWv5tMC3xP3QCBj
 1ox85IPtVWF90Z++6/FT0YDDHA/vE2qMk5vbqGdtsw13wOihZFwG7Ota9PUYYL4uQHJ64DYBhOY
 IqCHmjmW6eMpy4jQl/jx03ZDLYM32PkMvDcpsfKJ4kz/XWoGYGIwbfcUvRjBtZR5BHS3VOmZNxi
 ALt5pssKr4GhflBGq9jbPVfOmHzdCjCu6exqV8tNXNR9T+IkoIHK5Eh1RpATMxd7dJxGvNenxwx
 W68apD2fuuD9Edfsgvw==
X-Authority-Analysis: v=2.4 cv=TsPWQjXh c=1 sm=1 tr=0 ts=6a9ae6ec cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=-AHguRIk9tBBA_P1FkcA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX36ihoGOJf9Uf
 ppxgp6JE3S/Q7Qxr1o45U4AgRwuyouu0ETWJJxTs2kvARq5nJhdkoyKmxB7OEycIhZ54ZxBQ9NM
 AvRwwWeuS78AAqrSlkiaGrrCqf8A/gQ=
X-Proofpoint-GUID: SahzXVn4vqGrAADZFCtvhrW74JaUoA2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040143

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
index 9d27cd851b4a685ce42201b0d40ca6ecbeec9cb1..30586120c4a73a50a29af235b511c3ae97960e27 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -225,7 +225,7 @@ struct qca_serdev {
 	struct gpio_desc *sw_ctrl;
 	struct clk	 *susclk;
 	enum qca_btsoc_type btsoc_type;
-	struct qca_power *bt_power;
+	struct qca_power bt_power;
 	u32 init_speed;
 	u32 oper_speed;
 	bool bdaddr_property_broken;
@@ -1779,7 +1779,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (!qcadev->bt_power->vregs_on) {
+	if (!qcadev->bt_power.vregs_on) {
 		serdev_device_close(hu->serdev);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
@@ -2245,7 +2245,7 @@ static void qca_power_off(struct hci_uart *hu)
 		return;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	switch (soc_type) {
 	case QCA_WCN3988:
@@ -2259,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power && power->pwrseq) {
+	if (power->pwrseq) {
 		pwrseq_disable(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
@@ -2316,7 +2316,7 @@ static int qca_hci_shutdown(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 	int ret;
 
 	if (power->pwrseq)
@@ -2348,7 +2348,7 @@ static void qca_regulator_disable(struct qca_serdev *qcadev)
 	if (!qcadev)
 		return;
 
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	/* Already disabled? */
 	if (!power->vregs_on)
@@ -2420,26 +2420,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
@@ -2454,10 +2434,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
 
@@ -2468,8 +2448,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * let's use the power sequencer. Otherwise, let's
 			 * drive everything ourselves.
 			 */
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-								   "bluetooth");
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+								  "bluetooth");
 
 			/*
 			 * Some modules have BT_EN enabled via a hardware pull-up,
@@ -2477,21 +2457,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
@@ -2525,10 +2505,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
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
@@ -2552,16 +2532,16 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
+			pwrseq_enable(qcadev->bt_power.pwrseq);
+			qcadev->bt_power.pwrseq = NULL;
 		}
 	}
 
@@ -2599,7 +2579,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:

-- 
2.34.1

