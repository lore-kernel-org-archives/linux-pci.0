Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F63FC5B9
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677457; cv=none; b=Lhog4wuwdnc5JG+Yu59HPm+aY6wpABEuPF7X469RL9o7VmvqglA5TXmAxHqHu6UHEOiW0Tm0h64Qz+2ZJL+i8yJjsmApTHK0zoqNjFZyucIesIS6S5HUj1lhlXhLT36wM5bpnjc6Sw1r1ov8Rk0gfceZBNfUBOZCqtVFvq6D2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677457; c=relaxed/simple;
	bh=KEpaGYLJg/HFUQ4VCnAAAa4/K+FU5Ww1paHM4mUD9UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+9Nb6GyD/lrriZy4+Od3dGSAxB7jpJTKxdAziT8d28GDNElmchR38aIvh+ZkZjSbx5hlaaI6hU6+RKrD82dc7Qn2BMRsv807tMVbNAY8sY+bonQsPezHmal2+1AoeY6J61Jc77vSucXv4sngEcdHDHF1cKjUYuYvSP4fi0t4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=imSWQRTa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PyUzAL8E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="imSWQRTa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PyUzAL8E"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7eH0i141498
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=; b=imSWQRTawQRpzQNc
	mwknADJeEsLPlR3YFJePXgE+g2CgMtH6PhCsxzYu6wd7US5Nx69vYJpoMoZIt7uZ
	ydQPQQXaH/36mm5o6bTGsw8RUMelB+QtP0+646R8Ysv/anT/JPfsEa0737vDafR/
	syB4JF2ODhttzmyxQ3Di+cAOryTXkiWl9jzHpF5QjWvMjYq8d18bipucQBiO4QXq
	0/z8fwx0WM/zO2yfbM64iDJba7CvX7wwnV1nt2CO7N6/4YaKABMuRBFTcfCWv6GR
	3v2NzycAq7TJgQrJlyycdYS46QCtw9/euhWSr4U6z2bMuYovgX8AoTDMyNXYr6LY
	lNmHiw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5munpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c01ff996dso6776731cf.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677454; x=1784282254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=PyUzAL8EIpQpen8yYLJsDoF02JJal50kHQNDPB2OcRPVu05MZE7R9bztwGQBeONOxc
         csbL2jAtLCSZInY1AxxdxfPDBd3SOQxp+qFtG2SU9oz5xPK7Yv+aehkvGTdbdbF919ka
         FEjRcHkNe6tnLvxP2XGKf7x0bz8+haiHUyTOsjJ/UsW46ByTS5OMf69J6SeRric8AziM
         rO0MO1Yspkxgdx7M6qEIUKyJJxcoKGA+7ifO8HSWmdNxE1H6ZhPmHL3NlNLUIqo1koxD
         6KNqEE/wdiRhGE9QD7yI0UzLiCQiQlmrYN0bTKO2p9xkkGgSop81JWwbMSqTzfFjrexC
         dp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677454; x=1784282254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=YCTkgfvx4MhJOnLlRQWnRSR3zrVyujK0b+cbRMwN+TzDSMm/mRUh7XE4o5hto9SWDv
         axBFyioyrOFSkEt8KOq3D+8j+uIyv5NPWFX7OMgLk7VMUfatEuExU8A3LnktFd0OWY0Q
         brbp2BqJ+a2BPH7tCeTYGuElG4e17Yhf8tusu5NxtimOZo3UM7R332wDskQzzGPMvRwy
         LgxHh0Pz0IZRn8sZYj0ThatdnkkTfRnY6cZ4t2wkHEnIwzwEr/HRSc8JlY3m9mo2KJAv
         NbefmdFJ0z2caR1CglB4UsesYfjDZCKL56qHhkEMKULcr2azbsLBDxGdQF0E98Lw7Wg0
         RgqQ==
X-Gm-Message-State: AOJu0Yw0D8JqeoKKSNLCtn4sTTw2WM7RXbzM/9ztVF304PlPILZQvxo3
	xxePNsQiwVmFYZKnyWgBXe1Qp/h8IOqiK3WXJmB0KUPb4WBTy9vLgIaxBEHcuBfwenOOS4bddHV
	jMnXhp+lju0p7k2J3EjHDIvStwlFlvEpeZeIwkIJGxtCuqlzbVQ1n0HylukpCXMQ=
X-Gm-Gg: AfdE7ckCrqGmJDQ1aMW/yv0G7N8mmZyBBrSUS7wy1KWRnWMOilZE7fJ/IkQ9Dfn6aYe
	2+Idwzk2wmL3k69jYWFVFs2j9rjmlCZuVjTsOOUEh8Szwu9KQmmD+ezBYMSAVHC3bvK1TUrd8Gx
	o6DSyIZ3I9h3/C0PNTEOZFFDDezG3IYmQ1g3QowQZHlZEhEoAXz8WmVDXttYs6GaQKQd0UbvoQ9
	5pgxfnRdOalHR+aZicd2VFU9d+JxdO83P88l8fvQT37K55V8lkJv5y+tYGvB6OuN1cxeeRmMjI+
	xeT6ym3vyOgj7BHHSsLatQYCSenFgHFSovrKjLegjfKShNnYy0v2jEv3NeGu8pT89i/O8tgPwZp
	032iU7plqBf1+mYNrw/z5gvajkSM3UmQnSXlscS2SlGFIWcyFxYmZLqQgPyll3CFiZXyIKAWuQh
	IDPlMih4sJYvm/byedkuStxkt4kFlXpDF1C60AU1uZe2EubXXVa9mKCxGLkJh2j4miBeI2pbNIX
	SaQOvgXOZas1Q8vMwxz
X-Received: by 2002:a05:622a:114e:b0:517:6435:c4ce with SMTP id d75a77b69052e-51c8b3e2e3dmr114665161cf.49.1783677453739;
        Fri, 10 Jul 2026 02:57:33 -0700 (PDT)
X-Received: by 2002:a05:622a:114e:b0:517:6435:c4ce with SMTP id d75a77b69052e-51c8b3e2e3dmr114664921cf.49.1783677453240;
        Fri, 10 Jul 2026 02:57:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:27 +0200
Subject: [PATCH v3 01/11] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-1-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: qS5W_Wj0GdFpon9gvdGf4OUUMNm1k2kh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX9MixojMkT9/j
 DwU/Xw7RfHVVeBcmEK7PmJihaTAx67/tAa8oNFvcr/llIaaelLwe3Hzy2+Hh9RYb7aL6snQVspZ
 xBr8b0yNRLvVZ3tcjgjbM1vkSaf85uo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX2EIOmb7/Izr2
 0wW93WXXIfpBarq+H2PRw9+ZRmtm5gKwBW1vJcDP1uF823116ruCE9kkKci8KKNeyalam+ZZ3cv
 Y8/ta3ONXAcf1RLc6/uEo7mQn3bQQfKrPXxPgYqVC1HZyLl6h5dDKgljMtKgVvb8Tlo4Zi7Whr3
 OyNpUVc8JK0OOLv9XSSnyY+jrpLWjJvHSaoie0LFSMec82dGeXBT9IijRV2W+0EetsKfB1nu74L
 6B9oqZ66N6udhRshEpt9VaFK5f50yLBA/KzDV3fCTRqUuO8GUNMUbGkQYCnesLRRCRBQSFjNtyd
 r+v7iRvu1FhQWPDt/gwgvX4rCEnMnUdlrmopLT+8zHtKo8wjSz0KF5rbJE+3xEn5pLsVoMKNxdB
 OHw1dVtcKHftgRGF99NiKEFb9H1d8nnLunsSF7PCcmI8SWpj/zWtG/FLM1jKq12LvTETs493jTZ
 Tn9bop4HEDNwq0pTANA==
X-Proofpoint-GUID: qS5W_Wj0GdFpon9gvdGf4OUUMNm1k2kh
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a50c20e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=14bN-6-z4zEjTU3E0XQA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support for
getting the pwrseq device if the OF graph link is present. Once obtained,
the existing pwrseq APIs can be used to control the power supplies of the
M.2 card.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 2444471956197bae62a1c4c3a776c5591780ec02..135c79e696aefe2b37ee7a7a668715360a1e2d75 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -26,6 +26,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/consumer.h>
@@ -2445,6 +2446,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+		/*
+		 * OF graph link is only present for BT devices attached through
+		 * the M.2 Key E connector.
+		 */
+		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
+								   "uart");
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				return PTR_ERR(qcadev->bt_power->pwrseq);
+			break;
+		}
+
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the

-- 
2.34.1

