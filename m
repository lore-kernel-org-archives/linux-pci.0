Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D237CD5A
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218731; cv=none; b=CXN30ngMY6wnTAS80Sn6RMVegWXsGow+sBcGv84eW2bHu46AfJsmys3zWl5gylJWxz8qZkYv4KJb5s1NgGB22TXwgUdNEa1AmTLiGufuA+BjrLPPG0FOaWswzKvSiiY8nFTZBRgChboRlSzlgPbFizMaN3OeMw942ip0PcdULGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218731; c=relaxed/simple;
	bh=Xp5FK98F4aXVm1IaIUQg7a8ZJjOswS0wCMRvU+2daPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAPTYCq17tmuLKa4wBmzeP48v9sxe+LgC8GwnxUg2MT1s7DI2/NfKx82W5HOinW80pMiy8Ru6jXDUR0qFlwmJRhjtQn8jYhrfuvitUT8atlYF/c4gNDcv/QSrod5IIKUlHE3PenZAGGOIPJbqaVxjSUKYGEvRULZ7Q2WRAPKcr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qt9HQI1v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NdYtZLz2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qt9HQI1v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NdYtZLz2"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJggm2691617
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KnNGLFZg8KBKoCKQkuNws9wP1R08Qecii+OaAbhSdTc=; b=Qt9HQI1vaCGtbfBA
	SyYNQAwcyr3yHQqJVYqzqZqd+cZhHgb/Jl6W8i0VtNlkGJY8npAPSaKcyuAigC9y
	LoVjcmqvwnqbrCy/wjM+VQ8JfFk4VDCHrF/1d9uXZzWvadgFMrZI3mrpwbpH+uLU
	YQMX/zShurTmpUekIIYcDH8a4byUacD7taKw7LTF+HdHSknXVTA2QGsYQYdJxvLa
	P3g+mKHbdufnTaHjARHtfkWhLBHCYXllDmyf7QC+y0D/L2AuOFz8DB+KfotvAhuy
	dAdMUBaCv2VvFCwCwRdlYGrJ4JOCvDSHWWcVMFr5w1Hh3qY7oUQT16vz/n+Igab0
	VfSEgA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetb7tedv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c01ff996dso38173031cf.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218721; x=1784823521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnNGLFZg8KBKoCKQkuNws9wP1R08Qecii+OaAbhSdTc=;
        b=NdYtZLz2z2+76LFfct9iC8iv03ZeaeJy5xCqiloiY/LPknI0Hq+Ww4Le68m9ZzQIiZ
         sPzxYUPx+c1u39ygQ6dDfkxiSqAKGdWUS7GWk00EvNbiCwwDZ3fSJoVOVuJ4QwoJPIxm
         RWKzyL9rZ6ZObWvHD8/pyltW6tQui8m8xMAgsH/x2yQnjYoU4TR+XxpwtwXNd9LfoJbl
         T2BWkF14e5lrDsG8wxQ/UQQIAnCH167suPYVXv81qdtV4L+8je/MU1FmfpoL1XE2abiD
         ZKEF+1dC2aIqgfSsPlPmPiO4qh4CPklAOufRCniaGIoNbI6ioAF2LEmx309HFtFSodzE
         vNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218721; x=1784823521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KnNGLFZg8KBKoCKQkuNws9wP1R08Qecii+OaAbhSdTc=;
        b=Yg+UTebr9t4Brk7gRmu6gJQaDnF0/vcVGio6PAqFHUk0rtuYvUiBQZs/ihEaF7focK
         H41bPi7d+bV7pn+/bv+BjAKz/KvLieEDhVpLZOVfbGCXFYDX4Uh3eQ929iMzKguby2Wx
         njxhA/4GIE3kVr7soWRgUl9TLXpqAyAhM9DI2ERzzxVqBOHZIhYrRgwmyCxDUNXzRzep
         gSrbO5FJTAPIUeeuCqYfSUyESqK4ksxQ1L+1PsftLMv3awprrMb3LqdGJfJ4c/eFYh5K
         srL7UwvVzy6S5X16HkkZ33vsA8kAxHYYq0DZNzgGS2G17AWAisg8lYk1xtQ/lUNnrxMW
         cRPQ==
X-Gm-Message-State: AOJu0YyEP8+VbaZHyhG2k+0kTNF284RP9QsgZ4ajzKSCaRdy8ayUCYoS
	BP6R6nRS+oYTfhBJpLan+nOdQY5zQqLPJeu6oFT3DTRMJ27cjBRha8vqcQb2PT2ofEmKMK3gRoZ
	bHpVpFcit2nBtdGQP+TeilExlwzwxn3oRVuOwRr+VjckLcmag1pyV1k3i1rEseb0=
X-Gm-Gg: AfdE7cmFcLkSuGZwih3SnMlcRk944IyVOonuyWJQYWSuEucLMg4YNgmH4ZycTJtpOML
	fWT8MWZ8o6DkkVPPbgDoT5jb1btKIaiGV4oZpMne3v7iyBwzaODiKNhgprs9igZVpYIbd8x7kO/
	2Xnb3t+Hb5tlFVz7djo/UKASb1TsFIwrvdB9iPceQPD/MfKOR0LuSsfhRmQq05kTfDeJSb3vU6n
	9qu/4lQ75knC1PYDwajycs7geP/k7o1MbA5g76UoGMzpvLF2Xs9rJNZKqSvlveT/1MxPx1BggEy
	n8bzCE7duzCMNX0PpAliHafkOrvdDhdNV9SObVEsvszrjLWMog/zJRcV4Vp6RSQdRYo4WTF0UaC
	gg28K2Xx6uU6MUBSEUX490CFfWFCJeDp+2AX4LYcM1CgFBqg4HNPzzV9rX3ZCc/8Vud4xVD64r1
	pv6RQmErcPA9DKDCupvCArq4uJ2r33DEGYWVKjuh0AFArYRElA0a0=
X-Received: by 2002:a05:622a:130c:b0:51c:1b78:b044 with SMTP id d75a77b69052e-520be7934d6mr2444511cf.61.1784218720175;
        Thu, 16 Jul 2026 09:18:40 -0700 (PDT)
X-Received: by 2002:a05:622a:130c:b0:51c:1b78:b044 with SMTP id d75a77b69052e-520be7934d6mr2442971cf.61.1784218718124;
        Thu, 16 Jul 2026 09:18:38 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:37 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:25 +0200
Subject: [PATCH v4 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-8-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfXzs0hOOEAaFYD
 V8byuud0tiF+NTHccqTFucOBKbNhZIhazQQWUkQgAhWCL39RSdPwtGZwA2s287fNXlOvPSAD+Bk
 r1JvOfHYtXCViLkbeN+w2qfZzIrUqlY=
X-Authority-Analysis: v=2.4 cv=dM2WXuZb c=1 sm=1 tr=0 ts=6a590462 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CW3gqymaXyTMcD2nhgsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX3y3CxXRveY0c
 y5aJ42d8e+dSk/tNxi9uVJ/kx0l1Kb6K+2lk5LDGPYGB7I3w0yV/yu9qinEL3BhugHgV6kygDcc
 YlyYMwWP2sqkU8sDvvVdjod4vCM2sUuCLrd5RKqGvtq/Mgw8LRzPCzcJx3xgWzLTGffFb7gMtER
 4ZFKS5BbKflshJiG4cOUT0b1cpm5TuCrOCtjBGrWXnns5nzMrAMz2cRn6aftI+llq1uds92ckVi
 9HKubdmP9rpHr7ERAqsQnH3jx5dq0BFacOfDMrTi0ZI4cB5N3VYCih66I6J7uJgAlV9JG3sxGYl
 6ygDdKX0nPejeWJYeXKGkKZLH2sVIDZyc9aHy/eIomuPG5rFYmLbJ5nzkeZIjLjvoH2Nf2R7kYw
 btb3nS8Jz9wyC4pDeXpHPyG3byZcKQkxulBXaHDpC1BAwVDKB1QhQ0JYE4Uc2c7RdF2nsCXnsl0
 moxb4yCvhVYcV2zUBow==
X-Proofpoint-ORIG-GUID: u-JqLeWdMTW3WPunR50LEHpUUoYLzVo9
X-Proofpoint-GUID: u-JqLeWdMTW3WPunR50LEHpUUoYLzVo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160167

For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
rather than a dedicated BT enable GPIO.

When the serdev controller has an OF graph (indicating it is connected to
an M.2 connector), acquire the 'uart' pwrseq target from the connector's
power sequencer and use it to control BT power instead of the bt-enable
GPIO. This is factored out into qca_serdev_get_m2_pwrseq().

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 25c4387136245fca25e375951f960d7240116781..22f6185a946ef04c45e41b2b34126e3f58d603ca 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
 			/* Controller needs time to bootup. */
 			msleep(150);
 		}
+
+		if (qcadev->bt_power.pwrseq)
+			pwrseq_power_on(qcadev->bt_power.pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2387,6 +2390,28 @@ static int qca_init_regulators(struct qca_power *qca,
 	return 0;
 }
 
+static void qca_serdev_put_pwrseq(void *data)
+{
+	pwrseq_put(data);
+}
+
+static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
+{
+	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
+	struct pwrseq_desc *pwrseq;
+
+	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
+		return 0;
+
+	pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");
+	if (IS_ERR(pwrseq))
+		return PTR_ERR(pwrseq);
+
+	qcadev->bt_power.pwrseq = pwrseq;
+
+	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
+}
+
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
@@ -2417,6 +2442,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
+	err = qca_serdev_get_m2_pwrseq(qcadev);
+	if (err)
+		return err;
+
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2426,17 +2455,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		/*
-		 * OF graph link is only present for BT devices attached through
-		 * the M.2 Key E connector.
-		 */
-		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
-			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
-								  "uart");
-			if (IS_ERR(qcadev->bt_power.pwrseq))
-				return PTR_ERR(qcadev->bt_power.pwrseq);
+		/* M.2 connector modules are powered by the pwrseq acquired above. */
+		if (qcadev->bt_power.pwrseq)
 			break;
-		}
 
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*

-- 
2.34.1

