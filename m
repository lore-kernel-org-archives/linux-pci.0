Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F83C1D5E
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161194; cv=none; b=J8LXTFhvokzzFQ2VRekixMKlqutiPWVuW1WKdWt3Ihcp20YaQ+EafOtPyp0Ih6jpyo4S5VwoyzBDq/YD1fgt7g041RnaClB26gqj8Asmw5WIIfkkE4IrtSI1m+Nt46S+eEDNChGHfq9RUj8oGYKNJ+OtiaKRF8mAnxxJR76YXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161194; c=relaxed/simple;
	bh=GecsPtDzBCsWNuDkEsU+ZgpETbYSghfoMtZfgts9qAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HojtgKK3bcw6aabKLJ7Uk1ZYnpYT/aw0W3bIbD8UaxJ0SqvfpIpDfOUrVTjs631KtXHsvCcl/ilxPPg4gWsCaYETtfYU7UZ5Fi8Tx/44YDORE1K1gzi1xDjzNuSga5R7NTfmUIRJL2a272hpPXaatQKBo5keHMXPa4bWeSpCOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cb+W6Ypv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EDXIIedV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cb+W6Ypv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EDXIIedV"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52aFN2764501
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 07:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GCgClY81I44AjvbZ/aXoo8VK5dN9dzyBFnWzQ9hfEIY=; b=cb+W6YpvtF5y3yAX
	6rv+oXd/Q+wYrFm2Yws/rl/HK2EjfIoPbxBJtMqDwQ+JCI732Mfj8v5dJIT6Uxcb
	9HQgyQrV7Kr1TEn514xea1pMVxR7b+LRX/Nv8oWaRKszT7aArUrkQx6p4ur/AmsO
	fS51NXhrRC8itp+FNwS75r939xLjcCMl+Lrao09ZCUmh6IJ6vEi6Yk+8YSEcXNEZ
	oiWRDeWJeH1COoI7yOKlO3PxoTz6o2s8NLZrw5YPIKDN1cG1g23tHhxBkEf4u9xZ
	w89shjs6k9ZouofbOPUZlGPCuaRGsA4kHuvY5oI2qj4Xq0n9uW7m0wWcq38W4wdW
	oezlqA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqgyn6xk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 07:26:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so5511374a91.1
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 00:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788161191; x=1788765991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GCgClY81I44AjvbZ/aXoo8VK5dN9dzyBFnWzQ9hfEIY=;
        b=EDXIIedVfKqKQixsOyKIAoF0BZ6YjtUg2z6HLJKTDwsaNSuPCQkmEyhI2rtm1LL1SH
         e6lM2JW3ydC3KblbnAF2sny5wXuVGh7aLOYYo1LHPjckjGxgmV0w+KR4o8oIVnXv/mq5
         PY9HVPi3VT0EMSLGsVzHJOninPOH20SG8HrfTUHId8no3Jo+2gW3YDTn7GqmZKOolCMd
         N9XHRE8vfXiNXP6k1Fw5P9dxCTHApijLai+Kl20geJl7QIyjMSoyzU1yp+6cmhqXjosS
         vqipFcfwXk3cZgK9JsHgb9uwlvoKdmUpymM+emxRYdUCDdMOJiTPXqpVizlp4KYAdRam
         d56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788161191; x=1788765991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCgClY81I44AjvbZ/aXoo8VK5dN9dzyBFnWzQ9hfEIY=;
        b=GWuCO+0qAykxu+afdIvFwwTKOK6UhhI8z34llr12V3HBbVLJIUhQ14vmDYWalvfZYb
         QHtX0EWtP1hFbb0cvBPJvckc8pgqEvb0+smnuMf6dZH/GgTngcRiLBT/5evsLPG71Yd1
         U7tfWL7/zNZnKIIVLz1a3glqxBZCA1M3XxTSNr6sNB9xICWgU8chUx1zuMVkk6OiqGuF
         yTzdQ1j+7xitEBEYTTSor1TCfeutqvBY/T42j5RGL0ha3yfx2YiScFplEG6tgn9b/f/B
         eOxc8nNmSVRM0h3UySoZq0cKeJX08A9HbP7vchl9oIePiP+n6AEtbiEd2XQLyo2hQztF
         2J3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxp1AwMGJaSVuH2OiIVO+aJ9uS4dR5PeFHpEhDuLr8ujU5QEZxQNx+Wr7JF2aUF+hAr2hXS8DheZME=@vger.kernel.org
X-Gm-Message-State: AFuF++nZbiJeufkGsZJ312tE7Ohhds3GXbLb/3HSEuNEzIexA8CU3rxt
	EXdJmGFm3hBSKD/Tw1mX0spA02Jf6X6KqG/lD2izyLwaydme35tCQVDFIQEeQDx+CBz7dcqiDu0
	MwStSG11FoHpztFoaebf3IMt34v1DcZIDJIi0UtdO5zO8A/W272raCLvZ8YssIF4=
X-Gm-Gg: AYBFou2xaRRNy2WtRPBLKSlRxvv1PpluujoN3wZZIKD55Z/lMxtnmkCccLQoRkAoHdu
	gJvjlGwQa0ZdEmHSzI1TFxp/eWF3Qy+8D5sLtc9cm+VaHrVq5AnHiKjbWE+SCKJNCmzM+HYN/bm
	d/er90uBUuKcTTjaVvO22Ngyv9qkQKQ1vqDCLE8j0owmDzEjPQcRf3VldPZ647lkzYYQSUjo6p+
	mSEOO2L16TwrhnoVSszPZsvVPxaLmbaw2xq6tynHgtFUp9WB21vbxUSdeX/YMgDAxt+s0s2y69R
	+RXqrkyeTt+BlzuR/gnVjMSJROySJjVPx5bBBjcVHWnCSvYBzK+150WZRuCowR5UUygNSeR7AkN
	a8vddwwi9OLcT81QEokYm/5yjwcF87FboEo9e
X-Received: by 2002:a17:90b:1a90:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-396d0f8e80cmr34398747a91.10.1788161190471;
        Mon, 31 Aug 2026 00:26:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1a90:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-396d0f8e80cmr34398691a91.10.1788161189996;
        Mon, 31 Aug 2026 00:26:29 -0700 (PDT)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9595bbsm31327059eec.14.2026.08.31.00.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 00:26:29 -0700 (PDT)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 12:56:03 +0530
Subject: [PATCH v2 3/5] PCI: qcom: Add support for Shikra
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-shikra-upstream-v2-3-406661d75afa@oss.qualcomm.com>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
In-Reply-To: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788161164; l=854;
 i=sushrut.trivedi@oss.qualcomm.com; s=20251127; h=from:subject:message-id;
 bh=GecsPtDzBCsWNuDkEsU+ZgpETbYSghfoMtZfgts9qAA=;
 b=55ch1aG1G4LspPpgrm0K7D/1FVbflwomwl/UnDiUlC25zvssra1xrNLuTowwVyhnQIx1T7i3y
 BD5Bn6bEEdKCCwrq2EXn6BNFfR1UIiPZkXZLQs7q6LSnHDVPq6rJGyE
X-Developer-Key: i=sushrut.trivedi@oss.qualcomm.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA2MyBTYWx0ZWRfX8AJPGUETSksx
 SwWwIiMqi4Kmx79Jke7DjoBnFtMmie5bscCw8JLV5bq5A2xR7itnfzeBaocA71dhRXlhWfRJMKs
 sfCRG4e6kgiGXntcmaOfa3AXEGn4JLQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA2MyBTYWx0ZWRfX+MhyECgQUgNY
 sT1i1uudL03G7tqKCw5dmL0YZvWns1RJxAAsFbVBwsSvMqmqo0KWDbHJyY7qVZ5wEaSREDHqV6L
 CxT/L5lo6JxXDWSRiVjmPw1X6SJOF58qqo1brqhdvz+5b3tE/G/AyFI7NmwgRkaR1+Xf6WlSSgb
 upeH1JyGEGg3DgnbYgNmrcCf8K3evc0CneZKu5zBru/0wPAbaMZHyk8lXsMyC59m9q+ZGbvgtTb
 oOthmvTlQFdKTLTrIRS+bSq1lncmeSeCqOOizE408kxQW9CxZuz5HwPtsCvLKMLcnCqWvPQGwC4
 TyA6683ZfmUiFTbbi0cFEK+Nv+R4RpTq1EX+sFI43DZaXl+gG0ePb6LPjwPqC14+3qWcH/VdHjZ
 H31BivukFT9BlzXyvQuDfXlcKdaKRceKdqjcmp3Es1KOaPwHbCZoR1d0/RNzC/JIhuSD1DFEMIC
 2ZkyqeiFa89ZOkwWSrg==
X-Proofpoint-ORIG-GUID: zFakdYreCWR9wFQP6eqP-hUsM_PsjTkU
X-Authority-Analysis: v=2.4 cv=R5Ez39RX c=1 sm=1 tr=0 ts=6a952ca7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=sKgv3_SsqRtbfYgyWx4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: zFakdYreCWR9wFQP6eqP-hUsM_PsjTkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310063

Add support for the single PCIe controller on Shikra platform
which is capable of Gen2x1 operation.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8eb52857f69..19daadee65f7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2309,6 +2309,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
+	{ .compatible = "qcom,shikra-pcie", .data = &cfg_1_9_0 },
 	{ }
 };
 

-- 
2.43.0

