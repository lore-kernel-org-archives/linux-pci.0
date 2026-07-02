Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2C13C0A1B
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989200; cv=none; b=XT92Hm9rzqzsFwXB743H+I4VMV3cqnwgJGLKYs2kDKJb/2H60bb4bX12uq3DxOOGhU/ZNFBao64qQQCmy1fEq/3XjeeP3NLdIB+xNNI5jq7Wj0w0XhRygQYYrjpu8ake38wPjvbfrwf0crNdUAx3A+4C0UcO/WQM/dxYCclt99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989200; c=relaxed/simple;
	bh=d07rwEK7oQJoMCbcs1syF/OQ7vSvilkVUT1OidwjI6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jUawRCBM79AguEgfbsU2qVJbzFFqa6Cd14l6l+0mXvnx2TRNtMjEADUU6CzBlxB9nRvSjdFIB2XVIAZiV4WmsahKniawgHF8Ispvj/qBchpIUL1BCDntr7g3yM9RlVT1YZhdhFb6Sh87+Wr9fTP9YV+CMa1S6/NYF0EyDlsy09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bJfkgl4M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZxjkZVxq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bJfkgl4M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZxjkZVxq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628Cbj73050477
	for <linux-pci@vger.kernel.org>; Thu, 2 Jul 2026 10:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	buWuqZv0wJYcIIERzVOd4NOvM7xnqG9f4H+KVXab1/c=; b=bJfkgl4M2QDakoT0
	XRsvV2+I7igkZ2PK/BBbrHCGfeXemJxB9WcQVw2vZdxrfpKvQIMlni2NBiBBirXU
	bz7OqjPi+jNXuJEnd4OUYwYyqqxwvmZ8EYSOkNqDbpwPLJok0qUiIpLFiwD52MGI
	OSstWGI3+kYSFzljg5SbO1St07D6nRFJZWJF4uHTZGpnc6Fqne3ntWiwK8UUQlzk
	LY0JmZPNKEo9WZE6dzT2dwnGTz4yfD54dj4g14Nyd4r27GLzhQlRrH5uGTXQEsks
	pFJESnrZ15Uhea/h3aoiRmMpw/ANO5UEE6+74CzS4VtWvBPBfldtx40shDZCW/n+
	4qWeHQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f56gpum3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 10:46:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e663c29f2so54676485a.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989195; x=1783593995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buWuqZv0wJYcIIERzVOd4NOvM7xnqG9f4H+KVXab1/c=;
        b=ZxjkZVxqYKVocXysIoeXo0Qh5dl/WnrjunFTaOOv2DIDp0ZXeplG9B5jq61TvWM0lF
         W3sLzC3p42ok3nXRmPOXs2SYlrPAWzCrdXRB3bzbJMMkFYspr29XuDFTs/XrF6+mZ1qd
         5L1j1fokatTfyyzVH4BONDwO8J0VB3mJ9xZua4OkIk9bX1vWRHh2T0mLSAkKxsiT4dhz
         BqxzsQQgeb26xhjdMMn5EsG7E3hVB9bsdx1e3oxpQJsMkLXa01Tk9vOAel5/m+i0Zf2n
         IkgAzd8++epAiwVG/jBgU4+Qgzr0k+v4NSnFl6lLFkkK7oGQAmJCAHi0b+TdnwsXbPxd
         ujAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989195; x=1783593995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=buWuqZv0wJYcIIERzVOd4NOvM7xnqG9f4H+KVXab1/c=;
        b=bEHK4bgEfH+h1Gu4/Xaz6EUy+DiU5NVMoGYQkvNHqd9hTnKGC8SRUJX1zIvIa14Vsm
         0BBJAzX53TgQy1PfnLj/S5fQpFRW37ST/7gWDN17ltTOdw2SA2fZD5nbxyyN2Kw7GkEo
         3JIUI4RFK9G0JjSmGX09JgOM2aiDhCDqrv9ME5HVI7olbAORfADvUQEVqdqbveFlfq5l
         dbSd2LF6g/cAcpy3aTN7zh8Lqow7wKn7FzsTwOq0oQQH34DdWaWjdfNlMUe9dENYMudM
         i7VcUTt8FpT5Ic6B/SPDfHoplyoVdfN7PDT4s+PVRQjZsNK75ktoaJfhB1T8U/UDGs9S
         kyig==
X-Gm-Message-State: AOJu0Yw09o8ppvh25lYcij8QctdEAWvC59H+DKHe+LU/hMSf9lCth2Cw
	dtjW2AgrsIOnsnfLnt4yF6KtfvtsNy51IyBfIYQN6OjxfapJVwF57Gqi/qeg8TkRRR5GJy9lTZg
	LSHt6hkFFNP0mcXYITldh3GUuite6qVUPDS/L4KMXhRS/Ua8isUfwD1vMUb1fmls=
X-Gm-Gg: AfdE7clR6wb0FeB8xxQWa3FEZuUB5Udu7waWns/gYXGCBAzzFiLh8U5kNVX8xxtM0pR
	MN7fpi5oEIU40eIDeDBhveQJycaQSVHmX314MgRuJT7v9F/6lXpcwksVs+PC28G6wC1lVP3pBhY
	d3BHT6GSArN2bQxckb3/bodKEfuPos1LO05AMZyB+Bi1AnqLN5qIT6MrywHaNx+tKvbe/Ww/2ct
	fU+aQnAxw83KIkCuLnEUjLkVSAwmhCm5U0HziH0+VZmjf4Md4iqf7rBBZrmLFbVKHbrNGKoi8h+
	EC3WOA+l+DeqCPR027UnPmA1o1YkUKavdATIJsWAkSpFAmWar7DVVWpqQ6raRpWPLGHTo/ox1O+
	G6UxQtAoruXowmq/PGC/eQBozoGDR2MIQxgp/9a6pG42CYGffmSuZmLAtskn6pr4mRjoAYbR00C
	Vecxb5PQ/r9/4L2J9hSe17Lb2SnSbZXMzzoz6G03o16hRS/FHwbcQnxNvN0sZ9t4M=
X-Received: by 2002:a05:620a:4592:b0:92e:57ea:8c8b with SMTP id af79cd13be357-92e6955cfddmr1240421385a.0.1782989195284;
        Thu, 02 Jul 2026 03:46:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4592:b0:92e:57ea:8c8b with SMTP id af79cd13be357-92e6955cfddmr1240418385a.0.1782989194692;
        Thu, 02 Jul 2026 03:46:34 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b5ae4959sm109689666b.0.2026.07.02.03.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:46:34 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 12:46:15 +0200
Subject: [PATCH v2 3/4] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
In-Reply-To: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX9LFAp7Idy2d8
 wSl4sPjc2GUKEXRlKiQFsPGRmYvpaOfTbO44a0pGeEsKV5rLbo7JZuOj6OIovSW2Brzq1WjrDd+
 ra+XaMvtGwJRHsuwmoCjQUKpbXZn9TY=
X-Proofpoint-GUID: 4_p8Gp5AsEZfZ1hFt3iK7MmUkMeCe0aB
X-Proofpoint-ORIG-GUID: 4_p8Gp5AsEZfZ1hFt3iK7MmUkMeCe0aB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfXxdZYvIeZDlfw
 C+K4m5ZD+3FeQsjjDnUOFgRjYH3ywoJlvpSufupxm5Wwg7GMPMhN+fIBYUy+PTEtzs0K3d+FcII
 4mVkQn6HupdIlKiH/LkZ76A8Hxp+/2jlaSqxfTeYDbyCkVLDwbtuximvrPbJnwku7edxGCy3Vgl
 55MhKovqpBndscQ1XfH4Y+RElY7o/1O3QVFjil7t5EdbqCPAeAkOr7inOvhDF7/zIcNF3c9g641
 Dl053qp0UuKD3km0TtUorckFRV/ZZDYST3yMcARWqIyr+ocZHj8zOREvfenkAHTqZQp6jkrf53m
 mn6Nd50YAECZdy/GOWmZXDTzF4YfDa1gAEdqTg7n/Cvm5LUsrGAgCjJ2PCBg8h039DDXg1w9xAd
 Ow4s1ta8iiab9XyBjbnBU84BwU+JJhcn4hLofjBJweLXkZ7kbQeSp6VE1sepue6tX9+eHeiB4zB
 HF6net1oZn3CFaswjRg==
X-Authority-Analysis: v=2.4 cv=K9oS2SWI c=1 sm=1 tr=0 ts=6a46418c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=l-ki6R0DwxtWVe0rcmEA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020111

For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
sequencer rather than a dedicated BT enable GPIO.

When the serdev controller has an OF graph (indicating it is connected
to an M.2 connector), acquire the 'uart' pwrseq target from the
connector's power sequencer and use it to control BT power instead of
the bt-enable GPIO.

Also allocate bt_power unconditionally for all SOC types since the
pwrseq path is independent of the SOC type switch.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 81 ++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e09debdb00a1b8e74ccd5de6147e240e533b4594..b04593a96e14ac9e87ae76fa00eda308e81dea25 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
 			/* Controller needs time to bootup. */
 			msleep(150);
 		}
+
+		if (qcadev->bt_power->pwrseq)
+			pwrseq_power_on(qcadev->bt_power->pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2256,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power && power->pwrseq) {
+	if (power->pwrseq) {
 		pwrseq_power_off(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
@@ -2387,6 +2390,35 @@ static int qca_init_regulators(struct qca_power *qca,
 	return 0;
 }
 
+/*
+ * Acquire the M.2 connector power sequencer.
+ *
+ * An OF graph link on the serdev controller is only present when the BT
+ * device is attached through an M.2 Key E connector. In that case the UART
+ * enable (W_DISABLE2#) is driven by the pcie-m2 power sequencer instead of a
+ * dedicated BT enable GPIO, so grab the "uart" pwrseq target from it.
+ *
+ * Returns 0 if no M.2 connector is present (nothing to do), a negative errno
+ * on error, otherwise 0 with qcadev->bt_power->pwrseq populated.
+ */
+static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev, bool *bt_en_available)
+{
+	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
+	struct device *dev;
+
+	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
+		return 0;
+
+	qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
+	if (IS_ERR(qcadev->bt_power->pwrseq))
+		return PTR_ERR(qcadev->bt_power->pwrseq);
+
+	dev = pwrseq_to_device(qcadev->bt_power->pwrseq);
+	*bt_en_available = device_property_present(dev, "w-disable2-gpios");
+
+	return 0;
+}
+
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
@@ -2417,25 +2449,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
+	qcadev->bt_power = devm_kzalloc(&serdev->dev, sizeof(struct qca_power), GFP_KERNEL);
+	if (!qcadev->bt_power)
+		return -ENOMEM;
+
+	err = qca_serdev_get_m2_pwrseq(qcadev, &bt_en_available);
+	if (err)
+		return err;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
@@ -2446,24 +2466,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		/*
-		 * OF graph link is only present for BT devices attached through
-		 * the M.2 Key E connector.
-		 */
-		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
-			struct device *dev;
-
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
-								   "uart");
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				return PTR_ERR(qcadev->bt_power->pwrseq);
-
-			dev = pwrseq_to_device(qcadev->bt_power->pwrseq);
-			if (!device_property_present(dev, "w-disable2-gpios"))
-				bt_en_available = false;
-
+		/* M.2 connector modules are powered by the pwrseq acquired above. */
+		if (qcadev->bt_power->pwrseq)
 			break;
-		}
 
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
@@ -2545,7 +2550,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->bt_en);
 		}
 
-		if (!qcadev->bt_en)
+		if (!qcadev->bt_en && !qcadev->bt_power->pwrseq)
 			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(

-- 
2.34.1

