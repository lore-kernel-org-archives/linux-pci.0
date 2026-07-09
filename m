Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D63B3D47C2
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578960; cv=none; b=mVZlJRyWgnFVavARuerV4OoySK73ruGZlVMpeIV2l1SI8S+rgjysCC9Wixm7Il8GjXG+toyRcKkO1D3ZWRhKsLwKjBGVjb+AlW4G8y8Evcnc9BEhGSmn/eI4dVp8xn8dUPc0HotYdVaUCeThHASF4XFJ2MpCUjFGIY7U57YIf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578960; c=relaxed/simple;
	bh=g16SUM+svdptq1GY9X2fXmFPiOxntS0lmdbaXrp6d4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SjNvRJHwFo3jj4SbZaDhf24Ek81C2LfSkmDDtJmraL3l4/UOT+MUAoEfnos+KeOjybcnyEF4mzpLInJhO3dgBN1NfM35bfR03Sjz1lMMwkmb7Mgtp+k1nhv7vIKyR1GXskEdPGI7cdNiGGdpv1Q/RIoOU1m6e3ZNJihC+RVV68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jZp0taTI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uk7jXdBx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jZp0taTI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uk7jXdBx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960NFl916726
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 06:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y9gvp4Nx/FKZgEV7jDtb3Va3H+SAOqpQLjFsjmjYSTM=; b=jZp0taTI8QQS4/zI
	IrO8Yrfo0zF0G+0NSvnm55SB/Oez19/oIudWM29kzdhKmoNebtiKKpN6340jBxUt
	r0LT/4h+ozJB+TMB0Sbs2umX1rdvRxVJWbj98ixUeLqYBlR4VeZHlllQ9606ccyT
	GgW2PVrKhmmHyd7eWYk4Qrz330GESGbyj3BloNTzSdIoZ9YiLGibhCGzUKG7E9p3
	S2aR3AXG9a5ToRd4I0X6YgllMZqUdUdQej41GMyeekr1LU2bG8t/qOMaTrQlRott
	L30zWnCqkmskXwBwGtPPITcHZsOgXciphJSIJSubBsX5lebWTw4sDC5rGlLhwMl7
	vipXKQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv58xm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 06:35:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37e24235ce1so2821640a91.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 23:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578955; x=1784183755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y9gvp4Nx/FKZgEV7jDtb3Va3H+SAOqpQLjFsjmjYSTM=;
        b=Uk7jXdBxVANqJ+ZMbMvD6bzGlJrZYjzhs5WbsZ4A2D2tNKSqV9tsV+ix7Yt5waYYjM
         4au1uCPrUlyaG2GWfqWSd1wAdL088lgpmqwILW7nTrr5LrbxXxEE7YkS36mepsbW58Cc
         pVJTe347FMKPOaeFtRqEraaNqrotmvIKH4gstVhoP6Z89L0ZpqLt0dAhTeUF4Lxw11GN
         W3vcTSNa/DSfJlcWeIlROSuMoWKJX+01pux4cNmoyAXhZcmv4/HUQDH+pMuqAwb32+VA
         NZSTmFRYl8+79j9p6HLbhuB1qnpFAtRIiAKqenhei9Frimz+3f/lzHH/MK7F0ILV6IQ/
         q/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578955; x=1784183755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y9gvp4Nx/FKZgEV7jDtb3Va3H+SAOqpQLjFsjmjYSTM=;
        b=kasZeefVafojdPoUO2t1g53iX8tgcccWzZYgXcHquXxBLiT6ahC7mX4z+kZAWMKo+h
         /EZczbZnfMzPwL54gGgeiKBYm36Zp4fPCzyaDRX7+lrK2xNrHCCiE0JdiTijaarMP2Zu
         n0ydeNnpW1dY2TRHlNE+jiF70Jd6mZgLlrJqsETN5PpUYHFlGUXmIxfF3iGl7K0diwnz
         nBX4co2JJHFeuLUHVrK72veYOi9z6ffcgCbsm7ci+Rw6oqL2+oMHdWeUSJv1lzeMwuTx
         8ckSyRtevU2TmBTYvKOpOaIcTD48PnFZb91ou/LMs3DaEwPnNfPvzNq1j8aIzTIGqUm+
         ItRQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJuzYZaXlEr3w/lAvwIjuk++2YDdWIZobHtMgj6O1w/VVOnr6IesK9hPuOFkHx/3jDwiTQKMWs1nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzskgLsuVhQGR25WkQBmJ6qUO0xxs9gVJ/1f4VpFceL56xKiLoW
	Xy3i7i/GJo+NY2CbxQf0OVPBcGzNtaT8CC279czuhXsEmrwDXb5vUMm4y2fGt1KfiaHYJ2q3W6r
	V3xCOZYZ23O6Qi1SwYrlj5TqEsKnNa9Iv68KbvX/rqMt7KyI1OpVoxtOitqIuavs=
X-Gm-Gg: AfdE7ck3lk03vS8wq+sklsxvujKMAkx2ZzB6cxS8FBzrb14PJnpS0UJbxWyCnE/CT3O
	wInBEE/PaSYN30JA8IOhE9nsUxRnKjrOhe3JLLTH3YvRRXVgQTJyzFEQB2hD8FoTM+6L9hs1Dss
	K98RxdHgsm7Ku8oBVv8pzxbEu3nEanhXy9g02q/R8hPRezgvM1/ZyeC3Lrja4b1zmzA1NOvbSFp
	spEJyj10FqaRI8uCWR911ugvMKeGHxavgC6FQL08VVQ4nBoQ9KRpKUe4/j+Q5Ds1PP42dUgm5nb
	oZRfZf3VBvA2ex5W8tqr2QNPRB90HrP/Nnp24BVcTETetmAM1VBWvQB8qXpgT6SZ6ucsKiM1bOy
	LrF4+o6LckWsuoKE1cyGgV5HP062AbFiEqmTTgbjsukQMzA==
X-Received: by 2002:a05:6a21:b8f:b0:3b4:605c:2163 with SMTP id adf61e73a8af0-3c0bc903035mr7881476637.4.1783578954625;
        Wed, 08 Jul 2026 23:35:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:b8f:b0:3b4:605c:2163 with SMTP id adf61e73a8af0-3c0bc903035mr7881439637.4.1783578954204;
        Wed, 08 Jul 2026 23:35:54 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm28304294eec.16.2026.07.08.23.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:35:53 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 12:05:19 +0530
Subject: [PATCH v3 4/4] PCI: qcom: enable Link retain logic for Hamoa
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-link_retain-v3-4-81a9d187bb61@oss.qualcomm.com>
References: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
In-Reply-To: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578926; l=1463;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=g16SUM+svdptq1GY9X2fXmFPiOxntS0lmdbaXrp6d4Y=;
 b=MkCA8hAkNOGu/Aa2n+KaKo56xPrkug1TB9cr3mL/zfVW64EqSAegfw0mEINPQ8vd4Jb40yDjY
 GJTh77dRo5UCRC8mEhI/1zCePfyL9AVmIMTc87Cz9EePPhUYouTlyZp
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4f414b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfX/CsDXxAD4p4S
 3qLB0HGsFz7P1kAuQSBb8pw4GKB3yOid2elj8VvGoatNx4Ugqg9kaPyjaV43MzQWKkOH4nddyLU
 9teTGVEkMxeC6KT5Ph0IP+od6pWiUWs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfX6qaS88LBO4Um
 EECo6JTkbjjImdxMDiE9wi2AgNWjze4GZ9ykchTUthrKoePSns/J0f6B+PKclz+lF7r/sm6UxUM
 JefAmU4AQzhH5eFhqPMmFrzx/JB6C0cCVjnj3tpn0LKd+octRxv/8FHcvyLKJW65qJ0QCXwfXof
 hwg+YUraen7xR6UqjSw6ZawjwSNk9y/L+B+J/24qlcE8lexT+vEwgW0R8Z0pUPl9OlCriUH5r8I
 S3185Xy8DQixMJd7+6mscODi+1Q2Y49zOfVi3HTh0Y51LQ5krYJYEIWHWU465WWF5jkQJRuE7ck
 yjFuwc2IU/aa7OrxE3rGqrdffzfferGdvQrocPp7/mh0WUfeHDgTfe/7V+4EUunNI9l4Ud5sjDp
 7pLlALkE5DlYRvlglqD2v0i1ZfWF6DKoynALrPAeho1OYS6FGP7MkB0IAkDsui2ZzqyB5Xp9aRq
 z+0191vL0i9MhzZt9Yg==
X-Proofpoint-ORIG-GUID: QLghgZdJitKm8PSVF9uJ_4gTNlhaH0sC
X-Proofpoint-GUID: QLghgZdJitKm8PSVF9uJ_4gTNlhaH0sC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090060

The Hamoa platform supports keeping the PCIe link active across
bootloader and kernel handoff. To take advantage of this, introduce a
specific configuration (cfg_x1e80100) with link_retain = true and
update the device match table to use it.

Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 77d2d989e9da..0b345a16f4cf 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1671,6 +1671,12 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
 	.no_l0s = true,
 };
 
+static const struct qcom_pcie_cfg cfg_x1e80100 = {
+	.ops = &ops_1_21_0,
+	.no_l0s = true,
+	.link_retain = true,
+};
+
 static const struct qcom_pcie_cfg cfg_fw_managed = {
 	.firmware_managed = true,
 };
@@ -2370,7 +2376,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
-	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
+	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_x1e80100 },
 	{ }
 };
 

-- 
2.34.1

