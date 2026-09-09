Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2656C63E
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965818; cv=none; b=rt6PA9Eprbe2lh3QgcgG8Lkase/xrOEnLQHBM2TV0tiEStPzO9ig3Oa7SjN/CG0eW9nlfG3o+62wxIM8MDLbgZgEx3Ugs214FNopofwQ3KBuYdoA1uN3UJGGVl3Cd4xzL5smi8VKQXMplLmcXfmC2yOW1pL8/e3xVwY/WLY49C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965818; c=relaxed/simple;
	bh=4OXN0Rl1IOzPKZW/swSOZm42BNSE5v5u4Sg55/zk5zw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=egdJFW8m6zOy1fFFuV6lnFwE6Cu6iM6R4Y8Bcr9nPvQxXWQQycFwFxdS3ZiFYoyAVgz7JXjkXk0lp3K01eJ/wJE4rYO70RoKoJY+5hOGUOLfymwa4dWUonS1w0LJVNSksHmsxQYBEfEfXXI7LOjYzUAkGJCUjwxL1rYzffpR+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d0YpvMx6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RwADSGTJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d0YpvMx6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RwADSGTJ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU7Mi599875
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 14:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Wp2blfNSiKAYO5zA3+biPV
	ntif31YKgd1gEoQ6yved4=; b=d0YpvMx6l0iCCXgDnDNtdbNlXIovDRKG02Cwjc
	AD/UMcp1AtS67+GbZ1/lBCsNMFrXTkcxfEDjPSP8Pc4HwcJnXy0zQ5eQSeEwrk//
	t1gUcPRU+Cn/wKQm+QdauHYiYGtVhiW6FGPPIxrf0hNpbIb2AXPhISMmvluJXHTb
	PZTpE5R6au9Fl4rBqzImf41rYBiu5ORPm0LONzrxIV4EpRd+8wG4+Q+N+SECOb0d
	q2lbH/38+XQSMgbiJ80XtcJRE/Wyj0NIBlSw4KS1HfScaKvE8MaUHLnp/09+/7Yg
	GV/AmrdehkqZecV2/ifE8gkwY4LQCMo1YEmR2GxWeS9GM6IA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjywr2xyy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 14:56:55 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-78fa7ff1a44so237931137.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788965815; x=1789570615; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wp2blfNSiKAYO5zA3+biPVntif31YKgd1gEoQ6yved4=;
        b=RwADSGTJe81ldCvatpHLpY2DF6BbcO/U1g9RT2smYAAbV7+EJlVV+skBG2zCwf6HOP
         4LdOCkfw9pwn6abzvAdvyUtWjQDQzG+Ozz7fBwzcgYv+lNeJ54ISPT346o/3DBVeNASL
         yqRaQveMJ0kwRTM1BT6IMyB8oiSVO4jDZWS9DCI6N9t7eFSNAz+XT3jZ/apam/3rN978
         CtIqCKIq0TdqFZrHrTUpZhYN0+pT1xXr5vTuhbtp3L6zbWSB84dYjd0x2xMxmVjusAwD
         /oc8vzhZFihtmKY/lDo3LNlR/osqjWWf0ZsXHQLJdisMv5bUgYuH1ft3q4LTL1yZLs1D
         r3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965815; x=1789570615;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wp2blfNSiKAYO5zA3+biPVntif31YKgd1gEoQ6yved4=;
        b=Ze0LAZ8Nnsp3W8Hs/O4MnaDwR0JdD24b6cw9i8GRDbwQ5gasa7dVji0m44z0zx+K1i
         bAG3HlhpXYy985d/oGwX9smI0Vtvdt9RboXDy2f+zq5FiYpsKID5JVbVQr/HFDvbt/dT
         vl16ZK8cyC8KLKpTvsmkn7GTn7JES4DvBIeRPeswJCEKY01C1bUOnutBYkR/Bnk7+ANL
         1sdCQwu/H8XRXFuhnIWA2DRSvuOynUkXAmqKDJ1NTkh6wjrIDV5ZGp47it2lWYbggEXD
         kP3Iq3MEIhQc8uh/AqGVBV+kD528qkjT8t1sylixB7LFQY5M4cDoduK3t7V6v1vFdGA7
         DHLA==
X-Forwarded-Encrypted: i=1; AKwUvBxSe0rQhK5C0tGRlmFLsb9XFlVx9GvN41MjVpezJtxrJvXVMLbFzF8pk+54pgavEITdGkch7fvabMs=@vger.kernel.org
X-Gm-Message-State: AFuF++mdB0rEcfJVjVWugucvoqsjtVyA1qGVPfuEMl0INjji1qkE/pRG
	u0ZMGdaWVs4u5Q1NWN3xpxpVeg2G0E/MnvknR0cmHDvUWUOatOe3DF8b4k+TwtoB6TkcLedxESQ
	GdZ9ttm8mpiK8Zz3kKVNRxfLKg+5N2gxfLlm1sIOb6Jt8oOPsq2hP6zal5oczc48=
X-Gm-Gg: AYBFou3H7ZRMmylTqYnGYpojQLA7NhJL6mr3c7XNHWqh59unRLk9x0QEGI6kSobfANN
	LLEhFBbRLKTsoI2yOyC4a+M5Jpo4oVgxEiJqD7vwvFqxBXzCqSzc4pO9j+LYwWVqtfwqdCT3MkZ
	NZV/+aTZnAzJTBXRZaJqRRJ5jCsSDwTaCLWlztEJaOposuJbLp6zMSHsI4lqEW9dBYmA/TTexSr
	2ucTFDt21lIEDpXG/lRiu5X3whNYlBPiQaO5PLrnfrt8dQLHLkoxOs32Q2edaI56bt50NcEgGfk
	CJ90l2KEzeK1ScH7B1Nm9hPFIWbGjtp8oXH9k0Cm7xV8HTwReTpMGbnFDUfF5+/aa2zzTQAJlH5
	+t2y2nja1y6zQVw==
X-Received: by 2002:a05:6102:5e86:b0:78a:8a0:7116 with SMTP id ada2fe7eead31-78a4a6f61c1mr13893483137.6.1788965814567;
        Wed, 09 Sep 2026 07:56:54 -0700 (PDT)
X-Received: by 2002:a05:6102:5e86:b0:78a:8a0:7116 with SMTP id ada2fe7eead31-78a4a6f61c1mr13893440137.6.1788965813982;
        Wed, 09 Sep 2026 07:56:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883959f0sm47846131f8f.10.2026.09.09.07.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:56:53 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH v5 0/5] PCI/pwrctrl: tc9563: Introduce support for embedded
 GPIO controller
Date: Wed, 09 Sep 2026 16:55:52 +0200
Message-Id: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNSwrCMBCA4atI1kaSyduV9xAXeVUDamujRZHe3
 VE3hepm4B+Yb56k5r7kStaLJ+nzUGppzxhquSDx4M/7TEvCJsBAMyM47WKh1+iUFtTf7lRrDy5
 JYRvNCB51fW7K/QNud9iHUq9t//j4A39vv5RjM2rglNGUXLD4yGbDNm2tq8vNH2N7Oq1wkLc4w
 FQRMwVQETJqUEFJiPyPIqaKnCkCFRW4lC5pCB7+KHKq2JkiUYmmicYYCw7CD2Ucxxdvjf4shQE
 AAA==
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
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=a4YAM0SF c=1 sm=1 tr=0 ts=6aa173b7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=m0QktR8YAgtX1DuhF7UA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX9iK7YSc2tjE8
 9WBJDQlSam975fal5fWUtRSYZGCHj/hgA9uq+PdIJlu8+pquTK/AglEY6t3fSftaIAPdZAYOhx5
 iSOMvHnRwyyHFmH1s3OT1SzXL2AwpGJ8mWtWmr/CXfoZ8TMNqWXzDT0xFNgaTkrjVqeUb7RpsY1
 ToQsPbtsADbwCrMgnEc1jrXUhOhRzX6sDhXAcXc3uk+rS7Z9cUyhO9sTD1RRZRCrhjrDgH9pOb8
 Rx9Niq8+nXl5Kx77r3Gnct580J9zUYZDiTbgMTDVPpnJkgMGoYc+edOH98p/880BQV776aKNVcc
 G3SYacVIS5iR/xKWsXHokVzJ1MXg3vG6+Il/ErHf0UtYVfs1VhxFnt0t/xvNdQ/l14h41pgi19g
 hV0RICxLLJ3fYXY1basIqCrXDl1ahvnVULWM0pHdDljD2dmbuqFzz5SzyKW7xHS/fP+LhRZHzZa
 9OUm+hr26xmv4rpc33g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NyBTYWx0ZWRfX3lB05IHz+UuM
 csL4KQl69iUMIP0LqZeHidc6Jsq7dDtpAPJiWkYpL2WPWx0/+5bu5ARWQClT5iOxQRMUF2SXG2w
 XAb0x9/EtgzsHZ3+sR1fOEorw+EL3Co=
X-Proofpoint-ORIG-GUID: mAHyZBs_BjKVn0lzqMoqyv0rEr6fC1Ch
X-Proofpoint-GUID: mAHyZBs_BjKVn0lzqMoqyv0rEr6fC1Ch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090167

The TC9563 embeds a GPIO controller currently used for per-port reset
signals.
Add a driver for the GPIO controller embedded in the Toshiba TC9563 PCIe
switch providing 37 GPIO lines. The controller is registered as an auxiliary
device by the TC9563 power controller driver and accessed through the same
i2c device.
Please note this series is based on pwrctrl upstream branch.

---
Changes in v5:
- Fix GPIO controller binding for Toshiba TC9563 PCIe switch.
- Link to v4: https://lore.kernel.org/r/20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com

Changes in v4:
- Do not always use 0 as aux device id.
- Link to v3: https://lore.kernel.org/r/20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com

Changes in v3:
- Describe gpio-controller support in TC9563 binding instead of defining
  a gpio child node.
- Link to v2: https://lore.kernel.org/r/20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com

Changes in v2:
- Fix PCI_PWRCTRL_TC9563 Kconfig dependency
- Move of_node refcounting management in tc9563_pwrctrl_adev_add().
- Link to v1: https://lore.kernel.org/r/20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com

---
Alex Elder (1):
      gpio: tc9563: Add support for the embedded GPIO controller

Lorenzo Bianconi (4):
      dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller
      PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
      PCI/pwrctrl: tc9563: Switch per-port reset to GPIO descriptor API
      arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563 embedded GPIO controller

 .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  14 +-
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   7 +-
 drivers/gpio/Kconfig                               |  11 ++
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-tc9563.c                         |  99 +++++++++++++
 drivers/pci/pwrctrl/Kconfig                        |   1 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 165 +++++++++++++++++++--
 include/linux/soc/qcom/tc9563.h                    |  19 +++
 8 files changed, 300 insertions(+), 17 deletions(-)
---
base-commit: 028f86457e822ab9de5b0d6d23efddc1b8b54ae1
change-id: 20260731-pci-tc9563-aux-66a29d438f60

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

