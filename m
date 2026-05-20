Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C00351C2A
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274920; cv=none; b=YH22Jt6fwzW+AKD7mGejduztI85tLV0icMZhJiG9C+9nV4ncHGs+AfwiqatzS6N2OMKgiDeWkfev7ADjCYVgIaVZ+GcvEulpvumDLmIrTmG5/XqhP7Ed8i2yvuqpvCpCFdUQxqgf9zoJaSPfUTawSYUQB3jDpk1uFFjXg68nBB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274920; c=relaxed/simple;
	bh=IwOf3bKBO2x+9q5gt71IHZnJfjB3imuDUZjTiln6iJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GgjcCh9XHyF5v8AIHTLZ2ZCVXtdK2A/j/I4hsFahO/r8hjm/nUPy30kQxDdn8hBkGag5ENL6RXDe/0fVRERs1YYZ5731eeAUFAdfC0YYGeOVfo8rj4Uf2yzy+hz2YAWjrxbDAj6E4pVTCjBEYynAazbn15dOb6x8fojXjTDAVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZCEqkdp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OMOh5Fkt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZCEqkdp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OMOh5Fkt"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7IGM8341703
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 11:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GI2hbxpBYvrJsq1N33WhlyERapASJ5myJdAz+CdIXHg=; b=IZCEqkdpOmuOTAfo
	FFowHjttUxAGEL6dabmLFG5uG6JmVQGx+XH/JDks/TMnGdpG5sjS9jPt135PwXvh
	kM5fFIOafts3NfhPGblJstja8QPnvh+kV5dLlYv1ptiGnNrb4+a/JMdGJY0dCbeu
	QUhV50m0qOAgJPty5vTS9P0oL5xiCdoiEW9eA55XCXBBsMEsGcY1kVZEQBITBS5N
	25PCZ2uPQBMNUpMgaGZMbh0yy7uEhwpfEAJii60KgznRKtjH6CLVZd3E1xwvhyKQ
	bCUP7Gngp6u63mFxaXTSFzu4kq9FN8//0qECmODT7ITvORD1Bh+1wcQcjMlJh5tB
	hxBTGw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3vccg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 11:01:55 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-439bb670a3cso4576569fac.2
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779274914; x=1779879714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI2hbxpBYvrJsq1N33WhlyERapASJ5myJdAz+CdIXHg=;
        b=OMOh5Fkt3jOFs0GGVa5+j+6D25HQSqP/WEokwMhyHCRrrrCnQoY5S2mC4CGTOPwU1b
         Cz8zWmZuEYoj837m3TLk5n3IwE7ogclSl5G+o7WxpnZw9+ToIchFnh9Evn1r+Nplp0cG
         TTtlCqHKTY9ovhMHoIFbARxVswAmfgs94Agr3H9o/7KrtMe5zRev9F7M+CBb2jz5bSeE
         WFsWng9FnTaV/liEmnZsNIKnOGJ2PhwHoZJbnrWz4ZbJRBdC1y0rrtK2TJxnS2/z6cCo
         NL18G2SLHdks/H09+e+z236XJYDvZShgvCJn8SA0tGr7HTUWmgr1PsC95IJa/xvtLddx
         O2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274914; x=1779879714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GI2hbxpBYvrJsq1N33WhlyERapASJ5myJdAz+CdIXHg=;
        b=k7vj2KZIqQDheTNgW8Ehh4i7dwJJpF3tIknZeoVjC3TkK97auBe3d/slr/FyXByvIP
         sr8P44dshOeQgmDIPV6vDqGEmreAlsk0ejf2WmMqENKxXstKW4WUfUAKR7v8LPtzW4Vn
         bJiQld0JENx4YUpYLmOdRZQ7A82+ufmWXl0v1QDZucQyfz+asb3/i/akeXVp4PG+JXHi
         rHDVCNt7utxW8Epv45TbGMQ+ebOmjRN+UNIG7KlVbr46+nuEIyZdi8VgyFkOCsXiFXcO
         MLWKyGTV+E+3EC2VTTCRc00JVt+b8mBVpRU3YT2Xa0izK2EXmFgTsaeQNww+mp8pnyxs
         xC3g==
X-Gm-Message-State: AOJu0YzVnrgH4ex8GC3G57ypSLb67Zffz8pBT/gjgcGpHGPr+2xMMAvf
	MfrDB0oi+TshITujocaUOld6SXl8HenUzCcN02daZ2K5ledzb3DW/fCpNVpm4b2eXqN+spm1/5e
	GqNr34tBWTOA3wCB8kNUWv/VyYvWZvQBIicTdAGimStdLpMmjcKldjjcj/cvlBYMvC+3Hz0o=
X-Gm-Gg: Acq92OHkRhJVurfARyns6Dy0I1IPda0AUYfFjSdRmy/UmCdcNvfwt7BAvMzjl6HMvZa
	B++cyUkqytmq6oXTpdnxb9I4dXW1Llp0PevUkGE6eskifQ0PykVatC0bwt0WE9nSjLh1zWdRgQe
	V6EnTnc+fi38wg2fdLN6vTCBBGqtl4A7qzC7PrO2LUhQlkQaidT6FP2js6tX1wGCM9IGPlye5Q6
	wOMSyLcF1jgCRqqW2CJsmQcw+FozR4RXh5PmZT6B9MgMLd9KBKpxrwlt/sWP8JpDirqYsasv33M
	TOnGKIkag2kljt0Ucwzm240/vG5Iq3tUEIXV6yTblHVPNQRhfQ1bKWQK1iXazI3uxMBI/qduZDW
	1mjY5SsFF0fS9tAwuo6PZYGsk0ygcE455Z53m26pE2zZcG+nOntrQQWy0Tr6X+y4xtFh2Ft0uK2
	gUmHFPJpyPwEKvdZu1
X-Received: by 2002:a05:6820:858f:10b0:69d:50a5:5c48 with SMTP id 006d021491bc7-69d50a56172mr2610048eaf.21.1779274914458;
        Wed, 20 May 2026 04:01:54 -0700 (PDT)
X-Received: by 2002:a05:6820:858f:10b0:69d:50a5:5c48 with SMTP id 006d021491bc7-69d50a56172mr2609995eaf.21.1779274913931;
        Wed, 20 May 2026 04:01:53 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:9d48:e1ec:d837:6344])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eb6320sm840310266b.59.2026.05.20.04.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:01:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 20 May 2026 13:01:43 +0200
Subject: [PATCH 2/3] Bluetooth: hci_qca: Support QCA2066 on M.2 connector
 via pwrseq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-monza-wireless-v1-2-9f6942310653@oss.qualcomm.com>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
In-Reply-To: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: RptkUC3Flcq9_Zu_mb4MY_0Te7AyZFZ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEwNSBTYWx0ZWRfX2s/XIRhitg7E
 xVxoCV5j32vQJlzIflf302wcbbvdXF9Ddlx1G5D79eo1uTqWmqpATTj2YacEQIWMxUBaCaZPvEU
 AHqCwgI1EazjUfQiyqqUnW+2W0N3rxMNP5XFbgr6DIZXolv2FBc0zqemc1knJm/tYuIqvj8j7rQ
 QXA0Y4YNmAMZxlGFfitJaQbFnSVQFCRhHlnoNJG8f5suy/ITKpN6JT5fR03KK9uRF9IS77KZWjh
 cTN+bZ02FLg62bljbMRO0raCIrM1p4VVfxcrCRHyM2/bnd+Xti4IT38gkAdE5vHLFq1rPGZOCi7
 BL4UIqVwmUrme/WyFRZEuYe7Zt7ojum/lM5hWl/ktMAat92I81WYIFmJM5G+5Q+A5e43PgE7WFc
 CCssEGj5AFT5Yk/q2KL4FiOMedgvznk5gyUqTG5EX3Lh+FN6uxT/V9BPwsSKq5nzerzxbA1ZcR/
 gthHKoJ3zeXYuT6C2UA==
X-Authority-Analysis: v=2.4 cv=JuPBas4C c=1 sm=1 tr=0 ts=6a0d94a3 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=CW3gqymaXyTMcD2nhgsA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: RptkUC3Flcq9_Zu_mb4MY_0Te7AyZFZ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200105

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
 drivers/bluetooth/hci_qca.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b5439b9956cfb0497e6ba6ccd9ed61224d23a9dd..de5cba7b7f44e280a48dad5d670fa2758d3268d0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1873,6 +1873,9 @@ static int qca_power_on(struct hci_dev *hdev)
 			/* Controller needs time to bootup. */
 			msleep(150);
 		}
+
+		if (qcadev->bt_power && qcadev->bt_power->pwrseq)
+			pwrseq_power_on(qcadev->bt_power->pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2415,25 +2418,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
@@ -2543,7 +2530,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->bt_en);
 		}
 
-		if (!qcadev->bt_en)
+		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				return PTR_ERR(qcadev->bt_power->pwrseq);
+		}
+
+		if (!qcadev->bt_en && !qcadev->bt_power->pwrseq)
 			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(

-- 
2.34.1

