Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442182;
	b=kioqwj0OZQZXmKyBOWDpE6LyaqhBbE5SYj1X9NDc2lkD6yAc+bHk8f36OcayjYPXLMte
	 Kmc+/VBJE2VS/N9S0Gp1+bPfgce6+CxP1vgq1dr0qnwcEt0vlpr+hVu1n+LmnKFTUyi2b
	 IgemdkmtDFD1Y0aNBDcb+/QphoX7fVd80r2J9OaqlfvYA5cOoaIMd6yBYz2h/DokEhHX1
	 K2kBqiriOhq4BKqnXD3olsUOZOunzk1mzq5CqA53JQWepShvdOXV5b0ePq2xjxcP1L9ZC
	 6QCbka35x/E5wUrW3QNrX3stOFpWK4PQ7REiLyHrhD63kn6EpowoQEbK9e6kTqr8tAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442182;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N1oFBv4W0/OF6fkBqaRCQiDB1eU3UHqeJgGqt8r/kaI=;
	b=PjRSPPl8oB9no6Lap63BOqcDSlD5Ry/9OhQmOVQ3LHI2P7fsgNQ9CcHvAWnPdvRM0+x2
	 +iHYA0WXZVbYT7L6GYMK6qphfctOS2Rm7Ht/V5qTnQK2PY3zGnNbRWiULdJcUY4+3DXb8
	 a6LEEUExTCimjMTB234E805pYnAkAxbXFRqG42pxAfPCyNIW0ggr4J7IwUU2/oezYzUfY
	 MbLouKZSshDv1TtWCzAkVn6CfPM1i8/UAGJRskxuFNRlQHQ/JqhWEMZfDBvKtlaTzC5ht
	 lEAqe7dX7kjCUYrxiqLH2D+/1LEVT/Hseumhxvj7Z84G3pi5Nouy3LuFzqhAgO67c1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fdOmMSWh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="fy3gp/b7";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645360A2627
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2645360A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fdOmMSWh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fy3gp/b7
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKtj91974162
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N1oFBv4W0/OF6fkBqaRCQiDB1eU3UHqeJgGqt8r/kaI=; b=fdOmMSWhHzLbu7tC
	X5W9iq3K2KxlFtdWjgHKHcJBCZCctDGQBmA7iF8/YZmvuRAVS5IEVcZvR3Ml+o/N
	7kUuSQIdfr76oZBoXCz1KF7UOVr9mLqp5YoXL3Bi3mEaA5RH/skYCZIH+Senbz2x
	234ImgVJ84yPQQxYZac8VgDneRzTw1b1maQgh2I5C8IWN+duXNdy/dJB4iC06DO8
	ADiOtEw6j7PRR23qMT5hHmo/f7VnmIEmyQNLLcMT2hs+iK0N1yEslY0/KuT3NIYt
	+BhSbaxADA3G9KCxEfMm2oDhCvQVaA/gGvjwhH1KT+PnYZA5qbgBvn9fXYp0ENfg
	gzVIDA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7urkku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:21 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-92134f1eb00so49355776d6.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 05:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442180; x=1796046980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N1oFBv4W0/OF6fkBqaRCQiDB1eU3UHqeJgGqt8r/kaI=;
        b=fy3gp/b7z5M3BJSoO9/UV0yauBWn0ViFGIO18w8EzK50itgoebMnEUI055HRNvx5kP
         4ZsdBbUfpIa3DFjWVeFkMEJl+7Ty55ewfHfbyM/DIHgGJcGPe1dYS1ja8odqkYc9MnsX
         gay77aDgiKchBbjaAj2y8mTGb3tvR+jggAJqtusFPFrVKdhN7wHzWWX+coucvik16MB5
         ldyVkITKfaQT2iuSwm3bCiBHrhpYuyHYiJWrFJ4BT/2u/56XE0/u7/wgFh87nh9xkEA9
         ahprfghlkpxmk+J8DnDBdJEfb+TYETF6+7EOz0DAwDj6BhOJCtOH9l+KhJnQWKSQDEJi
         5eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442180; x=1796046980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1oFBv4W0/OF6fkBqaRCQiDB1eU3UHqeJgGqt8r/kaI=;
        b=MSzewZX7kUC4xNF0QTc0M/JBuA/xlTQmbwp7qOZx+riz/SJ5Kvm4ulAf+L7+LkhKDG
         FWpf5TFfgKqWYqwfcRfhxuyN39VguoyRPEDbuqse0/eV8kitzADZcbTMSITA2XOQvc5u
         d7io8NSiJavn/bv4o0fMOzf47YkGvlFq2gCw2SYHCWZcpzSu5DUxcyhFHUQLHsNvKTvg
         8lL9Vd9SdfU574BO9i57RWLfs2bypf4ESNYKHkCH+x7jSJ/SfMqeWziVjUKmL7DYckwy
         4iodq3EGbVWyp7lzXO4lxeN9tDj22KKWxu/SCipk0OxmWtEgnOmf+38SP/cg8+ttggiD
         sw/w==
X-Gm-Message-State: APuU4Z/65THE5hepm2jcRjFH0BJDzV8IDr+1uHuLz+H+qgbu4IeYbKCm
	B6jH5dSWhmfxa2ynAoOEXZK2/F9J41eGT1j0fl2IUDuI5+ee48ujO1k7XzdQmsTI/oJZIq4Hqhy
	6BUIAQC25VN2PFlZygMGESffwmNFuKJM7Xi2owZZYzF0VR29vp0bgQHT/nl9qckI=
X-Gm-Gg: AZFdTZfJOKBA9gdA6yWv+TiuCfeAsb6P0iyxJzKcv2869zEc0yqI4+MSknW3ITzpEl5
	EuF/lp8fF8+3XQDW/ZM+rW7UsYB8OQIlD/EaR0GqDv1BRzo9AgchMn6z0qnAnAJdpTpDwgh93zg
	ZRzhkZ2EaWfmDt7LvgPZp/5xOsoEZRyiopArXDrQDRuVtskU/D35sGELjessCnt2fOzpxpMTt3N
	xPI7HAEGTN4RIYYjvKX4qfHrSrkl1T3TCkNVJOlxegyVS4duJZksDk6igVEDLPwNT6KJ4q2AppL
	tW8Z05Mg6KNGxUDwAdvM0DRl/Z9FkgISUk7RKHY/iWf8QvH8YYn8LjEQP14v7oEWDjDemNB82Ju
	k+aPxeTHndHPv03gh9fxhtKKYBryrnzUTyMr3VOifIaMdim7C7ms3Rh5ybUD08nAyYhFIbTqvHg
	uQDLR2udsVJALNUCxcfdNrBjlKX1C8grzL8biU1CevoaLYLLGFdX9p6M8BME6Fq/cNnczL28O7y
	+OM6ErnGNvtquaN0FnXgu/T9ItW
X-Received: by 2002:a05:620a:2843:b0:949:a139:2f26 with SMTP id af79cd13be357-949ba823976mr1874149685a.7.1795442180187;
        Mon, 23 Nov 2026 05:56:20 -0800 (PST)
X-Received: by 2002:a05:620a:2843:b0:949:a139:2f26 with SMTP id af79cd13be357-949ba823976mr1874143485a.7.1795442179575;
        Mon, 23 Nov 2026 05:56:19 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:18 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:11 +0100
Subject: [PATCH v9 4/8] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
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
Message-Id: <20261123-monza-wireless-v9-4-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: K8AW8ALi9x4oy6dE1PO6li5iugWBYRuT
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b044605 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=_i6oeMK_y0MRuiu9OnYA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: K8AW8ALi9x4oy6dE1PO6li5iugWBYRuT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX/yon+PbbDvJH
 KYj0/gEyUtdJjG4v02wtM/P71P8L2RP4TMo7XGsCFCsXQGrjESYz43t0PvtOXEPt4g4NMh6of8E
 bDnF3chk5JxkJWn6pJC66pGXpykLO4U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX05MTqK4tzUtD
 IkevCzNpzSYa5bKCZDMlp7M5W+tdjvgqghej6Yd8Z3dxxJ1JBpIbZS8cKXxMDcRqotdLWlYVdNU
 xCIjqmX6ra24ypeHWrpcyHj2OObjaiuoU0C3OgYHYuLqY2bN5q2jilg4UKGPElVpbpYVIYAplCj
 LGyMbjvSUe33GWj6/F6mqDCT7WN8YUiGvfGIANqpD1qo2ifzj9YeEPp8czluluEKUaQFUMa9yDp
 ZX3R845JBXGjcVx3WsIaG95hEICph7LYU7cGPWyPtVt4LOqmStOo4OgrN2pkhJsrCHqPRp1eb+S
 trQC2HsxUmnSn6KCwaWJak3Wd4McAL57Ws7V+t96plIJPIjYneB4MDm/fSh9aJ1Vxl1zjmaKZGd
 VRgDJD8GCeLKeIaF/U/5pQUtbMM/hY894U4ShjY/fVlW7b8SdLrgpt/YCDNEGby9yEKm8xBQIxH
 JgfPCRy+8am/8CpiKlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

'bt_power' is allocated dynamically only for a subset of SOC types, using a
switch on the SOC type that mirrors the one that follows it. This is about
to become pointless as the power sequencer path (used by M.2 modules) is
independent of the SOC type and needs 'bt_power' populated for any type.

Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
allocating it separately. This drops the extra allocation and its dedicated
SOC-type switch, and removes the need for NULL checks on the pointer.

No functional change intended.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 67 ++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 44 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 3c0239e837fed7ff8d8261b0c61e5163945d157b..9246abd3492870a6867d12656056d2a5e6490e10 100644
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
@@ -1810,7 +1810,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (!qcadev->bt_power->vregs_on) {
+	if (!qcadev->bt_power.vregs_on) {
 		qca_port_close(hu);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
@@ -2279,7 +2279,7 @@ static void qca_power_off(struct hci_uart *hu)
 		return;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	switch (soc_type) {
 	case QCA_WCN3988:
@@ -2299,7 +2299,7 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power && power->pwrseq) {
+	if (power->pwrseq) {
 		pwrseq_disable(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
@@ -2357,7 +2357,7 @@ static int qca_hci_shutdown(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 	int ret;
 
 	if (power->pwrseq)
@@ -2389,7 +2389,7 @@ static void qca_regulator_disable(struct qca_serdev *qcadev)
 	if (!qcadev)
 		return;
 
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	/* Already disabled? */
 	if (!power->vregs_on)
@@ -2466,7 +2466,7 @@ static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
 	if (IS_ERR(pwrseq))
 		return PTR_ERR(pwrseq);
 
-	qcadev->bt_power->pwrseq = pwrseq;
+	qcadev->bt_power.pwrseq = pwrseq;
 
 	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
 }
@@ -2501,27 +2501,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
-	case QCA_QCA2066:
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
@@ -2547,8 +2526,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * let's use the power sequencer. Otherwise, let's
 			 * drive everything ourselves.
 			 */
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-								   "bluetooth");
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+								  "bluetooth");
 
 			/*
 			 * Some modules have BT_EN enabled via a hardware pull-up,
@@ -2556,21 +2535,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
@@ -2606,10 +2585,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
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
@@ -2633,20 +2612,20 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
-	if (qcadev->bt_power && qcadev->bt_power->pwrseq) {
-		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+	if (qcadev->bt_power.pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power.pwrseq);
 		if (!bt_en_available) {
 			/* The host cannot gate the BT power individually.
 			 * Treat it as always-on and drop the pwrseq handle.
 			 * The descriptor itself is still released by devres,
 			 * so dropping the handle here is not a leak.
 			 */
-			err = pwrseq_enable(qcadev->bt_power->pwrseq);
+			err = pwrseq_enable(qcadev->bt_power.pwrseq);
 			if (err)
 				return dev_err_probe(&serdev->dev, err,
 						     "failed to power on BT device\n");
 
-			qcadev->bt_power->pwrseq = NULL;
+			qcadev->bt_power.pwrseq = NULL;
 		}
 	}
 
@@ -2684,7 +2663,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:

-- 
2.34.1

