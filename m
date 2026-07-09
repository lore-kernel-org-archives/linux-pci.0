Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905E43DFC8F
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582188; cv=none; b=jg8L1vpj+xdvAA/dmQXnDcn5G8oY2gKjy5J/1vkrxZFz8WUYaFcz+kvIbNilxTB+5I+9xKePUmY3BNgC+5zA4hjE/KMX91+Rk/hp5ZIX8CIBv6rvIotlGzOlwH4iJDg+cjQdgNM8s/X58QNuS0kOLsUK3rhryC6VjRh8xburO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582188; c=relaxed/simple;
	bh=0s1aN4Mi0AzWm/Hayt7uymch60EarJ0VTt156et5w+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sH6PyqYlyZUYIhKyl1b13lXCkVFaAbbi0VKnnFxl/w7ZcU5evO8MXsnJMM17UxPD6SL4lIsydEuT3+gNEYZD6X/Qx63qaiPpKU5EvVRasrGmS0MUYhLIkeK8kG7on5iz8BLyvAczNEZHfZtomvUYGS2iRQ3u9XWtbJ6NUnj6yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U8FIlzz4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IBirFVS8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U8FIlzz4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IBirFVS8"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66961Crr933518
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 07:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=24AQujv9vKySCI+b9FnmRb
	ZgOeazlB7CEm9iOmkIzr8=; b=U8FIlzz4sgYpiaugQKX03IEBhuE4qll7VT927r
	rZAhKIOtfOrWUI4AUf1D1J3BjNBWnT52LHPauV0TwlH+n6IdMQNdKXYI64BDheJD
	pKSecc/fQnK1WKAZBLjpLDS6Kd24hZnM6xbAnYTt3fjXxFs14p0FA181+khZMWfU
	wFglt5uuLm0gW4fK4c8Q45yWbJRHgw3STCnW7fWahPKaN5dMlrOZiMmazTllc75P
	G8RCrTmQ5sUIrtkzGAqPCLjZ/KzkDmF9HeWxXNqu3yIgXb4G6Gohcy9e7qyyCh1w
	66GjMG3bxyX/rtWOevqVlfP20xAAiJbpv83V3NQIgC9vlPug==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6jf6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 07:29:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84832baac02so424165b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783582185; x=1784186985; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=24AQujv9vKySCI+b9FnmRbZgOeazlB7CEm9iOmkIzr8=;
        b=IBirFVS8kt/emi1fH62YQwVJRgtbgs0f8qC+JO4+Ytu7T0M8o8QMwsLmJLvEnYi9k1
         lRZTchggG9XPHW2jp15T3RgH9NFfP4RGDlmGoLoBTi7thgbVAdNUVY3Vvrb6LtNHHTZp
         eJomsXRbeXXci9t8uHWSWQNiNxi2qtUqG7azNyZGLsXu4U+wqL7CqhEII8tTtO3ARUnJ
         bqaMRB4uJG6kLNlX20Ee/GmjhCCThmb2sjBrWNe+szQv6LHE1FoXvS6DD0vadSS8kLFR
         2eXHPsHGg46NR1T7Bq0diYt3OVkYS+OgzugNr+l+p2iDlxPF08LtPxj6jQ8uYaT2bi6o
         OOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783582185; x=1784186985;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=24AQujv9vKySCI+b9FnmRbZgOeazlB7CEm9iOmkIzr8=;
        b=kc9cAfN0W4w57Ds0cbahrNX2K859Kv2K13kLGs8kCezQ34yQfllvWpEK//1sHX+B57
         aM/AQNUFH3vt06PibrX2mJj7PiOR9szxuETb28ea4i20Qg3jvdOMQsUJaNkNVCXOU/UL
         ioyou2INgztaISQXqJZYkWB5HDxAm2t8HZBiAVUdL2H+pB/jJG/sx76PvWI88aM+6uei
         4ZEcuM9bvac203Mq/73o9ChI9BeaxifaBxdI6qTQXO5b9vxJUfNTqhZKA0A86sIgxSDp
         jpmKFujrp/gZNv2OB0uEj0ZeLIwcjKZiUM+MmHaGwocqdqMSTCVZBjJnUQNnKjMNFMfA
         HE9A==
X-Forwarded-Encrypted: i=1; AHgh+Rqti+HdUAd9+dySXCXQu5YKpnhLRpoePi7668eO72aEU83IioWG/PS/sYg4CfuJCBa043IcgudPFwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzf0lxy0xMmLrqHZQu7tUibogfRAADLv7fbATm++WbNdthNDEA
	mH+ltRMQXyAPDbEql/H6pnXGRmCgGp2YGY4AHiL4vB4VPScwZPHIKm6HEsIWkU8g6ROA2V0GmmH
	9HeJT4tdm4VznVLVDe6qRVqrol6EVHu61pMZaQJIGVs9ubPQw3O+dSyp6pWHl0eI=
X-Gm-Gg: AfdE7ckQ4eU8RVu/0Qqoq1cfxEgdRY+LrJXXPJd6VtqHTx8YiI9IdKllkKgofB+hggo
	GF+2w3hO03Z7P4TKfXKi/A9MtjrGk2QkcyalhIIWKLnb+xOsWxdxJU+5JsVqrtb8kkDTVbEavou
	rvSYDMC3Hnp7j8RO3/l+o5mj5WYq5u1uCqszGk/KilbUDjo4TVoDWmigl4gbuHrcRTC+0MUDIQJ
	xSma1yGR2kRXYJlri/UDaMCDZ/9F+h1i729IH5Lf9VB1IgwfMEWuTt+eCa5vND9JLvhaU2xOQI+
	YewgpItNOfLo0okarlc08tO9qdDPDNHEvkG9Xw0T7QTdiNTVE9MOs6UMxZaYi4EVZdCxb86QvgK
	bNNXtOfZFnYXlrWKjNjfqjFRzEdKdFjy0JP7HUQu61QvrnqFKlEW98vWNIaKshA==
X-Received: by 2002:a05:6a00:a0c:b0:845:ec35:6d7f with SMTP id d2e1a72fcca58-84855fd49b0mr1758071b3a.4.1783582185325;
        Thu, 09 Jul 2026 00:29:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0c:b0:845:ec35:6d7f with SMTP id d2e1a72fcca58-84855fd49b0mr1758050b3a.4.1783582184905;
        Thu, 09 Jul 2026 00:29:44 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d44d53sm8167222b3a.38.2026.07.09.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:29:44 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
Subject: [PATCH 0/3] power: sequencing: pcie-m2: Enable USB/UART BT
 coexistence on Hamoa EVK
Date: Thu, 09 Jul 2026 12:59:39 +0530
Message-Id: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAONNT2oC/x2M2wpAUBAAf0X7bGtt2PgVeThYbLl1TqHk3508T
 s3MA0G9aYA6ecDracH2LUKWJtDPbpsUbYgMTFySUIWj3Ti7dXe4Ml44WHDdoow0qkhBwr3kEOv
 Da1T/c9O+7wdPMdSdaQAAAA==
X-Change-ID: 20260709-fix-hamoa-m2-w-disable2-0fe775072c74
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>,
        mengshi.wu@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2OSBTYWx0ZWRfXyUk9PbRBIUB+
 jGJ6pC256dKi68x7vJBKfzq9mICZ/1xcG0m3AJ9806b7AcooLeoCgTbrTQl6eKklXRy9AGObOGN
 szR1VpnPBxEwOItEale1oiL2pBaS5is=
X-Proofpoint-GUID: GFIYwsa198iEDzQWmW9ZTEN7NvBo2bRa
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f4dea cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=H5-0xJHwKRPjY1VIS5sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: GFIYwsa198iEDzQWmW9ZTEN7NvBo2bRa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2OSBTYWx0ZWRfXwxGaOuL384hm
 hCJXDtBxvhzeSDosY+Vf8CeoyAqdBn+LpRWyiQcLgfHy7kOD8GmkTDHdpnfJ2vHBbJLR1IeR4DA
 bAi2IqhCSdji7a7SFVcgnlgZHTShXomUw3zhP3/G9hh8KlxAIxd2mq24fWdxUPjncSWg4n4Q6gQ
 qJL0QHihes6zV7fL5WXQe1n9pL3dJa0sBYsMri8feVN8AB+z6v47Nrhtg4odohxKzDNz8dtTSWE
 jVJC7tLMQdS8SDbqQfMjTYLINLyPWYQuiLpxls35VSuwpieZNH+fE2fgMwtpVDKjPvOwHCQH6Vn
 1XrJ23RM3tw5ppSm0p5nEtoqY907fnXNWIyiPNuSUyY8l1fjnxo9uu/exJC+JhcJqmSdDsncyxk
 snyeC13nBWT7o5SgKPTbZEYKWlTMmSk3mtcH+8F4Rj4Y0ahVG1Udb2JzQbFNHi6nbb2oVyjODL4
 cTANPHWeNMKbsVwn5HQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090069

M.2 combo chips expose Wi-Fi over PCIe and Bluetooth over either UART
or USB, depending on the card variant. Both variants share the same PCIe
device ID but use different sub-system IDs. The current driver uses bare
PCI_DEVICE() matches that cover all sub-system IDs, so both variants
trigger UART serdev creation — wrong for USB-only BT cards.

This series fixes USB/UART BT coexistence by:

1. Narrowing WCN6855 and WCN7851 table entries to UART-only sub-system
   IDs so USB variants no longer trigger UART serdev creation.

2. Deasserting W_DISABLE2# for any PCIe device detected under the
   connector that does not match a UART BT entry, allowing the BT
   subsystem to power up and the USB BT interface to enumerate.

3. Describing the PCIe M.2 Key E connector on the Hamoa IoT EVK,
   adding w-disable2-gpios for software control of W_DISABLE2#.

Validated on Hamoa IoT EVK (IQ-X7181-EVK) with multiple M.2 cards:
UART BT (WCN6855, WCN7851, QCC2072) and USB BT (WCN6855, WCN7851)
all work correctly.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
Wei Deng (3):
      arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key E connector
      power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID
      power: sequencing: pcie-m2: Deassert W_DISABLE2# when no UART serdev is created

 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 129 ++++++++++-------------------
 arch/arm64/boot/dts/qcom/hamoa.dtsi        |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c  |  39 ++++++---
 3 files changed, 74 insertions(+), 95 deletions(-)
---
base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
change-id: 20260709-fix-hamoa-m2-w-disable2-0fe775072c74

Best regards,
-- 
Wei Deng <wei.deng@oss.qualcomm.com>

