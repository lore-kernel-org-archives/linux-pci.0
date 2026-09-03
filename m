Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F035F61E
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422020; cv=none; b=hBHqaef4G3dFWuX+6BTP8z+k/FYpjF8FdFP4EeNz6j7qhEFKXN8paxrTBHXcNwzYIjSI11m3h9SAINX31y0z9mX2V0B7sSU9CKKEHayZqraCNY2CYzo7T5gOKdzpQDp3lpvILM07/Thg/yrl/uEouDy0fB5vNzGoQf9Fsyb6ClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422020; c=relaxed/simple;
	bh=AdPchfXsCQJMDBk4lR6KMgXheIpXggHP0WxqUt0lzGE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FWo1NEluRIpaAkBHafIm81UepuVhIpzLPd3KnqiKaZta6OFwBUAxNY65Qp97BSx2/15On9AI8kUxKTc6+2V07hs3pTrd4OETOqFM9dsCAH2Paz4tkM4fOdDVQrkjpW7XSgfdPPiAA4DKrO/bKJzwc/BKzdamUwgcUnT0WpQE9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jRvkp291; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MS/YDNuf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jRvkp291";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MS/YDNuf"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835lrbY3642515
	for <linux-pci@vger.kernel.org>; Thu, 3 Sep 2026 07:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LhA0v7+rttf/9iRNLvM4UJ
	HnE3oXqpEsh3RJGJCDhJk=; b=jRvkp291gXB0U8Z1GFg2yYuYYMkbo/dWuNrXBL
	g/zyp2XD2qrXxfX52hKYnMB56ZDO9Am1eHhi0/GKEnFFBVqg+Sh4NlrjVeFmKYpz
	dsOOzk3QpLlV0S0XY+ycDeRs7/dftfavJP/vSFoqfr8DayO7NeOQRc+BqCpSoEAh
	WGHX/jGru9/3kUrhShRxSsyeX5lRv3sizriG4RYCRw8n2+sR814KAMf9ZGUJ3A7N
	so33ZyHq5o9zLOrbQchbrMEpU1spTVBQ9qB+8UpiqT1M5GdBQZm/diSg8wWDh37g
	4OQgqOjDEqLvOzAhDhGAvnToM40Fb8w5dzvWW1VegsVhfVjA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdut08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 07:53:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93909014c85so380761185a.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 00:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788422017; x=1789026817; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LhA0v7+rttf/9iRNLvM4UJHnE3oXqpEsh3RJGJCDhJk=;
        b=MS/YDNufm73uT7jncGCw1/TNkT4SAYaUFTuxw0zcIYJ7YEuUMgEk7PXhyndzJyw6+r
         YMDCTdUAyvYbem9BeAl6eGG4GRqv2GWjDBj8ltXnPTnsmORec3htiYesIxMMtmxYCKSt
         qysY/v0XQQkNaXXQZDU95X2Y5JuEpecgfhXkVgjBQThZ4LD+XLTXo3uIL8G+ghf4b9Li
         N0lNu4ovcUmVqxctJ7+WPRuvmKhvKKoz2cajYWm9NwwFNLUxrr8TSPEf9nA44VmiD+6L
         aQkOFBTxzZMez/CtVMB3wvcWx0VhEA58QaYLxiqrhT9uJTc3FHDYt8QDmEjUT+DxbQj5
         HiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422017; x=1789026817;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LhA0v7+rttf/9iRNLvM4UJHnE3oXqpEsh3RJGJCDhJk=;
        b=AlTa71as07QFbijyVUCWl/1J1iFg61Jghjmjin/qpTXDQNFbhjLMo3SRn+xCKYbLUV
         yzCednIhsGFLGaRZ9olIULMpkL4RIgfJ+y6K0Vefdn9eaHSrZeNAiZgXnmlKuMAIW2c8
         N6Vu7rWNoA2+5fX2VWiKalSBCik5W+rU3ogIDqi/p7Jkgeeeu3//Qg9fCcphIJw+S9QR
         7CtGuEgmGqJLFHwZcANy+YsKfxjasU/mUTQZeXa3Z7F5j+mpFKLq5bAqyFiuhp4wlNTQ
         8QYDypz/jCvySp4KDcFYk/5RT2uTWD2DqfJs6s+IlcDJLd2P8Qd8YcOxF+C6cop5uaLJ
         Y+KA==
X-Forwarded-Encrypted: i=1; AKwUvBzGKdCZNlduxUXzbTX1CdvszWRD4e3UCkO7qoqBVt5idXczoeN8qyec9H91AbOkhfFf+RT8N2y4Dvg=@vger.kernel.org
X-Gm-Message-State: AFuF++mS1fGGKdGIfGj3OtSm7Fw8gxuHMQc0Omi9onrRt/HhkerkgxBG
	M6mYJdF9pLhG0fcyuYtywdlP0z4KNgnhuyDgYvBoeXGQ1oCvVo6y9i0XUWVbMNknxoY789rI4v2
	rTW5zDxsbYdd5A/pA+tAXuDkyknZ+q90i4j9WmZTnjszSr9vwdD2T7DE5+hlCw5U=
X-Gm-Gg: AYBFou1bDBXycMIRNH0d+Odngda5CwJkxpBm1LZLzph5Jcm8Ncdmx6/b5CF27YkpmnX
	SkGCICI1uOSRQec3XnsrxNs5mj0qWaGn/Ip6BOm1LJXX6KpngcGBcZWJHvjuJ53Yggz4z2YAiv9
	nX5DMU6iltXtHf15/TfPVPhW3IlkzS4U/Rrp0P6BOozluzNIxbQqlAY+u1KI1W7fLpHvNAFvL4/
	+u1lgMIE2g62qTyu2wZ6Wg4FPsJ9KMPzq7xUZ2qCIOUOCwaxEUV1eGXsVw11Ivif3I0JjaZeZwp
	PwW8BZRbvBOdJk34Dmm1rg3zwh3Iv8s3+UIAzRWOztgGkMwhoqalP3AnW5op5uCsQKHVzGcnv/g
	dr4H1IchQroOOhg==
X-Received: by 2002:a05:620a:8084:b0:939:191c:cac7 with SMTP id af79cd13be357-93972cbb0c3mr226674385a.13.1788422016780;
        Thu, 03 Sep 2026 00:53:36 -0700 (PDT)
X-Received: by 2002:a05:620a:8084:b0:939:191c:cac7 with SMTP id af79cd13be357-93972cbb0c3mr226672185a.13.1788422016377;
        Thu, 03 Sep 2026 00:53:36 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d1fe2sm57232225e9.3.2026.09.03.00.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:53:35 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH v2 0/5] PCI/pwrctrl: tc9563: introduce support for embedded
 GPIO controller
Date: Thu, 03 Sep 2026 09:52:56 +0200
Message-Id: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBREr0L+2k9Kq4Wy8h6GRW2L/EQotkAwh
 LtbcelmkjfJvNkgukAuQp1tENxCkfyQgJ8yMJ0eHg7JJgbOuGSlKHA0hJNRFylQzytKqbmyZ1G
 1kkEajcG1tB7CW5O4ozj58D78S/FtfyrF/lRLgQytVfcqHVWuZFcfY/6a9dP4vs9TQLPv+wdh/
 2PSswAAAA==
X-Change-ID: 20260731-pci-tc9563-aux-66a29d438f60
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a992781 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DaOxmBnbJEZ67lbDJzMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: PF8WAIod8T1x68ZjPMeYl2SGgTvCzrVN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfX8+RAVAVqP7fx
 sL0ypRQ6/hnK/Gr1nYkONsDNWwoxT/5eITTa49g6MDatl132BZqP1H6vTIedhg9TjnQAbmf+eWn
 MaysCE2gr8Hlx5mYErxqZB74OWm7s7mS6Bd5uU6OU34qiYAawWH5L6dZHyEDkcq2yBUsCAflDVP
 kLS93jtzaVIrqpR5BdLV6FNgUurfKyKxNCvwoSRm6ALRNVbZgsUyXCX+ggucvlwHVfPhOFO3kBZ
 uCxhbFeCnbOe7dGZl92zT5Q6SSIc6GrC0FD3KaZ/zPODSS0BV88eNkjFIqqV3qmkT5A0UqzoBQA
 kGlkcmhr9B7g/kKqEhxsjwm0AULdiqA9YW/fA0qtVqdCIK07SVLrjOO2qFVgzkfql/4/ZE2vPXU
 5hUj/q3chufDO4dWpa3N+J54wfcbslOR3OL18er4IPX7r0YBzOixlZsLJUXgRa6k4ua9MTipHox
 vVIT0UB5mUdopnpl0OQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfXzT97xP89Ty4F
 V+mmERomKyhJYVyvWdnjhSdvLv/heLMpEhmHv2JmtYa1CLUJD7VYq0vwqwc4j8HvT8ZUfl8SpKG
 GBAOpNhaszpAQD+CmDuf0si2TC1R6aQ=
X-Proofpoint-ORIG-GUID: PF8WAIod8T1x68ZjPMeYl2SGgTvCzrVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030069

This series is based on pwrctrl upstream branch.

---
Changes in v2:
- Fix PCI_PWRCTRL_TC9563 Kconfig dependency
- Move of_node refcounting management in tc9563_pwrctrl_adev_add().
- Link to v1: https://lore.kernel.org/r/20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com

---
Alex Elder (1):
      gpio: tc9563: add support for the embedded GPIO controller

Lorenzo Bianconi (4):
      dt-bindings: PCI: toshiba,tc9563: document embedded GPIO controller
      PCI/pwrctrl: tc9563: add GPIO auxiliary device support
      PCI/pwrctrl: tc9563: switch per-port reset to GPIO descriptor API
      arm64: dts: qcom: qcs6490-rb3gen2: enable TC9563 embedded GPIO controller

 .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  31 ++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   7 +
 drivers/gpio/Kconfig                               |  11 ++
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-tc9563.c                         |  99 +++++++++++++
 drivers/pci/pwrctrl/Kconfig                        |   1 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 165 +++++++++++++++++++--
 include/linux/soc/qcom/tc9563.h                    |  19 +++
 8 files changed, 319 insertions(+), 15 deletions(-)
---
base-commit: 550ecdbab0f51174202e7f9f6557673090bcd5eb
change-id: 20260731-pci-tc9563-aux-66a29d438f60

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

