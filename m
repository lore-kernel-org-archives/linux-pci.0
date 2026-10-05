Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF048097B
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202912; cv=none; b=CwxcLXfK1pi7aMq8S15Wy8CsyxHopwX+BRFL41ZDScmxHW7Ul0QLVzq4/vmT27+0Yu7gDHJ4tCe4jxwFm1zVPnxwXadcsOvikwSWQhnDLH5gdKF4bPEhq0PQ989CpjtCvEfquU4kP7IAa7upXKyQiWcivsNZpqq/vsqZ5RaMd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202912; c=relaxed/simple;
	bh=UbfvsxV1N2Q2BwLuWb1XgYTj+UMWr2glJ7cM9WRcoZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PPb93uP0JCQwLyrurlIctVsamY2NTXrqt9b0wM0dlGe6mtfnkycFOydut019Oz4jqKL7nj6i8mF4c27gwyzoKmb2Br86IXNpTn7dRrek8+QND7A/BVuzHVoirLc6rswZC5K/9HIHMfnNsGajPyvJ17pf8gr4+XOd9jiw8sZBdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X1s9ueCy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NCsl8DIU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X1s9ueCy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NCsl8DIU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFYpH914125
	for <linux-pci@vger.kernel.org>; Mon, 5 Oct 2026 12:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	khcQaR9KeJm7qpoXnT6a9/DyCnO60USLg+886y5MCh4=; b=X1s9ueCyZhaUEX0g
	fb6dt+yMvYvSoqcIc7Xvs2Wpp3UL1HuYyMkjjRcHrBeRD4Ztfmpja8tEiY/x8iw/
	8XS2lTFV42K8w7uRO9BwdX4xV6m3wIszxruVAYmT+qnCibpwnecJoP4sFuAFpKk3
	NYBCdcTnkeX3kBnwvRcwyYR/p/o1w5p/CtVAuhzjnBKwh45txawBkaq0quX5F1+q
	kQStTo8KOcImqG25oBSiOMZWKJFMWBZ8age1yUSRXyNWBtMXIVzvru0LewHlSexy
	iMNdWro8eQtz59IZNqW6ounfJ/pYI1O/+ji79ULOm9vmr00NdqGPJ6daMFx0IG+i
	8EJM+w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3chfknpv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 12:21:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93dd3c3badbso357756485a.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 05:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791202908; x=1791807708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khcQaR9KeJm7qpoXnT6a9/DyCnO60USLg+886y5MCh4=;
        b=NCsl8DIUorVPzmgt4Q/FVjzG6nRANqscLHis47k7x/j3/Dl26A5p0MSxSYCWH1BzZ0
         9J+DZWOP/mYjmPM7s8MGkXdPuuQbyTtb7t8W7QtwOzclrue5g9E9o+rI7aec/H0whlS4
         taWCvFOG1BIH60+uml5n2eXzRnbbFq8h2uxLAZ2idpGjI9jMkd2sLE+TraxcppvMYEbs
         ebVEgnMS2Q0CnDF0dJ02+yNQotq+lLbopKhVjb7rigPg+Ii8RLyFLHaI9DhhspWoVj8E
         ofT0O+ZN+tyVpwiCmBTiR1Ime+okQsU7d86Dwl7aByp0e3IDYD7Yz/vqJNoiHZo9d7az
         gTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202908; x=1791807708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=khcQaR9KeJm7qpoXnT6a9/DyCnO60USLg+886y5MCh4=;
        b=CHhX0JOOGiONINwEU4W6y2fMgAxtY9ettpqiZPk2+P17PCgZwz5tmaf7PHbxs1mSQz
         36YlfefEW5PB7JUD/RLlhze9sL33CYxANqbm09w/swwIhdLwWdEUSsVSH2e8mb9nEdnz
         3OZSFJJISBUVLuhze7I7VEei423EHjjCa/PihPkJkyM9xCH1jXvrlxVVALbyfW17uFuU
         qXIiAKuOdmfUAWnM4NHmwmGfzjkpQFtoddNxPvh6UfsiCe0L7YG4HAIys42B57GuM5Wx
         Mf9CjmR1Tv6s8a2KoCMGnkESmF9Host/JAAPFjpEVc2kVQfpA2ZP9KhtRQ7il+/QDH3j
         DAOQ==
X-Gm-Message-State: AFuF++mLV+eOsFviMVHHdMUPvqXxLwcW9wQJB8pg19MlPAT7q20L3Yx4
	UAVn5FXFOEZQC8oIUJ+7tw0Ykjph8YmUbUAu70wr7VplyD3iPKAcFe/uFikzfwJiGTF+BMUDKnu
	2EZrB/P+CWHLIGvJLfDomei0y9fpUXRRkGSSbla8/V6JSHmNR+rlM2UH7hQSx0Tk=
X-Gm-Gg: AYBFou2+tH1Yv9FOQXki1TLap8lmKRUQmK7p6I4aAENOkaEzkeuBBUYOCGTCIG3r1uR
	38/2JuVMtbd7j/g5rteTwhEqVTDZP7el4qi9YHhT9Yozlb5lFPhQf6Ved8ecITOyiqMf5aOiCQ3
	S1fI9hnSU1BVcw4C+V682TjWJ5lVear9i4odW7rOheuSrt5HA/EEYNvHvkM4/Eyi5l+46V0Hmk/
	tOX5W/CXWrb3k+Uc7lFc282Ar+iEyIno7hRi/4BycXgoC+CiYU0k12Jpq+9rvYytP/FfcPQ6ubR
	kZNebEyxyR8gW72l8Lm/evzOsbR9cOU10nUoPCLiVl4BKrnoKqbt6YXvIjMNckEDj0axe0pUCKL
	g5hjG4x5JtFCv8USHnSsueOWJ45sZwB9amqegT7veJX8JJKt3q+1VgQTMvzwz7HD69AwvrMeKGJ
	xHTS8+Ota0n2trlKJrRWr7XeWyFvjPcosEGFGVwnnlOI4xg2/MATSz8dhC3wca9te5iOuDrA==
X-Received: by 2002:a05:620a:199d:b0:93b:beb3:5898 with SMTP id af79cd13be357-93e510787ccmr1202221785a.49.1791202907801;
        Mon, 05 Oct 2026 05:21:47 -0700 (PDT)
X-Received: by 2002:a05:620a:199d:b0:93b:beb3:5898 with SMTP id af79cd13be357-93e510787ccmr1202218185a.49.1791202907310;
        Mon, 05 Oct 2026 05:21:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm324157425e9.1.2026.10.05.05.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:21:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 14:21:31 +0200
Subject: [PATCH v7 1/8] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
In-Reply-To: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: fb44y5obb2cIYmkAekN6rbzKFpblvJvf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX3YXxq/IjB5ae
 c8hWPcLMaRK0z6i+1hyJCw27L7RNDjWvDx7bBoHRdEjS13lbuh75yYv8RyHD5/QJtHWoj1XkOqi
 u2q7zLUbgVpXd0Vku3hs3pL9ksi+qaY=
X-Authority-Analysis: v=2.4 cv=eZSo7LEH c=1 sm=1 tr=0 ts=6ac3965c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=14bN-6-z4zEjTU3E0XQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: fb44y5obb2cIYmkAekN6rbzKFpblvJvf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX7Qzyxu4A3OV5
 e48spnM6vuNC5QUD0U4CCEKplgmOadqmA1Vi2+ezQ3/QGohMn5PPaxuZRVPz4oO9DXfopKlE5fB
 QPotr2wf/zsWKdM5H9mfAJkICm9KAJ6ZiN6aQWE7EJWz0ISy9TjaYYmrpdJzZVjTAcEmTYCA7Mz
 qAoPYTOLH4h3nAH7iu42RTIZxXrtxLpa/CbNsPBpMygK+upTLWJmrREu3JVeHyrmhSZA5mbjg0l
 us0BVyuD538w5qw0MeLn0ZhY6/k43h6fIGWt6FR8XwuuzAGxQwiwcVxHCoRC5c+tbrZFcp/6NyH
 UO32bjQY0v6b8iz6MENeUPbvm94vN5rCIlwLJtAArQdxMvTcAFI+InTo/mAME2BTZ5w7jA/AmgQ
 kXeiZKlJiVqnxscOqrvuN454rU8dWmQxIE/96S1bEY5BpzOemCDEXCXuupoTtdxtq7A7iFyYFkR
 OEuWmF9QVbKZEdYGuXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050048

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
index 7089e9b639b2aad2d5ad2d43b07f495833757805..e249fc6e44479142e25af4e37bc4e1bdba13cd98 100644
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
@@ -2454,6 +2455,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

