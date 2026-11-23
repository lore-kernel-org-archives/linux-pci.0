Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442177;
	b=xihNLrwiY/4CWv675RsVJe/ry28knGfCqxanY/t0luLSYsyu/DW2rhXvdO1Z1YUlqQNF
	 y4tBSdfm0u+Dv5qBC3YT3aNf/cGADkkA3lBY3ZhudeCrfcIO/ijWkeRxX9ZtkuuQdh0cY
	 gp/NGd452ktEsCL9gliaX9h/TnFhlxkDG3WijQcpplRzlsf2AsVG+Pa2OHVAXWgeC4W1n
	 nGa7qlwAhW9HWZQXd7MAdDattTOJ55M6JiEfHVtW1oA2wFxxgNdBtxlvezhEKqXLphdvM
	 L1iU75GZiw8QgS+5wry9piCb5a5DZFqZbuapc3g3mjJrAba2wtK7rfFr4QgVZzpXCgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442177;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=m5HVoyvcOYYPn841BrG9bcSw+LozVDgWcsxFSE0WYck=;
	b=Pg0Bpoj3rPIfE7iye4L8Js94JNeGfkvJcfFRBjgW3OjgtgFpT6HNNAmuUoaXSiox0bci
	 B/CBMthHVvGVrSAOPelF0+0QTMSK2GQLLX5aF1cjEOmF7twBOy1m5alZjJKEFWDWg1sRF
	 20ubnRb1B/4EqjDpQrv0J9FC1OTht1GzWf1oxIKpBf2xB2QiF5dnTlZZcdd6yGKx83O2l
	 475kd8VjAB2fSVvpRvhTdIM9QxJQO1PxB7f+S8DsU1r6gakm+mqtIDrVlicJ1xggn9TA4
	 KoRL+Awa+xvfvmtZIRvS7jSFJ1Ryz1AgjvGEu2SWXynXmKebAhD9rUf4/4HnJmAA93g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cQwhuwMK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iOlVOy8+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEAC606A6AC
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AEAC606A6AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cQwhuwMK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iOlVOy8+
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDLFUd4030412
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m5HVoyvcOYYPn841BrG9bcSw+LozVDgWcsxFSE0WYck=; b=cQwhuwMKG4HuwC/w
	C5jRFE9QyYl59JDVP3l79g5VRJB+LHFLySF4CDEcrB04fxFXRZLVYm2k5Dh71dX7
	mYgiFyAB1p9E+GHRoXXYyrGajeGvn3I1dFkHc+ow9riNQVBFP9YX9TPjgtQw2htb
	81Y8/LgBgmU+2Wq2Y+hFewPITf/wWAbGpsB9lmclX9iUQfSNC7K7Y8BAWYcHAxlK
	AAzKKu8RUMJf1RTMdvl5L26874RmOCqQaa6G/61JxXkOLUyvGZihI7uJ+X24O2cX
	Vw5C42XQJsiU7oLlL5OK2/PNpWsht7IHuOvKqV8Fw+35yD8EmhH4mwspAnAAeW68
	fuWleg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evshv77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f6f4fe531so541013585a.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 05:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442174; x=1796046974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m5HVoyvcOYYPn841BrG9bcSw+LozVDgWcsxFSE0WYck=;
        b=iOlVOy8+2jJ4QyZnpcc+BtQXgi8jEnmqKrEXMW6iTfqUntot4pwLR9uXv9pMa93drA
         EaQ3xFgiuVJS9/69C9F8ekgCfwbD1Rit2HfywZlgOT9IcMvZ6+6YsBcFGMLFI3VGSOxD
         us9RD5K1W1YYOwWdqqbebsUxlD5lqS7bF1cD7nhtIksg+HXNsmvukQPz5Vy19wQ7gHbs
         uZaVRT4Jiqsxk0jP6ayuYXhiBryCk1PwskMIz7UX4xuDwPP0IXbw3e4clQ3zcHwbIa1r
         MLYeO8h6FmFEAhRqdR/FeS/mDIwI9l9BsvqI2fJlkqzgm2or4cxEY9l8cNN0RVyZxqku
         7trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442174; x=1796046974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m5HVoyvcOYYPn841BrG9bcSw+LozVDgWcsxFSE0WYck=;
        b=XCCGGLX4CK2IqXK2iZvJ2T9ppC81NdGZT5K5fQwBM9D6rbq4+0uAGK9Ok3DlKVOfxp
         ipggsk725NcOpqfipG38mk75+zHWFx4qL6vCfNVfdVYyBo3MGyb8XT4KMV9Zf8lh5PLX
         0lFu7f6bjWYChAmMyYsK7R+Ge9I36Vs6IufNFrrSwqfaNtNsqQ2eXIRntNI/Yg5peX6W
         adJ3IWu7ervzU/hzpQg5Ljzic00uBJ0J3UAB9urmNiYSjnJ/zCKMLPb6GcN2HlVqpk4v
         muzWqjJNjDFDmIk7WhjRmu72xNsBqnqeT3ZZtOoHbaQ8XaJtuBnTBIYEKUPCSjtOC/iZ
         FiAQ==
X-Gm-Message-State: APuU4Z/Q6vNT+mfZ/kAi4OqfdMDeEnYOU7HiaN4wCKa1vSsg4V61XG3m
	1ht0P81+vI+U2+Ggtdv0B7Efv0Jzqrnz3Tt0thA4t0DQ5Xh3Z+95XWCEoZuNoD9TxN+QlVT0Ncz
	ZtPRQmf9R2JyrhYrlwvwENyM1Tp3BfKtYQ2/JkYqXMwwmqKsUv4gssELItV+0B5Y=
X-Gm-Gg: AZFdTZdHnovgMBwRAnG5CzJn72UJcIshRuRKbnfOnDQgmEFPD4FWPCwRZLeALVyChJw
	6EycCn+PentCG8sviqU7OV8084yuVduiASZu1oe3kQSPmzIPJ8gAwmoTSEG70LQOwEYLnQNYKra
	l29MtD8rWKAEurtH3x9vZSmJKV/raz1EsDHMigYu3YRXa0FfWJCSxeAmLgE3REhCzyTrG25YYDb
	0kF0GnyuN0kWg5bjEb9yB4CsYiyCshh7aPUwj9jDBa2BDarYL6LHZu7lK1tReAwPaR4ZhG2kfEy
	mTv9WPU1cHgFNO2l+lPmrR8PGq+c1qDe1W0QTF6kjPssJUpjqw3c/b9EKdVShymtVulVHzGKRF2
	Ej9xdz0gnYa4GLzPwVCh6e+oaIEO/SdCKLfBAu8zz0nDo1J/BVXh5P7OPOosQxlpRR+UlV3nJFe
	jDgv0MpddKKY4EpvKEXU19PZn+jz8uW2FoaW0I21UrsXOJGJkaxR3lKtjOELyyPhUJ/yJesBzAq
	29apnfFGf0dvtQK2JToN/N/LEK8
X-Received: by 2002:a05:620a:6011:b0:93c:c1e8:6504 with SMTP id af79cd13be357-949ba9555e2mr1786392085a.23.1795442174368;
        Mon, 23 Nov 2026 05:56:14 -0800 (PST)
X-Received: by 2002:a05:620a:6011:b0:93c:c1e8:6504 with SMTP id af79cd13be357-949ba9555e2mr1786386585a.23.1795442173721;
        Mon, 23 Nov 2026 05:56:13 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:13 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:08 +0100
Subject: [PATCH v9 1/8] Bluetooth: hci_qca: Add M.2 Bluetooth device
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
Message-Id: <20261123-monza-wireless-v9-1-450d7d764aea@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Jesse Casco <jesse.casco@gmail.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b0445ff cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=oxJxktCAzv21rYXR6MwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: qv9OlicC7BvH-X1cTbbeSe1aFZ7G5aqx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfXxay2jKvmmNy+
 7TcjOcY/cwQ6nGvAXq12QAykccw9TVziXJ3ZKANYY5CbmP0olz42g5BHU0Z4iRtZjELuly79TeD
 VNLioGkX1M3lFePu4T76CTfZmAHMcchTLZcoMI0BOiiroo7BDmmefsa1BiglH2YXtzVaje/fU1N
 pCsIXKDaezSoi4548289wKheQ8zd08FXLFfsbY/kTkuI7nbN/OA7N7ro43nRq5AtJQOtSwSjZzO
 0HHtjafpuniLteXbQgAExCyZ2ZN0ifnO3Nu9Jg2jdM4sQznkLcOTxXe4mXBFJo+vkcFCslX6cec
 pjPGlZ4M/GTj7QDmsbXGR4R/pP7SDex7/wRYoOax8nnh19E5AUHOOLJiV2bcYWAL7jGZv0OGinT
 8yMRWRj+v6tTUylrkjS/s5NX/EqkksGuQl7moRfuodfvJKeUi2h+U263ZFsJ1bSL5wJhGkmW78x
 19/iI2D/9G1MDKJ0m7g==
X-Proofpoint-GUID: qv9OlicC7BvH-X1cTbbeSe1aFZ7G5aqx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX7a1ffu31Mtr4
 J4PCDxd8V/gtL2hqaM5o6qeU/m20jQPUfcV+sNCSibjgblRCzA0KlC60TlU4uSldxp94WJcGgOr
 wZ9nmXdl/kdMF0L2wvGSBrBPP0nHqys=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

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
index d693e28427251e9357019c192c030b837ebb2bb9..c4e42c9542adaddee17e256eb017902ef565025f 100644
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
@@ -2491,6 +2532,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

