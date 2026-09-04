Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90242501F47
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536572; cv=none; b=aobr19ti/hfz4/uhznKI4JvldmZaEBMb7ntfPW/pHI6EcK2EhIB9nWFChN1RyRO7HSekP1plM6ff/iR+uXSsigKVhfu6q78kulgP1Mb/LUkTw7RDt4ROEKtosYCRDm/1g+2wjUYbBqztYCmtSxKVkDdTFTYdLOQa/bM3HyNPs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536572; c=relaxed/simple;
	bh=ql+lzgCyBPEjEvO5d+fZjVYHAWX/V60lJU8VXvadKEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3XX8tXT3Xj3+C6i34Uym56H+gTwgzNcHv3w6cpWbwJ1U/6sfpxLSvrFvuVnT0Uym42JY6MgHoD4Rv+7mugPGGK3vblVTy/m6l2qfPbZgRURz0xB98DubY2g4b3kugMhQ+UsEd+ifU05hFYMSJtd24YkzwiTrAmDmwnqr1HG7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9rAaPex; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WuqIieRd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G9rAaPex";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WuqIieRd"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684EiSMd195836
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2026 15:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MINzBqJ4IAJHoJgZZ9M8ZzzajtUoGcKXgzz7x3DJbF4=; b=G9rAaPexNp2ooVdn
	uu2Vq/+Oz4C+BZX510p9D7XyPn4KqVMjoiW1jUVj/mbJoaUMqQdNg/QRJCYJ4O/C
	or6zcqwEhN9avQ8Rw0sZCTpg6y25VtPXxGo/T+41agBrJARpscxSVaGXzpHehtYe
	k+mjSsrOMzE3fO2myy4s87VM9bn+fNFfvmTu3bUCo1hEqLCjO6zonauA2K7ZFV0r
	hX8uBA1oxSnqb/AVTVg7dfL+7JdyFe9j24v9FhophxnS9SCQrDRUmJQsKjGEXFo1
	bxua11PLWeR8U6DwjTp84mqdvpVzAfVG61XhFQx5ydLz5wP795qx0QPeJqCzO599
	wibaoA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg0120j53-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 15:42:37 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97cb32961e3so743961241.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536557; x=1789141357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MINzBqJ4IAJHoJgZZ9M8ZzzajtUoGcKXgzz7x3DJbF4=;
        b=WuqIieRdKkssahH/ozo2uv2t9E7LSU3P7JWyxsoQyQtCErR+yPzvsFJs7nO7Tzslro
         m+k2bBIPnSgvO+LVDaHry17GFRw+Dp+jt42IHTVtvVhytTjA0tcMRDE6lql/UZSQtSo5
         mZwSZAYMYmxm7kCfdUc+rSh1pXSXxsgtOwrhuea49LGapC4yHmrwbsAxqvpSx/d1ZkSU
         UPnWf7v8Vsy9XDgetV/n/+UmqncQWIKJ8YLBfqEy2sUyqqNCNQ3enuPgqfxPOCTss1NB
         a0kcdoRh7ibftYrQcDyd3vI95tyZYfPETXfBprGDxJKYYS/D4zuUwEuUnqzhP+3il1co
         MFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536557; x=1789141357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MINzBqJ4IAJHoJgZZ9M8ZzzajtUoGcKXgzz7x3DJbF4=;
        b=kw41Gad4p7JgVIGquHTFcirFChu3v4xLOEjJM9pwfDtlSbVb8QbxHmEx5MUcFMzb+y
         dd3ZU61ycZX2WHcztQfeOWVF07IY9sEBiL5x8TNR8UoQSMQsPzKwch5bA+J/4oDRHCsf
         ulQpCg5cgE+3b25yhmXOrza9SBuFclR4yUn4xsTuzyZABKpn+kd1E1Gw/DGFj8dpOTHP
         XVFGejE24IKXbtCSg5fd3YxUzQPyBi9USXc/XDPaO08TYOB3yirlJXw7nJmvfdQN0Q89
         NA2C8yq008xjCvJ1pUv1tARtyCYdWJa0Zyq1nj9d+BgbtzOXkLmr6ZNXt/k+nIcMD7/d
         KRtg==
X-Gm-Message-State: AFuF++mXNbcXwsztl6DBxomp4x55LQntRjyqGheQXrgURcd8MTHGW0Jg
	z3NuBMog3dKFGM77l2d/Rp9E546h5J6X2vG0KcHuehFvcIwUD9FL8yFmAQeJbUomZCwVrTOZ8rF
	iBcZxe/EVE/7V5YTBahTDsaWOQVmLQPguUurY+jB268p3+zn8WVK6KSZgy4ps+rs=
X-Gm-Gg: AYBFou0ZVrH9uj5TzIs/JwOe0xG8Q8oj9hX9zEqllTDzhJL97Ply4J1qLDQurJQkOg6
	yQgnWMHn+QKNxxRaYQXKQihZ2U8w2IaB72KqN4hXioQgTPAPMyV+QwKK2eDheAcXeMsU1pPH5wp
	BDMNZmmArCvgVwE/2j3uOJxOpv4JIS5bZsIhWaU8O+vh7bJISoTAaAWY6PcbIo5y3kJtgdbGQ+3
	rghlsvy+HXM58garxYBUe/SwNiEMi9fr/LVZth2Mhfsw2Ma4d7BaHTzist5xi7DbPQBYdXT8kUo
	K2/MpBNxRw1l2aMM2GpBIerigVl2zEfBYF6AfDDAlOEThXlhuHZYn+qe1/rmH8SqPCMJHjLoTBq
	neXaqfQNQYoPzw8rS6MiWs7W6pH69iggtQdmWTeh83kp2obGqUOFKOiUWhsDOpR7boaaq/kmb78
	knBT/8CgKPDHJvkhCZQf283y9nJL0Cti0/jHUGWplv91ps45/+/dE=
X-Received: by 2002:a05:6102:3e01:b0:785:c3dc:2f5d with SMTP id ada2fe7eead31-78a4aa13b57mr2612970137.9.1788536557193;
        Fri, 04 Sep 2026 08:42:37 -0700 (PDT)
X-Received: by 2002:a05:6102:3e01:b0:785:c3dc:2f5d with SMTP id ada2fe7eead31-78a4aa13b57mr2612933137.9.1788536556685;
        Fri, 04 Sep 2026 08:42:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:35 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:23 +0200
Subject: [PATCH v6 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-8-d8c5042b3efd@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX9E1/Aihubjbd
 kqMYU8U4UUqOne3Imfpnpjp/V8mt0HoRC8KLbwoY/8HDqoXLXmt78ZsSxD7B7k0sbjquSkJIu/E
 k6GCBgwrr7Rc8ArdMs3Nzrd6lcXCaAQ=
X-Proofpoint-GUID: tE1NrFHQwKGHaE9a2zWukrCnhKOfj3oi
X-Authority-Analysis: v=2.4 cv=LreiDHdc c=1 sm=1 tr=0 ts=6a9ae6ed cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=reVw4oyKNVL6WbIJD7YA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: tE1NrFHQwKGHaE9a2zWukrCnhKOfj3oi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX/pAu1RPN5HF/
 QTdS6P6sGWNE5tpmYwb7PZUHVvq4gtbGAkBv3GgV7vvmUFq4/OcwLjlJ835o4Hke1pnN6Rj8pQ+
 IHILGc9Fh/Q14RDVy+A03ning6TjDA9FXoSNOytSW7dF3lgHqDufvp7qcTFWtwZMop3gtUoZPhs
 dXdhx4ppyd6cBnTp2HqlD2aoHCAw/VUoYGmfZ8pOIzNN2bbxKk/mQiGSrNhVnmm1m36pllXlKsv
 SBouRrT87T/qp0plhVKcJaXZYaF0btESKPyjlzq+YOw89aPTnOuKqddT719zx2ZO+co0mue6rA4
 MVkAbWRt2vr4D8zRfiAA/HkENqUt1RVRp8R3Kbrw9A0PqAK9eggh+4A4K9A2qGvVuq3mGoYPkOA
 16Ivz+WKHNlosCBeJVIBPqcdYEdkq+GCtjY8lHnMiWuiEmWNRVe0pZhHvUGs/vZ7GB2OzlJQOEq
 lRDelPVnOJh5wAhFGMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040143

For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
rather than a dedicated BT enable GPIO.

When the serdev controller has an OF graph (indicating it is connected to
an M.2 connector), acquire the 'uart' pwrseq target from the connector's
power sequencer and use it to control BT power instead of the bt-enable
GPIO. This is factored out into qca_serdev_get_m2_pwrseq().

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 47 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 30586120c4a73a50a29af235b511c3ae97960e27..db0a968dfb00fa6f1abb86a3f6d1be89dfe80c6a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1875,6 +1875,9 @@ static int qca_power_on(struct hci_dev *hdev)
 			/* Controller needs time to bootup. */
 			msleep(150);
 		}
+
+		if (qcadev->bt_power.pwrseq)
+			pwrseq_power_on(qcadev->bt_power.pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2390,6 +2393,34 @@ static int qca_init_regulators(struct qca_power *qca,
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
+	/* The pwrseq is looked up on the serdev controller (which holds the
+	 * OF graph to the M.2 connector), but its lifetime must follow this
+	 * serdev consumer device, not the controller. So acquire it with the
+	 * non-devres pwrseq_get() and release it via a devres action bound to
+	 * &serdev->dev instead of using devm_pwrseq_get(&serdev->ctrl->dev).
+	 */
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
@@ -2420,6 +2451,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
+	err = qca_serdev_get_m2_pwrseq(qcadev);
+	if (err)
+		return err;
+
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2429,17 +2464,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

