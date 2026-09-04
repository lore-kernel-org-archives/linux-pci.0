Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C3503BC9
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536576; cv=none; b=EpPZKLVuXp+ltMDf1OJZB0no/hZgRb7SseUvL7MDmcaKIswhn/fKcKJ/y9AJKmarMhY01iEPflSVEZ7s3iadDM6UmjQ2Hb25iLaSBDeN6hu35xrAw/BqeZxlc9UuoPUOZq2AZF0gabx01LY3iibbGJcQHmjnovZbM25i6pKii1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536576; c=relaxed/simple;
	bh=YCIWSFqXvG0Htk2WgfzGGPg3a2awjtggrtVO72ie120=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQ4Gr9bRxnFA65X9Ga3APHB/ofMQfrHybGOG6XxxV44bjk1gp7dk+hm+O2HGdnwhnkUKKUyhUGCuiCAX5mUjS7bgwjnPePdxlBG3aiVX4AnwBbTA3t4zY9pnMHiqQWmce1WUcQQnolzFeOjelqJv1EJKlPeJwbK9R+m6a4ytZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f42znUV4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LEtMSiMz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f42znUV4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LEtMSiMz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dh5KT3890992
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2026 15:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FJHtkuDgx65JWiN/Fuqm1kYGp2m2CoyBUOoby5Sv6h0=; b=f42znUV4QQA0d5k8
	WuG+u4rU01UvJtnGEsJSnUCuMUS5aDPdoatKRX+CENaSzTbqsMMphFis293gZtTt
	fJNpi30bOLt8t+PHwky7Mm+nca4FKVAVQr80cRX7+McxLdjKEMCrccCV8o6CDFFL
	CO7jsP0n+fqfsYJS86CIr6+5hlP+W1KNVCud5w6m4mJoKROmvGZfRET1yg7s5HH6
	qdMvy9MCSYV9qVJY0hMm1kkHSFiIKYfOmSv+VgrfSax51EC5tA2qb2SRtGi1O04k
	vmV7Nm06LwXtFei3o5etQf8+piRWox76Q3LfWzmtpfuUoqSeN2w9TqUHUpdBLVG8
	9XEPLw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp7839f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 15:42:39 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-98087b0c5deso835401241.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536559; x=1789141359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJHtkuDgx65JWiN/Fuqm1kYGp2m2CoyBUOoby5Sv6h0=;
        b=LEtMSiMzZWDnwribHA3nbZXWVrDeHEJxl2qbMWzHm1Oqu33L08+sCkzynI4gCHejrB
         o51BOxAFcxIhQ/4Pmn2g/z3YHGeRqY8Lic4Pe3fmRyY8XUW1GWwM5QcRW9Uj5XXdazF7
         OAeGQApjyYU+U+crOmc3k+P26huDv2nnqP20TJ+fhPh+1ZWtl4lH140LlVCPRkMIAohq
         LP52vsRmCOm83PqXltOQ47XBYLAjjo7RUf8TGxn1dPsoMhcGsMiVxBnLH8b2EPw0+Xcb
         lkP53tXRmdwbd9y9aSWEs0S0hokRunw8VH0RoL+YId3f5TYRvLutq+nCirbL5tf27yBx
         iuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536559; x=1789141359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJHtkuDgx65JWiN/Fuqm1kYGp2m2CoyBUOoby5Sv6h0=;
        b=Jm7hqGcw1Xw7xTSdI15fgzD0lvsgr0t+qeMQGZ5X/7GfaAQid1tq7QuOots5F0WsMW
         fbinou18ZLItPkKgJLgS7JRMGOFHOPer5ekiralrR22zvH9DssBQU8dGV5ibFYpQOV4s
         39BL7bOQRxir+UjmfMZ7mHu91DA0Da0ZB4X8S12/yNByrGUe5LXbP7Y9acxVgkUOw3K8
         5ZxRiwTo8HgyxTrCNz3Nbi2uR8GznDKJ1ofDS6/tFL1MkDTEgqXpdSPxGGt00MnUZ8N7
         kLGG8pffhpeqdSRuhZXY7WQTjnD0Y4hGzYwxmJvZOMmiSw/Tlq9XMogwarNnH1LgnPb/
         zneg==
X-Gm-Message-State: AFuF++neAKy6p9FoMIoUpGt//zDuOvPOGJCK/RSImNPPhtu83R+YHJb1
	Dvs5ApPL8vbaVhLX06GxCQaJ+PiNnDwI2RqJhe3ETfDezFVwBXubHOHeMq1TPy9rmywjoCk7AFY
	7i4tX/nwpxZRUPLC9CA6dbT79Eha3DUYYp6N5TALbm0awhviNkYvKAml8zrwUlCs=
X-Gm-Gg: AYBFou3VM3677tViFhPZE1d3/sYAHfjcg9wyonEqji+1AVDSDP+U+38vtFArilFQI9t
	9AfUrBFfiAtMNZNZ0tIfPFuOsSqhaoPclpbHksR5kWb4lHNjYAQm2mwYyiia3vOLZsx6CEwINTK
	GDuAQfhLW0l0wusvy8PUgzUEc4+2zjClPvbXo4AOQTsXxvYzNqF8mp7JSWDwbxVg8B4tz9AI5hp
	0XzBMQHbVJY4DHL3lOm8kc6KFrUjYSkSW7qeMahdswPsDpVPF/a8KinzW93+Gc+P3JkxJPMx5tK
	SbOuzwFIFb4/GbwaMCe0WY17kGlc1XwzuuZ7qgTdpk+HiJ00ntWn0abRwMnoRKQQojeGVC9zYXx
	o2IFP1Xh7xx5qzeQh/g/AZer3aF0i6XF4RvOpiJ8vffCojoc9xzn7591XkGgft9swkRCf12UQMx
	BJiGfkw1aw3SRp1tt9rOyq7053561yTsCKNubsPne2Hg9YFJyZKRg=
X-Received: by 2002:a05:6102:91a:b0:784:ed9:1a1c with SMTP id ada2fe7eead31-78a4ab66791mr2919622137.12.1788536558830;
        Fri, 04 Sep 2026 08:42:38 -0700 (PDT)
X-Received: by 2002:a05:6102:91a:b0:784:ed9:1a1c with SMTP id ada2fe7eead31-78a4ab66791mr2919586137.12.1788536558377;
        Fri, 04 Sep 2026 08:42:38 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:37 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:24 +0200
Subject: [PATCH v6 09/11] Bluetooth: hci_qca: Flatten struct qca_power into
 struct qca_serdev
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-9-d8c5042b3efd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfXzUw9C70Llidd
 pw9u3ov8/7wHfvoMoR9NwvHRBZGs2Oic0lN8rTSyFLVCuv0zcTBEUw54vxengeMt504/P08UWRW
 mOX+MGn1MEpNZtMIZlll5lN0EN4wtHA=
X-Proofpoint-ORIG-GUID: 7D6pimkR12d6FWygyWJc7CT6P-8hU0tC
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a9ae6ef cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=IDBDRlgmZ80N7xYWSSYA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: 7D6pimkR12d6FWygyWJc7CT6P-8hU0tC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX0iArOli9hyfs
 Qhdrz+otRsAVz+FWzgBa62FxMOD5lWyRiqwbjDQbQouyFIYZ/qeJ810oIVj9qTphFjtzHzKAM+8
 G98WdONc8OnBwPieSBPxFVnYBDYr4K+zI5kbGNjcxDPIJo0GsqE1NSIv4hkOuIQX8vDRME3Jpae
 e0zL5nzvPsLjRAQOak5PuA6dfg37XJQW4IoH2utT7sltNJ85A+AjQhk2v+Uq0iHRMVd4y8T1YXQ
 TDUezxCe0wAZ84/QNPIyE5Z6EYmnn7BAnkhoOBz1hD30bRr0BlKDcsGCPA+l3Ul4VY0f8+gDror
 /FaOQ9tjY90LbrQetiMgywgIV9fTfuxBWQbI5B4+M3vpSJlW3ou2NTIqBSlI/cYgLwSJ9ZQdeph
 UbYKRFsEJDMcasDGvtVeqYJamOzLnIQweRBj9ESvOg+p9EiukpY2z/SmuW/DGbYpxrZkRQt5/UU
 r8TPKXxcL8/xslmTQCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040143

struct qca_power currently only groups a handful of fields
(vreg_bulk, num_vregs, vregs_on, pwrseq) that are exclusively used
from struct qca_serdev, via its embedded bt_power member. The extra
indirection level does not provide any isolation or reuse benefit,
and just adds qcadev->bt_power.<field> noise throughout the driver.

Drop struct qca_power and move its fields directly into
struct qca_serdev, updating qca_init_regulators() to take a
struct qca_serdev pointer instead. No functional change intended.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 91 +++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 52 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index db0a968dfb00fa6f1abb86a3f6d1be89dfe80c6a..cfefa8b72e2527639299811d1b4f2fac697ee704 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -211,21 +211,16 @@ struct qca_device_data {
 /*
  * Platform data for the QCA Bluetooth power driver.
  */
-struct qca_power {
-	struct device *dev;
-	struct regulator_bulk_data *vreg_bulk;
-	int num_vregs;
-	bool vregs_on;
-	struct pwrseq_desc *pwrseq;
-};
-
 struct qca_serdev {
 	struct hci_uart	 serdev_hu;
 	struct gpio_desc *bt_en;
 	struct gpio_desc *sw_ctrl;
 	struct clk	 *susclk;
 	enum qca_btsoc_type btsoc_type;
-	struct qca_power bt_power;
+	struct regulator_bulk_data *vreg_bulk;
+	int num_vregs;
+	bool vregs_on;
+	struct pwrseq_desc *pwrseq;
 	u32 init_speed;
 	u32 oper_speed;
 	bool bdaddr_property_broken;
@@ -1779,7 +1774,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (!qcadev->bt_power.vregs_on) {
+	if (!qcadev->vregs_on) {
 		serdev_device_close(hu->serdev);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
@@ -1876,8 +1871,8 @@ static int qca_power_on(struct hci_dev *hdev)
 			msleep(150);
 		}
 
-		if (qcadev->bt_power.pwrseq)
-			pwrseq_power_on(qcadev->bt_power.pwrseq);
+		if (qcadev->pwrseq)
+			pwrseq_enable(qcadev->pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2230,7 +2225,6 @@ static void qca_power_off(struct hci_uart *hu)
 	unsigned long flags;
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 	bool sw_ctrl_state;
-	struct qca_power *power;
 
 	/* From this point we go into power off state. But serial port is
 	 * still open, stop queueing the IBS data and flush all the buffered
@@ -2248,7 +2242,6 @@ static void qca_power_off(struct hci_uart *hu)
 		return;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	power = &qcadev->bt_power;
 
 	switch (soc_type) {
 	case QCA_WCN3988:
@@ -2262,8 +2255,8 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power->pwrseq) {
-		pwrseq_disable(power->pwrseq);
+	if (qcadev->pwrseq) {
+		pwrseq_disable(qcadev->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
         }
@@ -2319,23 +2312,22 @@ static int qca_hci_shutdown(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = &qcadev->bt_power;
 	int ret;
 
-	if (power->pwrseq)
-		return pwrseq_enable(power->pwrseq);
+	if (qcadev->pwrseq)
+		return pwrseq_enable(qcadev->pwrseq);
 
 	/* Already enabled */
-	if (power->vregs_on)
+	if (qcadev->vregs_on)
 		return 0;
 
-	BT_DBG("enabling %d regulators)", power->num_vregs);
+	BT_DBG("enabling %d regulators)", qcadev->num_vregs);
 
-	ret = regulator_bulk_enable(power->num_vregs, power->vreg_bulk);
+	ret = regulator_bulk_enable(qcadev->num_vregs, qcadev->vreg_bulk);
 	if (ret)
 		return ret;
 
-	power->vregs_on = true;
+	qcadev->vregs_on = true;
 
 	ret = clk_prepare_enable(qcadev->susclk);
 	if (ret)
@@ -2346,38 +2338,35 @@ static int qca_regulator_enable(struct qca_serdev *qcadev)
 
 static void qca_regulator_disable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power;
-
 	if (!qcadev)
 		return;
 
-	power = &qcadev->bt_power;
-
 	/* Already disabled? */
-	if (!power->vregs_on)
+	if (!qcadev->vregs_on)
 		return;
 
-	regulator_bulk_disable(power->num_vregs, power->vreg_bulk);
-	power->vregs_on = false;
+	regulator_bulk_disable(qcadev->num_vregs, qcadev->vreg_bulk);
+	qcadev->vregs_on = false;
 
 	clk_disable_unprepare(qcadev->susclk);
 }
 
-static int qca_init_regulators(struct qca_power *qca,
+static int qca_init_regulators(struct qca_serdev *qcadev,
 				const struct qca_vreg *vregs, size_t num_vregs)
 {
+	struct device *dev = &qcadev->serdev_hu.serdev->dev;
 	struct regulator_bulk_data *bulk;
 	int ret;
 	int i;
 
-	bulk = devm_kcalloc(qca->dev, num_vregs, sizeof(*bulk), GFP_KERNEL);
+	bulk = devm_kcalloc(dev, num_vregs, sizeof(*bulk), GFP_KERNEL);
 	if (!bulk)
 		return -ENOMEM;
 
 	for (i = 0; i < num_vregs; i++)
 		bulk[i].supply = vregs[i].name;
 
-	ret = devm_regulator_bulk_get(qca->dev, num_vregs, bulk);
+	ret = devm_regulator_bulk_get(dev, num_vregs, bulk);
 	if (ret < 0)
 		return ret;
 
@@ -2387,8 +2376,8 @@ static int qca_init_regulators(struct qca_power *qca,
 			return ret;
 	}
 
-	qca->vreg_bulk = bulk;
-	qca->num_vregs = num_vregs;
+	qcadev->vreg_bulk = bulk;
+	qcadev->num_vregs = num_vregs;
 
 	return 0;
 }
@@ -2416,7 +2405,7 @@ static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
 	if (IS_ERR(pwrseq))
 		return PTR_ERR(pwrseq);
 
-	qcadev->bt_power.pwrseq = pwrseq;
+	qcadev->pwrseq = pwrseq;
 
 	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
 }
@@ -2465,7 +2454,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		/* M.2 connector modules are powered by the pwrseq acquired above. */
-		if (qcadev->bt_power.pwrseq)
+		if (qcadev->pwrseq)
 			break;
 
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
@@ -2475,7 +2464,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * let's use the power sequencer. Otherwise, let's
 			 * drive everything ourselves.
 			 */
-			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+			qcadev->pwrseq = devm_pwrseq_get(&serdev->dev,
 								  "bluetooth");
 
 			/*
@@ -2484,21 +2473,20 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * through the power sequence. In such cases, fall through
 			 * to follow the legacy flow.
 			 */
-			if (IS_ERR(qcadev->bt_power.pwrseq))
-				qcadev->bt_power.pwrseq = NULL;
+			if (IS_ERR(qcadev->pwrseq))
+				qcadev->pwrseq = NULL;
 			else
 				break;
 		}
 
-		qcadev->bt_power.dev = &serdev->dev;
-		err = qca_init_regulators(&qcadev->bt_power, data->vregs,
+		err = qca_init_regulators(qcadev, data->vregs,
 					  data->num_vregs);
 		if (err) {
 			BT_ERR("Failed to init regulators:%d", err);
 			return err;
 		}
 
-		qcadev->bt_power.vregs_on = false;
+		qcadev->vregs_on = false;
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
@@ -2532,10 +2520,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	case QCA_QCA6390:
 		if (dev_of_node(&serdev->dev)) {
-			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+			qcadev->pwrseq = devm_pwrseq_get(&serdev->dev,
 								  "bluetooth");
-			if (IS_ERR(qcadev->bt_power.pwrseq))
-				return PTR_ERR(qcadev->bt_power.pwrseq);
+			if (IS_ERR(qcadev->pwrseq))
+				return PTR_ERR(qcadev->pwrseq);
 			break;
 		}
 		fallthrough;
@@ -2559,16 +2547,16 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
-	if (qcadev->bt_power.pwrseq) {
-		bt_en_available = pwrseq_is_controllable(qcadev->bt_power.pwrseq);
+	if (qcadev->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->pwrseq);
 		if (!bt_en_available) {
 			/* The host cannot gate the BT power individually.
 			 * Treat it as always-on and drop the pwrseq handle.
 			 * The descriptor itself is still released by devres,
 			 * so dropping the handle here is not a leak.
 			 */
-			pwrseq_enable(qcadev->bt_power.pwrseq);
-			qcadev->bt_power.pwrseq = NULL;
+			pwrseq_enable(qcadev->pwrseq);
+			qcadev->pwrseq = NULL;
 		}
 	}
 
@@ -2606,7 +2594,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:
@@ -2616,7 +2603,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		if (power->vregs_on)
+		if (qcadev->vregs_on)
 			qca_power_off(&qcadev->serdev_hu);
 		break;
 	default:

-- 
2.34.1

