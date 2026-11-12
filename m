Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472448;
	b=dIrt+3Aj4ROlEp0BaXuphL/dtc/NLJRI3UHjcs/d3auiXLav24BodVdCa3In6Ls/wKxv
	 Ox0le13sshbfMESSZKZT3evlExqCdp4t18w/mEumznLuvfi32ajm9pMQePTYt28PUQTQs
	 b3CDVy84ftpKycSyGV2Vy3S8SS3cztw1nnMEkbkbQPz4CefbKbL0ckkRV4ES8ZnXu/ZjU
	 Gi/OATKtqHxs8lNDN/hcF2cLYiR6DCjP+TidMcoDA152SsIBVq8r8rEuYM8Kwn+065XsN
	 syC1xg00fQZi5+yj+m4l1NMYH4YAD1p0niewtI9HFlQ0zJQFIiRXQOoEFgZK55BOshg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472448;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JA2MLM/kSRhbbemzPOhXyM8O6zmbUZeLkRPWG+4Um8c=;
	b=ZaXUQ8Z+9zzMEI+e/G3G2MjztSu+7FD+hf7NF8muH9MPFmUSSTH9rnEhACePbh//s+eG
	 nNJ2euJXktzsNS3WPqDmnP2nVHpddLd3IcuVqpoApLIDg8bBLYM3c31OXsHpaNUoFJAGB
	 yfUxh1zMJlBi3NguuRTuWWx0Bq+Vs3ChpGtgx5mNSTAT+ApGxv61pGBg1Irp2o9x1idl0
	 9frnZenxeG1/Bum0XrLdu9YskVd5+hfxwBcyg4+Mb1co2iWS1znJogBECj949t2/8CXPm
	 9zbHQ3oLpCUMbDjei4uCoFL66HfNje19DhDajOwWDmEHM74IOwfo9/iCywsdqocR3Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LTXSISnD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Uh4ZYP/d";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5A60A261F
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB5A60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LTXSISnD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uh4ZYP/d
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZQ8J4092474
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JA2MLM/kSRhbbemzPOhXyM8O6zmbUZeLkRP
	WG+4Um8c=; b=LTXSISnD2o29P/Ymftsq5P9ISlcV2UZZa3dUIrogaFsG6fK8yk1
	7fI9xFKg55kb1Jop+i18dbSwbFvRZdaGqeBdTta1ArDT0BspNlwoeSQ85T2uwNwl
	Jk7Mhljz29L6/3cIrPTnb8/BUJ9Dg58lHZzYUM5FuzH126RD8+efgfV18vzSJQdc
	Ft2Vdwk75XawrOlBSeu5iEjYMx6h11EVRMGzlqLEWFlSVgwU0YBRDT1plZIauIcT
	zsP7Ps9ii4k1RHUSRMH+Z//o7jFbUCeRJmiQMdhhjM/gXQR6uyDmoMYpr4yzlIxb
	M82zRNSFQzOpWfnE0jo+o8qzKlwELmfr85w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8hyan-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd5f6002170so184242a12.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794472446; x=1795077246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JA2MLM/kSRhbbemzPOhXyM8O6zmbUZeLkRPWG+4Um8c=;
        b=Uh4ZYP/dw65r95/KGsFsQwrtbvyghA3vs56A0kWWWqcgd0lBP37JF1KgiO1Cfpbs8N
         lrVhpCVV5skaYk7J96Q/6MQBa1aCQAj8JEBJXm0WXTOWY4VFAnWIvNJf0Iq2cQ0oTwD7
         mXQqHL5egItEZKE6BGXGfjLQJ9tASKIoBVd/Xv0CKqJsVDpzJp1wHso+IvrpHJE0mfgz
         8GzohC8DHUQ0VMDxXpt92r5xrtv7MRoE/QnfFft6QnziNcFuY7Dv+TNQl7eGQFof5X+z
         mw1RewSCBn+3znOEVUZSIa/+IF9vGA8HyvDTmuFQzgDFNox+nTUDmEEEpg/hA0TUtH0B
         OkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472446; x=1795077246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JA2MLM/kSRhbbemzPOhXyM8O6zmbUZeLkRPWG+4Um8c=;
        b=DwvPzssmcXQVQu50rxGV6QWO8EtRLgbuOJzKr3nOtNE+ioiknPrX8NjiaMeqwmZydJ
         iHhXjjGDsEEJ3J88BG45etfSY/tV0zyZfGgjNWT26wnax69dfcCaUMQlyZqZzEzzxXdu
         HBXZ2dxNwsEOo3hw7O48P7nqYmP0Wyg0xdi0l6L6mmZFJDY62qVo8XOJNZ/Fj4ldKHJq
         9R5p/RvOzInn8rgjTc4qKfhAexNiw/bivpyO0bSOMJQxLi0fkTmY5gfIovHinAsi7AGI
         ceSNwuplN0TuGZUZ8dWQkO9OIABLSaosYwdCndEpixBw53VMOKiDiqMxiWA3rPDfUES+
         GKNw==
X-Forwarded-Encrypted: i=1; AL+hErFedIzKllbzUdHnIdBDX86Wcgrv0Bq7lITwTzBQ/qeTRjXe8UFhJLIoz2TuFFCQeozp9z9PMzwL6Is=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bqm4RkpvvMoFUc0WsBHdpG4EacZfaLGNBOtJmjdBsg/R/KsoI
	MApgDS0+kgy9lqrBajFJeaBMo4z61R55vu9eoWos6sgrnfeSft8oLCSDDewG/XggTSRYwq5g9TM
	2pTltVVPNl6FOmjzMb36lrcbhUXg/b78kK94fKFTKX7FI35cJUbcpsJum9Ay6O0A=
X-Gm-Gg: AYBFou2c8YggeXghWeCu4lFzBXxGc4NDws7pfB+f0IG17xAtrx+Yf0ZdYS6p5fzssy0
	16mkBKUbEH9VoPsBg8LblUk48eO02iGkWVmdT+KtCTYwVEN5+s9ATOr1xjpJ2ucxPOb/wNZAalN
	ATgr5vDfxuAkGkdep+eqawd5m2p9frD8mJJIp7pTTXWiAJ65xd+8KOHrg4PtUZtsZm8TKtqdAb4
	Q2ThtT+T92DBsqbjr63Q3Q4jg3HSVcyvTI9SNKtbB5pImI9xr0Id/ERR0hoMyrldN4Edt8nKyOK
	e+CYpgdbVCU0jMFo/sC5BtRe39WiK4rc+08CxBr9f1vVF3PgU0EcN1Nzp5+m1h6tjkDQa7RqsIi
	MwNtUr1HJn7Pc6UVsH/zsL8dgwRQp6kPuwxgA1yVXUGm6HQk5poXnTNhE6iUTtZUaMNIqsgUWrC
	iXGw==
X-Received: by 2002:a17:902:e547:b0:2ed:630:40ac with SMTP id d9443c01a7336-2edd7751683mr80863515ad.2.1794472446240;
        Thu, 12 Nov 2026 00:34:06 -0800 (PST)
X-Received: by 2002:a17:902:e547:b0:2ed:630:40ac with SMTP id d9443c01a7336-2edd7751683mr80862985ad.2.1794472445681;
        Thu, 12 Nov 2026 00:34:05 -0800 (PST)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4b950sm29351705ad.13.2026.11.12.00.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:34:05 -0800 (PST)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [PATCH v5 0/4] PCI: qcom: add Shikra PCIe and M.2 Wi-Fi/BT support
Date: Thu, 12 Nov 2026 16:33:51 +0800
Message-ID: <20261112083355.3884737-1-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX6B9tfeIOivpR
 df8VuzeALTr0uR0ebknlOUBOS14yD+WsK6BLKDJ0fy0QmA85VUOnVnbg0O9JX1tvx2zYhOs8LPN
 A62MaTr6OoyoN30moWP7FSrocx+6P04=
X-Proofpoint-GUID: ODLgetoNE4ad0WIQds9QXpZpAD3HAZmg
X-Proofpoint-ORIG-GUID: ODLgetoNE4ad0WIQds9QXpZpAD3HAZmg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX8yTd6bSMZTGE
 Uhe/IgfCDjK6SDG8bJdu9nWkfEJwCVRuIaSyCQGi2N1XXNweiYrkN4OTb4kxRNvDOc/eRZOUXT8
 r+sbP+F+tmJJPWkr61/CZYdKapBlXa3EMhobHkOlSlzB7nBtvy9TGUToRc3MFKs63KM2LrZI8dI
 CepJTt7bHL3wbBs26DA0WgXFggyeCmP6RPRg3ZJIS7PWxuud1kSJsFh/ElGbAviHXXQavr9Knjl
 s0Sf7PHtZqfjWrqKs4IdB4bZnVo22FMHU7aYw683MtlInqYa/kLA5D+LpM4X3EIA02DId0bSe9I
 n0LrcScR9/koWltqonkQfGDyLHnaHsKUKtFAmKPt8EjtwAOWiapl8p1eEBIsMrsDiSwq4ZRibJo
 QHVk874hnBnwHgmM8TKMTJtzRr6i5vFot7L2XJicsPOjer+3HhT9+QRc4+KdJPRSCnr2rG3JEqp
 Y0NQ00HDnEysFJf+z7g==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af579fe cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=f2qYStR2zr0EFXCAC4wA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120033

Add PCIe controller support for the Qualcomm Shikra platform and an
overlay for M.2 Key-E Wi-Fi and Bluetooth modules on the Shikra IQS EVK.

The previous overlay revisions depended on PCIe controller and device
tree changes that were only present in the Qualcomm downstream kernel.
Include the required PCIe binding, driver match data and controller/PHY
nodes so the overlay can be reviewed and built against linux-next.

The overlay describes the board variant where hardware rework selects
the M.2 connectivity path instead of the onboard WCN3988 path.

The series has been validated on Shikra hardware.

Changes in v5:
- Rebase the series onto linux-next next-20261111.
- Include the Shikra PCIe binding, driver and DTS prerequisites.
- Make the overlay self-contained on the upstream Shikra device tree.
- Build and validate the base DTB, DTBO and composite DTB.
- Start a new review thread instead of replying to an older revision.

Changes in v4:
- Build a composite DTB to validate that the overlay applies to the base DTB.
- Explain that the product design does not operate the onboard and M.2
  connectivity paths simultaneously.
- Report Bluetooth UART and HCI validation.

Linghui Wu (1):
  arm64: dts: qcom: shikra-iqs: add M.2 Wi-Fi and Bluetooth overlay

Sushrut Shree Trivedi (3):
  dt-bindings: PCI: qcom: document the Shikra PCIe controller
  PCI: qcom: add support for the Shikra PCIe controller
  arm64: dts: qcom: shikra: add PCIe PHY and controller nodes

 .../devicetree/bindings/arm/qcom-soc.yaml     |   1 +
 .../bindings/pci/qcom,pcie-shikra.yaml        | 192 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../dts/qcom/shikra-iqs-evk-m2-wifi-bt.dtso   | 122 +++++++++++
 arch/arm64/boot/dts/qcom/shikra.dtsi          | 158 ++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 6 files changed, 476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-shikra.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/shikra-iqs-evk-m2-wifi-bt.dtso


base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
-- 
2.43.0
