Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DE37C913
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218719; cv=none; b=SIbz/kWeWYb0Y5H7/DQ5aHOuYBoEa4c4ZtlCz67MGRHzQFvG0xbU+F2vcxl1RHK1QOaLX5qFXPEPSVJ0qovjtCUfVre+g4ZyMMdSH7H2q3uimNFB/3IYNhnkRnvFb3mLfyXdm+YUGigfBp9PAzxtc7/mXW/GhMupPW3SBIn0TuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218719; c=relaxed/simple;
	bh=SDP/HXgz4amfEH/BI3vkK16jvRVsmUt0sdawVFBJlw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g+WOFeMyrIDVK39owrCwFOugtDzfoFEhIGcs8Rl2Dw74R0ekFxKCLo7g47UicfB9yt5Bov9UZ9IbATLYu7Opu8po6kChKIWOB25YBR4gKdlVd9//nC2duM8zKlWqMKM/ay4G4qnwFIko1hAYwcxxxPTlPpUyRDpI3vNNrZynzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AEdaw8EP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kw4MN4Ei; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEdaw8EP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kw4MN4Ei"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDKAso2959669
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=; b=AEdaw8EPUB0um5rn
	QvxNivBNe7znLZRvXMtDnqg4K7M/EeM7+28mptmwZ52lT68O4tU3NvYuFaD8TU0t
	cdk/W9RXG/4wbGVYUkPEetDFYJAdXBmPZd2dmkgdhyJQ/FzyuS96LvrErh3nrjAd
	89TVSLvm1TzuueCvM1fpvkzmEzfM+txsnLJfJHx5NN6jDU5KEUbo4U5kW0cGcRbi
	7IuIgQa/6a2/BAoELavwshaDfmXkU/yzFLxCoOFZ5QwlRqF9U+PTRyRYY+RzInoV
	3IqMsl80hi/DrQd6+HnhPJzJxeFlq5dBa29+d7Z2imRpaEQRJSaH5T29AaRfAF/g
	wqRG7A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym1904t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f1e4e0eac1so89773516d6.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218707; x=1784823507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=;
        b=Kw4MN4EiuahwLS8Pk1rgNbinLdAyzabzRXYxohBSJeBWar/HEjVhiPOLezC0xLmqwS
         Qt7G+BoLLcUiarfS+DR6e5mlkVZn8/FfO6cF9p7G7ntQ9hGzw93YYBBjP2Gp6cTFTF1w
         RTeonzoCsiWf0GPjlRv71F1GsUIoRntcwl9oZKGjNtXKWjJAggbDS9ltsQ/1ixXyT6az
         HajjTxSxGH2OM8lSY+K1QrgfInjgzBgD3GJ1vmj86ZxM61dp3rcB4+R+3HA0T3REDOro
         jyv9qBy0Yu0TCRnKsgq9xOgezfPeju3O6IQXwsXe2eRnCJzJU8rZFs7DOVIYo09AQd8D
         8GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218707; x=1784823507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=;
        b=mVEWiZLZEyVafwN7dbUfwjXPJV3BuOHhlWva79Te+kfItIorgKBHfecrxxjdSHM4B/
         q6URPl4LOLtiq4WHKW6gKN8F9h+yLsdgl3SrmQ5MOl91A9wrcXNTqCxRf2uR7Q2Oo9u7
         In9weW1639GomMft8tz3TRkEXOXteBUGwHplvfluZ7uxo9MD+VlRXwhb9U+09+OL+arB
         pKnwGfPiG1+lUsi2huFj6xQDJ5JY06D0GsVsXoWdKrj0DXcpErvDF5hulxNMP32svZzD
         kzvUr1eD8/UPXzpoev0pZ3q4EJ2CoWOd22W2WLCHZU3XVR1KU0X6d1cdR4KFD0xK8uPu
         Ye0Q==
X-Gm-Message-State: AOJu0YyO7DoIG692Ea5qBzsonIxN1g0DcFnzUqnGd3cmCa4dlsYy0+zx
	t8GMMo3v1KeP57O/fmhBvN7g/HDKxXW0CvW4PyEQ/d/qoM9ADUG+rMSmL/6jGD1lC9QB/ZV38PC
	OtsdoBHPflNZDYtdW3HcfdIZshg7fMcP142Cp+GGd3kCTTZvYSDiRLLM9CaERYhI=
X-Gm-Gg: AfdE7ck+06hJ44p4332tfTHU596eaH7+X81YJcgEhLkEzphB3xX6Gz7XGroWNXHkWCQ
	fPJHsIfH+IhtSWkiHKyE1ewr+G4TdRO65VDjv4vkqbueap63uhbSqAKNMP0chm7Q3CFRhjJuCsZ
	dGmciDRZhfAPGyCWhAT/GGSWttkyo98xR2gNlJ8S6QnV9eb39abvk4pDIN0IuFKa8QAobo8niVt
	5c3662FcWBDAjKMA2Q4+r6P53wknWZyvTf30QBm2Fx4dZK1wNcjcC34tmPt1911WcZtrOrEeidq
	aKP+UmsVenhF0Ob+xmfBPD+9VkFTFMjihwO1lq0XueFXcqwoiPh+fiJgaTI3R3+Fa/14MqUF7+F
	Fv3O8ZLeQnXZLDdSl3BifmVpXBpkEU7F6i/rsdBHkY11KFOEc4vV/ycaf/839HWvRMr0ZU4rIpG
	NaDUL5fhskt9mXq2Nc+WsC8lecjlwdeyE28soPjRgDFPD4ijafr1k=
X-Received: by 2002:a05:622a:2c8:b0:50d:e471:2d1e with SMTP id d75a77b69052e-51e4239fd84mr117365081cf.35.1784218707226;
        Thu, 16 Jul 2026 09:18:27 -0700 (PDT)
X-Received: by 2002:a05:622a:2c8:b0:50d:e471:2d1e with SMTP id d75a77b69052e-51e4239fd84mr117364701cf.35.1784218706689;
        Thu, 16 Jul 2026 09:18:26 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:25 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:19 +0200
Subject: [PATCH v4 02/11] Bluetooth: hci_qca: Rename 'power_ctrl_enabled'
 to 'bt_en_available'
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-2-9b02e6f549d7@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a590455 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=wYtw_XDhO1ghKZOGarAA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX54G9o5Z/nhIj
 kL1brCgfC6TjLWlineohNorg0MvPDGBsUnRpGC3PJVVFHpevBPm8I8MCoTxoqTHBRqIpPK5zaxP
 gRxB0KjVCdu8kLVkhtsdwY4sG3DaJAyywzUJAM0/IoyVDcgn4jg3WEOR4HekVP4GC1GlEWe4QfP
 qnVoTv+NRMAdlzsCndm1jKvKsxGCQt/NJsGWo/zknywfjBQZN6ufiiHdPC3B0EcyCp96PmiIJTb
 GBFbOjmQ6tMfV4YNWEwJ6pbFHVi6U/Qjx9bpULIqTjSSlqJsKd0s3I5QGDnZy3BK/xVDuTPW+eB
 J9sxpa8XNZvkG5r2UAt68MAUvSOldP7kczed/YWxpcAJ3X6IpsAHgr1TSH23ovZIqPzp1nbfOuF
 L53EEkPZ8G5lFOPYh4RNOqDSb55LmYnXQpv4qbJueSCx75ZCFhDiOPfR+a4NWDT+0g64PvtxCDg
 45Hy2JeIpvRKPeQVGKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX7pHXO8EvkobI
 yh2BAWvh/TvLqWdTa5egI74Yqsb0xVmwEe8MpxyRmqMns/49lvziVOG4s+cJKc+3OBPz8tmxLW1
 KlGRa484caLc4ONapoRUjRhkxc2M/SM=
X-Proofpoint-GUID: qjcmQFN6WBlMtXQXrfDuz5ICAh273G79
X-Proofpoint-ORIG-GUID: qjcmQFN6WBlMtXQXrfDuz5ICAh273G79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160166

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

'power_ctrl_enabled' flag is used to indicate the availability of the BT_EN
GPIO in devicetree. But the naming causes confusion with the new pwrctrl
framework.

So rename it to 'bt_en_available' to make it clear and explicit.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 135c79e696aefe2b37ee7a7a668715360a1e2d75..17f436484e1e74d1dd690ada22134315abb767c4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2393,7 +2393,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_device_data *data;
 	int err;
-	bool power_ctrl_enabled = true;
+	bool bt_en_available = true;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
 	if (!qcadev)
@@ -2501,7 +2501,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
@@ -2539,7 +2539,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		if (!qcadev->bt_en)
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
 					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
@@ -2557,7 +2557,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
-	if (power_ctrl_enabled) {
+	if (bt_en_available) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		hdev->shutdown = qca_hci_shutdown;
 	}

-- 
2.34.1

