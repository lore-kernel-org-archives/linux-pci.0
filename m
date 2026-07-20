Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329B2F549F
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534653; cv=none; b=mOiW5R80W+Udtr+vags7JnAYCWGWpK9jXdeSvrBoCanhY/JTI8ldVybkxQAGM7zG1A8tmIhfXlTR/cIBf+IQ+2Z7izm8mmq2L2Dn01gzz94hkqVX//+ZQXZYoiUrkivVDMUqsSNYU+BzJqbpTp0r0rOJbmzhKpFGTQSkZgdDEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534653; c=relaxed/simple;
	bh=KEpaGYLJg/HFUQ4VCnAAAa4/K+FU5Ww1paHM4mUD9UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n44CDRiirO0yi/kh5ZdvIMF9RCKA/+p2UJGe6KPC1t+jhyKKJoMXkyMaKXqSEGTK/ZN7i0VZoEZyPzfbT4wBo+Bn0OnXX0hE8Lu+ItlhJLC+LFhmCgWCMn0NoupULSGCh9NVAUVy5qo7sXFRGouUswdomR4MELgzFW/1VhLuUSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ObLSV1L3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R0MBgJg1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ObLSV1L3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R0MBgJg1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RVZv1762334
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=; b=ObLSV1L3NZM0JoOV
	awyLlEcXYHGjLDaOAyMHUQbfwnzMIj3Mvbvw62/PIpyGgdcFMziZXLlQfouxi8gT
	kldrzxmleq3SkRrPABeDwZxstV6McS0Kh0kpS3n5NErEIn3l6CRIrWhnJuwgxiSv
	kFC4g+b6rpw6VTL1La2/iVkA+1Z5s8FVaneQ2dVzoSTAHU3swfI7hEjoivgHyzSU
	X6fA7AxmFB4k1CcU8KdWTfzhLw5yCHkzpAj55+20D67MYfWcvCq4P/UvhcE0YJ67
	rMl/FcK+GFAGMAx5cgaJViE+dYwX7S6dm091So0L9B2ikLjVSOaft+qJZAsYb2Ej
	bprGlw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnn3kw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1d137a68so261954471cf.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534649; x=1785139449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=R0MBgJg1O0oE7tGvAhrTw7q33gbHFqotDedJwaZ/cycjQK5ig9XAdCDaiDAWExBVKz
         EQRHwMB+KeUmXzpoFzc+SsUz0vMXBwgUvPUd30MEQJ07UdPX8XX9DX1fXeoR8X8GkVqa
         otztwFr9ilXRj32ATW0auUo8Y5rkI1fwV7aSjkWTlO1U4hatGtLus8I0KgnsgJZyxG9p
         zO10xbyd7eTABlZXaYkxSnN43ThBF2hC8ptOVywMvvkNwN9ZwpTgXdci708DXLPp6CC7
         R5CSmHyzh0LL+psUBZRJN+hKerRFtszdI9C6Bnx5iVFwU1AaylxHeK/Sbbmrq3fjIf4p
         0Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534649; x=1785139449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=gI1ZusGfyDX8NMaihgEc/3dtqUd0gMp9LfpNrWCf6ZqFF6xPgR+esshSIM6MAy2JI/
         nb3CdVSi41dVT3DYyxrM7Y4wEgFNtGY6YzHcYWggx0LyWsXmSPyCb7EbvpFysV+G+ulz
         WY3sVAt3sH6HkMmokeqT44isMGEmOsHqkwoZ2vCaz6wy3IVYMsqKUFTXCR0Mt3AofRPi
         Tj6dMiTt8pKhwf/MTMqayUHxRMT/unpH3FIbdbXazbG6JS18ldR1Mv2jJ8jFJ1Vc2U3w
         oOj1WODwMKyTW17QZFxnLHNmzpc1R3ym9TI1l0d+mwwQjeX/5LpqhTnr+7aQdLUo9YS3
         AI6A==
X-Gm-Message-State: AOJu0YzCXIqM3fey7EebTKuGRko1ieq/Uoifxl0/+wDKtMoFs9V8/NWl
	ga06jh/m6KVopOtYcz4AR0kAmZvJBIKiuYnIsFKZnBh4UfdU99IjjOgCjfe7jIc4BHOxb02Xuuq
	hUrtL1WMTTk9BoqcnDGCr46KE3Kum9d+Y5BVfBtGq+CZgw40eXK+1FWNAQqjOeMo=
X-Gm-Gg: AfdE7ckTYRnhzH8YMB+zoS58yfEd8EN7goD7epeCkNcE05Xrj3ASLFzPUQupt/x/5mL
	uh10BHEddgGoSfqjDWLAXCIKXo8i3tQRBsCWFC/5ijnUhEzioGNEWCFBzcmn49y3OBEiRLEnn2B
	jqNF9IuxEqnaTmYqaUoTHLE0EitSLJ3Z9sZO+U6ILTG2JGDfVOLB7jXVSN5RNvpgkmg3zpxW/fq
	cO0nVXe1wyb8XpXG12eOgbc/7bwz515kgLnYl0Ixsg4Qb0jaJAuyqh5fn4LEZMhhyahryyTk4iI
	wUWUq75s6QSQgop0TDmibLCl44EsZ2CwIpAZjz8o77XMKARdd7TGe86hckEX801ugkh7jlwm122
	cHYQ5UIFNhepb6hdJn8IKoz1IUFx4csj1lOaDzA6oLyH06dlfM04CBM3oiS5vwE1+qP+yhOWD2r
	R6stOkFyPfLWleCc5iaGI34QDlzGdRDsAXmZJq7GkCNjYzOnmbadU=
X-Received: by 2002:a05:622a:22aa:b0:516:e249:e30f with SMTP id d75a77b69052e-5213e876fdbmr126377531cf.42.1784534649516;
        Mon, 20 Jul 2026 01:04:09 -0700 (PDT)
X-Received: by 2002:a05:622a:22aa:b0:516:e249:e30f with SMTP id d75a77b69052e-5213e876fdbmr126377021cf.42.1784534648784;
        Mon, 20 Jul 2026 01:04:08 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:08 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:03 +0200
Subject: [PATCH v5 01/11] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-1-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX7ByXdXAq7yYS
 gCdfcI9hQ8dzzDW+5ei0BDfHAbdwlPUCaMaGhdJEgPerhUzfXpWmSptbQW3lJDH9zKbEEyggKt6
 mhBHofvo7Tz7uaKPFVZoDbu1kVh/5E7O++pMn7dBLJKOoQFeJg/+RtxJttTdRi0cSlEy5jq1yDG
 uv/92TW3JDVbmNM11E9n+rKxqCDp166jjHI8lYnh/XE/p+nHuvsZhm3KNV58bwDJHX/TN20j+zP
 CmZQNBNEJ3RO+5vkHgWJNVjp++kQLxyOxzdXMrZtz2CDEri8lU367pW5WhsJmxpCCtGiEQmdY0V
 8yxUcXaxvpV0I5uSYFj+g630rNDng9S4KmhI+jYPa+DjJH6MBpDYuZsdDYCDsQiQTf165RdKzCK
 JEoGEtNokR2WzV/3nna5pVjnG2ztTwp/iyXyp/cFnJU3NyU8QLHzAt0w4wwIyb1O80/EbC2qHKY
 cORAm3CKi8nVDFxO4nw==
X-Proofpoint-ORIG-GUID: G9oAOIgFqFGal62R1I7yZEVpdtomsQ-Q
X-Proofpoint-GUID: G9oAOIgFqFGal62R1I7yZEVpdtomsQ-Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfXwI3Gl1A7MONd
 X55ih3BOoR4M7zQGSbiOYd9rrV1OrxzaSPm3w6FpBCwmY5jjD8f7cmBDMtTd1vWwFiLi/K4eVqu
 S15xc9OgKwoYJlDd5yKzVB/Mk/3xvA8=
X-Authority-Analysis: v=2.4 cv=deOwG3Xe c=1 sm=1 tr=0 ts=6a5dd67a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=14bN-6-z4zEjTU3E0XQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088

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

