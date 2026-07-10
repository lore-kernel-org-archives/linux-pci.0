Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851783FDC00
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677468; cv=none; b=Rq5tHbyrc2CI0RTuUcYBJeIbwpXaZ+8w208eDCyP5WyAVWB17HcJyc4O5RcclK/0/VmMNeLJk8U10XfSgS8BOj5z80lmx0MejGSJcXcv2al0pimuYdhW1XbtOtJOPzJ3bsC7s7XtWwlyWBWVegHMdDFdOX23PMPp4eiLi++xWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677468; c=relaxed/simple;
	bh=SDP/HXgz4amfEH/BI3vkK16jvRVsmUt0sdawVFBJlw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fm+t8SGqh8V8+9e+UN4QffHFSTNHd9lVdEpvb6ZrFsnRR4jhmmY8Gto+5MQxp+xjD/oChoSd3Fh9W1UNfIx/uAtjFfGanF0B674/Bpd40keYG9XJt27gaWgKSBfc8t1peLeMY8SA1qfaUMuF1fRFJE6zXHP1muigi/Tvo2S0xlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bMEl7vZO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AyPfjdb8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bMEl7vZO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AyPfjdb8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dSZ6182752
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=; b=bMEl7vZOTf4dDadp
	EzlAQnUxEqs+ldnAmqhMDH0+LSqEFMW9vdihBed3ExQzkon4MXvnfTGGPIs3Jos7
	eWtw2JCrYsKPXX5g/E1/4+zJp16/bdUJ9cD9nf9YTz1kwIhe6+6vqu7t4SPZWCtv
	F2pgZkZeHIrsUXJixKP70U7Rr5iY3LK1MaVXjb/KZq37oiu3CV6tdE4DhRznd+PR
	YwtkfXTqGpdyBz6/8feSqDJxMU8Td8Cd10LNsKx8cM9vjOUxJgkytYnPvB9D4C1J
	FuJ2n3Ck73w1qmWzovubuUv+npI/LRHUpwxiYXOWAUXdR2LzS8r5Pb4JZgl21jGg
	riBE/Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte2hdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d30035dso4896191cf.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677456; x=1784282256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=;
        b=AyPfjdb8gJ4oonHJoGgQD37xzqVfXkXKKE6nAUc+U17wn02SnfC+mUe1ffzx3SsuUj
         PL29jAQIQoDgLQSPOeLUOUMribhORls1HeaZo1SVfUICCHvngr0wDjqiKCMBV3MFde6C
         CdhU5cI44h9pFC8m5DUwZgI12+54u4xNjZfrJArk+len157zoEzEMe5L5ROXBE4WjXAB
         yk2L2MypgPf8mIPzFodzJzZmfIG33fpRDl23lL7MSN3kbxvzVfqCY0dgeQvCXMoNSstu
         96aAlsA7zKPNYc1Z+VCaGYkwz+v36RvATALCayDGXI2wKVJV8JmgH0cGtERX36XSZ4Md
         GjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677456; x=1784282256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=;
        b=EjsvRk/0z048+X+ox96NMXoMWXyqBvsC4b1Fdka5vf6RotKkIpORjQ8hJLh9bKAok7
         +r58ryJpEkjnIXsu4sDsIC826Xdd7fO6IQzWDTK54z2hfooN5CLFbP98FQAaH4FqUsj2
         jkWqbifKjVWsLRw4DK+LwtkjFhuK7fJuP80fNn3OuaM+TpwlHU5SeQx5ScCygMXRkNCT
         +UT/qqiQ1+MJL6REAVw5Iq5v9431xc/FKMCHQelaV5KsjcSZU/xXWbQ8RtNPLiqo1AjW
         4VzoeF+PhDal7RjMgN/7gasxODxK+pLfmkwOK6bw84CRNZzRShQpRgS1P85H75djll2j
         k61g==
X-Gm-Message-State: AOJu0YyiMp27F1ObwwMgdv5Fg52abqqAf2R9+APPjKydfjLmj2yl95Tc
	jXntBOxLGgRCf/PVYXdpx24cSWQbGnjWY1C7WNHaONfvU6DMkKyU2gneIwwYmCb2TsM5AVDpVSw
	5/Fn7k+zHgS0dh1LTP/t4FxAwBdUCeys3fdiQohh205VaBI+rm4MGHjYI4v5lEDc=
X-Gm-Gg: AfdE7cm92F3FMSEvGoxSHyPMyxhWMbfp4a+Ab/VPFY2C01QJZqUTC5jBEyiOqigklKA
	bxcOJaBB6EoyBFbDR8bPLB7JwJ1/o55o1mcczbjHh/BddzXjaG/NR5c6tgmSnCrRWlNeyWBl0N3
	48Dqmpawu8N/Y7kQN9mYhFPKUZUuZp12sUoYlwD4tvit1RBRiQv4zde0zixi6i4tn24zOZ2YGIO
	hO/4BM2MUK+2w1jxmra3UevVda3MJfhUovckMlmmngHHBDxD1SEG6Elrxwb1LUg2fHnGzwiQFhO
	DiZ1MJ2UxE8mtMXihCCEFbV+rezFp344LJUttjASWsEVj3R6CGz91LCjUPaMSCZvvlT7vwHSI2Y
	HqpAVQTJDzDvjM6wosvuJzDBQaiK21tgzoinOv1XOPgDIIJjkuXO/o6Eb8QYU5md7ayB2EYfHMh
	pAQ/q/rhVMKwaMCIFkZ3lPF5KR43I+7OgAQr06Ek7E5gNdGR07IRkVMOsK/c7W5q6ar7N97xnZ2
	inMBqWstmL/oppc1cVZ
X-Received: by 2002:a05:622a:4189:b0:51c:10e8:ac7 with SMTP id d75a77b69052e-51c8b45652bmr114762531cf.37.1783677455762;
        Fri, 10 Jul 2026 02:57:35 -0700 (PDT)
X-Received: by 2002:a05:622a:4189:b0:51c:10e8:ac7 with SMTP id d75a77b69052e-51c8b45652bmr114762241cf.37.1783677455256;
        Fri, 10 Jul 2026 02:57:35 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:34 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:28 +0200
Subject: [PATCH v3 02/11] Bluetooth: hci_qca: Rename 'power_ctrl_enabled'
 to 'bt_en_available'
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-2-46253587af64@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: p31y1EpNS7hb6NnO4fo-2ekrlCkNxf03
X-Proofpoint-ORIG-GUID: p31y1EpNS7hb6NnO4fo-2ekrlCkNxf03
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX3stYO0Rm7A/Q
 OV6Li78Xt+6ii1uz5ErbdCnfV9p2eh1e1zo9YcXcDJtjARmD83yksBRFlJwhItrBCJ+me5gv5f+
 PrQcAE5JMLpgr1yaUAWtuJvllgxZikSmcns9ugL+hEiCpH3JgneUetRJ+xzgRDNtl0q2vO429dc
 EUGPallw7b96TXB8uXVXosW2V0B9nK3Lsc4j76aksorLF7fqATnLoQ35ZJ3WYPfLc4yIb6wh5ht
 1ROSGTpys6Cx7QjfjSij3CQOuaLoIPV3ZExY3bmI7f4xMGRNB7D2IwWdWTj1a4fLVrCj96GOrg3
 K8J4JdCJy/upKkl9P//ffiywf2tNyYh/TZPrtEJcSHHz9s7r/BDFUtyMpKoSRxoO959EldtOXnU
 loLoI4RE4jbFfMNVVaxfgNii2igH9S4o7OIKmGPiy5eoZEBSKvLJ2JI894e6ue3lGitAIigcAIw
 MNGmql/5X9vawtjcT7g==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a50c210 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=wYtw_XDhO1ghKZOGarAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX24hDlepq/u0i
 BH13bVNLhqkp2rUH0yyeEv+8aZsopu5BrC4PiC1DnjPolS8VajOlRL1zS8qt8ca/je7LMmaxRij
 e2unwbXvZvNEajvj30jeYy6u8bgl/Ps=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

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

