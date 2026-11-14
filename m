Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618799;
	b=2yO5BKzyWKWQKGk2LwJ/+5wRXW3OoQ7TZXF3lsuRBDmA6Z75lMjkmB+cyU8NlaggN7xK
	 p+NUtvRS0a0cnjdValMxCLE/Vf4tmX+FFV5SOdW1wq1RajnMHKVuUAhVsPUzxZN/YyVyE
	 pfONMWNDL82KufpJ5ENzBfCBvpJkr4pkfCiqE/PgVTjqY1dYwywEscC0GHJagGVK2doxY
	 0q6WQumFfYTHj21u3uFr8GyD/CMWGtUOx5pvjXigbR7YPy1pSYzOVFeQyocm5kMzJia/E
	 rSfiQO8Qh42t7OpiFswvyxPkREOWiPnnqHhGys3amJtYZbNloMKfxtqvcXneALg4CJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618799;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kTe3eKjY4XOv4bMTLL6hPdxF10qrrinmEmdieEW7Zow=;
	b=wk/VsdZCDM3B85W9AY4I6p3ZVcp6JBTyFOGIT5UXn2ju3OWB89lLwPAlk2R/WrF6w9Mc
	 JB20tjk3uP3CjxPKposnqvawQB4y1OIxWJXFh7IkG2JNHLAUFrRn7QJPDtSpvcW9NpceD
	 pMCdBq7E16Cgd4BXQsRHtK0R9bviX10k9CcbXZ26u350YPdRKPRBrJ6kEJB6O7avgwRar
	 lNPuGqAW9E2kPAiZWsEHi3nxOeVF6kn3SCPkxG562o/S/q8nfnYw4okVcCF43KvdHsHaW
	 Kdr5xXkmA1Ng0OqgAlPYW07uUog17Yvic/FuiO48h6R2Nhk3aV4RZgun0O4R4Vw98eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cXgLXeS1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C4ogScC6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614DA606A323
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 614DA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cXgLXeS1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C4ogScC6
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADMc43b2848186
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kTe3eKjY4XOv4bMTLL6hPd
	xF10qrrinmEmdieEW7Zow=; b=cXgLXeS1+LMy2W/ICjBzD2Owh7SmPZrPOiTmrZ
	B8ISCHkmxI+EHjqrlu0L4FYVm6IbQQFvc/YYD1VnteEoM9YMpiWfjmg+n5dAITOK
	RkbSXlzNtnv2u26QaX81b/om8KaCW7A9mF/rNFHpyROLiaNSNXbt2bgScETOQodx
	TsNlXI5ugGQTnXCH69BoszIMtRszMsKuxMKd0M+nXHv0bBqQksYE3bdVohjcXTYS
	hJdEIacllZMKrgLso3qgdAROKbYFlFrvOYICs39XRYfFn7VAmNR2PGySXcMeyckv
	1RBsRHjYR/2ZGJKiY3UASETai/1PTfs8qQqG9cAZg3MeybrQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx1bpayjp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-375f0fd31f4so1980219eec.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 17:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794618797; x=1795223597; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kTe3eKjY4XOv4bMTLL6hPdxF10qrrinmEmdieEW7Zow=;
        b=C4ogScC6ungvsTMT5xWhvlgkRLSO7JhU2kzSgmx2mk+Hzmygsxsclf0XFAl1QpYiQb
         RZsKSwLdEvTYngGR5cHDCLFe4UuL8L3dx2uERhcC1HzGVCTqCrUUs2ivcB0/OM2NG2Vp
         BiZYgMhs1B4zu1h0/nCEl8ukzjB3GT5IZESOEn/jQR5kYnVCwGtDA0+qkIuP0gZGZxvv
         tOvRnLkEaQnpPgIsAcRlK5lEIXgm7S728oW4IGT6XsuyhtQW6f44OhkizUeQVgfi3WTy
         YlODfGvtNT6yuB2YPGzYVxC4Ne6tOaEeeybV6RTBcezlKgUNePeDLUkk0wk0VP/uDe5y
         7BcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794618797; x=1795223597;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kTe3eKjY4XOv4bMTLL6hPdxF10qrrinmEmdieEW7Zow=;
        b=dF+z/o+qc6wnMx2L4YU14TUuS9PNMPfFI/5hJxtWeTGBNlYd9f9tWz3xgcfWPM+bkZ
         mRYmIVPRpe+pf2+rjBAmRCuLWBpTR5nZ9VbLsgbcQl2DTdEvHMP5YSVSLGeyC72OESgS
         pUfYeKAWtAW0wPjNVT/ILDMxVpLPXCnoLyP+SwnsMakWHniKtTjqpnlcCDAj0y1dhrXi
         jVcC5MkNFE/dzgAVxYI4I6xZWPlveb44JdZ/zUk/KyNhDNWzWWMO7iTTefdP3U09Y7ZQ
         rjaWgGr9txXLsKLsrIImgVH27DhULWgMvoNZpa8iwMnT48iwRFIoAImn7zE8RCkvhbiX
         Psxw==
X-Forwarded-Encrypted: i=1; AL+hErEcUn6avHFiNV/RZ+RSVjhsczCulaYXgYCizUI7SuEYWFe/4+3yuv4wJv50RWMapzA6cHv1se5dpYA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XtMi+32JvBWOabPKXZmU7qMkaOq+FtM0r8nkrBytJo4oqa2yV
	PdTVPuTxNr6yt7OOckjKqsb7c54vMhMmfM1OsePcpzLd8XYZI6j2iKCjDHQukiZvXmZ/c3beETA
	j1eEQYhptnxsc+uFBF8uyH6Xk9DUOqt8Pq8BL4hS5RnsbDkZumFd4OkCpuP0MLgs=
X-Gm-Gg: AYBFou0cKn3utudv0+Wth9LI78b8OLPyGOVluqNu2Xh7y4dnMOGC7hJFHba+o4Dn+c1
	9RDcKimVquuGC2474rv9OM6rhPa0NczEaeDnWPwiP2JZ7mdFAW6paRpEvTeSWZJwOh+bPC8Dig1
	fAzn3QUBeYeWIY5thZlGRMpvRhERijkLHEFg+7Tctf3nTH93Akmy9lHeNg6KHyjaAm278WCHo5E
	OBL64/zm9FxlMLrLBa6/fMI8CV+cieLBd6HEqLrf/qWuTgQTdQU0FNIFqIVfpyCR4PvQofH4zB0
	QfUQrKMu6BHsvlWpVTjlLQow95yD+EcjqOuB1b38S//hzoZfc+ml1z+EeUyp/iSAZlTvV9vKDAt
	xiN9gK0fBLS4EEHGOE38NgcOxYJxsZtpn5f/Gf8RhauCZlK+KBC4bnxaMP1yiqfTtLXMvme5hKq
	LupFGuXlMC
X-Received: by 2002:a05:701b:2912:b0:1b2:490b:6fdd with SMTP id a92af1059eb24-1b5030ad368mr3877926c88.24.1794618796876;
        Fri, 13 Nov 2026 17:13:16 -0800 (PST)
X-Received: by 2002:a05:701b:2912:b0:1b2:490b:6fdd with SMTP id a92af1059eb24-1b5030ad368mr3877886c88.24.1794618796106;
        Fri, 13 Nov 2026 17:13:16 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm10952813eec.3.2026.11.13.17.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 17:13:15 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v3 0/6] PCI: qcom-ep: Add PCIe Endpoint support for Monaco
Date: Sat, 14 Nov 2026 06:43:02 +0530
Message-Id: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAJ6192oC/23N3wqCMBTH8VeRXTfZjinaVe8REfubi3S26SjEd
 2+zCC+6OfCFH58zI6+cUR4dshk5FYw3to9R7DIkWtZfFTYyNgICFWlojTvbM2EvasCa071mWhI
 lBIr7wSltnqt1On/aT/ymxJiAtGiNH617rc8CTbuvC3TjBooJrgpRQg2aE8mP1vv8MbG7sF2Xx
 4MSH+AHUEKbLQARqEsQvNGlJBT+AMuyvAHFbJ3+/AAAAA==
X-Change-ID: 20260918-monaco_ep-fb14fafd0ecc
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794618790; l=3448;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=HSSXpCPII9klFGjnKVFNox+HX1Zi7tvJ1q/JdjPsr/A=;
 b=mzC5SLAz+I4A1GceeUdQy980TaqpgvTcpEzshGVr47GyxQxRt/riLjQ5q6gzXqJQIEpja6etU
 c851xf0oY1cAa10RU8VyTcPADrmUVLdDu1HgHqJFvxQ0jA0L24WQs3e
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=W9ytxhWk c=1 sm=1 tr=0 ts=6af7b5ae cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=ABVqSM4OJHPb3BREvlQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 2NxOX5xIVJ2tvDRs4Y5GMYdVq8pjKljP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfX7HA02LkEMFJk
 PVCdG0CQG6MNNuUo/2FvPH+85l0Hg9wOkKjH88jTOsHgO3jLPBkGTOspliF4YDNEVMKAAn2O0oj
 urJimDDRQ1/adVx0uZsLdo0/eQ+IXRo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfXxMYCcd8RvF+D
 S4V8fXVyGpp2T8DllMXwgjvI3TvXQSoQGImlIF/D57SsFmrVko4TI2kHdMHDS1HsvNyHzRvJrgT
 IZV1+Iq2HS0FIrvu9jl22Owp7CqoV2mOdJjcjDfhrzACIsxVlg1t+lEvFw0n2wswv+yteBc9ajj
 2FxEI9A46l9vugwdSQbkWDEpFpCrQoZ05P7wpEt76mcNJtcgeuGnMldjWNNj6/eNFRuXyBGStkO
 nHj1aAG0ScGPhQX6JcKyfIcQqArMQ5K/O3R5RgX7C6do5cA2/OKdTYO1dIaKB7qC8bp5ZkJQVzI
 DTYyUeR0erbsRnosqp+mZ5myaXUWttAZC7K41KdwHnnU62RkzCpaYjOdx4gy42eej1qETG/bpRG
 j46EqQaWjGFMtbOdKVVEX+Dhi3FkJd0UUrJ5FFLVm+wPW0t7DBf/wMb25bPCFV6WGG4qgJ/PfT+
 VLTYFWvUxXhSu9FphwQ==
X-Proofpoint-ORIG-GUID: 2NxOX5xIVJ2tvDRs4Y5GMYdVq8pjKljP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_07,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140004

This series adds PCIe Endpoint mode support for the Monaco (QCS8300)
SoC, which has two PCIe controllers capable of operating as Endpoints.

- Patch 1 documents the dedicated 16 GT/s x4 QMP PCIe PHY compatible
  for QCS8300, correcting an earlier gap where this PHY variant had no
  QCS8300-specific compatible of its own.
- Patch 2 documents the QCS8300 compatible for the PCIe Endpoint
  controller binding, with SA8775P as its fallback.
- Patch 3 adds the corresponding Endpoint PHY register configuration
  to the QMP PCIe PHY driver, reusing the existing SA8775P programming
  for the 16 GT/s x2 PHY and adding a new configuration for the 16
  GT/s x4 PHY.
- Patch 4 fixes clock-enable ordering in the qcom-ep controller driver:
  some platforms require the interconnect bandwidth vote to be set
  before enabling clocks, otherwise certain clocks can get stuck off.
- Patch 5 fixes the existing pcie1_phy node's compatible string to
  list the new QCS8300-specific compatible first, ahead of the
  SA8775P fallback, matching the order used elsewhere in this series.
- Patch 6 adds the Endpoint device tree nodes for both Monaco PCIe
  controllers, covering register regions, clocks, interrupts,
  interconnects, IOMMU mappings, resets, power domains, and PHY
  connections.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v3:
- Rebased to tip.
- Link to v2: https://patch.msgid.link/20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com

Changes in v2:
  -  dt-bindings: PCI: qcom-ep: Drop qcs8300 compatible from the standalone
    enum list(Krzysztof)
  - PCI: qcom-ep: Fix qcom_pcie_disable_resources() to tear down resources
    in strict LIFO order (phy -> clocks -> interconnect bandwidth),
    matching the enable path's error-unwind sequence. (Sashiko AI review)
  - arm64: qcom: monaco: Add reset-gpios and wake-gpios to the pcie0_ep and
    pcie1_ep nodes so the EP driver owns and correctly manages the PERST#
    and WAKE# lines; drop the output-low override from the wake-pins
    pinctrl state that was permanently asserting WAKE#. (Sashiko AI review)
  - phy: qcom: qmp-pcie: Reword commit message to clarify the new RX
    tuning sequence for the 16 GT/s x4 PHY is common to RC and EP modes,
    not EP-only.
- Link to v1: https://patch.msgid.link/20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com

---
Krishna Chaitanya Chundru (6):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add qcs8300 16 GT/s PHY
      dt-bindings: PCI: qcom-ep: Add QCS8300 compatible
      phy: qcom: qmp-pcie: Add endpoint PHY configuration for QCS8300
      PCI: qcom-ep: Set initial interconnect bandwidth before enabling clocks
      arm64: qcom: monaco: Fix pcie1_phy compatible to list qcs8300 first
      arm64: qcom: monaco: Add PCIe Endpoint nodes

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |   4 +
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   4 +
 arch/arm64/boot/dts/qcom/monaco.dtsi               | 150 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  36 ++---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 105 +++++++++++++++
 5 files changed, 280 insertions(+), 19 deletions(-)
---
base-commit: d0cf0853ff6b71724a399a87ca028fc57be9ccca
change-id: 20260918-monaco_ep-fb14fafd0ecc

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

