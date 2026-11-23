Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442184;
	b=yxxqm8IZ5kyWl3lkomDnde3r3mUOy4lbpAQTbP1dTL0pW5P9wjBAc63bQX45Aw30zUv/
	 N+mnc4aNoxi9slrei8qwOdfowbitGah1BF/co2ganNWB+s4W84/3+wiaKN+6cWVnNFy/Z
	 uwYMM1mEijJVdVJnGnToA3fRva9R5h7mX4a64Pr9r31X8tLWUISgwndpIQwsZ6W631UUu
	 2Ll2W2ZOvD+A3UdPAcPwoPWt9KuWjP3lngeS/U8Qqbij2p2O99FT9X9SgHG7e2Yqt9Xod
	 9nBUXbFi1nmQkD645WkzQqnKsH4okZlEy2KGC97kZhnBllryJDJQFnVShO6o/65EnOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442184;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=i+16hty/zVeDc8dRspK/Il9OPjPC+qWKo3Dn/TxDI2c=;
	b=OYhAr/lWjDeSiQYtvp+159+iKKmc9bC5FEdykjW/mm4xsKlJ3Rc1K2CImsWk6yKfVjTz
	 Tzu4CXHn8Cmv/I5KduoC+5yvuaJxyvnutzciuvfruYOp09uG53WDkZmVKu/NKnRAlFBgO
	 nSnad0ocKGApomcAUmawfgvkABgy0AwtQce7R/fN9QOOQiKUYGm5/N9DKQyXkVGiquswD
	 w8ddp3N4Nrp1VQYJ7/N4ZhO+x7Rzk+1qIF3wpSbvWcmUcVQLlTFYaq8DOB5V1CzpmYCnU
	 gP17kEftSwKKijBiLERpVxyC+DoyVxU1Nk1m+wZaGObEncGLqNCmoplJ/Jqfti97gvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BDNo2l9w;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="WQR/m3h8";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880FA606A6BB
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 880FA606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BDNo2l9w;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WQR/m3h8
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDL1ot3072458
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i+16hty/zVeDc8dRspK/Il9OPjPC+qWKo3Dn/TxDI2c=; b=BDNo2l9wrG6nLYvH
	yHuz4utGXidK0DaIUU6RkW/JfMlmATTuMYOfBsL2zgmw3X7WOiBDg/qtJUAus98W
	qSsGnErUajpkRmHulMijx8Bdru1hBmgTlQ+POc+wNWt23rd4vy2iNIiPIZibqhjc
	Qr6VPBXHYpI/l/+exCvYKHWz+TBQZEZWa4tTNUL0Z/w5WrA1eP3uF6itG4OsVdSK
	0muTTuIh8X7otblTshWkaYle30rezGrBiydtyAPso/T3wVtOJEiiTcGqEaykfeBi
	f9ZrlPOdrSiSJZV5qNoHPoFhelDWgMtttBHvM9DX8gjaiXrrTvvLNAG4tgfAt2xh
	2HoX2g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7s9s6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-949dc497896so133439985a.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 05:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442182; x=1796046982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+16hty/zVeDc8dRspK/Il9OPjPC+qWKo3Dn/TxDI2c=;
        b=WQR/m3h83vWZfOVX1PqAl3+lUbP/tMowHPxNsVW9nMZo03K2f5Xm05hfmU6OoUplFn
         IUKHSpetEG/FAol+TWxPzC3ALagCrLzeh53Dp3jqCxyHGaWS+L6AaxYPGxJh+Dyaa4b6
         5YPUVN/TMoW3i71QpiOiw8/5gIlF7GfuuSYG9eteOlqKFRVOLHxHnDlZprfzmlurK96v
         QLGjolgXETBLHO6Y2n7blJITyPIdKQCSrc17bhe/QXvOMBYfg5pW+RRNn8ohqWav1h7A
         SnSEXAefmeAGlnBptW5pZz0AxQC3t+BKCvfftS7/YH5s0RHy5aRzrLyc+vF8oLyTs29O
         fdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442182; x=1796046982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+16hty/zVeDc8dRspK/Il9OPjPC+qWKo3Dn/TxDI2c=;
        b=IL3+377W8FJbQeqH7408C32hCYIgkZ+HXWNIqqd8l6QhTeqt945cyDDpq2P+e4aU8e
         R1QpV82Za6ag8KQ4dVT97PanI/2sZeDiVfzruxQfuI9ucvVJWBddflM8X9FO28II0zzx
         EucO34ppJltk/4FjzOEhRFfWb/EQoDr1Mwhkv2mS/h9FyhU8QqoMmxc3iB5kFVettBYC
         hgXCLcJhkDmdXQrLQNDTyjmekiMmKq9/olnFP56DviOGWzy2UvK8pf36qHMebepoxkQk
         XrUaJFVaoFfBJNzO5u3+BaLIANewzX26VGDArIuSjfo6OlPGouwjEeey8CRA53lwwV1p
         ztiQ==
X-Gm-Message-State: APuU4Z/Df7ZVo8UG1Iloo75Jgk5pRsjZr9Dn0r279pp/PpfVt0WyeJ+d
	X/jlNhLs9MFQ0HEtquz0/i6DkFeGV6nkZOwB712JfbgLXZPeWdh/VYutUcZ1T/K5HLHYEIkAVgW
	DeL775nwAXgmrFPn83QXU6qg8pQYv0g116Qvf0U0zJp+saruOOojooY4ST4rbtJ0=
X-Gm-Gg: AZFdTZf1xV1jNawOW5jV/KoShe5bRystt7rMFeSX2gIW6tFNbUF6K7cxunakEzcIbz9
	vo/QixX2qtQ5Bql2LGsRW9mokw//y8r4utktPSYOck7WHisvQDco7x3DSWTAOBIeV1qFCoIM8Ky
	aC2xM3NykTaUPny5mD1F3vyJbzEUNOrG6j+SHyxY779Bkd39b9Gag30MYlyU4At7cOpiSkDsHHq
	GWKVwLn2waReYSE0Ouu/rvGeLgEiPpKupZCg7T/TI/CO674Yn8ayN9l+lF/V8W+eq5JxZk6Nafq
	fgmxljMl+okBzvmlPfziCjpBmm1BgmLO3kv8Y+Jlo+qfyrVt/XdIIwT1V72mtmPo0Ebs5la1fc4
	pOCu/VIUH9iGY2E8CpNyPZL3YTZUM1QRjYYZAyoFcEY8GvjYeikNSIdjDSDuBk6FQ1kzZOA/LbS
	9BRwGWNNfrYJma4WO/7Elj30aaFBjGzTGcCjFw60Rfspykvy+EMlo0mfwYKEQQVUS+38sBHylk6
	1w+BXWtyI1iGizFZpvJvrAcZeSE
X-Received: by 2002:a05:620a:460e:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-949ba9e51e4mr1827495385a.31.1795442181987;
        Mon, 23 Nov 2026 05:56:21 -0800 (PST)
X-Received: by 2002:a05:620a:460e:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-949ba9e51e4mr1827490885a.31.1795442181447;
        Mon, 23 Nov 2026 05:56:21 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:20 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:12 +0100
Subject: [PATCH v9 5/8] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
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
Message-Id: <20261123-monza-wireless-v9-5-450d7d764aea@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b044606 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=FvA3uXTk7I3rYI6t6TkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfXxuKMlTBdh3Wk
 Ml8lEDJh3IlOwuDAHqK92lP2eVb1JYy5OaFmwMCHk6FxtHo0zF11IQiih8/M84reooooPPtMhXY
 H6j5/b3TIyQyESM3InERp6sLQwFI7xGFrpqu2FmBRXLKndZIQQM6ya5UTkfo0fL/Hf7uDCxCwLU
 9N9f742Ip5XD/Pkt+A9LZtQLXryhQ9MajUOqJJgQdglSRnmnXtPQ2vxWDYOCBTzFj0MGBW8ur8Y
 G/olsMoerL+l5mvMmjsvFvorkHJA5/NaXAeAsNwzyuBfTlbfI0G3SaZ2RsIm/Tt8UplgrjVT/Z4
 0ECBS8fKJL/oulcdNSw8Acu1GO4OCPFT0zRyVHJYS3BIopUyojfAQr6pYsa7fIfh0g0yD1J0xRk
 WscUoOqqYoHbtv8KjaQLAVNKSASlkxyrJJc9kSMgLGdpz5QwbfjCEcJhz054mcxuHmfmEj3Q5N5
 +va5zXQD1pQbZ8C/CGw==
X-Proofpoint-GUID: g0-kvGGSxW0UHaB_UnsB4-avXFY1kd6r
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX2Buw283EmAXM
 v3cVKaXglXRG0MKPcLKUjRNPoe6tBDzHLzqs/1iiotrUlXwKvbxwA3Y+SLGf6/N15L4JRBU2bDJ
 FLxMEyp9EWOIXlenJQ8ZfOCEcjqZSz8=
X-Proofpoint-ORIG-GUID: g0-kvGGSxW0UHaB_UnsB4-avXFY1kd6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230055

For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
rather than a dedicated BT enable GPIO.

When the serdev controller has an OF graph (indicating it is connected to
an M.2 connector), acquire the 'uart' pwrseq target from the connector's
power sequencer and use it to control BT power instead of the bt-enable
GPIO. This is factored out into qca_serdev_get_m2_pwrseq().

The lookup is done before the SoC type switch, so that a module behind an
M.2 connector is handled identically whatever its SoC type: once a pwrseq
has been acquired, the per-SoC enable GPIO, regulator and susclk
acquisition is skipped entirely since none of it describes such a module.
For the same reason qca_power_on() brings those devices up through
qca_regulator_init(), which enables the power with the UART closed and
reopens the port afterwards, as the module requires.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 9246abd3492870a6867d12656056d2a5e6490e10..b9d77628d0cede0c75da134d522476460c7c599b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1886,6 +1886,13 @@ static int qca_power_on(struct hci_dev *hdev)
 	if (!hu->serdev)
 		return 0;
 
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+
+	if (qcadev->bt_power.pwrseq) {
+		ret = qca_regulator_init(hu);
+		goto done;
+	}
+
 	switch (soc_type) {
 	case QCA_QCA6390:
 	case QCA_WCN3950:
@@ -1901,7 +1908,6 @@ static int qca_power_on(struct hci_dev *hdev)
 		break;
 
 	default:
-		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bt_en) {
 			gpiod_set_value_cansleep(qcadev->bt_en, 1);
 			/* Controller needs time to bootup. */
@@ -1909,6 +1915,7 @@ static int qca_power_on(struct hci_dev *hdev)
 		}
 	}
 
+done:
 	clear_bit(QCA_BT_OFF, &qca->flags);
 	return ret;
 }
@@ -2456,6 +2463,9 @@ static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
 	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
 	struct pwrseq_desc *pwrseq;
 
+	if (!qca_serdev_is_m2(serdev))
+		return 0;
+
 	/* The pwrseq is looked up on the serdev controller (which holds the
 	 * OF graph to the M.2 connector), but its lifetime must follow this
 	 * serdev consumer device, not the controller. So acquire it with the
@@ -2501,6 +2511,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
+	err = qca_serdev_get_m2_pwrseq(qcadev);
+	if (err)
+		return err;
+
+	/*
+	 * A module behind a connector is powered entirely by the
+	 * connector's power sequencer.
+	 */
+	if (qcadev->bt_power.pwrseq)
+		goto power_ctrl_done;
+
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2511,14 +2532,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		if (qca_serdev_is_m2(serdev)) {
-			err = qca_serdev_get_m2_pwrseq(qcadev);
-			if (err)
-				return err;
-
-			break;
-		}
-
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the
@@ -2612,6 +2625,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
+power_ctrl_done:
 	if (qcadev->bt_power.pwrseq) {
 		bt_en_available = pwrseq_is_controllable(qcadev->bt_power.pwrseq);
 		if (!bt_en_available) {

-- 
2.34.1

