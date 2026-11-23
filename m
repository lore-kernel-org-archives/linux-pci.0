Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429540;
	b=CwIDFaVpB/5kiBXgITHw0/NDdIj4uE2yRJC3PqW9Uo/aMyX3vy2HVf6wQG4p2z4qtfuV
	 mGeevd5adli1IibOkg73FqY1qWgAmtos2zboUzcazjde3jP8pCGrqpE+f63aFdIcdvFPY
	 KaRanlLJgGFxedSRO39vXvRjKdxKr0KClhhnzmGitKUVQRmeYb6r4TFtOQgrxxVTPlTGy
	 21KUdbCA2JzeUAmfvfnqfcUg3fCzM9bLvjeO71V0dgZzo+tntJN1UZPtyocNOAwQm0S8+
	 e+xjFJwL3L3EGLE87LIGVWra+iQ47kDtrzlfeR02j6UN/pirC/RQ31RqIEN54YeGYRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429540;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=adhFQLImZQirbFPoLtUf2pZq/lJYN4GsRu+tngxUkCU=;
	b=5U0CVZt8YKN4sa52EA6CZdspnTVpqNQB85NT0P4RYz1ID4zCAcgI8rJc7PB0ltdn1eBo
	 4PCFmuTZYn8m/diHMpK/234PiPfvhfJKjgLJ+djF4rmHKt8LiDDyMXxL3nShRB+BD6WwH
	 5kZEbRiArHxINVx1wY8RjxYH5c0my90+hEkpESEA/Tk158x2TQssjR9EVxEAXHf9/yt2G
	 x7kZO8IzunkhgNXP85nOW3p9lkLeaXwnL9MMXzoLoxywFtKNGDGz00nF7K39sDoZhWqqS
	 OIgpyLhWMpelJ9TK+DMhGgZkTzs8niZUSaxsR9wXDYab95w+3N60fjnTjT0l+G17nNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Uy87OOjD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="NMic/003";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8831D606A33C
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8831D606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Uy87OOjD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NMic/003
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9G42R1544557
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	adhFQLImZQirbFPoLtUf2pZq/lJYN4GsRu+tngxUkCU=; b=Uy87OOjD+M+H/Cgp
	W4Mm0/BO1WugRB1SeYHgWze84y/G6wDJpnIYqP2i1iXA9SXj8Q5a7acNJvc6eVtB
	gA2t57cXgdFgPVtlJ9cGFfxdggXcYqc6obSojxKxYswhTyLVmM9XErKydwMk533k
	C/Yjn9kst64NcM0bU2oiubzAgrTP/HRzOqJLs1i/Zd/b1aNGGQqkDRgPj8/eTBLB
	cvddWDshVee3WCuICoTPweQsqEks4lDcoPuwc7/AW/i6NLQ/iE23DYYwJ0l/RATi
	kzVVyFaPFe3znakGyzW07wlgzzLlt/J0bKA11gZlhm2E2p1QJRnsVjo5dJwIG/k8
	vdDr0Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy00xx2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94960131b4eso589203985a.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 02:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429538; x=1796034338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=adhFQLImZQirbFPoLtUf2pZq/lJYN4GsRu+tngxUkCU=;
        b=NMic/003iKo2gWqt0MmxRpp+Oy1YuG/JH+556AEirB2aTjFAaBkvsdd4K6e8m0oL4h
         ffNaHMmlGiT9oAtIDJR2fZiGQcepAquml3k4iGjvae4fv4Rg89BAkpOQ7wMgjauQ1OXj
         UhZ7oBnFaR3POPqoxNXtoemVHAdFrfTSJC5hOlPT3RXR8Cx5ch8qp+Jl3PdMkT2BsY0x
         ONqzXngc7N8G2MMc5eL/8hxC+ezJcnXHMmVmyl4/rYRh6mCpvQCcZZeZ7anxAuWTwCu8
         FC10eFvML8YbKn8lxxA4aH0KY5AFluAR4vxDhHZ2bU3rUusFoVwJr1+lRjYpdIp6ROQb
         zqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429538; x=1796034338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=adhFQLImZQirbFPoLtUf2pZq/lJYN4GsRu+tngxUkCU=;
        b=NkHcwanYY4iyCqpAPAKbff3D2VsV973OOYzPv3Tk/ccHEIHHEEc02mL7qp1slgsn8w
         j0GbjiAkFCGnPVcCROEQQfy8VjvpUUWWouXAJcLhrRGmaFKLrOddut+3acPLAO60Ds3S
         NDcCaZuzjfM7QQlS0RPe7KGP7j13v3Km27RSgmMhgge9L7Ktg5U1/oK0JpTlXGwBIiSg
         WX0wOFvfMId1iP7qVMHtOki5rVjZc3MCpo7GmX9rAFl7rTO8TN65tZ7Xci4O03MYe8bG
         zd8aaXexjkbOXw25hl7pC7wNy0TJhxnUpcNip/jYBDIp3OKhnc+L9pQE26dhxlAKQpCo
         Nq2Q==
X-Gm-Message-State: APuU4Z9KA4Xj9urp0TvKTukqHbc9+TfGI2tgmCz3nHCqGAAgyOLlspHv
	VLe6Qzb5Ay1jPmh9JLi/lgD0y0prZl4GdCyv2EjBsgGj84OT7Pxzl0W7N0jsSaq2HxJkKam9MXO
	p2pOYDRs+SSGYF8gzieCQ4giT0irm2FuZ9PyWmprJikMIco9XtST9ecQj+TdUi5M=
X-Gm-Gg: AZFdTZd/9tdwpmhF/4kMfmHWw7+dEP/bHJahszbzVaPg/iZmVIU7jEC9JvkKsRPn1Sb
	noZPAOVy7kdUs/R7+GSqOCFtNrdGkrtowdxJ/+pi6uqPrzK42ztYs99HEJNSA+N6vlQTyufcCGe
	tOcRaXSE1pwF5WOII7Ab2GKm40xtLfILHLzFMtAqIfNMrvWaSq8t+Ib6jdaFCvppCRbingw+WZ2
	xjd4cF5zWcsMfp2yRxyPdgH/L11pZRQA+1l366VDQRESLr0x7jUFRr0zPCIlJ0W9XBbaoacBwlW
	nTBN/X4zDrSoZ0umOnP25iOx0HPTJHJT8NjzIokFx1J9GrBytCHzUUpvAdkUGEbBDLeC83Rm/ge
	PNauZ1UNKAkJ2QmlAvGy0xcXWEFf9LeS4IAxoACpVEsQ9sp887PSNoRL7319R649C6/Gy7foRJ1
	G+vlzAUtpt/fMlo8YnJi6Q80/wWiJzfypNoQnpWQoQXMP2OhyHXptB2BFhygC964YeyB+lOFUct
	LSR/QA4A8cpiKwa0yd3P6ACFoF2
X-Received: by 2002:a05:620a:280b:b0:949:5e26:e927 with SMTP id af79cd13be357-949bac774f7mr1912581485a.73.1795429537801;
        Mon, 23 Nov 2026 02:25:37 -0800 (PST)
X-Received: by 2002:a05:620a:280b:b0:949:5e26:e927 with SMTP id af79cd13be357-949bac774f7mr1912578385a.73.1795429537376;
        Mon, 23 Nov 2026 02:25:37 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:36 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:32 +0100
Subject: [PATCH v8 1/8] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
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
Message-Id: <20261123-monza-wireless-v8-1-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Jesse Casco <jesse.casco@gmail.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfXzweP0TSQGvWa
 wc2VfLBmxst+60Pt58WEF0Sh0F8sP7WA81XwJhJDhPii74IK08sl48GKHQaUdf1CcJnISp3lhfu
 HjkGDSwdHaZv6BK+EWUod9b+EElrVN1yuzUd2GR21S0ScbKRaLl87cyfuSjm4KSPubJq8E1dSsJ
 W8LNu7v6xux9dVw+VBgh9g4DAGLCpcR23Rd8bQoY7j7yKHMD/JzoHyXQvTm04JPxQCMAaJfPsSA
 evbkL4eU+0e0eCYHjmaM1XGLxuewUMLgJOwTrrw8V7kXhMKNw/oncbqjhvAGb8SVESVW5Q/nteA
 V4PAuIToOBYNWyJa4rNLClWIWdb9yljzh8D7e+DMaWuaJ4/Le6hViPbB3FDeARH1+I3BXMVVzdM
 LFhSklbagNRajdQI+ErxL1Q0o2tjy6g9ImXB/yyGVLndl2Gc4Nll7d7m6Te1wcgt9MLZa4ZqpEA
 fRT3pt9aX9reOZiyCaA==
X-Proofpoint-ORIG-GUID: 14oo98AGJvxqPBSMvGqGgp5vzpUR-SLx
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b0414a2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=nT8YUeIo8neH6xSWzyEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 14oo98AGJvxqPBSMvGqGgp5vzpUR-SLx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfXww73Ui29xJzO
 lRphPV5qG4A0JIjbqySvnE+hBe9CdT+xBWjJgONj6+/GYV/lYuehV+Fe3ukB8iWg4Z4wtkzGaWp
 fOhWAWsv8qTR7u5CsPuaTzDai86IU+I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support for
getting the pwrseq device if the OF graph link is present. Once obtained,
the existing pwrseq APIs can be used to control the power supplies of the
M.2 card.

The descriptor is looked up on the serdev controller, since that is
the node holding the OF graph link to the connector, but it must be
released when the Bluetooth serdev device goes away rather than when
the UART controller does. Acquire it with pwrseq_get() and hand the
release to a devres action bound to the serdev consumer instead of
using devm_pwrseq_get() on the controller.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
Tested-by: Jesse Casco <jesse.casco@gmail.com> # ASUS Zenbook A16 (UX3607OA)
---
 drivers/bluetooth/hci_qca.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 158f294c18902a0908a400fae552ed5ad9fe0240..998796ea618822298d7f956a00c6c50f14332363 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -25,6 +25,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/consumer.h>
@@ -2430,6 +2431,46 @@ static int qca_init_regulators(struct qca_power *qca,
 	return 0;
 }
 
+/*
+ * A BT device attached through an M.2 Key E connector is described by an OF
+ * graph link from the serdev controller to the connector node. Resolve the
+ * remote endpoint instead of merely testing for the presence of a local
+ * 'port', as some device trees carry an unconnected port anchor which must
+ * not be mistaken for an M.2 connector.
+ */
+static bool qca_serdev_is_m2(struct serdev_device *serdev)
+{
+	struct device_node *connector __free(device_node) =
+		of_graph_get_remote_node(dev_of_node(&serdev->ctrl->dev), 0, 0);
+
+	return !!connector;
+}
+
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
+	qcadev->bt_power->pwrseq = pwrseq;
+
+	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
+}
+
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
@@ -2490,6 +2531,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+		if (qca_serdev_is_m2(serdev)) {
+			err = qca_serdev_get_m2_pwrseq(qcadev);
+			if (err)
+				return err;
+
+			break;
+		}
+
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the

-- 
2.34.1

