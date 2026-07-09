Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE933D3CE4
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578948; cv=none; b=BHVDRdzVFhYVg2iR+gcBMSqiC03/JZE6m/B3bACmWlwLpIvUSCxBYSJgNYSzjYrfrzqM5qZ+D+vJx6790PbMiuqf/a70vy0+q4HiSuV2kIT1cHBSczWg+feM8tooilOTLzKOR5+ovzWCRDUvrB7cOvyyiTi1Q9cQy8Wq6gNgnx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578948; c=relaxed/simple;
	bh=QG/qBYGp1CFoAUEioBOEm/0Vr40BG+zvspOBhc0KLXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2XpkfLL5lgURlnDrT15tkthVYcjR/BMNwnomnobQOBTpVjd2GbwuFlMYiJnxEXo6u+PRw8ExdPsXF4PQ8Im2PwEXcCCwRryIuD6saGO5IzS6ZQpNtcVuxyPbvfUl07ycZIA4n3cNOhFuq/dZ+3KdC6aZSWnm64KJKhyjzeW1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T6ljj75+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EcpL61lW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T6ljj75+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EcpL61lW"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669602BQ794116
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 06:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z0EqAPxjwdtcQIJ6xwVHlsStlD7K7EQBa7wviyRj3cA=; b=T6ljj75+RZN42Dol
	W6WaouM4UXt/sxxgAwcbLRB2jhkpunGtATTnog74/YcynuGCmDpEQo40NLhg5BB/
	kO7LNIJfvahRMtSz2vC8+4kTy/NV0Z+0iOZPnQBbDYebtoJxx6IYo4RGCzZZaXpc
	pB+PczWr4UPWrIrMitIgHF3yFD/2JCYcp7OfOaP+yO0blVduJ9+olZqP0+keVrIz
	GJgzsH4zdm4Osjs/ywwBJEGSVLNkaGmg1Z28elb4r/u+LosstnXAlvTVGgSpxnST
	z7hBeGeRMk1bLIzlUnMblPuyUB1NpXgI37nL1rxl4Fqxguv+clKh05IcecbZYMf9
	4Qy3Ow==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1yds1by-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 06:35:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88d7a75507so981229a12.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578944; x=1784183744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0EqAPxjwdtcQIJ6xwVHlsStlD7K7EQBa7wviyRj3cA=;
        b=EcpL61lW0Wp2K3s6pqkX9QPoJ3BzYt+AAy+JCBMCB7pKGW1m2zPv+FUIl/1RDVTEAI
         s9/k6u56jsHYD4osqdtzaEQR4xGQmUdEawJi4ztSpzmBCSbisqaD7MZuPJN5pgFeb+YN
         A0MMxAXJVWgqjebh4vwTwRoMLT58RQStpK78rEmDwe2PLMi9srbjQxew2SYXscIs/tpO
         W3nmuSz/INpk++gdl4N9k7fyHNqvSnPvZrDTR3DZyEoKf9rFSJdIb762HOS5G3CvMJ6V
         BTfq8NBQaLgmgqhZsg+8LppeYMCgAukSJkdqLQioJOjYBvrZK4+kh+3G/dtuDK+sJ8le
         NAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578944; x=1784183744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0EqAPxjwdtcQIJ6xwVHlsStlD7K7EQBa7wviyRj3cA=;
        b=J3dAA6Be/u+FECJiEXP15wRn/Nd5bhoOgDCS48DSQc9lPRaKqhWeo6NOCBxGt/lLeL
         ln/JJagG2OzmjjnFQPuNmFAUie/DIIKb9/1p7SwA49sJlzSWc7A+AczeQTWNDjwP2+R4
         H3E0n2y+QTYWzwuqVd6SWKm5sFBrA8YTsD4LST7qcy8tqTCtHO2AvXFRvfqJ+mm0rxjT
         hTQ5ytTYMBJbFYKtCUEL1UjMfoJeCXvYfeGNi2T06yFW2rCk/nHVgtd114yoRjK+affx
         HWXF9Cmb5TOSWZam2DFP6MiYdz33ovxoOgCF/rXqJA+GnehXTHaHyV0k84qNLtctFLCL
         b/8w==
X-Forwarded-Encrypted: i=1; AHgh+Rr3wOuRJ4BhABXzQhmUHtZea51dzRHZRAVTv1HDgWfbOb+/fW/bxac8LaQWZLvAF+7YeCbLSleZLDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcO613Ef5ZBKFtxa9ESWMpffwCXTPC6fR8kohgHThohQE0rxmS
	YeoebKE9BDGNf1parbuYT1rdD9Xmrwm4/fLSlPaE+WU3LimH/P58QMvrVDMMVa+f2QzbG3WDfOX
	hCpvJ6QUlG57/XWRsxGpqOXISyAZNnApOLnhKZkNxf/m6ex0r1Mz6YGoXNgPOASE=
X-Gm-Gg: AfdE7cmiUPl0r3vkRqH8kR1nhC5i4bUMtuMozEmstG8CwlN0HXg0bEzZnapVqEbQD1K
	1PfkYdHBXjPmqXrOr/BCI1vzk+0107WfHfGKx1wVemOdbjSXofjmlETRRr1DMO2/3QE801lwA4q
	MzBLv3jRCGUeblr+T24NJMvqf7rBmbxDsmSlRhWYD6qRMcCUOLMY1hsQ4WY7rGr31txGYa3Mw0g
	6WmwWON1JYBcJwmPROKFO4ZD4qlKUlBO43UOhCXDmdHTSxzIalxzB4o3d9WQ2Y7LsDZe5E+80xP
	i6XFEwPcZLZi0dcoyw5TNP/HOG5q25BwadEPzFGeITxI1KgGlT2WLBgTLva8SUnMk1K6JllxRIW
	yir59vYopBYmuPx9BetGgoCiIh9ykZJIutzKgXQRUXopxrA==
X-Received: by 2002:a05:6a20:c998:b0:3bf:bdb9:f602 with SMTP id adf61e73a8af0-3c0bcc6a270mr6656538637.22.1783578944028;
        Wed, 08 Jul 2026 23:35:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:c998:b0:3bf:bdb9:f602 with SMTP id adf61e73a8af0-3c0bcc6a270mr6656493637.22.1783578943419;
        Wed, 08 Jul 2026 23:35:43 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm28304294eec.16.2026.07.08.23.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:35:42 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 12:05:17 +0530
Subject: [PATCH v3 2/4] PCI: qcom: Keep PERST# GPIO state as-is during
 probe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-link_retain-v3-2-81a9d187bb61@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578926; l=1729;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=QG/qBYGp1CFoAUEioBOEm/0Vr40BG+zvspOBhc0KLXE=;
 b=ihJm48Lda5dcP9vNT/LESX/IJC7zDKsME7N6tASM4TbxgsiS59KnttAt8fxhcwoUzfu2ZuZ15
 wGw9wT+ApGhC8+FIcaD3nm6FkRbwQfRlCz+35C53uYonymK6P6GdDHl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfX5HjjS7+L8wFO
 Pvmt0LHRJ8FX7lZbfzmm03TzmTjiIWfRCTH79f80ooPdpqL/pgdQpblh25uuvuiLNVpWOAdzjLu
 wz1U57hzWvQEgP7+13SG8+Ft0N9r8P0=
X-Proofpoint-ORIG-GUID: lgkrjdXm6fKobCMH643v0E3CaPEQnHsM
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4f4140 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=awRzx6-DDdmypIrTvt0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: lgkrjdXm6fKobCMH643v0E3CaPEQnHsM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfX2D0Mfv9+jBnl
 pGjPebcD+oqbDS3rRAJtgdZ0QIgIrSBzN+sHYhvZXmdA5IGWewgIeIz7OV7NqUoS/tfCBZrouhu
 PMmrXmgVASTO5dKFFxkbq9b+/zALdyJwOlpS2KJm0cWaz9tO0HziK5Q5m3pu1lcIl3lDlaQNwVr
 D9O80vjL8ZbFoegME2Woi4GSdAZLDho7IK89Nwh1rb3O7H+bxNj0yH6cUbQvxYO89aBDRozuGG9
 tQCH/9n2HOiKIoug3ig66RcYAYNBveZo8G7n9UEfBl8KPR8LTWCNBsSpjeUYWWnvDviW6h6kA45
 sOsSChFwBM9+SxRvPwfSiI8DsZ+zTgb4lG786mstE0GT2alDzsXSE+vr5ZXmOTzDEKgVGmUDR4m
 OFkCDSgAUYh28mWXgzqZYKSV5ybVAnLpkBveE/N6RrzTBX0NspRHvnBV320A9HwMYgB9JdupE8X
 anayQrR9rOijAqQkezg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090060

The PERST# signal is used to reset PCIe devices. Requesting the GPIO with
GPIOD_OUT_HIGH forces the line high during probe, which can unintentionally
assert reset on devices already out of reset and break proper link
sequencing.

Change the request to use GPIOD_ASIS so the driver preserves the existing
GPIO state configured by the bootloader or firmware. This allows platforms
that manage PERST# externally to maintain correct reset sequencing. PERST#
is asserted explicitly later during qcom_pcie_host_init(), so forcing it
high at probe time is unnecessary.

Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8eb52857f69..9ca620d4746a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1841,7 +1841,7 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
 		goto parse_child_node;
 
 	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
-				      GPIOD_OUT_HIGH, "PERST#");
+				      GPIOD_ASIS, "PERST#");
 	if (IS_ERR(reset)) {
 		/*
 		 * FIXME: GPIOLIB currently supports exclusive GPIO access only.
@@ -1918,7 +1918,7 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 
 	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
 		pcie->reset = devm_gpiod_get_optional(dev, "perst",
-						      GPIOD_OUT_HIGH);
+						      GPIOD_ASIS);
 		if (IS_ERR(pcie->reset))
 			return PTR_ERR(pcie->reset);
 	}

-- 
2.34.1

