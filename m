Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590704;
	b=hVAv9oA1s6fbVrhfASB+xK6C79ofcIud6Aj2J1TYp/iQZAU/iTI8xkSKVcy64N6w6LOp
	 I6XEkmBWaSUDsJOTASs2NR9PpPboU1hysUX7unpX9fpDcVhGI9/DAYWN1qVfpsgoiVdFN
	 djChUfa4p7WJpMALflL5oozPRqA3NUrY7qzF1vuSDqsxUaFqs2iKatbG4ng39ahasolRt
	 XH4l0rNGqURG1XbK7ssR74cU0Vs7rWGSjW52Z966COJIXouh+rieAChQ/vwQFJoA9j7AD
	 HhwTyrNGlk0VouWW5ovf1Xhb2yUQPYuuYDkOPT/oEvybsJakf6X6rRGLI7Wn8Wap35g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590704;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=A6HdOEiXNNGwTsccgbIYty8lETuR44TLn/Iqy59Js+k=;
	b=Nf4cpAOTs5lvRiAyqJGZn+I1rKQjW+ZFcXguu5mhI6mdG7TP3BYGwDj9Xoq34GbXNicM
	 oHG2Nj88c1xFEIIsGuXg2UKXkL1jmbflvx5FetjwJv+GHE055ZpzyW90Uta73SIdylEiV
	 fijYOdTWwEGX3Z+m1olEkbEAToxXX6J3kYelDao7iWYc7cRlgqs56CiBm/KyJJYVUguGs
	 wIAY2DexiSBttO03jMYkGja6ejq1gBfw/MT+Pu5wlOMjwonie//gMsvLypqii/NgDpNfb
	 M1SNEF+nS5TdcPlV7el2ZqnfinYIFyhJ4uD1a4dCEzK6iHVhPRf2jxGzUOltPrnETrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZKg5+0ZU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="DSRVI/TZ";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5278606A32F
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5278606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZKg5+0ZU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DSRVI/TZ
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBg3781599904
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A6HdOEiXNNGwTsccgbIYty8lETuR44TLn/Iqy59Js+k=; b=ZKg5+0ZUKItN4MQl
	jd6DvWNlARLGu+LBUHR2LWHb/xsjzDQttPT/Mnc0mEN2bZb/WJRQDIN+01ub8Jp6
	qMSoFXpK8aR62TXUOxn5UCiljxyET0nonh7sQZvIyTONBxrZKMNlS8PxOiuHhs7c
	1481WuaMOzzOZzHPQfHvhRVUgRZ2BqNHP3FbNlOBjpVA+c6/r6imVR6AdCyCyMMq
	1ixZfQVXAtIjTUANaWen3RUHlRhIGqvDwCQqW7AvnMkQguaJJio4wXlzbwdiaFzP
	sVil3VduxM4yvqcI1CUDqiThFP8umBA54bdMSpQHEevCjl/jPwvi1Wv2jMEqGJMx
	S4l+Jg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhugspg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-366c279b454so1544447eec.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792590702; x=1793195502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A6HdOEiXNNGwTsccgbIYty8lETuR44TLn/Iqy59Js+k=;
        b=DSRVI/TZif+nx/zCTqReqPKw8dsqxpoEgYD0SLHqWEKKDZW3CAJ8ptNo9NDkCCd/CA
         k47720PFVjMuXk5ZzXmyzqZzqjqbtskYJtlADKC0XkbXh1GrnTNxqzPalfGCrj/xOk1S
         1ByyqlL97KwGxfENgWsvXNqWVYQEzmTxmXzKjy7xnnlQnEDXtJZrChYVBelHxjpym02X
         Y41QaFwtl9ISXCK7qw+g3mRXw6cL4buw6z8JnRqNhgSvsGgAZW/dp7UekiHInggU7hmt
         bW/m1Ovcfk+gISUDHJp3ZUYuhPbG466LthxnhJ+4JBYgmswiC/8bMe/+scrxzue0oa9t
         RB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590702; x=1793195502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A6HdOEiXNNGwTsccgbIYty8lETuR44TLn/Iqy59Js+k=;
        b=IXXm+JrsVmUIaWiRDZCnpubUjQXNPgqLatFfWR/fxBiOLgXH8ln4s41VA3YX13pGW/
         PLQ0YLiZrzx5v3rec+GtlJjTMEqS3NaOfIJwmRkvkhjg3WrriGsPm6RLN4oo1630Zfvx
         Vc3yG4c91JRYEPHmLkdeKPU8CYMdilRbMd+zgdoc93zcGY43/7DqW1Zg5OjY9zxXSpoS
         xi3/3d/5ZTf6j3VEnC6y/MU47yjrstOLV3+soXXiLnaaffbbkD9ZvDGJjnUcz8POuMXE
         VoyqVUDEnfC7SAka2uZjbjMpu9HaWYA0XWUJrXGM/WwQqf4Y8qoM0t/KRaNz344bb+K6
         ZsSA==
X-Gm-Message-State: AFq9FYL2iVMWDksmKg9dNcmh636bEc92U0u50YrLfvZeJV7hpKneCwQK
	9VRpkPou3oz6qeU6jtx8dd9Dw6iNsh6EjN4iO9oK10OJ8NONJ8KNFVTMQObFBFD00z+F7fOjcwJ
	E3JCbUcyxfuMw7bwFZc3+sDnCQ3eTc2lgAXzVuBpS7cNTWRYJXnrJlxDWeZVgT3qo3TWCKsE=
X-Gm-Gg: AYBFou1mC2fKIxEwGgmPUxeS3E1fJDtE6MOJsIDGyS4Y+CRMuS8kygFQfXrN58IlEFt
	fuMwgUctIZ/ENH4FBob/0iJhYmDcd8LHg8cu7q1J3ZhYQg3dc7LA1bMhkKVHNovctJepDhPopn4
	DBc3cv3j5XZByObuxUNkAc2rCB1MQJyWOU643v7/2gjQWns58nWp7qmkwyJI5CxByxk7IvO8tHk
	JMFEMrhXGMOOFON5ervxg4xc9CEewzeCrBDiMWUMZGio5MElq/JF2P+xn0R9aB//U5Sn2Okmkr+
	CrNUZBHSiHCCk8A1JTLMrbBXS2QbBENnqhLczifSvQGJZj5lnfeNL5eCZ/VVHeztfBMPnbpHBUq
	PFR/yJSSSPoq1fIb4GNcunDqvJMMExYXlug==
X-Received: by 2002:a05:7301:619c:10b0:366:fbdb:2070 with SMTP id 5a478bee46e88-3674d7574femr3257887eec.34.1792590702234;
        Wed, 21 Oct 2026 06:51:42 -0700 (PDT)
X-Received: by 2002:a05:7301:619c:10b0:366:fbdb:2070 with SMTP id 5a478bee46e88-3674d7574femr3257839eec.34.1792590701513;
        Wed, 21 Oct 2026 06:51:41 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc848fsm7534332eec.13.2026.10.21.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:51:41 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 19:21:23 +0530
Subject: [PATCH 2/3] power: sequencing: pcie-m2: Add support for PCIe M.2
 Key B connectors
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
Message-Id: <20261021-pcie6_fix-v1-2-ad37134c35a3@oss.qualcomm.com>
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
In-Reply-To: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792590686; l=5232;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=pVhUYhxs6KQ1T/CI44JRxbLe3qLaaRGFuWNum37M39I=;
 b=VQW3OX2obJt4ghRsMP4Ee8708R8JZJPwdoz4zISmNpz7bXgo6m6qDUApCttZOVfAWygfrUufB
 WCZBwE300rRCsIc/JIVm8Sju9Yug+3Xy/c/srO5U8FVdDtNpyow9gZm
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad8c36f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=LWHI3qZMtzRrPHsxVWoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX1PnjhV19aPWM
 fmUngWmgaxOjHFmMu+3a02NfaWKBCVfS3+hVpji3F/otDdgIf/we24cGvF34jUT95lfGvB3BDYt
 NaR/UkIPNxl2Y2CU7f9LLXSWnf2yRBs=
X-Proofpoint-GUID: UOlmlOFv2o2DDOlIHQZsOGovJG-23yEB
X-Proofpoint-ORIG-GUID: UOlmlOFv2o2DDOlIHQZsOGovJG-23yEB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX8MdQ07mtXdE9
 p06OZJ0dkXRF46gjpWpW5S7uhtkJo1SFrUlM2DvJYvJcoxWxLCh421OSfAv4QfE4kYtyUQlqMVH
 iWqNUYKuq8WIf+rVgXBWHoU6O5dZpC/Y9PsXVah4pWrGY1p8e/gDls5nRczGH0RtKMrej+IMl7b
 dcVmA8S+Uuy/6k0vqhtbY28HT+t9ZeLYWcqQ3DK/y7rjUMl1LWZPIUiHgiejrmY0WbG8d8TvXov
 cXEL8Dbg0wuM84Vmt1tY4P/M657YVgmALbq2I7zhRDikH8MB/FhDN1z2MkAdJVyhm3396JeXkVa
 QT+bUmURVFsvj4JVc1hb9i27VDQHdh95BsDmf/n/V80tqRRklp4DFLsPYVAU/o10LR3DjtbEn+F
 obhaEH7efsttUVap7W2U8giifizFqonoVvUq9dP0pISbV1kQ3MSLWyd32dkBhjgHWBMbDFJ6T0C
 +2TVCQGUdCNAWm6rUkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210055

Add support for handling the power sequence of the PCIe M.2 Key B
connectors. These connectors are used to attach WWAN Adapters to the
host machine over interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB
2.0.

Currently, this driver only supports driving the 3.3V/VBAT power
supply along with the FULL_CARD_POWER_OFF#, RESET#, and W_DISABLE1#/2#
GPIOs as a single "pcie" target, since Key B Adapters expose only a
discoverable PCIe/USB interface and no non-discoverable bus (unlike
Key E's UART-attached Bluetooth device), so no serdev creation is
needed. The optional WAKE_ON_WWAN# and DPR signals are not currently
supported.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 82 +++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index e42e85f47629..62185bf30d73 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -39,6 +39,8 @@ struct pwrseq_pcie_m2_ctx {
 	struct notifier_block nb;
 	struct gpio_desc *w_disable1_gpio;
 	struct gpio_desc *w_disable2_gpio;
+	struct gpio_desc *full_card_power_off_gpio;
+	struct gpio_desc *reset_gpio;
 	struct device *dev;
 	struct list_head pci_devices;
 	struct mutex list_lock;
@@ -111,6 +113,53 @@ static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
 	.disable = pwrseq_pci_m2_e_pcie_disable,
 };
 
+static int pwrseq_pci_m2_b_pcie_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = gpiod_set_value_cansleep(ctx->full_card_power_off_gpio, 0);
+	if (ret)
+		return ret;
+
+	ret = gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	if (ret)
+		return ret;
+
+	ret = gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);
+	if (ret)
+		return ret;
+
+	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);
+}
+
+static int pwrseq_pci_m2_b_pcie_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
+	if (ret)
+		return ret;
+
+	ret = gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
+	if (ret)
+		return ret;
+
+	ret = gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	if (ret)
+		return ret;
+
+	return gpiod_set_value_cansleep(ctx->full_card_power_off_gpio, 1);
+}
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_b_pcie_unit_data = {
+	.name = "pcie-enable",
+	.deps = pwrseq_pcie_m2_unit_deps,
+	.enable = pwrseq_pci_m2_b_pcie_enable,
+	.disable = pwrseq_pci_m2_b_pcie_disable,
+};
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
 	.name = "pcie-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
@@ -140,6 +189,11 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
 };
 
+static const struct pwrseq_target_data pwrseq_pcie_m2_b_pcie_target_data = {
+	.name = "pcie",
+	.unit = &pwrseq_pcie_m2_b_pcie_unit_data,
+};
+
 static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
 	.name = "pcie",
 	.unit = &pwrseq_pcie_m2_m_pcie_unit_data,
@@ -151,6 +205,11 @@ static const struct pwrseq_target_data *pwrseq_pcie_m2_e_targets[] = {
 	NULL
 };
 
+static const struct pwrseq_target_data *pwrseq_pcie_m2_b_targets[] = {
+	&pwrseq_pcie_m2_b_pcie_target_data,
+	NULL
+};
+
 static const struct pwrseq_target_data *pwrseq_pcie_m2_m_targets[] = {
 	&pwrseq_pcie_m2_m_pcie_target_data,
 	NULL
@@ -160,6 +219,10 @@ static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_e_of_data = {
 	.targets = pwrseq_pcie_m2_e_targets,
 };
 
+static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_b_of_data = {
+	.targets = pwrseq_pcie_m2_b_targets,
+};
+
 static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data = {
 	.targets = pwrseq_pcie_m2_m_targets,
 };
@@ -534,6 +597,21 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		goto err_free_regulators;
 	}
 
+	ctx->full_card_power_off_gpio = devm_gpiod_get_optional(dev, "full-card-power-off",
+								 GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->full_card_power_off_gpio)) {
+		ret = dev_err_probe(dev, PTR_ERR(ctx->full_card_power_off_gpio),
+				     "Failed to get the FULL_CARD_POWER_OFF# GPIO\n");
+		goto err_free_regulators;
+	}
+
+	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio)) {
+		ret = dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get the RESET# GPIO\n");
+		goto err_free_regulators;
+	}
+
 	config.parent = dev;
 	config.owner = THIS_MODULE;
 	config.drvdata = ctx;
@@ -598,6 +676,10 @@ static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
 		.compatible = "pcie-m2-e-connector",
 		.data = &pwrseq_pcie_m2_e_of_data,
 	},
+	{
+		.compatible = "pcie-m2-b-connector",
+		.data = &pwrseq_pcie_m2_b_of_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwrseq_pcie_m2_of_match);

-- 
2.34.1

